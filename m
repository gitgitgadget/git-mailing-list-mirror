Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6E9285041
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771187021; cv=none; b=guLA/TUtti6YDk5JHW46rTywJi4BZXtRNJ7S0F1Gc0SkK3bDe/YTbz3WIe2kpKJrvzog1gzWY1ywxpS6aPObNFLnTetd7mMhdodyhAQsKhyC6BlEGfnjZoKH9rEeYk8ygZ0s0KQ+MdkfAo0Y4k8sQZ3Pi0lN0EktWr8+qFf1JsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771187021; c=relaxed/simple;
	bh=Dws17k26KGAr85CLdnsRSuagwr3FIgrtMwX4Rg8DbOs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f8A/A8oN9dLDU3+sJsIdKmhDZbEoIoyMimvpKVyL/DcWupwT8iLZGuXsthOk9QOHsD4+8khtcumqAlNAP9H8meWduM7QI04mzN7Z4vO6LEa3Pmzpv4/4g0VUFoPUJ25f2g4N4ZoNS0hmQt6H5DK+i/2FUfXp+YoRX4g4K1xyI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/sQHXoJ; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/sQHXoJ"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-126ea4e9694so6896367c88.1
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 12:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771187019; x=1771791819; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vzua+15CwnwT15xjjXTtuTeuIDwUNy2mtjO+sHF4H/0=;
        b=f/sQHXoJxUIvcN9L8ABLnrdrofyhsvJDne6Ow6c0WlI36rXUTE3H/+Z99EsqFFKILl
         PziN0ixOes2xPAbq64QK6mfk3Wk3IM/nKVfOL1Pg2kMSfyiRNbayg186vNZhlL9ebF6d
         9yIPI3gTZ5C2bzX3tIxU8m9V6/DzWWv+68JyaiA2zxlc6sKzC4WEdFoPclKGlbBp+8Rl
         +F+68iNlQBj6rQQstuX7rbbKwotWMlHd18aY+SR/mmLrPtr9R1IDlIxAED2wp8w3NCx4
         QYAXxgjE5IHvnDh4Y81Fw/vSzbJUzeTL/3ofZf8UUBmEA9+BLAE+mBmAMm43YMKMCr5g
         WawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771187019; x=1771791819;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vzua+15CwnwT15xjjXTtuTeuIDwUNy2mtjO+sHF4H/0=;
        b=nY2NTRZcJXs28lIrxlQii2Ggzqbo9rSnXLFDlJXGIJ6UidNPMdZ4pVJOq3h1pHSbku
         /OGzmNZ3JemNM+COurpanyQLsoTU3A7nsc1dCz66lTmJwfpPuzdNk8+CdD2WLxC1dTDP
         TsJNA0Tm8SqD3ZG1i9tBIWiZE1qQpC2ETM2qAyrXUrF4chD7ih95g/VwfST3z6asRIsh
         8ly5u9dY6cRNmX7ffNx3peoLBKJQ6ym9AKs8hhmO+Y5naifrJtIQ3uHsQ33CiV57VLR8
         8/PZRMke3eeTv/luPvK2rnbbT1P520TaWlTD5g/v2PUrMwqIOg1dQJpUUwY6c3HuTRyc
         altw==
X-Gm-Message-State: AOJu0Yyp2wWGctwgtAdvckRNdOFga6yMfEQFHU2NhzCjLNBAfm3Q40Qp
	BscggdtkpcOdFuAUm+mnfOMXoFUglSQRGCuU2xP5zeAseOAZmCacHYaNAwJWPA==
X-Gm-Gg: AZuq6aLPOM1g8bQuX4Mju7c/FdM6JjhpNLWbJmxDs5WOxZw8dQq8biRv8oUB6wDAWFo
	p99JJ1IZaPjxAnQR3vHlpQbicbvlqtsYVKqozAXSsJMMazxnPtHJ51S0z6bVc1n++MkN25kHtbA
	cUXZ6ifovnIC67vYqw8rtG5w6ygLWqeoCKEc6lluJdxFuDDo3NsCxFW0yMq265DUJjHOfOHlJ3Q
	emfumTlx0x2kE1OVii7KjiDw/30th2Oar97eaa6ftaRUCCN92bm7OnZEaLIwIMYL/ygX5N9jIrE
	J41QkJGOBRwoihoXv9/cfoiGN9J+ysRsqX9uOFCx4qlNFCiowUlEgwXUdckpOaWHQM0T9Z+KmaU
	aSndhDVpVStaUGomHEb+FWuqmW16crzkcHfV5FSltFMgkS//n5CcGaOzwTwwDhfkq6GvcpcrST9
	TkzxADSrSOI3N2etRaEO0hXRn5Yds=
X-Received: by 2002:a05:7022:f91:b0:123:2dd0:10bc with SMTP id a92af1059eb24-1273adb383dmr3399565c88.10.1771187018825;
        Sun, 15 Feb 2026 12:23:38 -0800 (PST)
Received: from [127.0.0.1] ([172.182.226.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742b62455sm7971635c88.1.2026.02.15.12.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 12:23:38 -0800 (PST)
Message-Id: <3ef70fe673170925ccf2901a625fb458837e9fcf.1771187016.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com>
References: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com>
From: "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Feb 2026 20:23:35 +0000
Subject: [PATCH 1/2] fetch: add a test for --force flag
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
Cc: Orgad Shaneh <orgads@gmail.com>,
    Orgad Shaneh <orgad.shaneh@audiocodes.com>

From: Orgad Shaneh <orgad.shaneh@audiocodes.com>

There are two ways to force-fetch tags that have changed: either by
specifying an explicit forced ref (+refs/tags/*:refs/tags/*), or by
using --force.

The first approach was already tested, but the second was not. This
has now been addressed.

Signed-off-by: Orgad Shaneh <orgad.shaneh@audiocodes.com>
---
 t/t5516-fetch-push.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 29e2f17608..31df7faf56 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1105,7 +1105,10 @@ test_force_fetch_tag () {
 			git commit -m 'file1' &&
 			git tag $tag_args testTag &&
 			test_must_fail git -C ../child1 fetch origin tag testTag &&
-			git -C ../child1 fetch origin '+refs/tags/*:refs/tags/*'
+			git -C ../child1 fetch origin '+refs/tags/*:refs/tags/*' &&
+			git tag $tag_args testTag HEAD^ &&
+			test_must_fail git -C ../child1 fetch origin tag testTag &&
+			git -C ../child1 fetch --force origin tag testTag
 		)
 	"
 }
-- 
gitgitgadget

