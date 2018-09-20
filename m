Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FCCB1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 05:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbeITLfY (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 07:35:24 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:44360 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeITLfY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 07:35:24 -0400
Received: by mail-pg1-f169.google.com with SMTP id r1-v6so3868049pgp.11
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 22:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BJayoAaw6/qALc6ScvAEBz+PTBiBYrPmRUqjw2jJod4=;
        b=Ko48OD8h2t1Kqx9B/CummlXiCxlFENbH+SOhVAzCZ/2Hqdsq7BlDF6CNfnoBNNFVnb
         0sI4rXIRS8eFyd3l1iMioP6J+zQZhZIiENR5Mer3ZpN8TiRLhdGGRCG4Cui/zunJ8YMi
         A9TL0187ik5vs+57/NqQOAQZK3xYqU15TuXJZMQ74H/8EL/8mpbBr7MVMxma1L+GsTwn
         ta9NLxvbRScdUdySqwRGcKAREk2crBVRTcADBfDhEUxyxUXX7Z4C0QgFG3s9o0TpZY1m
         d9sq5HfFgCmfqP+/mXuN1VJZ70hJuomkbGsMWJmSW5QwBWS7PnxhkoIHldBbHo78V/LB
         IEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BJayoAaw6/qALc6ScvAEBz+PTBiBYrPmRUqjw2jJod4=;
        b=aYnTCJArAmIJlKg19nOQRvPQNNpwiwqFkzEiEgLSebFYbVEp5MidX3lsGbjVFkIsAG
         MC6+Y6tfl46QA8fOY3psZJwQ9JOtQFwcfUb0M3I7hPE63ZHiWGycARjFFxk7jiTBZ4le
         PuD7/AIpxxOUlPz0iv1iip+46fO06TEhEcNCYKdAnCoqP1XlKrSUxLKcxTXlXP42h97p
         7Z4HSWN8214ADWwvJYayujpFtEmjv+W4zOaU1kh6p1Wh1si//QmVtekilXM3RVXwpkLo
         AfNFxCKgfLwzZJTvazr3jx70h38TlPTfnG51DjC0hQvKNldDlt09ZaLbS/Pk3pbkpqcE
         lL+Q==
X-Gm-Message-State: APzg51Ca7ZGba3aIBz7ylDJN/1SnIEZxiHEo3Pvb9ejPT9Jt4T8zsj07
        M7ZKsiR2AVcvBubuoALvc/Iel/vahIasvgBs6TM=
X-Google-Smtp-Source: ANB0VdaOTqenS2UpQI/1p+57Q3kVBLvGV+Uw4o71FeqJAranZ9noPn67ISqc4HDduVhNE9rjvnvmNftI2QqBnohhEf4=
X-Received: by 2002:a63:b95e:: with SMTP id v30-v6mr34974658pgo.221.1537422824085;
 Wed, 19 Sep 2018 22:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <d24df21a-7ab2-84f6-8b18-83fd9c8c2b30@ramsayjones.plus.com>
 <CAN0heSpNT25PrNwdbQKZo=Q8kpSfwnzuOz34xKHtfF+Fq9ZXmg@mail.gmail.com> <89478060-85c1-416a-0ad9-54d3f8f1111b@ramsayjones.plus.com>
In-Reply-To: <89478060-85c1-416a-0ad9-54d3f8f1111b@ramsayjones.plus.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 20 Sep 2018 07:53:32 +0200
Message-ID: <CAN0heSq8U7ue-SB-1iP1ZdW2hgrR0fwuKh_q68KvJ4K1dphpCw@mail.gmail.com>
Subject: Re: [PATCH 1/9] Makefile: add a hdr-check target
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 19 Sep 2018 at 22:15, Ramsay Jones <ramsay@ramsayjones.plus.com> wr=
ote:
> On 19/09/18 18:49, Martin =C3=85gren wrote:
> > On Wed, 19 Sep 2018 at 02:07, Ramsay Jones <ramsay@ramsayjones.plus.com=
> wrote:
> >> +GEN_HDRS :=3D command-list.h unicode-width.h
> >
> > Most of the things happening around here are obvious steps towards the
> > end-goal and seem to logically belong here, together. This one though,
> > "generated headers"(?) seems like it is more general in nature, so coul=
d
> > perhaps live somewhere else.
>
> Yes, generated headers, but no, not more general. ;-)

> The 'command-list.h' is generated as part of the build
> (and so may or may not be part of the LIB_H macro), whereas
> the unicode-width.h header is only re-generated when someone
> runs the 'contrib/update-unicode/update_unicode.sh' script
> (presumably when a new standard version is announced) and
> commits the result.

Ah, I wasn't aware of how unicode-width.h works, thanks.

> Both headers fail the 'hdr-check', although both generator
> scripts could be 'fixed' so that they passed. I just didn't
> think it was worth the effort - neither header was likely
> to be #included anywhere else.

With the above background, I'd tend to agree.

> I guess I could eliminate
> that macro, absorbing it into EXCEPT_HDRS, if that would
> lead to less confusion ...

I'm just a single data point, so don't trust my experience too much.

> > Actually, we have a variable `GENERATED_H` which seems to try to do mor=
e
> > or less the same thing. It lists just one file, though, command-list.h.
>
> Hmm, GENERATED_H seems only to be used by the i18n part of the
> makefile and, as a result of its appearance in LIB_H, sometimes
> results in command-list.h appearing twice in LOCALIZED_C.

Just thinking out loud, I suppose you could use $(GENERATED_H) instead
of hard-coding command-list.h in your patch. But with the background you
explained above, I think there's a good counter-argument to be made:

When we gain new auto-generated headers, we wouldn't actually mind `make
hdr-check` failing. We'd get the opportunity to decide whether making
the new header pass the check is worth it, or whether the correct
solution is to blacklist the auto-generated header. That's probably
better than just blacklisting the new header by default so that we don't
even notice that it has a potential problem.

So I think your approach makes sense. I stumbled on the similarity of
the name to something we already have. Maybe something like

  # Ignore various generated files, rather than updating the
  # generating scripts for little or no benefit.
  GEN_HDRS :=3D ...

or a remark in the commit message, or rolling this into EXCEPT_HDRS, but
I'd be perfectly fine just leaving this as it is. Please trust your own
judgment more than mine.

Thanks
Martin
