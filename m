Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B62241EA
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg5BWm/H"
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DADD64
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 14:54:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so4242515a12.2
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699048475; x=1699653275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9ZDo2dFnLpR0as/NzJg53IX/hktsmg/ucnxrZy7kj0=;
        b=hg5BWm/H3lDerDpJdCRTMydjUp7JOm8qaNbl8Q1nJxcx6W7SfhByMJ4uzrLFx7jMcb
         z06QjdiNAWNLftnX6oykiWSJYdllic+bDIl2DHzV5O5q7x78/e8nL/mQnQ4e/WcI0t16
         PpOAfpahDR8teAC8TWvbjZDAy8uVIKJVaerXsgyxu4u0SgIUz+UkQOFCadFpLTqLCPfk
         phJDiiIykSyrWtqxGNEIMdbMfNfF9MdnI2PJkoNDAoHoAGiJHSbhoWgeJ2Z0S9JmjdQO
         hRgmLqa8LiqHZwrXBar+7Qh5STjY9DzkqTsas2vGSAzV6SRIIuf1ahKZpjXs3JbQ8yXa
         ggiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699048475; x=1699653275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9ZDo2dFnLpR0as/NzJg53IX/hktsmg/ucnxrZy7kj0=;
        b=eyiYI0cgmoRC28LOIfiw1jJ7edOpKGW0trjWvtWdG14jGZ+R3KcIBJS+9UR6+q1x8h
         HGl8moNbwU67M0GTsfCsFcWL8xGUCFnwZL7K1mjNggkOshZQv5BHW+e39Fqo7M42tYAL
         mzHOWnKSK4DhsDHeXMQ6RbFzb+tdA/gOEqsochgxjeojvmieF8iROnwHqLHJYriN4y8k
         aOCST5uQvV/qFgtZi7THts/LKZzcWMalUdHBOAuKJjrIHMyC3z4dSTjwBc2erLdSN/to
         BEL0lfl650Zg5W2UR+jcPbLtF+ZbztpWMh4xCBn/HlZS3XYB3e/wvtYmwhm2tsoVXvWJ
         GC7Q==
X-Gm-Message-State: AOJu0YyQHTDy/lUWqo6krGK2VNXkqqpF1lytwACP8LSw+fw88JJr9Az4
	6gRt/PdBV4Wgqq83y2robbaluiMMDY5gidE4Nauw37+cOJQ=
X-Google-Smtp-Source: AGHT+IGYe0fRDMBXKSE09PnUq364/W40UP0B3BELPCRqELymWFzb6pLIPQkrrwTSDTxzLVySv7m1O+M7hrr4WS6RtP0=
X-Received: by 2002:a50:d098:0:b0:540:164c:2be1 with SMTP id
 v24-20020a50d098000000b00540164c2be1mr19868399edd.0.1699048474900; Fri, 03
 Nov 2023 14:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1698881249.git.steadmon@google.com> <8b831f4937a167519b77c724fcbc36884bbfe43d.1698881249.git.steadmon@google.com>
In-Reply-To: <8b831f4937a167519b77c724fcbc36884bbfe43d.1698881249.git.steadmon@google.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 3 Nov 2023 22:54:22 +0100
Message-ID: <CAP8UFD3SVnu+HFQhFpsF4PA6pK5B5L+aP-jxRX=Ro3EYekS0kg@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] unit tests: add TAP unit test framework
To: Josh Steadmon <steadmon@google.com>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 12:31=E2=80=AFAM Josh Steadmon <steadmon@google.com>=
 wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>

> +int test_assert(const char *location, const char *check, int ok)
> +{
> +       assert(ctx.running);
> +
> +       if (ctx.result =3D=3D RESULT_SKIP) {
> +               test_msg("skipping check '%s' at %s", check, location);
> +               return 1;
> +       } else if (!ctx.todo) {

I suggested removing the "else" and moving the "if (!ctx.todo) {" to
its own line in the previous round and thought you agreed with that,
but maybe it fell through the cracks somehow.

Anyway I think this is a minor nit, and the series looks good to me.

> +               if (ok) {
> +                       test_pass();
> +               } else {
> +                       test_msg("check \"%s\" failed at %s", check, loca=
tion);
> +                       test_fail();
> +               }
> +       }
> +
> +       return !!ok;
> +}
