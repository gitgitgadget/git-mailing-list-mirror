Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B640F8D0
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229742; cv=pass; b=GX0nJoO1vP/oMRGRG2lV7jTN5UzO1SpJrSjUikGuHPuAW1NQ06AF7o6mqQlnCwsjdyTIDAoNX7Vn5dBgTh+nqUstKdfoDH65kgkfEfZ8gUMj6cH1GkhxuD5GSl/2ehVvZ6wmtUTLKJRAdME09hci4sa7uODMlHuGrf426ED2/QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229742; c=relaxed/simple;
	bh=ja2O81zwsVsPwkbsmwk9fuY1nDnR6tXJaEPmjqeksZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d39Rdr95haj1zHs6z7nE3Sx5Vn3DPI/ed7y5tFtwFtK9AfYxBuTGV5BLQOvaowzaKdZj3g0cfnEMJFJqDkd7SVXJdlyu5xETFANYyvUZHFnTQKyGRFMMCcOVTxxCgSCE5uoy3N8Z99gZ0XKBsGII3AJHOGltWb6E3GkP+T5oB3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=source.dev; spf=pass smtp.mailfrom=source.dev; dkim=pass (2048-bit key) header.d=source-dev.20251104.gappssmtp.com header.i=@source-dev.20251104.gappssmtp.com header.b=OtoSNFKv; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=source.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=source.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=source-dev.20251104.gappssmtp.com header.i=@source-dev.20251104.gappssmtp.com header.b="OtoSNFKv"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664b3dfbf70so97799d50.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 02:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785229739; cv=none;
        d=google.com; s=arc-20260327;
        b=rVFB8L35UKPltMQAh+WqmrGzjYFlqylODdyHdffzMPLkanZVzFt0Ytrbqh8loBbANM
         aztczGS+39EBVG5RytnmUcrXCcY3HZmPSOCjbjE2/3JNyJEtZPRPP1T+CPSgGOZrTnPE
         L3GtTtVw0uavZwRp9tY+2dSvBIkm/wnXnvdlVQfEjA9LTHd/d5r3+5IzA4XByVRtLr8S
         pqoZj+/22E1Erp5qMnZkJ/hm/72ilK7COD9N5YLXusMU4TokTKMKKkY0q5jZQaMX8R9i
         Jl2Bd3F4pOO7p183n9d6B3RBzGDyuKPq7LvR4VMzcz4tbIFb85HhzXEdHHVNbZWbiukt
         g1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AQiVz14gsgzuX4jPiYscpTHtSu6DtwpktvDqCx+1vpw=;
        fh=oXOqwYaROWggbcdiccaKYGW5dEKLcOxkHO/0sMyBcgA=;
        b=HXWJor8d2rp5Ag0Y9W7T0H0+6HDVJKesleVSht8QHt2ifXcV02RRAYEglHYP1F8wEH
         iWlNLIiKMlKKVyDtuOsMSqy1yDK10ST6+uVmX5DqGeasFqgkoDQRGtG2HBinPxa6SfIg
         iq49GZD0UYZJLcT1NJS2DvZWaRw82q0Ew4BI2sTwIzShFqsxk+cyYgB3BZrEN8TxsEob
         TW/J3dErlj6ofJJZ68AR95jBzw4C/Uy8urQkCUDyIEK4AJ3ito1lNlHIAmCXFp1wOgoc
         ILnFjFTmhWZOAd1JusjMSZzTIxAR5OcTbWr8etzFRsGfRVdKkMgziP1KS+T1SQCxyEC0
         NbZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=source-dev.20251104.gappssmtp.com; s=20251104; t=1785229739; x=1785834539; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AQiVz14gsgzuX4jPiYscpTHtSu6DtwpktvDqCx+1vpw=;
        b=OtoSNFKvEtdmu1Z+8oK37Uhaimg7jOjLwjT1OjfMXMw6GrHVVnPOXhQwO20ES7nLe+
         DTQP/aqH9uFxn4yXQGd6Ezhjgp/icCCNWNKCRmf/AW0SpfYPRK8UCdCBGvX0frxj0KbP
         8tjWrxvVxVjfg7DisCYfgfOJsWm6g5vJpDhY01nY1DnvctTAAEcPcby9PsrGu4gpwLPv
         OfcofdxqGzAYEqjHsZSiXS0XprNIzl9GgPo+TD42Pd1p+K0dqKDS3lTPHkN5eXFle0VS
         O0nk2WDwIKvSQcYCYBPx6A7W8Q4opF7hoDhFx2q8TNrCF5n9wGsGn8ViL7UIb2zmVMyY
         u9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785229739; x=1785834539;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AQiVz14gsgzuX4jPiYscpTHtSu6DtwpktvDqCx+1vpw=;
        b=PIsAlM4bEKTvFZIH3nSNX72RsL8opjkZv5IrXMhd++SE9jdkhJT0ugeqZ0Ed9SGnZL
         twnBVW0Fji43cjr/hFqoxiAFD8u0GvIL+ZerZdBTdIDfZNzrzA4OFgx6t3gstUHcpPss
         Oq+NAsfuv9SpQXvRZPLHxKVGLwlAOp6nKnRqC6M8lOZNiXlyonc2merBdIk/JtHQobG6
         c8o4tlnQhmwuETqXDDVZ8tifqtoUpCXUON98J4aP/DapbPnObPW0VC/aT8q3qwbvJ0oD
         dZW7KDfPtVzdPqSGqPIJTMWSTPq+flSNPGX0SVM/qWnGkkiYUWSr3WsVRsafkYJcDcCj
         xsKA==
