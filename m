Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AC2846D
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706698; cv=none; b=ZZOvu7QPm8B857huuEfDBx1CYQ2kRrmZ/MBK+mYBvh1ILcE0JwZpE9H1cYifwouDuFFWK8N/k533IzKH10ebFyiztSLxc73abDvi9ggxGFTGutx39aEPOzpVzVZPEwc1rr42nQM3XttHILrIYSAAmRpALnEgyMAQWuzf6ekb9eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706698; c=relaxed/simple;
	bh=rFbwNAA/Jr96ZJJ13HILqHtebWj9Usw+YB2ue1fGFl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrunoahGoS6w+v95Zy/Y/25XwYCtBX/XyLgcoDOobDTO1InodvTmK7DzNV5Lm5cSK9A3EaKc+75NB9sQ1oYo4ZtUQgpZTtsh9DNaX/xeXu1lFq07w6EzvWQqTqtZY9JQTCHNf9VJuMqQ/1SJjv79Flb80F6K/lqugYLdiJ5QK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsaUNtbN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsaUNtbN"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so2071383a12.1
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741706694; x=1742311494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c1hf8hAOdhqGPyVZD1VYzU6ZpQpaI1twiioBCMCvbM=;
        b=UsaUNtbNLGmVEor7GoAqYVVxxO3X2vnGKDyayQWuMouFvjATzPdzV2szBHlRVBxgj1
         KsgPnEzEaw1owx2E7NqftN5bU//MIEmxuaBkQQbmAF0vZVAI2TK3+isssASMqNaPCrdm
         gOcd34lPKgtMtPqts3RYgqkCABz4KlTR6A+TRKQXhNOWSjntogIrLtAQh7Nv+OoujRpT
         ppeRKkL21zMoDpTtt8w56cgk2EpUKoI02BTLnbhymi8fAwRgDSfkSgyo5xEHqjMnLUkD
         6uWTe9AMD8sSK3ad2cEphf23nE5sC3rPeytW4XU4qLiCaZi7DnADQChlUZ7skAcshpNP
         shyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706694; x=1742311494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7c1hf8hAOdhqGPyVZD1VYzU6ZpQpaI1twiioBCMCvbM=;
        b=r96HNKrQvDHXF7oYdEtPmZaoryD8QtRefG9TDyGYUetYABR5P+r9TxZDxmbGwcR29x
         07FXks3CHeHLKuW91YuduFqda7jsE5De+WGuqR11lCZVwZPqcpi1I73jfh6u1juVmY3P
         rto4ewyVEspl10EdJaAOnZMKYeQ2m/j885lkfT/uzNekSU56G6VEd2IqvBQsSAJAL0mY
         mg0zqxBvILEzzqF4H/Butrdha0KtvLIsM9AGEvyOIcAoymo+eWRtaUKd3we2sDw4QELe
         eRudfMH0TFZzgRAq2DnttqYMDKua4E3siISxgmBv/ctgf3mIfwRbANlHrLpJYhkOtT2u
         8oDA==
X-Gm-Message-State: AOJu0YxuGNR36OZ0KvrAZCzKYpJ1bpDIS0J7AuVY3ZTc02Czr31J7hTY
	kdcGd0tn3cqB8J7Te7G6RwxXU/qLTAZXRaWbNR2NR/F3C4LLs8J1d2y4MEckMzuELZPE7mn9MS4
	4TFWVOLreEp8E/tdxJVwxLIhZ9q8=
X-Gm-Gg: ASbGncuKJfwAq5n6e798C1K9cuhPsywkdenjmR5ltP3psutlkk0aQApNA26+yl8LZ0f
	c2kkqqoL/zsQGZXxLyG/CxBD1XqWgkET0gnAyG1q1WRdOTGvLCYaIpb7CSgg293RwbwKHHO93r7
	SWdUnxtZss07sn4DYwz9cKiob871RO9QnKQZYbVcY=
X-Google-Smtp-Source: AGHT+IGKOopZlhg/dvETlgIj1977EwYhd03QtJx1rAs/MtpBROD6QNEr6bIONkp6jmw69SDgovr//Nda+N4KdcUCQWU=
X-Received: by 2002:a05:6402:254e:b0:5e6:102a:c30 with SMTP id
 4fb4d7f45d1cf-5e762808483mr5420285a12.2.1741706694067; Tue, 11 Mar 2025
 08:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310074053.1886097-1-christian.couder@gmail.com> <xmqqo6y897cz.fsf@gitster.g>
