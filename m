Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A1DF68
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/KCMNqt"
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8447F1A5
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 00:54:55 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1eb39505ba4so1208313fac.0
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 00:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698393294; x=1698998094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZbdWJJ1MytqzeXjBGAJRD+LGygX//d+dndZzIz4o2Y=;
        b=T/KCMNqth+ugQzxdJmOZ5TvPrCxJLeXOQ8IgVoQ8W5jY93hd5V96PHxhZFf4Yk0WhN
         TF4uEozZtCAVJvF5w/60GSJsU7sOC/+UqFoWclsWjIOOPXgpafdqJGUWzqFpkhjiTnDB
         bp7fo5IzhnWMP7SvTtoqLCAoYiDCAnUaxPOnqYhTtSwGfwnozy9de7Cq18UUO0iJwjBh
         hRoOkpjY+U60ViQ1KpFA6s75U0dY3SlnbSXtSq/ahbMxfe9p42Km4SOwXy/xdCZGtgE9
         2Bw2yLI4jBQgxT/zyC5iNkLNZVICW+WlQ6He/WgP/FPDoHGePVMtuKeQizRNupgWu2a0
         2mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393294; x=1698998094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZbdWJJ1MytqzeXjBGAJRD+LGygX//d+dndZzIz4o2Y=;
        b=kSLj0mCwrh+AsD4LnQki1FqcCIq4wIhOeCEbRLLENLe9ECEU1NeZRpaL5q3uv2FKus
         8IApPQohW73Ri8ZzoYa/MGbSn/aS8qSwnyqHP4EbRoN0f8W8aPe4qv+CYfMm/cNJKN2q
         HEzJVXYTJ5e7CmfLF3SeklYfd3zf0ob408hBNnoGuws3cWLDJzZNO81tiII743V1uVPW
         gSUHJTKQihG3rt3ishUMcshwuAFhWXxdh+RscdlXUNt9PN32WTM9ICcNdqCGw6HJTlOQ
         emJTExK7H9Bq07l7e0h/Gc0SspI7gO3692KXWDZq7n64Ly4+bX1yjF3fLfP2c0W3b17l
         XmGQ==
X-Gm-Message-State: AOJu0YzzifmJvEQAV8khoU1FnE67ap2fx+gd/2wecVlDm/5gmQLAvrns
	Snvofy9orUwe8Dr2mC5WQDO1DN07BMvBypf/Dpg=
X-Google-Smtp-Source: AGHT+IFHbJI7jb0gOFaxd9CAtBGQjC57Nzp//SsDEvQ3HKUC+i6Ct56OzcN6x3aL1TnNEbAEwh/NaQjo5/zaPuagtpY=
X-Received: by 2002:a05:6870:9585:b0:1ea:746d:16f7 with SMTP id
 k5-20020a056870958500b001ea746d16f7mr2366551oao.6.1698393293989; Fri, 27 Oct
 2023 00:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024122631.158415-1-karthik.188@gmail.com>
 <20231026101109.43110-1-karthik.188@gmail.com> <20231026101109.43110-4-karthik.188@gmail.com>
 <ZTtXzg4NGJZzAqfS@tanuki>
In-Reply-To: <ZTtXzg4NGJZzAqfS@tanuki>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 27 Oct 2023 09:54:26 +0200
Message-ID: <CAOLa=ZRdfA9tgFtcR9aW+W2DAmJKA0QrUzBYGncCBJdFJns+qQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] rev-list: add commit object support in `--missing` option
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 8:25=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> We unconditionally clear the oidset now, so shouldn't we also
> unconditionally initialize it?
>

You're right. I should have added that in.

Junio, I'm replying to this email with the amended commit for v5. If
you want me to reroll
v6, I could do that too. Thanks!
