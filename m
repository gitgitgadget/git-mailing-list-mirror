Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246D26281
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753736961; cv=none; b=CmTjBIKOor97s6QxDV1DNREz0qgfhdF1ipKwcuhs6Yu/qOlKItYiwYAQQuPQmhdCjt//M/0UpFFiPHy3g4n2vd7H4eD9QL+zLRy3P8RsDXaFGe7g2T/pRrS3nAUqhQS+NjyHu1wMswwsxGFLFp00EeHosh360hvsWfmfGv2LHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753736961; c=relaxed/simple;
	bh=JE2Cu5SJUgjmhnv7mODOaAUbRBHgEcIhXfF6U/H/B1s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mT7Fbi5aX7uoBSfTh/nCEY50RhTJ9Vg059aYSmAg9zoqXV6QWjvX7KIn4Amh/Sq3Fed7Jo68y931gStt/5M9oiuQ70r/H1MyH4kzBlwQvDnflyECZScJtuWJzy1SNnY5/VXMIQ5SeUtIWas5Vo9U6S1s9p4vza1U8LYWMZ4d+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+JerXC/; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+JerXC/"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-879d2e419b9so3430199a12.2
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 14:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753736959; x=1754341759; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EtOd2E/zkM8te9UY5079dTKe2w5JmnoMDOE584+7Jlo=;
        b=G+JerXC/8KuyRdpGX07piWW6GkQQx+9uD7DYb8h/um0vWePfNkuWrfZvlKauic6u/a
         XAsKdfL2FyN7MoFkaiAPZUoj3ygWCkEuDC0N2GhxWnSgrWpAquiO89zDUI8hEeTLp3co
         b6m7jDspJa/eotVLyGHry6OCNAyYJFAnOUye528ADm1s0xx3CmQQmzAibeLAwvpvOPh/
         7OQ01qOB7SfjQ9En4eHA7po1lLjVhBvYx0T51N1mYhkHMa+sTbcWqVDH6kUhm8vh+vyA
         NGZsIFhxEucpKXdHMo9OOQjq6/QN7vaUX0OXaeXYFtgumFCe9gde8YbjKxXfdo5FFocI
         ZozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753736959; x=1754341759;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EtOd2E/zkM8te9UY5079dTKe2w5JmnoMDOE584+7Jlo=;
        b=IdaykHtiK4TuoCwbptE2Nw4L/fnPISAanPNVNdhUpGDxe4eEyA+BOicAYdnPOM3azW
         5fJGxRq8AI03HoLjgpw+EsrmV8URL34kJ+95IncY+2THc+yiHRujaCetqeCsW3rrT0Kj
         IvPkk2GY8VYQzpjBPwZPXB1nWVlRAebO4wzMtfo6Kuse9BZJXPWq8h6UjQNvzxv7YOUp
         ALgHTimgZYIPzljPTfsHa3XeyQW75fP15/7GAnpKpybNR9BQBPHV9gpNKwLtwWYiH5ME
         oaE/HxGRKsksw/y3LDRRlmOOPIHHcs7jaebRWle9/I3TNBUjfN44WInBzSaIkviZj9oA
         ciNw==
X-Gm-Message-State: AOJu0YydGceyr7j7lZWp/daBvZl6CcqEH1yBGQqPlhZYvd42YJu3fBtm
	hybH0kvVYGuJqPz1tz2c0caG2L4sx9btFVrQ1YQlXQFK9cyv1fw4A+GZZNEcrBHjsCD2Bsq/+oY
	hDtAHwvDZB0pce9MqWF6WmKB3FLrHfSp0PxJdxj0=
X-Gm-Gg: ASbGncutaiz2jxgVx48uqVX+6XmQSNb5puJS3z9Expm1g+32g3UnUyVWctzkHKYVGxA
	JAym1OyysWJegNUOqjyGu1cOvcwiItyja7CGIwfU56C4YzGGdn8WJZJsfztxgIRueUiEjTne24P
	dtG6euF7pYQzSx6TcX0sRqqyzBXZLtRzaJrlDdT5s/ABRJBS6UIy5q0aykXqAYvvLFrAzWbfDhs
	wiRGAo=
X-Google-Smtp-Source: AGHT+IH/oC8xJxjDK+DWiJjGqU7DiDCNfDE4W7Al3exSZhqAIABlClup46FKKvhkYzSEqWbBGFnVvMFSr7HuSSr96Pw=
X-Received: by 2002:a17:903:181:b0:234:d679:72e3 with SMTP id
 d9443c01a7336-23fb3100766mr207540005ad.42.1753736959049; Mon, 28 Jul 2025
 14:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: TDD Guru <tddguru@gmail.com>
Date: Mon, 28 Jul 2025 14:09:08 -0700
X-Gm-Features: Ac12FXylpoYQTRpeJN0sJZ7jztMTT56py9wgE93-SnLYOaARLI3W3S689CpQHLE
Message-ID: <CAK2EJNO-FY+TzAnwtOhAgbWpnBP1d8yfjPidWSd=rVKM6rrdhQ@mail.gmail.com>
Subject: gitignore pattern matching issue with Windows
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

  Git does not seem to properly handle the pattern [AB] but it does handle [ab].

Here is the demonstration of the bug:

C:\gitbug>git --version
git version 2.50.1.windows.1

C:\gitbug>echo [ab] > .gitignore

C:\gitbug>type .gitignore
[ab]

C:\gitbug>git check-ignore -v a
.gitignore:1:[ab]       a

C:\gitbug>git check-ignore -v b
.gitignore:1:[ab]       b

C:\gitbug>git check-ignore -v A
.gitignore:1:[ab]       A

C:\gitbug>git check-ignore -v B
.gitignore:1:[ab]       B

C:\gitbug>echo [AB] > .gitignore

C:\gitbug>type .gitignore
[AB]

C:\gitbug>git check-ignore -v a

C:\gitbug>git check-ignore -v b

C:\gitbug>git check-ignore -v A

C:\gitbug>git check-ignore -v B

C:\gitbug>git config core.ignorecase
true

C:\gitbug>ver

Microsoft Windows [Version 10.0.19045.6093]

C:\gitbug>

Rex McCarthy
