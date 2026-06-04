Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0622223707
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557370; cv=pass; b=auGltfJzjM+6gsVK5pIpKnz9wXiPquT400jxFPWSp47ai1hT4+e62b06xJMY8eRuOkI6bUxn4E3bBN8VJX1FFu/I9BqNX/6Oo7nTlADOBBYNaOCFM8kHZeM20o0q/gIoPCGmNO5FKriAcgDnrhxyMFWU0OLPlEa9jhEiI4EVWTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557370; c=relaxed/simple;
	bh=1zCzfYnQ9ZGsMqT0Ywy3jthJ5fKaP8U8fHuDHc0AkJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ji0ku0ZDK0qz9gXQnJ/Qr8ieUzdsiwuSIlkmAVEwM5roOaBVLrRnBGZk6xM9z8C2+Y5fxn50I0gl1ZJF1Hm9DrtPnpNtWNHPwWe7igkF0vKuAZWjSXGlKTw7u1O9xdt6/4BeXp8+8jQJikSwFowDzc2f2gLxMb2wldet9gJk7Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWofECrr; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWofECrr"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec423a5265so53415366b.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 00:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780557367; cv=none;
        d=google.com; s=arc-20240605;
        b=ObitKGxLeKc0XQ2G5FMnz0aj15nzvFU6GMY7KCxmsG5pG8FscpBHqk0Xf2PzXmLusl
         4vhQdPpXH4sqkvyVv8gNbPI8PsBbV2LcekIZuWle1h801LepheAhIuQh24UholgDh3Sj
         tWme2ovqKYCoN7NGlIBrLww2mWEF+3xACCaSW2h8s+dUE0dNUmYFzapwLWJxdDyi+8/g
         4fxM4qCvHk4U5PUBALzrHRHtb40kEhgjFFWs8/3IIPoy0247StSZZlmF6VlHe3gHFffH
         fl4NeDXFOqbovkG/hnZaUrX2JAiXvlFMQG7g7IcYHm2voXLYUVaX1ciKhZBDX3A+lf7Q
         ONlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DJvZra+h35SUC9rjQ2onRE+RGu5O5vzHKncjxoF/ZlE=;
        fh=hqPUdSkFaPLeuhPdomw2XoNMtAcumK7PuHsfM0tI7aQ=;
        b=UDlfQW22tSjo0wD1QynLZh8eblkVZmI3gbLgjEVF8RFxzqjmclp5ANO0tRp1vqiFGt
         dYNZboe9MU+UpAnkYJUiTlbRaLkuAltV7RE5cNRUuspagUqQQfF2pu27w9KXiHID2KRW
         yAjOgwUrJqkiL6jT2do72aRlYTUUWGWf+KzmvrrAR6/S4xcnYAiXgiQk7cB1uKbBWZB8
         fHDMKDYS174+FioLO+y+9IyUCZbXHyu+P0f/kPVFolQygYE0Ks7/KWqY32kbYFMGbs9k
         S+DzkvqRlPBcXLmc/rVnOh4WnZre1fTUC3KV8U+jPdBmquMOTdcW1sStYKbMJU9imEQ9
         mdHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780557367; x=1781162167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJvZra+h35SUC9rjQ2onRE+RGu5O5vzHKncjxoF/ZlE=;
        b=oWofECrrGQunXjuJTs7TLX3kzRRe6yBLiUvRKLOwZfmhJxGyjwCMYigzl3JWl45mCW
         CxhHIqNKZ9sBXXj0zU/h2UNbWn30hgFojqvaUlUE7TyoRRy82NIzJbqBCIlsGYRmxZqd
         Mw8qmWHEN5VYauxb0zg/0AqUUmLV/zvGFCoLlmf74K1k8RRwArGgxtgayguGtpnR0ZbS
         3PcdA/hmJ9KBmvM4XJccrCdxYDnZHWjaU4cQ8/6NZvIz8+6G/JrcEjNnU7bunsCm4MKv
         +OnQMQ++01TYuRqJrUZvBwf9HEimUh1CxBjulHAQNkynnljXjWYK9ZYjTOwJdBPLcbFM
         0k+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780557367; x=1781162167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DJvZra+h35SUC9rjQ2onRE+RGu5O5vzHKncjxoF/ZlE=;
        b=kMQj3odkYWw7li5B20KQLqZrJ3CvZmyqS9ePVz1ZJUEZ0gGM2XpOUmuwOFEEJyJCvV
         E3RQQB5BQZwE1AITkLH0RPjxFsiFns5Jeq4/NYEy6/TxxfNiMOdBpJ5QBpq9HF5K40rx
         ozsEXd2kOT//0V4RdWIzdAIx/JCUhy6dgr6SM4A7cLDLZ7se0zFvDLq7907L+ngUToV6
         riYiVzk8J/U1wjoMnh/G6FnlcGAD0UEd/42m0wS6+b4Xn8gejLhA/iYB5jlmHFmKw+CB
         U6rwVitHdjLyI7JgRUp65ks2UJbxKIwBdq7ZxJjGhimAJ/SHiGP1zc1gmkmCdAayDMWt
         o3yQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dg0ZWOa6V8EldfX/YMU5/Noe/Fkf2BSgTteblnL5ORrOGXGjklcGowyd7/3//fULhf5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxz58a6dkikd1HmZnJHAW6GrB2i49POGBAzvTC95+sw7b4MTDO
	ZFxW0qtwoZj4dExK/KcI4I0pYzqx8OjB9fyCCSfRmUySyIMb+fLJzV/Tv++AVmmaQBYpf686dUj
	s+yX7vHhMT5jIwdadSc5z5+w3PdsDg380505CoYQ=
