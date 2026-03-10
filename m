Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365CE39DBD2
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149702; cv=none; b=EL5el7QZfPjh+t4HZvFDJ6EEpgIfpUQ5pucUnWCaPjLDvN9/Ms1WWPu5P3TNXtz36I09XMbauAHxeYWy3cj4PYCT9udoBVb2Jq/ZsCHSXGTWYBJh0w7UmSUShyu1yBPkJAi+UC0DqzOpnSPDzr33v0ymrAaQdS58sOu9HmtjQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149702; c=relaxed/simple;
	bh=8d1Rtm241vlGEXyFu9r2k5SKidIuYmADYJggHtg8nLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYWBpIPIb9QGmmoqA9gG8tL1Sx3Fsp1AEtIoZQAo5D8OpVH8Mpjwh6vUqeOdPX4g4I1Xa2AZRZYV+01akgoGI2axRqfbhRNO6dTRzdFUKWeNGBFCZZyXcmFk6u8AL7nfPdnVCFpfJ+0o3suHcKUZOTOc5HGP48O60kI+wE5h4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ce5Msu1R; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce5Msu1R"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae505619baso56695225ad.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 06:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773149700; x=1773754500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q49lZQ6U3vqCaT9BK21E/DcIBk4wFgK+mLHTUtTwDZE=;
        b=Ce5Msu1RwwNJ8+7wvCWxmEhqToxqE7s4oD+LnBeYd/NvDV5N89g9e7nDKBlrKgnGwf
         1YQLDgCcqBa+Zdv/3iLMXwy9wVvv9URgZxay7Q9GS0CXi0UC9eCtElT6lpbjizZmkVn9
         LJAYe7QBBVPNNABCmEkQzGyggI/WW9+mhdXUiXKstsHjVWbzn9y1iaHPg4+rGMas/Aci
         Zpc+XGqi6f4ogz+Of1il66kkOQFTVw/FPVrCDAqU9/u5I6tToLNaBHUwvL4E8FDab05M
         LxMLEqgYNMsQiJsA6qSd9heS0rhInvMEiEnwl/SuvvXP6RN8EMvLvn2XMPGZh194Ab/S
         TGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149700; x=1773754500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q49lZQ6U3vqCaT9BK21E/DcIBk4wFgK+mLHTUtTwDZE=;
        b=dtbzQncxn44LGokol1mC8UEBnZ2WGlkaNbIRidMN4xteO7vKnXU98TBaNKNp/2B/bb
         3Ros4YlKW4/P7Jkhh/idkbcUL72Dj1mmDNz+NmIoJjz/tDsG7n6tBkoNf4tJoywZd/TD
         n9mz8PJcgaA0CJcQBU8V6+YnD79L3u0wKjszoQZH0eodMQbu43NFks6ROZYm3fpsxTfP
         BKcdeg9UivVXJj1io/sS4dSrxc0kVEbdD69H1PVFOZRxubb8CwzU9PaqJVhz+Puh3K2b
         tqkZ0+SGr+rz/DiUl2p8EDXvD0Fcf1R9/4mg1AhVTxlrK6mXN+T3eWGHQPyKOcfZ/9Qa
         heZA==
X-Gm-Message-State: AOJu0Yy1AAiJiqsKXzcyzc5CJXJ8AXJTbjRd/B+nmUSWseA99sd/m6d6
	UKVR679K7cbN5+982Y+dxTryovJ5oNaLs39gP+NBCm3o8FMvvwlf7nmB
X-Gm-Gg: ATEYQzysaPzHliMJFYsk04ECEhWH1dVYPtEI82GEzphF06RZaAjfNoXf5vMtRh1BmVh
	7kSaP4mI+5yh79CVDCXxOWSDeIq7RyegXWMdZogcl14G6bDlF3bijwta9dAoRFi5L0BPC7KDDkU
	3A3tSinKm77WnUmRtfhNhJ1YfWw0zojTyPxZZmx7CA/LlUILEJe1Tbp8Hrdnvf55N9Li5u/RYwj
	4jxl0pdmvl5D9ZQHAkZFsT/7LGKfF1Kn3MqBpA4usYOzPOVycQFB7tP3PvYVKS5016rv3eslRaJ
	qrBgeVTPdZrwLh4vAbRv3dS7yrNQhMyOvld2uqaIQyXp8Ky8C5IeBCi/2hQTe1yRBKs93+mHx0i
	sjV2ecdxW4O41PuCMXouYu2yFXRzQvnK9vTeHP2edHwA57wXRWnoy6ZCqBdwb9wMRsoxrE6ti5Y
	NAcjz3ZR8qjDFzXNoeJerw9NiNNhKirtDFffncE9gZJrPTQWbHtzse1bdPoKrbSTJpeyKtacSyC
	TFW3KADzn11eV7hG0UsxEnSvR6KDULr
X-Received: by 2002:a17:902:ea02:b0:2aa:e387:b83b with SMTP id d9443c01a7336-2ae825006femr144136295ad.43.1773149700419;
        Tue, 10 Mar 2026 06:35:00 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9b9c6sm173315835ad.29.2026.03.10.06.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:34:59 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	mansimaanu8627@gmail.com
Subject: Re: [PATCH] t1900: add tests for git repo structure subcommand
Date: Tue, 10 Mar 2026 19:04:35 +0530
Message-ID: <20260310133435.42995-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <pull.2066.git.1773112159662.gitgitgadget@gmail.com>
References: <pull.2066.git.1773112159662.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: Mansi Singh <mansimaanu8627@gmail.com>
> 
> The t1900 test file covers git repo info thoroughly but has
> no tests for the git repo structure subcommand. Add basic
> tests to verify that:
> 
> - git repo structure succeeds and produces no stderr output
> - git repo structure --format=keyvalue outputs expected keys
> - git repo structure --format=nul succeeds
> - git repo structure rejects an unknown format
> 
> Signed-off-by: Mansi Singh <mansimaanu8627@gmail.com>
> ---
>     t1900: add tests for git repo structure subcommand
> 
>     Add tests for the git repo structure subcommand in t1900-repo-info.sh.
>     The tests verify that git repo structure outputs the expected fields
>     (commits, trees, blobs, tags) in both default and key-value formats.
> 
>     Signed-off-by: Mansi Singh mansimaanu8627@gmail.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2066%2FMansiSingh17%2Frepo-add-structure-tests-v3-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2066/MansiSingh17/repo-add-structure-tests-v3-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2066
> 
>  t/t1900-repo-info.sh | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 


Hi,

The very next file in t/
i.e t1901.. is about repo structure

You might wanna check that out
because I find most of these to be redundant

Regards
- Jayatheerth
