Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0602239E97
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 02:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770257231; cv=pass; b=T58rqbMlh0HYAoAk4hCbx/c5ef2m/l8a1EDWZfczyfSz/+CMRZYFpYmMNpgVsw/HKKaGuAAetlOOOPiZW33MNDcLliPT3Ih6Qr51NyWOpZuRuUrjIyo/WZtUjNfTOwpdFI2ZkxDo+W29HFe+IHNLB9hkiJH6yCw/UHlupULKLx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770257231; c=relaxed/simple;
	bh=/JmeNf2iqQ3aK5NqqnRejQOu8HRJ3aL/PMET2zgF7e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aasQSk7xGD78ghxWaAP4V3iBpdK9aS8x39c2zjwKjhe9/mn2wZWmknB7UReV3ckdQETtuSKzKxMBN0FAQRInmeBm55krGdgs3MRJ8KTS+WKDiMAzasgiQZUUb22+8FsLILRTZxCmNy0bbLOiKUu3eHRyha/mJ0bLO0owoKgM1sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHxBPTKV; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHxBPTKV"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-649e97f1e1eso314698d50.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 18:07:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770257230; cv=none;
        d=google.com; s=arc-20240605;
        b=VqaF4oyB0CcxHdbljS4aI0463TSt97sC280OhLPQI5qbx2hRhY6qGiMjirNm54oA4A
         V7VGqQR9iUp86mVOn8B1pCBi/0YDM3lo86gHKKHXn1dVUuDJGXWv7VMv2PbWIpjlKnJz
         NpzAhifviC6FBJVRtILlkzyfihyjBosSas4h46hiz66saFSy6hhFXgae3tRXm5RjvsRn
         Fe3TJIST6KbtqkIfvq7WJEXJ+S0wIAc2YbulV6B745aAwhLaQmuELfgu3ndFU4qV8A9x
         Av4+SOz42OhaO9HxwkKWcgE2+DsATFovPuhFWX/U8qj4WGP6xOm1t74dox7Ad7p9jb93
         cXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/JmeNf2iqQ3aK5NqqnRejQOu8HRJ3aL/PMET2zgF7e8=;
        fh=Cc05iPPyGnFU+E2UW152Hd8hiWSctrbEX3dT+AGE6Gk=;
        b=lB3pjm6sLbNcHne+K1oXwe7qWol8uKbxDJTHO7ZmnF/pWdwfyAnLrwhdoFEnNOPkh0
         xgH2Oa+OUbCr2KNoKG2ghFQFBcSQMnBpUIml50BVwLyiy6GHTa/1Gps/Ns75UndNwwaf
         3QqReGH0hbWRtcN9xeDGopq65sj6anz7ul+aQXrLhXMKWHt1YY30WdWZTDryI9CpvzYs
         CksocdXHpW4zTeFNW2QDOQKD17QjfS1j3W4ZHIVWyBcJ9PK46JnBX2ejR+QbVlfxfKtC
         S7MzLi5g7i0AKhvqA/fUmAMKQv6dzMQBOVEkwlnTVgYAyLsxqWTkk2w04OaCGgWr+Sb7
         nHsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770257230; x=1770862030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JmeNf2iqQ3aK5NqqnRejQOu8HRJ3aL/PMET2zgF7e8=;
        b=BHxBPTKVqOEk+0RMT5svm7KMz7ZKyubSB0ImuXg4N4hbyZqMjtr4Ox+Qr57vKC2+3m
         12DRST5oOn4pCNWrTBeRHoLTgNhp7KZjSXmSRKL7kyEFspfZx8SOM0ba4UdGr8tRcXDP
         /94vaFspRBKFAjvvH9zg4lq9YJYZ32qT3Iorh2r7ojQH+8KZviZm9dVL7xNnBl76+8CM
         j0Y+7INknf0QEcHOloBwzBpy6qKtqIq1cuucE6NNfqPVECdeo2uDWstZY0PTdDUy8ERw
         NtKmDc0Hkq0GQBYyny2CQHWf3xutSGT9u52meoz6WV9POUrogPwC3qVQz5U+mAF1aK/x
         mPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770257230; x=1770862030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/JmeNf2iqQ3aK5NqqnRejQOu8HRJ3aL/PMET2zgF7e8=;
        b=jTHIeeA4KnT3MojklrCmdTlUTJ2lQE70QjTwxzpkqRzX3y5eGpXm0LUECaPC6iOoVT
         h2BRm/kBYvm+KhemUDodaCXoeZAXGtOR+nLy6B97Fl0oGmQ56dUl8rQiePwQPamLRe5C
         x13hMKfK3xfuycT60wn65IR+Qv3ah9OxEkVF9Vn3HZeUnGfExm6hVdv6kU7hi8fIE7sJ
         MdX4N2yk6fI12uHyMfvWW3vHOKRuOMq1JoUjhESbpiu/BlTMOQZf0yVVv9wJnMMpsXTt
         fQpqmXxES57301Gojp1KwOvnNz34TgLcItEMyQN6Zc+T5UnglJemEBg9DNwbs6jqTXaz
         luzw==
X-Forwarded-Encrypted: i=1; AJvYcCVM8BOYAA5DAXwRMJNDOw+j8cqhepAdoscg2aRm3RcWK5K1OE9GVtt3+Sko4+WZS1Im4Io=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4WyXFDEHnSZgfBne54ytHGrDyUEzkiz4fZ/oBwPusL6boFRv/
	TtBTUajvc8MtEyLsf4DHZn3SbghfmsrL5Zn6c40lPyCpWzH5x0iFsDYC3Ot5AMCAJyBuuFFQn7C
	oX9bQQiw32MwlfiCCNi61WiyiyoesdEs=
