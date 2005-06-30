From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 14:23:25 -0700
Message-ID: <42C462CD.9010909@zytor.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com> <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 23:22:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do6UD-000399-VH
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 23:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbVF3V2Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 17:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbVF3VYv
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 17:24:51 -0400
Received: from terminus.zytor.com ([209.128.68.124]:63407 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263089AbVF3VYS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 17:24:18 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j5ULNUko019727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 30 Jun 2005 14:23:31 -0700
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
>>For the purposes of rsync, storing the objects in a single append-only 
>>file would be a very efficient method, since the rsync algorithm will 
>>quickly discover an invariant head and only transmit the tail.
> 
> Actually, it won't be "quick" - it will have to read the whole file and do 
> it's hash window thing.
> 

It does that, but it only have to do that when the actual file has 
changed.  That's acceptable, at least for the repository sizes we're 
likely to deal with within the medium term.

	-hpa
