From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git.git object database at kernel.org?
Date: Mon, 25 Apr 2005 11:46:25 -0700
Message-ID: <426D3B01.8060408@zytor.com>
References: <7vhdhvstb2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504241553580.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:43:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ8Wj-00022q-9h
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 20:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVDYSqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 14:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVDYSqx
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 14:46:53 -0400
Received: from terminus.zytor.com ([209.128.68.124]:28364 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262725AbVDYSqv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 14:46:51 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3PIkWa8012385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Apr 2005 11:46:32 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504241553580.18901@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
>    NOTE! The fact that "mktime()" seems to depend on the timezone in which 
>    it is made seems to make this questionable. I had always assumed that 
>    mktime would take the timezone from the "struct tm", and thus be 
>    reliable, but somebody seems to have shown that that is not the case at 
>    all!
> 

No, mktime() always uses the local time zone.  It's the inverse of 
localtime().  If you know the timezone offset (e.g. if you have a RFC 
2822-style date) then you're probably better off rolling your own; 
otherwise setenv("TZ"); tzset(); mktime(); is of course also doable.

	-hpa
