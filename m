X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] index-pack usage of mmap() is unacceptably slower on  many OSes other than Linux
Date: 19 Dec 2006 11:57:44 -0800
Message-ID: <86hcvr4q13.fsf@blue.stonehenge.com>
References: <86y7p57y05.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
	<86r6uw9azn.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181625140.18171@xanadu.home>
	<86hcvs984c.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
	<8664c896xv.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612181906450.18171@xanadu.home>
	<20061219051108.GA29405@thunk.org>
	<Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
	<Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612191027270.18171@xanadu.home>
	<7vk60npv7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612191409500.18171@xanadu.home>
	<Pine.LNX.4.64.0612191148270.3483@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 19:57:56 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.16.6; tzolkin = 7 Cimi; haab = 19 Mac
In-Reply-To: <Pine.LNX.4.64.0612191148270.3483@woody.osdl.org>
Original-Lines: 15
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34846>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwl5x-0001SM-4A for gcvg-git@gmane.org; Tue, 19 Dec
 2006 20:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932912AbWLST5q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 14:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932917AbWLST5q
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 14:57:46 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:20562 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932920AbWLST5p (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 14:57:45 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 4F29C8FD7F; Tue, 19 Dec 2006 11:57:45 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 26667-01-58; Tue, 19 Dec 2006 11:57:44 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id CD90B8FD90;
 Tue, 19 Dec 2006 11:57:44 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> May I actually suggest we handle _all_ of these issues in one central 
Linus> place, namely "git-compat-util.h"

I can't remember now, but a couple of patches I had to submit were because
sys/types.h was included either too early or too late on OSX, so let's be sure
to get that right.  Surely, my patch can be observed somewhere, perhaps in a
git repository. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
