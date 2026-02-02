Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36F2E0926
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061057; cv=pass; b=B+WGpUvrIaGTpS19Imr3dWoQgxHekKiIFFJ19P3mQuX3P/KWGqNKn8iQNDDIedpyfDXaQ3I9CCkPg0ul+NI5D0DS52IHrXbvRdJqIBAAmhaiyRY+bqXn1YSqi1BdTqObZEBClDo8EzcDXBLCRIFtViSGv+Mi4/jb0obuG6RRKTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061057; c=relaxed/simple;
	bh=NWr+2TvOt+O5XAs9MvO3Wv1mzdef1RLzI1aUDNCcqY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BP2Oo9F7vXRXGye1stdkxNOlo71X24cPa6k/uhhPfiISIudci6yY/VLHUCMO7Dfiqu8Yr+6fPildZTn31pEp/5sMdmzS9zy6aXVGLn6H9XuydaIIM6T/3MrEx3SR1ajWa9ffET0it5x3hk9FQF8l8irrpLNyRDYn9xRrRgSuY2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=As4ZKEWL; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As4ZKEWL"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-352dda4a34eso1987684a91.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 11:37:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770061055; cv=none;
        d=google.com; s=arc-20240605;
        b=E4WM96Tgv9sPc8vDD7mWJVMof6zeHDKKQ68OwK8lsHA6k6UZLJhLwozZWr3jeNXVW2
         iLm29ZVKM0XqWNxiQ7jTOj33xw0sH1+h31edPahMA2831lRpfDxFbRW2UHQj5fRRSsKh
         YUs9P6fwnhLq0c3lrO+PV4gY1JgdqgBsNHArj7QwwZapiLDLXe1eYqrH/WaJpC90SigN
         mmrshE8dzKOvsJEqrzkES7fvwS3RBwmkW58k7gzhqmeiiDhSwAkgZAJrqdKJukfT/nsl
         v4PThsGUn2Zw2+UQkfeMXGeiaT0xchy0HQ3aEnpDBuDjBxE4Yf/EsBTSsblonLHXE63H
         6zvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DKfjhh2l54X7r5mlOSalfqUoNDl5GKvXCiU4eKiwWr4=;
        fh=/IwEVW501n8DRLoh5fN/gH9sIJri18P6YWs/9LMdh70=;
        b=lkByc4Ttse171KCN50q4Kw3/GrVDxhZ3Pu/e3Hb3kzvvjJWanqU1UL/tftcCyYCtqp
         i0+lf/CiV+vgVwxyhnpbrYDa5FIl7HIbe4tFi/3wI/M/BPwcTpPMSztQ3V/iihFLAiro
         zdsh0oZcwccy8yoqDKrq3Bjc4qs2hhyfgdsBMiFEmqu45kUAITs27XmZjnIRyk5raJKZ
         xAfIwYkWktIOlacD8PVKsPA3tpmJQwVxPmlZhL4WXZMSjdvzbpnNccZGqPSQz825e46A
         cjebW/rpwUFzTrjVmjGR6tX4xuqChfHlAIouJNGpKtML87HbtmalQ9ppwml12xV5Q7eW
         oUjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770061055; x=1770665855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKfjhh2l54X7r5mlOSalfqUoNDl5GKvXCiU4eKiwWr4=;
        b=As4ZKEWLgjYc59OnQ+lVprKoIE3PrnRKh5uD2i9Mc63sEC8XhjUlymYsAUT2CfSwx+
         +LFdKvAckEQ7GwA3UpAolkw6x2POg8ABERgMCeryDXOsrGnuc+QIIom/SMAKBjygubFg
         4znNp3xbniSW5Ddt102DfJu3/JorfG2DHAsn4N4fv97tGKeZaGqkHfDwf27yk51wr7c7
         Uwkob/4FaJyaUcq4zxkG26JZYhQT/4YT/9k2rSpZhC6Gv4yOmHnFTJNUm/jKq9RdzI8h
         97ZaYi39oqudODj5giHJ6XGA9YWsOE0M8chaoye7XrHa0LjPyoRzUbngE1iWLoqsbQ3K
         3hpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770061055; x=1770665855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DKfjhh2l54X7r5mlOSalfqUoNDl5GKvXCiU4eKiwWr4=;
        b=YxJVfdv9w0RmIAii6Ntg6hNuhFoFCbCA8RkDB0QXko1HnQ0DC2/Y1hoSrXYd9/3txY
         yWtt/FtnFX3XezuzypXyRyfuc3FjlvIP9BlFcSMIPbv2blJv05cAUbhngKoPJQpOeJgy
         8ZGgc/RJn1iUv3ICOJ9hNmtBQI9BHq+0wH+nf5aDV10L4azzkrIwGtI7JyYMc+u536g3
         vs1/3QkuBy8+ba9AMtMGbCP0SQIbG3n43I63S8iBmZmdwGKdqayj0eU/wqyosKiYLJhe
         86saQI0TWI9/PH6RL37ioZJ5TDWnu0If/LHBPAxwGjHg8pKtZvzMvvZPg217Igybd6St
         2HXg==
