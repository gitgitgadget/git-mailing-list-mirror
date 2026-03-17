Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0923F7A9F
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771146; cv=pass; b=QPe+6+WCXefqq3ZND5Ump94m2cocw+imeBGwoj1ZOt4u1avCymisPiJNUB3BLXI2gtMrp7WO4Be9Kn+czo5stYc3KB1YUFEVjtusuTWNmN6WDoTXy7YOzMb+tY9BvAgATWGk1KENP97EHTIpxtwg5rgZAfunnctfM7anx3XFJk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771146; c=relaxed/simple;
	bh=9Pojj9ph89dqX2/drWaFYbTe5GZZK1Ul7SaHfPH9o5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8JorAE4oN21i7GtU0mR4QM/V6GLpjlj8qfj0CjiiC8/tDn7+AnqTcQeTK7vw2WLxSI5hVm574hAiP+OXsgwkC1pOwygN4NxQNDypKpGXXwuiyQRXRHDNGRhHpF1/0PqWDC5X+ywDS1mEAmCSjkcqBwSy61OuqJze8/kI5SocsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-124a7216c9cso270259c88.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 11:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773771145; cv=none;
        d=google.com; s=arc-20240605;
        b=X2WMwtZHN66UGFAdeK4lMFl9tQkryvgUYB50lvaD3DpSKhbKc5CBlFSr10v76yDCyb
         dLEaVs4ZC5cr9rZjhb76x9BcDT1W1c3EYNQR96j6G+scx09Gb4V0TLfrngHr4nDro1Ld
         Gtoe3OHqptwDUe0DGQ9QUWjdxarb3hgxromaR/HnkcXChH7YxyMYXUonz+OMtsXVFblX
         BfC29QDe3u6vxlDf6Dwu1Tia9Cj/+WjdWkfC5MVbPZwnsSmEQNXOI3Keny2tj4t+8lof
         O4aczkeInkEjISY2slBHBGp+tOXRwInDxrJZH8OVQg4t6BwN02KeP3RDKotijQGje4/U
         rfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=VM7jyyQ62MtaJSq0mzE/OaNXSvcvrkcHSG864dpZeuw=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=gyj4WLsAyd/EwXsyJI/boTx9EWZlEaPI+4wb21e1PELA1D71py8CKH7dXBplWVt7tF
         GtEVa6xt8iVC2hyXBeleHH96tqkd3xIdH0i3K4T1hPzbl5V1O+DSwFHq2cN6ouesTBSY
         74mDB/oXPGODNLkqn4JBeGReatIST+mRq0Mm6yB3FC50AdpHUZXQlIloZSnHLurEZgQ4
         sNIGI2VTTVBQyW4FPmuP5+SNRtd+aPydhO6hOCYzzCxNcSBF7NU3dbMEjT1YCl4onn+Z
         qGyxX5tyk2U41kTlgB/WdAopiPGD6MWwOr9cTqygcbOgdk4I3/y5v/H2ugS6R+Y+7+Tk
         RNgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773771145; x=1774375945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VM7jyyQ62MtaJSq0mzE/OaNXSvcvrkcHSG864dpZeuw=;
        b=BR5a+NlF8gF98dwAPlDpf3S4f6a22772CxOvyB2f3GHYohB8u8wjqpXGOfELDK0CPM
         PlOsM0sji0FHzB3Z2Qcoqf3jOCeAbWrozOEhhI0L0zv8mnY9F0MhHySfLUb2a4Kmb5FO
         P5N0Yfi++pXLO+EoORfREQsoe1IcUujgLjA3L3I+YCo/+nZeqU5iEA8K5AnFaW1/fOw0
         AnBHGyyoF/T6rH5Y+ejRQ4sp7OYriju+WgCQL7AGU1VGiStKgc9pQH7U/fZ7FEB+CnQm
         2hDBmtsA+OsdBDGWbzahBRDyVizlOBmY53i1fWaf8b1NTtBrbU0lvRRvPdRUnihPelRG
         kMSg==
