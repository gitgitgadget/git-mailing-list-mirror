Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DDE71F406
	for <e@80x24.org>; Thu, 10 May 2018 20:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeEJUag (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 16:30:36 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:33463 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbeEJUaf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 16:30:35 -0400
Received: by mail-yb0-f175.google.com with SMTP id y5-v6so1109364ybg.0
        for <git@vger.kernel.org>; Thu, 10 May 2018 13:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LqhLdejbdawz66TXQyjGI8kKYAZiaIs0ZSG2lebOtEc=;
        b=AnWsdI+TgsJOFYklGzXhInhPmJnm4SQ+8a7Wy2zt6jm0SmStWVsPsnKsYlHR6PIoBL
         yc3XoN252WpH+1/i/GK9Gc/IZ8aI2prkkh30q9WtWNbh9ePpRIr7wHVC6i41e/S+hNHK
         Z7fAF+SjetdLPqtF7DpkcYSVV4Q7o0UYdQPyzY6OJ7BMdHsVnm6MdTbZP2vaOfybUrL/
         iAZHiw/dinj01a/J0DwoSnFA/tBVANCqgM1Idz7X1qTRgofYdqODYkPCU34bgygJcAY6
         OF4E+LPEXZSvM4fd5fCvV1A+cudP0Ax9Qosh+sG1X0HCP4m5YESLUCVZ0f54rqIGqnmu
         7ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LqhLdejbdawz66TXQyjGI8kKYAZiaIs0ZSG2lebOtEc=;
        b=FNVqMWKOEE5ll6S5LXxRs19EYx2YDjGU9xNtxAkCavDg5TC3GCemyaVUAwjCU6sLsy
         SaTSz9Y8Ohjp5qMhZYvkT7QrZbTxqWPld1cWjS4A6Dddc4/d+GWy5HcqMulaMmip0lde
         z80F1NuLmz93RcFxWcOq1yeZ/+5k16vepYTY+aqd3Gs+Q+DsPSpLX0o5l2dzZF1rhRTb
         TV/nsY7y2l16xOwqNqy31DMFCMe84Ox/u/VvvUg06OAwViSognx4YoWwLLhmgG8gqQm5
         QjGlKRAU+F3xQtx8s/QTWFaHx37ALJ51t/KJqUo5vLFzERp10HKxmfI/KSXrbRXOXMrv
         I1nw==
X-Gm-Message-State: ALKqPweQA980KlwEjuH4MqIyvHy56tdGhjrvpz2XQJb+z0c862c1J6Mk
        xWpHhbFbxgJXfbFRD7fvDaK+gm5SSCGIyYdr3ao=
X-Google-Smtp-Source: AB8JxZq1nFxLb7mEJ8lZ4ubHInIsBWc6Vct7Uf+pVrkPqrOPaZw7FiXVwz8RlIxekJ8y3mPGNOUTB5M0F9scfnLcj7o=
X-Received: by 2002:a5b:808:: with SMTP id x8-v6mr1620046ybp.104.1525984234730;
 Thu, 10 May 2018 13:30:34 -0700 (PDT)
Received: from 1058052472880 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 May 2018 13:30:34 -0700
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
In-Reply-To: <CAGZ79ka3kVHSZ9oG=NOvr0=KCHODngxJQLbKApDsFY=xNPhU=A@mail.gmail.com>
References: <20180510182657.65095-1-leif.middelschulte@gmail.com>
 <20180510182657.65095-2-leif.middelschulte@gmail.com> <CAGZ79ka3kVHSZ9oG=NOvr0=KCHODngxJQLbKApDsFY=xNPhU=A@mail.gmail.com>
X-Mailer: Airmail (481)
MIME-Version: 1.0
Date:   Thu, 10 May 2018 13:30:34 -0700
Message-ID: <CANw0+A_T5zDUUWznYBe0m9fkSODPnfQaK1yJKPPawHTxi9+9BQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Warn about fast-forwarding of submodules during merge
To:     Stefan Beller <sbeller@google.com>
Cc:     sandals@crustytoothpaste.ath.cx,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,


Am 10. Mai 2018 um 20:49:39, Stefan Beller
(sbeller@google.com(mailto:sbeller@google.com)) schrieb:

> On Thu, May 10, 2018 at 11:26 AM, Leif Middelschulte
> wrote:
> > From: Leif Middelschulte
>
> Hi Leif!
>
> thanks for following up with a patch!
sure, thanks for the quick review.
>
> > Warn the user about an automatically fast-forwarded submodule. The sile=
nt merge
> > behavior was introduced by commit 68d03e4a6e44 ("Implement automatic fa=
st-forward
> > merge for submodules", 2010-07-07)).
> >
> > Signed-off-by: Leif Middelschulte
> > ---
> > submodule.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/submodule.c b/submodule.c
> > index 74d35b257..0198a72e6 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -1817,10 +1817,12 @@ int merge_submodule(struct object_id *result, c=
onst char *path,
> > /* Case #1: a is contained in b or vice versa */
> > if (in_merge_bases(commit_a, commit_b)) {
> > oidcpy(result, b);
> > + warning("Fast-forwarding submodule %s", path);
> > return 1;
> > }
> > if (in_merge_bases(commit_b, commit_a)) {
> > oidcpy(result, a);
> > + warning("Fast-forwarding submodule %s", path);
> > return 1;
> > }
>
> The code looks correct, however I think we can improve it.
> (Originally I was just wondering if stderr is the right output,
> which lead me to the thoughts below:)
I=E2=80=99ve had the same thoughts about stderr. However, I thought that us=
ing a
log function named `warning` to warn the user=C2=A0would be the right choic=
e.
If anything, I thought, the warning function might need refactoring.

> Looking through the code of merge-recursive.c,
> all the other merge outputs are done via 'output()'
> that is able to buffer up the output as well as handles
> the output for different verbosity settings.
>
> So I would think we should make the output() function available
> outside of merge-recursive.c. (and rename it to a be more concise
> and descriptive in the global namespace) and make use of it.
Sure, let me know what to use instead and I=E2=80=99ll update and resubmit =
the patch.

>
> Funnily we already have MERGE_WARNING in submodule.c
> which outputs information for all the other cases. I would think
> we ought to convert those to the output(), too.
Sure, but `MERGE_WARNING` prefixes all the messages with "Failed to
merge submodule=E2=80=9C.
>
> Thanks,
> Stefan

Thank you,
Leif
