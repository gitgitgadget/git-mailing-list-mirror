Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E36117C8A
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1LbSrAQ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28c23a0df1eso4258096a91.0
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 10:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705082514; x=1705687314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLdf2qssu2dWCpLIZ89H+ww5LrGDDYk4nW1z1fpTf7I=;
        b=V1LbSrAQbt8heg1+5qskGpxqmqwhVpeRhoX5I3LpnfZYmGGlKPPsdmsr3iylJS5AWF
         BVjFVL9M/7uPRSRvyBu+Lm2fcHXIQElqI5cGNeIP6ksgUix9GZ8IMtd9yDIEohwLz3Nu
         Vwq9Cl4CamXSLJsNwZsxkC2xKAKVuERWgqA+TF/AF8Bq35nC2HAb3nlRzLW/3YjnWdZq
         3GoROGfKqyFAJqVvDVO3vd5phEKt7WzsKMFXw/aub3381Y2HZGR8I519k/1QMd4q9PKO
         BFollRZBnLV0X+DpokKQii7zR46gky26SmslevcO/hZl9mkg3gtAWeV/1qLaBnhUJHEN
         UGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705082514; x=1705687314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLdf2qssu2dWCpLIZ89H+ww5LrGDDYk4nW1z1fpTf7I=;
        b=e5TNOvZDS9rVayltjS0+rZvfAKxDCvqE6C3coCbyMikTnB0x5vscAFxLLCdnZGuUxU
         CmX4Cskg4KOIw1FkIdm5qKtpUiCdi/fa2InQskO7k8Lr3l12GOQ3jtCepcNKRYL24xzW
         EWW4mrQJpjbmvK+Iwl14DyRRZw0Bm3l2vjCDhLwYUIgfw2z6sWU3mcTMfnHIyQg94UeG
         DzeKq+/eviuDAhe6ZuKJbGcsn0ai5Ubg0v+BugSQdY28ARR7vO34GWdhOaacUQmbyeou
         99Qqi29OVc2WS+We/hr69E4KbRBOY8BxUgsDijSwteWf+koPL9bMBFnQWIkjLa5fvTTH
         OAeg==
X-Gm-Message-State: AOJu0YwGLQ3Qo9hlR5NAsef87GjSs47x5XC8TC4Oa5xM2X8S5LBVWIC4
	I94+a7nDBtuLIvfcq0FAFW2VRsCSDnzV0Dr7te4=
X-Google-Smtp-Source: AGHT+IE5yWzj34+wvPqzfTJzQOkZa7WLkLO7op5Wm4y9v54NV/BDm2xCIoFFMXAUzA/c10TxeEja8g==
X-Received: by 2002:a17:90b:3744:b0:28c:c6a0:f52a with SMTP id ne4-20020a17090b374400b0028cc6a0f52amr1548471pjb.84.1705082514062;
        Fri, 12 Jan 2024 10:01:54 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id ph8-20020a17090b3bc800b0028db69af4a4sm4450352pjb.4.2024.01.12.10.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:01:53 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v4 0/2] t7501: add tests for --include, --only, --signoff
Date: Fri, 12 Jan 2024 23:30:15 +0530
Message-ID: <20240112180109.59350-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110163622.51182-2-shyamthakkar001@gmail.com>
References: <20240110163622.51182-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The v4 of this series fixes the issue reported by Junio in v3, in
which one of the files was not being added to the index before
committing. This is fixed in v4.

Also 'untracked files' tests are moved after the 'nothing to commit
tests', and also show that with -i and -o, behavior remains same as 
when not using any flag.

The v4 also adds extra step to check that certain files are being
committed. Specifically like,

 'git diff --name-only HEAD^ HEAD'

as per Junio's suggestion.

The '-i and -o do not mix' test is updated according to Junio's
suggestion.

Apart from that, certain instances of 'test_grep' are replaced with
'test_cmp' as suggested by Phillip.

The --signoff tests remain the same apart from removal of empty line
as pointed out by Phillip.

Ghanshyam Thakkar (2):
  t7501: add tests for --include and --only
  t7501: add tests for --amend --signoff

 t/t7501-commit-basic-functionality.sh | 102 +++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 2 deletions(-)

-- 
2.43.0

