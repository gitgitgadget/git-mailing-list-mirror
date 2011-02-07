From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3] pull: Document the "--[no-]recurse-submodules" options
Date: Mon, 07 Feb 2011 23:24:54 +0100
Message-ID: <4D507136.2030505@web.de>
References: <4D4C5EBC.2090100@web.de> <201102042326.08607.j6t@kdbg.org> <4D4D33E7.4000303@web.de> <7vipwwx56r.fsf@alter.siamese.dyndns.org> <4D4F19D0.2000408@web.de> <20110206220939.GC17210@elie> <4D4F273C.8030003@web.de> <20110207074157.GA2736@elie> <4D5047BD.6030304@web.de> <7vsjvzttbs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 23:25:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmZWk-0005xT-Pm
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 23:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab1BGWY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 17:24:58 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:57887 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210Ab1BGWY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 17:24:56 -0500
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 2BA4E187862C9;
	Mon,  7 Feb 2011 23:24:55 +0100 (CET)
Received: from [93.246.61.132] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PmZVv-0001oy-00; Mon, 07 Feb 2011 23:24:55 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vsjvzttbs.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19CIaaYW/RoDdWlWL1WVvwOVwar1iRx5IAc8l7V
	dpyDJdstbY3otdnwUg5pl7jTZq0fe2x1wNNzrOWEh3sEVZtInT
	t1RiWHqmdZaMCduac8nA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166306>

In commits be254a0ea9 and 7dce19d374 the handling of the new fetch options
"--[no-]recurse-submodules" had been added to git-pull.sh. But they were
not documented as the pull options they now are, so let's fix that.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 07.02.2011 22:42, schrieb Junio C Hamano:
> Hmph, why not enclose the three of them inside a single ifndef here?

Sure!

 Documentation/fetch-options.txt |    2 --
 Documentation/git-pull.txt      |    9 +++++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 695696d..f37276e 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -64,13 +64,11 @@ ifndef::git-pull[]
 	downloaded. The default behavior for a remote may be
 	specified with the remote.<name>.tagopt setting. See
 	linkgit:git-config[1].
-endif::git-pull[]

 --[no-]recurse-submodules::
 	This option controls if new commits of all populated submodules should
 	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).

-ifndef::git-pull[]
 --submodule-prefix=<path>::
 	Prepend <path> to paths printed in informative messages
 	such as "Fetching submodule foo".  This option is used
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 3046691..b33e6be 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -84,6 +84,15 @@ must be given before the options meant for 'git fetch'.
 --verbose::
 	Pass --verbose to git-fetch and git-merge.

+--[no-]recurse-submodules::
+	This option controls if new commits of all populated submodules should
+	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
+	That might be necessary to get the data needed for merging submodule
+	commits, a feature git learned in 1.7.3. Notice that the result of a
+	merge will not be checked out in the submodule, "git submodule update"
+	has to be called afterwards to bring the work tree up to date with the
+	merge result.
+
 Options related to merging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
1.7.4.47.g87a200
