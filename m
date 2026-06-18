Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB19F3FDC1A
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781807860; cv=pass; b=UZlCMwW4PnQPesfbZncY0zEliEKkv/UrKfXtmKQ8HPAzkJTGT+Ug9PHe53EKuWutzO6WAGbVWnMjFSryzO2i/8DiYQdYh0N89UwHPrW3zD285jiF8gj16J85aL5YhHNxRNfFr0KE791Ag89rDcJfE7WX5pewOyN+rTIkd5TB81c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781807860; c=relaxed/simple;
	bh=++Ow8FrZWEw2eEh4twTnoyaaRDDVNyfj10w9gML4Ex0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lPQS1sT8KCTTEQRtqL4eNILOtAU8GKEiZi70+Os+cIsMCd+nQJDFtGR+ljEB17CF0YkvqH2yV51ylN2dee15ZcKJcvIkFUOvfZxNuPvi7FTdCHA9OllGoWLxecAHHqKMa7nb0MTcH7tDzam3VM9v0fphRWYWB+mwEfCsPxZk5VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jjf/8qyC; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjf/8qyC"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-966d7738c3bso843691241.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 11:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781807858; cv=none;
        d=google.com; s=arc-20240605;
        b=ENRyXdd0WAU55YaQWDzq9kZq7Qam8LwKUWICzUXERQycwbPoCZhXpCZH7Kqnay24TB
         2pMwVsaje4kApKDTrN0iRWl3BXF8vSxfCav4anhWrgtaSs/Yhjr+hefc7sHhdTMQWZ+T
         gvbaE7Ux0E8rgv9XUVWQRrtZy9f91JGdpZx8guIOCwHkoA2snnsjEVr+1EhPCQqFf0hd
         p80JePYWyLTMZEqQJb75k0R2cJK184iE/er7wtremzPYdKbsqvuLnWLBzroy72cCIKDm
         u0vRLDQgC+xugdaEBthIaGrPlQa4UMCgo0WZztSKrSXpMHj3XhhnDONlResAiLTVKn22
         iE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=++Ow8FrZWEw2eEh4twTnoyaaRDDVNyfj10w9gML4Ex0=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=WnyDys2AY+AMKi5c08dlc9gi1We4BQNmpCZgLV82Z4m3m2Yx+e37gAu3MWGAjkTI4q
         FVeVlrkH1Qi5rDLoJ/A9Y+APloqztOMBdWOV/jVr8JCvhALN9M6gpRBh13g2sioOOcz8
         MAV9nSxRxlt+AL22DPzy4hxw0qnkKTr1IruS2DA5anXH0Hc2XJ8RXBvhcTr0C/w78B/a
         b7A+1A674jxsfB5j1edjkEkjDe/DB7mZJhNlJhJUzLi111zyK2Ur4wfrbB7XDyQJQXJB
         JeqOxq1j6l3UsYiYHCkbH1e5J0DyAJXjSIvdSMH8MhAPEpPnW+XyvcUZpIO1i0VSarVJ
         dVvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781807858; x=1782412658; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=++Ow8FrZWEw2eEh4twTnoyaaRDDVNyfj10w9gML4Ex0=;
        b=Jjf/8qyCvTn+atWRceoG4I6WIjVYmf9EPgQLTUJ3wdDxnIpISaFcpD4wrfswSb/mkP
         S2fX8Qv7cg4fHgQkqJtglqcYY92Rg0n6MEWad2XE+hNoD5r5cdi8UwVcPW5dQVjurzjp
         /AYxFlIGscXK8BUgd4E0TlpJqeiDSRCJvHa6oJ+Kp00pr7s6vfO+eZcT24PAfoZlW3z1
         mDwzkfPDmnbAw3oxZwnXqBI6+aWt67f03GECb7phlEpMJjvJvHnCAEthvngo7OhfGYqV
         4qKRjB2fKXdATaz2qbKU0GCZ7geDHkWcX0dysCAFBN9rFllWUzVfOpWRACv3w5344D7k
         zOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781807858; x=1782412658;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++Ow8FrZWEw2eEh4twTnoyaaRDDVNyfj10w9gML4Ex0=;
        b=eFZLdYhNUEHX4cX6xmDru9dA6WMCOlAK4TQ3/aG0u6YnrTvJgYnJvica/hFbKU6yYb
         leiPCgeCwmLuatA38TRY7Ca1pJhvjeNFYeh8P2YWFzGN1Za1ND7u3111sE1TB8HdiU5e
         FhsixqF/dhTV9WFCPKnaDrd4B6Ct1UQVOU4sva5NZcIpDNicj+ECZivaXVC3909mztgE
         4d7jHihQu9jFIN+OSCGVIXG3C8ys092E1YBC3deVWG9QElbnADcqjMZRoH9P1iPNnU+B
         0an8zsdLCXWmyp1xnaiEytZTai3s7qLvAWOuTR7Cr7nUwAWjXWpbjVd1zGYItTer1VYy
         syGA==
X-Gm-Message-State: AOJu0Yxv7TgFS4+3U91S5G+AGwoByuTJHuG5JXIBZ2KVwjiWJYuGhsjN
	QlbsU+Rbuun/YcGiJ/933wxi5KCpmNWCrlpH8L/OrpgZP/aAP9DvvSCGA9FjC4cE2dmzduLwwm5
	HwJmPJd5UqfqimjcmpDwnitzYyriPwMOPJ6KV
X-Gm-Gg: AfdE7cm1HQCoaRbkpEO1aPiTui6/xAloOJLS6R07MfyhxnA0ycN2HewZWXl+sFvFtZX
	c2qE2eRANVgFJTqbDlf648f5kOwv2SQZWPlQH3Ilj9SR+3wi/FRAC72A/alhXt8QyCFdZDpuUL0
	WYaGtKOQBIM4EYsfiKRCZPkTihC6NPlyAIPATTRFcFhjBcm4V0vgMlwdqaTgzlxl0bLmPxrXI3c
	xNSaZsvl4EHkOW/th8HX/BsrOjakMfj804Jxrb/e6YJ3iCPEVXd0Yztzx37BO97P97jflla89Ff
	/9TrkA==
X-Received: by 2002:a05:6102:508b:b0:728:89af:8edf with SMTP id
 ada2fe7eead31-72a1dc35643mr417395137.11.1781807857903; Thu, 18 Jun 2026
 11:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Erik_=C3=96stlund?= <erik.ostlund@gmail.com>
Date: Thu, 18 Jun 2026 20:37:26 +0200
X-Gm-Features: AVVi8CdHgQ8JqV7GvaGYoo3v9PRAxz9ImrJ-W10NgFIrFxmDZwCu8xghgUlYOeI
Message-ID: <CANE2Nt_LP9odF9tVsy8di54eSH=QJxif2WQfHC+TQGGFeVcjvg@mail.gmail.com>
Subject: Pinned references?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'd like to be able to express a reference together with an expected
object ID, for example with strawman syntax like:

refs/tags/v1.2.3?oid=a1b2c3d4

The intended semantics would be that both the reference and object ID
must exist, and Git should fail if the reference does not resolve to the
specified object ID.

Tags are nice because they convey human meaning. Object IDs are nice
because they are immutable. As it is, I often have to choose between the
two, or represent them separately in external tooling.

Is there existing terminology, prior discussion, or an accepted Git-native
approach for this kind of "ref plus expected OID" invariant? I
searched both the Git reference documentation and the mailing list
archives, but couldn't find what I was looking for.

Thanks,
Erik
