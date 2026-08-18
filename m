Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA283A7F58
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042583; cv=pass; b=FxulvW7f8qC1kjNf7GkpQc029dFhNJnppJ64yTRreDQlJDxPZubU0aQ2bb71U78e8Cu5YENGTYwjNUnTbt80Y2hd0HJ4RPpW7J9pHngL+R1uoDLwQzn+ZG/RYE8too+8E/ly5MR7aRPqgORn73fw0dEfcrc+SHaWNTZCBIGaEWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042583; c=relaxed/simple;
	bh=Y8sS8A4drTqlTGS5KRkshvCpT66ZyO9vKEp4cEfiroI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tu8kB2IWQ0/ctS1sxTJrwecPd4ScBMB+6YsOCq0TfA5fFaJ7E9WDls0xW3mMt35mCF+SaROxEEaLoCEizWPr5v3muQD/KmiFSAaPY7hYGIj47VIAL/zsUa19kRYEZuicPNU10lYQVTh16/z9hSlHeKtBF2AvSTCcIwXV9NR5Ec0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMUmf2sE; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMUmf2sE"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7389cff36bdso944840137.1
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 01:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787042580; cv=none;
        d=google.com; s=arc-20260327;
        b=PaptPPDSaw7HES5kAbYJEzD0ceEkIXKFpjkTYOCgtF5atCvf9AxoUF7QXUsWSix5f2
         v3YqwDOAjfXaROtb2F/fbwyJ2H2oLE3DwxGHz5VSfNqIPT1wl4yiVygyVBGFZRJDtyXh
         NXGHp9jga7fs4I4O3mJ7SbalmQhqL95p25gA0lQrFGxmt9GG1phJusy7hAbPEu9ayzF8
         vX4sKYmxJvft44HOOXwG+HcNHfK+wQDVX/ygYlAnGsCRP3ITroumTEhaejEicfKMriA5
         hWNmwKKg5ONuQZC7N95y9++VusYB/jh3ItHjjEvTEMVoUmjCmE3OesZmitRfBxwYyCRR
         DvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=vMuv2uE+mLLBAGL9+E+Jn59mWlXYKf5ZamswtmdMEoA=;
        fh=LibUWz8r0OxUl6A++e/pYBiQ1oFC/ZBVkWdkK/rfKEA=;
        b=impxTcGwVMsXtjAluOGaKZ5EH+W/KekL5SV5Ca5ZBG9hbQ7vX22utXaFmBSEdZUOk7
         Ede9Zb9YoimJ9L32Yej4mi4+Vnvhq823kDR3NjsnCqvJh7pDVPNCB5SKfCiucYe4BVVA
         IoV35Mol05zr3U3lwUN1qoKuea86F5zt8/VKOHcXvgN9A4ati7MhR7iVRtsCsg2FYsjm
         zfKfcY0bi3JgOlC3qMyWOG8Xi4mD0luVpIwJcQrQVviKia/ekriVLw8dv0mF1FB8Vaxi
         dP4/YrTZ0UjgXzYk21K9tOZE6IuTDVni5xBHr81lg21lqjzGnXaMKJxvI6J4EOnGlFc8
         mP6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787042580; x=1787647380; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vMuv2uE+mLLBAGL9+E+Jn59mWlXYKf5ZamswtmdMEoA=;
        b=bMUmf2sEUkLdxNYE0BzO+wAJTEogB6YHg3i8sRvSyGvnypu/M1TzdUwfcMDlFwL+/5
         BnJhL00mk1ZrFL8N/1GYU2GryigrBGdtCW6fuLyoAXTDEq5m9/1aQW5YcISIMS8zDXJy
         tKQO66LjDvow9Z8R2rfQK8wMSus5BNntbluVnvxHixnpusCavorYAfKC/8nGtTpEMMY6
         +1iidYdEFmZdqYkQ8JFdIlkZkz5xpah8ocLLGxYb28OjhhHbMtN1Ob2ZRbQ1InW+eS8w
         Iu6WNB3IQv33/2QwP/w/nCSX0O2SKtyYVQrk3Z8iXbF0jifGgGtLoZHpWtWcG2Ij4rZO
         5vQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787042580; x=1787647380;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vMuv2uE+mLLBAGL9+E+Jn59mWlXYKf5ZamswtmdMEoA=;
        b=CvqxcAJf/CeyrVrxYBeSYaeh2lTXCU8T/o7nYryCtZmADKRh42DObRWOAG821kaPmL
         Lm2DAgYSAIT0C1OwC/FlyxbLP8x9tHRbTJfw4+6TBduuAcGe7G5+0iH083wbKttuHiuK
         t4lSlBN9fbL4mtR8JEdPBmT46D7UJHmm+q6SnNULbaZ9X9XjGeN30l0HtcLyHOJE8NuP
         xrt0vl3ylTagM1ROOibmvu1b2Mef/+SiQOiYGYZUOs6+rFfAWmlSxseMWDc7KIi5Zck4
         aZkDjXEhy5ihmjbH1dfMnjXoPYbSlBrbKZFWtj+lUXkSKgQq9PENC7FmdoVJ92gK84ol
         FVBQ==
