From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 12/13] gettextize: git-checkout describe_detached_head messages
Date: Wed,  1 Sep 2010 20:44:04 +0000
Message-ID: <1283373845-2022-13-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 22:45:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OquBV-000790-8l
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129Ab0IAUos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 16:44:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55306 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754967Ab0IAUoq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 16:44:46 -0400
Received: by wyb35 with SMTP id 35so9681926wyb.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Fr6c4mdRFZ52mcI6M1DfLVykMQYNLlnxqbVQpkQBjc8=;
        b=C/6GypsHUkK1xSDRyx5fOT/11N8jbzpjbjdAxen5tAVUP8r8GjPJep4noR8ez17amH
         dCl6G9EKz8gJq2x5V7J6Pz6gXC9XB7z6RaaVOiQA27+N3QEGVvD957N4mFJGv39RaeIh
         q65o5XJAu9oITX1WUoiRU02CYUMScuy0sDClE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VRm20fdkCuDGJWxNB+LMbzv5mEiSHhTgVck/C2yJn7dUewRc0nJvIuxHK1ZE4XS+3O
         JbQnue6UiAWoBAHFpwhYVoDbfIGOy//fENQqlasJqC+hSh7ZlPUVa5HK3rvZXMGRbSRS
         zripCBQQWRPCbWh/8TuYkmRG1MfiuJCFfpLmU=
Received: by 10.216.165.77 with SMTP id d55mr8417320wel.23.1283373885479;
        Wed, 01 Sep 2010 13:44:45 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm6461150weq.16.2010.09.01.13.44.44
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 13:44:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.579.g2183d
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155084>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

This is comparable to the basic messages, but I put it in its own
patch mainly as a reminder to myself, this maybe needs to be split
into a %s format in the future.

 builtin/checkout.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a7033a0..79cbcef 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -574,7 +574,7 @@ static void update_refs_for_switch(struct checkout_=
opts *opts,
 		if (!opts->quiet) {
 			if (old->path && advice_detached_head)
 				detach_advice(old->path, new->name);
-			describe_detached_head("HEAD is now at", new->commit);
+			describe_detached_head(_("HEAD is now at"), new->commit);
 		}
 	}
 	remove_branch_state();
@@ -616,7 +616,7 @@ static int switch_branches(struct checkout_opts *op=
ts, struct branch_info *new)
 	 * to remind the user that it might be lost.
 	 */
 	if (!opts->quiet && !old.path && old.commit && new->commit !=3D old.c=
ommit)
-		describe_detached_head("Previous HEAD position was", old.commit);
+		describe_detached_head(_("Previous HEAD position was"), old.commit);
=20
 	update_refs_for_switch(opts, &old, new);
=20
--=20
1.7.2.2.579.g2183d
