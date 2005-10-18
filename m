From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git-daemon extra paranoia
Date: Tue, 18 Oct 2005 15:08:20 -0700
Message-ID: <43557254.3010807@zytor.com>
References: <435560F7.4080006@zytor.com> <7vll0qploy.fsf@assigned-by-dhcp.cox.net> <4355691D.2010200@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 00:09:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERzdQ-0003kM-8H
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 00:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVJRWIh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 18:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVJRWIh
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 18:08:37 -0400
Received: from terminus.zytor.com ([192.83.249.54]:65516 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932168AbVJRWIg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 18:08:36 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9IM8QV4009007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Oct 2005 15:08:26 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4355691D.2010200@zytor.com>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10236>

H. Peter Anvin wrote:
> 
> For security, avoiding aliases is highly desirable, and if they're 
> useless the easiest way to do that is to reject.  If aliases are 
> required, which it sounds like it might be, then canonicalization needs 
> to be applied.
> 
> This may sound redundant, but a lot of avoiding security holes involves 
> applying good practices up front, instead of reactively.
> 

I thought I might want to add a bit of an explanation, just for the 
purpose of illustration.

Right now, we use a whitelist for access control.  Aliases are not a 
problem, because they fail shut.

A year from now, someone decides that they want a "all but" feature, and 
thus adds a blacklist on top of the whitelist.  If aliases are 
permitted, unless the blacklist logic is written very carefully, one 
would then be able to get around the blacklist by using one of the 
aliased paths.

Improper handling of aliases is probably second only to buffer overflows 
and large-string DoS attacks when it comes to security vulnerabilities.

	-hpa
