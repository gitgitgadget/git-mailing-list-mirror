From: Phil Hord <hordp@cisco.com>
Subject: [PATCH] git-push.txt: clean up force-with-lease wording
Date: Thu, 26 Mar 2015 11:15:09 -0400
Message-ID: <1427382909-7414-1-git-send-email-hordp@cisco.com>
Cc: gitster@pobox.com, phil.hord@gmail.com, Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 16:15:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb9VO-0000si-OP
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 16:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbbCZPP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 11:15:29 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:24268 "EHLO
	rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbbCZPP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 11:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2350; q=dns/txt; s=iport;
  t=1427382926; x=1428592526;
  h=from:to:cc:subject:date:message-id;
  bh=glOTs5lX4yG3L8xnBF7Z+FUlBf/vXwYh/gxZ7l9DpQM=;
  b=Ao6QxfoMwyZYlV3+8uHm8c8aPq8HeFfL3lqCIjiSWTxn/W/S0uUK3YQ3
   JiroFNVC+3S8sF09KXfq22jWzGS/jANS2o/3s4kcSNSTo0YhnWjXzCfEM
   TzfzUq6lqttX73mkNFP+6vqbhmWSIIffxni8MMZr3/t1DhH3DuIW6OfkF
   k=;
X-IronPort-AV: E=Sophos;i="5.11,472,1422921600"; 
   d="scan'208";a="406893498"
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by rcdn-iport-6.cisco.com with ESMTP; 26 Mar 2015 15:15:26 +0000
Received: from hordp-lnx.cisco.com (dhcp-64-100-104-75.cisco.com [64.100.104.75])
	by alln-core-5.cisco.com (8.14.5/8.14.5) with ESMTP id t2QFFP9s024643;
	Thu, 26 Mar 2015 15:15:25 GMT
X-Mailer: git-send-email 2.3.3.377.gdac1145
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266332>

The help text for the --force-with-lease option to git-push
does not parse cleanly.  Clean up the wording and syntax to
be more sensible.  Also remove redundant information in the
"--force-with-lease alone" description.

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 Documentation/git-push.txt | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 5171086..863c30c 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -157,9 +157,8 @@ already exists on the remote side.
 	Usually, "git push" refuses to update a remote ref that is
 	not an ancestor of the local ref used to overwrite it.
 +
-This option bypasses the check, but instead requires that the
-current value of the ref to be the expected value.  "git push"
-fails otherwise.
+This option overrides this restriction if the current value of the
+remote ref is the expected value.  "git push" fails otherwise.
 +
 Imagine that you have to rebase what you have already published.
 You will have to bypass the "must fast-forward" rule in order to
@@ -171,15 +170,14 @@ commit, and blindly pushing with `--force` will lose her work.
 This option allows you to say that you expect the history you are
 updating is what you rebased and want to replace. If the remote ref
 still points at the commit you specified, you can be sure that no
-other people did anything to the ref (it is like taking a "lease" on
-the ref without explicitly locking it, and you update the ref while
-making sure that your earlier "lease" is still valid).
+other people did anything to the ref. It is like taking a "lease" on
+the ref without explicitly locking it, and the remote ref is updated
+only if the "lease" is still valid.
 +
 `--force-with-lease` alone, without specifying the details, will protect
 all remote refs that are going to be updated by requiring their
 current value to be the same as the remote-tracking branch we have
-for them, unless specified with a `--force-with-lease=<refname>:<expect>`
-option that explicitly states what the expected value is.
+for them.
 +
 `--force-with-lease=<refname>`, without specifying the expected value, will
 protect the named ref (alone), if it is going to be updated, by
-- 
2.3.3.377.gdac1145
