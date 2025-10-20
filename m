Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9DD354AFF
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760941939; cv=none; b=TWJCqosLwrCLxfLy6H27Wjuz04Q1OUITcd6uVjfdQY17qoDHFb2dUBSFYqALk8eCPebKIxXhO0NljAk3LgW6R+Sa5uY4V15WcSGdj65TnHl6KCjxKUPWWxQYztD76tAsKiT5khwsPzz6C1WmsgtIpNRg5ovWvTrGJZlgPXznMRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760941939; c=relaxed/simple;
	bh=sfq3uRGyLmv8XmMMkeSn0x+MsKvZ1TvPYpp5U4o1Ju0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPPjdudsZ70a0vUdefLmH1FX8ZEqSQAwwdvv0JW/ZY/WYmbJMEkv1MPOwucIxonHs9pYltViBz0AzlrM1Bojd9waVipFnTa6XRyJJC48xeTsLDhZf6QTfwdw1GI+Q8BHx2oOJ9BSoEtzytAPFff6EK01i9fXOYMd7ANgvjzioEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHDj/exT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHDj/exT"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-26a0a694ea8so29341425ad.3
        for <git@vger.kernel.org>; Sun, 19 Oct 2025 23:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760941937; x=1761546737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d2dltspqfkQyY0pcrqDBjUSJn7vT9/2S3dfgWV2MlYU=;
        b=JHDj/exTHq8IHKg3wNLfdPBzmyMCDRFnBTpuaz0YfR2buwxLEoDCYWphkWC7CXVvmb
         8wwRUYQUkCUJSccjmqoQ7/dXpWg0O5Gge6cJSL1UqkuLjx1/zgVWe5qUI+JbHAJIEZnp
         R0+i7vscMUiSf8J7UJggQVA2spM6veS31g/zm2lfdH6SEFrw8s1/EC5V6KDldmimJYUT
         eYbqFut0atD2G5kq0T5yeidd4DUlDvCiqLjcILtvDHrgxyFgGrazB7qVHgKGIA//J7uU
         CkUsEw5yUuTwYJxAQLVA1VonS4BJObZJ/gHcyCWTsYQiwQJeDnkXYq/Z8TBrnPQMv9/U
         SAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760941937; x=1761546737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2dltspqfkQyY0pcrqDBjUSJn7vT9/2S3dfgWV2MlYU=;
        b=WoqcFtwo0edcbloinVqYxbWoEznElFObUMyx/a2xa9B55dD/pES1NFQPglOD+bCpAI
         SC4/Qn5JbN0dogJq56gLz9Qya7wbS428XmZgiLDc8gtQrnQUxnanqXJZpz+bx68xYntM
         HCNJPoh/s7SznVFLGcjvc1suFu+OLiaJ2dmD+0smEo9NM1z6hEG2tFDvNKqOixDIjvgV
         JaEc4QM/C/6VapEvchOHrruiWq82wtBGShuGmVEEWcuUxnVCrORqrHrZRTCN6jIli31h
         5BX+9Ifqcf6fCJhDD2c1nE7+mOWclsVlAmr8Q+BPFSU9UdRaOk+KnsTHwfYtphWhQB4N
         NNDg==
X-Gm-Message-State: AOJu0YyOyMUrXAUmRbn2aYVegLs7NGd1M+bbVynbjaE9b7IORx4r5FsH
	F50Ntq58V+xnnHacKliTHO4g2DbAqXV2A2CbheUS+J6BhHLMf/rLX24E6XFI6nffQ7KA0MRU9Dc
	vCHYQ2NXkfjp9rHpl8P+U/NWf/s70IPM=
X-Gm-Gg: ASbGnctDyJp0K0XxIrRtSKHWTuirCVwlYfmqh2vvda5WjxC/KtacLfFthqmi7emxZhL
	N7a9VZDcPTQfnUj5YHoUV4QnFn0gVxMwefY68oDnx67DRREOS2IejUtBH1VAYQWU5lx7HFTqHS7
	dMVmwgAOai6gEhpuno+6c6BkfBt9xFHCgtCKSM4GlhB1GBwWLmp4lSgPfZQz+fSAQklzaPtPdVt
	4TwPk5voktHoDrJRpqLPd9cA7Iv32TOmqRkpueXZq4JgONv3fFHmkbrVzmbBnaXLg==
X-Google-Smtp-Source: AGHT+IEirGlbGek6/7yRVw1pDAHNWkAP/cmpq/OC0ozckesdi5DOcPMAubC8Q5Xk3qE0XsfMpH/XZxf6YjQ0CoeBjKE=
X-Received: by 2002:a17:903:4407:b0:27e:ef27:1e52 with SMTP id
 d9443c01a7336-290ca1218dfmr139923125ad.35.1760941937192; Sun, 19 Oct 2025
 23:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760869186.git.belkid98@gmail.com> <7da4fded535984faea52d5f88793d3c8e47c0091.1760869186.git.belkid98@gmail.com>
 <xmqqqzuy3n3k.fsf@gitster.g>
