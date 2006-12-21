X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 20 Dec 2006 19:56:57 -0500
Message-ID: <923634DE-0F3E-4A96-BC37-CB7E25C7251B@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 21 Dec 2006 01:04:39 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34994>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxCMJ-0005ja-9A for gcvg-git@gmane.org; Thu, 21 Dec
 2006 02:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161100AbWLUBE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 20:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWLUBE2
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 20:04:28 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:55522 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1161100AbWLUBE1 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 20:04:27 -0500
Received: from [192.168.1.6] (cpe-66-67-221-135.rochester.res.rr.com
 [66.67.221.135]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by silverinsanity.com (Postfix) with ESMTP id
 06E521FFC02B for <git@vger.kernel.org>; Thu, 21 Dec 2006 01:04:26 +0000 (UTC)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

(I originally forgot to send this to the list.  Oops.  Difference  
between "Reply" and "Reply All" is small, but important.)

On Dec 20, 2006, at 7:44 PM, Junio C Hamano wrote:

> Does everybody use Apple CC on OSX?  Is the symbol defined even
> with GCC?  Or Gcc fixes headers well enough and makes this a
> non-issue?

Apple CC == gcc, as far as I can tell.  And the definition of  
_POSIX_C_SOURCE, which seems to disable too much stuff, is in /usr/ 
include/sys/cdefs.h:

/* Deal with various X/Open Portability Guides and Single UNIX Spec. */
#ifdef _XOPEN_SOURCE
#if _XOPEN_SOURCE - 0L >= 600L
#undef _POSIX_C_SOURCE
#define _POSIX_C_SOURCE     200112L
#elif _XOPEN_SOURCE - 0L >= 500L
#undef _POSIX_C_SOURCE
#define _POSIX_C_SOURCE     199506L
#endif
#endif

Why _POSIX_C_SOURCE disables strncasecmp, I don't know.  It makes me  
sad.

Yours,