X-Forwarded-Encrypted: i=1; AJvYcCV86Hd2/3QJ1258DpFvS/xJZA6qh3m0qmSYDtKAhPPk4TqSSOmi1KkM01PiVd01p/M+Mww=@vger.kernel.org
X-Gm-Message-State: AOJu0YywZUpiaYLS18t74apH0+LOQmBFmv2/PuEgl+IEOZNJ/hTZyKRk
	FENnUhMJNeUfnKZkgQeA6FbUQUsGQNndBaB5hcYeNAJgzZm2x/bbnQshBU1D6Yn16uT54PH5gg2
	AUMBQGBwOir2DYDjneNwkZxZ7UFu2Dfg=
X-Gm-Gg: AZuq6aJaDvJ6dl1QWYpTYI9bl3/oIzZErjQh5gdHz+2gClMVC/qUuPTlzTxugeRXis+
	MT1kxk7T5BBeDR2Ybl7wmI8eAxiaM3E/684OH7dMcA/xJsmXQNIbPbV9AXugXQ1lhGNwFwigrvb
	MbPeHnqLrMwGeTUiClZahTijqLDwTj1UBR0Ky9F1tG/7l4cJ4+9Otzr/Y8kT5jJGrYi2caW0tNX
	/ly2QkqAPZFNpswtOdd3v7v4/4/5Im0/Sa7G0c/a+W6v2UQCBiHzSw10cCHjMCIn8kl6rn7i00w
	LGDJp9uv0NQLVHulenJHUf6mB9BW+Dv6c9D319pT4zayHKk7mb8xoMQGbSyB8upuNsaoa4EF71a
	sM5Y=
X-Received: by 2002:a17:90b:584f:b0:340:be44:dd11 with SMTP id
 98e67ed59e1d1-3543b3d01b0mr11579388a91.27.1770061055335; Mon, 02 Feb 2026
 11:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202131921.15175-2-pushkarkumarsingh1970@gmail.com> <CAOLa=ZQCuka+cSuCu=KnTHm=gk1iJ_QJhDjy1Ku8WLfSgkGorw@mail.gmail.com>
In-Reply-To: <CAOLa=ZQCuka+cSuCu=KnTHm=gk1iJ_QJhDjy1Ku8WLfSgkGorw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 2 Feb 2026 14:37:24 -0500
X-Gm-Features: AZwV_QgvWwiXL7djR4YwMWYW-j2iXyq8QXtPuJW3Z5XAMVfT7UMWopBEttwAbXg
Message-ID: <CALnO6CDXwbxiQ-UjJLxgrjbgryQwxMro106BnewfFvcqchb2sw@mail.gmail.com>
Subject: Re: [PATCH] stash: honor --no-overwrite-ignore when updating index
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>, git@vger.kernel.org, gitster@pobox.com, 
	peff@peff.net, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 9:13=E2=80=AFAM Karthik Nayak <karthik.188@gmail.com=
> wrote:
> To confirm, changing the test
>
> modified   t/t3905-stash-include-untracked.sh
> @@ -434,7 +434,7 @@ test_expect_success 'stash push
> --no-overwrite-ignore preserves ignored files' '
>         git commit -m "add ignore" &&
>
>         echo after >ignored.txt &&
> -       git stash push --no-overwrite-ignore &&
> +       git stash push --overwrite-ignore &&
>
>         test_path_is_file ignored.txt &&
>         grep after ignored.txt
>
> still passes the test. We should be testing both scenarios.

Hm. Using "git stash push" (no new flag) on my build of 2.53.0 with
only this test added passes, so I agree it seems unlikely to be
exercising the intent that led to the FIXME.

--=20
D. Ben Knoble
