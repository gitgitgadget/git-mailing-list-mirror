Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BCE39FD9
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765896114; cv=none; b=e2vcCwy+LM7Lzx6JaJ4iHOtIMlvPO2YrT5PWFgTzUZzM94s4J+8X/e0L5MSvdDsG86gmKmbxs/GibIbu2mRMoYYamX30hePxQhRcezfjI7cz4PSKo4lZjPLlx4sthwFjeN7NlOGoTRK7IicXFcQyIGHqG/PXNxrEkZKscsB0C5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765896114; c=relaxed/simple;
	bh=k6x+H2cdmi63tQrtgPVN2HK1Gm7YAbL+jTtcKYC6ON4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TENTzF3yekze0G+VqABBTDGupUlotFeXiA62lP0rxdCrXR1GqJns86F29jwJMrDWbZ5m7lBZ51BBNPTrWBcKZ3mKlSWlVOZw1fbz3VjSugB5CISnhFNc4TbDt+zd30N9HogQJ3sLJ0MKNbndEbXbxCX5Hn027upfub/2RqAAOnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMWl3YH6; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMWl3YH6"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c6da42fbd4so2438016a34.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 06:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765896109; x=1766500909; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HXC1zTl+didUYwY0HBVLhJVwrj873NlobIJF0eUahEA=;
        b=iMWl3YH6W1bnmfrEWWK7Qm/qCw9EY6OeLcVqMXVLzJCuauLv4vVpoIpJCPvi0k5uCP
         9Mb5S449uONIBiaExIJNKgJYNg1XMrZooUlU9AYx2Tzw1o3IC3CGvZvHkSxtAZHDV2WP
         zmO1IeNXt6vSGlbCFJ2udHe1/FOy+JGXZcFzy5eohMQkJO1EuOEK6D1H1xtv/H2rUIAc
         hoDce7OaEBxgARGJ7pPDM8ffPm3NAeKosTqZgDIfH+Q3k6CdPfEyC7WznXrdYOb4vvOt
         G7j2vMjM3zj7b48on2CfX7EzHCkRQJai5Tnz4ZXjNDalKhArAyn6rCV+UTNyXeDu/Zuj
         rLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765896109; x=1766500909;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXC1zTl+didUYwY0HBVLhJVwrj873NlobIJF0eUahEA=;
        b=cvcaXn0wnsm1VXUCIarEZBy9YMNsEMU53GJjnRG8gzmVgroXiIUl0W/kVGq4XuooFb
         HrDjGpRPqairLlJBdM/QDhaXNdw54snDG0JPqlRKI/OETq6/8jg2jzBMohIASkDv8RUZ
         jpF9UQuVMATs8RfasVc8dEVxO4FjqaKSBUE0HqzJeULOaluc5ZE/7DtgoZHC+4hKDwbF
         yBtu6UhOAIObYFpwXIWMUJrtbeLmhnIsAJk5rRpbUEtuEhBLrfnZUxyvZstMxMB11uom
         1YDt+GuGLXkLSGKaUnrXRaDHp2C1RRCa42ED6/NOqF8b1Md9vSVorK3L8Y8EY3HI2cql
         u8fg==
X-Forwarded-Encrypted: i=1; AJvYcCXWBaut392S03AESX+GdeUmlssbOXhMyBYQR07k5Ja7PTPKS7Y9XCHcNKvhNq/Z8rXhFAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz/YE4CtXVCLUi37AnElVKf8KLATYp2NYVLiqv8OC9V6fN2Nfa
	1LVZWrLKQFGzWFCaVrYrofC3R4Pg5BcbbIGt7n7GUS7xrfylIsdnAM4i
X-Gm-Gg: AY/fxX6LPd+iIoemQihOKnUf2VZGIzI71FiCfm0F32E/Ga5umjpt2xiRsstD4d42MdG
	fDqdTa2zjAdUOU4YZfjEYviRLj3Bcqo6tPd356hV5FEPl6h6GavKjnVeHB2HCk2QvGb+ui5mZIC
	WirwVsTGuv6W/GZ9d5o9JUjlAmwEp7S0RcUWsp0rWoyJpbUvhRig7yPDg8iNWGK2ZujkYnAGxAD
	vLUyEb0PJiYXD6rTlB9f4LvcvxtQhPuL/E/GZDdvwUZdEj34wbkawtTds6b84QjYDufBYGISdXC
	+Dwo0fRSMyUt2CbAYT2b1c6RNc0WPlHtNftB+oaMJmqgterS36hRmbQ44DcYzyJyEnT/YVdjjVP
	jvAl6Lsbvxie2kx+X5sCGoHhqgQzii5dSj+3l+3k5Wp3mGey/ANrWX1S14x6rQsxw2HXo7sUyq4
	YIMDhi
