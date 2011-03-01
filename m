From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 7/7] fetch/pull: Describe --recurse-submodule restrictions
 in the BUGS section
Date: Wed, 02 Mar 2011 00:04:45 +0100
Message-ID: <4D6D7B8D.3020409@web.de>
References: <4D6D7A50.5090802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 00:04:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuYce-0002Xe-To
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 00:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534Ab1CAXEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 18:04:47 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:43703 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756275Ab1CAXEr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 18:04:47 -0500
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id 45C391897B4F6;
	Wed,  2 Mar 2011 00:04:46 +0100 (CET)
Received: from [93.240.102.247] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PuYcY-0002z2-00; Wed, 02 Mar 2011 00:04:46 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D6D7A50.5090802@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/XZSy5Zv+Ue26tLKsdKdDdYJ22l/4D+ImfcGxi
	WFMezqhYz0zuftlxLcDjs6qFsq7ne3a8peB03OTCNqo7r0lGCH
	yrFUlWpMqq7/aSBvgFpQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168280>

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
index c76e313..f907ef5 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -76,6 +76,15 @@ The `pu` branch will be updated even if it is does not fast-forward,
 because it is prefixed with a plus sign; `tmp` will not be.


+BUGS
+----
+Using --recurse-submodules can only fetch new commits in alrady checked
+out submodules right now. When e.g. upstream added a new submodule in the
+just fetched commits of the superproject the submodule itself can not be
+fetched, making it impossible to check out that submodule later whithout
+having to do a fetch again. This is expected to be fixed in a future git
+version.
+
 SEE ALSO
 --------
 linkgit:git-pull[1]
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index c45efb3..1596d2b 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -220,6 +220,15 @@ If you tried a pull which resulted in a complex conflicts and
 would want to start over, you can recover with 'git reset'.


+BUGS
+----
+Using --recurse-submodules can only fetch new commits in alrady checked
+out submodules right now. When e.g. upstream added a new submodule in the
+just fetched commits of the superproject the submodule itself can not be
+fetched, making it impossible to check out that submodule later whithout
+having to do a fetch again. This is expected to be fixed in a future git
+version.
+
 SEE ALSO
 --------
 linkgit:git-fetch[1], linkgit:git-merge[1], linkgit:git-config[1]
-- 
1.7.4.1.291.g6060
