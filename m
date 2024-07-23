Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971BC7F
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721693446; cv=none; b=RtJkWWXWT/hAqfPbf5zM1Xqazr3jHD1xq84qjZcl36PthZubZzLCfIXNtb6Fx/bTRx3zXBkpukKG7Egpj3+RgRymQ882UPXHBXpSFeiaNNxiJMaI94awVvEESl6cX8R4BigMeY1O93V4NsOBy3o/iVEMbpxuyahbAAhzuyce7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721693446; c=relaxed/simple;
	bh=jew3cAktCBn17Nn1XooEcKdpgdZpyphmFXBQTrKLlOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSMWG9i5clMGIgYYTc+hijXTvXqY1NSr6Ar5DSvrP9arwtO8Ixxp50MynlUKJu6EeeIMY3Wz1KnxhlIkyGoilWvHCPIqtLhTMRywS+Pn5MDE6YeRhJHTDMdVBkeWjb6SEFU0KSf9LDAdNe+AjjFDmisrf8RobKv436q1zpC5Cro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79f16cad2a7so297841285a.0
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 17:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721693443; x=1722298243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0+MI7Z3TCZe064jVjqSn+cdurF6maiV7uX7JFKpn8o=;
        b=GPZ4K7/BEubooBt39Ikaci83Wumc3SOFhoJjLTrCmK2zcweB+R0VtySzMvzxTuwAjk
         wQScmKHECnoQm1zLMFDSST0ht2ECOb7RxqrHZkyikuY/0DxyvVb0iIr2zuITtwrkdoCX
         24B5BP7afrXtEJzl2nNQd967qiP5iv7SHg2UzMdRLf1O9fztG7j+7xcfyUc7lAOi+a5z
         8JkDUL98bMm12AbxGACj8pVUj6qE5PvKRIG4A8LwKkHnhH8e8NjtWektntLLa4rDvGmE
         czpsNAtCu5GHT8NugATPxZBEEEUQB+qDK2/l4ERL+gOGnjAsBlBeiEZHQLsxk+NymSz7
         mcEg==
X-Gm-Message-State: AOJu0YxVT+PufhNdgih41o14UMRvhhtmxcfpSZzTOweewODJgN2kbHM/
	p6JOU8t2AHrkeNa1d3o1XSGfJXPYC9S4ewmHIXXvzwvqJvOlKbe4OgMB8ltdzbqn1Em10j6sa8v
	YMlOiBwl7b8YA3HgP123peFc1sUU=
X-Google-Smtp-Source: AGHT+IEe9NNtdvK1CdI11zg8c32fEz8z4lFL+P9yXXdXdiCfoHkG7GBhd1TDDFuNAruBO+6Hj2apEWyShd4bV3uALJA=
X-Received: by 2002:a05:6214:29ee:b0:6b5:4e8c:1be0 with SMTP id
 6a1803df08f44-6b981922a8dmr16426416d6.16.1721693443415; Mon, 22 Jul 2024
 17:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqjzhd81la.fsf@gitster.g> <xmqqwmld55y1.fsf@gitster.g>
In-Reply-To: <xmqqwmld55y1.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 22 Jul 2024 20:10:32 -0400
Message-ID: <CAPig+cQnUBxttpTnucj527T0ExH1fHER4mrbyoU+hEh+Kp+Bow@mail.gmail.com>
Subject: Re: [PATCH v3] CodingGuidelines: document a shell that "fails"
 "VAR=VAL shell_func"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kyle Lippincott <spectral@google.com>, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 8:05=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Over the years, we accumulated the community wisdom to avoid the
> common "one-short export" construct for shell functions, but seem to
> have lost on which exact platform it is known to fail.  Now during
> an investigation on a breakage for a recent topic, we found one
> example of failing shell.  Let's document that.
> [...]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
> @@ -204,6 +204,33 @@ For shell scripts specifically (not exhaustive):
> + - The common construct
> +
> +       VAR=3DVAL command args
> +
> +   to temporarily set and export environment variable VAR only while
> +   "command args" is running is handy, but this triggers an
> +   unspecified behaviour accoreding to POSIX when used for a command

s/accoreding/according/

> +   that is not an external command (like shell functions).  Indeed,
> +   some versions of dash (like 0.5.10.2-6 found on Ubuntu 20.04) and
> +   AT&T ksh do make a temporary assignment without exporting the
> +   variable, in such a case.  Do not use it for shell functions.  A
> +   common workaround is to do an explicit export in a subshell, like
> +   so:
> +
> +       (incorrect)
> +       VAR=3DVAL func args
> +
> +       (correct)
> +       (
> +               VAR=3DVAL &&
> +               export VAR &&
> +               func args
> +       )
> +
> +   but be careful that the effect "func" makes to the variables in the
> +   current shell will be lost across the subshell boundary.