X-Forwarded-Encrypted: i=1; AHgh+RoowrykCPwU0Kw4Rke7GjbZk65kjly3M0p4Zl1MsBJmdac6klJkAvzytWXvI/RBaerxfWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4gQdba9l1PA60LhhNWaGV95a5xTrzoDW2/LibqM2iJovC1rr2
	H3jOxLMCpMjFR+4SCA68cgiuB5DmJp5mXYQzaMZPGGVE6PYrTIi/Lv3kZl4K/h8XywjYL6QGpEj
	ND+7K8ykQnwioDgz1tRtmal3xdJ6kqk8=
X-Gm-Gg: AR+sD10v9Y43+QA0nX4OWv9Z/f2PmBTulphDKCqmlhe3ByjAAyo16cEQ01IilwlsZ40
	6vUs1/NUrZERM5fmRrotx3USa4kck/whwGoRNWda4yfVfjAwvx0x7P0H8NS4tVHX5NSDAz7yQKl
	EIDFpUctGmd/W9Wz37DFlqO+Ftp90NXtwrIufjB7Utz2GQZL5QMpxwsZUROL6aFpNV9bRZud4B5
	bTc+6eMGa4uBS7KoTD5YlIn7Kh6FDtjMDtTK1kUJ6J26XRN9iPAz1Jd15CH2z9ZifvuJsCVfVtU
	cO05qLIbyzT0sY55jFVG6Q7yIHirMCK9xyypsfIHtKfx4B+NtXzytCbhKnPoWhFyonDRGjD/CHh
	kJXKWq+/x66Zl4N9wOkRpB+PfgPDKw/XGAOM=
X-Received: by 2002:a05:6102:5345:b0:739:918a:16c5 with SMTP id
 ada2fe7eead31-7747c0b5429mr1706752137.3.1787042580063; Tue, 18 Aug 2026
 01:43:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Aug 2026 04:42:59 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Aug 2026 04:42:59 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260817211936.2943278-2-keni@his.com>
References: <20260817211936.2943278-1-keni@his.com> <20260817211936.2943278-2-keni@his.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Aug 2026 04:42:59 -0400
X-Gm-Features: AcwNN1WiQ_5PlBRyQWQAUcGjwXNhEkihHE4hEM-ZoIgNb1SXMOzM4DdUI3YYcpI
Message-ID: <CAOLa=ZQLgxhq2TVS1AYpRoAc_8AkWVtv_VhEm2HovgEX_cFvWg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] config: surface editor failure in exit code
To: Kenneth Lorber <keni@his.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000002f10d606594e4660"

--0000000000002f10d606594e4660
Content-Type: text/plain; charset="UTF-8"

Kenneth Lorber <keni@his.com> writes:

