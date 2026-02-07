Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9D26CE3F
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476029; cv=pass; b=TKeLOAbremyKY5Br8tH8Ue9dXFH6QGyC45ZTn5KNjT5JdkbdY1F/dSG+I2LnkrriNML8yHPCNcmcG5AvILCxXs6g27UOsei4sUYoyDYlhb2FT92shCA8RPY9hZ19L+NqV4ay+ZZ9hymeAZ4p96N5yNZ7+NU/UL1NelhvcqFq1Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476029; c=relaxed/simple;
	bh=KWNPwgu8md9bajRJ/GggXXwwsbLRyD0OH4E81cwNBmc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=D2T5RsuQx1kC3JW2C8PUZYaeHyfay/g5ZISr1Z7swDgPqYrDjwn4MKomBiDjLmylGhgVn2g4z1GM1AqhQEUVVc7rVXVhyboFueFjFlavE9SaDGmJ459l7rmqN4HKyUAD1YOGxImUrHq8pLTYF455ZQ4Wz48wqKHIKDG65rfr5ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=abstraction.fr; spf=pass smtp.mailfrom=abstraction.fr; dkim=pass (2048-bit key) header.d=abstraction.fr header.i=@abstraction.fr header.b=FXj4EiPg; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=abstraction.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abstraction.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=abstraction.fr header.i=@abstraction.fr header.b="FXj4EiPg"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so6280191a12.0
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 06:53:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770476027; cv=none;
        d=google.com; s=arc-20240605;
        b=HfANpRG+F/8ucKenyiFvhk1Ot++51iTgVhYOqiw7mfqiIsEwhDHGG1pIg1KPcSa4nU
         nFrM6qJhBS/PQLGya64friPPrb7Qbafj3HP1E4cOs/wvAiqAuVxFKrRrrLE6OxNqyk05
         JIVvcD89M2KRGStaBa2gZEV8yfdYB0Yjz4jlwahFhkwiIXRnUc4cMkOL80fHbxsTbsHX
         TQnsLz0F98fUfA9zKOHwBpF2wienT7c2A03kHILvG5sJwkGw26ri1YsXONCYuG1Fmi9g
         L/GHVxsiz7SfSv5IV+6YQ7Hxl8o/n++aaEbdZVq0rAictBYzyRIh3xgkdZ4dX1jYoLZb
         0U8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=93iBTuzGo2tF06J6yDHAjYo2Ku+oG7fYomW4OmO6FAM=;
        fh=EbAi3aH7dvp5fWvHzbiEGXPrqvy29bDdGM5R7Dlg3ME=;
        b=FCF5p3AakqgLIgZkVw3IK3IpaX2MAE9k8YUQO2OzcNA20HOwJkOwGgGiXbtQCkT8/i
         tBXnd7EPAMr2wrufWcnvsVMeeIo1drt1vTXBlZO4CBxHmRGrBciJ/BTznTw6Q9YRW+od
         5V71Cjk+q/GG+Ggh86RYZQPvIovlyXa94/QR2EQKlcWuBIHE/4e45F0F3b8VC7UTLkOM
         zA2HH8FrlvX57/vUjy5Me3UjbwbY/gm+8QAxYviB0a/uUuA8HJlnNmWoLGGwo4e28wIe
         6GT7F73rqbJEJPh8Ip5Yi6hVgT6rOOIGQeu2tViIYPA8JJvGkeqjsNXSFM2qIm8tA4mT
         j42g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=abstraction.fr; s=google; t=1770476027; x=1771080827; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=93iBTuzGo2tF06J6yDHAjYo2Ku+oG7fYomW4OmO6FAM=;
        b=FXj4EiPg/wtdeZxr1ZxHkezOv+iSxHMFt8fRVk0MRory5y09oxD+nt1AAtNTKZ9D8S
         Ce7UPfRS32bUfJ9p7uDZrJYewX17pU2tQAnkxcJb/c945wc5XXBNPjtTHMe+Dl1uQRWK
         usidPuCUTWYXeCsoYZyEHiI1OVsDa2fmasMEVUzoX/6277YcZOHBlF6ZbKt96TYZCSK8
         a+fE2PNxk3e6x6jeKCJblSCQFW0a3/rUvkCRzJAoCj8ZOfFNRSWeRJpYvjLSOiUpTvKw
         ZzcPMj2Jhak5z8S65AOCY93tqY/HGPfEXkSDQFw6JlK69Aoh6hgUbCBcgpSRKxpR585s
         5rMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770476027; x=1771080827;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93iBTuzGo2tF06J6yDHAjYo2Ku+oG7fYomW4OmO6FAM=;
        b=X12WchnDu18rMzbQtCMyx3Vz5atVSoj+lqnGNVvK/juKCdibZJvFxnlrndudTCQM6k
         21OtYyMg7urRTF6wtQDV3RjPHi2u94pSaRREH3xkAcRP3jTl9FrNov6k92QqBbEBCCus
         pynJNvP0yApi7BugwZ2+S5g8jrg/QaiJqKPlTpc30D1BALF9JJuUgDLovZe5YmIevoeI
         wwWkOsyCIWf333k8735akCK2ogAZ5rg0h6ox5A1bW1Lzycvv4uqthMOWG2EKzf1oEjem
         BRewpOW4e9KNi6w5l/5zyfhVfo0Sx1rmB7AS1p28TOQ+VrO7j6I9sJaWFBY4Fq1C9mug
         m76Q==
