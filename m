X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: doc bug?
Date: Sat, 09 Dec 2006 10:42:32 -0800
Message-ID: <7vslfodi7b.fsf@assigned-by-dhcp.cox.net>
References: <elc64k$t4i$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 18:42:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <elc64k$t4i$1@sea.gmane.org> (Han-Wen Nienhuys's message of "Fri,
	08 Dec 2006 18:07:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33828>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt79q-0005oT-3M for gcvg-git@gmane.org; Sat, 09 Dec
 2006 19:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759184AbWLISmf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 13:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761219AbWLISmf
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 13:42:35 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46494 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759184AbWLISme (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 13:42:34 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061209184233.QGNS18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Sat, 9
 Dec 2006 13:42:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id wiik1V00B1kojtg0000000; Sat, 09 Dec 2006
 13:42:44 -0500
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> while messing with GIT's build system, I got
>
> **
> asciidoc -b docbook -d manpage -f ../Documentation/asciidoc.conf ../Documentation/git-tools.txt
> ERROR: git-tools.txt: line 2: malformed manpage title
> ERROR: git-tools.txt: line 6: first section must be named NAME
> ERROR: git-tools.txt: line 9: malformed NAME section body
> FAILED: /home/lilydev/vc/git/Documentation/git-tools.txt: line 9: unexpected error:

That is interesting.  git-tools is listed on ARTICLES which is
excluded from MAN1_TXT so the Makefile should not even try to
run the above commandline that says 'manpage'.

At least that is what our Makefile intends to do.

So that means you may have found a bug in our Makefile, or your
make (by the way I think we pretty much requires GNU make to
build git), or perhaps both.

But I do not see an obvious breakage in our Makefile in this
area...


