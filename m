From: Pierre Habouzit <madcoder@debian.org>
Subject: [proposal] make parse-options nicer wrt optional arguments (supersedes all my recent posts on the matter)
Date: Mon, 17 Dec 2007 19:23:10 +0100
Message-ID: <1197915797-30679-1-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 17 19:25:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4KdP-0003yo-Lz
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 19:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649AbXLQSXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 13:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756608AbXLQSXU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 13:23:20 -0500
Received: from pan.madism.org ([88.191.52.104]:54931 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756048AbXLQSXT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 13:23:19 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4726030731;
	Mon, 17 Dec 2007 19:23:18 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 197F318F74; Mon, 17 Dec 2007 19:23:17 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc0.1148.ga3ab1-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68592>

Here is a series that aims at fixing the various issues with
parse-options that were raised recently.

* preliminary patch:
  [PATCH 1/7] parse-options: Make callbacks take flags instead of boolean `unset`

* teach git parse-options to allow callbacks to ignore arguments that
  don't seem to be theirs, refactors:
  [PATCH 2/7] parse-options: allow callbacks to ignore arguments they don't need to use.
  [PATCH 3/7] parse-options: Let the integer/string cases be callbacks as well.
  [PATCH 4/7] parse-options: let OPT__ABBREV ignore arguments.

* Document this (my previous proposal + Junio's squashed):
  [PATCH 5/7] parse-options: Add a gitcli(5) man page.

* Implement my `{}` proposal, a sed -e s/{}/_/ will replace {} with _
  as a wildcard. Contains documentation for this placeholder.
  [PATCH 6/7] parse-options: have a `use default value` wildcard.

* Somehow unrelated patch, but still parse-option related (resend):
  [PATCH 7/7] git-tag: fix -l switch handling regression.



This has been pushed as my ph/parseopt branch on
git://git.madism.org/git.git.
