Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F22DC334
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782593923; cv=pass; b=OAdn5MOsIG7IxH05pdT4aRLMxLntefaknHXKrCiUNWYdm8EC6QEdJ6SpmFEHRNoikltR2gv0i7BCfwUb6cy2+yrB0OGxWbcwU6ipwVIsjwYFdZmgvroBlcNLFozcaPeLpsLkdfxM52iKte0OnNr1VgSlW0HpageUZAmLx+oihjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782593923; c=relaxed/simple;
	bh=qel3XmHhx8ksLLJTa7takvaSe29FNC5wuRqAiP3R99s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLUWc9Zg4aWpbwNO4DU9Zu+cZZaei14NXM6ZJJRLo1fSfPZojhi/eSTbLuk2DU3Zon1IVs4DNfFQ5WXhJMnj72K+uvrYJlUOUxh5kgA7yRG040TRswkedLhyJJxfpTIeWfVNLU2+9qXVhNn6M7iFSRRDZTsoQQdGoGazpQeZnf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nv3OziMA; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nv3OziMA"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80c8c9ae040so9820157b3.2
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 13:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782593921; cv=none;
        d=google.com; s=arc-20260327;
        b=rboVp/QPQzo31Y361ZU8jj/nEWNCTt9sXGJHQTGe7KI3TW2+Gk0D8vpnZwK79isenz
         5OYj9wTDmMxskD1q0TvkVkasmuIQJM28Fxs9gedta0n7ugcUWc9mIc3PgPrHe+4HC09C
         rli+YBBaIISHc+zpZS/poyZ0bvlXtSYo+O9ws7viW9bPvc8rwvD98zN4b6nhkm1E3HeV
         JQTMhPAePqkGSXmyyf2P7J6Z6csC/vJtWS+XcmTmVh9PqF9EP8R+QcrGRZ2D55WlmWtf
         emPs9Eqg9Vg/GhnTLtj7tI1qc9cRE1o43Chp46JgIllaFHq/AUUt7G0K+akC1+I7G0Tj
         9xDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CBHRor6GfWtWTYzVRQOuempjb/ryDWIdLr46tdMFf0A=;
        fh=II1xNaWpsbGGoje1lWhXs73nMC4GzAl4tRfC7+O7yrw=;
        b=HHnBsBAyF5VfEnmmN0GzESpN7UsRHkC7D+5JL7p69//WXnXReZ98kcwsTy9zJl9dzl
         Yyqry/jvRLiV6ZTdJ8IZygyv9IDUM5UkFE6VD1tH0CDYRhNzti7e4kVNyupCvnVIjSv3
         beKd+SrkW53tev8tC2V2/zAVPOMoDEnwFR5q9m5QisVbOsYNOSPjN8nzzRCx2AgitZGC
         7xcBBlw9QQU7/dcRPg5pIPXHkf4Nf1CbfUWdPJZ8tGk8qsizCZ5GKnJ7Ttl6qP9o+N7C
         21sn95rzZZhvi3vNKpbF5c9e/yIiDPQpTzpW4hCa94usE5/IAowIjHNKIBePZf63tOl2
         dbvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782593921; x=1783198721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBHRor6GfWtWTYzVRQOuempjb/ryDWIdLr46tdMFf0A=;
        b=nv3OziMAZouhkXltbpLDFjUSehaVF7SI8fQ7TpBqDxJrnH+zqx2mOKLkOvwfnTQU70
         GLToGp8ftlhjVIfuGN21NlDuZ4oyBUUY3sfc0jg2W9mIDDgJDu07Gpk2zl9cgdb4EiF+
         QBpQTHULL/n5LpVqwkF1yOtExRVAdS1tzH7R/jaILI/PfIMYL/m1Tk6Kb+YKTcesQ9FP
         s2rSH6sSGW4BSGs119DWxKkELaK524I3o5vmWcOtja7sVEgWTwFlV4JBji7PacprmrSQ
         OdCtQX7ndHS7vfe14fLdtANanWfx6QOckr0Y5q8SFBNmV7l5c+rRC2I0oD2SEXlTgaiR
         xy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782593921; x=1783198721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CBHRor6GfWtWTYzVRQOuempjb/ryDWIdLr46tdMFf0A=;
        b=UeIiM4pR18DztB7L0ONWd3iGQfBfXrJHrWFoCw9+oqCDEAw7LD9F+XvU4r77xHwHU5
         5lUzkMHMu9glTh5IAcIneSJ56tKt8SWHD3vSyYNIwhgLBzEPQwLwHB5jMel3l0GLZlz4
         mxChvFpaURfJkn+IbtSQ6brZ3HGxKXB4eGkBXXpKBeVuHx6+YQJdXl15ESgSFCGJJ1Nc
         eQGJPOlcNIO5MXgWMlFrLgH1dmvGoWjh9+uxddq87rVP+8qQK98bUbc02mwjpft73x2M
         er4Ty+nj99zv+TLZyR1e0CzUUmD/stXuAkU9CBcM3h9phE8WVzh45BXh/1qUeskrHEz8
         ahxA==
