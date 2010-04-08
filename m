From: Junio C Hamano <gitster@pobox.com>
Subject: Re*: [PATCH v9] Documentation/remote-helpers: Add invocation section
Date: Thu, 08 Apr 2010 13:01:25 -0700
Message-ID: <7vfx3567e2.fsf_-_@alter.siamese.dyndns.org>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com>
 <7vsk77e20r.fsf@alter.siamese.dyndns.org>
 <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com>
 <20100407224942.GA20239@progeny.tock>
 <7vzl1eamss.fsf@alter.siamese.dyndns.org>
 <h2ifabb9a1e1004081152hbca48fbex11134249aef9df14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 22:02:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzxvS-0005Sq-RP
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 22:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933352Ab0DHUBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 16:01:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933161Ab0DHUBu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 16:01:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 19D05A8470;
	Thu,  8 Apr 2010 16:01:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KcAL5L+pr/OPdvn23H5uR7oQl8c=; b=DITA0n
	ox5viIR+iW+7KCKqNfq2Y6rIwp8bzhUCrVH0Cvwh2W2OHrVFXLC+9987bmrX8K5S
	uZlQkfRNyy3JH503IhW4xKbeBNqymhbiDOHO3yw0kUrstgDuagW3C5YCsodTGk0m
	gKEuWz8XrJu3iieEMrUS2xrcWI7cbwZmyax48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rqWRLFDkgDTK8F7ljZ+uJYCZKunbaDeK
	SKx1irfmDN9m7VbYgrF7MLn+YjkXDJrwHcAxwoN3gwC/ZOF2eRfWQ5srMRYeKEA6
	uoRPRYL5xB1dQkh8iDxQhss875k15x76Clw1yaUbp1IrBHciB2dFZAgRfnlXaKi0
	AwuzsvJFw9A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA45FA846B;
	Thu,  8 Apr 2010 16:01:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 782E2A8463; Thu,  8 Apr
 2010 16:01:27 -0400 (EDT)
In-Reply-To: <h2ifabb9a1e1004081152hbca48fbex11134249aef9df14@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu\, 8 Apr 2010 20\:52\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A48403E-4349-11DF-983E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144378>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Hmmm, perhaps we should update SubmittingPatches to say something
> about that? The section that talks about what to base your patch
> against is not very explicit in that aspect.

Ok, here is a rough draft.

 Documentation/SubmittingPatches |   52 ++++++++++++++++++++++++++++++--------
 1 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c686f86..1d403ee 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -53,6 +53,37 @@ But the patch submission requirements are a lot more relaxed
 here on the technical/contents front, because the core GIT is
 thousand times smaller ;-).  So here is only the relevant bits.
 
+(0) Decide what to base your work on.
+
+The general principle is always to base your work on the oldest branch
+that your change is relevant to.
+
+ - A fix for a bug that has been with git from older releases should be
+   included in both the upcoming feature release and the current
+   maintenance release.  Try to base your work on the 'maint' branch.  A
+   work to kill a bug that is in 'master' but not in 'maint' should be
+   based on 'master'.
+
+ - A fix for a bug that is not yet in 'master' is the best bug to kill.
+   If you can find the topic that introduces the regression, base your
+   work on the tip of the topic.  "log --first-parent master..pu" would be
+   a good way to find the tips of topic branches.
+
+ - A new feature should be based on the 'master' branch in general.
+
+ - If your new feature depends on some other topics that are not in
+   'master' yet, and if it relies only on one topic, base your work on the
+   tip of that topic.  If it depends on too many topics that are not in
+   'master', you can privately start working on 'next' or even 'pu' and
+   send out your patches for discussion, but it is possible that your
+   maintainer may ask you to wait and rebase your changes on 'master'
+   after some of the larger topics your topic depends on graduate to
+   'master'.
+
+ - Base corrections and enhancements on a topic that are not in 'master'
+   yet but already merged to 'next' on the tip of the topic.  If the topic
+   has not been merged to 'next', it is Ok to add a note that the patch is
+   a trivial fix and can be squashed into the series.
 
 (1) Make separate commits for logically separate changes.
 
@@ -170,17 +201,16 @@ patch, format it as "multipart/signed", not a text/plain message
 that starts with '-----BEGIN PGP SIGNED MESSAGE-----'.  That is
 not a text/plain, it's something else.
 
-Note that your maintainer does not necessarily read everything
-on the git mailing list.  If your patch is for discussion first,
-send it "To:" the mailing list, and optionally "cc:" him.  If it
-is trivially correct or after the list reached a consensus, send
-it "To:" the maintainer and optionally "cc:" the list for
-inclusion.
-
-Also note that your maintainer does not actively involve himself in
-maintaining what are in contrib/ hierarchy.  When you send fixes and
-enhancements to them, do not forget to "cc: " the person who primarily
-worked on that hierarchy in contrib/.
+Unless your patch is a very trivial and an obviously correct one,
+first send it with "To:" set to the mailing list, with "cc:" listing
+people who are involved in the area you are touching (the output from
+"git blame $path" and "git shortlog --no-merges $path" would help to
+identify them), to solicit comments and reviews.  After the list
+reached a consensus that it is a good idea to apply the patch, re-send
+it with "To:" set to the maintainer and optionally "cc:" the list for
+inclusion.  Do not forget to add trailers such as "Acked-by:",
+"Reviewed-by:" and "Tested-by:" after your "Signed-off-by:" line as
+necessary.
 
 
 (4) Sign your work
