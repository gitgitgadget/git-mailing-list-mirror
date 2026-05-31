Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1508A35DA5B
	for <git@vger.kernel.org>; Sun, 31 May 2026 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268591; cv=none; b=LM7kfD+S9o+DB32sh0AQLUg3z2s+9WyO/XWmVyO8ysdOeT9hukT0psNZKYRCIDyK0pjOzXhGchzgs03v/l98FZMj/3Zx/tjne4/p0DkVoLYo6sYC4cBlXEflXqwGRqymyF/73p9szBG9k3m6Q39pzuC3kr6CUGsepV2Xpma6cek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268591; c=relaxed/simple;
	bh=d7PCywOrDJJAEU1QDYDbN+vSWfbSKDXoMrIe8DI+8aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFelLA7CZVEIefwLJih5Eyhz3CdRy2eLZjdYVnafsDm6uFa+E0Oc+4u+h+NKVbXsyFoMG2OGW5AFWKkMPT7L5fA3ZTFRuTl5LY73sFxVetZeVAmXw4qRuJoF8D8f8WZ60MCi9SGIbKuVHXJ6x5xKWrtLXFVqp+kcP5miHR1TEDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW+jSDNn; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW+jSDNn"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51758478240so447331cf.2
        for <git@vger.kernel.org>; Sun, 31 May 2026 16:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780268588; x=1780873388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ozsZ3fv5wpAh0UUIhhH4NIcah1l2yop1LVC+oUeZts=;
        b=UW+jSDNnCAEiMoN7qWy1YyqTr2qxE8DEu+scJUfwcg5LAw10BKbm+26yV9EhbP1t7M
         J5Im+4HZOzphuOphesP4v58dUfov3hCgzcnS5CulatMs4Fu30CB9to+a7E7vL2MZ7gWe
         yc1FQzqsuY2uPhNWftJmeRKuKal40TW3G6Lfjh/hwQXW/bouEZLx9pieo64Hi3gxWvFe
         VxrlTDgo7B1+FyoZpLjd9CesGEDF2Fc13FgH/wz1DNfbLnmf9Z02pDvuJaAymmzvNHUA
         yl55IUJdwkRVvkAXEgUwzC6SlD9Lke/dVWp4uBSG7PBuhs71fS9xpMpGQRoMJzC0xrFy
         eoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780268588; x=1780873388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ozsZ3fv5wpAh0UUIhhH4NIcah1l2yop1LVC+oUeZts=;
        b=Ib49POuSd9Vi/KlG/kc0C0fO8VJCnwf+JtqKTJx7zCw5tTVlUWPbDNt5uDzPXNYFl6
         CHYu6AqGqUw7uTEljioLZeA+GJc/zQzC5EBYbeftXsQAp0DIp9m5Qn85Dq2+55F2CAM8
         hfGbefxehOfTdd6qNHxjMbe1PB/zx6UHHMJgWxLm9K/yM/qr/3xLm5YSdmYctzygEixj
         RddAkFE0w0f9Szp/OjXI/H5lnZiLemi5Lk6xFXpADBoOpFQhTNct6lwUxcNYjvJT9jcN
         zVI2oeuyoWrpEjNAoLnmPLm8m/fUosQSzLjexCZlPcfFPlKyjbvzfsiv2TKAIr6psu1z
         rFkQ==
X-Gm-Message-State: AOJu0Yzv55XSG6mulnFohm7Cjl0El2GO/UrUDpDxvlnbbTAvI0lEULzR
	IfRYZ9CZ3tOCavz1RJW9Tj18QycX473Ldus/mUGuCzVau4OlqE1gTQV4gnFgp1cw
X-Gm-Gg: Acq92OFSEIieEGGLGg+kYvMjnUEl03dmLkmVAWsRjq5OcFkW5T7bCtaUTUW7X0VQR3/
	KPgIUefwwHwPqdQ5BRK1SVxmv63MMe/sUFOvQQ8DnGio6uVUMY7TT9tAMWzPWRwfbfOi4a9CebU
	iK0q2hfTWkH6nXSp6Xzec/wq0WeUtlRwGEAIWsOIZZ2Avz0ZhINIAFBMj5XbHV4xPgQbYDoKXVH
	g78qPYflBaJvN/rZko6+O+YhAniX1xV1IuP4HmYFwad0tobOdjec+4Nbr/wtGyu/pa+Z1hAhNMa
	BOBrFYTlMFQP2DlzANwz44ZkQu/qCUYg11Ny42qi8GXiNdTSDyHck9q7XteSp2JopOsQdSkbxAo
	Qc/Bl6X/ByGUvlxy4HMp1ualHs8HaxhlW3EDcHfg9kv0xgonYMmZF3enpV2VmXYQm6batfhAmx6
	ohfNi3Tcar9oZ0YVtdE0VJ5nu9kirqBhPsDIbx
X-Received: by 2002:a05:622a:8d11:b0:50d:97e8:939b with SMTP id d75a77b69052e-5173a7fde61mr120806511cf.36.1780268588106;
        Sun, 31 May 2026 16:03:08 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm78268426d6.8.2026.05.31.16.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:03:07 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v3 10/12] git-gui: allow specifying path '.' to the browser
Date: Sun, 31 May 2026 19:02:23 -0400
Message-ID: <20260531230225.126817-11-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260531230225.126817-1-mlevedahl@gmail.com>
References: <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260531230225.126817-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invoking "git-gui browser rev ." should show the file browser for the
commitish rev, starting at the current directory. When the current
directory is the working tree root, this errors out in normalize_relpath
because the '.' is removed, yielding an empty list as argument to [file
join ...]. git ls-tree (underlying the browser) accepts '.', so use that
as the value when in the root.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index f48d929da8..16d6b3051a 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2993,7 +2993,11 @@ proc normalize_relpath {path} {
 		}
 		lappend elements $item
 	}
-	return [eval file join $elements]
+	if {$elements ne {}} {
+		return [eval file join $elements]
+	} else {
+		return {.}
+	}
 }
 
 # -- Not a normal commit type invocation?  Do that instead!
-- 
2.54.0.99.14