X-Gm-Message-State: AOJu0Ywb1tMbWs5qeXhfV4NVkk7fXiUS55cLBN9Y0ajGf+D2NYM+uiGv
	lvmhRg+G/0CHVNFMybvXFlc8sM5bOlQMXrqUHA81Hp8hU3KlK6S2Vp9UOXUygrJ/HgS/jHHmTqJ
	XmaEqFxTi1QXL7GmU79Pd3fA/aqp8fUU=
X-Gm-Gg: AfdE7ck/3nQE/RdVXezjb0jAjPlHRkSt9nrjy6jPxdSjsYwaTbrnRiiZm5VfArmHwIi
	lM95KmvfQJO4Mcm0kTqT+ZaSpQ2YGjb04297fuMwWYmERhKAAsNeu+/b6WiSF+RI1RhS9N8zIXF
	xvxa8jWHU2ZC0nlfW4jrhcXIO0cq+O/o7IcRIOW1WwSTzTxH8Hyun8DNEcWKkT2yp3NfcsCtnUt
	iUfyku06Cbftw1QJEtTUeJiPsXsEbobOI4KClJ2zeCgKjF9Od5fEHnS7pXp8znNecRrm8gzfQcM
	OBWPPKQKDby9yowd4yXBLb5NTbUUf8MajEShV4Xe4hlB+8BdJeGGeLZdEMb30M8jPsE7I58/Ob7
	kJ3D5UQLQc1MRIg+pd0IwkpqTX8N4jkgDf3rKd5AkpnjV+hJsm4199A07X/PGPnPytCfwOHVZdj
	ZDHGLY
X-Received: by 2002:a05:690c:4989:b0:80c:85e5:872f with SMTP id
 00721157ae682-80c85e58b55mr64863477b3.61.1782593921057; Sat, 27 Jun 2026
 13:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260625-ps-eric-work-rebase-v14-7-09f7ffe21a53@gmail.com> <CAOLa=ZTdcg47nmZs2t1FvyOgG9S4Ap3RaK+C0Dhku6cG+wj_Kw@mail.gmail.com>
In-Reply-To: <CAOLa=ZTdcg47nmZs2t1FvyOgG9S4Ap3RaK+C0Dhku6cG+wj_Kw@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 27 Jun 2026 22:58:30 +0200
X-Gm-Features: AVVi8Cc2ljrjp5TJHnZADQKWj86a2zWOeSH7O8Mn8Z3tRh_oyhEWmpNOBDMvq3w
Message-ID: <CAN5EUNTZ+m1v90K2bivD1ZTNPc0jFPt4LseN-B-mGbifYHj5RQ@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 07/13] connect: refactor packet writing
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 26 jun 2026 a las 19:03, Karthik Nayak
(<karthik.188@gmail.com>) escribi=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> The subject is bit too generic no? Maybe we can talk about the function?
> Perhaps:
>
>     connect: make `write_fetch_command_and_capabilities()` more generic

Okay, I'll use that as the subject.

>
> > Refactor `write_fetch_command_and_capabilities()`, enabling it to serve
> > both fetch and additional commands.
> >
> > In this context, "command" refers to the "operations" supported by
> > Git's wire protocol https://git-scm.com/docs/protocol-v2, such as a Git
> > subcommand (e.g., git-fetch(1)) or a server-side operation like
> > "object-info" as implemented in commit a2ba162
> > (object-info: support for retrieving object info, 2021-04-20).
> >
> > Refactor the function signature to accept a command instead of the
> > hardcoded "fetch".
>
> [snip]

Thanks for the feedback,
Pablo.
