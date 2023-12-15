Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D247F49
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QfBPR9Jw"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D09DB26EF3;
	Fri, 15 Dec 2023 15:32:58 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=l6gssdIBOBnQbWcHAyq63WMEy
	WqAdSI1lQd40rcK8fc=; b=QfBPR9JwB1jkPVJweGyEywd1+o9XmJI3N4dJXQkuc
	JHQM3atLiejlFgwFeR6M9PoMFzZRjTo8cGaOf60x7KTYbO0gUrcslzVG2wFkyO+3
	Z2jMslvkqO2xm4QWmMy4XWDb19fYfhOA8zh+4y7ee63pSscg6rGD97bq1DASObp+
	zM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C941F26EF2;
	Fri, 15 Dec 2023 15:32:58 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7421F26EF1;
	Fri, 15 Dec 2023 15:32:55 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/5] refs.h: HEAD is not that special
Date: Fri, 15 Dec 2023 12:32:43 -0800
Message-ID: <20231215203245.3622299-4-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-76-g1a87c842ec
In-Reply-To: <20231215203245.3622299-1-gitster@pobox.com>
References: <20231215203245.3622299-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 209A978E-9B89-11EE-9878-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

In-code comment explains pseudorefs but used a wrong nomenclature
"special ref".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.h b/refs.h
index 23211a5ea1..ff113bb12a 100644
--- a/refs.h
+++ b/refs.h
@@ -56,7 +56,7 @@ struct worktree;
  * Even with RESOLVE_REF_ALLOW_BAD_NAME, names that escape the refs/
  * directory and do not consist of all caps and underscores cannot be
  * resolved. The function returns NULL for such ref names.
- * Caps and underscores refers to the special refs, such as HEAD,
+ * Caps and underscores refers to the pseudorefs, such as HEAD,
  * FETCH_HEAD and friends, that all live outside of the refs/ directory.
  */
 #define RESOLVE_REF_READING 0x01
--=20
2.43.0-76-g1a87c842ec

