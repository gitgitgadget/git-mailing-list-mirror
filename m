Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF41A30EF64
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 05:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772428557; cv=none; b=HabpJjE9AmGtx/oi8fHvk+grFQCwkczOA3b5gu6bPyssoT2KomXLl6No8EjY2fRi5ZDNpcZ10p3j91Vl35xPoWNBo1kqbn6D9b64Yq9WijkdlzM2D/hdnQEAleg+/lcNns2A9FJ519HIhmue7h1RPFPbYhn/4mxWaTq3kyi6DWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772428557; c=relaxed/simple;
	bh=C0ND/058SRvoiDV+RZlAG5zBjxYP+hOMK74jl4zwinI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CIepdB1IFnn8W2kORIU5l2U9qahZl7dKgH+o8yJAu1y/NorVNmT18NFD/UetbIQAHWjH+gqwyrk4kpO6/Y3EXnp+mw3FSzOG22WH9QmGSPaMCI0PJU6PpOM7zN/qEK3M+0zoMCgHbU7hETbrhittgandzUzWzNb4ZI8zcr9Ry18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0V7+BuU; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0V7+BuU"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c711959442so427641385a.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 21:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772428554; x=1773033354; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7RbBn7BeJ96OossUwxZQJYew7yeBQ0JYvDXxKaVLVI=;
        b=R0V7+BuUIw5kjk8dNWiN3l4RpsmO+Zde2SmMcc5eruiDTXrUeeG5Pe5CvFLf3vVgnG
         ENWujErj4IlpMqREpowblIYyA2YCJbacJy17CL1OmYgks+rb1Ky/fjxgn0F1e7BTLUmL
         qC60wC0ns/nIZbqa0RmaRCe0kA8ZhqbV6hhBNlj2q8gNAnOIeKUle3X/8cBThpXbRXhW
         jGlfJ3OeOkhpKQL08L5KM+F2Erh7PH9spe0AcvKx2SVUqnXCLog0U9f3kSTDZA/wT2HG
         MV2fnvEdQejEDbX/TGbO+4CNCXcEFcdc6O9Y/cQp8dxnkiQi9lhA/K/5eY0K7rJg8Kzw
         9c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772428554; x=1773033354;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B7RbBn7BeJ96OossUwxZQJYew7yeBQ0JYvDXxKaVLVI=;
        b=tQMLS+RHy0XuE/Yjrh5PyAExD2cfznIlvNRt35mcvEkvBqBTzDTzJI9e0vFEAxmsN9
         fuvD8da/x5pI7bLai3x5dRWTNMvb0YrND22qTQ05n7a+ut1lcPn7yGWg23RKwvFzE8up
         uhGKtDcbfX2TCGV5bcUFUaIFzXv4QCANb8iOZGgxe6mAdbPdTpAXPzpf9PEsSOP35H5Q
         LCFuGJh1n6ZF+/mSLTXYOQwzQl1f+ZEn5imjRmYe3QPzziTFfvHfuAxgQAT0zLgtqOWn
         lW7oU0YqfP38dG0PRlCqU7BUy960UbNZ+/ZxBKLp+eTOFKgJZRzFjPlO+T92J30cKtJB
         S51g==
X-Gm-Message-State: AOJu0YwhDQfBN6vedipIvnFBRWsTefn3MOav5T7rZuNTXgZPu84fQ/11
	Vwr71yo/VZbxfo6lVWtxmIRDVzJjiXU0eTh0v0h0KghDyMb3FMJ3I5mVVW9TuAd0
X-Gm-Gg: ATEYQzz/GLqskn1qIlq5ESXADpHWrA5zBnuDKejQcpxI/Rhtgc3xfw8lIVqwiynDIla
	VUS9vZjuC069nZ/R8UlOz1nSCQDxxClk1kU37BbGky5xcg5S5pZKxZ4pN2XVQ7ZYQUhDGyj9jrW
	bBYJNBAauDneBBo8ukL+1NgrG4HHj/+PRcru/fJ9DJpZZwpCvHz2knZbac+M1O67YZh/lOxnMj1
	lg225LSrc1s1E2L0R8edocCLJbbMe92Eil+Y2iFaxJssG5hxJQOUN3Cu24TWQ8oX0apxnmitXoN
	Hwy2br3mKR3IgTDQMxyFvshM+mz9FgxKzj5OlJ68FOf91LomVzD6M/ljY/kJuSF0IIsKvHqVaVO
	9E7a4IKlATNx32DCYW0Gu8sK1N6q1Gn8k98QFZhTywKwoSTQfStt1T8XueBY048u1fd9p0kCKK5
	KYHe2JUKFb+Ruosp9MZWmrljvV+Q==
X-Received: by 2002:a05:620a:4506:b0:8c7:1316:b0eb with SMTP id af79cd13be357-8cbc8c46b0bmr1350791185a.8.1772428554371;
        Sun, 01 Mar 2026 21:15:54 -0800 (PST)
Received: from [127.0.0.1] ([172.183.95.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf564c27sm1072746685a.0.2026.03.01.21.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:15:53 -0800 (PST)
Message-Id: <2369608976c6126bcf40c59974389a84394aab68.1772428548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
References: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
	<pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 05:15:44 +0000
Subject: [PATCH v6 2/6] repo: support category requests in repo info
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Teach repo info to accept category names (for example, layout)
and expand them to matching key.* entries in request order.

Explicit keys keep their existing behavior; unknown keys or
categories still report clear errors.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index e687d833b4..f614298199 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -96,6 +96,33 @@ static get_value_fn *get_value_fn_for_key(const char *key)
 	return found ? found->get_value : NULL;
 }
 
+static void print_field(enum output_format format, const char *key,
+			const char *value);
+
+static int print_category_fields(const char *category,
+				 struct repo_info *info,
+				 enum output_format format,
+				 struct strbuf *valbuf)
+{
+	int found = 0;
+	size_t category_len = strlen(category);
+
+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
+		const struct field *field = &repo_info_fields[i];
+
+		if (!starts_with(field->key, category) ||
+		    field->key[category_len] != '.')
+			continue;
+
+		strbuf_reset(valbuf);
+		field->get_value(info, valbuf);
+		print_field(format, field->key, valbuf->buf);
+		found = 1;
+	}
+
+	return found;
+}
+
 static void print_field(enum output_format format, const char *key,
 			const char *value)
 {
@@ -126,14 +153,15 @@ static int print_fields(int argc, const char **argv,
 
 		get_value = get_value_fn_for_key(key);
 
-		if (!get_value) {
-			ret = error(_("key '%s' not found"), key);
+		if (get_value) {
+			strbuf_reset(&valbuf);
+			get_value(info, &valbuf);
+			print_field(format, key, valbuf.buf);
 			continue;
 		}
 
-		strbuf_reset(&valbuf);
-		get_value(info, &valbuf);
-		print_field(format, key, valbuf.buf);
+		if (!print_category_fields(key, info, format, &valbuf))
+			ret = error(_("key '%s' not found"), key);
 	}
 
 	strbuf_release(&valbuf);
-- 
gitgitgadget

