Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC133822A3
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784362532; cv=none; b=V69d46/xy+tF19Gv/NUKq0lVIpvlmT59tfDxJr5udt3Nd7Qzj7Up5yELpomneLIub+oZ2i6PODHmbfS5c7oXMxNfMv5M97HiFXLLwvq5O5EL462T69bv/QQI5aTWG8NnjkPrVGR8kBY3Fv7tSWyxnHJBQ8mLHV4rJ2bNfE3RtHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784362532; c=relaxed/simple;
	bh=z04NoBm2aMAs+x2ZS+yto/sgHJhcHh5x6b5VAzaKRC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fk+0rbJGh0lb9JSfxkpHFF1N0uo2Orna0nP0QXuIp1gUdNw+JsigqDKGuWALBeTjlepGceRtaf3JokLpvPzxbTNAmSJPtjMsMxTuv4fMPR0/4CSOgZUlIluSoPmLBCQTa4qlc7XgLKELJKhci6pkEtLA7rKpUvmjO4LPsjV38o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAG/yPyk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAG/yPyk"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-caf707e3a70so1406502a12.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 01:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784362527; x=1784967327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5aVVCOxIumcQc9fx8QZlzndWDO9gn7zuNtUIBwDoKGE=;
        b=KAG/yPykSb/VBs73uMONc+cSxy/IO8PL6GBcJAH9FpIJby0puHmx6AQz7qHEcrpQMs
         8QqJh2Bgn3+CSDEOmknMDIAFEnslFoGjx69fVFLKI8lZCFU2TsInQ/S9Eq3cMADAuLkz
         IOSF71+qoA+KfUD8GQ9lRehd1Jr8+t20VRTEK68bGc0tlCLEfHYENOav89QzMqSuud4U
         SLYq45Iv2ZtFP6E9L8KyPFPaMt8AJEL4KNShllD7TEqXp0NvHYQS+J7NEtoIpTLetZC4
         DpVuo4v4OrYW0PyuESAqQkYOBTjU7TGeNHCsTC1K7tk6aQwq4IIZ1a0w0xV57/2Tn3ar
         p4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784362527; x=1784967327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5aVVCOxIumcQc9fx8QZlzndWDO9gn7zuNtUIBwDoKGE=;
        b=j3v/G5cyxRv0ftnJuYcC95DwD8HI0Cu+pi8KabYA08zX7wAGujatreIscnWlqORSgB
         kKiPggylPnoFFPmw/DjURFezVfoUiMrRD9JCRaZSKlmL5e/4YGR9kA5kfElVB79kQhZ4
         Ql198MM0NI1d7KtDGygHTKP1Hj7kgxwJ+R+WJt+D3Gdf+5zsLjEDNNM2O0bnnOtl5yTa
         F6muinJOoUfdsM/7aRUTVHIcvhN8vJr6xTutjaPiK4HVyHfSDBHy460NPizjX4+Sms31
         ee0/xwgqn8f6xY8biUnU17U5RAwq7rx9TSd7+7VSVnGFIK5SK2Vr0bKiAnNoZcbyI949
         G6OQ==
X-Gm-Message-State: AOJu0YxNVZw63FENdaz4L+DxSO0nNjjj3TyzyYqOg3yBRn7+DldjTsqt
	5/Pk5OALI5VWqu71dpRQqAX66eVsOMDew/aEwoXetsCqfA6z5OJJyoKNEycsnvem
X-Gm-Gg: AfdE7cleKZYcwLeCO5xWndg3Xf3rS9S6XEguH2DJ56+WoJF7C7Af1PZ8tJeQNWfc4mo
	fRyzvTRkdZSdf/kkaguuG+1AOZ6ZrssdCCKDZlELPn6d9WuDabBNt6holRFxkvooTxRGBaS8mh7
	3XDSC1q+ruIWoSfHGLmI5zpgwwXrQ6HVLC3ds054BKRPKF4PcJOUXMwI0++E/Sl40Z7Gxa48+4I
	qZxEeO6aVDEtYcE1xCJZgIpDnv8tnnktEq7gvd3M2MFcRTKIyamOuo+iQoUoERpnqsmFUhuieT2
	Gmbn4g7rH0N+H4oRn0eJQZ2Kt4ckolEJ7aOrNh8H5wtZ0/GXKpVD3J9VUznunIjsYrMROFwW6iS
	wAYP+fmgZft4Wzt1cvQxz50yPJj6/oBeSn7KrL1/rcdycIX70TzHms9fUOpZWb7+LY8t/mg5t+y
	g5asQumiJDmLG06/vyHZJ5aA/o31E=
X-Received: by 2002:a05:6a21:6197:b0:3a0:c246:bb98 with SMTP id adf61e73a8af0-3c38dbbd1d3mr10180720637.29.1784362527304;
        Sat, 18 Jul 2026 01:15:27 -0700 (PDT)
Received: from sahitya-07.tail6abcb.ts.net ([2401:4900:8fba:f9ce:4201:ec66:99f2:ce40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1de301sm14831922eec.24.2026.07.18.01.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 01:15:26 -0700 (PDT)
From: Sahitya Chandra <sahityajb@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	avarab@gmail.com,
	stolee@gmail.com,
	peff@peff.net,
	ps@pks.im,
	Sahitya Chandra <sahityajb@gmail.com>
Subject: [PATCH v3] wt-status: avoid repeated insertion for untracked paths
Date: Sat, 18 Jul 2026 13:44:49 +0530
Message-ID: <20260718081449.26747-1-sahityajb@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717144620.259031-1-sahityajb@gmail.com>
References: <20260717144620.259031-1-sahityajb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wt_status_collect_untracked() copies entries from dir.entries and
dir.ignored into string_lists using string_list_insert(). At first glance
this seems quadratic, because inserting into the sorted list may shift the
backing array, incurring O(n) work for each insert.

In practice, though, the entries in the dir struct are already sorted, so
we should not have to shift the array and only pay the O(log n) lookup cost
for each insertion. But this is subtle and depends on the behavior of
fill_directory().

Collect the entries with string_list_append() instead, then sort and
deduplicate each list once with string_list_sort_u(). This preserves the
sorted, duplicate-free result while making the collection strategy explicit.

Signed-off-by: Sahitya Chandra <sahityajb@gmail.com>
---
Changes since v2:
- Reword the commit message to explain the quadratic concern while noting
  that the current sorted input avoids array shifts in practice.

 wt-status.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 58461e02f8..57772c7501 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -832,14 +832,16 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		if (index_name_is_other(istate, ent->name, ent->len))
-			string_list_insert(&s->untracked, ent->name);
+			string_list_append(&s->untracked, ent->name);
 	}
+	string_list_sort_u(&s->untracked, 0);
 
 	for (i = 0; i < dir.ignored_nr; i++) {
 		struct dir_entry *ent = dir.ignored[i];
 		if (index_name_is_other(istate, ent->name, ent->len))
-			string_list_insert(&s->ignored, ent->name);
+			string_list_append(&s->ignored, ent->name);
 	}
+	string_list_sort_u(&s->ignored, 0);
 
 	dir_clear(&dir);
 

base-commit: 41365c2a9ba347870b80881c0d67454edd22fd49
-- 
2.43.0