X-Forwarded-Encrypted: i=1; AHgh+RoU+0wU42qjNbRCHURBdOQQz4B8r8g61RbWhHG6d48+hT9S8SzQVxnKWpMFG4SP+zTbEpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKESlOftXv0XiCd5NV/vVqURcsXZjUc/qiT5me4IzbMA1/xX5w
	MEEVCM6dEBjVhplpoltVIBuNFqWBx4TT/cWHD5BSRgNI7lO/oI3Sf/MQRDHV554ycVAsRDwmyrs
	h2xKTPjLZjJgcNA01gF/GFdI8GnnqFmNCuVJFc4/PYg==
X-Gm-Gg: AR+sD10eHbgmwVm3Dcsv90HQcEQcvlyoYtZReACK/pbVDCey/R2jhd2TIts6A7hiPv2
	BYK0BXD1JYr697IGG3RQEm1NW9/6LXFyowbjIjb3+jW/USLUDVx3K0adjveMlNthQofVANjJgP3
	dP8F+89IJwQAUWvoN4wg6Po8GS0uJ8AsqKCOTBvSzpqy3kJllThTMuf/TT+j7qevBM2KMyVhPSU
	0RTtDY7WFpu62ComeZbjxSiRakrBCKFGWF5b0i+frKBchruY/OVUGDtov5M5cVvYEoWxj0JRPob
	4i5P8UAyIy9WEvY7xsZN
X-Received: by 2002:a05:690e:e8d:b0:668:43a3:9de3 with SMTP id
 956f58d0204a3-669058356fcmr874600d50.3.1785229739280; Tue, 28 Jul 2026
 02:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFZW3h0K6vi15HhMEX30Ab+pjRc3mQr2Myv9KJUH=MWzsvt0FQ@mail.gmail.com>
 <20260727095735.GA1153453@coredump.intra.peff.net> <DK9MX0YJ07S0.1TOBLIA6ZNSEN@gmail.com>
