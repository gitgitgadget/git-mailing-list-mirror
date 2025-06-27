Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB628F5
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750983257; cv=none; b=ft1Y6o8eRqmBwJMxr3HQYjbqGNkwA+19+mUWWay/hMrc2mhXBgyfLijP/7t2BXRgEHTnD0wBHV0hhnRdqDSLWza5gEClQWiN2kN3n3rtWsD61PmGD2/RwsDt5UTjfmaKjXxDWPEqrxefSQjvNQyOn0RV2BIAkeXk0RmCgbkAu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750983257; c=relaxed/simple;
	bh=XAyYXYVmXjHEt+6kAzvL0g5g4NQ8SnhuY8YGifVBTbA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=vFVRGzXXsr/pGkUnQdDn0jLIRryusF95OWAyT5+o+sGELMYuhD1KjUgrakZrJ926Z2/XZWDaeRtFVZxWkDDy005MBU7yaPTMGUt2ygzK4SaK+ps8jyditrOKfQVEBWflhqndIKa0231N7MXn6sAQD6wKGvy/uX6YPWv49kLBiYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=erwanleroy.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=erwanleroy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e733a6ff491so1391019276.2
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 17:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750983254; x=1751588054;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAyYXYVmXjHEt+6kAzvL0g5g4NQ8SnhuY8YGifVBTbA=;
        b=Cl1YRNaOnMQX7nB8SIby3cSQachAAUJrQBU1VGG55yWxH+kDUfYbPbg9ZqXDfHCC/b
         nfkZ8gFdj7qJgSD/oS4/BGyH0ZgZ3QDP6cKUqvEirzfSeGMU5GevJyjQpDltN58gqn/z
         D5xLxH4WhLxMQmuvgeTquD1zX1KKbD4KteHFYJZCp6kC+CMZJ+R8WbL/bH+v2u0U1XVt
         r1o075ADBaWQHly4RRSPLeh8GemD9Bk9RT447HBWFdlIgrC7hFEMammS0RAdKvc65NaL
         GA8jVEfpzozLjs5pqPmwapxr26Itb4aoz/ForHt+wWgjhRA63bPYWYU3tnKYFXv3ekV0
         pgHg==
X-Gm-Message-State: AOJu0Yw1l05v6pHonDoJ6dKq6CyD6MEaW1NdlR2S3w9C5sioLyv39dvi
	t1DRRt59E1hsUJHd4P0H6t39ndOGE0Zh/06K3PeAkPWOwpHC5Fg/X8jxeuH3dBNdL+jT2BMZjq+
	4HWKc2ftSxa+sobDhlFuGGK350MmC1GmA3iHc
X-Gm-Gg: ASbGncsadtPfnRaPnxwQF6vILHw3V6Dl8rtLZ2tnAQH1vjsPexIQ4inXUKVEX27O2bj
	8/s3og5uCLktxIT02xxLZuj4BCzrtks3fLtn4ql1IF6wKgXTrDO2hmQw6Q6njb6/eo6E39mALAd
	3zJig2dt0PxJkr7bShe97xTHoFNmRouOyoBjKvreB/eQ1ggJfRUWUpbI2FML/qrNSnk/eaRBleK
	aQZgwfTzE4pYkQ=
X-Google-Smtp-Source: AGHT+IEXNaCdhb6kOk6Adjzz3spODWOcpJdvfMU+kEjRnelXyym1Y9TvyymRQszxg5ko5hwpU5DoQ0KhQ4c75YisoKc=
X-Received: by 2002:a05:690c:2902:b0:70d:f673:141b with SMTP id
 00721157ae682-7151715068cmr24190047b3.13.1750983253913; Thu, 26 Jun 2025
 17:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Erwan Leroy <erwan@erwanleroy.com>
Date: Thu, 26 Jun 2025 17:14:02 -0700
X-Gm-Features: Ac12FXw8UHsS1gwKQHLyeDkmBcVokhHfYabzXtY_j72o3wOLa7vzvPEMS-VbVRM
Message-ID: <CADT1yYmQGG5mQnWk=+19UOEvcDyiUQmWsib9jUJsPDc=A27vMw@mail.gmail.com>
Subject: Git "Permission Denied" errors on DFS path only with newer versions
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello.

I'm writing to see if maybe this is a known issue, or if there is a
possible known workaround. I've not been part of this mailing list
before so I hope the format I'm using for reporting is going to be
correct/helpful (this is attempt #2, I did not set plain text the
first time).

A bit of context:
At work, we are fully Windows-based, and mount our network drives
through DFS. We are fully cut-off from the internet so everything we
run is local to the internal network, which makes certain tests a bit
more time-consuming than they should be.
We have been working for years with Git and a self-hosted gitlab
server, and have had no issues.
Recently, some of the new hires started reporting lots of Git errors,
mostly apparent permission denied errors.

One of the errors:
PS Y:\Users\xx\Public\dev\test_for_it> git remote add origin
git@gitlab.xx.local:xx/test.git
Rename from '//atl-xx/Basecamp_Atl/Users/xx/Public/dev/test_for_it/.git/config.lock'
to '//atl-xx/Basecamp_Atl/Users/xx/Public/dev/test_for_it/.git/config'
failed. Should I try again? (y/n) n
error: could not write config file .git/config: Permission denied
fatal: could not set 'remote.origin.url' to 'git@gitlab.xx.local:xx/test.git'


What we found out:
- The first thing we found out was that only network drives were affected.
- The second thing we noticed was that not only new employees after a
certain date were getting issues, but also longer employees getting
new workstations. This started to make an actual permission issue less
likely, as there was no change to their user permissions.
- Then we noticed that the delimiting factor was the Git version:
Users on Git 2.21 and older had no problems. Users on Git 2.36 and
newer (we also had some users on 2.47, and today downloaded and tested
the latest 2.50). I would have tested every version in the range 2.21
to 2.36 to help narrow exactly where it breaks, but I can't find
pre-compiled versions for old versions and I'm not currently set up
for compiling from source.
- We also recently found out it only breaks when accessing through
DFS, if we directly access the corresponding UNC path (what DFS
resolves to), we do not get the same error.


It's not excluded that there is something wrong with our network, but
the fact that it works with older git versions and not with newer ones
makes me think git has a role to play in our issues.
I wasn't able to find a changelog, if nobody is able to look into our
issue closer I'd love to at least be pointed in the right direction to
see the changes that happened between 2.21 and 2.36.

Thank you in advance,
Erwan