X-Gm-Message-State: AOJu0Yw3HkJ39IYFQvpPCLjHsJZrplJkZLsf7OgrNhY1x/7mjr0ej2zk
	kgKnncGjJho7em4abupecRSGmXR7afH1DB8SZxaSeBCk7qBwJlFJN3vBiqJT5Lam3VUTdKPpIzm
	CP64po9wmj99/bQOZt2PP5KwAMLBTP9KoVy6pL6KBv6xR2+enmMBVzrBP+w==
X-Gm-Gg: AZuq6aLRt6AifEXkgwexYrYShfoKv9iezE5x0RfgYXf839BlGyswxqOOIJ/Ff9DJqrx
	oE1INN516qY5RByk3EO3uvUr6s3jOeBdeSTPIGp0xprktcQ/q/98+5KdigpabrSf8/07kXreCq9
	0F+qfNkUiFB1lMYlO83v4PpUqgteZ6lfC+p3Ols3pKrRxdmElkZbBWyZLoQKGVB3DrFHMsO0yha
	TV5P9fpc5a2axKAp5R9V1yo4uyioGzKOGGiMWlj+clYRclk4ZaxNKRDbCCvsj5IjBP/CI/caW5S
	TspYhR4b8lhLgPDezDpojJ6C6gDw
X-Received: by 2002:a17:907:3e21:b0:b88:1e2:ed49 with SMTP id
 a640c23a62f3a-b8edb830d48mr405504766b.8.1770476026882; Sat, 07 Feb 2026
 06:53:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sylvain Rabot <sylvain@abstraction.fr>
Date: Sat, 7 Feb 2026 15:53:36 +0100
X-Gm-Features: AZwV_Qg8-6Wj0dbOX4aeO_X9sEnIG5T1R4rbZWV9fiG82lA8bfWsCn_UWJnVhik
Message-ID: <CADjtP1FSAQZRyBCjPZ00Y2g=fdtRZWHP44XLqjor-OrYXAN-vw@mail.gmail.com>
Subject: git clean ignore
To: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm a big user of git clean -fdx which is the shortest path to a clean worktree.

However, I repeatedly found myself deleting precious git ignored
resources such as editor/debug configurations so I asked myself if the
git ignore mechanism could be applied to git clean so that we can
declare a list of patterns git clean should never remove.

I launched an AI agent on this and here is the result:
https://github.com/sylr/git/commit/13d0177c52130782bcf7877895a5b497abdfba86

Since I'm no C developer I'm not really qualified to review the AI
output but it seems to do what I wanted. I'm not expecting it to be
merged but I am wondering if this is a feature git would be likely to
implement ?

Regards.

-- 
Sylvain Rabot <sylvain@abstraction.fr>