In-Reply-To: <xmqqqzuy3n3k.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 20 Oct 2025 07:32:18 +0100
X-Gm-Features: AS18NWDAIrem1YnAgN2L_ADPj-XL9Ycg4A52zMvhIsJBd7QJMQeuWoHcc6tqtPs
Message-ID: <CAD=f0L8Zc=rRwCo0QHWnf8OCXidubJrQYpeQg=gLXV=npO-T1g@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 1/2] gpg-interface: replace strbuf_split*()
 with string_list_split*()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Oct 2025 at 16:52, Junio C Hamano <gitster@pobox.com> wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > In get_ssh_finger_print(), the output of the `ssh-keygen` command is
> > put into `fingerprint_stdout
>
> Something lost at the end?  I'd assume
>
>         ... into `fingerpritn_stdout` strbuf.
Yes, thank you.
>
> and tweak the copy I received locally before applying.
>
> > The string in fingerprint_stdout is then split into 3 strbufs using
>
> "into up to 3 strbufs", I think.  If we do not say so here, ...
>
> > strbuf_split_max(), however they are not modified after the split thereby
> > not making use of the strbuf API as the fingerprint token is merely
> > returned as a char * and not a strbuf, hence they do not need to be
> > strbufs.
> >
> > Use string_list_split_in_place() instead for simplicity.
> >
> > Note that strbuf_split_max() uses 3 to specify the number of tokens to
> > extract from the string, while string_list_split_in_place() uses 2
> > because it specifies the number of times the split will be done on
> > the string, so 2 gives 3 tokens as it is in the original instance.
> >
> > string_list_split_in_place() returns the number of substrings added to
> > the `split.items` so for a successful split of the string in
> > fingerprint_stdout, at least two items should be added to split.items
>
> ... this "at least two items" would become contradictory.

Yes, noted.

>
> > so we can always be certain that the substring at index 1 is the ssh
> > fingerprint even if the key owner's identity part is missing from the
> > string in fingerprint_stdout.
> >
> > Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> > Reported-by: Junio Hamano <gitster@pobox.com>
> > Helped-by: Christian Couder <christian.couder@gmail.com>
> > Helped-by: Junio Hamano <gitster@pobox.com>
> > ---
> >  gpg-interface.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index 2f4f0e32cb..cb182f4c11 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -14,6 +14,7 @@
> >  #include "sigchain.h"
> >  #include "tempfile.h"
> >  #include "alias.h"
> > +#include "string-list.h"
> >
> >  static int git_gpg_config(const char *, const char *,
> >                         const struct config_context *, void *);
> > @@ -821,7 +822,7 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
> >       struct child_process ssh_keygen = CHILD_PROCESS_INIT;
> >       int ret = -1;
> >       struct strbuf fingerprint_stdout = STRBUF_INIT;
> > -     struct strbuf **fingerprint;
> > +     struct string_list split = STRING_LIST_INIT_NODUP;
> >       char *fingerprint_ret;
> >       const char *literal_key = NULL;
> >
> > @@ -845,13 +846,12 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
> >               die_errno(_("failed to get the ssh fingerprint for key '%s'"),
> >                         signing_key);
> >
> > -     fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
> > -     if (!fingerprint[1])
> > +     if (string_list_split_in_place(&split, fingerprint_stdout.buf, " ", 2) <= 1)
>
> This may be just me, but when we expect at least 2, I would find it
> more natural if we said "if (count < 2) then error", rather "if
> (count <= 1) then error".  I'll let it pass, as there is nothing
> mathematically incorrect here ;-).
>
> >               die_errno(_("failed to get the ssh fingerprint for key '%s'"),
> >                         signing_key);
> >
> > -     fingerprint_ret = strbuf_detach(fingerprint[1], NULL);
> > -     strbuf_list_free(fingerprint);
> > +     fingerprint_ret = xstrdup(split.items[1].string);
> > +     string_list_clear(&split, 0);
>
> OK.  This is a straight-forward rewrite that is fairly faithful to
> the original.
>
> But I wonder why the original was written in such a convoluted way
> to just extract the first part of a string that is space delimited
> tokens.  It is obviously not your fault that the original is written
> that way, bit I would have expected it to be done more like this:
>
>     char *begin = fingerprint_stdout.buf;
>     char *delim = strchr(begin, ' ');
>     if (!delim)
>         die_errno("Barf!");
>     fingerprint_ret = xmemdupz(begin, end - begin);
>
> Am I missing something?

Okay something like this which just finds the desired token and
returns a copy?
    char *begin = fingerprint_stdout.buf;
    char *end = begin + fingerprint_stdout.len;
    char *space, *start, *endtok;

   space = memchr(begin, ' ', end-begin);
    if (!space)
        die_errno(_("failed to get the ssh fingerprint for key '%s'"),
            signing_key);
    start = space + 1;
     while (start < end && (*start = ' ' || *start == '\t'))
            start++;

    if (start >=end)
        die_errno(_("failed to get the ssh fingerprint for key '%s'"),
            signing_key);

    endtok = start;
    while (endtok < end && *endtok != ' ' && *endtok != '\t' &&
             *endtok !== '\r' && *endtok != '\n')
        endtok++;

    if (endtok == start)
        die_errno(_("failed to get the ssh fingerprint for key '%s'"),
            signing_key);

    fingerprint_ret = xmemdupz(start, endtok - start);
    return fingerptint_ret


>
> That may or may not be outside the scope of this topic, which is to
> reduce the calls to a misdesigned strbuf_split*() API functions.
>
> Thanks.
>
> >       strbuf_release(&fingerprint_stdout);
> >       return fingerprint_ret;
> >  }