X-Gm-Gg: Acq92OF56xwjOBhiJAPYPJHj1xHU+8bTMIVS6x/+lMSipNHbZQYQXezUVXwapXd4Elo
	Ze+/z+qopYudKFLZq8y21IbqxwOmTkkTPEaipqIPtG7qAeWvTpmy5lXxRSizgjn/9HZiTCOQ9sv
	wpskyraJWsPCmA8aBmJCCckb5zfp6w9+VVANedjy3DMnJHDiIXeTQd3IwWT19HiXXRDKBDYKYHp
	efqLCufUxIYBvwdzN7oTFMujrwMd+5ATXDTvfhcqJOeudFM5FikZo36Sd6bfFJ4yZTMAs6tjTlO
	qt4VLhtYv4x2dSDsiA==
X-Received: by 2002:a17:907:2807:b0:bed:83ee:922a with SMTP id
 a640c23a62f3a-bf0a89335abmr230609266b.16.1780557366716; Thu, 04 Jun 2026
 00:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2314.git.git.1780269406949.gitgitgadget@gmail.com>
 <xmqqik7zqh4p.fsf@gitster.g> <CAHwyqnV6uh_yyO9FcUiXKfKPt15ojR3GOmRC06pW55f=KRu=Zw@mail.gmail.com>
In-Reply-To: <CAHwyqnV6uh_yyO9FcUiXKfKPt15ojR3GOmRC06pW55f=KRu=Zw@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 4 Jun 2026 09:15:29 +0200
X-Gm-Features: AVHnY4JrFPJSx73wpi0e7ui-IIwJva9z9vs4CwyGntgvVm5V3YgAtiVUIbhwtl4
Message-ID: <CAHwyqnXScbCONOGcP1RY3Ho7t7Y3smOfOMOOVf7eNsrQRnSLJw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: drop duplicate %.a from link recipes
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maybe we can do this to get around the brittleness for all ~10 places:

```
-LIBS =3D $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
+LIBS =3D $(filter %.a,$^) $(filter-out $(filter %.a,$^),$(filter-out
%.o,$(GITLIBS)) $(EXTLIBS))

 BASIC_CFLAGS +=3D $(COMPAT_CFLAGS)
 LIB_OBJS +=3D $(COMPAT_OBJS)
@@ -3392,7 +3395,7 @@ perf: all
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
$(UNIT_TEST_DIR)/test-lib.o

 t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
- $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter
%.o,$^) $(filter %.a,$^) $(LIBS)
+ $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(=
LIBS)

 check-sha1:: t/helper/test-tool$X
  t/helper/test-sha1.sh
@@ -4015,13 +4018,13 @@ fuzz-all: $(FUZZ_PROGRAMS)
 $(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
  $(QUIET_LINK)$(FUZZ_CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
  -Wl,--allow-multiple-definition \
- $(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
+ $(filter %.o,$^) $(LIBS) $(LIB_FUZZING_ENGINE)

 $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o
$(UNIT_TEST_OBJS) \
  $(GITLIBS) GIT-LDFLAGS
  $(call mkdir_p_parent_template)
  $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
- $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
+ $(filter %.o,$^) $(LIBS)

 GIT-TEST-SUITES: FORCE
  @FLAGS=3D'$(CLAR_TEST_SUITES)'; \
```


Harald

On Thu, Jun 4, 2026 at 9:06=E2=80=AFAM Harald Nordgren <haraldnordgren@gmai=
l.com> wrote:
>
> On Thu, Jun 4, 2026 at 2:33=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> >
> > "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > >  t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
> > > -     $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter =
%.o,$^) $(filter %.a,$^) $(LIBS)
> > > +     $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter =
%.o,$^) $(LIBS)
> >
> > I think the reason why the pattern to use only the .o files among
> > the prerequisites and then use only the .a files among the same
> > prerequisites (both filters $^) is used here is to make sure that the
> > linker sees object files first before library archives, so that by
> > the time its left-to-right scan sees the first library archive, all
> > the missing symbols in the object files are known.  The above change
> > depends on LIBS being a strict superset of all the library archive
> > files ($GITLIBS in the current code, but that can be updated in the
> > future) listed as prerequisites for the rule, but there is nothing to
> > guarantee that, so it looks brittle.
> >
> > Exact same comment applies to the other two rules touched by this patch=
.
>
> Hmm, there are other constructs like this that rely on $(LIBS) being a
> superset of the archives, so the three rules changed here align with
> the trend rather than introduce a new trend.
>
> Not saying we shouldn't find a way to handle the overall brittleness.
>
>
> Harald
