Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279FA1CF9A
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkUegLpq"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e778e484dbso11298927b3.0
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 07:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702999995; x=1703604795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8xhfm+b0tavGU3AyrVIVtwdSt7YmfwxhOAyDI3SkbI=;
        b=jkUegLpq8y+ZR0vXTBYUHsJTTUM0qasjcLDiCUdtGdu8ThtDGBl2XrhzXISmnyoXPP
         QkXe5C/QwmsaTn+aeW3oWXvu+tpEBFttqIxacE/lhx2Kpw7B6ZliVC0reFLTdEc80Wbb
         TVlPABSwp0A+vllR2k3yYjV9PA9bAqHzQqGTKqarxfkH5/m0QpFfoKIMRvUvMqsdybHl
         R31BWNs29xV5WmLFm6kw35wluPZz2C6B8rS2KdKcSwIy+Tv5a9wy4tkYAw6S9DxOaO3n
         NLroeMHIzXUUz/Lq+Gh0wUR4OmY5xedDds91MIku234QGiqhREV2VKq9JT2S2kIG8sgs
         YthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702999995; x=1703604795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8xhfm+b0tavGU3AyrVIVtwdSt7YmfwxhOAyDI3SkbI=;
        b=rL+MxLA7L0iCWtav4GChRa+gmuJd+Fo5vhpht8vI1pX6876BbtjmK0t+1lgemd/H8h
         YrjNpu1f8MtNq5pBoclw4A33GaMK3YAf0lLzRN6Lwn+hNpPp1ZQK8OoL/v5hQorx2lIw
         7vswJeYBcmQy4WNtrfrlnylRMMJoPZErNx9ecGrLI/TFSZLjnQDzZZLJjtdRfbVV+MlP
         1zeedxuEVD60qB9BUDkUu2c5OaqTCYLLzrv/aGVwSQJiGjZyTbrpvcgPA2sg5IHDp7VI
         DoGPUmuMzuaT+Klk1ysRGMfX4sfA7fSw1LxumGhIe0GTiEesXr6NaphBvlV0gLMzMQlf
         lWIA==
X-Gm-Message-State: AOJu0Yxj9/W0iPjeWj5Q5ldf3aDUx7j43dWnTuVXps0r7cpsIGsIWN2b
	B/Q7hMXgVEaMpHF67e8U67ycs5nt7MJ4/gsSxTE=
X-Google-Smtp-Source: AGHT+IH1IJkiEbwLlXvlFo0252aosj9CKtmWyM2adFJzrGVV+H4XgPOhwQOCmajENqgtZxnzkijelefod6c3wVQ0Cb4=
X-Received: by 2002:a81:7c45:0:b0:5d9:50cc:b8ed with SMTP id
 x66-20020a817c45000000b005d950ccb8edmr13603588ywc.86.1702999995057; Tue, 19
 Dec 2023 07:33:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215203245.3622299-1-gitster@pobox.com> <20231215203245.3622299-2-gitster@pobox.com>
 <0c93d426-17c3-434c-bbd0-866c31c23f9d@ramsayjones.plus.com>
 <xmqq1qbnktnl.fsf@gitster.g> <xmqqttojjegr.fsf@gitster.g> <xmqqjzpfje33.fsf_-_@gitster.g>
 <ZX_9nRYKVq0jT0Lp@tanuki> <xmqq1qbjij0f.fsf@gitster.g>
In-Reply-To: <xmqq1qbjij0f.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Tue, 19 Dec 2023 23:33:03 +0800
Message-ID: <CANYiYbHFA+1R1JdN-o6TAJqDbh7iSmELjpc2kK8HkHJ7RQLgGA@mail.gmail.com>
Subject: Re: [PATCH] doc: format.notes specify a ref under refs/notes/ hierarchy
To: Junio C Hamano <gitster@pobox.com>, Teng Long <dyroneteng@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Peter Pan <pan93412@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 12:16=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
> > the translation changes with a big grain of salt though,
>
> Hopefully pinging Jiang would be sufficient to ask help from the
> French, Chinese, and Taiwaneese translation teams.

The l10n team has a command line tool called git-po-helper that can
check for spelling errors in translations, such as mismatched command
names, configuration variables. A new pattern will be added to find
mismatched reference prefixes, and the following typos will be fixed
during the next localization window.

