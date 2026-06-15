Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3171137FF71
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512631; cv=none; b=ouXX4vn4+v6a7eH0rZ09NbXFFQ1xzD4n9iJn0PA+yzXTVuV2/bD9uOYztTkPFnsVJBWUDL6s4l5VEY/yj7cl7kouDcdlmn3s1hs5iQga1Qrg2NEnFXoEl7edGijWQwyPsth+d7jHERudKNYzlyjqEIe68UkzM4sTk9SO0av0ZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512631; c=relaxed/simple;
	bh=8UBEDtZf1orviEuUoz9qnZNjxwWtHgEwIvXr3XBTK3E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RuTdy1MFEkalSO9X+qwOeSBEpQcyvBKmbUD5t134TrU23pJjeVPHaqT3oSHDodeOhVF7qmNq/wS9fGCkmWjVP3wiwbQVUFuVJLTRnzhG85MOeYH6gddl6BE+CL5Gdgz0CSCxl16Cy68y5nECFxKhbsuA/Q4pnhDELhcl95zGfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/xgzptT; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/xgzptT"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9159477c893so366313585a.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781512628; x=1782117428; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdHm7w0zR4/ZoA+Phl7/TI4+ga2sfdV2Mgx1TEtU+y8=;
        b=q/xgzptTYz8SObFE7NEfRKTIxnQ8OTmplrpfLSgF7B/q+XAI3/xgkqg6AVsiAfVjPX
         MDS4FRuW3z9vcWnKzyozkD6Ef2QAhVqOKN4K4YQSmsrAaEPGSos+2idzkaAXM0GzJSV1
         4RfetGoc43kUFOsdjvznqJicpcC+N+gyaE00SleO6dKC9GPPEthE9NGaUxjL4cQVcEbh
         z2hwYm+ZO2scD+8VKUWeRhV7mpyRr1XO95MWbw7FpJ3Tr+ZG/LNwV8sivWtCpyIjcuBu
         YwEavGm6h+5cnDe8hjMPkhey4Ff+Ar1pOfJQohFY/WAPMzNlNrExXoevNqczY/270dJk
         hFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781512628; x=1782117428;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XdHm7w0zR4/ZoA+Phl7/TI4+ga2sfdV2Mgx1TEtU+y8=;
        b=Zcew4rZRTbgMpuEoyWAWBEkgnDAKoz9lU5PB8+b2PlcnuDSyj3PDRO4GxlgViyqXwE
         FS2qqZhyTs2qJ3bX5PXdrBY/92AordGXl1TiKBTF1KgUDqHlH4FGU+6QzVDee5bAgztF
         9qoDmRi8SB7BeszXdWG4s8WzsquS2SVrBmU51Fq6tm6d/FCY51781GI++sGt+GHD2aHf
         2K3z8M0s+Y+ltDpAkMLvmjrerBNOyv4cRhw84K6w3ezUGTrdcwsHqYm+J7FixlE58i5V
         Dd5+KPW/oNi4p1jBwxZZQKfne6mLY+EUwzIJwU8EgUm9YnX8XU9phaRt7/6sK7990dFa
         +VdA==
X-Gm-Message-State: AOJu0YzuWZjP1BRah/cA8nQsu8BLFF4J7sDpuIfBpHLdgbniQqTZbfH8
	UYTZuQnyTvCgmJvbLtD77LjXtoljrGQM/DTzUDaNeYGMvhNUkEoYv7jU6n0mXw==
X-Gm-Gg: Acq92OFBFptkETyUpvK1MSiqCFpLiRZd0h8cl3mCYNbKlhRUh+rQkl7RY6TqkTx6/nC
	Ds5mrcchOkouw8K0d0yR5UaI3Kdshn18VvC9G4AU4uX0aSCs5pUYAGIOE/wFMsiAV4vGCiarIwY
	5N0zEtfvpz+A3xvmrqoSUXrcRUmMZTIO2eoVp+1VeA40AcSJql9ni1j851ea8Uivy596nMZUsNg
	CZ0JTIPG/QtP3sT9jqYdatffzpTa9cu8qcWqX3Mq80HfwBe5RDSi7S1aroCwV8b1872slEJbks5
	yfMGkxWDkKIADitQVUJcWBP7KmF4GtXDxiGxnxrHrcjoT9fWVYM1fgFK1lu6m5cUIgIcO6IMNMn
	apXihMQ3bThPTQCZ024BwyvAPFMIAMqPdakp7ZtTQ2gqoUOK26/yLNV6TqeCY1UX0NhK9oJX5tA
	WUFhTiepdZzHvAO3YRI4NDaI9I6Wnn
X-Received: by 2002:a05:620a:400e:b0:915:b852:4361 with SMTP id af79cd13be357-9161bc0b6cemr2213421485a.20.1781512627705;
        Mon, 15 Jun 2026 01:37:07 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.157.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a0541d3sm1047970985a.39.2026.06.15.01.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:37:07 -0700 (PDT)
Message-Id: <c55b9cd6f749bf1470dba46e6bfea4c0472d3490.1781512625.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 08:37:04 +0000
Subject: [PATCH v2 1/2] t3415: remove prepare-commit-msg hook after use
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The "pick and fixup respect commit.cleanup" test left its
prepare-commit-msg hook in place, leaking it into later tests. Remove it
with test_when_finished.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 t/t3415-rebase-autosquash.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 5033411a43..8964d1cc88 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -490,6 +490,7 @@ test_expect_success 'pick and fixup respect commit.cleanup' '
 	git reset --hard base &&
 	test_commit --no-tag "fixup! second commit" file1 fixup &&
 	test_commit something &&
+	test_when_finished "rm -f .git/hooks/prepare-commit-msg" &&
 	write_script .git/hooks/prepare-commit-msg <<-\EOF &&
 	printf "\n# Prepared\n" >> "$1"
 	EOF
-- 
gitgitgadget

