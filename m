From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/3] t/t5400-send-pack.sh: re-indent subshell invocation
Date: Tue, 18 Jan 2011 22:41:36 +0100
Message-ID: <1295386896-21828-3-git-send-email-avarab@gmail.com>
References: <1295386896-21828-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 18 22:42:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfJK7-0003Az-TV
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 22:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754Ab1ARVmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jan 2011 16:42:32 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46636 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733Ab1ARVmb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 16:42:31 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so82442eye.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 13:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Nmjnpdkqm5M36lziYOskm2+XJ+ZEFeKELfjvS4A1HUw=;
        b=WxFrVy/I2HMpVH7/ae4ytTGBag8PpIwCD/ug7/91JaUUtTSuChwr0HOdxx+7lwzXZj
         pqAcwQ2hnd/OWR0btF9rPLOh4Wni8OanzMTw3jwEgl/MzDoaXS6J0ilPMeM4r8lY/TDu
         0tKhmnFOum044gHsCbGvf0CvbcO3wN5hmKCbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HCrbcXX/y4yR3uyyxjU0v0/1E/JY15uonqUyscvFSyMMMVgFZSbQAK442Al+4mSUdc
         kC/C7hPjfxRCB0IHXFXe5jz04OiXun+qt3aPRRpKRBhxr+7ijOujGgkKPF5pIGDRvcbs
         j6/yLKOd6SVtdRcOxBgOpx1nk4OQuVTZFaoPE=
Received: by 10.14.22.79 with SMTP id s55mr4449502ees.22.1295386951113;
        Tue, 18 Jan 2011 13:42:31 -0800 (PST)
Received: from snth.ams7.corp.booking.com (212-182-132-170.ip.telfort.nl [212.182.132.170])
        by mx.google.com with ESMTPS id t5sm4916974eeh.20.2011.01.18.13.42.28
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Jan 2011 13:42:30 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1295386896-21828-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165225>

Change a subshell invocation in t/t5400-send-pack.sh to use one line
per command in the subshell, that's the usual syntax we use for tests.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t5400-send-pack.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 0357610..d4db5ac 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -32,7 +32,11 @@ test_expect_success setup '
 	done &&
 	git update-ref HEAD "$commit" &&
 	git clone ./. victim &&
-	( cd victim && git config receive.denyCurrentBranch warn && git log )=
 &&
+	(
+	    cd victim &&
+	    git config receive.denyCurrentBranch warn &&
+	    git log
+	) &&
 	git update-ref HEAD "$zero" &&
 	parent=3D$zero &&
 	i=3D0 &&
--=20
1.7.2.3