> > diff --git a/po/fr.po b/po/fr.po
> > index ee2e610ef1..744550b056 100644
> > --- a/po/fr.po
> > +++ b/po/fr.po
> > @@ -19773,7 +19773,7 @@ msgid ""
> >  "Neither worked, so we gave up. You must fully qualify the ref."
> >  msgstr ""
> >  "La destination que vous avez fournie n'est pas un nom de r=C3=A9f=C3=
=A9rence compl=C3=A8te\n"
> > -"(c'est-=C3=A0-dire commen=C3=A7ant par \"ref/\"). Essai d'approximati=
on par :\n"
> > +"(c'est-=C3=A0-dire commen=C3=A7ant par \"refs/\"). Essai d'approximat=
ion par :\n"
> >  "\n"
> >  "- Recherche d'une r=C3=A9f=C3=A9rence qui correspond =C3=A0 '%s' sur =
le serveur distant.\n"
> >  "- V=C3=A9rification si la <source> en cours de pouss=C3=A9e ('%s')\n"
> > diff --git a/po/zh_CN.po b/po/zh_CN.po
> > index 86402725b2..eb47e8f9b7 100644
> > --- a/po/zh_CN.po
> > +++ b/po/zh_CN.po
> > @@ -13224,8 +13224,8 @@ msgid ""
> >  msgid_plural ""
> >  "Note: Some branches outside the refs/remotes/ hierarchy were not remo=
ved;\n"
> >  "to delete them, use:"
> > -msgstr[0] "=E6=B3=A8=E6=84=8F=EF=BC=9Aref/remotes =E5=B1=82=E7=BA=A7=
=E4=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E4=B8=AA=E5=88=86=E6=94=AF=E6=9C=AA=E8=
=A2=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=A0=E9=99=A4=E5=AE=83=EF=BC=
=8C=E4=BD=BF=E7=94=A8=EF=BC=9A"
> > -msgstr[1] "=E6=B3=A8=E6=84=8F=EF=BC=9Aref/remotes =E5=B1=82=E7=BA=A7=
=E4=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E4=BA=9B=E5=88=86=E6=94=AF=E6=9C=AA=E8=
=A2=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=A0=E9=99=A4=E5=AE=83=E4=BB=
=AC=EF=BC=8C=E4=BD=BF=E7=94=A8=EF=BC=9A"
> > +msgstr[0] "=E6=B3=A8=E6=84=8F=EF=BC=9Arefs/remotes =E5=B1=82=E7=BA=A7=
=E4=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E4=B8=AA=E5=88=86=E6=94=AF=E6=9C=AA=E8=
=A2=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=A0=E9=99=A4=E5=AE=83=EF=BC=
=8C=E4=BD=BF=E7=94=A8=EF=BC=9A"
> > +msgstr[1] "=E6=B3=A8=E6=84=8F=EF=BC=9Arefs/remotes =E5=B1=82=E7=BA=A7=
=E4=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E4=BA=9B=E5=88=86=E6=94=AF=E6=9C=AA=E8=
=A2=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=A0=E9=99=A4=E5=AE=83=E4=BB=
=AC=EF=BC=8C=E4=BD=BF=E7=94=A8=EF=BC=9A"
> >
> >  #: builtin/remote.c
> >  #, c-format
> > diff --git a/po/zh_TW.po b/po/zh_TW.po
> > index f777a0596f..b2a79cdd93 100644
> > --- a/po/zh_TW.po
> > +++ b/po/zh_TW.po
> > @@ -13109,7 +13109,7 @@ msgid ""
> >  msgid_plural ""
> >  "Note: Some branches outside the refs/remotes/ hierarchy were not remo=
ved;\n"
> >  "to delete them, use:"
> > -msgstr[0] "=E6=B3=A8=E6=84=8F=EF=BC=9Aref/remotes =E5=B1=A4=E7=B4=9A=
=E4=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E5=80=8B=E5=88=86=E6=94=AF=E6=9C=AA=E8=
=A2=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=AA=E9=99=A4=E5=AE=83=EF=BC=
=8C=E4=BD=BF=E7=94=A8=EF=BC=9A"
> > +msgstr[0] "=E6=B3=A8=E6=84=8F=EF=BC=9Arefs/remotes =E5=B1=A4=E7=B4=9A=
=E4=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E5=80=8B=E5=88=86=E6=94=AF=E6=9C=AA=E8=
=A2=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=AA=E9=99=A4=E5=AE=83=EF=BC=
=8C=E4=BD=BF=E7=94=A8=EF=BC=9A"
> >
> >  #: builtin/remote.c
> >  #, c-format
