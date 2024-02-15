Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F412BEB7
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995391; cv=none; b=MWa9lZTn2q8FogL9bCLpcX7Z5r9WGfFJZmk+70N9eZbnHx6vuiv9fcc8JbEpO3mw9VavbQ0juJJMbU11w4OO+nke7e5EWJ6xJEUI85zPelaiRj5fDi9kx9Wg8IRKvd/fo3682CV6p6xCdZfCIQNKs/GHQRYDKIyG/hRPbbtX5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995391; c=relaxed/simple;
	bh=lkXRbvtbwYnVrlFQK393gZ1nDxz43vrnrQrzou/H8c4=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=nnb2DCjlHap6gwzX1AOv79bst+H/4fr+jSXUDvMCXKRJD4zS/gHGKiOfkD25vWdv86fjiP4yrNW0baq57YeYQLoSgqpDHpoUCDY7bxwBbwdZ4L5WCb/U12xlPrQo2T9drI107C4lgGiBfvexoQWkDXGmYWwsk5L2VVwmks9IE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLB0lTJZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLB0lTJZ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so349291f8f.0
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 03:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707995388; x=1708600188; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lkXRbvtbwYnVrlFQK393gZ1nDxz43vrnrQrzou/H8c4=;
        b=hLB0lTJZdJbsIkgGISkGoXlMoB+K93dJ6SFUe7IRSogZz5QqiMvBDQEldtsD6ZQybR
         dwtl0qvU/AIzpYPcmTocL4WcfGlOF4h9mjIEwNmf9ajNUL+xdZDNgY6maFDlM4eZsEdf
         1lLzelmd3+aErHUpUzuKlexI77owgekFmvXGKsLdxlilH+Ju4KtM6neYHUtyjRJyLBDW
         waPhX+lznWDGnH1RltjbOasEvxdRlr9gcm+BUBHCJV31cm21qb1SSS5/ZfACuW1h7qLS
         beXLhq/ieT+0H282/NWmBHwPdk+jqlUTLDUXjzur0F8e2BssAS5ujfBKPNNLpXnv1fgr
         JNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707995388; x=1708600188;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkXRbvtbwYnVrlFQK393gZ1nDxz43vrnrQrzou/H8c4=;
        b=hZBZj+1pf0s+lh6RfPkcWzpCacVAhC9uWcMeLWB+amXtCcFlq8aXTXt9Cg+obM1+5j
         dtNJP7Qs60jBZafXC07nTq7r7c4fQzGxRut1MjT2yAHlf9xmDGT5q/32TzGEU2njH9U4
         Ay3a15yb5MT22GxclJmfaE+gO8xnWZs7E0ILypcnYAaqgBoLQmgeq5GakSEj3OslUjTZ
         NGKc93WF3zN5jjVJVwYyKw3GE1pUzJbhQyhLsWd37/0O9Sl2DsjdfXZ6t8W1nJl+nBnO
         VHSkPP3EbAVhvN6CLf5lh6SYrS3o7Ih3iTZDSNHFtpm7+Tr5HTIIOZ1j/MGPkQejkMHw
         4EGw==
X-Gm-Message-State: AOJu0Yz16ASnT+N4TftPUeROrYH4yeNzMQYRjCRf74aup4Lma/2Spb2g
	phx5Ss2sQvgERNRrNXAYLukUTiTaVzRL8buH+xXe+pI29T3KqKGZ4WgvKYYQ
X-Google-Smtp-Source: AGHT+IHSW4z5RW8qcRDNi7jYBfFZW5sSr1+nxgnO2oXHzRqs8mRJJGxsEKJTVKe0gCGtHNlS6yxjVg==
X-Received: by 2002:a5d:4c49:0:b0:33c:e306:bba5 with SMTP id n9-20020a5d4c49000000b0033ce306bba5mr1065268wrt.1.1707995387493;
        Thu, 15 Feb 2024 03:09:47 -0800 (PST)
Received: from smtpclient.apple (laptop-ipv6-2001-660-6101-403-1-c1.labri.fr. [2001:660:6101:403::1:c1])
        by smtp.gmail.com with ESMTPSA id bh8-20020a05600005c800b0033b888a0a63sm1551803wrb.0.2024.02.15.03.09.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Feb 2024 03:09:46 -0800 (PST)
From: =?utf-8?Q?Jean-R=C3=A9my_Falleri?= <jr.falleri@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Git difftool: interaction between --dir-diff and --trust-exit-code
Message-Id: <976C9BF2-CB82-429A-B9FA-6A14BCFFCA3D@gmail.com>
Date: Thu, 15 Feb 2024 12:09:35 +0100
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.400.31)

Hi all and thanks for the amazing work you do on Git.

It seems that the =E2=80=94trust-exit-code option from git-difftool is =
not working when one use =E2=80=94dir-diff.

As an example I have set up the following configuration :

[difftool "false"]
cmd =3D false

And when I launch git-difftool in normal mode with =E2=80=94trust-exit-cod=
e, it works fine:
$ git difftool -y -t false --trust-exit-code HEAD HEAD~1
$ echo $?
> 128

However the same command in dir-diff mode is not working :
$ git difftool -t false -d --trust-exit-code HEAD HEAD~1
$ echo $?
> 0

=46rom what I read in git/git-difftool=E2=80=94helper.sh it seems to not =
forward the exit status when $GIT_DIFFTOOL_DIRDIFF is on.

I believe there is nothing in the documentation about this interaction. =
Maybe this is intended but I find that this could be useful to have this =
option working on dir-diff mode too. For instance in my use case I would =
want to signal an error when I detect breaking changes with the breaking =
change detector we are working on, that is hooked as a difftool.

Best regards!
---
Jean-R=C3=A9my Falleri (http://www.labri.fr/~falleri)

