From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Change git-cvsimport to handle slashes in CVS tags
Date: Fri, 28 Oct 2005 13:47:38 -0700
Message-ID: <43628E6A.7000104@zytor.com>
References: <59a6e5830510281146s7b25da76l8bf97287522b89f2@mail.gmail.com> <Pine.LNX.4.64.0510281151450.4664@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wayne Scott <wsc9tt@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 28 22:50:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVb97-0001zv-K5
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 22:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbVJ1UsP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 16:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbVJ1UsO
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 16:48:14 -0400
Received: from terminus.zytor.com ([192.83.249.54]:22221 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751698AbVJ1UsO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2005 16:48:14 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9SKlgLe001454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 28 Oct 2005 13:47:43 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510281151450.4664@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10775>

Linus Torvalds wrote:
> 
> Is "_" the right thing to replace it with, though? To me, "_" replaces 
> either a space or a dash, while a slash could be replaced by something 
> more like a special character.
> 

If nothing else it creates a nice symmetry, since CVS can't use '.' in 
tags (which only is the most common character in nearly all versioning 
schemes), and which is commonly replaced by '_'.  We already have the -m 
option to change that back to dots, so we'd go:

'/' -> '_' -> '.'

... which at least means no info loss.

	-hpa
