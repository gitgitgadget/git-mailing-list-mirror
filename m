X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Improve git-prune -n output
Date: Sat, 28 Oct 2006 13:37:56 -0700
Message-ID: <7vejss6usb.fsf@assigned-by-dhcp.cox.net>
References: <7vlkn3kn65.fsf@assigned-by-dhcp.cox.net>
	<200610270937.11368.andyparkins@gmail.com>
	<ehvnob$tmj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 20:38:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30396>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GduwN-0005TX-2t for gcvg-git@gmane.org; Sat, 28 Oct
 2006 22:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751404AbWJ1Uh6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 16:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWJ1Uh6
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 16:37:58 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:7314 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1751404AbWJ1Uh6
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 16:37:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028203757.MUPE22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Sat, 28
 Oct 2006 16:37:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fwe11V00A1kojtg0000000 Sat, 28 Oct 2006
 16:38:01 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Andy Parkins wrote:
>
>> prune_object() in show_only mode would previously just show the path to the
>> object that would be deleted.  The path the object is stored in shouldn't be
>> shown to users, they only know about sha1 identifiers so show that instead.
>
> This allowed to 'rm -f' [some] of what git-prune -n shows.
>
> Did anybody used that? I don't know...

Yes and probably no because the output did not have enough clues
to help picking which ones to remove.  If the command said
something like this:

	.git/objetcts/11/feed0... ;# commit 2006-08-28: WIP for	"foo"

it might have been a good clue and would have made sense, though.
