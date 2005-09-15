From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Remove shell dependency in env.c
Date: Thu, 15 Sep 2005 09:30:54 -0700
Message-ID: <4329A1BE.60600@zytor.com>
References: <43290BB8.90501@zytor.com> <7vy85yahjk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 18:34:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFwdm-00041S-Io
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 18:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbVIOQbM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 12:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbVIOQbM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 12:31:12 -0400
Received: from terminus.zytor.com ([209.128.68.124]:46776 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030515AbVIOQbK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 12:31:10 -0400
Received: from [172.27.3.248] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8FGUsRs008804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Sep 2005 09:30:56 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy85yahjk.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8614>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>This patch adds an invocation of "env", so rsh.c works for C-shell users 
>>as well as Bourne shell users.
> 
> 
> Hmph.  I think the original code is buggy already.  If the path
> has a single quote in it, you would get into a problem.  If the
> remote end first interprets what is given to it with C-shell,
> then it probably would also barf if path had a '!' in it, too,
> even though we quote the entire thing within a single-quote
> pair.

True.  The better method is to \-escape any questionable characters, 
instead of trying to use quotes.  I'll try to write that up.

	-hpa
