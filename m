From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] howto/maintain-git.txt: new version numbering scheme
Date: Fri, 31 Jan 2014 15:14:05 -0800
Message-ID: <xmqqfvo3hhhe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 01 00:14:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9NHu-0003wl-Dn
	for gcvg-git-2@plane.gmane.org; Sat, 01 Feb 2014 00:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933163AbaAaXON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 18:14:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933129AbaAaXOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 18:14:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34769683E0;
	Fri, 31 Jan 2014 18:14:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=d
	qTX8Rd7thvSyMfJzLLlw5lOvK8=; b=h2r0wDVeLLFcjRpn2HB3TmpbYb2z3osdW
	bAm7ykRscIqZ160B7KBApyPLZL5Ryli+t+UtyyLDy1QgN7WahsBOlLxS+/UaBkJj
	tdqYr6DFJmZBo8HoOBbO7BzEZx3tAhdzXszGbjthCfE4yXOKTolgf6ok4G0lqO+O
	wXHLwsuF9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=KPO
	UzNWwzMEN+aBx3MeChVwo8pF3dp8IzRAKSojYhmDofhirvxfC5PNY/+F7R7wtyqd
	0L7w59KwgLcEVmZlD3eW858sNFECPYNPdbIjukP9CgYDKit8U604vBp+X+/GPHjm
	UQQylc33oji7/B+k8tXOf0PmLdNUIvJC3b2DBvx4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 290C7683DF;
	Fri, 31 Jan 2014 18:14:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FCE9683DE;
	Fri, 31 Jan 2014 18:14:08 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 62F91BF0-8ACD-11E3-B1F1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241324>

We wanted to call the upcoming release "Git 1.9", with its
maintenance track being "Git 1.9.1", "Git 1.9.2", etc., but various
third-party tools are reported to assume that there are at least
three dewey-decimal components in our version number.

Adjust the plan so that vX.Y.0 are feature releases while vX.Y.Z
(Z > 0) are maintenance releases.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Haven't committed to this outline, but I am raising a
   weather-balloon to see reaction from the list.  Comments?

 Documentation/howto/maintain-git.txt | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index 33ae69c..ca43787 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -39,26 +39,26 @@ The policy on Integration is informally mentioned in "A Note
 from the maintainer" message, which is periodically posted to
 this mailing list after each feature release is made.
 
- - Feature releases are numbered as vX.Y.Z and are meant to
+ - Feature releases are numbered as vX.Y.0 and are meant to
    contain bugfixes and enhancements in any area, including
    functionality, performance and usability, without regression.
 
  - One release cycle for a feature release is expected to last for
    eight to ten weeks.
 
- - Maintenance releases are numbered as vX.Y.Z.W and are meant
-   to contain only bugfixes for the corresponding vX.Y.Z feature
-   release and earlier maintenance releases vX.Y.Z.V (V < W).
+ - Maintenance releases are numbered as vX.Y.Z and are meant
+   to contain only bugfixes for the corresponding vX.Y.0 feature
+   release and earlier maintenance releases vX.Y.W (W < Z).
 
  - 'master' branch is used to prepare for the next feature
    release. In other words, at some point, the tip of 'master'
-   branch is tagged with vX.Y.Z.
+   branch is tagged with vX.Y.0.
 
  - 'maint' branch is used to prepare for the next maintenance
-   release.  After the feature release vX.Y.Z is made, the tip
+   release.  After the feature release vX.Y.0 is made, the tip
    of 'maint' branch is set to that release, and bugfixes will
    accumulate on the branch, and at some point, the tip of the
-   branch is tagged with vX.Y.Z.1, vX.Y.Z.2, and so on.
+   branch is tagged with vX.Y.1, vX.Y.2, and so on.
 
  - 'next' branch is used to publish changes (both enhancements
    and fixes) that (1) have worthwhile goal, (2) are in a fairly
@@ -86,6 +86,10 @@ this mailing list after each feature release is made.
    users are encouraged to test it so that regressions and bugs
    are found before new topics are merged to 'master'.
 
+Note that before v1.9.0 release, the version numbers used to be
+structured slightly differently.  vX.Y.Z were feature releases while
+vX.Y.Z.W were maintenance releases for vX.Y.Z.
+
 
 A Typical Git Day
 -----------------
