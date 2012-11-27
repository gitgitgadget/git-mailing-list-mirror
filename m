From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation/git-push.txt: clarify the "push from
 satellite" workflow
Date: Tue, 27 Nov 2012 15:52:27 -0800
Message-ID: <7v1ufeli2s.fsf_-_@alter.siamese.dyndns.org>
References: <1353977748-17110-1-git-send-email-bcasey@nvidia.com>
 <7vy5hnomsl.fsf@alter.siamese.dyndns.org> <50B41DF7.2000705@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 00:52:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUxK-0003o6-NH
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899Ab2K0Xwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:52:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34771 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756768Ab2K0Xwa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 18:52:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3664A582;
	Tue, 27 Nov 2012 18:52:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YGJ+bkpSU0tG6j+T/QVGu+Vxd4M=; b=cEHOJ+
	445TfEBe/9Nh6W/R0xw/ZjTq4CvaSOB/B6Fs1GmC32JuYvIQDaDy65b6y/YKdDEz
	k+eUGNoLksq+CHO7Ui559PZBcRdTvAxI8uykMbUownvBeq9t5QXNPdgiOENwIiAM
	AdEDgxxoidAKK6IpxBWr6rBehmSq2ayLWtLWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ozfg7dhQu+bk5i10h693yGK5Owz7fBpU
	qNHfjym2u3xIU6XjlYUMqhd//xWA7zh06XSyHhMdHZ+WBuMdapFyuKDFo24+j4mX
	CyH6tbErAe4pMCmQBVSItMeBNoKt+BIyn7GPxDOJLhJdyC7t7WHuUTUCa3i3k63D
	2NLy7gtuR/c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AED62A581;
	Tue, 27 Nov 2012 18:52:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DEFCA580; Tue, 27 Nov 2012
 18:52:28 -0500 (EST)
In-Reply-To: <50B41DF7.2000705@nvidia.com> (Brandon Casey's message of "Mon,
 26 Nov 2012 17:57:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 809C191A-38ED-11E2-9054-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210634>

The context of the example to push into refs/remotes/satellite/
hierarchy of the other repository needs to be spelled out explicitly
for the value of this example to be fully appreciated.  Make it so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Brandon Casey <bcasey@nvidia.com> writes:

>> So refs are correct. The context is not sufficiently explained.
>
> Ah, I see.  Yeah, I think that is complex enough to merit an
> extended explanation.

Something like this?

 Documentation/git-push.txt | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git c/Documentation/git-push.txt w/Documentation/git-push.txt
index 6d19d59..8b637d3 100644
--- c/Documentation/git-push.txt
+++ w/Documentation/git-push.txt
@@ -385,11 +385,23 @@ the ones in the examples below) can be configured as the default for
 	A handy way to push the current branch to the same name on the
 	remote.
 
-`git push origin master:satellite/master dev:satellite/dev`::
+`git push mothership master:satellite/master dev:satellite/dev`::
 	Use the source ref that matches `master` (e.g. `refs/heads/master`)
 	to update the ref that matches `satellite/master` (most probably
-	`refs/remotes/satellite/master`) in the `origin` repository, then
+	`refs/remotes/satellite/master`) in the `mothership` repository;
 	do the same for `dev` and `satellite/dev`.
++
+This is to emulate `git fetch` run on the `mothership` using `git
+push` that is run in the opposite direction in order to integrate
+the work done on `satellite`, and is often necessary when you can
+only make connection in one way (i.e. satellite can ssh into
+mothership but mothership cannot initiate connection to satellite
+because the latter is behind a firewall or does not run sshd).
++
+After running this `git push` on the `satellite` machine, you would
+ssh into the `mothership` and run `git merge` there to complete the
+emulation of `git pull` that were run on `mothership` to pull changes
+made on `satellite`.
 
 `git push origin HEAD:master`::
 	Push the current branch to the remote ref matching `master` in the
