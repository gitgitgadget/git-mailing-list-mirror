Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1933BBC0
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660860; cv=none; b=llkFD/eHU/4LJGPzcSeQ/+bY0lczH5gNvx5uaEmRAAuXc/Nsy/LF+lDg+3awSAPpdHnNdh85ylIaNn8rvn/GzDSXnSDgz0o2dyfx9JQgAzWq7NrjTtrITTj7X0drPuMDLLBvJeIJhgDb23liBxQTJclJuPQK55kGSbXDU7+nUDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660860; c=relaxed/simple;
	bh=vfU3ZytEqqIQKwUsRsmVAm79/uoonrURH3hYtq0g8fU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hIHQ9AUGcFsfvb7M1dOjpaDaHpQyv7BwPPEJNuFriV9NfjXeNp6E9V3Pg+VTHpfBB/W9sLAqUspje0F2UhD9l/swwfarrZupzmP/6gVvwTvpXNjZn6iQo3KcBudSdcZZYAhSkzmprocgdUQonhr1Bk4hBGrdftUkhfwx3RcjS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=YK1lTHwx; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="YK1lTHwx"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-347327e3aeaso1887532eec.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 22:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1790660858; x=1791265658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cx1TbuXucUNUDl7cz1jxXv1gZ2Bzqw6DdFkLrKl2MnY=;
        b=YK1lTHwxV2mnxCx1rhBcLDhZWXIz58oDJq1jLfMeCntAGx24EOQQ4KeIuQ9mPE9+Yi
         DxGusY93tqB7cnDN5fbrAjnRqJpP8Nw51z1YQchbAG4zG4sDACyTTvokHHpFj8/e+Ay8
         hdk1meO1VjzHcGEuv60K92RMf8nuR0uqW5ijjENzS5l9HoZEMa1SYs4SBkHLuxFw5Wvp
         IBItLuizVCI4u/PZwndaDUCmu9YBSN+HB74f7FU6wIneNZCKQDuw4yiyrBN7G93UK39y
         BFB82s3wiOEsF89Z+TF2el2LuGicNgYSDh4vm3oBTAB9Bjl9DWlalikefBJD2De0pQtK
         PPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790660858; x=1791265658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cx1TbuXucUNUDl7cz1jxXv1gZ2Bzqw6DdFkLrKl2MnY=;
        b=cRH1ZXs6qfpvnF/PuzouxzvUcPnGva1g7edxZmkHULb1lRt/QsTcrvWp2nIohDuS4S
         8MeAEs4TrEYr3Qaik784pELizgEmzaRJxUl30gsJ6MjwlNz1t5hyGiBZqoNt+peH9XyH
         R7saE73J5z6qr+k7/Hkhj/iil6HZjk8ymyeGXD3oSrVRb5mt2qgAlJZA/vbhdKf4V0mG
         PYZbNylt7DhT/3XZUKTrVckwS4kXRU8U1Hf5WbdJKeNS+Rufia//a4LONsnl9D2UaVyk
         4fLfAYlsXD9KhxKzMSHNc4zGG8tgpBQEcIuDeercsft+cZAJwh7JQKOgMieAmJOijpwf
         8Dxg==
X-Gm-Message-State: AFuF++m6ecLZr8xo2xo1dGUAvUB5nClmzXq2YXq9e5w73IfWPRyuQBhh
	CODdogOoPwJrbs17TuiWkRkQ/YPZB5awY66qEb9q4vpsRkGq3oQa8FROrKSSdkXvnEa46VIIoq/
	wHgFV
X-Gm-Gg: AYBFou2uXkXkTB+njVLcojIjrVr8SyTkMP0qXtRUNYCVnohT8iu82vzzbKypPTAP1MN
	Pq2oN18G7giYop2084Zuh3FZXPOCT0g55hjdseHli/0ZAZjbAbxSDTVUW7c4G/dE84JYMkyHZIU
	M2gTxVni+JoiAoEJ7s6yw3GLgMcE+ng/wV0tBOMGVwAjbR7nbFWDnnMwMUqvLtRMRz+oo1m7tYj
	oEWOgsZkxi771qXt2QxNFSzH38Bo4a1Z+rVIbtIjRH1FrZQsYpnOIV4L3kdj5luaRqI5E5b6N7v
	nWEz+SYzi7s0SgZzwCmTl1MtjirnyleBXRTDPx0vsC9Ni8zkmVlHF0kNBEj5sVxC7NG4XAWDArj
	wQeJdT4R7phwILn7/CSrPd5PNxgHr4nX9Cl0go2dhBJdJyEUfYcGDszf0euRFl0zxLNaf0LbW20
	0OMKlarZBPSZ4omea8j+DZu342lJsRpgZ0dnuCk4lVQEVXgKxXsTTYsRr2EiNLJfz7nExrzDgaO
	5OlN5aM4Mi3nyMPcg4s/muyXDsC/llBb4kmifQ=
X-Received: by 2002:a05:701b:2301:b0:144:eb46:c3f with SMTP id a92af1059eb24-146ce67ee2fmr14422648c88.2.1790660858318;
        Mon, 28 Sep 2026 22:47:38 -0700 (PDT)
Received: from brighamcampbell.com ([73.3.69.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-147913a776fsm26744289c88.17.2026.09.28.22.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 22:47:37 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Mon, 28 Sep 2026 23:47:13 -0600
Subject: [PATCH v5 2/2] git-contacts: add stdin functionality to docs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-git-contacts-stdin-v5-2-e9becaebc47e@brighamcampbell.com>
References: <20260928-git-contacts-stdin-v5-0-e9becaebc47e@brighamcampbell.com>
In-Reply-To: <20260928-git-contacts-stdin-v5-0-e9becaebc47e@brighamcampbell.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Brigham Campbell <me@brighamcampbell.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=vfU3ZytEqqIQKwUsRsmVAm79/uoonrURH3hYtq0g8fU=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ9bugI/Xdu9gO1dmuHj5SYMLW/f3/TDvn7pF17H7TjWLU
 smdrIsnO0pZGMS4GGTFFFlUbs1SvzjZ+tHBCP4JMHNYmUCGMHBxCsBEJr9mZOhQVnJdHc17UcZ4
 n6+hmQdn6pybzLWlPd/FBezOfD17dx3DH85IgddLHv84PXFL56c9EXvu9jfsbfxyrlTPx+CdzBm
 mbC4A
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

git-contacts now accepts patches via stdin. Optionally, multiple patches
may be concatenated before piping the result into git-contacts.
Document this feature.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 contrib/contacts/git-contacts.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/contacts/git-contacts.adoc b/contrib/contacts/git-contacts.adoc
index dd914d1261..4e0b518aae 100644
--- a/contrib/contacts/git-contacts.adoc
+++ b/contrib/contacts/git-contacts.adoc
@@ -24,7 +24,8 @@ Input consists of one or more patch files or revision arguments.  A revision
 argument can be a range or a single `<rev>` which is interpreted as
 `<rev>..HEAD`, thus the same revision arguments are accepted as for
 linkgit:git-format-patch[1]. Patch files and revision arguments can be combined
-in the same invocation.
+in the same invocation.  A single dash `'-'` character in place of a `<patch>`
+tells the command to read patch file(s) from the standard input.
 
 This command can be useful for determining the list of people with whom to
 discuss proposed changes, or for finding the list of recipients to Cc: when

-- 
2.55.0

