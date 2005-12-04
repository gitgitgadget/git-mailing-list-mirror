From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Add compat/setenv.c, use in git.c.
Date: Sun, 04 Dec 2005 15:34:25 -0800
Message-ID: <43937D01.8090706@zytor.com>
References: <28409.1133564908@lotus.CS.Berkeley.EDU>	<43935A9E.2060602@zytor.com> <7vr78sebp8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 00:36:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ej3NT-0005w4-VI
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 00:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVLDXel (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 18:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVLDXel
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 18:34:41 -0500
Received: from terminus.zytor.com ([192.83.249.54]:45756 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932239AbVLDXek
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Dec 2005 18:34:40 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB4NYPAB009772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Dec 2005 15:34:27 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr78sebp8.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13199>

Junio C Hamano wrote:
> 
> Oops.  Isn't the patch itself wrong, so is using alloca()?
> 
> putenv(3) says
> 
> 	int putenv(char *string);
> 
> 	The string pointed to by string becomes part of the environment,
> 	so altering the string changes the environment.
> 
> which tell sme that whatever we pass to putenv() we should *not*
> free.

Indeed.

	-hpa
