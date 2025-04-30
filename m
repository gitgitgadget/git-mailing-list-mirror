Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439E1DFDA5
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039210; cv=none; b=rb+uQYbVpE6xW3XMjoAJPHXOEiBP4V4l59gabX9L4LHHF+B0hpt9BCLYDwj/t6p78NdUi7reuAF3qL3t0U4Nc00IKbTb7IgWs2rZDHVooAEZoqfndD8n9J/c1/RhckhdMQT4M7JhoUtPKwGfrwMoikcmfM8eYBxkdXUfKxbKVLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039210; c=relaxed/simple;
	bh=SxX+EqHzFZOKL8vsJvvJIOqPSdKOgXHDqFqJemOobhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8IZspEPl9vbi2q58UvUYMLUstLSmBIHJ1KE728uhCif1VzFX390p1Y0Svqx+FTSfbh/vv3ZVvgLnvhu/CQ4ghgG0i+SgwE72VQVx5W7wuhjEQc4pDglBAFCdVY8XN0hWPhaaNpmJnX/oeQQDj3sYVSDfzB9sPKf10TSfsGEyu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO9RmJ4L; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO9RmJ4L"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-225df540edcso15102775ad.0
        for <git@vger.kernel.org>; Wed, 30 Apr 2025 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746039209; x=1746644009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j563LolDk6lts4W0nJp0nldD5kQODfpG6rdVSrlTgcY=;
        b=dO9RmJ4LYwMt9BAfDsigh7iBfVrKJpiJiT5pDu80CyV9Z6qYWLMb+Q7JSwFlQhWBcu
         cljnX/JxAMg7/prtRObPSXOuKu6BabPs920yWwGrIgpYY9b9tCiUoAS9D9ZdmqZHmedM
         0Wjd1sguw2n5TQzmAUP5QniPoKPKvZ6pyvIhFoCySNtR4ozn9ydG2UTpbxEcr80+sMpJ
         UoARdmmBtxVCqu1SVISx6bKjTxYnfNRxeiXY7etxD7lig3LTmIOUyASANkt/Df2sm32x
         T67ZAYk/2Wot9HqGE+FBtT9t6+lfceGugOsGb5D+ozz4KYoickboHeOLvpEYByznZVuI
         UDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746039209; x=1746644009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j563LolDk6lts4W0nJp0nldD5kQODfpG6rdVSrlTgcY=;
        b=cj5nf1VAtIZBAfjVO9er2Dpmdp2eqhlnCOHYby6Z5GhEAqvUxXVpoWQSBij0APVdoq
         lGTQvtYVVuPbkMqycZB3l35TEiivfBsry3ltQcsQEMNSJShHnYRbExMsuo8NDBi7/aUi
         NpG3wmFWltL55EyhKN/uU6SKHnLe9Vd4ojYo8B9oiCp+AybR978oN95OIC75z4tj52dQ
         CJ8VpnYbfpZ7N99inI4VGQ9LpPmM2zcHIga/Cj0DKRx5oPe20p1d9xnlDdX7RSQE3LUs
         gVeXe2GsBXtfXAULxfTiNBqLONX4CifoeCCkvp2CikUIu/eW1uq7aaW82PcX06WE8cbB
         AY+w==
X-Gm-Message-State: AOJu0YxP1lLotR9PKEtL1dLeX3mas/jfVC1Y+tmjrDR47yCkJbMjF5FN
	ZTPh4pl9OopqfiR4FV5Xy+q1vILNr8n2YyWheLmNEgweCvxzgc5xpR8JuYBU
X-Gm-Gg: ASbGnctDktT4T6xSBjcRSmlo/3wdx0nfkdN0+c0MOqcheNFS4/sT1MfvuUDu7ocCPLd
	jyYEjDcz29BFVWY3V6zACNmDNI4bZFIwmIA1tWmhoeRsHfjEpoAK2Q8JUX/om82nzGKa4s0qCrc
	090y8p11yuoBaiedCXGGNSAZYGQGP+xqc4+SoKDK5HBqjNImjHjshVXckZ0koJDhOnP22JE8U39
	Lubzs912ojKm0fPwMGaMFRs3OjdB29hogFcyK/XF43bLRc4TVrzDeNiQ3/BOAnfP7QAhmIxzpL7
	l2leoTknkxzKH3kaZsTKgFQ9NW+RsdaxhyHm81JtvOUrLckDf+OVy22lstlp749gdCNSmLVlAzS
	MRC6ikXQ=
X-Google-Smtp-Source: AGHT+IEKAFaQ6Rm06oqgl7IsgYo8ouIPv3vmxj1Zm2P1XG01aiK7OyJpIO5zXCGmv52j7M9YLd6u0g==
X-Received: by 2002:a17:902:c403:b0:21f:98fc:8414 with SMTP id d9443c01a7336-22e035fb28bmr6570435ad.26.1746039208542;
        Wed, 30 Apr 2025 11:53:28 -0700 (PDT)
Received: from occam.ucdavis.edu (campus-079-147.ucdavis.edu. [168.150.79.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f76f45b1sm11142958a12.1.2025.04.30.11.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:53:28 -0700 (PDT)
From: Jake Roggenbuck <jakeroggenbuck2@gmail.com>
To: jakeroggenbuck2@gmail.com
Cc: git@vger.kernel.org,
	roggenbuckjake@gmail.com
Subject: Re: [PATCH 1/1] Exit on invalid diff status of diff_filepair
Date: Wed, 30 Apr 2025 11:50:37 -0700
Message-ID: <20250430185309.11197-1-jakeroggenbuck2@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108060151.7218-2-jakeroggenbuck2@gmail.com>
References: <20250108060151.7218-2-jakeroggenbuck2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Has anyone gotten a chance to take a look at this simple fix?
When git is built of the main branch, it still segfaults when there is an invalid diff_filepair.

    git (main) $ make
    <make output omitted>
    git (main) $ cd ~/Repos/ECS50-3/hw3-skeleton-broken/
    hw3-skeleton-broken (main) $ ~/Build/git/git diff
    Segmentation fault (core dumped)
    hw3-skeleton-broken (main) $

Let me know if you have any feedback or suggestions.

Signed-off-by: Jake Roggenbuck <jakeroggenbuck2@gmail.com>

