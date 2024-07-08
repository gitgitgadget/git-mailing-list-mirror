Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5AC13C806
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472016; cv=none; b=pt33M+F+T/06FeRyC8TtOHrkzx4D7T4Aj9AspPD1gn/yaLMXgZxyBW3u6T4jlqMgTS0Jm+9P/UqbAIbsW/ava/KOBy07dMBVx3OP5Po6sCTxTkWhsS79oaRTfBaCP9sNxhsjZwMAfOrOuLXrmqRTzI9dgjO4NU9otn9mA5ZGz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472016; c=relaxed/simple;
	bh=rgY71Htck/Hj2IBLuX/Qat3+VwD8xaYgVD9TVYzyRbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvB3FMfivgaPD+u095J1OeOufNBgVRsTcjjJBWdY1oGaxhO1m197cj5peH5zoO7I9cYwYzrlQe8Mq7K3Q46P0/8r55E6Xibd2WviPpwR0Ip9g9B/6m1mY1/bx4Iw40e3LXHqzPduFJ07C3/HksPpmbwiEpkdbKF9eJFrFA1q/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-447e87f0084so10713951cf.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 13:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720472013; x=1721076813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgY71Htck/Hj2IBLuX/Qat3+VwD8xaYgVD9TVYzyRbE=;
        b=eAJXzn57bveQu4K5ivQ5AwDvAzp3DN0fo+DZmcw7lJkrbbp8yvS9YiQDBvfpGbdrWw
         bGtOnipy9+C01+4jTDl8/DCRHxn+O6YB/v3nyLa8pvkIO1iG2R7yEU9QEsp52FOLjdfO
         QF6HxjGFeEQVWaEnKEqNlUGcqYxKvTj5EXAfBwW1wpulqkMoC4sAPBTwIONZw9V1SMWn
         59akdBw+1l9x+aAQRGwIb1wm8FycZGC7vAx2O2I9dhGKGzGU2NyGKVrFKk9RPUqBImP1
         IRjLjdtbiKcYLF6F95a1duOiGNrIQIqfKveT/qGXNFvLGiuCzzwavZWYq8m2wMtWBl3x
         kRdA==
X-Gm-Message-State: AOJu0YyoR8BUAg3GHqDmAdxkF7+3jfB7wBpn7ZlmBoY2gt99qgbyL+TC
	nOrmd1JWNM2gYtv4Q564sugB7Is7LRptBX8OiV3/067NVSKCvwNjPM1GZDCaWeKwXvvrfKO6fLh
	4Ltlc8QKOmvqVTPijrQzEDzsddwc=
X-Google-Smtp-Source: AGHT+IGH+vcXp/Gvl8/MF1sWSIqGpPG3cL4iGVsNSQQUj30aJkmKFYRfaZml+Q7AyhJfezeLGd1BVaOE2k1FivHfYmk=
X-Received: by 2002:ad4:5f4f:0:b0:6b0:820f:b833 with SMTP id
 6a1803df08f44-6b61c1af58dmr8579626d6.46.1720472013673; Mon, 08 Jul 2024
 13:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708092317.267915-1-karthik.188@gmail.com> <20240708092317.267915-7-karthik.188@gmail.com>
In-Reply-To: <20240708092317.267915-7-karthik.188@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 8 Jul 2024 16:53:22 -0400
Message-ID: <CAPig+cRvz7ctW8K7QbZyDSTTG_qxdU9uRmJYrXPW64OuydH4VA@mail.gmail.com>
Subject: Re: [PATCH 6/8] clang-format: formalize some of the spacing rules
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 5:24=E2=80=AFAM Karthik Nayak <karthik.188@gmail.com=
> wrote:
> There are some spacing rules that we follow in the project and it makes
> sen to formalize them:

Since nobody else pointed it out: s/sen/sense/
