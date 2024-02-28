Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D0381D2
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115313; cv=pass; b=tAc6gMRtHvPAlTybnMNihkfHZRulQLnh/pLt+TBZ7IUbqmBCWPRjfXMNgqMVJLJQMnDRD2d14+gXsNZAGKFd7sd3Lyo+PTRo3v/wd7qzAybfz0xv4txqTtnlFaxQ1zbaM1rdKATn/Nu1LngZzg304GnP+BlQYRoSGajBH9YuDks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115313; c=relaxed/simple;
	bh=nfjV5jmXNJoEMUQi7YqaHzPOM1pwMcFql+7DL8L7tQ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YOJWy40gvyF2HCyyRaiHoj9e8jUIWlFo0hCWKAvx1Bc5hRUwGwjqyix1lzZbqPDwKMwiOWtlTWh6QRIOER2q90iebdXPnslc/BgH3flsDCItvr3v/i7zAX01je1mNhhz8hCx37spdf2Is47Ou1gqZB+VoTWrJAUGBICVhFvhbEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=clisp.org; spf=none smtp.mailfrom=clisp.org; dkim=pass (2048-bit key) header.d=clisp.org header.i=@clisp.org header.b=TUJo8Tnj; dkim=permerror (0-bit key) header.d=clisp.org header.i=@clisp.org header.b=Xkx9r7O7; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=clisp.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=clisp.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clisp.org header.i=@clisp.org header.b="TUJo8Tnj";
	dkim=permerror (0-bit key) header.d=clisp.org header.i=@clisp.org header.b="Xkx9r7O7"
ARC-Seal: i=1; a=rsa-sha256; t=1709115123; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=j7zYqTVSDBZXp26PLy2+mdtvhNKDgBr+QGamWYgwZqnzb4tBTscahUalnnxlEVJ/bd
    MBxKdnJQK/g1DHYuUyt6k4w+zH5Cv6gSNOCcmueOj15gwRtRS4bOcZHSgTktujus0zW9
    y6oMfZHM8Ew6hv3gYiPmN39cxzpx7+/GxZGqHgg1zcLGQ+eGvSkviLedQOaB73qJNt2V
    CCrMtMjS3gi+PlQOoJ2q2qoRff3zheylK6FhJcjk93tJF4LMqKXD7EQvBqdI8fWYe2Gi
    K38Ua6wtoMJWClIBtIAAZpPuOOep2FI+zs/dJWT9E8uHGUPbeRf2NrIcUYsBq6X12tXO
    RhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1709115123;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=N8Eoo+09PKFODdfGHtpI6viHI4orJKdm9VoDK3CswK8=;
    b=Fyasca5HHmKPEDrw7RmN0V4mDK5OfVCJC1P9oztlfuVKIOv+8QJc8xjWD7m+PhRCqi
    NCDBDO3AHycT8Zm0VSfr8LGYJD/fUd4qhY5Z7G+dVqa551SInjQPv13vSNlSFFxU9eEc
    j9kbc432CL/b3vAFDQFsRuDCthWXIRElkt/29887E0MvpJkXv5JdAAmA/SNIntfeDFGt
    4czhmuH0jvFqwbWYqJJtYN9Qp22bs2L5g5EaEp7UqMKAXNNxmvqVCeEMtnDYmLoKbFCo
    Bi1lCbPRQsvyQEMaELX47x0negCwL6Dnn+HqzKuOTI/ftqEN/lTycyIzNNaLq03uk/Nf
    aKUw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1709115123;
    s=strato-dkim-0002; d=clisp.org;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=N8Eoo+09PKFODdfGHtpI6viHI4orJKdm9VoDK3CswK8=;
    b=TUJo8TnjuX6GyzGCfGNSRNGfB/0AYkFW4Y9MGgwjpRpjzJwl+3BsRMAg2G5RZOzJY3
    swwpkIRUAxbFwJV3MmnH0GFZp1ONNo/GKT3HSj8tLmmNFVsGv7ccHEvFtJA6nUGz5GQG
    c4o5fxEXHdc1RYoKszcdJL/47/5xRPJTHUOx4XwG1fA+QHv/mtonvoSbCHIG1hKPmjmi
    uxw31VOQpN36viNoc3pDT5xa13oxpxUpeH0XAhBC0WHWVDf+p6znn8F8f2wsklEGz11H
    84HHMAhNVdCrDgGIJ2B4swD2zRsh5K1Dz5epxpB1B0TtFBH8NeT024jyVO3osSXCtUJt
    Y5tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1709115123;
    s=strato-dkim-0003; d=clisp.org;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=N8Eoo+09PKFODdfGHtpI6viHI4orJKdm9VoDK3CswK8=;
    b=Xkx9r7O76KZJz01sLzkiyc4IMbbvT/QdtlHK/AQqdKfYKjmbRHzVIcWz9BAmmoC9b/
    8GylCpeZ2HAVzRv3r8Bg==
X-RZG-AUTH: ":Ln4Re0+Ic/6oZXR1YgKryK8brlshOcZlIWs+iCP5vnk6shH0WWb0LN8XZoH94zq68+3cfpOX2/Pq//Tg/hkr3jO7u/1QrMMGvA=="
Received: from nimes.localnet
    by smtp.strato.de (RZmta 50.1.0 AUTH)
    with ESMTPSA id 61068701SAC36Hr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 28 Feb 2024 11:12:03 +0100 (CET)
From: Bruno Haible <bruno@clisp.org>
To: git@vger.kernel.org
Subject: git-config doc: variables sorting bug
Date: Wed, 28 Feb 2024 11:12:03 +0100
Message-ID: <6139934.yKrmzQ4Hd0@nimes>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

In https://git-scm.com/docs/git-config the variables (advice.* ...
worktree.guessRemote) are apparently meant to be in alphabetical order.

However,
  filter.<driver>.clean
  filter.<driver>.smudge
come after format.*. They should come before format.*, since 'i' < 'o'.

Bruno



