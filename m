X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Mon, 30 Oct 2006 16:34:35 -0800
Message-ID: <7vzmbds4pw.fsf@assigned-by-dhcp.cox.net>
References: <200610301953.01875.jnareb@gmail.com>
	<200610301959.05313.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 00:34:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610301959.05313.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 30 Oct 2006 19:59:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30556>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GehaT-00083S-26 for gcvg-git@gmane.org; Tue, 31 Oct
 2006 01:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161487AbWJaAei (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 19:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161490AbWJaAei
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 19:34:38 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:3525 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1161487AbWJaAeh
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 19:34:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061031003436.WTNN18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 19:34:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id goaG1V00r1kojtg0000000 Mon, 30 Oct 2006
 19:34:17 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Use "&iquot;" Latin 1 entity ("&#191;" -- inverted question mark =
> turned question mark, U+00BF ISOnum) instead '?' as replacements for
> control characters and other undisplayable characters.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Do you have something against our Spanish and Latin American
friends?  ;-)

I wonder if there is a more suitable replacement character that
is accepted across scripts?

Japanese printing industry has a long tradition of using U+3013
("geta") as a filler character.  Originally they placed a type
of otherwise unused character upside down while packing types
into a row, and the reverse side of a type, when inked and
printed, left imprint that looked like footprint somebody who
wore a "geta" (a traditional footware) would leave.

	http://ja.wikipedia.org/wiki/%E4%B8%8B%E9%A7%84

shows how a "geta" looks like, and

	http://unicode.org/charts/PDF/U3000.pdf

shows how the filler character looks like.

Note that I am not suggesting to use &#3013; as a replacement at
all.  I however think inverted question is inappropriate, and we
should pick something else if we are fixing the question mark
which is obviously inappropriate.

