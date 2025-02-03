Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E41D5159
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601151; cv=none; b=YD/coiw4Yx8moEUh9HQVGxQAA0gpgq7+BbZaZYTy729ir0BYYgiaAc634iMYDL7r62Ne1+jcpH9SOyHstLAx8+H4/XKdtPqA4BS7lg+hLUEYAYklepcYQn6MOajkSvMeWnpvp6JO5Xx9BCJ/JOjjhCETvOAypxjoiEfx60HjT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601151; c=relaxed/simple;
	bh=8DZdsVCrXYVvZ2qyO0wx90fYV9UD8giapr/Xbc766LQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ra4eI53jbAT6nhHD5BvilFWxYlLst2vdwvCmTf9XUa7eQwjD9M6sA5y0DD4E0LD6LYmeumJhB5+ix9MDcH6f9AUtvrTZtBxzNvqOFBrJRGq9bfn0pf/R/3HwjTigi27d9lkAsPX63JSYdwKRWE9Mzj7wwxKgOy71tVMra+IGs2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZx02TWG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZx02TWG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2156e078563so67102125ad.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 08:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738601149; x=1739205949; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/QxN3obrx2gccde6kHYdTG7dtrTQfFQuXhB4weAamnY=;
        b=WZx02TWGU07eNd8SoRAL5sVV7lQf6f9SM3hFIU8oIfdbyJm2963lNvs3gpzf0e5Ou0
         rfzMCQ9Etb08d1sq4CZC6H98GA/BDM6De6Nf1rWJOhsltNKqj0oYSGYTzPCsRoUmM6Aj
         g0nzqGdTNsyU4WFT5xUw3GAd2lhhbLy7lja8BwsgvT6TGGwt+Giwrntb/DxXcNNQcda9
         dveQBiStU5zf6Goj4CsL3knsGAAl8I95lM8ntyAvugWskT4bQIjVax16062XDHkZzntV
         fWR++Q/E5nq7/Z84kJ+3gmXr7pOKTpx9N6ePlBpS89DuKdiQ1kxp8WWR+RiOmemXMZ5s
         lPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738601149; x=1739205949;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QxN3obrx2gccde6kHYdTG7dtrTQfFQuXhB4weAamnY=;
        b=DsZJcfOHu4/Zaj4YI87lYE21JNyOd/eA1Z8SIOfFrUpPorzpp/CzoteBJ3sJVmjEEE
         NFHNsGc7j5LIm3ivpAxTo0q0N3k9GDc4iyaBDWXeGKN4f56mABZY0QNe/g9R6JCaxrYN
         jKIre4TVB8kxwltVyE7+/zVgkRaiM2hzNfRl9PM8vIgPtf/3hdVMLwJKCFRZSkQ33ME6
         mcQ+qVs1gi2ZnWX7BscISAkos1zdNCpjOpwjR8AJp0m7sf6K9KBNgv/kRhU97kxgpfAO
         n4MFEdUQ4M7zcMN4IM1BgqtcRGQYA7twYeK/ZJfvYTmGS4xxUwL7KBVfYhYFrcGAPq2x
         Y+lA==
X-Gm-Message-State: AOJu0YyIFbj+7Un56xiXlgN1R2cAeOti17A4nXR95i0Ca3cCcYhhOhej
	d3UbVNRPSmDukhRIPbr+PSfS4YmEOAI/D7kB4aYaGJ6DNroas8hkzKOYv5zoqW5icIIjloQ3UvK
	+I0+ruVVXeXaGnyH5nKG9LMYGqIGyG8FY
X-Gm-Gg: ASbGnctx4Up9H3KUm6dqp1EaU/cS8pjpVVFDgKx6IRmqCbl5Vzjp4W71slDZXyKYzoT
	Fft6c925x9LEYqs0xGPwUO2XDLIShd039XKSkcKJ51nQ2qrPDDCzRtVIoRcwhbsCkts2YdWM=
X-Google-Smtp-Source: AGHT+IHQxMe3qn4/LSwNwgWJ3smMLUy2wzrYBVbbahxFZSaTI68+tlvw9y4NCgodFKUBHdA7w1+lieH8td1c96jlYsA=
X-Received: by 2002:a05:6a21:6b02:b0:1e1:bf3d:a191 with SMTP id
 adf61e73a8af0-1ed7a6b7a37mr36199597637.33.1738601147621; Mon, 03 Feb 2025
 08:45:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Manuel_Qui=C3=B1ones?= <manuel.por.aca@gmail.com>
Date: Mon, 3 Feb 2025 13:45:36 -0300
X-Gm-Features: AWEUYZmkFUYut-arMxI8mFRZalI2TOoW21paOjx3oQOtTKpjQu2Ym64qISWaVeM
Message-ID: <CAPpV+OaMcViVKok5U0-4HaYyPMKEA7BBzw4t113uAaMndjs5Cg@mail.gmail.com>
Subject: Usability issue: "Your branch is up to date"
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
I've been teaching Git to a group of young learners lately. They find
it odd that commands like `git status` or `git switch main` say "Your
branch is up to date with 'origin/main'" even when there are changes
that can be fetched from the remote. My proposal: Add the timestamp of
the last fetch to the message. For example:

```
$ git switch main
Switched to branch 'main'
Your branch is up to date with 'origin/main'. Last check was 2 hours ago.
```

It looks like the timestamp of file `.git/FETCH_HEAD` would be enough
to implement it.


-- 
.. manuq ..
