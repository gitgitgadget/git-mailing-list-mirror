Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1E71DF270
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743442463; cv=none; b=JVIRO8rX7CN/3ca/urJv00WoXH6s8mw+Xp5c5E1UUWdN4OMabNl3URp8v4cqqrm3dGBSPHigEDxr34uXLeFPWPFo5TcAmeo4zjHhiLKBEiTqw4DnY1DsIc1ruxCBrJ41DM6sVtwzVefBUK7rojs/vR+BwqaevNbRAcfsiatTZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743442463; c=relaxed/simple;
	bh=p0ux7f/8mZqwXvHzDPuQSY1tGll2oBfJgwuOLbj1tzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILrlukhislDwb2lMXbqnqIrSd1IsBIPMQyaIFMRzKi3Vyl3J7FCY09TPaxebqO7Jjam7YF1/mCfCWEdZt6tA4m2CzkH/nV/tAMUaCQLmOyVBqbjHTHc2RAvmFPQEy5ivFmo9VkZd/kEBq9lcOzDAHtTkei4OTIL0/DDyEfctkLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f43676b7so5489196d6.1
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 10:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743442460; x=1744047260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LD4O2sZBBQQTIQRKwSqwiW0N7PtEh6SzrKMz9yIoJng=;
        b=fuWW5eTvDRnUVtAszHseQ8g2qyswewT9BazH97u3Dzm01MAd0xIQL3KIz+THH2KsYL
         pSwTTOe2PcT1c/k8/W192k2mm0lAxFjsreabVdDbi5jyy5rLgbBC6UwXJKhUnhuLhumY
         4IZ3E5c/1zHOrGBny9NuN69y45CJCxDoHwlsgov8uTchC28NyFqUGCAJQNWGmnMmERZd
         B2rvRT0zxLCrNal3VMxNqE9qXlgHlu/+4eT21OSyV7+f1CkHjUcFl2tlM8HBCMiM4xa6
         MaSwjvzU0tTDbHR25x7XVr9X7BFmn53ZXngWbTBLdvtEEVNFQzxStXN01KCk2upSpyUY
         Kbjg==
X-Gm-Message-State: AOJu0YxYdnnv47w84hZakE/2hkECMBX4JxAmtzUWjKxVsKb50ywecQ0D
	94mhpfme60CDlQbVREODLT+NACt68g1U4qppBGePDIE/3LtQ+ZY2yHNYgcG8K/zRcFOYMDI2u54
	2XSh6vHFiSMXKLT9qKBq/D/s+qrc=
X-Gm-Gg: ASbGnct57YC8dbG7xXu7+yLJk/5WkwFirCvIppkZ6H2MgpKKSgSR6USNyR5I8kxFJ7D
	6Si18OSbFXFsAZExbNMRtcapurqVChRS3uT3W9g8OTEvaE+8sNbiqMbluDKgtvZ+2lbjRp4VtDk
	hp1RQbCJfrRWKNIb8asgWXgxMKIRx74WL8xJ4nq4jdBAb/bu6T61y4wQp1Wns=
X-Google-Smtp-Source: AGHT+IEgdR84HTWN8zleHCU7yuhzhqA89BF6q0J2ilBORWyaHrMPRX5EziHeYG53WIuX7ey4G535eQODn7+ZMh/XGCg=
X-Received: by 2002:a05:6214:ac2:b0:6e8:fd2b:1801 with SMTP id
 6a1803df08f44-6eed5fc54e9mr70026846d6.2.1743442460290; Mon, 31 Mar 2025
 10:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com> <0b6bcd225dc1444f4debe5fb8c499c6cad0a4ab2.1743436280.git.gitgitgadget@gmail.com>
In-Reply-To: <0b6bcd225dc1444f4debe5fb8c499c6cad0a4ab2.1743436280.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 31 Mar 2025 13:34:09 -0400
X-Gm-Features: AQ5f1Jrn6_j7KZPDv6-HWC5iQREvljpS5QSZwPR6gZ1esETvZe3cvaMvm3HjSzo
Message-ID: <CAPig+cSJ-3CXLV3dEhN+B8k7COQNW1Zm2ynuZtmmspzXsjp_PA@mail.gmail.com>
Subject: Re: [PATCH 7/8] tests: remove GIT_TEST_MERGE_ALGORITHM and test_expect_merge_algorithm
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 11:55=E2=80=AFAM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Both of these existed to allow use to reuse all the merge-related tests

s/use/us/

> in the testsuite while easily flipping between the 'recursive' and the
> 'ort' backends.  Now that we have removed merge-recursive and remapped
> 'recursive' to mean 'ort', we don't need this scaffolding anymore.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
