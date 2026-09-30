Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853344C9DF6
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769080; cv=pass; b=fhZ05480hRmzG6zH9Bf0e/WMpIaUL5anBiaOF/MEkBWSiVjbMHOyoT4RIjXWRT2pAeOWVxlz+GnMlc47ZZluzlRJaxDUNoFJfAKVbo4d/6sDwm0p0/ujOSgB/04r489q2/L8G4Gl1nypVOeQgzS8N4rHyPdOED7fYoDvIOyp9mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769080; c=relaxed/simple;
	bh=kUGDZNYManrFkuaT+zX9t3xK4vbXHGOkwaYi8hM7LC8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muY3z6J5E0qfgSFZCFh/ncsRApkoudGpgWfM251Y0udGFwNWCMye+KNgUkSMA5BmBVPbG/dRmKG8IfOhsxS3emj4CL0MSj80wGNXX3xRobSAxnjdcdl4dGN0qTGKzMI3hOVAxZysKoJ9Y7Tmiuh8zLc1TRtJVbcw043+6y6jZcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7JOWpon; arc=pass smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7JOWpon"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c67e512ee5so1806310e0c.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 04:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790769077; cv=none;
        d=google.com; s=arc-20260327;
        b=JWN5wum2ucAS7ViiJDA6efyH4GiAx5jUKpUcRtD3FtiKwIO5pKANxexaPg41UHXj7T
         6rtddK2kDYezYMvwmYYbbLC7z5DYJbzvfFJH8x5292IPnUfu51SALHohfyx2YfqK20eN
         9FQfgIeuShdU8wUTBnoN/qdi3Y2W4D2IH8MQKZ1CuCEoU6T+N6uSV2CDVcRchich3KRe
         pa5BTBwIUe0Gy+iQd5xpBCOMKQzYtok+DHcqjQXMxs0TxpyLNbf/OBuHQsAPGvl2Nr8L
         kE4jWxonGlFs3rBkKfJpmUPN+ylnQ0MswIpZlEzHsl2YKzCGWcUsN+cbrUhKpZzJlRoi
         YIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=BeNN6JQHdgqNTH2Tf8X/pGaBkuepDNAhmh+G9fgcI/I=;
        fh=Ymz5NQq7NnXzuzod5pZSZ7DvycUQtVkTm7UKhWW2lHI=;
        b=q5rSWVtC3zLFXCXCOk2NcvoNmbA4OmUmx4oc3RShYRwiirj1QLYmuZ7AK1whFebrew
         IHRWTyUMi991c7owdQi/vl0IumWjCLPiEZNwhPzXWdq2m+NdaRG2gdw5D9cq5tquhGIH
         HW3MY5DyDabWb+mfqoVJQrylQ5wmn+p3oWdFwsrdaR8/2mLinVAL6kHhpys1Yrhd21p2
         +sTesj1lfECfPardfjX0yYEHTF5fbLR1ofXmveXRpWbsXEHYlR9JrTcxSaLJ3EowqY9H
         DU6Ra0c5mCey4I2E3ZP/NBbKBObYwHgFnLG+3Hm5bCQDAJxOwtTFDx7u0gxHzkbyXRm2
         /Avw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790769077; x=1791373877; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BeNN6JQHdgqNTH2Tf8X/pGaBkuepDNAhmh+G9fgcI/I=;
        b=Z7JOWpon77HInjXQ2WrF70lLlsSXGjTF63asi1D9mJShPZ/GA7UOduWRvr9LpHz9Y3
         dshf8ltse0aETF9YLvWLXdfTjue9rdXRLaQLlnx7/TZCBZIIJ5CmihwZfanzMZDYfHuI
         6yIpKBVfIb8C6Y1f/JZdjPH05xZ+CmMZocjF/PG1/Eb1bUKziPVkywy4DpeMDe/lQM04
         EtW4rdvWYD+kihs/55hBPKpGU1Lo3Amtld/0RcXe0GhK14VN4cGjqbJIJOjxB6TbriU/
         JEaC6sxbiUgG6DafSPFYTyZ3ipTkypn9L6g+ZWQLMHkZZavhdeS1qXaEI+XBATHyzwbm
         myzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790769077; x=1791373877;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BeNN6JQHdgqNTH2Tf8X/pGaBkuepDNAhmh+G9fgcI/I=;
        b=z5JQRfzK0MXexREmUpjVjhTF+L3kEmtip2fHMfuzfz0fJjPeAh94Ba4018WLeSlYzT
         DprsEWXJox3Nxk0FhHBZ93nPFdjiD5DKULpV5Q+EGe7kcxBrnMvtBiEYgkgO/i97R8v/
         UPLRHAgOTiMwMapYTwfkZjzuj2nb0T51invfbV5ZwIzf8jf90jRm1bNv5KxQiFDaXtOG
         AmbRQe4AUSUsFNgdiRkRtjKNqF3rWYZSC496NBgAWTYPgvHezQP67LGljgIhosqUMwVm
         uRkeH/SNcwxA5DwcHyKeTr0xEed5VqyQtQyTWfHWhBb/We9PBt0Xk/QgDcBONTIpDrdi
         h9Cg==