> Teach git config --edit to show editor failure to the
> parent process.
>
> Add 2 tests to t1300 to check editor exiting successfully
> or failing.
>
> Signed-off-by: Kenneth Lorber <keni@his.com>
> ---
>  builtin/config.c  |  5 +++--
>  t/t1300-config.sh | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index 0882899c3f..a166b2131e 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -1291,6 +1291,7 @@ static int cmd_config_remove_section(int argc, const char **argv, const char *pr
>  static int show_editor(struct config_location_options *opts)
>  {
>  	char *config_file;
> +	int ret;
>
>  	if (!opts->source.file && !startup_info->have_repository)
>  		die(_("not in a git directory"));
> @@ -1313,10 +1314,10 @@ static int show_editor(struct config_location_options *opts)
>  		else if (errno != EEXIST)
>  			die_errno(_("cannot create configuration file %s"), config_file);
>  	}
> -	launch_editor(config_file, NULL, NULL);
> +	ret = launch_editor(config_file, NULL, NULL);
>  	free(config_file);
>
> -	return 0;
> +	return ret;
>  }
>
>  static int cmd_config_edit(int argc, const char **argv, const char *prefix,
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index e3f8064889..9a8f852a86 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1823,6 +1823,24 @@ test_expect_success 'command line overrides environment config' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'git config --edit successful exit' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	GIT_EDITOR=true &&
> +	export GIT_EDITOR &&
> +	git -C repo config -e &&
> +	unset GIT_EDITOR
> +'

Nit: couldn't this be simply `test_env GIT_EDITOR=true git -C repo
config -e` and avoid the set, export and unset?

> +
> +test_expect_success 'git config --edit failure exit' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	GIT_EDITOR=false &&
> +	export GIT_EDITOR &&
> +	test_must_fail git -C repo config -e &&
> +	unset GIT_EDITOR
> +'

Same here..

> +
>  test_expect_success 'git config --edit works' '
>  	git config -f tmp test.value no &&
>  	echo test.value=yes >expect &&
> --
> 2.43.0

The patch looks good to me otherwise :)

--0000000000002f10d606594e4660
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1d1f7b2dd3ceee63_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xRUd4RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0orQy80alVnNGN2Q1NZRmcyaTJmZ25nUTlFWFZLSQpsQlJUNUJJc3Zl
dEFPVlVtdnZ2MXBJaHFRRHRiUS9Wc1U3bnl4SERqYWNVMEo4VjFLcVdIOUJ2a1ppb0VDd1RsCnhB
Y1VMYncwZW05c0JrUDRwWVNWMUNjcVo2NlZzM2Rwb2pkeGpRdk1mZFFOekRCSWllSmZHVmtTRVpY
dE9qVUkKbno4bEg5TXVRaDhodkVsZXczOGtlaUViQi9nZ3Uybk4yZVljN3RLV0FwMkk5YVJjRTYv
YVFrT3lDdFNYeFRaWgpkSm85RXVxQUREc1E5bVJMMEJISWZjNURkRWhlWkNKTlE5ZDkvWkphMC9k
dS82QU9pUTN0clAwUUJEaHJVQURBCkR4Rmx4QzJvYTRCalFXUS9ydEh3MjVNL3ZWb3JTRk9rbVlH
dm4rU2Z4Q2ovdjJQeEFHVHI2SEMrS3ROa280ckUKUXIzTlBjS0FUV0QwSXJCMmZ1Y3ZpUHNicElV
eGhqMUhsdzRJb1VpVFJvTHYvTlFHdUpodnMxVmZmQno4bFlPdQpsQ2ZlV28yQWZGOG41cEJXU3RN
UlkzU0lYOEtSQVlRZmxUU2lDUGI3UktLbHEzcFBqQnVTcFFKajJEeHlIaVdjCjV1R0Yvb203RVBF
aE8vbUNFcHlldnh2SGdvZWd5OG42b3lJU2xyYz0KPVpJSy8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002f10d606594e4660--
