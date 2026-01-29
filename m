Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE847304BC6
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682056; cv=pass; b=r4LQT0NnIWJKXo1Gq2hZ9HqFH2K9urCAPvBGS8EFuMvQOIGW/Q8W+i7fpcpAyFdTLWSTe1cwhvK+XOESHMTL+Drv1VtqZw9mW25lQ5KvY+nzDyADCjnWA0fLNIzY9dqQUhw76lorbXZJp2BGcv085KICcX7GtDOO52+/m4vh9oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682056; c=relaxed/simple;
	bh=DickB8q6pcoqPVmWbcv5kKPLe+4M0lhm+hAJavb2CqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugvPEzb4jbcqDgM3arz9o/5qO2BruGHGlNQhHMeaUv+vzsJdYhiBitSCQbA3JB3ez1KfESvQWFW6s+8U4c6Qr+Yv72TCu3fmbEd9SQJsfTxG3L5Kf2MphwRlE3WCVc4QJJU0QminRvOlkwzv3ZjW4V0xLsTx6+4hMm4qnbjz0H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRTFd6Sm; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRTFd6Sm"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1233bc1117fso1303113c88.0
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 02:20:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769682054; cv=none;
        d=google.com; s=arc-20240605;
        b=UJnViW3SnKT1Da6oleS9+Y/FAoZGcRt0QF2N6bz8oEc66C63eSwS8tcJawvgqAKiYc
         d1tZuQTvp4fZGhZ3u5mzAuQvwzdrUac9dLXopwFG4X9+g3Jwgj5FY5B1HwUWgo0bJglb
         +pDrDMtnD++T37UhyVErnWHdw8+TtOFRayo1YsecCg8ybaKG/+nKIuvcEGWVTvYsr8CC
         sIw4Esr5T64kCt0FjCzaPe2AgrlnDr2bzDPzkutRRYUnOGta59gr0ke/Xe1zR7563q9+
         m3P3YInJnBXI6UgWBhmVtSvs4nCmYWq5Ysj14fHdpy2+BkcJ9V75B3mDfEfi1GzNidIF
         EnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DickB8q6pcoqPVmWbcv5kKPLe+4M0lhm+hAJavb2CqE=;
        fh=O77PP+L+QSzUWpSStQ46GKSevIu+qGnIG7ur08/zwEE=;
        b=j3khO3dXKVynbN+2o+smbjGRCIy4lS/0+xyfLOC7Jk62PIXqQ/bASUm5KKAf6QOZ06
         JBakHqUIiWzHaqMxHJ0DS5H4hhzgLxDsOt9xy2INU0IAAeUd4lie8ErvfU7Gm5U66xdn
         1j7875zbhyW1nlWUUI+LuuBKrzG/z8Ema+m53ZC7jYmzZN98slQGG8BUCzYjIWN1vOGQ
         n/XI/iXWOIIiIP5C6kOYRmjOTus8PNn0l2N7JOPXCgMWqX2PEgzRCi2oj2NOXYIiks7e
         TXwgNnXcfKJtsEgm4yIfjusCKSZSCH4vWztCFJXSev3XQCfihG8mD1J2Ua7LxDCoFPpd
         WRrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769682054; x=1770286854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DickB8q6pcoqPVmWbcv5kKPLe+4M0lhm+hAJavb2CqE=;
        b=cRTFd6SmRAiVgwNLVdfHVXYdHa/IL0rXhcXSbT4DtIgEWFA7RhUieedRG2T6TMr5o7
         IgcWanwqhObPzNPbkLN3hFiywrXvUKtX+XcBRB8cR1UAxJlsis6qk54LftcyknLO01HP
         ZgQhqYh3IBujidCnGCS6qLkoQf3W1pSZCcnrYYrncvD/IOssp/oqFQotDoCNTlenrP+P
         rgji0zL7SB0aL1b9HtNUhZwzoY1csrFBbTtP5/UOq1GdLzHhvbzgZEsl7dMhlSea3amK
         h66ZtUwXmeCo0oFuL47jwFRrKa7BT8+pZ1P4Wowh7jao99QIYIfjTFUh7ALIU539lC4V
         TTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769682054; x=1770286854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DickB8q6pcoqPVmWbcv5kKPLe+4M0lhm+hAJavb2CqE=;
        b=CFzO7dghVOQlMcLTpoOCaxAsUzAdnhjHUKYGyyJofkD696JdounJ2Ees0jtlgOgHog
         BHGr04en6+8Dy//71XnaIlZbCEShH+U1/bjSaVAnh+lPbgbBUgZ75VXTMys8MLhhssH9
         YFgTt3NLW8lCuxlDX+Xm0bnkyGUPBpGQBGHg4HUJsXhkr+plUt42YOAOadZWzTVIAm0/
         mF5K8WwTvcObMDRGL6KzrKCkl7LGo2DOQ+Wdkga4792BS3Hu5gXUvksq5x2TcqFwT89b
         rZkGiKaEB/q9km7I+FjsdWPdZHB08s9bWP54pCEtij3B9l1aAG0m9oVm9HaTQkxcKoN4
         vYaQ==
