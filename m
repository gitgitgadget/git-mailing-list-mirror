From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 08/20] gettextize: git-revert literal "me" messages
Date: Tue,  7 Sep 2010 16:47:44 +0000
Message-ID: <1283878065-19349-5-git-send-email-avarab@gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:51:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1OA-0004K7-96
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254Ab0IGQtd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:49:33 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55994 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757994Ab0IGQsH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:48:07 -0400
Received: by wwj40 with SMTP id 40so8414154wwj.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qhBi6vrfW95wny46c4ojeZLTmycrB5POTCKlghA23lo=;
        b=xAFwY1WHSfTZ4p+rI/lI/8ccEIIMYFUbkGmnimkph3LE3OshjOlZBfF8GOEXSM/UFP
         SnL47j+iPwNNjFe1oOzNBwdaSS9nCj5E8SPnVvqB7eSvMi1S1a8i6y/5ujWo7wuR//ms
         6bueOR+8tXxIweinJZIaOMTihZZQZ4E0qitCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=b5kElU8lUbugIULOF3TM7zN6rFOm4oWaPltdhUkCJoYaBE9dUyyPiS3xdvz1JXtiep
         wjtMO4V55Ex6Xi0WjIJVF8cPyK84iTBoAUvv/PHFlQaiJ+hLSjPZdvPLbS86/kjaFpMb
         hFz2eSfwQLAtjtGAJn5pz+4jvWHgHv9mi03BM=
Received: by 10.227.135.141 with SMTP id n13mr105759wbt.97.1283878086113;
        Tue, 07 Sep 2010 09:48:06 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm5895402wbe.23.2010.09.07.09.48.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:48:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155722>

Redo the translation of the remaining messages that used the `me'
variable. These are all error messages referencing the command name,
so the name shouldn't be translated.

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/revert.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index ad2c76a..a89dd12 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -347,7 +347,8 @@ static int do_recursive_merge(struct commit *base, =
struct commit *next,
 	if (active_cache_changed &&
 	    (write_cache(index_fd, active_cache, active_nr) ||
 	     commit_locked_index(&index_lock)))
-		die(_("%s: Unable to write new index file"), _(me));
+		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
+		die(_("%s: Unable to write new index file"), me);
 	rollback_lock_file(&index_lock);
=20
 	if (!clean) {
@@ -454,8 +455,10 @@ static int do_pick_commit(void)
 		return fast_forward_to(commit->object.sha1, head);
=20
 	if (parent && parse_commit(parent) < 0)
+		/* TRANSLATORS: The first %s will be "revert" or
+		   "cherry-pick", the second %s a SHA1 */
 		die(_("%s: cannot parse parent commit %s"),
-		    _(me), sha1_to_hex(parent->object.sha1));
+		    me, sha1_to_hex(parent->object.sha1));
=20
 	if (get_message(commit->buffer, &msg) !=3D 0)
 		die(_("Cannot get commit message for %s"),
@@ -577,7 +580,8 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
 	}
=20
 	if (read_cache() < 0)
-		die(_("git %s: failed to read the index"), _(me));
+		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
+		die(_("git %s: failed to read the index"), me);
=20
 	prepare_revs(&revs);
=20
--=20
1.7.2.3.313.gcd15
