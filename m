Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4375B76058
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560132; cv=none; b=jHBwoXt+NUtQywDCOmM+Rna9QrgE7mHwZv20dULF3LkCp/WbrXgcwhRYD80veporTFMmaI2XA9yutM8HAYxvVhR71+O9GsOE5/zk+DFHp/4UBUX+UMoDqQR59ilo38ilqDBqiase/lJ7mkRqg8CgZSyQtls+T3OFo87YPQjChR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560132; c=relaxed/simple;
	bh=qzaQl1IHzXC0UPE5jMOF/6Jk5Pq5vPfrECbcTnkpB2E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvkJwk8vyZg8pPnQMReNdp/Xff4pcX6rrmEYKd4xmn3bXQOp3sxdzNFRBrXvfu8on3IM4poL7343sG6LVwhSygegvN0XTFTW/P9+qu/K5prGIZzOXbMde+vaywRAgY7y6PC3SoYxAvA7QxoQcGKAoQG9SzjOdCF9fFAk6b5udGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kJLO5otH; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kJLO5otH"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 08EE21BB04F;
	Mon, 29 Jan 2024 15:28:44 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=qzaQl1IHzXC0UPE5jMOF/6Jk5
	Pq5vPfrECbcTnkpB2E=; b=kJLO5otHJWjyV1RFJizZQ/s/tN1HIYBlBex1nL4WX
	Qz3/lTKzfdUjNVrQvxKPui3Mi+JBt8RPfX4k+3iJcw4zFIT7tijqMh3L17XJIOYC
	0a9Q+w4eoNDSCulvmInwbHxUuGwOvTwCUaVNqYkysJvyZLMuA3mhImbkFmHA5TDh
	5w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F3F871BB04E;
	Mon, 29 Jan 2024 15:28:43 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F32A1BB04D;
	Mon, 29 Jan 2024 15:28:43 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/3] merge-ort.c: comment style fix
Date: Mon, 29 Jan 2024 12:28:38 -0800
Message-ID: <20240129202839.2234084-3-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-440-gb50a608ba2
In-Reply-To: <20240129202839.2234084-1-gitster@pobox.com>
References: <20240129202839.2234084-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 FEFA4B7C-BEE4-11EE-986D-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 77ba7f3020..cb83449d7f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2641,7 +2641,7 @@ static void apply_directory_rename_modifications(st=
ruct merge_options *opt,
 			oidcpy(&ci->stages[i].oid, null_oid());
 		}
=20
-		// Now we want to focus on new_ci, so reassign ci to it
+		/* Now we want to focus on new_ci, so reassign ci to it. */
 		ci =3D new_ci;
 	}
=20
--=20
2.43.0-440-gb50a608ba2

