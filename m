X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: fc046a75d539a78e6b2c16534c4078617a69a327 fails on OpenBSD 3.8
Date: Fri, 30 Jun 2006 10:06:44 -0700
Message-ID: <7vy7veindn.fsf@assigned-by-dhcp.cox.net>
References: <86wtayy42o.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 30 Jun 2006 17:07:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86wtayy42o.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "30 Jun 2006 09:57:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1FwMSA-0000LI-09 for gcvg-git@gmane.org; Fri, 30 Jun
 2006 19:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751813AbWF3RGr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 30 Jun 2006
 13:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWF3RGr
 (ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 13:06:47 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:19917 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1751813AbWF3RGq
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 13:06:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127]) by
 fed1rmmtao05.cox.net (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with
 ESMTP id
 <20060630170645.UPUT12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
 Fri, 30 Jun 2006 13:06:45 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> gcc -o upload-pack.o -c -g -O2 -Wall -I/usr/local/include -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRCASESTR upload-pack.c
> In file included from /usr/include/sys/poll.h:54,
>                  from upload-pack.c:9:
> /usr/include/ctype.h:67: error: syntax error before ']' token
> /usr/include/ctype.h:68: error: syntax error before ']' token
> /usr/include/ctype.h:70: error: syntax error before ']' token
> /usr/include/ctype.h:75: error: syntax error before ']' token
> /usr/include/ctype.h:78: error: syntax error before '(' token
> /usr/include/ctype.h:79: error: syntax error before '(' token
> /usr/include/ctype.h:93: error: syntax error before "c"
> In file included from /usr/include/sys/poll.h:54,
>                  from upload-pack.c:9:
> /usr/include/ctype.h:91:1: unterminated #if
> /usr/include/ctype.h:40:1: unterminated #ifndef

Crap.  Including <sys/poll.h> pollutes your namespace with ctype
macros?