X-Forwarded-Encrypted: i=1; AKwUvBygsQ4FScOeEJIPx3JrcuWLSiLucT6nhz4+yYrJrSwRtFdVXRIxkcd/sy8vs20CJP83mkQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7AU4L85/rdDEhD85WpmETM6voB8WFetaxh1UgzBrEI0kaOVoH
	mP7vvpGC9lm/v86QWh5pNFPBm842DVMPy+9qpY2RTGFz5p2ZFyQuicC5XTSEJ7rqNSoQWK5Y/7Q
	+JMdELRMtjX81FF6tyhZSKbH8abQYSl4=
X-Gm-Gg: AYBFou3EO20JuhjpVSRQU5XiVjFJUqiKfrPq4Prr4QKhAUNs7IptKGVIYP6bLnfRvFb
	Az46urPJupNq4Ps04kOL+Zs2o8vKKynyzXLxWFtall/u+U4GPBRdOuTAAVGugIe0L88G+uf9j2q
	jxAbnbV2rpJgvaBLXJt0VFhJ3+I07SBz0fcv8D0bJAvS0egrIerV8TCN5n9JYO+Nbh4MZ6b6DnR
	PhhUkLhP/BUkEcCPkdyVzMxeUD3E1OA7xSPzBQe6lEkWF4pFC/b62hWvsCUNfPng6sAOhsZxu9g
	n2gtoO6ezlW2PTRXqWHE7yR6AAkhftO7q/FxsFf6FFo7eZNKM/kgSwL91rIuVteME2haYOS5qDy
	Cy9+MdK36tQX363KeNcAXgGYreVqldyn1WAgknCaVzaZBEOQxcGriCDJS
X-Received: by 2002:a05:6122:1d48:b0:5c9:a60d:3278 with SMTP id
 71dfb90a1353d-5d67c00ce67mr241543e0c.12.1790769077123; Wed, 30 Sep 2026
 04:51:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 04:51:15 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 04:51:15 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260929-pks-reftables-fix-timezone-format-v1-3-3df105a95ed1@pks.im>
References: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
 <20260929-pks-reftables-fix-timezone-format-v1-3-3df105a95ed1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Sep 2026 04:51:15 -0700
X-Gm-Features: AclHuK8eJwM9PX1HJfjOoya2Du_Gi6ur1uieDsXFTZTBQOi3L9qQ3Ee33qcVo5I
Message-ID: <CAOLa=ZQorPk_Kkewkw5k-gdeh=VRVBMcaDA54S0ByJfAswcCWQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] refs/reftable: fix on-disk representation of reflog timezones
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Josh McKinney <git-bugs@lists.joshka.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000b7a0bb065cb1ea32"

