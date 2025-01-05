Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4831F5F6
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736070722; cv=none; b=Tz+5dk6CoW77YzO2JiCDzwunI9AuxoHtlCMTfKjdPjZZZvxcyFgDSY2uVlb+yac1fy7NvkzQil121v/sB2JJ1oxcoiRCP4trQ00TcMwFonzvdqYz22QOiM2RZh3bh9Av4oAZeEvRBR9RNAHf7yUWCboNdwyxygHluLHdtPDP56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736070722; c=relaxed/simple;
	bh=pczgxvxrp1D5gS+1F5IKd5P+NbYRsg9LF+G/bVhbmqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKAvzaWFaVI27TgsbfD3XnwJd+R/3t5M7s1z0z5V3bl3RFWfVw88lE8VrKW6DlHqRosMNJNSzbbwIz4UymG5yt6IFDQGRUa4IVk0efYQSYP6RSGIzWhufys9GSdCTSIYoZLLYOoDYJltafk3Mb3yyO+yEa9WphHB7unjCHtluR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4677cbea36dso17963511cf.1
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 01:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736070719; x=1736675519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G6wcmcL3WcTO11rSEiR1KvI7+hcPV6l61XUSZN+0MY=;
        b=qy/fMUn2tJKC+dIlUcYqzmE2O4Qwhk3gCFVFa1C/b83f9Z4kpsRSXMNwNUJG8mZ7VC
         sbSIPYC94WwTvzyYbeuDWi3i8BXE1C1S5kCvDG00+EUvD3Wi8QVJ1KmOSNfAe+kr5umz
         JddxuL3rLi9V/Pb/hKHwA3rO3rBu7/MwELvZYw+CVk9hwlKyAWkxBmpyKCJjw9ntBHsA
         KOWPzeJSO7hqkmF7nOe4lsFSavGcRQYhfbRv712ziQV5s55GDhfIl6ScNBKdXgn9DzXB
         UYw3l1zhJzItr7IB7KGEj1xChNi6tplD8FtmevI8419r+4no3u4Z/gFgmpr7oIxAvoaz
         2Fvg==
X-Gm-Message-State: AOJu0Yxk2Yza12yPQZ4yRk/3COXPM8DCAeDUItsjoqIkIrZMoXTSfQbI
	Z9QNXcH2LU8cbE+7/E1Z19bqdxAGO71IBG6oiFJL97P3gJ8WwN8P3gZwUmrRXcXtzF2/ygsgC0Y
	Cmw+U3qZWDMQqodsJbcoeI4egxKgQKA==
X-Gm-Gg: ASbGnctdVU4f3+No8kKCC7EU7VbcT55cjuL//9O+z8FZ6/M1xdXQmwnEyjaTa5B4T5X
	bQ/QVt1DFT8bRWOlm9+uuDQm629mI9PqUahCgNBaCFfqfUObMfI3NlzATIuh0bZJn6NISGLc=
X-Google-Smtp-Source: AGHT+IFmbQTf8ieLNnFvjBgDFAWE6QGv4jOl2CaF761zZ138P1CH6XYkk225f93D2MQlqR+yatxvU2DBSIC6MnlT0es=
X-Received: by 2002:a05:6214:518a:b0:6d8:e5f4:b972 with SMTP id
 6a1803df08f44-6dd2330be97mr316004506d6.3.1736070719051; Sun, 05 Jan 2025
 01:51:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKz1=ZOY7GziF9DNTLXv=G+OX8_vAbvOYS4L2s-D2C3kpr-zOg@mail.gmail.com>
In-Reply-To: <CAKz1=ZOY7GziF9DNTLXv=G+OX8_vAbvOYS4L2s-D2C3kpr-zOg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 5 Jan 2025 04:51:48 -0500
Message-ID: <CAPig+cTjK3_jme88H8D5AiXAoGc+Donu0tgBGYcS2F-KQ0Kfaw@mail.gmail.com>
Subject: Re: [GSoC][Newbie] Test Script Enhancements
To: Rhythm Narula <rhythm.narula26@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 4:39=E2=80=AFAM Rhythm Narula <rhythm.narula26@gmail=
.com> wrote:
> 1. Avoid suppressing git=E2=80=99s exit code in test scripts
> a.  diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> @@ -271,7 +271,7 @@ test_expect_success 'push update refs failure' '
>  clean_mark () {
>         cut -f 2 -d ' ' "$1" |
> -       git cat-file --batch-check |
> +       git cat-file --batch-check >actual &&
>         grep commit |
>         sort >$(basename "$1")
>  }

At a quick glance, I'd say that this change is incomplete and won't
work as you expect.

> 2. Modernize a test script
> Is there anyone working on t/t5801-remote-helpers.sh? Can I take this up?

No need to ask before working on something in Git. You're free to pick
any modernization. A good way to check if anyone is touching this
particular script is to search the mail archive[*] for recent mentions
of "t5801".

[*]: https://lore.kernel.org/git/
