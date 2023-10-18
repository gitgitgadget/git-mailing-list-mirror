Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFAB1A582
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+w9th3S"
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E1495
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 06:27:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso1178826566b.2
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697635649; x=1698240449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLGNHMSnR4smyx+1ZEx1NJs6c6R8pYWgs/lsgHMcwZg=;
        b=S+w9th3SvZelJkUBQbY6dYJE1bqi/5lhbKdH9CTEa2fhkKsQsLpmweLncSIj6lUlYe
         k2LJIjpYaXayYiKU+w7WDCET7wMAsXSBKL8DyecXADzpztQpsTJ2lh04KNxR/pzL4Abc
         eNA6nqy8WjOEK2PMi4o5E4pHUcUUrNc9uSbEF1Mr4+4+AN/k2fg9dLTvJMKVu5i7GVMy
         ti64KBSxnHxex72v+x4ozW3Zha8IS3GpjLrNTYCtdWDqapeyw7XF3VkYyJZJryfzaL2t
         IbM+Sh8AxrOLm4IorGzdZMNOHYbBSOEB+OERDhdZ7vMfa9hbYRQ+jI9kl72AhxcYpynU
         5L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697635649; x=1698240449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLGNHMSnR4smyx+1ZEx1NJs6c6R8pYWgs/lsgHMcwZg=;
        b=c+hN/YWb+yoX7s0QBnuzGJrWqH69PqeExZiqLUPBZgMgKqeGUmheOvHacKRrquh+ZK
         s+WC327dgSHWicm9dDmIMmZfx8wJIHOzBl+cXwPPYt3NCXHklFINtJl80msLyMNp5uVd
         94WQsgwfrcrHbJ5SJQwLf3f/x1xkwhgffGN/rfD7IodtoXJ6GBjuDgYiAqJNXD0KFB7u
         0a0MVfxJa908OEN+Ka3WXvaxEfTHWQL8OjRTrut0DaRh4d56KrXPors+b0nitmwdT0Lw
         S3VPR8gMLZW+alT9n/LMXtZ4IVjlcv87j6uCXEPL+1COrsRDd4Z7g5f6ORm8WTDxAwZa
         6mfA==
X-Gm-Message-State: AOJu0Yw6+yUzuYQF+W0j97fillLH11n6l7IFDZojrIRDNQDW4CYaBjAI
	SdBBFUmmUhEtDjiJ/hC1wTNr3QYfRwR8QEp4dZCaNPBtbzdg2rD7vs+GbA==
X-Google-Smtp-Source: AGHT+IFInNRQhUa7LuSEJGCGqsu2bJFFMBDgAUh9n+/KBuWIvmwQ3YmBAaevQtfA0b5vJbAI7oWdmuMZUG/mXxcZ/Mc=
X-Received: by 2002:a17:907:a08a:b0:9ae:701a:6efa with SMTP id
 hu10-20020a170907a08a00b009ae701a6efamr3816188ejc.69.1697635648616; Wed, 18
 Oct 2023 06:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697607222.git.ps@pks.im> <c4d09e3e5dbd11221cc4d229b815434d441cdb4d.1697607222.git.ps@pks.im>
In-Reply-To: <c4d09e3e5dbd11221cc4d229b815434d441cdb4d.1697607222.git.ps@pks.im>
From: Han-Wen Nienhuys <hanwen@google.com>
Date: Wed, 18 Oct 2023 15:27:11 +0200
Message-ID: <CAFQ2z_MiOazk8qLvEn5xfHyMwY=5pa6rEJD3vC3+rnHz4AeQ2Q@mail.gmail.com>
Subject: Re: [PATCH 08/11] t4207: delete replace references via git-update-ref(1)
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 7:35=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> In t4207 we set up a set of replace objects via git-replace(1). Because
> these references should not be impacting subsequent tests we also set up
> some cleanup logic that deletes the replacement references via a call to
> `rm -rf`. This reaches into the internal implementation details of the
> reference backend and will thus break when we grow an alternative refdb
> implementation.
>
> Refactor the tests to delete the replacement refs via Git commands so
> that we become independent of the actual refdb that's in use. As we
> don't have a nice way to delete all replacements or all references in a
> certain namespace, we opt for a combination of git-for-each-ref(1) and
> git-update-ref(1)'s `--stdin` mode.

There is a test helper that can directly access the ref database,
t/helper/test-ref-store.c.

If you use that manipulate refs for testing purposes, you make the
test independent of behavior
git-for-each-ref/git-update-ref, which is what you want for testing
replace-objects?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
