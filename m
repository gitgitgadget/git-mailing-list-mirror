Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177BB54BE4
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183367; cv=none; b=MaKpOAMmIuY8M6QbRy5Br23qmnEcpYv8lYYsqoQDtHKFRJyjrS5fhgjInGyqIiwikhaZRv5plHWXneMr8RaigAj6JENG67z7/msR6vUuxhcvsqyuFXtwGbOWf+a6PL+J3XqGzk+LLZgkDRwhlgEqMmiQLJHxO13cuaWMQq3JkXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183367; c=relaxed/simple;
	bh=VYxWuMSUuJRm349oPn0S0EcvA/RVDQTQviCj3LPciRM=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=An8Y93Sd9N0LIlQu+UArzffD7QhBXsAjkqtDqYqu5TsR0YWBl+A9bZGi//VpupbtwT+02RTE8Pi3aQT0UEeRJJXra3no9HNwWPUvzNvASmvvv6hK+vwDY+zxUJ9Sa41YM4wlEg0uXZBYRFEpkl0rAf/lHxIydleGNcODD3WxKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7sS2zaL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7sS2zaL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41331166961so1579305e9.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710183364; x=1710788164; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YU3fbLc0Bq0fE0V0R2PyBHTXtJHZGFgj4Pid8vnqv5o=;
        b=l7sS2zaLGzVAHwNQmMinujBT3g97Gjke2aZU82gSANR/lwbTYL84zGOLLZAOf1X3Ms
         PD7l0OANhZhj0+cCYE4JAS0OuOW+D0eLxsSzInmXCrh5X+NlqQDcYcpAT8vweokX1HbR
         bfQiMvrOpCd1QZt9mLC3gC7anE/Q4xKLJdkf1EifVy31RBg4Oj1+NFys+CXTu4IBFwhR
         ORQKa3ozhbmKWFlCsmwgwUwXYwhjiylOOPPFslK7+ZNi9278aUupHWd+mZ3bnpVXQNXC
         rW4oZqiF2RP0axb/6fHn5fLVrY9rShO27luaMFwZyHXOyfrDal+pMOnoHYDNOa1fXCYO
         tsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710183364; x=1710788164;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YU3fbLc0Bq0fE0V0R2PyBHTXtJHZGFgj4Pid8vnqv5o=;
        b=QtJ/N7Fq/PYg6sirqaPjYDB8aPbs3oWlLY0o4yjERpvhEEHT3CRm5F8P2N6We8eZr9
         lve523iZjLrhoBMHvAJ3cK0SAp7NlR8wA6LhgRmCf927CBgfz6Xh1xiJY5FDh5/1VrLR
         NBUvpdjYVaxRp73rrTprF2gj8CkYQrSADx/Yl+Nc9Z4aDXMEnvBCbgEU0CJpCtJ1MezM
         qcE3XawBUStPjKaia8BzHz4zFayGkxQul97wgKa9/tHgvc8lvGnm13Cj8jQosT9zJJ6a
         c7e2rKxYcgt0NauFh7yWnFKleL18qzXS+VslHZj7ndJooEcBKv4PYS21qsGO7tKmDnfl
         v+yA==
X-Gm-Message-State: AOJu0YwpHxFxw9FrE4ezIQpIQRzTAXUC+P4Net6URr/Oh1TeM8HOXnc7
	6ejRzjLoElI2Jw2VbKD1T0QtTi0P8owTZv4fpfeiE6ZPNEgq1XI8NygrtS85
X-Google-Smtp-Source: AGHT+IGk0F1vncYQkvfYDJJWCvkEUrGn7lDR19AUD/DEUquFnkrXWFSlgrawoBD6Wn5FgQulQ5LT2g==
X-Received: by 2002:a05:600c:358f:b0:413:2522:a9f5 with SMTP id p15-20020a05600c358f00b004132522a9f5mr4323138wmq.21.1710183363676;
        Mon, 11 Mar 2024 11:56:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b29-20020a05600c4a9d00b00412f4afab4csm6655456wmp.1.2024.03.11.11.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:56:03 -0700 (PDT)
Message-ID: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Mar 2024 18:55:59 +0000
Subject: [PATCH 0/3] cat-file: add %(objectmode) avoid verifying submodules' OIDs
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

The cat-file --batch command is very valuable in server settings, but so far
it is missing a bit of functionality that would come in handy there.

For example, it is sometimes necessary to determine the object mode of a
batch of tree objects' children.

This came up in $dayjob recently, and applies cleanly to v2.44.0.

Johannes Schindelin (1):
  cat-file: avoid verifying submodules' OIDs

Victoria Dye (2):
  t1006: update 'run_tests' to test generic object specifiers
  cat-file: add %(objectmode) atom

 Documentation/git-cat-file.txt | 10 +++++
 builtin/cat-file.c             | 41 ++++++++++++++----
 t/t1006-cat-file.sh            | 79 +++++++++++++++++++++-------------
 3 files changed, 92 insertions(+), 38 deletions(-)


base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1689%2Fdscho%2Fcat-file-vs-submodules-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1689/dscho/cat-file-vs-submodules-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1689
-- 
gitgitgadget
