From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 13/13] gettextize: git-checkout "Switched to a .. branch" message
Date: Wed,  1 Sep 2010 20:44:05 +0000
Message-ID: <1283373845-2022-14-git-send-email-avarab@gmail.com>
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
	id 1OquBV-000790-PU
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182Ab0IAUot convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 16:44:49 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54032 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab0IAUor (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 16:44:47 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so478054wwj.1
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=EKEG299+FpARPR+eX57XWb0OBV7cIbHv5MjzMvarguk=;
        b=Yu1Bt0REA4G8ILDiX4y47gRv8pKt2eIg+ntokmGrBIC5FNrhQ106qC+lNQNFGX1HWC
         eaR0NR2jkUjNIBQPsV41jZpuNtZEJu360d2vwsMtn8zheNmxds5b39grFNRu/VRT63hJ
         1WLjzH3UOq1MN70TWP4ncA67YcQPksIqxlbVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UCZROjwU14XzozwZSz4yX7CMLHW4mh6j/sxP3dkCciZVOOqhJRWZkhK9LeprHfARAx
         wd+ojfrpxEsrAlgZ/JkZi7asgZL/Z1XxDOUqu+iCFXcHL0cw1oNlU/CcA7pAEVZyGcXo
         vhvN47qCD/Xi3dSy+uXO222yndc6S+en8pNb8=
Received: by 10.216.71.206 with SMTP id r56mr757396wed.29.1283373887029;
        Wed, 01 Sep 2010 13:44:47 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm6461150weq.16.2010.09.01.13.44.46
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 13:44:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.579.g2183d
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155087>

Split up the "Switched to and reset branch" and "Switched to a new
branch" messages to make them easier to translate.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/checkout.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 79cbcef..8d8649a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -553,9 +553,10 @@ static void update_refs_for_switch(struct checkout=
_opts *opts,
 				fprintf(stderr, _("Already on '%s'\n"),
 					new->name);
 			else if (opts->new_branch)
-				fprintf(stderr, "Switched to%s branch '%s'\n",
-					opts->branch_exists ? " and reset" : " a new",
-					new->name);
+				if (opts->branch_exists)
+					fprintf(stderr, _("Switched to and reset branch '%s'\n"), new->na=
me);
+				else
+					fprintf(stderr, _("Switched to a new branch '%s'\n"), new->name);
 			else
 				fprintf(stderr, _("Switched to branch '%s'\n"),
 					new->name);
--=20
1.7.2.2.579.g2183d