X-Gm-Message-State: AOJu0YwAghSLVqNroUQQj/Xu5ygRqgIU5SMikeYQIR1HkWQXzJlcUmPu
	gYVFSwM4FhQvqmStMN404T0Nur62nZw5LFI4weTjV6bFyR16OX/jRvlxwFeLhnS0zvzZFK8ICi8
	cbFJ1pXQEF0i+UhjDhfEmrWOVxBH4bt0=
X-Gm-Gg: AZuq6aL1hWWffQk8OR7PeQdw5WA7lK4uKcn6Byak15pSf9TMeWkLcpUSStsAxmUkqTZ
	qvE3CFjNk5C+x8uQB91ECp6XltP0IrNV+42zf9iH5hY7CKQHBObJrxnS6a4EBsV9psZeJO3jpzO
	DmJ4OPVZ54BvbNXUxmSl9QDL+AcVWngMc3HRZ9dzBvItfzGXRgHk2MeO2XCR6+as/mEhiY5LZXL
	ME7zQuLpklLQXPVQgNh2fZIonntvAa10vYVlM/ppiMNB6DINtMeEcQ+IBjMeeXHpB3LkKLoSHrm
	7t/mytuHJMi97Q+LlPcGbqhLgcaGyLnn/HCQExXXZ2T8k4aOLNfvG7ZpPFx3FF6zWJM=
X-Received: by 2002:a05:7022:438d:b0:11a:468a:cf9b with SMTP id
 a92af1059eb24-124b1027c9cmr1449211c88.9.1769682053850; Thu, 29 Jan 2026
 02:20:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
 <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com> <CAP8UFD0kEATc6sU4r2pVq9k2X737Tk+_VXrxXx8K=M6=ciL=vQ@mail.gmail.com>
 <BAD29E01-C358-456F-8E31-058AC0AED0C8@gmail.com>
In-Reply-To: <BAD29E01-C358-456F-8E31-058AC0AED0C8@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 29 Jan 2026 11:20:41 +0100
X-Gm-Features: AZwV_QiHzqnIXH5qiM-Y9p4vozHpWEIqWZuYHIrkrlmR_WjRL0JmPiz65IrwJGk
Message-ID: <CAP8UFD29LtG2dRRB4f6mZAHNGqDmDxUV4ULYw3w3OYg15ZBBYg@mail.gmail.com>
Subject: Re: Git project and GSoC 2026
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git <git@vger.kernel.org>, karthik nayak <karthik.188@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Meet Soni <meetsoni3017@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Bello Olamide <belkid98@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	Eric Ju <eric.peijian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 28, 2026 at 9:28=E2=80=AFPM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:

> Just a gentle nudge for the project ideas. The deadline to apply for GSoC=
 is Feb 3 18:00 UTC. We need the ideas page ready a couple of days before i=
t at least.

Thanks for the nudge!

> Feel free to chime in to suggest ideas that would be achievable by someon=
e new-ish to the community. If you're doubtful whether an idea would be rel=
evant for GSoC, feel free to share the same and we can discuss it.

Here are ideas I came up with:

1) Continue the current work on removing global variables.

2) Finish, and then maybe improve, some work Eric Ju started a long
time ago on `git cat-file`.

3) Improve git-backfill, or maybe a different command, so it can
remove large local blobs when they are available on a promisor remote
(for clients who want to get back disk space).

4) Implement some kind of fetch order when more than 1 promisor remote
is configured (this order could be passed from servers to clients
through the promisor-remote protocol to make sure the fetches happen
in the optimal order).

5) Make the promisor-remote protocol useful when the server wants to
advertise "better-connected" remotes (not just remotes the server
uses) as Junio suggested some time ago (see
Documentation/gitprotocol-v2.adoc).

6) Improve `git repo info` so it can show more information than now.

7) Improve `git repo structure` so it can show more stats than now.

8) Improve fast-export/fast-import and maybe git-repo-filter regarding
commit and/or tag signatures. This might conflict with GitLab people
(including me) possibly working on that soon though.

I would be willing to mentor any of them, but I don't have much
knowledge on `git repo`, so I think it makes more sense for me to
avoid 6) and 7).
