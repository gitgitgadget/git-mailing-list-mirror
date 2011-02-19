From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 70/72] gettextize: git-revert literal "me" messages
Date: Sat, 19 Feb 2011 19:24:53 +0000
Message-ID: <1298143495-3681-71-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:29:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsUU-0003dU-SW
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250Ab1BST2m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:42 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39339 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756205Ab1BST21 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:27 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347149eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=BWVewWnQJgp1yNayP49tNWl0vcmgoqQVm57ZwYQKNII=;
        b=BaQt5QyWHpKtDmAQb2rtqOj2yXmxTEn5cBPadQTKegealS/QrrHoIteqQqNp8CAmPc
         qVxZmgW/Yu2wmKuVq+0Uo+92RiFu93wVmA1XPu+mgLkMBpLOau0WEaMblI6D69vDZqj8
         3AujVuEyVbRvna1am/inKEp5gX/mmGy+IyFCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=abVpbKW+6QXfp9fP3iM1SRjAXc2gvleOAeGpCPuk2KXldax7OBzcqVJ1rj2JMH/ZTb
         MQcbPZ4V/mibAa+h8JHzAD3drEv/5oZYiMPIHvJM9ckmHLEHttFylzQ6ATvBVGSybuJZ
         Z+SECr0dEZusRtIw1xi/MBvMqfCt0sgwlbSns=
Received: by 10.213.27.71 with SMTP id h7mr433161ebc.20.1298143706953;
        Sat, 19 Feb 2011 11:28:26 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.26
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:26 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167350>

Translate messages that use the `me' variable. These are all error
messages referencing the command name, so the name shouldn't be
translated.

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/revert.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 02c23c9..b0a5ffb 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -362,7 +362,8 @@ static int do_recursive_merge(struct commit *base, =
struct commit *next,
 	if (active_cache_changed &&
 	    (write_cache(index_fd, active_cache, active_nr) ||
 	     commit_locked_index(&index_lock)))
-		die("%s: Unable to write new index file", me);
+		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
+		die(_("%s: Unable to write new index file"), me);
 	rollback_lock_file(&index_lock);
=20
 	if (!clean) {
@@ -469,7 +470,9 @@ static int do_pick_commit(void)
 		return fast_forward_to(commit->object.sha1, head);
=20
 	if (parent && parse_commit(parent) < 0)
-		die("%s: cannot parse parent commit %s",
+		/* TRANSLATORS: The first %s will be "revert" or
+		   "cherry-pick", the second %s a SHA1 */
+		die(_("%s: cannot parse parent commit %s"),
 		    me, sha1_to_hex(parent->object.sha1));
=20
 	if (get_message(commit->buffer, &msg) !=3D 0)
--=20
1.7.2.3
