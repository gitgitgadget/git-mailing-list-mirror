Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D63FC433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5AF61056
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhJ1WRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhJ1WRp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 18:17:45 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4840C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:15:17 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z144so8988683iof.0
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHEAbjDbqSDU4cyln/xc4/8mgBKXTv1XLxeeJMzm5Ig=;
        b=LYq2SlrjQKgiAdwcNgtKfYoJq3HsJp1b5aiMtE5u3IYPG38AsHJMkwC4ypCUVnKG89
         UeEsvuVIRjmwMEqFIddUvP9g8zKT6E7o1pKjtWVcISqRn8TNytVa8rR6wL9mhmO5ogBs
         U9a//Jzr56L3Gu0/02sxbfRR0P5iw3aXDRq7JxdojoCxHz16ProaSoRwSCGK7BGG6QXO
         8aIo1M6akUdtdi+ev5+YnRyk42UI2XSz539mYAkrrIj2GpXRKmdlT9/rHQv4CKHxFW7U
         A6YBjlU7hPJNjPXqVbNtZ6e/yTvOqYrKEafLaTKT4QRUDRPeOrft63ktPoyDb5Z24QlW
         nhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHEAbjDbqSDU4cyln/xc4/8mgBKXTv1XLxeeJMzm5Ig=;
        b=4Q7TH4e9AMuLG7j8S3xXH/flO4Rip43bduqGCvE6pnGLbnq7AqX8jH3aRhsY0zRDOl
         WQnDJA+UdpGNVA1mhkmfD1g7DRM6V8Mn4/Jh36Gr89eqyEXn85ixLJtBhsPnnLnvld6s
         U/OV5kn9FqYB+QgMc57iSf+NyVh21DmFnRpmYIl4JNpRvp3DYNPtM0gLKdaIpfiJ4Wwj
         1rdcWuxtaLBRZv+AAjAfI01WF90ot9nnsXtWYdjriZoRfRDR3osvyzKjo5iNnPA1oov2
         c5OeOOODvRRwDTYcT4vFWJKp80PICeR3ebcNVfjKd3vGEkS6bd4cADiqU9dnNdyqpzK7
         VFaA==
X-Gm-Message-State: AOAM531DXS4mw4f3bcSPw131fXYnBFH7RTc2kYvudKBh2NKoWTpS7eU5
        t12+MIr4GimFsB60EclkmHlcI3EyF3YR1jkcdUJKFQ==
X-Google-Smtp-Source: ABdhPJyhXy/IfGfwWOr9oV64LC2YNrljaX5pJ0wy1noYll94vCSfYGi+TAsuix+nC4AhVTk+T+6gmE0CIxLBBMP48VM=
X-Received: by 2002:a5d:89d0:: with SMTP id a16mr4907037iot.159.1635459316891;
 Thu, 28 Oct 2021 15:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
 <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com> <973a250752c39c3fe835d69f3fbe8f009fc4fa74.1635288599.git.gitgitgadget@gmail.com>
 <xmqq35omt11f.fsf@gitster.g>
In-Reply-To: <xmqq35omt11f.fsf@gitster.g>
From:   Ivan Frade <ifrade@google.com>
Date:   Thu, 28 Oct 2021 15:15:05 -0700
Message-ID: <CANQMx9WFKJAGF+7zti8+-b2je9sFuNxwOx-LCPtEoGCea54Mdw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] fetch-pack: redact packfile urls in traces
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 6:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Ivan Frade <ifrade@google.com>
> >

> Just a curiosity.  Do we call these packfile URI, or packfile URL?

The feature is "packfile URI" (and the section is called so in the
protocol). I changed all "url" to "uri".

> > diff --git a/pkt-line.c b/pkt-line.c
> > index 2dc8ac274bd..ba0a2d65f0c 100644
> > --- a/pkt-line.c
> > +++ b/pkt-line.c
> > @@ -370,6 +370,31 @@ int packet_length(const char lenbuf_hex[4])
> >       return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
> >  }
> >
> > +static char *find_url_path(const char* buffer, int *path_len)
> > +{
> > +     const char *URL_MARK = "://";
> > +     char *path = strstr(buffer, URL_MARK);
> > +     if (!path)
> > +             return NULL;
>
> Hmph, the format we expect is "<hash> <uri>"; don't we need to
> validate the leading <hash> followed by SP?

I was trying to find a uri in a packet in general, not counting on the
packfile-uri line format. That is probably an overgeneralization.

Next patch version follows these suggestions to look for a packfile-uri line.

> > +     if (path_len) {
> > +             char *url_end = strchrnul(path, ' ');
>
> Is this because SP is not a valid character in packfile URI, or at
> this point in the callchain it would be encoded or something?  The
> format we expect is "<hash> <uri>", so we shouldn't even have to
> look for SP but just redact everything to the end, no?

Yes, now that we count on the packfile-uri line format, we can redact
everything to the end and there is no need to return the length.

> > -     packet_trace(buffer, len, 0);
> > +     if (options & PACKET_READ_REDACT_URL_PATH &&
> > +         (url_path_start = find_url_path(buffer, &url_path_len))) {
> > +             const char *redacted = "<redacted>";
> > +             struct strbuf tracebuf = STRBUF_INIT;
> > +             strbuf_insert(&tracebuf, 0, buffer, len);
> > +             strbuf_splice(&tracebuf, url_path_start - buffer,
> > +                           url_path_len, redacted, strlen(redacted));
> > +             packet_trace(tracebuf.buf, tracebuf.len, 0);
> > +             strbuf_release(&tracebuf);
>
> I briefly wondered if the repeated allocation (and more
> fundamentally, preparing the redacted copy of packet whether we are
> actually tracing the packet in the first place) is blindly wasting
> the resources too much, but this only happens in the protocol header
> part, so it might be OK.

We only allocate and redact if it looks like a packfile-uri line, so
it shouldn't happen too frequently.

> Even if that is not the case, we should be able to update
> fetch_pack.c::do_fetch_pack_v2() so that the REDACT_URL_PATH bit is
> turned on in a much narrower region of code, right?  Enable when we
> enter the GET_PACK state and drop the bit when we are done with the
> packfile URI packets, or something?

I move the set/unset of the redacting flag to the FETCH_GET_PACK
around the "packfile-uris" section.
There is no need to check every incoming packet for a packfile-uri
line, we know when they should come.

Thanks,

Ivan
