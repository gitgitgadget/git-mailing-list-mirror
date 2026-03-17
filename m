Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C252121018A
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707366; cv=none; b=Cku8mJUzNrmwgP7dM1PVd0+J8xuQMbdIDDGqfmMYMiDJ9O6JSX4EQ4+/VXjQY6Ona/DcBOPorwREOJrhCg34BKRuvBmc9ovpjHo2hwjlR6IzyeUI56QcBRPa4C0/l7auptFDKjZgH5RqaFpwqwuTyykZxbQ/98/f0DMK1hEP2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707366; c=relaxed/simple;
	bh=F1rQY6lS1liAjY+9q77IEcOzLQyGsY3Qt/rpIVhG7as=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fqPFiSVFkbAti1oTowB6L7YRoTOJ4hiMQz87nFQc74BtMZYK3avbqX0TeQsW38UaXhXcOYqF2wnFM7VN20Dsc3KuDuQvNnHD/aLYK368wypsiv1B3pa56vmOFz5QySi3Qku3huLd9HoDUUu4eYWkD+g/Vzc1OnMOW4UzWopcUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKNZ5FFh; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKNZ5FFh"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso6179341eec.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 17:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773707364; x=1774312164; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+e0vbdqUVgzn4DIHrRVN1NYuT+wGbffhrIkYn6JMRM=;
        b=UKNZ5FFhSfhQGOBGJmJn5+e5DtOstU7PdDP04rUz59aASzx2n5qUt3+gQVf5w/Y1pj
         98kOXAg3nq+d4Ycc30gr84vUhKwGLGqlgOFzAbg024d+yO0s+vjuNZpAZDpXQtP7eiV3
         JOh4xSALCqrvNyMcfA9thiLyvngIAnKYHUVtjIOeUEMa8hz10fPv4JFB1xwqT3Js2CKu
         oxo8A4NSTTFPoteyUMTpFxI18ec28tlqA0yMzn/irvTTARbRtlwdi4quALEzzEYoUcNX
         NqflsHxIlthL+RlyY9GlE5eua02u3p92v9b81RtXbnNrgebg1fcR6odVPWh4CV/vzPpZ
         hMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773707364; x=1774312164;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V+e0vbdqUVgzn4DIHrRVN1NYuT+wGbffhrIkYn6JMRM=;
        b=AFEr9JDyAmGfwadzPB9wuvYKspWMj8Z6CId8I62gbYCRSzi4i/B49bEGQng+m23pmm
         46q1BYt8jOrePNloRtYKPUQ+D9XBuCYymLoqFBjby0PIEiNcYp2FO1maSmC/e3LcAJ99
         1i/OlbKTBv5pBrcR5/eVD0Fnls/w6OXONtf21xggQyMOlaGv2qNrt3OO0zdga+IhOEWP
         u6MSjXbErKajSu+fP1+I4s2O0xGHkPRTGF1Cc4MCYj2gg42/E5mMfLYXbLl3zxIgrWYl
         ukD3jn9PPw5wE7B4aL8vaXl2I7XOfaj/V8kwg16s3fmIMegZztGyzuvVSJqNPQUC64iY
         H21g==
X-Gm-Message-State: AOJu0YxR1sErxmvgmeNo4UWAEVc89RuJPdD9wRN1kGU3k+y97H77msBS
	lbzbMrHwVLJ54XNs/sdLgFYcTVPpCaD2Y6vThyCMVen5vIyA2byJvofPl7B5Vw==
X-Gm-Gg: ATEYQzwAhbk5m2sETo4pbEGSN/aks3YJaU18pM2IZwQlp3uAIayfSZh0jxbZc+s0CbK
	3O1+gmt5BbnC/o2yPTW6/Oq9U11cpn8DbL0WW+b2fqo1Op/Jqwvg6jEavX7oURkGBMNfeTWh5Iv
	5k9zkYw4xvid5Zh+9fRqbT8ANeFuwhsX91QFPxbQ9FbnTCKpM2DfGb7Bg/K3Lwoe+rAX/chtWsK
	xjKyL+fq0y05RieqyuaFsBDNjzbXwA2QDGtjC/b2AkGArBztMlND2lihfQ0iLgHBlsSCtRqZjfV
	vg0zM5VSmOcgKMICPmGu9dCkzxY5evhkw1boeL+2lrviB+V+aTyJZXfkp0uV19Idf1N1FsfIMXj
	uP/mDhnK8bs+L064s0lNt1UeIGuhNRncJGUJUtWMUNa9iHXAlhVOOAYn5WShJppC2YIFisn2t89
	xoEn6uTp6LdA2nX++PCOYYlq0A8g==
X-Received: by 2002:a05:693c:60c1:b0:2c0:bd37:a75a with SMTP id 5a478bee46e88-2c0bd37ae65mr2164222eec.1.1773707364308;
        Mon, 16 Mar 2026 17:29:24 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.136.171])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0bbe04304sm10099463eec.23.2026.03.16.17.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:29:23 -0700 (PDT)
Message-Id: <fda0239103f6e2b9e76403144b9ed2e9205e1c2a.1773707361.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 00:29:17 +0000
Subject: [PATCH 1/5] revision: include object-name.h
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
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The REV_INFO_INIT macro includes a use of the DEFAULT_ABBREV macro, which is
defined in object-name.h. Include it in revision.h so consumers of
REV_INFO_INIT do not need to include this hidden dependency.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 revision.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.h b/revision.h
index b36acfc2d9..18c9bbd822 100644
--- a/revision.h
+++ b/revision.h
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "grep.h"
 #include "notes.h"
+#include "object-name.h"
 #include "oidset.h"
 #include "pretty.h"
 #include "diff.h"
-- 
gitgitgadget

