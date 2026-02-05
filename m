Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF243A9D80
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289209; cv=none; b=q+M0jmdaSgja2yVDcUww3CKtxVDKjbZEIulurpAS4j655ScH/2Ajbh0zLzBCjqz3PfT5asqoL6yNbV2fNt6DvtO3rjBuSgq0wMtCwzOtuwHzCmX63tg6E7pEYZdbfML27i80yGUNPstOQk6h0H34qn5OEfkCUkTcHVBndbqk0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289209; c=relaxed/simple;
	bh=Bie+Jd3sSNtLiNiZ9PzHS+Z99vx6cKqqgNp2iDPZZIw=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=MJmuPpRDDM3gfFuQdozYOQpPtHMmnRh59gjdBsAWjYDaYYUjryFPDPrSzk19Xv5aGcd+T9dAMmflxRmIk3mbY8Lqzlc4XgAZ5YpycAJoCbYjCrH4DgAD4WTNx/qe7ERcGr0StWZ4iPM1zrrOrrg2Wlrz6eCDr1bL1iVxuJH/NdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samuelberney.com; spf=none smtp.mailfrom=samuelberney.com; dkim=pass (2048-bit key) header.d=samuelberney-com.20230601.gappssmtp.com header.i=@samuelberney-com.20230601.gappssmtp.com header.b=0g7xo1NX; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samuelberney.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=samuelberney.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samuelberney-com.20230601.gappssmtp.com header.i=@samuelberney-com.20230601.gappssmtp.com header.b="0g7xo1NX"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b785801c93so194563eec.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 03:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samuelberney-com.20230601.gappssmtp.com; s=20230601; t=1770289208; x=1770894008; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bie+Jd3sSNtLiNiZ9PzHS+Z99vx6cKqqgNp2iDPZZIw=;
        b=0g7xo1NXqJdbelI1oWQTfTqbwMNmbenpLeM0v5O870+Zixa9fcWk9J7oLnZ/ftIZl3
         h64/pwkK09xSXrAMdu9TO/RPqi+b875tPWgxCz/2OqjcsA0jiInS5Lfmu1fUBJzsyFbG
         c9VEjZeqWok0/9q55JKB++zxmRHzYqKHrg+Bj0EBB+ke3jm2OSijpcwMBMN6nyoNxLjD
         0/0urWllCoOCaOPmxAWESLOQLWaPt8zlmG++bopSyWIN0Qz8peSV4WO3iMD+PxbX6h26
         4f/7ibIkvzYQeprCi4eAMwoMjvvdXL0JFaRFWd0lY1C+pz2gqB/TyHigCk9xWApSSa61
         wb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770289208; x=1770894008;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bie+Jd3sSNtLiNiZ9PzHS+Z99vx6cKqqgNp2iDPZZIw=;
        b=cFnqokMygN4vAgJMDZdFJ0br2G9pCo4UEd5/mfrOu6TRNs2GhqIp8RuFp6zBgnKpo1
         TKcqCsfWvPT066tht0FoXGHx3jXJCPMVPrYvn6k3Vi/x103VQhOiuGLJsr2yYtEdFDCt
         i96x40gLnwtj59LV9P9SweSwzKYJJni4Zj/aDn2n5qpSOz/tsM16rij4PpDKLo5f06T8
         aToOpNDtLAJB0sX297dwokRcG3q5xWph795m1ZF6vcS4icjlkQmDVLY7dxlHucpK2SJ+
         +dgGJU5iQkt2Llj38QCmY3EKSYh0fLFIc0dQP/qEpWTq+FOjenfssliASXecgtFnzoZ1
         0pGQ==
X-Gm-Message-State: AOJu0YwjRjnst82Fj+esoopknstWWAwgCBF14Kk1IA+MWjBlydmG81U9
	IYXfPadEwosRzA8HcsDfJomDN8vwoKOz+hblggrhkNAf/Fp0bHkhwJkoGO4uO/Oz2z+Kbi0reDn
	NOAJqHA==
X-Gm-Gg: AZuq6aK2XPbjhUDjDFMLRs4nKG1MRdJ0jHsceUV6A5yjwpGRECLp5IUKzx314AWSpLH
	Y0VlN7wnGFsxIcem6bzlHTAXZyUQ9KBMUg15p3sXzRh+FyKO32sEvs1Kwvp97MFXRuUNeXCM+lw
	K7lrvclywbAPl4ZKYLLUWzy0JeSSnZVNc/kMCzWIfwWBWKnHzpAIR88CHxNYS1ltP4ZYnpTaoNT
	sJAr0tnG/mwU+2e4YVRlcgjg4fB63OeZ6pjTM4wOKhrvMh/nOGfVdXGPlbS/t3HrMbLJncktBTO
	Mn3nxGNGrUJFbOKmi4GCO1ig4AaJWUnWW9X3eOUE/p1ApXC2pgBVQAUkSlNgrjqL5Qhzt+jxBfC
	fuTITtaypk8wjoh27P4CSI45EdGUFpid2mu3qdMaQa6wXLk61LC7bj62+sVTqbWpp2hn6/Ciiwk
	ltO7irjKk60dVV5ZPnTAIzFJb5zmmIwsalHeAlVS/mhA==
X-Received: by 2002:a05:7300:bc1a:b0:2b7:da6d:8e8e with SMTP id 5a478bee46e88-2b83287b0d4mr3071492eec.4.1770289207589;
        Thu, 05 Feb 2026 03:00:07 -0800 (PST)
Received: from smtpclient.apple ([2600:1700:7bd8:864f:909:2b55:6806:7d59])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4bb8b02sm4343215c88.0.2026.02.05.03.00.06
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Feb 2026 03:00:07 -0800 (PST)
From: Sam Berney <sam@samuelberney.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Keep git whatchanged
Message-Id: <106C80F0-C92E-4F23-9CCA-631AFF12AC65@samuelberney.com>
Date: Thu, 5 Feb 2026 02:59:53 -0800
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)

To whom it may concern,

I have no idea why anyone would want to remove `git whatchanged`. =
Can=E2=80=99t you count to see how many people use it or something? =
I=E2=80=99m going to keep using it till it stops working and then I=E2=80=99=
ll be grumpy. Don=E2=80=99t make me grumpy!

Sam Berney=
