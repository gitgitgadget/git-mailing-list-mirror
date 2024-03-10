Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C163420DCC
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710087981; cv=none; b=MkqKNGmoXwYIkK6xBo8Nju1nY/6Wo1z4UA2toJogh+WjUtgIS7FQ45Oitz+7xUu4AtMEzLFpeFxBb7svE0mzdvfswc4iuOp8D5exQCJI84oB/+WQ0CLm/50/pv1CxbyzrQS8yZ432EsdQD8JdLlwNzsA4iNtzeRdHHJSWwXYd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710087981; c=relaxed/simple;
	bh=mPTYpJyQww8pn+HrcCPOXFm29vxvXrQyjmGF/7PZtSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YpUKW2EXhR0I+wLFgeiFkhiVfIJUjFQvJ1wHaPvcQsYk2iO4H6BAEGWvddfojJPDQ62/o+l2GitzxmrxB/fPdP0R7pVY2nffan8VjOUg0IOwhk01fJ3jT9uFViTspQS4F8GCSeBfhsQUCXwss5Bo+tiALGjFftHnz+Ivs7VwJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcVkhNnm; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcVkhNnm"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5131c0691feso4769517e87.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710087977; x=1710692777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/dxbx10RAKyJIoSgBKT3kFeW8K4NGzPptQfUTWHVdE=;
        b=RcVkhNnmqlpO62mJV+nbxByzREOjkx/D4LCcS2mPBIjMZfJsfddGTb0E+VWyBoTjrR
         zy0HvIijny+sqVOTPfeGDbR49hCQajieFYDaz628puuImUfGgvR7mjd/HCgq3d9mMhJi
         DfHJVFYxiYFp18NAlyRcxTjH2FVv+9MJ+eEO3HpHkPOmX/fQlotLTJs7QV8Fv+xhL5Lr
         ncg/pF/OcpuVtbgyABoMOJvmJN4Yva1bg/3YTftNqy/yiS0qOYaG7TUGVzQiHIG2oDeK
         3oec7fKUlQsvC5+TOtvRyvkAmG57ad2HDGJH9uYQ9TzKyvtxrmBaPyD2Ju9zQtmyWVdq
         DRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710087977; x=1710692777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/dxbx10RAKyJIoSgBKT3kFeW8K4NGzPptQfUTWHVdE=;
        b=XG4ctgzcrfldx5k7EVcEyju6C+d5oYmYkwX1SqzUknKg2AkUiwNG7JTHr2nCi+aypt
         dMnb8McD2S1WS+aczS+RBSEEaCtxu7difSYwQpDNVsKC8HhhADXHuew73QBgp/UuqtPh
         lVDqNvq90gPpQp3p1VGxBz843BRMA8YJsUezjYXDXy57WyWmxbBw7L+W5U5oFTk6ShtM
         opbSyBADbtiUyVGZ79y8c0lzHBDY0z9AH50lK/fizxyihYFJnHAfjFS0WDPtj6uq+ttW
         yMJInTyNaDUBZvqVeip8lXJIiagl4yuCE9HnCa9ca0/4+GU/EDCizZzPnJQZGXEYcxo3
         odmw==
X-Gm-Message-State: AOJu0Yw6gsw/QWE2aes5eHpxQLDJvlihdTMksiIqiAB54UMPWUNbbBTd
	Pr0ZdIE1r3zYIIKkG/WRjCmlL1f2exobIM593Svyf44BXZjVBC17RrQF6+YEFRm7KkoL
X-Google-Smtp-Source: AGHT+IGoNrxXFnp+Bes5NtJ+OYKmguQvqSUJubuJ18nPL0RFcX5W49ahsb3Ya6lr6huyaAcVAb8PYQ==
X-Received: by 2002:a05:6512:2353:b0:512:fded:e674 with SMTP id p19-20020a056512235300b00512fdede674mr3421281lfu.61.1710087976583;
        Sun, 10 Mar 2024 09:26:16 -0700 (PDT)
Received: from localhost.localdomain (cust-west-par-46-193-56-47.cust.wifirst.net. [46.193.56.47])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b004131f8b622bsm5712067wmg.14.2024.03.10.09.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 09:26:16 -0700 (PDT)
From: Aryan Gupta <garyan447@gmail.com>
To: git@vger.kernel.org
Cc: Aryan Gupta <garyan447@gmail.com>
Subject: [GSoC][PATCH 0/1] add zero count optimization in ewah_bitmap.c
Date: Sun, 10 Mar 2024 17:26:13 +0100
Message-Id: <20240310162614.62691-1-garyan447@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey everyone

I hope you are doing great. I came across a "todo" in the code base 
which was based on zero count optimization. I tried to fix do it but
I am not sure if this was the required this or not. I would love your 
guidance on this. 

Thank you. Have a nice day!

Regards
Aryan Gupta


Aryan Gupta (1):
  add zero count optimization in ewah_bitmap.c

 ewah/ewah_bitmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.25.1

