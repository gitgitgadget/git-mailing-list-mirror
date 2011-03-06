From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 7/7] fetch/pull: Describe --recurse-submodule restrictions
 in the BUGS section
Date: Sun, 06 Mar 2011 23:14:15 +0100
Message-ID: <4D740737.1060901@web.de>
References: <4D74061C.5050908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 06 23:14:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwMDW-0001B4-A6
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 23:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab1CFWOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 17:14:17 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:59146 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab1CFWOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 17:14:16 -0500
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7FAD218997F76;
	Sun,  6 Mar 2011 23:14:15 +0100 (CET)
Received: from [93.246.45.11] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PwMDP-0007vW-00; Sun, 06 Mar 2011 23:14:15 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.14) Gecko/20110221 Thunderbird/3.1.8
In-Reply-To: <4D74061C.5050908@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/3NWRw8SCrmV+0EGuXRfs5/Jz5Im/iTp2C0a1J
	W7hgf3BQ9gktZCurn/XjEXrNCP6CzzRH8A3woQeaUB61ODt0Ja
	PU5G1KKRk+ew+fudp15A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168542>

Using the --recurse-submodules option with fetch and pull might not always
fetch all the submodule commits the user expects, as this will only work
when the submodule is already checked out. Document that and warn that
this is expected to change in the future.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-fetch.txt |    9 +++++++++
 Documentation/git-pull.txt  |    9 +++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index c76e313..8669227 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -76,6 +76,15 @@ The `pu` branch will be updated even if it is does not fast-forward,
 because it is prefixed with a plus sign; `tmp` will not be.


+BUGS
+----
+Using --recurse-submodules can only fetch new commits in already checked
+out submodules right now. When e.g. upstream added a new submodule in the
+just fetched commits of the superproject the submodule itself can not be
+fetched, making it impossible to check out that submodule later without
+having to do a fetch again. This is expected to be fixed in a future git
+version.
+
 SEE ALSO
 --------
 linkgit:git-pull[1]
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index c45efb3..1aad8bf 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -220,6 +220,15 @@ If you tried a pull which resulted in a complex conflicts and
 would want to start over, you can recover with 'git reset'.


+BUGS
+----
+Using --recurse-submodules can only fetch new commits in already checked
+out submodules right now. When e.g. upstream added a new submodule in the
+just fetched commits of the superproject the submodule itself can not be
+fetched, making it impossible to check out that submodule later without
+having to do a fetch again. This is expected to be fixed in a future git
+version.
+
 SEE ALSO
 --------
 linkgit:git-fetch[1], linkgit:git-merge[1], linkgit:git-config[1]
-- 
1.7.4.1.300.g29eea0
