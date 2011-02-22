From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 71/73] gettextize: git-revert literal "me" messages
Date: Tue, 22 Feb 2011 23:42:30 +0000
Message-ID: <1298418152-27789-72-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:45:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1vH-0000K1-7V
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631Ab1BVXov convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:51 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:51284 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624Ab1BVXot (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:49 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3867040bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=BWVewWnQJgp1yNayP49tNWl0vcmgoqQVm57ZwYQKNII=;
        b=SL2x9oDwAyGSyuQqfvFRkoqYLsp8fpZ04xBs0B1aMUt1/6G87kDW6XouE2iseb0pmm
         B3seasctoBX4Rs1ejTm9usuojEb3SI7o7KGASgnqiq2CxAoWSLhkRM1pqVyPiaiL/8VP
         oUgZvCJeLjts1hlELvXZ/9m4Qeit16VPwlC2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xQH/iA4YEJtIWECAWne2jxAoUm3tvJMaaT86WsR0rZFKeWA9Pom2zG1rCjx5n2DbqA
         OUQJUqwx2zy29iB0mpDWTnqu5UBhiDcGSDABndkU6BTpe+ipl6/GYKvMcHdmamNDcbZk
         fIDS1MUJctQ2vEEyNgag8IUyYi7++k5eHTumE=
Received: by 10.204.57.18 with SMTP id a18mr3056612bkh.64.1298418288696;
        Tue, 22 Feb 2011 15:44:48 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.47
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:48 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167616>

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
