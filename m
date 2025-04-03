Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B21FBCA0
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743712920; cv=none; b=To5fiUYniiIO1G1s60fOn5CBafJwSKTbZhHSgEk7HUkvfM50kcTa38bci0mBUQcEghPl7lMoVLQUmTQ8kDt1VRE70x5dHJA+8b9rI8v6Xok3d2bSllY5iqAh9y/u3zISx/oH7ZxQ3Lg9iV/Abl9gi8AOcsMZMI12Wn/i4V5zV+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743712920; c=relaxed/simple;
	bh=bCgIPSQXSVxOm/8bhzIqgmCHdmRo9t8+VV+SAEhetY4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=G+EUEngdUGJTRC7NSymTsgBrHPSCvNBcrCprQTJpswAgGAgyQ0eEVN2pBxhh4+qy1r4w7dTEdcH4uP+AgZlqECGjqiMYcUYmO2xSrD9/o5jkzdjakIdoKZhVHhLcvn4K7x/O9JBKWoY8otUFdc4Zzc49uymudgcTKaR0pisLz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marrold.co.uk; spf=pass smtp.mailfrom=marrold.co.uk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marrold.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marrold.co.uk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227b650504fso14164995ad.0
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 13:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743712918; x=1744317718;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mTyFPqAnPbJ0l/aPIuFZ8g0rEgcsc5WQ2d+g2P7InwA=;
        b=fGuJTSDU+214E/lzW8azHaqVZ8kizqcN1zlcB75fP7FtoEOwxXpS1a2++b29mF7yV/
         60MqNpVcIkgrqMUmcY0bZInK3OL5xkQ0AOLM5KzwCulU7MdCaJSGK1pk6DAq1igXS/Vp
         1y4ubxyK4D6MRGzMIOG/0yqStGGoB+YL+yKVroimmMoaTa0FUSLGkpGaXLG23PhkHdq9
         8q+wkDNkh04vJuDwsO8r6fXBQtSMB35FY26Ga9qAV+YAL/qGFOWbTibtezm9670CozVx
         8G9Ww0l1D3nQesAdrNMndnGp8YAO+VYmpwLMd1g5Xngdhz2cO45u4lQ2/tlghf1GthTx
         rRHA==
X-Gm-Message-State: AOJu0YwXdwG1BGeczjP0Q6P1PJDmsCJlWyp5y5bBVH/PS4SIb4iQZ5Hw
	yQjWe87yNmiGcO5uumP/hPdnbcQM/+nYyI/LqLjmqr0ZK0R+kP+6a7f6tOBMlzi6i1Py8xlkrX+
	Bv1A6NCDkSZFv223GneFoUu0exANRcDum+ECMJLcSHNFxAgt4iX4=
X-Gm-Gg: ASbGncs1PTPHmLByKkRYg5Pre3X27QJ+pSxRk8y7vYtKF6+iFDnCAKZ4p76LqZx6uh2
	k6spPBdivpLQxuXYC3MoOYCzS1/Ig6Z/nUmZkIYK+rXoLNKn1e7Z0OpATXjjCMzfW+/vEMP1lhd
	Ornkpf2jOWdib5X1dnVUybcrH1RE4=
X-Google-Smtp-Source: AGHT+IHTIkOz4j0yA7AnXqN+nUc2BD9HyUz+cQE26MXwkZlSsW3dH9gFbUrh0ZGxOdMXy81LP31kyFovMfTzI3GYU/M=
X-Received: by 2002:a17:903:41d2:b0:21f:61a9:be7d with SMTP id
 d9443c01a7336-22a8a1d6c08mr5734375ad.49.1743712917731; Thu, 03 Apr 2025
 13:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marrold <kamailio@marrold.co.uk>
Date: Thu, 3 Apr 2025 21:41:47 +0100
X-Gm-Features: ATxdqUErJFnFrDPNwWKV-UpUCPNyuNsXw9atQe6EwiJif8KxowaNr1y8-bzm8jk
Message-ID: <CAC-Lcd-=_dVmyy0x9N+5ap4h7UQrfkVpJaCtZnoMrkxabVR1dg@mail.gmail.com>
Subject: Git Commit Signing
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm attempting to manually verify git commits signed with SSH keys
using python, however verifying commits consistently fails, no matter
what I try.

The python verification logic has been tested against signatures
produced with ssh-keygen and confirmed to be working.

I suspect I'm constructing the message incorrectly to check against
the signature. As far as I know, the message should look like this,
with the gpgsig section removed.

    tree ff5ee8caaf2893a79711151b2937130469d83d39
    parent 3e84a21590a5ad714d168878abc95218d0e42cac
    author Matthew H <git@marrold.co.uk> 1743454803 +0100
    committer Matthew H <git@marrold.co.uk> 1743454803 +0100

    Commit message

Could someone point me in the right direction? I'm wondering if its
hashed or encoded prior to signing

Thanks
Matthew
