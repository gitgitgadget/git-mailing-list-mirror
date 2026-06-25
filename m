Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBF5149C6F
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394676; cv=pass; b=m0UPEf/yJrrFaFA07KnwIsil/Q2pds8hpqGc/g2iyx6hop9hRUgxiOzxV7QKPUtLp1nXxSJ2VJN8QenygwLvfZa49byaEoRD4GMLJP8rLoM8gWuqccYtr7PM4coePZNuvkIECa1mGzucxZeK2aTauHiJeJ53tlBA4JJYX2zeTzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394676; c=relaxed/simple;
	bh=yimOGCKOeJhLgBilKm54+08nYBKGong1n7QJtY6R73A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdjKoliK78mjFrDQ8ZtB+Bh+2mqyQ9ZI3mg8jBVTKqnwOCmgh4DkLIz3Qgnb/7ndR0+/2IcAInYhyI9kBJ+fwaKoKAVlR8uT+5vH5fa2fxyQkyNw1mPuZz/l3MUOxERbFBKzqfIkfc8+3wRP1ODuFekKuTJZ/K/p8mdQtmixmPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6hCxjT/; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6hCxjT/"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-447046c980aso1559521fac.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 06:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782394674; cv=none;
        d=google.com; s=arc-20260327;
        b=jiyfvZFpbd9DuBjub+Iw8bFww4HowSRkzFrM2xlxJ+4Ka5qpwRGauqW41QuopbWvqv
         aQjBf6bjc1o5mL41BobrD7LJjjMq6iS7KQHw6hcXUl5RbjvMc/RMf8UBg9OYTa9KsihY
         fxjPtT6PfLyNfvhiaTTzPGJ0u9COZWBwhVt+IMbow67s4bLDNua5fFjIG16A5sXeLnT0
         kL7EQxwCuNPihvp7KBMQyJrsDibUsu19HjKb+4NM8DKcuIEwqsG/uhtrqmxllZHuJfgi
         OZBxWjpdMb+QAinU3tetm/tkdn0rwQXfbJiU4iR1FkuXvP3jv6EQC3rSm8d++F1EZR0b
         0uLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fp+9ZYpU9DzbQRR6dsi/7aIIb1uVhox1ZmWAOGZuLR0=;
        fh=7EF8lVoseiMbV6oSZr/p+k8C74+zhtoOjLa803uCcrU=;
        b=Bu6z3bDa4BDCmmgkydrydnMyRl/ObNo0QFjkRrSE5whZuCf7rQY6Qx5iJokZvoIhI4
         ATiczT5ALE6yZ1jjWLmGViNKMLad+vCYAsc/xa5DNV29zUb5SBLRbjAS5HDKTw+lOJoh
         p3KfDmKmsoBiL6em/tBV2OHfZT0yoy1A0uZVv3/OpKjeFtROAnQcjsl1ZZCY4RTTNDnf
         89V7LPX4f3JJoLXNLeEp3JpaTpv0+flkW4PtD897pEYK7eFRg52jd8e5RXX/4+l3WwMq
         HMwuJdaEDyZX6ughEcWKU9uWJHKbYgFcNObtMxZ1OUQV56N950ZR6qSHgxlbroyHthwI
         UZ3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782394674; x=1782999474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp+9ZYpU9DzbQRR6dsi/7aIIb1uVhox1ZmWAOGZuLR0=;
        b=N6hCxjT/+P1vW+MRTOK7Nv7q+Ls6+XiX8l7OsL8gOGufx2ZGm65VErvxjG8FnvXylu
         JjGq/TJtBEe45cpTKkBcQEzYxnVmoQqGoeteCQalPomAYvpsAcwzEosVfUFuskU/7MqX
         ZCDoL8tjPoeOEDLyx6BauOq47sik12fGHiDx9/89dOqoRocw8AwRZRdow193gQPcbSDb
         5woEYwDqAgUEVQegg8bbDF+17IkmkOfPbMreSmG9/W/lVe7pPO3+W/LF5aYEDP1X1e6e
         NDjCUXiNFtZ17mXset/WTUQs7NX2817tBOcAYbEgDbGrg0wMG3a+bMNHyGrF6hfWyhCR
         L29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782394674; x=1782999474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fp+9ZYpU9DzbQRR6dsi/7aIIb1uVhox1ZmWAOGZuLR0=;
        b=GconxTUTMk833NMEPiwcFvuyKaIsbzByEwS1mJ5ouHrmYkDyddRZvf2+FZan3dVwt7
         ysJcRZ0YtIV6E10BRbnv34BLCPhMW0SWF56CSbrWQQvZNIbRMs036v8vCzallrDGeOYd
         hkVY9IuabmUfifdxqPrpIsJ9zkznh5FOkuY3H9Dmav4C7VBcPHFXo+8fvCeJ/Db6d/xn
         iZla82XEk8wax+qBIXp721STXynpWJWgg49W+6CjZfXEY8AYr97B37EeWSPwmu+DGoKI
         aq9tFf5yRitkFlJS7t5YBWHBo7g1YL8mnll9aCe2GyO2lWZy7psluGsd9ZvIJWEWoyeg
         XRSg==
