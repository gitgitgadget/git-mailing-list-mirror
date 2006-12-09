X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git-commit: select which files to commit while editing the
 commit message
Date: Sat, 9 Dec 2006 02:02:45 -0500
Message-ID: <BAYC1-PASMTP1040BEA204693E211075F0AED20@CEZ.ICE>
References: <loom.20061208T131919-178@post.gmane.org>
	<7vpsaui4cn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 07:03:07 +0000 (UTC)
Cc: Pazu <pazu@pazu.com.br>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061209020245.ef3f5751.seanlkml@sympatico.ca>
In-Reply-To: <7vpsaui4cn.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 09 Dec 2006 07:07:00.0781 (UTC) FILETIME=[9F5CADD0:01C71B60]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GswEb-0004xm-76 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 08:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933840AbWLIHCs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 02:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759264AbWLIHCs
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 02:02:48 -0500
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:60794 "EHLO
 BAYC1-PASMTP10.bayc1.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S1759257AbWLIHCr (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9
 Dec 2006 02:02:47 -0500
Received: from linux1.attic.local ([65.93.43.74]) by
 BAYC1-PASMTP10.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Fri, 8 Dec 2006 23:07:00 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GsvIJ-0008PG-Dl; Sat, 09 Dec 2006 01:02:43 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, 08 Dec 2006 11:18:16 -0800
Junio C Hamano <junkio@cox.net> wrote:

> Personally, I would refuse to use such a modified git, because
> often the first thing I would do in the commit log buffer is
> check the listed files and remove the '# ...' lines while
> typing.  I do not want that to affect the set of changes I
> staged in any way.

Your usage should not affected at all by the addition of this
feature.  One of the comment lines could be magic, in that if
it is missing the feature is disabled.  Something like:

#  *** Editable Commit List ***

Or some such at the top of the list, where if it is missing after
commit message editing, the post processing of the file list
will be completely disabled.  Another alternative would be to
just enable the feature with an  -A  or some other commit command
line option, so that those uninterested in such a feature don't
have to even see it.

It would be interesting to hear from Pasky on how this feature
has worked out in practice for Cogito users and whether he thinks
it would be a good addition to Git.

