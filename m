Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE29F1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 15:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbeGaRhW (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 13:37:22 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42476 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbeGaRhV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 13:37:21 -0400
Received: by mail-ua0-f194.google.com with SMTP id w7-v6so10612966uan.9
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPiPBqbTbgoHcHbDkqytuHHothNlRGS7gGUe9wk3pMU=;
        b=WQ+4j0FzD1EvI2mpHIykMU6ftHdOxuEwF5hiLUEW39LsIdjoD1kVBHFPR9YrNOhXdL
         Cm4ahWn1nwDFmsf+zpg5Ih/q06yi6fv01cvoD+8fN6yX51ebfquwYfcWxK0nIqGxTUa3
         Z/ldAV9pKiuIRJ0rFvcu0EFN84INGQsD22V1w5zeElw0AsTymk/1zDLniiEnqr4c/7GB
         xTGQPRhuzw2FSaB6qa24WmkPv2tl/N4hqMCbTKqxmSirRnHwOHniGcgMBOS8+bElhSYZ
         ZzPrhv7+0ubtV179/SSedXny+549JKv2xhdCM4PYYPQMWij0RdJu6ZuOQ2a3N8CXNT21
         rY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPiPBqbTbgoHcHbDkqytuHHothNlRGS7gGUe9wk3pMU=;
        b=Z2xqYs4UAyXaB8r/UhT8sJUiANUEtpNkxSP4KqMCg7Nv/cvfMa4ARPet7G9wVFeYqD
         WONGqr4KqEmDPGQyClbYe2t6phK2t19hXMy0YbuLgf8CPTQ3ClS7URJon7X+kDl/bD6s
         NtGPH2mbPJ29uBsC0tAo+NcBssV0b4xMFNcrHUeOFlrJrmu2+53wURJ4TbsspVV1C3VY
         driQJAf2+1vkEO0j//Zo4mxjpK7aHzkCVHgvMmpm4ukCTZY6VapLFqSpUp+aFxiI23VA
         6SBMUGXJL87nJdofuckU7LY2klLVz9lWz5BPB9u1EXNmQTRxDM9bnZ1sjJov2qF85c92
         O+2w==
X-Gm-Message-State: AOUpUlHtMy1MUuqQy3ypm+yT9feoKa6Ljm9mSLXlLueHMKPYxLGXfRtV
        gVekzYt605jD4gphpfVuzDTdngUHkkMMRfFWXcej9A==
X-Google-Smtp-Source: AAOMgpddrkHseo0ZUN/mq6wn6zxxPkWRvKiYtPQGqIViOkzDHD7Tdgt1AWDZ1IRPHYab2gKC2yeZswGDVmzkv9B4Myg=
X-Received: by 2002:ab0:60ae:: with SMTP id f14-v6mr15651043uam.153.1533052583061;
 Tue, 31 Jul 2018 08:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
 <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com> <xmqqtvofcsgc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvofcsgc.fsf@gitster-ct.c.googlers.com>
From:   George Shammas <georgyo@gmail.com>
Date:   Tue, 31 Jul 2018 11:56:11 -0400
Message-ID: <CAF1Ko+HAusyCOaTWT-cT0DW0MoJdDv3RdoW+U25QRqaacCAh5w@mail.gmail.com>
Subject: Re: git merge -s subtree seems to be broken.
To:     gitster@pobox.com
Cc:     l.s.r@web.de, git@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000a2aedb05724d9eb2"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000a2aedb05724d9eb2
Content-Type: text/plain; charset="UTF-8"

While debugging this, I did try -X subtree=src/ however the effect was the
same.

On Tue, Jul 31, 2018 at 11:53 AM Junio C Hamano <gitster@pobox.com> wrote:

> George Shammas <georgyo@gmail.com> writes:
>
> > Bisecting around, this might be the commit that introduced the breakage.
> >
> > https://github.com/git/git/commit/d8febde
>
> Interesting.  I've never used the "-s subtree" strategy without
> "-Xsubtree=..." to explicitly tell where the thing should go for a
> long time, so I am not surprised if I did not notice if an update to
> the heuristics made long time ago had affected tree matching.
>
> d8febde3 ("match-trees: simplify score_trees() using tree_entry()",
> 2013-03-24) does touch the area that may affect the subtree matching
> behaviour.
>
> Because it is an update to heuristics, and as such, we need to be
> careful when saying it is or is not "broken".  Some heuristics may
> work better with your particular case, and may do worse with other
> cases.
>
> But from the log message description, it looks like it was meant to
> be a no-op simplification rewrite that should not affect the outcome,
> so it is a bit surprising.
>

--000000000000a2aedb05724d9eb2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">While debugging this, I did try -X subtree=3Dsrc/ however =
the effect was the same.</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r">On Tue, Jul 31, 2018 at 11:53 AM Junio C Hamano &lt;<a href=3D"mailto:gi=
tster@pobox.com">gitster@pobox.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">George Shammas &lt;<a href=3D"mailto:georgyo@gmail.com" targ=
et=3D"_blank">georgyo@gmail.com</a>&gt; writes:<br>
<br>
&gt; Bisecting around, this might be the commit that introduced the breakag=
e.<br>
&gt;<br>
&gt; <a href=3D"https://github.com/git/git/commit/d8febde" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/git/git/commit/d8febde</a><br>
<br>
Interesting.=C2=A0 I&#39;ve never used the &quot;-s subtree&quot; strategy =
without<br>
&quot;-Xsubtree=3D...&quot; to explicitly tell where the thing should go fo=
r a<br>
long time, so I am not surprised if I did not notice if an update to<br>
the heuristics made long time ago had affected tree matching.<br>
<br>
d8febde3 (&quot;match-trees: simplify score_trees() using tree_entry()&quot=
;,<br>
2013-03-24) does touch the area that may affect the subtree matching<br>
behaviour.<br>
<br>
Because it is an update to heuristics, and as such, we need to be<br>
careful when saying it is or is not &quot;broken&quot;.=C2=A0 Some heuristi=
cs may<br>
work better with your particular case, and may do worse with other<br>
cases.<br>
<br>
But from the log message description, it looks like it was meant to<br>
be a no-op simplification rewrite that should not affect the outcome,<br>
so it is a bit surprising.<br>
</blockquote></div>

--000000000000a2aedb05724d9eb2--
