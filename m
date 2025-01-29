Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37A614F6C
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738130738; cv=none; b=ilaG+QqvP3EHC/PMrh/hsif4dUSN0HubAGztS8W5+BYxjG30mFlS5Dy6JBn8M/sM/MsH+HWEby9qBJNymdxNCc5PEkJjyFyGNKg6c0YzhVxtAtzf0J4zD8LPkwBfKcdtfY/AQ7GQ4SUsbzY3WBXGYqgCujAlR3Cxjf4l6gDrITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738130738; c=relaxed/simple;
	bh=F3Xi2P9XdMvfC0yqBdMP+dANmU8zIZ51icATeLsfPs8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oL9B8h/rMajpsvDCtS2x5Go/12vC7hxwqpMliblZxKIJUqZD/+sx4f9zXxF8WQnXRJYw9gZP3xq0XJ5HAyZa3t2qJ3TZStOGDDtnczBQKf3921WYxzVXSZv6KCDqQXtNgz8VwY0mbrSzBFxemJdigZCmAUWvONNSesZeVYKgCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z26D2Gpv; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z26D2Gpv"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso8614059a91.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 22:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738130735; x=1738735535; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jF7tuA4qRbg1UBmc1WM9ZHcIUFAf9QXjX6CTfZMOCuY=;
        b=Z26D2GpvpAbwXDsCQakblcMRQgvkiag/dOPpwDKUGcYQB8Xv18z5xpU6ga/28XctGk
         eqosaXAkfg0olAJwDJvmhNAYDYsvgEa9da78IUVDduhxlGxX5d314kIV0qN07xShl1Zu
         IyIrYsVgS7wUMWrZKzJkIWyt89sujC19a/8xgtrJ0ILcFbSp4RbHpKXbA2dHz70TcKmP
         kmc6WmUmGtDYqk4213DWBN8lOX+DiCf2MnWQrQR6wIZkVHoxPxYpbw+6fF6cuziSvLip
         FDLbH/UOmigl1Qo9FIiX75Yj12m3hDLh5NDXrwugUp8bUUEvJj8L7G6G0zHtJuw6Rep/
         evvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738130735; x=1738735535;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jF7tuA4qRbg1UBmc1WM9ZHcIUFAf9QXjX6CTfZMOCuY=;
        b=L3sesnUFU0slzUdslPbNhdLFOmLUbxOldVk2oN4PpVVjvezKdvIJQVyrrAN8dyZRVg
         y0ukCnHRGmM0wI/q3e9MebXXV6QLj4Cmeq28++KTaDXBe9zH6xvzFsmGUNfX7rx+n25w
         TaXAnoYzTGqHDt76oIcMzW3J24bGzD3vBZ+dDDxBUqIhAayI7hhpC0VRTWE4Ph5WEDlF
         eDsym38RZTBFAmvUUQHFASmV5s2fdnSqzo1QjNpgEVJzCYBZfuqV9WKICV/U1PC2+ntC
         c2hz2ip/RCYo6/OYyGHvHFzJ3w2kDgvnLKzvZov65utEqoydDEkyqFntv3SVhPibwSgD
         hj3g==
X-Gm-Message-State: AOJu0Yw2ro7Wvld5PwIYs05zNqhnK9cZCaMTyEpwmQs7z64tYtvoLbuG
	6j75UwLugpYFPJVTxitg3jHKXK8Hqhr4UErrscYiHmePcJo/ZyKl50ielboRC6S4NOFqKj9IibR
	Lg1sE7hSRYAoGkYfLWc79AMtL987bnvLG
X-Gm-Gg: ASbGncsBBwPAJWxyQPD5MKIcO+i794MzU1RrOOLoV7Tg6L0QCsufCBrR5Rgf7abmR7K
	XB5kjEh6yLjsxe0mNf7C0GKZ3cH11/pRSHJH/lv/tjccbawgr5rOOSEZCqi833zfKu6RslfxF7q
	J1AR1PUJJTldw7nrHVdHex1KQWgYRnPg==
X-Google-Smtp-Source: AGHT+IE10kcTOwh2A2OY3gqfw22Z7KWLElMNq728WQ8RnX/i/Jmpy4dTnPTS7SKNSB2ocQpUxlB5QBrIMIokpwG8RhE=
X-Received: by 2002:a05:6a00:180b:b0:72f:9f9e:5bc8 with SMTP id
 d2e1a72fcca58-72fd0c74655mr3081143b3a.22.1738130735433; Tue, 28 Jan 2025
 22:05:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Raghavendra N <nraghavendra89@gmail.com>
Date: Wed, 29 Jan 2025 11:35:24 +0530
X-Gm-Features: AWEUYZkIkQ1lg9tI7MsfZ1-NF525axxMkco79-i51h9xLxtQXIkfw8TyQbqDuAk
Message-ID: <CA+U2-7GiHq9qhiyLPLgzOd1JK072gzkmZ+4vQ11V0QpKgPif=Q@mail.gmail.com>
Subject: git diff -G: Regex pattern to exclude a word
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Members,

TL;DR: Question is - How to use the -G option in git diff to exclude a word?

I'm trying to understand how the -G option in git diff works.
Specifically I'm trying to test a Regex which excludes a word from the
git diff.

Consider the following setup:

    > git diff
    first-file.txt
    @@ -1 +1 @@
    -Lorem Ipsum is simply dummy text.
    +Lorem Ipsum is simply dummy text. tree

    second-file.txt
    @@ -1 +1 @@
    -Lorem Ipsum is simply dummy text.
    +Lorem Ipsum is simply dummy text. ball

Word "tree" is added in the first-file.txt and word "ball" is added in
the second-file.txt.

If I run this `git diff -G "^.*tree.*"`, it shows only the first-file.txt.

    > git diff -G "^.*tree.*"
    first-file.txt
    @@ -1 +1 @@
    -Lorem Ipsum is simply dummy text.
    +Lorem Ipsum is simply dummy text. tree

This is correct because the Regex is checking if textual diff has an
added or a deleted line that includes a word "tree".

Now if I try to exclude the word "tree" with this Regex
"^([^t]|(t[^r])|(tr[^e])|(tre[^e]))*($|(t($|(r($|e$)))))", it should
only show the second-file.txt. But the diff lists both the files.

    > git diff -G "^([^t]|(t[^r])|(tr[^e])|(tre[^e]))*($|(t($|(r($|e$)))))"
    first-file.txt
    @@ -1 +1 @@
    -Lorem Ipsum is simply dummy text.
    +Lorem Ipsum is simply dummy text. tree

    second-file.txt
    @@ -1 +1 @@
    -Lorem Ipsum is simply dummy text.
    +Lorem Ipsum is simply dummy text. ball

So the question is how does the -G option work in this case? And how
to use the -G option to exclude a word?

Thanks,
Raghavendra