--000000000000b7a0bb065cb1ea32
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> When writing reflog entries to disk we also record authorship
> information for the reflog. Besides the author name and mail address,
> it also contains the date and timezone at which the record has been
> created.
>
> The timezone information is typically encoded in the "[+-]HHMM" format,
> and we often pass it around as parsed integer. For example, the timezone
> "-0700" would be passed around as -700. And this is also the value that
> we eventually store in the reftable on disk.
>
> But the specification in "Documentation/technical/reftable.adoc" notes
> that the timezone is a "2-byte timezone offset in minutes (signed)". So
> instead of storing -700 in the above example, we have to first convert
> that value into minutes and then store -420. We don't though, so we have
> a mismatch between specification and implementation.
>
> Ideally, we'd just adapt the specification to match the implementation.
> But that's easier said than done, because the specification is 11 years
> old by now and reftables have already been implemented by JGit for a
> long time. So if we now changed the specification, those libraries would
> have to make a backwards-incompatible change.
>
> Another alternative would be to bump the reftable format version, but
> that feels suboptimal, too. Other libraries would all have to adapt, and
> it wouldn't really help us to fix the discrepancy between alternative
> implementations and our implementation as older versions would still be
> misinterpreted.
>
> The only viable option seems to be that we simply treat this as a bug
> and fix it. This will of course make us misinterpret older reftables
> that already exist on disk:
>
>   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>   =E2=94=82 tz    =E2=94=82 HHMM encoding =E2=94=82 correct minutes =E2=
=94=82 divergence =E2=94=82
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 +1400 =E2=94=82 1400          =E2=94=82 840             =E2=
=94=82 560        =E2=94=82
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 -1200 =E2=94=82 -1200         =E2=94=82 -720            =E2=
=94=82 480        =E2=94=82
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 +0530 =E2=94=82 530           =E2=94=82 330             =E2=
=94=82 200        =E2=94=82
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 +0000 =E2=94=82 0             =E2=94=82 0               =E2=
=94=82 0          =E2=94=82
>   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>
> But this divergence ultimately doesn't matter much, as Git only uses the
> timezone of reflog entries for display purposes anyway. We don't take
> the timezone into account when parsing "HEAD@{1.hour.ago}" syntax, and
> `should_expire_reflog_ent()` doesn't use it either to decide whether
> reflog entries should be pruned.
>
> In summary, the fallout from this change is quite contained. Adapt the
> reftable backend accordingly and simply reinterpret the timezones with
> the specified meaning.
>
> Add a test to verify that we properly encode the timezone as offset in
> minutes. Adapt the test helper accordingly to no longer zero-pad the
> offset with "%04d", as that can be easily misinterpreted as the "HHMM"
> encoding.
>
> Reported-by: Josh McKinney <git-bugs@lists.joshka.net>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c    |  7 ++++---
>  t/helper/test-reftable.c   |  2 +-
>  t/t0610-reftable-basics.sh | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 10db03991e..d0de066355 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -2,6 +2,7 @@
>  #include "../abspath.h"
>  #include "../chdir-notify.h"
>  #include "../config.h"
> +#include "../date.h"
>  #include "../dir.h"
>  #include "../environment.h"
>  #include "../fsck.h"
> @@ -317,7 +318,7 @@ static void fill_reftable_log_record(struct reftable_=
log_record *log, const stru
>  		tz_begin++;
>  	}
>
> -	log->value.update.tz_offset =3D sign * atoi(tz_begin);
> +	log->value.update.tz_offset =3D tz_to_minutes(sign * atoi(tz_begin));
>  }
>
>  static int reftable_be_config(const char *var, const char *value,
> @@ -2186,7 +2187,7 @@ static int yield_log_record(struct reftable_ref_sto=
re *refs,
>  	full_committer =3D fmt_ident(log->value.update.name, log->value.update.=
email,
>  				   WANT_COMMITTER_IDENT, NULL, IDENT_NO_DATE);
>  	return fn(log->refname, &old_oid, &new_oid, full_committer,
> -		  log->value.update.time, log->value.update.tz_offset,
> +		  log->value.update.time, minutes_to_tz(log->value.update.tz_offset),
>  		  log->value.update.message, cb_data);
>  }
>
> @@ -2690,7 +2691,7 @@ static int reftable_be_reflog_expire(struct ref_sto=
re *ref_store,
>
>  		if (should_prune_fn(&old_oid, &new_oid, logs[i].value.update.email,
>  				    (timestamp_t)logs[i].value.update.time,
> -				    logs[i].value.update.tz_offset,
> +				    minutes_to_tz(logs[i].value.update.tz_offset),
>  				    logs[i].value.update.message,
>  				    policy_cb_data)) {
>  			dest->value_type =3D REFTABLE_LOG_DELETION;
> diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
> index 57758936b0..d9f2ca1d0e 100644
> --- a/t/helper/test-reftable.c
> +++ b/t/helper/test-reftable.c
> @@ -163,7 +163,7 @@ static int dump_table(struct reftable_merged_table *m=
t)
>  			       log.update_index);
>  			break;
>  		case REFTABLE_LOG_UPDATE:
> -			printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n",
> +			printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %d\n",
>  			       log.refname, log.update_index,
>  			       log.value.update.name ? log.value.update.name : "",
>  			       log.value.update.email ? log.value.update.email : "",
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 35e98b43db..579657467d 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -837,6 +837,41 @@ test_expect_success 'reflog: renaming branch writes =
reflog entry' '
>  	)
>  '
>
> +test_expect_success 'reflog: timezone offset is stored in minutes' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		GIT_COMMITTER_DATE=3D"1234567890 -1200" git commit --allow-empty -m mi=
n &&
> +		GIT_COMMITTER_DATE=3D"1234567890 +0530" git commit --allow-empty -m ea=
st &&
> +		GIT_COMMITTER_DATE=3D"1234567890 -0800" git commit --allow-empty -m we=
st &&
> +		GIT_COMMITTER_DATE=3D"1234567890 +1400" git commit --allow-empty -m ma=
x &&

Nit: it would be nice to have a negative timezone with MM filled in too.

> +		# The reftable format specifies the timezone as the offset from
> +		# UTC in minutes, whereas Git uses the parsed form of "+HHMM"
> +		# internally. Verify that we do the conversion when writing.
> +		for table in .git/reftable/*.ref
> +		do
> +			test-tool dump-reftable -t "$table" || return 1
> +		done >dump &&
> +		sed -n "s/^log{refs\/heads\/main([0-9]*) .* 1234567890 //p" dump >actu=
al &&
> +		cat >expect <<-\EOF &&
> +		840
> +		-480
> +		330
> +		-720
> +		EOF
> +		test_cmp expect actual &&
> +
> +		# And verify that we convert back when reading.
> +		test-tool ref-store main for-each-reflog-ent refs/heads/main >entries =
&&
> +		test_grep "1234567890 -1200	commit (initial): min" entries &&
> +		test_grep "1234567890 +0530	commit: east" entries &&
> +		test_grep "1234567890 -0800	commit: west" entries &&
> +		test_grep "1234567890 +1400	commit: max" entries
> +	)
> +'
> +
>  test_expect_success 'reflog: can store empty logs' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
>
> --
> 2.56.0.rc2.329.gd58861e689.dirty

Apart from the nit, the changes look good.

--000000000000b7a0bb065cb1ea32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 67c66dc12b6cc1d9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xODk3SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0Z1Qy80NWQySHhRVzg0bmZFWTNRbEttazlqV2hHVQo5M21LUUJGNDU0
YzRGYmFoZjh1K3VlNUl6NHNPd25LYWIzbGtBTnJ2b0FNZzNUeW5ITjdLdEgyNlBwNFFMUkVmCmts
MTRkOUVNNjZCZHR0ckNZb0FiZzFqVVJDNkpJbmtHZmhlaUF0bnd1Mmg4bVRjV3FlckZKcmlJSmVJ
cDM5RkEKTGwwZXBkK0JtaGxZcUxIWjlPRGxJK1ZEMkRJbG5wNUlZdldBdVIybENmd21sS00xa0Ra
a1dsd21PSEhjZE10TQp4ekJBWE10S2Frc054TGcwd0V4Zk9zZkVvQUNkVCtHd1oyVVFZV0Y4bkZh
amt0Z25IckdTdG5NdkppczBrREVTCm9YakNyNUN5bVZDU2VVNmwrdmpTUUVtd0cwc2ZVdmVoOGlR
VW9OdWsrbEJKSStJbFhjVld3ejhQNjdMSzAzMXAKUVpESy9WeTJoQXNtVFVUbzRkclVmcTdrTHlX
N2dpQktIQnBGbnkvUUpob1FnMGh0eXVucVlzZG1CckpaMjI2bQppK2dmWS84QTdMbkVqcGFZV1BF
Q0h3Sk1sMWNBQldVTTAzUXpUZmdMVnNxQlZKU2UycXhXMU16SVltSC9weitVCnA4VkxtZjFsMDJu
Y2p3ZFRtOStHeEpHaDBUajJMUGhQVDk2aVcxaz0KPUdNbUgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b7a0bb065cb1ea32--
