Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B82FFF8D
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776156777; cv=pass; b=WypMEI/S6FgbIOqQ0fyc6aK0J8MA3o7Muosyn+6hps+LRQv+MB57gAwu6msdYHcjsUV4pkracxD8fK9ti1d2EeVprBvrm6dH2apC3scg9R0YwSgmqMnRNjiyYCXt9+nnjK1sS86Ugfbec6n/BttDUF3Uv1/1imECpBhtlglHayU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776156777; c=relaxed/simple;
	bh=SFnC7MO3bm8TyaQzu+wosDciphSdeZd8lfJh3Kxcd5w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kn73B24TJg/ohgR7lVYqkXYEhXgtMxuNZlXSABkAIEgbggB14uNtJt61ECy/VItlz/xair/0Hmu3QK8UtEHJB6Mpk8f/Dm66OH+f9Vy7X1tC9MXz12WaXeC58UyBHkETQP9JudLl5J9swsfgf1AyyMIM51aUJwUT4bNxZ4jWI0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIIbOdoe; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIIbOdoe"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-610e2e8f57dso331219137.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 01:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776156775; cv=none;
        d=google.com; s=arc-20240605;
        b=dGiX3bJVg9rOGyZ+8fNiz543mY9eXKGOAwRVjvd+CI5YJ5/QDfgnsvBw2tfLCyUrGD
         oNy5h8OgVlLQMHkVo/P+G4V8iPSIzCcudnZZntM/aj2F8y3qBwDIi6zSQbErH53k/68S
         +NcqI9V8gF7I0xz9gHpfRUYaNYT/oKB+Ex78kuJo/BeJIiSEpfOVf4TbufZfNLVAEczw
         le1v1aoXW+Ph8RPFj8WwnDdIk11tXpHzde65/F1z9nT3J2pIGE2e3n52Y0inVVrjGZxd
         5PbV9KxFxo6O2U0iO4S+1FW01VNOrQsBIZ1DTMvYQkOTZSFUOlD8MpCnJ8TkMK4mHOGy
         U6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=J4FbbxWY5mHiOl/GjkB3UNgNEC0wz7PLz+ZVaGxmB9M=;
        fh=GhkfN4edOp6AHIeW5VW4kRoz07vKjPe2eWgqsffj0Ns=;
        b=SALtVEFXFB/tqIRk5fgN6ekzv38MfLn/PH9UzQkJ9uL797BryzCXxq8vzQ9FJzkAk5
         Geg6gOWtODtKGVbJh6tlF0UHKKBPjxBFBjPN3LpHZ4kqmyw95C09X5ft/R6Tpnf9nbZ3
         Ot6AYNiJE47J6o76aMh7/Xzqjk3E77b/I9EB55Om0nauDYes2RdfsBRXNIYERp2rBXZK
         Wu0gv0Sg3uX7377D5S/zx8ykuyMFZOEm5YQnSbTBNgXMyirfFRuR7WMjieyzkmqgMqe+
         qisQnHDH5KkouNJgOpLBeEDWY14Hg0l87RT5kt07YYTsPNoE0N+WDS6DdGljS+qnToEg
         kHdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776156775; x=1776761575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4FbbxWY5mHiOl/GjkB3UNgNEC0wz7PLz+ZVaGxmB9M=;
        b=fIIbOdoeLf+iyLzjB12c+rQ4OXcyP0b6Esy1tTzUnYOsmRzIrOcHDU0s5gv0ZQ0BAR
         x1fLS2OtYAUS3WoKyqBKCzfz7q4ejT2b1STvf0kQeS+j4EVi+7lZwepuwJla0M3A0bjA
         WO4ZxgIP6NEEh9NaR+mCZHyr2YLH2ywXPTrSCzMWuOEdk4cFKEkMkvltuueRSzATSa8r
         8f7cUUWY7A8rZeHMobGU7RIMECy1iNGJjeaHc5VlkMu3Vd2US47rw9he5xYa2bcch/AP
         Ul8CYzkWweCZXTSePqgo2g7HA8I03zLfqcFXkYWaAcPcaAwTnr32OLmd5uR3Fc0d7Y2a
         d5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776156775; x=1776761575;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4FbbxWY5mHiOl/GjkB3UNgNEC0wz7PLz+ZVaGxmB9M=;
        b=SjwU9rCVvlsdxOaLNDHm8e71UEZRrB6Dg1bxKbH0w6qTLRTpWpZvBQIANFFUsQ8wi2
         vfRn1eyJOIOhkSSS5JQdoHrZOo51NXvKD8/ej6V+YNMVuWu5xUia29SJIMKrh4rQibMa
         HaBoxSG0EA6E0e5l/LQoXZ7IjwCzD1Yq/niQpMq6Fm12Kcz6g2UpPsOYp93Geef004zp
         lEnboWp1ri5GTGAPj+JGksn0de1FBg1fgCcrmxBXVd14ZXXehyJN7sauK8q4EQvOC7pe
         6C35Eri2HO1+fXzICGWn2uyXuDr9EE4am6om9FDS7EDBehDOzPnJTzmc9LO6cXfC0TDS
         /1Wg==
