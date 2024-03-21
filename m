Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE9BA46
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711002189; cv=none; b=JqVGMEjOf1MjRByYc2nb9ekY6xC73l5y4S53x0KHKCPzDIh9nP7QV4JDoyawlWj0GTTWxkW9VdqNkU/U1m1hbCNARp2Jx2kb1xllWYGxUKTkyOvc+9xHA7JGnLwCjp6ut2Yo2yLnaQYoTV3Z3mAd/D5ecIGBSQ+1YxQjZJWjwN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711002189; c=relaxed/simple;
	bh=oUJCXmuIn7YROIaAvdw5Atg1aQ4/w8h4WWg/0U4bM0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8Wr+zUEPzj1BVr/Ip/A0EkswbULTSSyxnawT/CYSojJyQQhlUMWkzWe7yoVV+Smtgy+cGdESouByRwCYPSoytD3B4aH6ifciJn3C8RXEbd3CYuekLRWshFdGpkVIP69f1cP8IJhhV+vuAK2jsiWdb7jNF64M1zr05+cdO+PrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7e096ab9287so257175241.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 23:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711002186; x=1711606986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqZ8SAIo2lTm7eo+4RcPESiz1qiOSor2RdUyeYnLatA=;
        b=CfNu2N3uQeYatqiMVilepyK3Ja9jj8UZVkNmGpUKK+JD8EBhpKVqibERs0o0AJNpeI
         MBfZ6aHcCjZR9Ugy3nqxm9WVxcglQ0dveBEDj7/XYvKYG/OpRntWjxlSJ0eXRBaHKU65
         WwPgoG6vZZ9P/CMLveb59WsKFVUfQDN1MX0dFHWnHJpv9g+87+c0d0ZLVP42cI7JhwzU
         O/VRzz62E0z+GuJ6evsYQAeSG0EYewAQxcFhC3sMM9cu8JgzrcxL8kSEJuXUKAu+QzrI
         OU1pwfY/Cm4f4tT5bo3lYHAw4Ttvdw0hBoYXel9p9Llbg5zeGj/i64D3QWalrYaoctko
         8t3Q==
X-Gm-Message-State: AOJu0YypUH2FhJNTicRL4bJdCPqO5GW1RalOCAl5XWA3C0VDMhTCRsR1
	TmP0y6TcFydvIRK+RhxJagBqF+wiXk+9KMEn/nFEWKEjjzZ8yq1RFqLGvKcINI+qrhF6xGd48gL
	NhAe9+5rysfT/Y6AbJ34XquREfvg=
X-Google-Smtp-Source: AGHT+IGyz1gTghx/qzCXlSp2DFmDhmvoQ356JAFvbh6GUigaMuk/XkbweoqEVlgFlXIN4lJLWWgjODnZJzzG+Hf7tf8=
X-Received: by 2002:ac5:c1ca:0:b0:4d4:5480:1bc2 with SMTP id
 g10-20020ac5c1ca000000b004d454801bc2mr6736179vkk.14.1711002185834; Wed, 20
 Mar 2024 23:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711001016.git.dsimic@manjaro.org> <a75a5eb8793f4ae6eb6e7cf0e2fd017471fefd0e.1711001016.git.dsimic@manjaro.org>
In-Reply-To: <a75a5eb8793f4ae6eb6e7cf0e2fd017471fefd0e.1711001016.git.dsimic@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 21 Mar 2024 02:22:54 -0400
Message-ID: <CAPig+cToaiCzj2XwNSeStx7p7ZPn7=a2nKZBFLwX12Uj=hJ7cw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] config.txt: describe handling of whitespace further
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com, 
	github@seichter.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 2:06=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
> Make it more clear what the whitespace characters are in the context of g=
it
> configuration files, and significantly improve the description of the lea=
ding
> and trailing whitespace handling, especially how it works out together wi=
th
> the presence of inline comments.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>     Changes in v5:
>         - Rewrote the description of whitespace character handling again,
>           to eliminate ambiguity, as suggested by Eric Sunshine [3][4]
>         - Extended the improvements to the following paragraph as well, t=
o
>           tie it all together, and to make it less ambiguous how to inclu=
de
>           leading and trailing whitespace characters into configuration
>           option values, if desired so
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -63,16 +64,17 @@ the variable is the boolean "true").
> +Whitespace characters surrounding `name`, `=3D` and `value` are discarde=
d.
> +Internal whitespace characters within 'value' are retained verbatim.
> +Comments starting with either `#` or `;` and extending to the end of lin=
e
> +are discarded.  A line that defines a value can be continued to the next
> +line by ending it with a backslash (`\`);  the backslash and the end-of-=
line
> +characters are discarded.
> +
> +If `value` needs to contain leading or trailing whitespace characters,
> +it must be enclosed in double quotation marks (`"`).  Inside double quot=
ation
> +marks, double quote (`"`) and backslash (`\`) characters must be escaped=
:
> +use `\"` for `"` and `\\` for `\`.

Thanks. I find this discussion clearer than v4.

I don't have any further review comments on v5.