X-Gm-Gg: AZuq6aJXZt5fwfgvyXdGoB0P0D+mjDKYMYzVScczWk8iqz6ZpS+dTfWyFKZRh3tP7uS
	Uy+ghhEYCLITA0LOWLdRprOUYuaFqxCJlxC28eZ36HSO9xiqkLuZkpzuCwOASUBYhoejzWMaD1f
	erJYmMVZMmfdlXrToBAEvJ5j6ww0GNCERJN4GWlfA7sCTTY2XkXEJosApqHxY3p9WELMOxr3nCX
	eOBuhjAGOYcBiNkzRTSMEsJwA9vD4aJq+MH6lk0wz27Qwd8qH07Q5IESBw/QoeW4Wfkg78ygNZo
	7ERsKkbsDQgGSuvkxOJjjdqkWk+mG7t5ZQz1H+LXk2V0+6tNH7GrJrKps+DYTWZKMmrOLU4fK+6
	9oxKlxw==
X-Received: by 2002:a53:c0cc:0:b0:644:4eec:222 with SMTP id
 956f58d0204a3-649db4c12b8mr3093266d50.85.1770257229706; Wed, 04 Feb 2026
 18:07:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
 <534b9313b19a73bcee6e0ac1d7299e19@softwolves.pp.se> <aYNC5dlL8wdwdFuy@kitsune.suse.cz>
In-Reply-To: <aYNC5dlL8wdwdFuy@kitsune.suse.cz>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Thu, 5 Feb 2026 10:06:58 +0800
X-Gm-Features: AZwV_Qgu9SgSJIrDqoeQqWuG_cwmAUZcdis1jMNk2MfcCHskhO7QNobJerHhc-0
Message-ID: <CANYiYbF295W88XUXqeiO9SXjDTMbJo9h8=mNk3xNALPHTXwvsQ@mail.gmail.com>
Subject: Re: [RFC] Introducing AI Agents to Git Localization
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Peter Krefting <peter@softwolves.pp.se>, Alexander Shopov <ash@kambanaria.org>, 
	Mikel Forcada <mikel.forcada@gmail.com>, Ralf Thielow <ralf.thielow@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, Emir SARI <bitigchi@me.com>, 
	Arkadii Yakovets <ark@cho.red>, =?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>, 
	Jordi Mas <jmas@softcatala.org>, =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>, 
	Phillip Szelat <phillip.szelat@gmail.com>, =?UTF-8?Q?S=C3=A9bastien_Helleu?= <flashcode@flashtux.org>, 
	insolor <insolor@gmail.com>, Kateryna Golovanova <kate@kgthreads.com>, 
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>, 
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.com>, 
	Ray Chen <oldsharp@gmail.com>, =?UTF-8?B?5L6d5LqR?= <lilydjwg@gmail.com>, 
	Fangyi Zhou <me@fangyi.io>, Franklin Weng <franklin@goodhorse.idv.tw>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 9:00=E2=80=AFPM Michal Such=C3=A1nek <msuchanek@suse=
.de> wrote:
>
> On Wed, Feb 04, 2026 at 12:58:05PM +0100, Peter Krefting wrote:
> > 2026-02-04 10:31 skrev Jiang Xin:
> >
> > > Please try using AI coding tools to update translations in po/XX.po o=
r
> > > review historical translations, following the prompts below:
> >
> > No.
> >
> > Please disable this altogether for the Swedish localization. "Translati=
on"
> > using stochastic parrots is not mature and just creates gibberish that =
takes
> > more time to clean up than to do the translation from scratch manually.
>
> Hello,
>
> a similar attempt was widely reported, eg. here:
> https://linuxiac.com/ai-controversy-forces-end-of-mozilla-japanese-sumo-c=
ommunity/
>
> As pointed out the availiability of the tools is not necessarily a
> problem in itself. The problem in that particular case was that Mozilla
> automatically applied the tools to existing translations, even
> well-maintained ones.

Thank you for the context=E2=80=94this is a good reminder that automation
should never override community judgment.

To be clear, using AI as a translation aid is entirely up to each
contributor. In Git 2.53=E2=80=99s l10n cycle, I temporarily handled the
Chinese translation (as the usual lead was unavailable), translated
all new strings, and fixed many issues in older translations=E2=80=94both
speed and quality were surprisingly good.

As an l10n coordinator, I=E2=80=99ve long struggled with reviewing PRs: whi=
le
git-po-helper catches technical errors, it can=E2=80=99t assess translation
quality or detect irrelevant content like ads or political text. Here,
AI can help flag such issues during review.

That=E2=80=99s why we updated po/README.md and invited teams to try these
tools=E2=80=94not to impose automation, but to explore how AI can assist hu=
man
reviewers, language by language.

> Abandoned or completely missing translations may benefit from AI
> translation when the topic is general enough that there is likely a lot
> of training data available. Unfortunately, git with its specific jargon
> may not be the most optimal project for automated translation.

For Git=E2=80=99s Simplified Chinese localization, we follow a simple
practice: a glossary is included in the header of `po/zh_CN.po`, and
all contributors=E2=80=94whether human or AI=E2=80=94are expected to adhere=
 to it.