X-Forwarded-Encrypted: i=1; AFNElJ8b4lcMguQAFyt/e7p5AvYidwi/S7qJHn1dKoflRv46b9moHLPdjODCYaMWu/TXBtbmV+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVvw/t+AS8P/4s5dRdQeKipsrtwlmjWhXhjWNEj7iuzQdSaVsx
	YpTu2T171UYQ+ThDkj++l/KzqUpFx/diiDk8f8neGb3F60eCsh5HbCP1OTrrL91oupT9zfdZg5F
	c4lbO4p51QiGxG6VNq5z/olgEtV7SB7s=
X-Gm-Gg: AeBDieupvehY2OhcFOFFBTfZ3JFOEz9iWvl91h6540BxIGH31+CvNkNM5wbKcBmmoWf
	cCSIyyEPYaMnH4rL/NSB5n3SWyFJE+kiCkJf0IAoWmoICOYHgdHqJlJrVmltiJOY/Oopk5rnY1O
	+53SZmLzUsvmWo5hibyCJDqYVacofKlO+kXID9wLLSLZCnGOlw9kN1BMlIjZh+8WjR5eHwdw3QE
	1zmHdCzb7p+AN220hf1fKXWgBAQa2wvrbzno74GtLhekIQ7xGbBWeGjo1z66jtIX6xF7Ss2Iwx/
	MAr0415YlSy+z0Qencv88rklm9mrnLH9WSWB36a7plc0mUKy6Nrj
X-Received: by 2002:a05:6102:4589:b0:5ff:efdc:e225 with SMTP id
 ada2fe7eead31-609fe7a6af5mr7180744137.3.1776156774957; Tue, 14 Apr 2026
 01:52:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 01:52:54 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 01:52:54 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260324123750.157143-2-belkid98@gmail.com>
References: <20260324123750.157143-1-belkid98@gmail.com> <20260324123750.157143-2-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Apr 2026 01:52:54 -0700
X-Gm-Features: AQROBzA90ONOSBcvh-9bK_gJLSuCbjvAPKVq-W5MHddrx7WdBUU0KfujgvOeOzU
Message-ID: <CAOLa=ZTD+qqgyB4Pn4bcOfP+Ks8Zch+AWZkzhrRRbk-eJvS-mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] environment: move "trust_ctime" into `struct repo_config_values`
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: phillip.wood123@gmail.com, gitster@pobox.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com
Content-Type: multipart/mixed; boundary="000000000000a323dc064f67b954"

--000000000000a323dc064f67b954
Content-Type: text/plain; charset="UTF-8"

Olamide Caleb Bello <belkid98@gmail.com> writes:

