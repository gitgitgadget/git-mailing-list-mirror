From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-commit: reword the --amend explanation
Date: Wed, 03 Apr 2013 13:04:13 -0700
Message-ID: <7vtxnn4c02.fsf@alter.siamese.dyndns.org>
References: <1364994441-15961-1-git-send-email-cmn@elego.de>
 <7v4nfn7j5i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Apr 03 22:04:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNTvV-0002aQ-VK
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 22:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252Ab3DCUE3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Apr 2013 16:04:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760728Ab3DCUE2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Apr 2013 16:04:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43EBB128D4;
	Wed,  3 Apr 2013 20:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9sEzIoY+qbMe
	Gmm1XP7iAHcISFE=; b=TA8X1PhrHKFmOMwOQpTTpa1Tg02gcvhxbPc881/eOrxZ
	V9PwkcBzHlxfLmslbf+z7vonHhPS+Ur+AFqMETakSJdCkZ2uQ8+1527OXUcPY9Ta
	v6wCrVWtoQk/f7vK6+lhriUUelrG7GqlCUnBI0i3cFYZVA6U1JHs6rOvAlJufXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yNNRv9
	V21uzRDI1XX+rO9GoGpePHYV5rUsFJrrS3QvVtRVv9AEt4jEpf3Unjtxo8yjKah7
	NyCEv2ni03MumhwEQZ04Ta+qVFiE2j//wysD3nnePsW4PWtHxxaizmpKgaTR+3M3
	XLUARnQI0Ps8dQCT+0eQru2U8BqNZ851QLvnw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BF4C128D3;
	Wed,  3 Apr 2013 20:04:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3B5A128CE; Wed,  3 Apr
 2013 20:04:14 +0000 (UTC)
In-Reply-To: <7v4nfn7j5i.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 03 Apr 2013 08:01:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8B2AE86-9C99-11E2-8E29-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219967>

Junio C Hamano <gitster@pobox.com> writes:

> Yes, and since then we gained --no-edit option and such, so "editor
> starts off" also needs to be rethought, no?  The original wording
> with "seeded" may have a better chance of survival, I suspect, but
> still needs some adjustment.

So here is my attempt.  We still need a sign-off from you even if we
decide to use this version.  Relative to your original patch:

 * Using "amend" to explain what "--amend" does felt a bit
   tautological; I moved the "replaces it" to the opening.

 * We do not necessarily launch the editor, and if you give the
   message in some other way we do not even reuse the original log
   message.

 * Mention --reset-author at the same time mentioning that by
   default the authorship is carried forward.

 * "The commit is prepared as usual" was meant to describe how the
   content to be recorded (i.e. the tree object contained in the
   resulting commit) is shaped, but I felt it a bit too unclear
   without saying either content or tree (it could be some other
   aspects of the commit like the log message and authorship, etc.)
   I tentatively replaced it with "The recorded tree is prepared",
   but there may be a better phrasing.

-- >8 --
=46rom: Carlos Mart=C3=ADn Nieto <cmn@elego.de>

The explanation for 'git commit --amend' talks about preparing a tree
object, which shouldn't be how user-facing documentation talks about
commit.

Reword it to say it works as usual, but replaces the current commit.

---
 Documentation/git-commit.txt | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 19cbb90..bc919ac 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -190,14 +190,15 @@ OPTIONS
 	without changing its commit message.
=20
 --amend::
-	Used to amend the tip of the current branch. Prepare the tree
-	object you would want to replace the latest commit as usual
-	(this includes the usual -i/-o and explicit paths), and the
-	commit log editor is seeded with the commit message from the
-	tip of the current branch. The commit you create replaces the
-	current tip -- if it was a merge, it will have the parents of
-	the current tip as parents -- so the current top commit is
-	discarded.
+	Create a new commit and replace the tip of the current
+	branch. The recorded tree is prepared as usual (including
+	the effect of the `-i` and `-o` options and explicit
+	pathspec), and the message from the original commit is used
+	as the starting point, instead of an empty message, when no
+	other message is specified from the command line via options
+	such as `-m`, `-F`, `-c`, etc.  The new commit has the same
+	parents and author as the current one (the `--reset-author`
+	option can countermand this).
 +
 --
 It is a rough equivalent for:
