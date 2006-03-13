From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Sun, 12 Mar 2006 22:41:35 -0800
Message-ID: <4415141F.2080604@zytor.com>
References: <20060311192954.GQ16135@artsapartment.org> <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.64.0603120847500.3618@g5.osdl.org> <slrne18of5.fr9.mdw@metalzone.distorted.org.uk> <4414747B.7040700@gmail.com> <20060313033805.GB14601@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 07:41:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIgkR-0006lr-Hf
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 07:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWCMGlk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 01:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWCMGlk
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 01:41:40 -0500
Received: from terminus.zytor.com ([192.83.249.54]:48080 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751536AbWCMGlj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 01:41:39 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k2D6fZu0025363
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Mar 2006 22:41:36 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jeff King <peff@peff.net>
In-Reply-To: <20060313033805.GB14601@coredump.intra.peff.net>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17554>

Jeff King wrote:
> 
> I think Linus has cut to the heart of the discussion (that it's worth
> git maintainers' sanity not to worry about such problems). However, for
> pedantry's sake, this is how malloc works:
> 
> A void pointer is guaranteed to be able to hold any type of pointer
> (either char * or struct foo * or whatever). The declaration of malloc
> indicates a return of void *. On a platform where it matters, the
> compiler generates code so that 
>   struct foo *bar = malloc(100);
> converts the void * pointer into the correct size (in the same way that
> assigning between differently sized integers works).
> 

Furthermore, the return value of malloc() (calloc, realloc, ...) is 
guaranteed to be a value suitable for casting to any pointer type for 
which at least one object can fit in the allocated memory block.

	-hpa
