From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Build in some more things
Date: Tue, 30 Oct 2007 01:14:56 -0700
Message-ID: <7vzly1nhmn.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0710292049450.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 09:15:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImmFt-00071R-7R
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 09:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbXJ3IPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 04:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbXJ3IPH
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 04:15:07 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:40316 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbXJ3IPF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 04:15:05 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DB5342EF;
	Tue, 30 Oct 2007 04:15:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A4E8F8F36C;
	Tue, 30 Oct 2007 04:15:21 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've merged this to 'pu', but honestly speaking, the conflicts
are geting a bit more "interesting" than I care to keep
repeating even with help from rerere, with four people
simultaneously touching the neighbouring code in their topics.

Topics involved are:

** db/remote-builtin (Mon Oct 29 22:03:42 2007 -0400) 4 commits
 . Use built-in send-pack.
 . Build-in send-pack, with an API for other programs to call.
 . Build-in peek-remote, using transport infrastructure.
 . Miscellaneous const changes and utilities

*  jk/send-pack (Thu Oct 18 02:17:46 2007 -0400) 2 commits
 + t5516: test update of local refs on push
 + send-pack: don't update tracking refs on error

*  js/forkexec (Fri Oct 19 21:48:06 2007 +0200)
 + Use start_command() in git_connect() instead of explicit
   fork/exec.
 + Change git_connect() to return a struct child_process instead of a
   pid_t.

** sp/push-refspec (Sun Oct 28 18:46:21 2007 +0100)
 . push: teach push to pass --verbose option to transport layer
 . push: use same rules as git-rev-parse to resolve refspecs
 . add ref_abbrev_matches_full_with_rev_parse_rules() comparing
   abbrev with full ref name
 . rename ref_matches_abbrev() to
   ref_abbrev_matches_full_with_fetch_rules()

Could you please check the result after I push it out?
