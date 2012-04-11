From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 0/5] provide better error messages for @{upstream}
Date: Wed, 11 Apr 2012 18:17:10 +0200
Message-ID: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 11 18:17:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0Eh-0007nA-S1
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760630Ab2DKQRa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 12:17:30 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34675 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759973Ab2DKQRa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:17:30 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SI0Eb-00065L-1e; Wed, 11 Apr 2012 18:17:29 +0200
X-Mailer: git-send-email 1.7.10.344.g387ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195198>

Hi,

this is a small patch series to provide better error messages when
'@{u}' in various forms is used. Patches are really tiny, and 2-5/5
could probably be squashed together, but this way the individual
changes should be more readable.

The idea is to provide as much information as possible for the user
when @{u} cannot be resolved successfully. The following cases are
distinguished:
- branch@{u} on a branch with
  * no upstream,
  * on a branch with a configured upstream, but when a branch is not
    in remote.<remote>.fetch
- branch@{u} when branch 'branch' does not exist
- @{u} without the branch name (current branch name is used)

Zbigniew J=C4=99drzejewski-Szmek (5):
  t1507: add additional tests for @{upstream}
  Provide branch name in error message when using @{u}
  Provide better message for barnhc_wiht_tpyo@{u}
  Be more specific if upstream branch is not fetched
  i18n: mark @{upstream} error messages for translation

 sha1_name.c                   | 20 ++++++++---
 t/t1507-rev-parse-upstream.sh | 82 +++++++++++++++++++++++++++++++++++=
++++++--
 2 files changed, 95 insertions(+), 7 deletions(-)

--=20
1.7.10.344.g387ed
