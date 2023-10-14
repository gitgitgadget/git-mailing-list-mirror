Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CAEEA0
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai6ySclp"
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BEFC9
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 10:22:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53e3e7e478bso2731196a12.0
        for <git@vger.kernel.org>; Sat, 14 Oct 2023 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697304170; x=1697908970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP4z3mhe0V3tfPKYqaSIri46jpPv62fACeSBgMMrpUk=;
        b=Ai6ySclp9dMdxMc2F8xJXeYGRj3UCq19PMotb6nptd3GowavYyAOTiWeGi+lot2bW1
         rjtirODUK8NFjiPiuWrCL5D2v5HxuTpaZNr6R+XzE7z4ocRN5MQPMNoHPuHLSlVWkeSx
         /QJ9BY7+v8ZPgKgiH/bT1hlr+5sB5CoHnQalBo3kzP1nuqoBUytDR2ZW3O543JeDmb1Q
         7rVYoaAGjFtpClP0hOO9IWKWyiIsT6JHjniJKYZXRCNfCfaq3hjm8DWKad/grhc7ZbiM
         Eb9VltmAgN84m57vhPX59QCnW+HZZBa/Yp3rrlNxz7VYKNR4rnnmJATstbX2rRbIA+2g
         qFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697304170; x=1697908970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP4z3mhe0V3tfPKYqaSIri46jpPv62fACeSBgMMrpUk=;
        b=tJ3Cnm+vj2Ra3wneDm3vRkG4CuzvZN/3q9keCrPH0LvhNCLn0ZNmjjiYKufT+uASjJ
         uTB1QSSZFV6YLUAdWs3Hh/Oik1y7qBIqvEKeUk8svBXSV4VGWY7DWJEUFl00Gfx956ha
         9u72dLVt/B/hvGp9dSlLnkmAfavaVfZFF1tNDXkb7s5Ja6a4N555A0egcSt4I0Lx+Zw7
         LT5ixBflXwp4m11qZewSvQIUiiH5oQrELst/eX74SZmQ5EAYqtv0b+DkWw4iOjyS0N5O
         ow/7Hl3gNloYlzyliqp9jARReNaJmrD5vBIqrAqLL3IKz4XCk8nTI1h0e5LYOOniM7Bx
         y1jg==
X-Gm-Message-State: AOJu0YzpW7C1qzvOeCKE8ICyNbAnQ5CpLJhbsNvZHQYAYsZ36fZhKzuv
	bwvU2DcrSpE2kOcOblkQI11b6EcXk0iFe6V1jxwEQirRc7LODA==
X-Google-Smtp-Source: AGHT+IGOyHh1u6SrNHvtiWwrPVMxGi3O/PzdxuUTx8/eBTOdbEKJFRG0FSea8XW9mZ/J0chVlVdGAYyVgOr8rcUJIrw=
X-Received: by 2002:a50:d653:0:b0:53e:1a75:8492 with SMTP id
 c19-20020a50d653000000b0053e1a758492mr6121088edj.34.1697304170623; Sat, 14
 Oct 2023 10:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKFQ_Q9WjF9i-Rx2jdCw-adPVQrWNfNKrDY-em8Rpa5RNLXz4A@mail.gmail.com>
In-Reply-To: <CAKFQ_Q9WjF9i-Rx2jdCw-adPVQrWNfNKrDY-em8Rpa5RNLXz4A@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 14 Oct 2023 19:22:38 +0200
Message-ID: <CAP8UFD3z5xKfvao2Q87tK7y5P+2LSKW_Hv-dBvFb=J3gm7-Arg@mail.gmail.com>
Subject: Re: Bug: git diagnose crashes with Segmentation fault outside of git repository
To: ks1322 ks1322 <ks1322@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 2:00=E2=80=AFPM ks1322 ks1322 <ks1322@gmail.com> wr=
ote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> Run `git diagnose` outside of any git repository
>
> What did you expect to happen? (Expected behavior)
> No crash, reasonable diagnose output
>
> What happened instead? (Actual behavior)
> `git diagnose` crashed with Segmentation fault
>
> $ git diagnose
> Collecting diagnostic info
>
> git version 2.41.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> Repository root: (null)
> Available space on '/tmp': 7.75 GiB (mount flags 0x6)
> Segmentation fault (core dumped)

Yeah, this is a valid bug report that I can reproduce. It looks like
such bugs have existed in this command since it was created last year.

Best,
Christian.