In-Reply-To: <xmqqo6y897cz.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 11 Mar 2025 16:24:40 +0100
X-Gm-Features: AQ5f1JpLQT39u9a_NdWoguOTQZRjryeR6pdiAiXiDpQ7VCvEGdXyWwb0yuOXKhw
Message-ID: <CAP8UFD1ujnSYEnNO4xifwXj397V-=1kJSMGJ3j613+qVAkyg=Q@mail.gmail.com>
Subject: Re: [PATCH] promisor-remote: fix segfault when remote URL is missing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	"Randall S . Becker" <rsbecker@nexbridge.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 5:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Pushing NULL into a 'strvec' results in a segfault, as 'strvec' is a
> > kind of NULL terminated array that is designed to be compatible with
> > 'argv' variables used on the command line.
>
> It is good that you corrected a caller that tries to make a strvec
> into such a state, but shouldn't strvec_push() protect itself with a
> BUG or something, I have to wonder.

Actually strvec_push() uses xstrdup() on the value it is passed and
xstrdup() crashes if that value is NULL. So another way to avoid
crashes would be to make xstrdup() BUG when it's passed NULL. Or maybe
xstrdup() should just return NULL in this case?

Also it looks like strvec_push_nodup() kind of works if it is passed a
NULL. (It adds the NULL to the array and grows it.) So I wonder if the
right solution for strvec_push() would be to make it kind of work in
the same way.

Anyway I think these are separate issues that deserve their own
discussions and can wait for after the 2.49.0 release. Here I am just
providing a hotfix for the "promisor-remote" protocol capability.

> > So when an URL is missing from the config, let's push an empty string
> > instead of NULL into the 'strvec' that stores URLs.
>
> How will these strings in the "names" strvec used?  When URLs are
> present, I'm sure we are going to use it as URL, but when they are
> missing, what happens?

The 'names' strvec and 'urls' strvec contain what exists in the client
config. They are only used by the promisor remote code to compare the
names and maybe urls in the config with what the server advertises in
case 'promisor.acceptfromserver' is set to KnownName or KnownUrl. This
is done to decide if an advertised promisor remote is accepted or not
by the client.

When 'promisor.acceptfromserver' is set to KnownUrl, a remote should
be rejected in any of the following cases:

  - the server doesn't advertise an URL for that remote,
  - the client doesn't have an URL configured for that remote.

When 'promisor.acceptfromserver' is set to KnownName, URLs should not
be taken into account to decide if an advertised promisor remote is
accepted or not.

Note that the promisor remote code added by this series doesn't change
the code that actually uses the remote names and urls to clone or
fetch objects, so there is no change there. In particular, if the
client doesn't have an URL configured for a remote, even if the remote
is accepted and the server provides an URL, the client will not be
able to fetch or clone from the remote as it will not use the server
provided URL. The test called "clone with 'KnownName' and missing URL
in the config" shows that.

> The second hunk of this patch seems to
> ignore such a broken entry with an empty URL, but that smells like
> sweeping a problem under the rug.  Shouldn't such a promisor be
> either diagnosed as an error, or skipped when you accumulate URLs to
> be used into the strvec, so that the later code (i.e. the second
> hunk) does not even have to worry about it?

If 'promisor.acceptfromserver' is set to KnownName, I think it is
simpler to just ignore URLs altogether. Such a behavior is easier to
document and implement.

Also if we ever develop a mode where the advertised URL can be used
for cloning or fetching by the client, then it won't matter if no URL
is configured on the client side. In fact it might be the common case.

Skipping remotes with no URL would make it more difficult to explain
why a remote was rejected in the KnownUrl case. In the next version, I
have added checks and warnings to help diagnose why a remote is
rejected when a URL is missing.

I have also added a test case where the LOP URL is not configured on
the server side, so not advertised.

> > @@ -356,7 +360,7 @@ char *promisor_remote_info(struct repository *repo)
> >                       strbuf_addch(&sb, ';');
> >               strbuf_addstr(&sb, "name=3D");
> >               strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitize=
d);
> > -             if (urls.v[i]) {
> > +             if (urls.v[i] && *urls.v[i]) {
>
> Why does urls.v[i] need to be checked?  Didn't you just make sure
> that the strvec would not have NULL in it?

Yeah, right. I changed this to just `if (*urls.v[i])` in the next version.

Thanks for your review.
