Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8A10E9
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736584230; cv=none; b=eK0L5SJjzJj4wd+mpHJv2k+YgOGj/tG1OzX8zgvA+rccudSmC7amf1B95flwhQC2LEESwTzPfrAPK/LSPN+yj2oLCrjavjIqNwZCb5qomjI5LN7layeuzEnGeHKmYgj8t50+NNLo10Xc5a1YUMKNzfKxos+w/9VGDo3mlmje6d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736584230; c=relaxed/simple;
	bh=sdyUc0iG5oTTcvj7oer51bC7JAj3Jcd2FEkFHa7fES4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6EvjL9kxkruKHqfPTDz55cT/TWhs3YbTKtIUpVNl2gkZFUlaUwrsln/fYgfnapOnD54q11RpLXXOFSc73EiljXaMD9okvqBNWKZNYWcT3ixvrE89ta98xDbMKMSk2Ed/nJXhOt51BG9bL4ry6YJE7Ue1WHhFKXepaBRNnNhirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVdlAOM5; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVdlAOM5"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso3642180276.2
        for <git@vger.kernel.org>; Sat, 11 Jan 2025 00:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736584228; x=1737189028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5RHbmwCmfSajkrccMbUp0fzoakPhJVYX3LMOcYMHzbg=;
        b=OVdlAOM5iVRDa/f4yoTSTtPePETw2jhaizDq9Lf7cN2BBTWd4h2TA2Q3wlXJVeHG9L
         iH+EwEY5kJhkbw9tH8HVqPH64TSi2x3n+g7b2BgBq8RVxO0CIJBWTagUzxqfDNUfrU8M
         /oOYTbOp0cM+ibx15Lq85OE4yRuDt29nSbagWPT6qtW4F8u3Be1K1ruTpo3bUhvLm3f4
         SgWi5R+t6ESFXhysKJh0SLTV/RLFGE7DkBsbzL1ubyhMAHX3X4n+joOe/lI3ejer8GY7
         +g9gSO+Xn1yyZ+rZRCQRO18iHZN9z4NPf+pHIuMffb8Vo8OmyKCVk13BuSswUdgYEO7Z
         bWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736584228; x=1737189028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RHbmwCmfSajkrccMbUp0fzoakPhJVYX3LMOcYMHzbg=;
        b=wN5zyD+xRw9ExXrE0nhOEAGBeGs9LvcJbTy5PsYE7yAaHsYJLbkox4VmVTwe+7DE7P
         KG0d6BKLKxfyGqa62yHpogdJtyRy9IygbKx7gWgvYUOWdeVC/VjhuB7iIEqN7rPFbhba
         UkjqBT7l1aGkRrirxiAF5I2K2cAjEr5259RHzi4IxYP0r30MiYdKUzME05+WNd8dDHLx
         wrCkSfA4R6pJP4E/QGKintyF9NYdT3ahB6PKipWubNCcOiflAXipODxX3uvg4W1gAh4Y
         qujjguMyV0PjKeChKq/+LlXW6YkUBdVV8s3UuIUb4Hqp8vNE6Hve10fu05SY4biM6WXq
         EoAQ==
X-Gm-Message-State: AOJu0Yw++S3uhkp24cEERflAExugq4k/5MqvPi9jVGsiampW4TylWkm/
	lmkQbb4DCRh96qGp7G0+XMNQOU30hvdSee1Glec3khC5RiS8VjXGiwzUTpmzs2SDuIpfS2p4f/R
	UzgtLq/u0e7ko0J9VWFLZNvZTHSkQmh058DLM+Q==
X-Gm-Gg: ASbGncvVQ826/lOoPXCmqWnc7pHmm3efkeBbWMEyc+KNWr1cbBoO6CYo6tbo+gq22BN
	tmPZbPbYaxgU1oGskCGxQjxBUGZ5otUHKa6K3lw==
X-Google-Smtp-Source: AGHT+IFCv3ZyAppTthlez3HfeaL8Isdyb0t5UbqMp7o79xjXTcYz+yY2cCCICDdiXjfZsHTmmg36XBsmw5Mdcgw+WyY=
X-Received: by 2002:a05:690c:6b82:b0:6ef:96f9:2f48 with SMTP id
 00721157ae682-6f53130d51dmr114991887b3.37.1736584228016; Sat, 11 Jan 2025
 00:30:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGedMtcSSkmQ2u9yYvKMiWnprWR2VZrbuoT9EX+U6nuxOWiEHw@mail.gmail.com>
 <CAGedMtd0-m54075w97Z4pQ0wqAjgPRA8+HX5iar0POyuC6-GCA@mail.gmail.com>
In-Reply-To: <CAGedMtd0-m54075w97Z4pQ0wqAjgPRA8+HX5iar0POyuC6-GCA@mail.gmail.com>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Sat, 11 Jan 2025 09:30:14 +0100
X-Gm-Features: AbW1kvbw0CpAy3UzteFLhFz0_k667jyfFDmQS3HleHTXfGCBzyWfh0V7IXzZW4s
Message-ID: <CAGedMteK9=wYwCoPMGZ5t+FN_ZHOcSGxDenq8fkVM64oGpc4sQ@mail.gmail.com>
Subject: Re: [Outreachy] Blog: Introducing myself as an intern working to
 convert unit test to use clar
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"

Hello everyone, I published a new blog post on my experience
converting the t-hash.c test script to use clar. I would love for you
to check it out and share your thoughts!  Find the link here:
https://seyi-kuforiji-902b48.gitlab.io/posts/first-round-of-unit-tests-conversions-to-clar
