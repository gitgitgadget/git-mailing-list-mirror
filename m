Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055D0C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 16:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E61214AF
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 16:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTLdgo9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgAQQyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:54:12 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34100 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgAQQyL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 11:54:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id a15so23105868otf.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 08:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZM2DOQjV3js8kR/Q2XZSk7XpeVcDNSnWz7U0fNXwNdc=;
        b=nTLdgo9mS+P8rPAFQRWLhk2cRhodxT6fEjhvqD40Z9jw/X7KXvYb9turTC4tGZMFdy
         qwWmbu/BC6DReZdEavC9WNDWk+95/MjXBOCX3AM4J2iqYvI+Z2LtnAu3VGFS12m8isVh
         o7/dF6YXJ7z2Oi4cuOXBNblXVVHyKejrUYrRrUIDN266O3+nJ541+VGqcCgdZ23TygJQ
         X5GpKf8L4gR39NPmStHi1P9WCW/QyC1qhHGLhuM0Amks71lMiE9JMAr5+a33dhfhBPUW
         hzERySPoZA/XPxFOMLZFesZ/4GXFeTUkqH4Gapb3nIgEm+CvEDQfYS6AasFZ4S1XGUao
         OMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZM2DOQjV3js8kR/Q2XZSk7XpeVcDNSnWz7U0fNXwNdc=;
        b=DydLiV080LZ9W79M8Sgzg234LZKxv/4i4q/RO3tIbErqW1iIn5t6lvL14FHVDEqHOS
         XHRwufEdCbkrwkLCILgzB0Jo0VCbL68VBmYwI0ZlQFPfM4S3R0x431isqp02ZwurRS8C
         3r9+nf4Ja8Zwr10CX1pkd2rmURGKe1cQKkZ5BOiaR7+GCb9ehFHiPNswiQsDZQlt3m2t
         fL50uFjcpUHeKLEvSiRGYyCdBgo7M1QwTGF9cEY2tAokZUuPFVcjbHcp0kHMhaTpGdJV
         GMZHS9bWfCbk5XiyamYOpjDVOVFnt+vZ9oMKa+em5hIoRajk2Ki/0zikYI41Fszxy/Bo
         BZzA==
X-Gm-Message-State: APjAAAWd4xLCRj66OmRmA+8PQfWapKnL6SMjNBg7i0ogl0py8f/visFq
        0f3gGNI6XnFbSq5OkLFpXVWshjDVOWOKBgQH82o=
X-Google-Smtp-Source: APXvYqwsRFm3L+RNATwm2PVZlqwRDSqIfcXO8HlENEQ5FFz4uoDsBFXVBuwQbJ11HLk87HDlCHifilmZiN/HmS1ABlQ=
X-Received: by 2002:a9d:24ea:: with SMTP id z97mr6821628ota.345.1579280050685;
 Fri, 17 Jan 2020 08:54:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.692.v2.git.git.1579098078501.gitgitgadget@gmail.com>
 <pull.692.v3.git.git.1579206117.gitgitgadget@gmail.com> <9efed585ef7a1c09ed62998882236e7dbb58383a.1579206117.git.gitgitgadget@gmail.com>
 <37815f50-35df-ef02-4def-ad857fd55520@gmail.com>
In-Reply-To: <37815f50-35df-ef02-4def-ad857fd55520@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 17 Jan 2020 08:53:59 -0800
Message-ID: <CABPp-BEodg2wJU5m-GJ+zTifnEyRJ7eoKx86wZzaOtRfD91_vA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] clean: demonstrate a bug with pathspecs
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>,
        Kevin.Willford@microsoft.com, Kyle Meyer <kyle@kyleam.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 7:20 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/16/2020 3:21 PM, Derrick Stolee via GitGitGadget wrote:
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > b9670c1f5e (dir: fix checks on common prefix directory, 2019-12-19)
>
> Thanks for fixing my typo here.
>
> > modified the way pathspecs are handled when handling a directory
> > during "git clean -f <path>". While this improved the behavior for
> > known test breakages, it also regressed in how the clean command
> > handles cleaning a specified file.
> >
> > Add a test case that demonstrates this behavior. This test passes
> > before b9670c1f5e then fails after.
> >
> > Helped-by: Kevin Willford <Kevin.Willford@microsoft.com>
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > Reviewed-by: Elijah Newren <newren@gmail.com>
>
> Do we need your sign-off here, too?

I figured I didn't change the code, and the list already independently
saw your submission and sign-off, so I assumed that a "Reviewed-by"
was more appropriate.  If I'm wrong or people would just prefer me to
also add a Signed-off-by, I'm happy to add one.  And if it is, then it
should also be added to the last patch in the series from Peff.

If Junio wants it and it's easier for him to just edit-in for both of
these commits:
   Signed-off-by: Elijah Newren <newren@gmail.com>

or I can send a re-roll.  But I'll assume it's not necessary if I
don't hear otherwise.
