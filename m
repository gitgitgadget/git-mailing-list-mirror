From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v6 13/13] git-notes(1): add a section about the meaning of history
Date: Wed, 10 Mar 2010 15:06:00 +0100
Message-ID: <2a789ed6300651d06fbe5835184e2669a2c483cc.1268229087.git.trast@student.ethz.ch>
References: <cover.1268229087.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 10 15:06:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpMYq-0004t1-0x
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 15:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412Ab0CJOG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 09:06:28 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:7926 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932393Ab0CJOGT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 09:06:19 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:06:05 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:06:02 +0100
X-Mailer: git-send-email 1.7.0.2.407.g21ebda
In-Reply-To: <cover.1268229087.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141897>

To the displaying code, the only interesting thing about a notes ref
is that it has a tree of the required format.  However, notes actually
have a history since they are recorded as successive commits.

Make a note about the existence of this history in the manpage, but
keep some doors open if we want to change the details.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

New in v6, as per Junio's comment

>  - As to the determination of committer/author identity, I think what the
>    code currently does (i.e. honor the environment and user.* config) is
>    perfectly sane, but at the same time I think it would be surprising for
>    unsuspecting users.  We may want to advise users about this in the
>    documentation.

(but see the series leader for more discussion about this).

 Documentation/git-notes.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 02a2baf..4e5113b 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -121,6 +121,20 @@ OPTIONS
 	GIT_NOTES_REF and the "core.notesRef" configuration.  The ref
 	is taken to be in `refs/notes/` if it is not qualified.
 
+
+NOTES
+-----
+
+Every notes change creates a new commit at the specified notes ref.
+You can therefore inspect the history of the notes by invoking, e.g.,
+`git log -p notes/commits`.
+
+Currently the commit message only records which operation triggered
+the update, and the commit authorship is determined according to the
+usual rules (see linkgit:git-commit[1]).  These details may change in
+the future.
+
+
 Author
 ------
 Written by Johannes Schindelin <johannes.schindelin@gmx.de> and
-- 
1.7.0.2.407.g21ebda