In-Reply-To: <DK9MX0YJ07S0.1TOBLIA6ZNSEN@gmail.com>
From: Alan Stokes <alan@source.dev>
Date: Tue, 28 Jul 2026 10:08:46 +0100
X-Gm-Features: AUfX_mzVTBe1QDfG1909YaCrgZzE3UQyTYIBv_AgnrotrYeJGKdxWg4x_i-nyqM
Message-ID: <CAFZW3h3xyeJJwHfVK2mB2k1=e-0he9_gbTetJ1RdB2uUM1rp4A@mail.gmail.com>
Subject: Re: Assertion failure with git cat-file --batch-command
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jul 2026 at 21:26, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> On Mon Jul 27, 2026 at 11:57 AM CEST, Jeff King wrote:
> > On Mon, Jul 27, 2026 at 10:30:43AM +0100, Alan Stokes wrote:
> >
> >> I first observed this in 2.43.0, but it still seems to be present in
> >> 2.54.0.
> >
> > Yeah, I think this has been there since --batch-command was added.
> >
> >> Note that if I ask git cat-file --batch-command to include the
> >> objecttype in the output it is fine (which gives me a workaround). Or
> >> if I use git cat-file --batch.
> >>
> >> IIUC git only fetches the metadata that it needs for each object, and
> >> that is determined from the format. For --batch I guess the type is
> >> always requested, since it is needed to print the object contents. But
> >> for --batch-command that doesn't seem to happen.
> >
> > Yes, exactly. In the normal --batch code path we have this code:
> >
> >         /*
> >          * If we are printing out the object, then always fill in the type,
> >          * since we will want to decide whether or not to stream.
> >          */
> >         if (opt->batch_mode == BATCH_MODE_CONTENTS)
> >                 data.info.typep = &data.type;
> >
> > But for command mode, we don't do the same. This makes your case work:
> >
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 1458dd76d6..78eab9723d 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -690,6 +690,7 @@ static void parse_cmd_contents(struct batch_options *opt,
> >                            struct expand_data *data)
> >  {
> >       opt->batch_mode = BATCH_MODE_CONTENTS;
> > +     data->info.typep = &data->type;
> >       batch_one_object(line, output, opt, data);
> >  }
> >
> >
> > but there's a slight catch. That expand_data is used for every request,
> > not just the current one. In normal --batch mode, every request wants
> > the same data (the user-specified format plus the object contents). But
> > in command mode, some may be "contents" requests and some may just be
> > "info". The code above turns on type-checking for every request, making
> > the "info" ones pay to look up the type.
>
> Yes, for example, both 'info' and the 'remote-object-info' series
> (marked to 'master' in the last "What's cooking") [1] act on
> data->info.typep.
>
> This would make 'info' do a type lookup, and 'remote-object-info'
> request "type" even if it wasn't present on the format.
>
> >
> > A type lookup isn't all that expensive, but it might matter for some
> > formats (e.g., just "%(objectname)" does an existence check and nothing
> > else, so we never even access the object data).
>
> Yes, and only the atoms in the format get expanded, a populated type
> without its atom in the format won't be shown.
> the wasted lookup or a bigger request are the only effect.
>
> >
> > I guess saving and restore data->info.typep would work.
>
> Yes I think that too, I tried this and it worked fine:
>
> static void parse_cmd_contents(struct batch_options *opt,
>                              const char *line,
>                              struct strbuf *output,
>                              struct expand_data *data)
> {
>         enum object_type *saved = data->info.typep;
>
>         opt->batch_mode = BATCH_MODE_CONTENTS;
>         data->info.typep = &data->type;
>         batch_one_object(line, output, opt, data);
>         data->info.typep = saved;
> }

That does look pretty simple and correct.

>
> nit: On the current code the parameters aren't indented correctly.
>
> >
> >> I'm not sure what the correct fix is - always request the type in
> >> --batch-command, or perhaps only if a "contents" command is issued?
> >
> > Yeah, in general if you are asking about "contents" I'd expect you to
> > get the full name/type/size triple. But it's not wrong to ask for less,
> > and certainly we should never hit a BUG(). So I think we'd want a fix
> > along the lines above.
> >
> > Do you want to try your hand at a patch? It would need to do the
> > save/restore, and most importantly add a new test to t1006.

I would be willing to have a go at it. But realistically I probably won't have
time for a month or two. I'm also a complete noob at the whole posting
patches via email process, so it may be slightly chaotic. If anybody else
wanted to deal with it I obviously wouldn't object.

Best wishes,

Alan

> >
> > -Peff
>
> [1]: https://lore.kernel.org/git/20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com/
>
> Hope this helps,
> Pablo
