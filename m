Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24031D1312
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020431; cv=none; b=KKR1OvK8Te9Di2RkBFniM1FtaIqdj4q8+a15RcTHq+Qnv9XEoQKJUOci4/Fx1oeiSl6f9Hfyi/HeyTOXtxcDdW5j2ZJkA0CrSdOrm4YTdc+MEy1XjikGaHgXH4xWkZng/a8IN6bnNI9hxyPfrdcO1oG2L1qEp3T7i9yNCtqJ64k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020431; c=relaxed/simple;
	bh=LYzxscr/aD6BuXd7sXUHvTOOSxW5fTwQr/gpjOY6sgI=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=uA7KS1pf+lUuzQxl1QhDlwRi5shXk9oTicsaeNiL025SUoKNUCO7XaGQQRh51cYLC7uRpJ8gaWh0tVYh4n6iga3xdebQy4PlmHIBhpLUaPVsdeU+OAzAvhXWlDaN0MRwhFs/AIYr4IEAJOGemrTpIr3UcWm+Eje8Ay9sMQE+Y1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+3tN/NV; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+3tN/NV"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f4f505118fso20613351fa.3
        for <git@vger.kernel.org>; Fri, 30 Aug 2024 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725020428; x=1725625228; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tA74IIwrgAgRDQ3RLmt71AIAu7n51I+6o9Q47GQTYmI=;
        b=L+3tN/NV8c5aggifGR4JDv3wSFo88o6WsGnnjpEJcUEHSSilC/9GaLdHOO+ompr1YJ
         0/utIASczjmjHvqepJJau9pfl0G0xAxFNmF4vUzu3K+GQhxVpVUXG0L0UxcCHKLFq1hA
         M+KZa+8z6IwxXZ6subHacFkgWiC5mmAO9rx/ANClHY5t2vtGuaJpBCFo3wO42lqp5fO3
         dFNjYaydt1qP0lNu+Gyqt2P1VsGw0aYxcI7mPZk1ZrKI/NToiytV8piGVheYvnhkRGlg
         MIWLrI/0/cxoiv2l/7eZ/sxpWEzOZVkwjH/hfYKVMIzr0z1SR1dLWpCC9k3mhE3CoYCx
         gZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725020428; x=1725625228;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tA74IIwrgAgRDQ3RLmt71AIAu7n51I+6o9Q47GQTYmI=;
        b=WW4rrU4SkMK/b3U1Jn0daHgwXWZn6flf1USfc6qRujjJoVkgRCQ8gxK1I+kCv4BrXM
         gtWGOeMyMmv9TofwoSrjLX2nzMFuy+2iMPK+TvRt/nroWjiU3gz+Ys5c8esxrEUz4wd1
         Y/CmPacgr7ORb8CkDtl0zO6rbn8W1TdfZ9h2kMKdhPus6crB6sovpMt2IeSK+bBTz2ry
         GzTzn6/RcmOHxDWU9BcYQkDMLCnKzKQnvazXkqNUg/ZVc10jzo92phWtlpGHcTE8iZeG
         UBOJCUckFTwMqF4s3lOlLcsBTJZwcWAIoEEc6qcKylFUtgsiOOs1IvfhnJS3o8XyNJx5
         kSMw==
X-Gm-Message-State: AOJu0YwLScnD/YpY7pWI5bj9WA+2f/a2N1dPXbU/vAHBI8w2UbwMM7pZ
	dADFqO0EfimGRANxkHtio+yq9H0hb1fninEf3MPR3bIU3Dv3KORiJD5EKA==
X-Google-Smtp-Source: AGHT+IGHou8Jgfl7rIA5K1nFcqGlqVEd5L2oT+Xd0C8doMYZIQIEO29hshvUEz9/oNtj6tMzwfpEsQ==
X-Received: by 2002:a05:651c:19a3:b0:2f3:ed84:9e66 with SMTP id 38308e7fff4ca-2f6103a6ee7mr48085961fa.13.1725020427132;
        Fri, 30 Aug 2024 05:20:27 -0700 (PDT)
Received: from smtpclient.apple (88-113-116-214.elisa-laajakaista.fi. [88.113.116.214])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614de9744sm6518671fa.0.2024.08.30.05.20.26
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2024 05:20:26 -0700 (PDT)
From: Yuri Karnilaev <karnilaev@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Unpredictable peak memory usage when using `git log` command
Message-Id: <60B730E6-F3C6-4B57-94D6-E5A71754DAF3@gmail.com>
Date: Fri, 30 Aug 2024 15:20:15 +0300
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51)

Hello,

I encountered an issue when using the `git log` command to retrieve =
commits in large repositories. My task is to iterate over all commits =
and output them in a specific format. However, my computer has limited =
memory, so I am looking for a way to reduce the memory consumption of =
this operation.

I tested two different commands on the `torvalds/linux` repository as an =
example of a large repository and noticed a significant difference in =
peak memory usage:

1. Processing all commits in one go:
```
/usr/bin/time -l -h -p git log --ignore-missing =
--pretty=3Dformat:%H%x02%P%x02%aN%x02%aE%x02%at%x00 --numstat > 1.txt
```
Result:
```
real 594,01
user 562,22
sys 12,43
          7407976448  maximum resident set size
                   0  average shared memory size
                   0  average unshared data size
                   0  average unshared stack size
              187437  page reclaims
              274228  page faults
                   0  swaps
                   0  block input operations
                   0  block output operations
                   0  messages sent
                   0  messages received
                   0  signals received
                1031  voluntary context switches
              287056  involuntary context switches
       5455479398547  instructions retired
       1828253079874  cycles elapsed
           135_616_064  peak memory footprint
```

2. Processing commits in batches:
```
/usr/bin/time -l -h -p git log --ignore-missing =
--pretty=3Dformat:%H%x02%P%x02%aN%x02%aE%x02%at%x00 -n 1000 =
--skip=3D1000000 --numstat > 1.txt
```
Result:
```
real 9,83
user 7,48
sys 0,40
          2390540288  maximum resident set size
                   0  average shared memory size
                   0  average unshared data size
                   0  average unshared stack size
               93487  page reclaims
               52995  page faults
                   0  swaps
                   0  block input operations
                   0  block output operations
                   0  messages sent
                   0  messages received
                   0  signals received
                 634  voluntary context switches
               14183  involuntary context switches
         50173495540  instructions retired
         24906960156  cycles elapsed
          1_470_935_680  peak memory footprint
```

As you can see from the results, the peak memory usage when processing =
commits in batches is 10 times higher than when processing all commits =
in one go.
Can you please explain why this happens? Is there a way to work around =
this? Or maybe can you fix this in future Git versions?

Operating System: Mac OS 14.6.1 (23G93)
Git Version: 2.39.3 (Apple Git-146)

Best regards,
Yuri=
