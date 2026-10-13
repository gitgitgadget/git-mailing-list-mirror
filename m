Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010AA499F06
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887850; cv=pass; b=hQTFum8c2UkUYk2Ffb8K1y7YaO9A3E5GylVkrOeE3x5HnY1Ri2p1RxLwJtYfsDx9E84azyhYeYH4b1UUNKM7oV1cYps/vFY3wkGIG6v2QSjEnrB72sVqhytdfUAzpuBEKrSztUsWZOqze9KIdcyHOthZ239rBTK++62nySDxXWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887850; c=relaxed/simple;
	bh=jFUJdKEPy3w/e19079gjHne8nHnG9EHe6zqj+Pvt4Bc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nig3EBUEiD6FWJ812kywnVne0VwmwsV1dSUgV0CS2NDO2PLHIvvWpmQC1754l4rZ4gcnE0xvzAzpNgpO+Il5N70PC28Xx8VW2GHJqvWn7ol/CtHwu55ANqr+6+TiPzX3ARoJ66BEBqJ27ldIt9uLSf+8mrne20rqNOuA8aHq1EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sl7q7PG6; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl7q7PG6"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7c03a445cb8so1908157137.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 03:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791887848; cv=none;
        d=google.com; s=arc-20260327;
        b=a/2qhNrtpAv7bViRKr85A09sRlwFYNppuftC7hwU2QI9FE3l7xj5xuQ3eZriOm4QGJ
         5uiKgn9aWiLW/9F7Eg5ciHTuw/yblW9x37Ney+nrdbzuR515rp9o7o01/YFrXShWToAO
         c38VGehA9mkEPaTK4qrIxHV1hsr6e1Bx77TtAMyUZ9WYiXE5eQoO8R6/9nEbdIeEbL/Z
         kxLvadIWE93quQQAy75GZNvEGBCGtvhaG1AZWpaxsZUAUsdu0Wx8rgMnoE8elonvq6xR
         vuUO/auOIDT2wQi8dGwlO8Iq1Qj6q2lzrtHpri22xVwYXwiv675HdKR0GrQBhvJu1ETp
         GLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nwQz7DpuPBMYLkdCPLgzr/H2pCt28HQUt1+HD5Ztf+k=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=isBYhS4vE13xTMAFt+09jqzTgRePaEbjA+xSNLqQiYWIUATOPxIidCRndLFaSm2mvG
         vFrH29diX/kVZA/MywsWIXYQljAD9RGI+cXZxQsXqMvHh2JDoYu8u8aSjLm8ObSGwZdz
         cJMvjfR/vEr6UThVvXgs0CVWto/hzkO1hhq4SJzixOL1Gn29Xu1uWectA5lP7cNVA9ik
         lDv8Syc/m16GotyK80BuVpRrlolotWDNcLlisFus2FCAa7qIRb5B8j8Bj/TBGFi1U1uL
         S2PZdDNylBO0tsRWWh1uYPcDnGpMeQTN+NmivTxb+5AipakZWOOxFh8zFRmnadqrNz9p
         YPOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791887848; x=1792492648; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nwQz7DpuPBMYLkdCPLgzr/H2pCt28HQUt1+HD5Ztf+k=;
        b=Sl7q7PG6y2rd4FrFRacvH7M0kRRbmpBkbdIr61LbhrpnM+HChiewct26E9PWeqMG8e
         X5Nbh0sxJ4pqYGZzvlEfuKphSHbsZU8PKSbVGjcGkx+hVTDfU2xSHBjxG+tjQ2pwWcb0
         xnUxMgXU+Divv+Z9qYgEvOHSHZSyXV8h4XzjvhLdjEDDtppE43m8pKF34DYVzro/Eil6
         XVq950250EGmIQKH9tPlinizIWxGxyJ+jU8NL3tMFfHL6sr5YbO+p+K6sd/c6lo2b+PN
         22EvaFgvSWfzkxna+mho9hhqwdMP8QpesFH6K3eUQTusRh02jBRyT5ai3oexyrF5Mnwu
         9X8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887848; x=1792492648;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nwQz7DpuPBMYLkdCPLgzr/H2pCt28HQUt1+HD5Ztf+k=;
        b=thSLpqZPfG/4mZDhanA9FKBQwsymWA4a49C0i7q7UnuRLSXRFZHqow2T9fn5l8w5yx
         fuvhrk1Iw66vD12dV7AcibHb24xV2joxb0vMjhTYuDrm3TPq4G108u1I/2IDssAhjMm0
         I2ufCEp8MJ3H2YPVS6NPkGy71NYLAqEOXH6m/+f9O3JhIlFJqSFDRhhRpMHlaLdcrK83
         W8HdwI+fADDzR6on58nbxrpnA3VL0EVcOKReMcTrIAplp1+d7TD2vuA0h3LCBvJtj1yT
         UUkzuzSB8MJSMBHP+TPkqwnMd2vy0LBOsJAWUdjB0Tb63lgUQxtaavyIXDQLf/ExlWzU
         1Plg==
X-Gm-Message-State: AFq9FYJn21goOyQAzonGbgfSDwS9W65/S6NUFSDeQIz/LeUDoeyQC/U0
	kfFhtINu32hFdzwXJFnaNqJAWEHILaj8s1+xIIU77oTU3d0mGCK3H0s5+DD2olk51dkiqJLBsl2
	k64E+VNFK+t8R17kXa6AmfKx4kHQ/X2i1D0KGJ98=
X-Gm-Gg: AYBFou0WOAJ+vx8KOY/OSKI3OXZV6lgkBPbj2DMhjdrXfp5z50GPi6cpa7yjMpdvLJP
	KXJ5N0EWeFWmGhNZrxYk6tUogDwU0FvskYSOfg5irtZS9N08tjAdgc6YH1Ap8wt23mDJgSscuvc
	skukpwCGRUayH/9ou8LntXSzn5xxaZinNpEHTMw2IZzDyZ8CeQpKq5fAZKfx+maFS4Fd352ZqqN
	04TM1iuW9SGEOx2Ouqe15hmLIa6KF9RDmW20Cve6JFslJfVcc7MOXHLSuqDV+K/XQKz+plUVype
	ekJO2KrJb9L5eyNLywRby2tibhUpjv71QQMst0BuReHTzNe9UPhCPsIXH5kUL5jSAk6Y
X-Received: by 2002:a05:6102:5106:b0:7a3:4e75:d1f0 with SMTP id
 ada2fe7eead31-7cb3738092emr4012244137.23.1791887847784; Tue, 13 Oct 2026
 03:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shashank S <shashu8660@gmail.com>
Date: Tue, 13 Oct 2026 16:07:16 +0530
X-Gm-Features: AclHuK8NSxzWuQ8kEpj3Z4rDlXftciRJYtfT4HLlNOne_L5_7b4YR3xAo2FHB9Y
Message-ID: <CANHmUQTa8tLpHjZZ=Fp0m=X5Tb+uFuCcRobX7x05gKamXAgrqQ@mail.gmail.com>
Subject: "[Outreachy]" Intent to work on t0081 : replacing basic shell test
 command to test_path_is_*
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm shashank s , an Outreachy applicant for December 2026 cohort.

I plan to work on replacing old ' test -f ' with git modern
'test_path_is_*'  , So please assign the "t0081-find-pack.sh" as my
microproject.
