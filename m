Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F653D524
	for <git@vger.kernel.org>; Wed,  8 May 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187191; cv=none; b=ZabqCi1cqcefuYvYo6kSHa/vRfhPosZbZfIJhF5N6FQhwkW1W7iUY40ysrS9AwcDuCWYEGUXlReqyZlgWV7dwmf2sJU3eSgDOdasJpsQX6jj8+Xf5KEc68Te7rX8ne8qoTqwFzEY/fhCQ5fqNgpybCyn20yuWr8aVeunIljesfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187191; c=relaxed/simple;
	bh=40OlhYelzWPYNO7Rt8KXTkXmg2BUFNtucYJ3gnh1Y4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fW62kYk0sNL3ler2wixAplC/PdVyymvTKL6hqVu3HUdU2E2JGUn+RK0769YtQMdCRUX6GkJjSWey4kXY1GS9hoLB/jK5YpmPQQIgzz6mJrjpZtLrYVNBBv4NZo5ztZ0/WHRFr7oEXKGiZacyHI3kQfDCYiF3VcFzqZILwfpQmQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7f7809ae952so1000162241.0
        for <git@vger.kernel.org>; Wed, 08 May 2024 09:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715187188; x=1715791988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWCDRtg2CAAap4CShGSAcZyRx6iymH7XEb6Oasxzy9c=;
        b=wzildts2BM7FjN52vsQ5YXJRk5b4XY4tp8gRn+9EKl70jYlCVxATzHaPQj1NlBisYq
         InLSpkOa+0uYsXRp0ARU/HTTbHrJ9uetWSQVPlldYbVfGKSLEYG1X6i6nQa+FvTWac3t
         QAof3A8liQrJatWVxzOf/f+sBCRxt57YrCDWMUOMc3iSoLShnNj7iIME3LW2Mot5uWOv
         Q66ExPY6OUuQuOQuvJ4u98J/LeoLwttegQiJsh1c1yzWmW1PTvzvhAEpq03PuH2NqGWC
         f2B4CY6f5OXtuHt8mgFElfU94+kqbQBlFo0+0DOfGHE1OB4D4OFDxYWh4H4obP0TtWo8
         Upjg==
X-Gm-Message-State: AOJu0YzpMeQznVA54nPIdNGDJX5IOydNE6w0LUKiCr96t2gRvaj/InVj
	VyA7HKAfAxqOtUqFKMh46rUfZW2EMwb8FquvhWDAYDt9VqOkRlU45k4Ek/Bu1dMcdmIEqmG9/c9
	L0ajwWngwVLmCiN2bYznQOk35aNZ9fBDs
X-Google-Smtp-Source: AGHT+IExmtg+w/LTDtJFj9OeGjegyEY9NJ47lYzsh/RofwncckfPHZPxsAQBZS8RTE/2aostrl77XK9VW90U0Dqavqg=
X-Received: by 2002:a67:cf06:0:b0:47b:cca3:aca0 with SMTP id
 ada2fe7eead31-47f3c2e6b6bmr3096342137.18.1715187188435; Wed, 08 May 2024
 09:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508124453.600871-1-toon@iotcl.com> <20240508124453.600871-3-toon@iotcl.com>
In-Reply-To: <20240508124453.600871-3-toon@iotcl.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 8 May 2024 12:52:57 -0400
Message-ID: <CAPig+cRS1SE5RNoqMp4F=rdjy7ueukN82q9qRaLdQWjjDJDvXQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] http: add the ability to log progress
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 8:45=E2=80=AFAM Toon Claes <toon@iotcl.com> wrote:
> Add an option `progress` to `struct http_get_options` to allow the
> caller to enable download progress using the progress.c API.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
> diff --git a/http.c b/http.c
> @@ -2061,6 +2081,13 @@ static int http_request(const char *url,
> +       if (options && options->progress) {
> +               progress =3D start_progress(_("Downloading via HTTP"), 0)=
;
> +
> +               curl_easy_setopt(slot->curl, CURLOPT_NOPROGRESS, 0L);
> +               curl_easy_setopt(slot->curl, CURLOPT_XFERINFODATA, progre=
ss);
> +               curl_easy_setopt(slot->curl, CURLOPT_XFERINFOFUNCTION, &h=
ttp_progress_callback);
> +       }
> @@ -2079,6 +2106,11 @@ static int http_request(const char *url,
> +       if (progress) {
> +               curl_easy_setopt(slot->curl, CURLOPT_XFERINFODATA, NULL);
> +               stop_progress(&progress);
> +       }

The changes thus far in the series all seem very straightforward. Nicely do=
ne.

Can you explain to this reviewer why you only reset
CURLOPT_XFERINFODATA here, but not CURLOPT_NOPROGRESS and
CURLOPT_XFERINFOFUNCTION?