X-Google-Smtp-Source: AGHT+IGUsxQQTrBkkMfpX1CZk/os/ST9Zno6xfof/DLaqAokFhafJrIoNXYZ2QKppvKqJEB8g1bDMA==
X-Received: by 2002:a05:6830:3c1:b0:7ca:f1fa:e9d7 with SMTP id 46e09a7af769-7caf1faea5fmr7393799a34.16.1765896109388;
        Tue, 16 Dec 2025 06:41:49 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb010476sm11494948a34.0.2025.12.16.06.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:41:49 -0800 (PST)
Date: Tue, 16 Dec 2025 08:41:48 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, ps@pks.im, 
	Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 2/7] strbuf: split out logic to humanise byte values
Message-ID: <z7fuww4wnfpt5m7rojixyp3atejopjr623bi7o7snplas7dgsg@yktwdifek23m>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
 <20251212223644.3090879-3-jltobler@gmail.com>
 <CANYiYbE3Tx6B5L5rEoDue7hTYzFGxw_qA-MRpC9RSxQ7HRczaw@mail.gmail.com>
 <xmqqqzsv3uus.fsf@gitster.g>
 <CANYiYbExjGoCw4n92a75xtREE_EhjEySVSmk=NwJd3GoMAoVLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANYiYbExjGoCw4n92a75xtREE_EhjEySVSmk=NwJd3GoMAoVLg@mail.gmail.com>

On 25/12/16 02:18PM, Jiang Xin wrote:
> On Tue, Dec 16, 2025 at 12:37 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Jiang Xin <worldhello.net@gmail.com> writes:
> >
> > > On Sat, Dec 13, 2025 at 6:37 AM Justin Tobler <jltobler@gmail.com> wrote:
> > >> +               return humanise_rate ?
> > >> +                              /* TRANSLATORS: IEC 80000-13:2008 byte/second */
> > >> +                              xstrfmt(Q_("byte/s", "bytes/s", bytes)) :
> > >> +                              /* TRANSLATORS: IEC 80000-13:2008 byte */
> > >> +                              xstrfmt(Q_("byte", "bytes", bytes));
> > >
> > > We have already defined "byte" as a 10n string without plural forms in the
> > > file "t/helper/test-simple-ipc.c" via commit 36a7eb6876 (t0052: add simple-ipc
> > > tests and t/helper/test-simple-ipc tool, 2021-03-22 10:29:48 +0000).
> > >
> > >     OPT_STRING(0, "byte", &bytevalue, N_("byte"), N_("ballast character")),
> > >
> > > The newly introduced usage of "byte" is now marked as having a plural form
> > > (via Q_("byte", "bytes", bytes)), which causes a conflict. This results in make
> > > pot failing with the following error:
> > >
> > >     msgcat: msgid 'byte' is used without plural and with plural.
> > >
> > > This happens because gettext requires that a given msgid be treated
> > > consistently—either exclusively as a singular string or as part of a plural
> > > construct—but not both.
> > >
> > > To resolve this conflict, we can unmark the singular "byte" in
> > > t/helper/test-simple-ipc.c, allowing it to reuse the translation from the
> > > plural-form definition of "byte".
> >
> > I learned a new thing today and am happy :).
> >
> > But how does one "unmark" the singular "byte" there, exactly?
> >
> > Would something like this ...
> >
> >      OPT_STRING(0, "byte", &bytevalue, Q_("byte", "bytes", 1), N_("ballast character")),
> >
> > ... a good idea, to "mark" it as a countable noun that has a plural
> > form?
> >
> > Or did you mean that we can simply drop N_() around it, i.e.,
> > N_("byte") -> "byte", to discard the i18n, because it merely is a
> > test helper?
> 
> I prefer dropping N_() for "byte" in "t/helper/test-simple-ipc.c", and
> the i18n for the test helper will continue to work as before if we also
> mark the plural-form of "byte" in this patch series. (i.e., drop the N_()
> for "byte" in the test helper in this patch.)
> 
> This is because N_() is a macro that does not invoke any gettext
> function, only returns msgid as in gettext.h:
> 
>     #define N_(msgid) msgid
> 
> And the actual translation for the msgid (the argh field of an option)
> occurs later by calling:
> 
>     opts->argh ? _(opts->argh) : _("...")
> 
> in "parse-options.c".
> 
> However, replacing N_() with Q_() would cause the string to be
> processed by gettext twice: once at runtime via Q_(), and again
> when _(opts->argh) is evaluated.

Thanks both! This thread has been very informative. In the version I'll
go ahead and drop the N_() here for this patch. :)

-Justin