X-Gm-Message-State: AOJu0YxhEEa5FOkrZlOUCPgIvY91bgWSkWXdB9Bfs4F0apCIn65BStWS
	+Ub8oS/zCZumDbOkbVZKExfL/eCDN/LJRRc32qIvvEX7gXoxWERTzioZ8VX2eI6jLjPT7UCPCdn
	opx5DTGRlLWf7/OtmyR6p4+wmffcbYcg=
X-Gm-Gg: AfdE7cm5FHb9F/UP4b0M0wOXyN/yzTGZdFbSDfISWzcpTwo14a6s4zQveZxra4D/d9e
	ruw956/2Ttla97Sa8iSdR378oRRLOpZMkYLHDooRq2HEucAHMeI3F6jmWkerDmO8oS0uzYc2LyP
	B49fe+Z7bywNKUb5HefSG3de1tZPBBluPbqWbRTjy30MJ7prWGWC33v/ggzvUHAaSp5xkjk1Xip
	3F1iy5Ci5qib/8SMNBCJdTy9+ZtozbK/KKDx3snwuyIgMKvb6LLj+cXLLzIqrIALwixCDUJEMS8
	cyK9wA5Dk/XtOy+N07uVPyN82kLecvWYy8jxnBcGrd1yy6yik8KCA6lZkg==
X-Received: by 2002:a05:6870:e995:b0:447:b25f:a54b with SMTP id
 586e51a60fabf-44811cc22b6mr2156047fac.22.1782394674522; Thu, 25 Jun 2026
 06:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im> <20260615-b4-pks-history-drop-v6-9-2e329e536d78@pks.im>
In-Reply-To: <20260615-b4-pks-history-drop-v6-9-2e329e536d78@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 25 Jun 2026 15:37:42 +0200
X-Gm-Features: AVVi8CdmjE6Y9NYLXExNKScioCnj1UFR7DP3udhD-ZHuiCkAwEktdsr4U5iu7mU
Message-ID: <CAP8UFD1evTZqj1ymW9g5g2RmMkYMaE0rPa0Hzt+irH94M6LD6A@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] builtin/history: split handling of ref updates
 into two phases
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 3:56=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:

> @@ -414,14 +389,43 @@ static int handle_reference_updates(struct rev_info=
 *revs,
>                     !detached_head)
>                         continue;
>
> +               ALLOC_GROW(result->updates, result->updates_nr + 1, resul=
t->updates_alloc);
> +               result->updates[result->updates_nr].refname =3D xstrdup(d=
ecoration->name);
> +               result->updates[result->updates_nr].old_oid =3D original-=
>object.oid;
> +               result->updates[result->updates_nr].new_oid =3D rewritten=
->object.oid;
> +               result->updates_nr++;

It looks like this duplicates what replay_result_queue_update() from
replay.c does.

> +       }
