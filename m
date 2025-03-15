Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF92F3B
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742056315; cv=none; b=IKog2dWrQpIrSXoUQXxz5WRZvE5LSf08pTrrnTly7M19l4yk5Y/JS+o5MNxnJHK9W0MWAi9h58Zj7cOCZqZPc5NtMCN9G6R1bvytjbfpgO0AFTyshS29DjgIAVxUSxszSzuBZTLDJ7Okx0H3AqmXxH/B2sl4R6eCNVST4brcrwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742056315; c=relaxed/simple;
	bh=2/md7qYBT/gdeyt9vhLW2GrBWmT/1V2nTt6Dr7SFqY8=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=CGq/K0eKg7oMODA4mXs3VFL9JWfQYOWaaaQriedG8xRUCahl0aDaBVE4DpyRA9WvPbQ6dTbQTDdZUozEiBh8AnVI7rgD1UKwy0VIv7I5tTBzzlxyp+uAFD2/MfU5rF9LRQyM82ANLIUrHySI9Vpa2QiNTid/v0JlA5UPIc+byd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qs70yR3m; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs70yR3m"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso2606608f8f.0
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742056311; x=1742661111; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bm87ELwfqaq6pi09H4dhYKn9hYF2U56ssUpffGXcH1Y=;
        b=Qs70yR3mQXs6JHAFilUHyImm/zrbjaFAFPb3f+P0OFZQ3jxjJ5oVi8W/K3ickWy3KG
         BZ/Ug275np1oDJ5NQuz3X8Y9iZj0V6QwbaMowplFNR3ZfUrcgXahr7RAkMDQmSJDV7EH
         qNun8FeB32TqTytDzLS3rgOpp/YiDAUtoIPfTgxjdDaq3sMQOrzI4u0BTxoqUeoOnoHu
         ZoAJR1CgW3CwwjE2AKk1ALY2gGVXlGrAYC/c9SCzviqml8hlLUlmU2Y7HNfkFvFTZmue
         u+E9rga9ctwvEOTEWsEFNeEmW7gSvnntcFkyaJoPFwyoya/iDnCwTYiyf3sPrKQr1HjS
         Thmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742056311; x=1742661111;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bm87ELwfqaq6pi09H4dhYKn9hYF2U56ssUpffGXcH1Y=;
        b=iU2XsaQs2nfyzWtV5jTEwkP1VqN1/U/CUxzB9G3l9MQIog252q8Uj/o0MoTHpAjIeC
         B7gSCRDFfcWox7UhzkdXBFcSLoenfT2pRcoOEw2GpTPUyeV+eNeW8qIT5rETAV1T/0g+
         0elNkokS6OAauYPKfV0YvMjSUm2DfHVjkq6xjIin7GHUhVkn76tCk5JquTN+NVJC99SS
         skKAo780W58vglnpvhln+38rLRsrbSxBtIV5MzRm9Y0dmhmfmlPxrFxTohQXCmgqPbO+
         mak/WzYaifh9OzmGbNN0DbeO5ONMn29VTpwbJmsGeZes41b6IOx05CYoW4ppz4/WZMCg
         JApw==
X-Gm-Message-State: AOJu0YyWsLRcR4KB7kDxjesAWSalHC5oy0XJv9OrhBx2c1byNopwD1ai
	3IGnLJr23h0lAXrYBgvV/zEXMQnh97IrGPIdCDfg0iHKTMAe6hf4MU4byw==
X-Gm-Gg: ASbGncssQUITyB+CXoYzZH55/5TZHFkUCmxy+mqdQCkD3HhnzwE9JQBs4acmHL5Ujzq
	CFBa2GI162IZTkXBM3mzqrAJPfg+tT0yd6fwjqYoyAflLpp3WCTRH+W3HCMar+pHroEZPj5Pln4
	hn+onPEQip6GKXe3sQBHlKiWnrexOA2HU7xGjdprjmo/deHYBNp6gr23Nfu5V9R7S2+rXwvUgKu
	/xya0Um99AcMgSnm07ROSYDFgrK/oCAK+S94YWzLnB1Nw1YbPpIqchdfv6QCTWyuXhBKGYVyR0w
	W5KuvKQ45DnoRH7LbIZ2KteWwo6qAE9itVm9InnY4RhAzg==
X-Google-Smtp-Source: AGHT+IHVWAEB5D3ny32ti33alILnQ6+G3XBPOwoRpHeEJfSKsHvkM5DESDHlsnObb+iCG3BL9GFr4Q==
X-Received: by 2002:a05:6000:1fa4:b0:390:f6be:af1d with SMTP id ffacd0b85a97d-3971e971f23mr9722140f8f.41.1742056311104;
        Sat, 15 Mar 2025 09:31:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c4f9d59dsm9522299f8f.0.2025.03.15.09.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 09:31:50 -0700 (PDT)
Message-Id: <pull.1880.git.1742056310.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 15 Mar 2025 16:31:48 +0000
Subject: [PATCH 0/2] doc: apply new format to git-branch man page
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

Working on git-branch's doc uncovered a bug in the completion logic that did
not take into account the new formatting of options. Apart from that, the
changes are quite standard now.

Jean-Noël Avila (2):
  completion: take into account the formatting backticks for options
  doc: apply new format to git-branch man page

 Documentation/config/branch.adoc | 105 +++++------
 Documentation/git-branch.adoc    | 287 +++++++++++++++----------------
 generate-configlist.sh           |   4 +-
 3 files changed, 198 insertions(+), 198 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1880%2Fjnavila%2Fdoc_git_branch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1880/jnavila/doc_git_branch-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1880
-- 
gitgitgadget
