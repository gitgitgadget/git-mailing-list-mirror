From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 19/73] gettextize: git-branch "(no branch)" message
Date: Tue, 22 Feb 2011 23:41:38 +0000
Message-ID: <1298418152-27789-20-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1wr-0001H8-Em
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185Ab1BVXn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:56 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab1BVXnu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:50 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JlKjpz+JgTZzWRF/QRVVJk4zdEl9NzMy8wUuCMM8dgc=;
        b=RF+yAgeP46gUkbsbEDS3m8LVPzOfS0jPk2/tmNUuuTu5fs/Kofdu0UgDt710UuRebJ
         qwnr0ZO8f37aSIQX+pbuGpuStmaGx385xYHDlWYagX0raDRAUGk1yxrgw4ubuRYraGcx
         4UmWl8pyb7T80u4eszjiFQmNMhTxbtNDj/BME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aKoLbjbp9hU4b84ptNXyccFYUZGQiu4oSE+qu9GjHmkpjRkjQsHZNDweuVhyRgMcmb
         KuejWzUc+/p0zpS7o4bbdBTfglrGKaxb/XO3Lq9TWlY7zK8ze5sAj0vWDSqdQQ3V4KDB
         eqEi4orL6fkbHncxijg04CeMRFYJrgWThbDtU=
Received: by 10.204.113.9 with SMTP id y9mr2986715bkp.201.1298418229932;
        Tue, 22 Feb 2011 15:43:49 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.48
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:49 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167646>

Gettextize the "(no branch)" message that's shown by "git branch" when
you're in a detached HEAD.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/branch.c         |    2 +-
 t/t3203-branch-output.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4c1a256..244589e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -476,7 +476,7 @@ static void show_detached(struct ref_list *ref_list=
)
=20
 	if (head_commit && is_descendant_of(head_commit, ref_list->with_commi=
t)) {
 		struct ref_item item;
-		item.name =3D xstrdup("(no branch)");
+		item.name =3D xstrdup(_("(no branch)"));
 		item.len =3D strlen(item.name);
 		item.kind =3D REF_LOCAL_BRANCH;
 		item.dest =3D NULL;
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 6028748..4ef7d09 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -72,7 +72,7 @@ cat >expect <<'EOF'
   branch-two
   master
 EOF
-test_expect_success 'git branch shows detached HEAD properly' '
+test_expect_success C_LOCALE_OUTPUT 'git branch shows detached HEAD pr=
operly' '
 	git checkout HEAD^0 &&
 	git branch >actual &&
 	test_cmp expect actual
--=20
1.7.2.3
