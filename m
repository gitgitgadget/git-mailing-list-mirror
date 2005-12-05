From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Add compat/setenv.c, use in git.c.
Date: Mon, 05 Dec 2005 10:39:51 -0800
Message-ID: <43948977.7060405@zytor.com>
References: <14404.1133806037@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 19:43:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjLGS-0008K7-DH
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 19:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbVLESkh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 13:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVLESkh
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 13:40:37 -0500
Received: from terminus.zytor.com ([192.83.249.54]:56988 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751354AbVLESkg
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 13:40:36 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB5IduVv001572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Dec 2005 10:39:56 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <14404.1133806037@lotus.CS.Berkeley.EDU>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13221>

Jason Riedy wrote:
> And Junio C Hamano writes:
>  - putenv(3) says
>  - 	The string pointed to by string becomes part of the environment,
>  - 	so altering the string changes the environment.
> 
> Good catch, thanks.  The Solaris man page first says the 
> string space is "no longer used", but at the very end warns 
> against using an automatic variable.  Chalk one up for lousy 
> docs.
> 
> (And sizeof(char) is just habit; 99% of my mallocs aren't of 
> char...  Sorry.)
> 

Personally I consider it a serious bug in the C language that 
sizeof(char) == 1 by definition.  It basically prohibits a whole lot of 
useful machine models.

	-hpa
