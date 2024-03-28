Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086C5917F
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619667; cv=none; b=YvJHnP1bWEISNm2PSd6pSWjB37MqN7w7vvwFLdoSGTHHc1tQjan1XvQ17Km9ysM3LtoamVM5IVz2BPitn7l7/CP/ZsTqXq1ud8frddLIKUql91EzM5greshIYgiy1Iq+gNHvvRL4oD7j/ymdoF7SKZHPZKp3W06AI2/v2Ntn0VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619667; c=relaxed/simple;
	bh=pzR0dAoiXKkl2yekwfchdtJGguxtInvoptQAffSglVE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=r+J+oGDmp3mpHr6TBYp+bhFDHkSskQwamEqAQ30xsaKiosAfa3jLCLY+CYe0ugXbCjAdbdfPYld7YezVn0mKTPup+0hn9aMr3mV0oQ9/J3TjqRtl/O8bYJ+3n6ol+YPVFxVIb+C+0/eNTucRLUAMFo8m0L84N4kk2JFIANr66EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB6m6sG/; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB6m6sG/"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-696719f8dfcso3868466d6.0
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711619664; x=1712224464; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pzR0dAoiXKkl2yekwfchdtJGguxtInvoptQAffSglVE=;
        b=bB6m6sG/Z0MXGPvZn7OfCBiTCBaaZDyT7h9IXhFQOWiPQwiI4SZDTe/32owAYtUvX7
         1CZVMRwlHOYbMTl0b0tfWcFvcyx8CWddssUN1N3XF/irftqnP7BU6TcPptoHTe3x+b11
         Xv018n4251zLzZmY4vDf+v0XiimIU5LWR4GUcL40VNtyxMZ8LDFSuM2TbsgyuYYM5v03
         ETIibAHUILmwG1Hk3OZIEPcScfHbxwpuq6rquVkYuW7buuJVeS7dN1RcctiIR2FG+ETN
         We7TAoF/NA6HZPkIsxTIpI+xJuWUtOY4PW9nGXC4VJA4ijREBVhGSFV6osuR9/PfPyVQ
         Zcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711619664; x=1712224464;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzR0dAoiXKkl2yekwfchdtJGguxtInvoptQAffSglVE=;
        b=pyS4MSV7gM120TL3ZoTVzlHp1a7fKc5eFjLn2w2VJ5eew13YWIGAot6Y40kRo9e68z
         N/GDzLYBYF4I4BkJfmZXkQIk6VYQACxQS2tI927Shkv5a3M/twoR6Jjxo5JMIdEVS3Vv
         zEjBr2TT0nLnKIw87st2pC05bl+fHDXGpUqZgujtXt1UkmYNkIbDi8Zd0akBP0e7a3fN
         mMCEE0nhBf/S6xDSBQXmH2/h7+GnU1AyFcos1gU/7u5DgbEus41EZVVhaoroO/fb7wIj
         WlwZS6EDjUzc2F9EfC0dPm1d9xNFRISosGAteXZtXa9vxc1gJWjVfv5McyiOhJxDphJ7
         nEEQ==
X-Gm-Message-State: AOJu0Yz4STJLbJAoXpr4tXzB+laHxvPjIeqr8mssacClGBYu1xCHAlp8
	ttsoTSl8PiTVtxHeezc/OWkBpFJfVzmuh65zN4yDRnfSDYLZ142Ea63GXohFcOIatjI+eXM7fu6
	tmBkwSxO0njOnufCgYsmh8HviCi6+jU9mBDKrYA==
X-Google-Smtp-Source: AGHT+IEZSICECZAK/Hs+Im3Bkguenf1L4rQKtFRBRLhIk8YIfyqsMI1fk6YP9tc+g9GoKH1lqh25I8fzxZf8rrjnCAw=
X-Received: by 2002:a0c:f64c:0:b0:696:8806:12a5 with SMTP id
 s12-20020a0cf64c000000b00696880612a5mr2222363qvm.34.1711619664351; Thu, 28
 Mar 2024 02:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: zhang kai <kylerzhang11@gmail.com>
Date: Thu, 28 Mar 2024 17:54:13 +0800
Message-ID: <CAK_130T8sZUZAuvj4x7sB278kVL7ARaBv3Pg2djQB45O+7xKTg@mail.gmail.com>
Subject: Update message_advice_pull_before_push to mention how to push after rebasing
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Our team uses git rebase a lot. A common hiccup we noticed during the
daily work is that new devs often didn't know how to push properly
after the rebase.

When someone try to push to the remote after rebasing the branch, the
push would mostly fail with the message_advice_pull_before_push:

> Updates were rejected because the tip of your current branch is behind\n"=
 "its remote counterpart. If you want to integrate the remote changes,\n" "=
use 'git pull' before pushing again.\n" "See the 'Note about fast-forwards'=
 in 'git push --help' for details.

However, in this situation, pull will "invalid" the rebasing. After
pull then push, devs often will be surprised by the merge/pull request
containing diffs that should not be in this branch. In this case, we
often should just do `git push --force-with-lease`.

If we add a message like "If you just rebased your branch, please
consider 'git push --force-with-lease'" to the
message_adivce_pull_before_push, we may save devs some time figuring
out what's wrong with their branch. If this is acceptable, we'd be
happy to prepare a patch.

Thanks,
Kai