X-Gm-Message-State: AOJu0Ywn858jNWxiJowsCpYiBgXjwbStA0HYnDBEde8GgNnqbPmx/9O5
	sEViJZdZYE2RMYM5GOFELwYBcF9FpNy+u85fqlr9u7OVlZ0j+I1VqsseXza98D0qzxFJta4N7TA
	96Hv4ZPF3DyMqh5pqM1Qnhq51FniEZ7M=
X-Gm-Gg: ATEYQzxac1KEQ+Crc8zB0i9YVscvMfTr8aXcJJlpYlb6D+LT0tInkmqiVW5YpmShcRd
	vDnf5C5XJCz+t/fTWTmOPoF1C1qOUQsikGsl1hDOmGU2uBTwc4NAE5uqit0nBZj+ZgwdiZp+pB7
	5GDcUWSdNBDVy5yiUag4fcdeGU0+8lja+vjZJBsmvZ/zmkzInSNdsXPUtOwNy8ywiTVQAaXDQ3O
	a7pBwTrzIWh2q/22wK1nVtsSpQrvj4SAUbRWZt0efnF2Y55WFgALvs1kn/k8UMJ2fXfF5PlzK0H
	NdgHpZGhVcH5CDxxoj74Ntlnb57orkDjJfpxsh8XFq3U0p6pT97U
X-Received: by 2002:a05:7300:3724:b0:2be:1f56:ed32 with SMTP id
 5a478bee46e88-2c0e4f79e7amr109641eec.1.1773771144640; Tue, 17 Mar 2026
 11:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqldfql4hp.fsf@gitster.g>
In-Reply-To: <xmqqldfql4hp.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 17 Mar 2026 14:12:12 -0400
X-Gm-Features: AaiRm51zQejdyU-v3N1Uvrs9dmQSxuK7dZr-cJXcVHpewLmPuayZFebGD9PuJyM
Message-ID: <CAPig+cTTgLVGPG99gsb19BeJVWS=VZCU4F-rjb25yHTAORWwzg@mail.gmail.com>
Subject: Re: [PATCH] apply: fix new-style empty context line triggering
 incomplete-line check
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 2:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> A new-style unified context diff represents an empty context line
> with an empty line (instead of a line with a single SP on it).  The
> code to check whitespace errors in an incoming patch is designed to
> omit the first byte of a line (typically SP, "-", or "+") and pass the
> remainder of the line to the whitespace checker.
>
> Usually we do not pass a context line to the whitespace error checker,
> but when we are correcting errors, we do.  This "remove the first
> byte and send the remainder" strategy of checking a line ended up
> sending a zero-length string to the whitespace checker when seeing a
> new-style empty context line, which caused the whitespace checker to
> say "ah, you do not even have a newline at the end!", leading to an
> "incomplete line" in the middle of the patch!
>
> Fix this by pretending that we got a traditional empty context line
> when we drive the whitespace checker.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
> index 29ea7d4268..8573e12f46 100755
> --- a/t/t4124-apply-ws-rule.sh
> +++ b/t/t4124-apply-ws-rule.sh
> @@ -561,6 +561,22 @@ test_expect_success 'check incomplete lines (setup)'=
 '
> +test_expect_success 'no incomplete context line (not an error)' '
> +       test_when_finished "rm -f sample*-i patch patch-new target" &&
> +       (test_write_lines 1 2 3 "" 4 5 ) >sample-i &&
> +       (test_write_lines 1 2 3 "" 0 5 ) >sample2-i &&

Curious. Why are the `test_write_line` invocations wrapped in parentheses?

Also, is the whitespace before the closing parenthesis intentional?

>  test_expect_success 'incomplete context line (not an error)' '
>         (test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
>         (test_write_lines 1 2 3 0 5 && printf 6) >sample2-i &&

Perhaps the parentheses in the new test were copied from some existing
test, such as this, which already used them for a legitimate reason?
