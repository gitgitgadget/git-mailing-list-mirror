From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 08/13] gettextize: git-branch "git branch -v" messages
Date: Wed,  1 Sep 2010 20:44:00 +0000
Message-ID: <1283373845-2022-9-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 22:45:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OquBT-000790-BC
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab0IAUom convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 16:44:42 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47495 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab0IAUok (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 16:44:40 -0400
Received: by mail-ey0-f174.google.com with SMTP id 6so858728eyb.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JYI1K5NYcqInKfVvgiAey4/GpRmjJ5GjiofMgo3b+Po=;
        b=eQetXPYcdIGQoRtObegPDmkzClloSAAXK5kgXR7qMQkinXFsFHS6AwZad4wEkLTegN
         Mf83DCkckMLW6jpeTaNzmxfD9VoFyP9tEJcaYfABdLsT5refc9TivUnzHUJg8OgpbYsf
         GOZFLA36xTWmJSIZo0W98Hex2gxaOEzSdrFfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Q39N9FceNWN6lovm81IcsfweFXMsnlgWQpNmFEBAakVW5Hoj9z9dV/OiI3R0QmK2uT
         zk2Vxt4Tk38UA311rEDDfoxjQyIDGcZHKkteDQdku8gybO5lo0fnFmWv9mxudQqNrE+T
         FdjOuSivmmf1BuRZe05LXR+IMhbndPGk3pgS0=
Received: by 10.216.15.10 with SMTP id e10mr308728wee.21.1283373879947;
        Wed, 01 Sep 2010 13:44:39 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm6461150weq.16.2010.09.01.13.44.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 13:44:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.579.g2183d
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155079>

Make the "git branch -v" messages translatable, e.g.:

    5054b57 [ahead 8] branch error fixup

This is possibly a plumbing message.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

I don't know whether we consider "git branch -v" output plumbing or
not, probably not.

 builtin/branch.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 8802033..59e71fc 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -378,11 +378,11 @@ static void fill_tracking_info(struct strbuf *sta=
t, const char *branch_name,
 		strbuf_addf(stat, "%s: ",
 			shorten_unambiguous_ref(branch->merge[0]->dst, 0));
 	if (!ours)
-		strbuf_addf(stat, "behind %d] ", theirs);
+		strbuf_addf(stat, _("behind %d] "), theirs);
 	else if (!theirs)
-		strbuf_addf(stat, "ahead %d] ", ours);
+		strbuf_addf(stat, _("ahead %d] "), ours);
 	else
-		strbuf_addf(stat, "ahead %d, behind %d] ", ours, theirs);
+		strbuf_addf(stat, _("ahead %d, behind %d] "), ours, theirs);
 }
=20
 static int matches_merge_filter(struct commit *commit)
--=20
1.7.2.2.579.g2183d
