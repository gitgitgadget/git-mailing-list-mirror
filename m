Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1400265CC5
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862518; cv=none; b=WmFTNq22hk9jslCycwg0pSFciNE32r3Xs+rsBxxEmzDPZukPTpzHuTgoO37upDqLPN4kdf4vRWxkFSEhjgwOs45HLaGdWXzgeS5KS01johfcrRWcGbC57P9QYYH9SiU4vVkCUKsb+1g6uGKthWBQVTX+BsbB58Vp1EKrTbXAbsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862518; c=relaxed/simple;
	bh=wYLgtjT5Yz6vZJzPjzvb0zlXm0p/dzdeoT8SvkxcqcQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=fOdSVQaWVYgL8tZkSK0ESNt23Qq0OyuMwsWkC2CR2vUlIcA/6qHT0cLVy3YDc7EEdg+c+5ZWEjcgqUQTx3sOBTmUa+z8FnHJRRiYpWwQ6TTA6/cEUEwlpNUKtEtnOolhG0vQo/Tp4HQfS2rPyd3+wKWvc/R+LmK83qQ4hF9xzDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OygAe5h5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OygAe5h5"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so59542225e9.3
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750862515; x=1751467315; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5zQyTX+XKZGgvZTngbyg7xBwPBR3NqXPEpucucIu0ZM=;
        b=OygAe5h5QeXhX/ZOuK993UHmBwSCeD8PJLZnY/uJpTf5XFxZTeh5VBqeR8wOETx12P
         1rmQdazeKfnmnFzp4/egXYnIPmssxVTjby7Q5DElsPE8yo6Zx618svfZre3OBZeQn6u4
         XE+rFshIrYGPj/Uq04hxv06Umc5RWj5WZ0xkVHvIaBqYx4I8uIiN0DpPl1SBrLjHAf2t
         5L56AZDGlOLnXP20OnAmmQngTYgG5iVUae0sQwE+5H1dAg1hy2g0ZW5rUjHN905K85Q2
         PTlHpuh+lcmHjL2jSvZvbR7MfQc+uiYlOW9v3zb+LHNdiencFpUM+1zt2cUHwQrMIFbA
         WpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750862515; x=1751467315;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zQyTX+XKZGgvZTngbyg7xBwPBR3NqXPEpucucIu0ZM=;
        b=RW9WDPc+SEBj81TQuUOLZZ8QOPzuBzyimv+lWIwMJLwxSf+On6UGSuacm6jLLNyrTc
         KFaO6czXMm8OP/SaMtmzP8d7ZltS0raH9+DUcR5mdS6KDV0Ol5CNSaB9z59UgLwvycG+
         3ghpunU3J7mPReSGeJyXWg2R3lhswFeo9N2ewUJpnrJ5miLavLh/zfEtnF84d1fTTfR1
         iL4UALWqGDB4cSb0m6oNf6jbf1CFQ4wh7MICQZyRmn+Ils4RVHbm/fde73t2lZssgS0k
         Ax0j0gtaFgSlVD0D/RP/FXXi1N7HlHtJou01G6Hb9nvM81YIcdh5vvBO4zpM8BDghqk3
         +q7Q==
X-Gm-Message-State: AOJu0YwL0U1ggfsKvHp4A2y07GPwxkcnMzXYnxq/Qy6W6AnIpjGcWmN0
	G/d9sUYxuJBTey4MCpiEHyqQk4A7EnGqIC0TCkv86WSMiFL37Ge8KgEkiMzYJsF1
X-Gm-Gg: ASbGnctqLLYZE5uUep80maggMfh9x8ZRJJAPEJhTuTZIZ9uSouSoDmg/pNreHk7aX6J
	PUDR7vbJ+yDqsyVi0M2Rci9Puj7wOfZCwY+qD57oqPxDQW4adfCEYDKRedpdf1D72BjL/ykHSXP
	kHlcFWTid9xztXIxBiF4Idb0768qtGvTY67JxUH77MCGJc/WMOHIHHGheaHyim3Hn8Hu7UtFj9w
	5aaIQ00mm/+einDwENoKfk8b/GwyiJhogOFMiQS5URojzeV0Jyqkf3EGmKRr1j/Hm/uDwRE5GPM
	JR6WtQuU7TmsQZVDMu0h/reUGOHgtmCl4Q/0ORpLbTqyid0Bpp+Zg77IJMFg7pYAMBvWnbD9xRs
	NX1QGdlJy4PiJmmp7hrhf4M4Rdm2zYdfEH19eBs996uRKXjDgOxo=
X-Google-Smtp-Source: AGHT+IFL0GjCjwXD8JYYM1tsTzp1gCBix9WiH1HkfUusBX6Gp/BqoCCRuuU/pr3rmTng9nchgp1zzA==
X-Received: by 2002:a05:600c:6383:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-45381ae45dfmr28794825e9.21.1750862514667;
        Wed, 25 Jun 2025 07:41:54 -0700 (PDT)
Received: from ?IPv6:2001:8f8:1f3d:bf4:1c8c:3398:6498:e1d9? ([2001:8f8:1f3d:bf4:1c8c:3398:6498:e1d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233a537sm23329565e9.4.2025.06.25.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 07:41:54 -0700 (PDT)
Message-ID: <1678ec18cbd52b8714034cd86a44d17c84eeee0e.camel@gmail.com>
Subject: gpg signature missing from commit f0135a9047
From: hassankhalloof20@gmail.com
To: git@vger.kernel.org
Cc: gitster@pobox.com
Date: Wed, 25 Jun 2025 18:41:52 +0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

I have added all the bad objects discovered through
`transfer.fsckObjects` to `fsck.skipList`. No other configuration
options were changed. I ran `git status` thinking that there would be
some way of contributing that upstream so that others cloning the repo
in the future would not have the same issue, but for some reason I
couldn't do that. However, I did see that a couple dozen of commits
were added to the remote.

$ git status
On branch master
Your branch is behind 'origin/master' by 25 commits, and can be fast-
forwarded.
  (use "git pull" to update your local branch)

nothing to commit, working tree clean
$ git pull =20
fatal: Commit f0135a9047 does not have a GPG signature.
$ git log f0135a9047
commit f0135a9047ca37d4d117dcf21f7e3e89fad85d00 (origin/master,
origin/HEAD)
Author: Junio C Hamano <gitster@pobox.com>
Date:   Tue Jun 24 09:47:25 2025 -0700

    The third batch

    Signed-off-by: Junio C Hamano <gitster@pobox.com>
...
