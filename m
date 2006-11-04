X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with git-apply?
Date: Sat, 04 Nov 2006 10:33:06 -0800
Message-ID: <7vzmb7vz8d.fsf@assigned-by-dhcp.cox.net>
References: <20061104072349.GA19667@cubit>
	<7v8xir4k3w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611040821290.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 18:33:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611040821290.25218@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 4 Nov 2006 08:27:19 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30932>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgQKQ-00028j-4h for gcvg-git@gmane.org; Sat, 04 Nov
 2006 19:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965588AbWKDSdK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 13:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965591AbWKDSdK
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 13:33:10 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:37797 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S965588AbWKDSdJ
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 13:33:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061104183307.UJKG18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Sat, 4
 Nov 2006 13:33:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id iiYl1V00M1kojtg0000000 Sat, 04 Nov 2006
 13:32:46 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 4 Nov 2006, Junio C Hamano wrote:
>> 
>> The problem appears that GNU diff _never_ uses "--- /dev/null" or "+++ 
>> /dev/null" to indicate creation or deletion of the file, but the 
>> "traditional patch parser" builtin-apply has assumed that is what the 
>> traditional diff output from day one.  Where we got that idea is mystery 
>> to me (this is Linus's code), but I suspect it is what other SCMs did.
>
> No, the original code used to trigger a "create" diff on
>  - source was /dev/null
> OR
>  - source had zero patches.
>
> It used to have code like
>...
> and I think the person who broke it was you ;)

Sorry, if you followed the threads by now you know I know that.
A few messages down there is a fix for the breakage caused by
4be60962, which I'll have in 'maint'.

I think it is a time for a 1.4.3.4; these are queued since
we did 1.4.3.3.

Andy Parkins (2):
  Minor grammar fixes for git-diff-index.txt
  git-clone documentation didn't mention --origin as equivalent of -o

Christian Couder (3):
  Remove --syslog in git-daemon inetd documentation examples.
  Documentation: add upload-archive service to git-daemon.
  Documentation: add git in /etc/services.

Edgar Toernig (1):
  Use memmove instead of memcpy for overlapping areas

J. Bruce Fields (1):
  Documentation: updates to "Everyday GIT"

Jakub Narebski (3):
  diff-format.txt: Combined diff format documentation supplement
  diff-format.txt: Correct information about pathnames quoting in patch format
  gitweb: Check git base URLs before generating URL from it

Jan Harkes (1):
  Continue traversal when rev-list --unpacked finds a packed commit.

Johannes Schindelin (1):
  link_temp_to_file: call adjust_shared_perm() only when we created the directory

Junio C Hamano (9):
  Documentation: clarify refname disambiguation rules.
  combine-diff: a few more finishing touches.
  combine-diff: fix hunk_comment_line logic.
  combine-diff: honour --no-commit-id
  Surround "#define DEBUG 0" with "#ifndef DEBUG..#endif"
  quote.c: ensure the same quoting across platforms.
  revision traversal: --unpacked does not limit commit list anymore.
  link_temp_to_file: don't leave the path truncated on adjust_shared_perm failure
  apply: handle "traditional" creation/deletion diff correctly.

Nicolas Pitre (1):
  pack-objects doesn't create random pack names

Rene Scharfe (1):
  git-cherry: document limit and add diagram