> The `core.trustctime` configuration is currently stored in the global
> variable `trust_ctime`, which makes it shared across repository
> instances in a single process.
>
> Store it instead in `repo_config_values`, so the value is tied to the
> repository from which it was read. This preserves existing behavior
> while avoiding cross-repository state leakage and continues the effort
> to reduce reliance on global configuration state.
>
> Update all references to use repo_config_values().
>

Nit: I was hoping you'd also shed light on why this can go into
`repo_config_values()`. Does it need to be eagerly parsed? If so, why?

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> ---
>  environment.c | 4 ++--
>  environment.h | 2 +-
>  statinfo.c    | 6 ++++--
>  3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index fc3ed8bb1c..0a9067729e 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -42,7 +42,6 @@ static int pack_compression_seen;
>  static int zlib_compression_seen;
>
>  int trust_executable_bit = 1;
> -int trust_ctime = 1;
>  int check_stat = 1;
>  int has_symlinks = 1;
>  int minimum_abbrev = 4, default_abbrev = -1;
> @@ -309,7 +308,7 @@ int git_default_core_config(const char *var, const char *value,
>  		return 0;
>  	}
>  	if (!strcmp(var, "core.trustctime")) {
> -		trust_ctime = git_config_bool(var, value);
> +		cfg->trust_ctime = git_config_bool(var, value);
>  		return 0;
>  	}
>  	if (!strcmp(var, "core.checkstat")) {
> @@ -721,4 +720,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
>  	cfg->attributes_file = NULL;
>  	cfg->apply_sparse_checkout = 0;
>  	cfg->branch_track = BRANCH_TRACK_REMOTE;
> +	cfg->trust_ctime = 1;
>  }
> diff --git a/environment.h b/environment.h
> index 123a71cdc8..64d537686e 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -91,6 +91,7 @@ struct repo_config_values {
>  	/* section "core" config values */
>  	char *attributes_file;
>  	int apply_sparse_checkout;
> +	int trust_ctime;
>

Since we parse it as a bool, perhaps we can make the variable to be of
type bool?

[snip]

--000000000000a323dc064f67b954
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 71ac510a942d34e5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uZUFHTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK28wQy85S0Z5THg4S1A4T3d6RmtyOU1rSTVJMGxBYgpLdS9mMmRuT2pR
R1IrNU9SWGlqelZVYWg4OUVrZjRIc2JVTXN5UU95RTZ3NzIzV0hCUjZENXk2bFhNWEhaNTU1Cnpa
ZGZmWE9xaUF3cFVXQndmOTh0dzFzM1YwQnVuY2d1Y1JzbWtlaks3THZPSzVjZjFEWTZKMmdyQVI3
OHN4eDQKTzVGd1JmdnAyVURFMTVyck9iSmgwMy9XT1dmMVpnSTFsdzFKQVJtcVJuMys4ajJOWkpG
V29qR0N1QkZHSjJSego2RWVNcEswcVVoL3RCR0NyTzFqbWxkYktvUnh3MzllNGtVMnJJSC9OUmlS
YkMycEJRUmpzY3JyM3VobGtKSzNzCjNrR1VPZHYvbzVIVlF5NlZ1S2kzT3BvTlFFY3BHYlVqaFAv
OEJTUk5RSXpnQnJRKzBlRk5lVWFRb1FDOE1tTkwKQU8xa0hBbUQ4RkVrYmU2VnQra2lYT096QWdF
bzZZbDdhQ2IzTDhiNy81S1ovQllxcm96eXRmSlhPbHRQVS9OTwptVmNFalltbGRMVk0wTmo0UW9S
Q2tETDVnQ0JhLzlSYWtEVTh3WDZ4VXE5RHJUcVZLbXViU0dTdG5VdEtvcExKCk8vazR4ajdlcEJv
M0pPYnlDTHRyWDRZbndSQjdGZ0FKdG1vMjFWQT0KPUwraC8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a323dc064f67b954--
