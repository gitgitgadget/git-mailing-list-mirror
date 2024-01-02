Received: from bi.d.mailin.fr (bi.d.mailin.fr [185.41.28.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAA116414
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bi.d.mailin.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="MvQpcwNb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=AD0KaYz+mhwoCzq94MlWO30nW+nmf0l9kJG58uJLvaQ=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=MvQpcwNbQV4dqMzGBkG40Vl+j94upvmRggIRXG3imMqhUFjxIGGF6A9dp6ncwobk7PxQnVjEPo4F
        R6STfnowlkf/zXjakvvBlHp21nIadSzma7XYOnU1A9SJTrmCqkN6MP34A/dRZe+ftFsYpNNrDT5W
        QyaAeVmn6ME4nc9/UcQ=
Received: by smtp-relay.sendinblue.com with ESMTP id ca077105-345a-4c65-a5a8-06c7be879255; Tue, 02 January 2024 19:57:55 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTAyMTk1NzQ0LjQ3ODUwMy03LWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5iaS5kLm1haWxpbi5mcg%3D%3D
Date: Tue,  2 Jan 2024 10:57:44 -0900
Subject: [RFC PATCH 6/6] completion: add comment
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 93D6C520261; Tue,  2 Jan 2024 10:57:53 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102195744.478503-1-britton.kerin@gmail.com>
References: <20240102195744.478503-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <ca077105-345a-4c65-a5a8-06c7be879255@smtp-relay.sendinblue.com>
Origin-messageId: <20240102195744.478503-7-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: rhv_g7CX4irG3_dMArnxljOs7AsRD0zXG_qJgo66HTd0xggVOnQ2KgnJQ9RnM9G1Lwb6ar_7FM_tt4JSkyLX0gbtKntAMu0437rBY6FziBpqTeaMJcpn4lap2gbp6_NjkBhaMdkcDLCn_EHhv16dcevSFYJBoW63RoDlz46OSwvj
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.109:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-completion.bash
index 3bb790220a..7f9a626e1b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1589,8 +1589,14 @@ =5Fgit=5Fbisect ()
 		term=5Fgood=3D`=5F=5Fgit bisect terms --term-good`
 	fi
=20
+	# We will complete any custom terms, but still always complete the
+	# more usual bad/new/good/old because git bisect gives a good error
+	# message if these are given when not in use and that's better than
+	# silent refusal to complete if the user is confused.
+	#
 	# We want to recognize 'view' but not complete it, because it overlaps
 	# with 'visualize' too much and is just an alias for it.
+	#
 	local completable=5Fsubcommands=3D=22start bad new $term=5Fbad good old =
$term=5Fgood terms skip reset visualize replay log run help=22
 	local all=5Fsubcommands=3D=22$completable=5Fsubcommands view=22
=20
--=20
2.43.0


