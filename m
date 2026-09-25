Received: from mail-ej2-f15.google.com (mail-ej2-f15.google.com [74.125.228.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC7A483BD9
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328364; cv=none; b=b1xTM+Lao1dkve+ExdugvYgiqvRT/63nsL3WSfL4BjE6E6mWowDngdF0HiItXZDSEvbZ3wHVrKCNR6IedJmbP8TKWrULMz7kqPyl0vN5YdPftiaYnTP6zCYHrqT8WJbEd5Pn64JkUZ/fj8ttYbebDXaATvijgOOGpsDz4+4iWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328364; c=relaxed/simple;
	bh=/xbcRE0NuM8Pn8vXRw+Ajz7h1QkSi19jEb8LBPmvWPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQEQwaJvWpbMsNLLIzB6UbfZdN2gJBHFbah4XX1MS6HpVIbYbPNF8X8YXtbahm7Oyv5+NPK9nNy3/IZzWjTFaAMAXiCmyHhak9bHP0BCYURiIqd0sLRhGS/zTACWrf8NRm/FSYelckXts0M9r0n/Ti7pOyjvuAvI8QSN56HTdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qCUQf/qk; arc=none smtp.client-ip=74.125.228.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCUQf/qk"
Received: by mail-ej2-f15.google.com with SMTP id a640c23a62f3a-c254f9f7dbfso76490466b.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 02:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790328359; x=1790933159; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t1Vyc26+/iHTw9UXj7DgeDdlKt7fiJIiQBqPj6rffHk=;
        b=qCUQf/qkFiXfelszi4Ta8SS33Y3eF04MS/GbVvII0QQJW3XaolbZ33oteQtXmZlNtl
         ljB6yqUibwGB0fidhGQHacR+tP5pZY7mdFWMnkzFhiptPEiQ5uCGGQx91hVJfg0nQli7
         cyE52ffu5Yl4Ok4WAer3WqHYjszEGSBgVJlv9RRj6NnKrX1DPlvo6pWafCZcE/gCthm7
         UEPLcFdwoLfdhISX5THcd74fMfQ9xVOp8EqNUozwoHDpUjWtIwNjYfpt/qmpHbokM6iu
         OnvthBGlzUMzqyzg1ItQAYYS+KSwsol4w/7WQyGOD5y7wZtKw885/B737Kq1Q+WqIP2A
         RbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790328359; x=1790933159;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t1Vyc26+/iHTw9UXj7DgeDdlKt7fiJIiQBqPj6rffHk=;
        b=xqNTfF+Xho1CuUy7PQohjPIvm9eTzm9Bc4+JaHU5v7F/9oHaocrY1HhVWkvCd9kloi
         t1Jv8ZjrJcdeukwLfJedR0ZylcCmt1U8gZLXNgShBOErZIltMpIw10DzuRq/AdGGnX7k
         p+g4RIBpJWdkX8wSTt8lNvOn3bUDRy0zP/TgE+q3orK/MLNCT9z67M0Bft1yrAKBqrbN
         CGjzLSTmGylSt4fnVTlA20RltKtWXHNhpAM7LautIMWiGPrLG1YWUdAsrnHSXz3/TJrf
         6Fw0ToBXkyY33Y0dFncnees1BCeEmf9AY2VwksITDhkxD+zljZE0Eav2A7UR9VPH0w50
         5hpA==
X-Gm-Message-State: AFuF++lw0RypifjnjWr/gpLPBhH73jKKnZRC6+q52eNBASglFNX/lC86
	1OKsXFJiuBr9RYlO75CWKNJW1Ta+L4QB9b68KFq88pmFMrtlrYZHnYBGSj4sqA==
X-Gm-Gg: AYBFou0kn8sfCCQ4uS2zhyIwF5YKFANG/Q7IZk72lVboWrWzIlYcXx4IRY2DI7eSbM0
	18jje6G0Y18yKAdfhPXHbWK2c+EbS8oDLtmBViWBNKa+YLkatBfdZROUMYZoAzRxB7Wfc0R1Bxo
	n+FcSEXbQ1itQMvHB/RHKrTZre2PpLcUKkcyW2fApeCwpFIgHHdQnUldKO7/Zjug1SsIcDXg1sO
	kD1X5HtxR2XDfaRmPYZFyThmEgYkXYk5cXv5p8vnIPWDeGsrIlMr2Bv5NDqr05zQLd26M1AVBg2
	1YYkbDY1aM7sEyz/MJci4JpALRl64j5HiDCIAr6T8MImr6fyXrA+yySaHsGELAXS37QqLs0p31c
	K9XhoX9GyI2wtLCImq1m3tzB858j9YFEQuY6ZFPJLmZ7jqaxRxfsQNs92+TIaFeIGW5tegWv/nD
	b7MQraBUfVpNqn17ZMVVSijpiVGd8H9hi0gXekSqnyUGHzJG6MFX6WYxBvAD3onDCvgPg1FBhvZ
	yArHxvhtgWSPTYOuWtwhiSSlmVddcXGT3Q=
X-Received: by 2002:a17:907:72d0:b0:c25:1a5:62a4 with SMTP id a640c23a62f3a-c2ac24743bemr441298166b.17.1790328358554;
        Fri, 25 Sep 2026 02:25:58 -0700 (PDT)
Received: from localhost (78-131-17-47.pool.digikabel.hu. [78.131.17.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757b9c1sm86696266b.33.2026.09.25.02.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 02:25:58 -0700 (PDT)
Date: Fri, 25 Sep 2026 11:25:56 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] Makefile: precompile "git-compat-util.h"
Message-ID: <arY+JMPe0KWucyja@szeder.dev>
References: <20260909195006.2179119-1-szeder.dev@gmail.com>
 <20260915060952.569535-1-szeder.dev@gmail.com>
 <20260915060952.569535-5-szeder.dev@gmail.com>
 <20260924235216.GA837070@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924235216.GA837070@coredump.intra.peff.net>

On Thu, Sep 24, 2026 at 07:52:16PM -0400, Jeff King wrote:
> On Tue, Sep 15, 2026 at 08:09:52AM +0200, SZEDER Gábor wrote:
> 
> > This patch follows the idea of 671df48df8 (meson: precompile
> > "git-compat-util.h", 2026-03-19) to make it faster to build Git using
> > "make".  The notable differences are the boilerplate needed to wire up
> > the precompiled header with "make", and the selection of object files
> > that are built using the precompiled header:
> 
> I got an interesting error message from this today:
> 
>   $ make imap-send.o
>       * new build flags
>       CC tools/precompiled.h.gch
>       CC imap-send.o
>   cc1: warning: ./tools/precompiled.h.gch: not used because ‘NO_OPENSSL’ is defined [-Winvalid-pch]
> 
> You won't see it with:
> 
>   make NO_OPENSSL=1 imap-send.o
> 
> The culprit is that I have this in my config.mak:
> 
>   imap-send.o: EXTRA_CPPFLAGS += -DNO_OPENSSL
> 
> so the build options for the precompiled header and imap-send.c are not
> the same.

Hrm.  I've run into this with 'make git.o' and the other object files
for which we set EXTRA_CPPFLAGS in our Makefile, and wrote about it at
length in the commit message.  I thought omitting EXTRA_CPPFLAGS from
the command building the precompiled header solved this issue, and was
puzzled at first why your use case still causes problems...  The
reason for the difference is that none of the EXTRA_CPPFLAGS we set in
our Makefile affect 'git-compat-util.h', but -DNO_OPENSSL does.

If you set such a custom EXTRA_CPPFLAGS, then you might as well append
'-Wno-invalid-pch' to it to silence that warning.  The rule building
object files using the precompiled header has '-Winvalid-pch' near the
beginning while EXTRA_CPPFLAGS are near the end, so we can override it
from EXTRA_CPPFLAGS.  I didn't find a way to override '-include
precompiled.h'.

(Btw, can you do something like this with Meson? :) Without resorting
to creating yet another static library, of course.)

> So now of course you are asking why I would have such a weird
> line in my config.mak.
> 
> The answer is that I want to disable openssl for old builds, because I
> am often building historical versions which use openssl constructs that
> are deprecated or removed.

Well, for the same reason I have the following in my config.mak:

  # Build knobs to build older versions:
  # 1ed2c7b115 (imap-send: use HMAC() function provided by OpenSSL, 2016-04-09)
  ifeq ($(shell git merge-base --is-ancestor 1ed2c7b11570f5d16bdc70d151fa78c3dccf6d38 HEAD 2>/dev/null; echo $$?),1)
    $(warning Setting NO_OPENSSL for old revisions)
    NO_OPENSSL = UnfortunatelyYes
  endif

> So naturally you are now asking why it does
> not just say:
> 
>   NO_OPENSSL = BrokenOnOldVersions
> 
> or similar. But that breaks _some_ old versions which really do need
> openssl for various things.

I haven't run into any such breakages with disabling OPENSSL for the
whole build... but maybe I just haven't built old enough versions?!
Anyway, will adapt it to your EXTRA_CPPFLAGS trick, thanks.

> The good-ish news is that it's mostly cosmetic for me. I also loosen
> -Werror for old builds, for obvious reasons. So it's not breaking any
> build.
> 
> I don't know if my use case is too crazy to care about

I would say so, yes ;)

> but I thought
> I'd mention it in case there are other less-crazy related cases we might
> run into.

Not sure what those less crazy use cases might be, but I'm inclined to
say that "If you deliberately set a custom EXTRA_CPPFLAGS that affects
'git-compat-util.h', then you should also add '-Wno-invalid-pch' as
well".

> And yes, obviously old versions will not have the precompiled header,
> either, but my logic for "loosen compilation" is mostly "we are not on a
> branch nor rebasing", so a sight-seeing trip to "git checkout
> origin/seen" puts me in the same mode. And eventually it _will_ be old,
> too. ;)

I'm not sure about loosening compilation for 'seen', especially when
it comes to DEVELOPER=1, because it's best to catch any issues with
DEVELOPER=1 while the commit is still only in 'seen'.  My config.mak
doesn't set DEVELOPER=1 when bisecting or when building a revision
reachable from a tagged release.


