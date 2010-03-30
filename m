From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Tue, 30 Mar 2010 15:13:25 -0700
Message-ID: <7vd3ylv4oq.fsf@alter.siamese.dyndns.org>
References: <4B67227A.7030908@web.de> <4B898F97.90706@web.de>
 <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de>
 <4b8bf32f.0706c00a.26cb.691d@mx.google.com> <4BA104C7.5020207@web.de>
 <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com>
 <7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA1FC39.10300@web.de>
 <32541b131003180936x746dad06k386788d3cb6fcdeb@mail.gmail.com>
 <b4087cc51003181019r4408953bxcd5049c9521b8173@mail.gmail.com>
 <4BA3329E.6050304@web.de> <4BB21F6D.7070804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 31 00:13:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwjgw-00089P-WF
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 00:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167Ab0C3WNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 18:13:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42689 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093Ab0C3WNi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 18:13:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A80DA614C;
	Tue, 30 Mar 2010 18:13:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7l8ce+yuWCJ/3ArPozyCZyovPug=; b=Gqf65j
	0huXWUOxis/xvcfBDKVsBkfJMiN2oqKXe1pS50nMZoWjVT/Dfh+5uNv0uHShD+tc
	O0fRi5UuTxKEIT2e2BYAi5hI7D+kVhcI6JZ9faKN29wZANWlFI+GEKbi2SC5LiB8
	L7bra7CGJdpem6BwSpXFOXU6Uz3qP1dt33BJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bh320AsN7iFO8AYa4E6YknFrwBWSekbs
	9229QzprdCKdX4HCQFv91aiL+ObpOON2e0VrmWlFIzulruiZMuGfmEHF7YdsnhPT
	5vKULrHjhicoiSob681pCAMJlubIpN7ypBICcMOvjNRM8wgudRJ5NCy9g6u8MO30
	FERJzHeqdCs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16AB9A6147;
	Tue, 30 Mar 2010 18:13:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BBD1A6140; Tue, 30 Mar
 2010 18:13:27 -0400 (EDT)
In-Reply-To: <4BB21F6D.7070804@web.de> (Markus Elfring's message of "Tue\, 30
 Mar 2010 17\:57\:33 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 79F21874-3C49-11DF-BC68-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143609>

Markus Elfring <Markus.Elfring@web.de> writes:

>> I find that the discussion is not finished yet. It was not achieved a common
>> conclusion and consensus on all mentioned details so far.
>
> Can we achieve progress for an update of the manual?
>
> Regards,
> Markus

Something like this?

 Documentation/git-checkout.txt |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 37c1810..d443a12 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -16,9 +16,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-When <paths> are not given, this command switches branches by
-updating the index, working tree, and HEAD to reflect the specified
-branch.
+When <paths> are not given, this command makes the named branch the
+current branch, so that a further work will be committed on that branch.
+See "Switching Branches" below.
 
 If `-b` is given, a new branch is created and checked out, as if
 linkgit:git-branch[1] were called; in this case you can
@@ -149,6 +149,27 @@ checks out the branch (instead of detaching).  You may also specify
 	the index will be used.
 
 
+Switching Branches
+------------------
+
+While switching to another branch (or more in general, to another commit
+that is not the current commit), the index and the working tree are
+updated to the contents of the new branch, while carrying the uncommitted
+changes you made so far along with you.  People often start making changes
+and then realize that the changes belong to a branch that is different
+from the current one, and it helps these people to carry the changes
+forward upon switching branches.
+
+If the branch you are switching to has one version of a file, and the
+current branch has a different version of it, which you changed in your
+working tree to yet another version, carrying the changes forward is not
+possible without merging.  But you may not be ready to resolve such
+conflicts right now.  By default, the command refuses to switch branches
+to prevent you from losing your local changes due to such conflicts.  In
+such a case, you may want retry the command after recording the local
+changes (1) in a temporary commit on the current branch, or (2) by using
+"git stash".  Alternatively, use "-m" option to force a merge.
+
 
 Detached HEAD
 -------------
