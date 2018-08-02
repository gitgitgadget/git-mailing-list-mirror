Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DD1A1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 11:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbeHBNhU (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 09:37:20 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:54343 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbeHBNhU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 09:37:20 -0400
Received: by mail-it0-f45.google.com with SMTP id s7-v6so2754139itb.4
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 04:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K8HGph4EDAEibI4kNlUpFwAyaUTr4tgltFYbk1u6ykY=;
        b=BVAftshE5pLnGNtiPA1Njubb6EPxat9hHWoxyrYyL5Sgqx49hcLIyuPMIhEAVYVDam
         mLRxSa5/5TXcMXKqB00iYu33aFRtkBcrldBVmZIa6HQ0gObgeqSiWQDZ9CUjHpmuhxGh
         tZuN+/DY7SFulPtHr80q8WJRxVVJYAIfGcJzcQOoMlff+DMDePtGTvE8ZS/VXes9mQq/
         f/NS64cXu7t1j64c24mVqUG1UwWFzZqGB0ikVM+cL7mNgcnlelMf1jjeycjEDIRpmkTd
         tA+Bd3PVV81tj80zEFLTa50GkNzGCBww+ba01kMEvOcWSsS0r1xSp/GgREcfsI20Mpgw
         UGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K8HGph4EDAEibI4kNlUpFwAyaUTr4tgltFYbk1u6ykY=;
        b=jKCANow+F2EvbMZEs2pQJxjxUPDbsJWTbcOHSheF8PAFq+NM+aaapqT/AM5OcE9/OO
         Q1suJK3qJxNArkOZIwgX0Jc9qBPLjgCGeGIgc2dVH4UzwS87KnVGpWmAXOqYFuMZtcJl
         oRKnP64OzJGdhwjvDQ+DodUbcRBRCeN9ELyHU+YIf6i60YCx0kDZpoSObitJghstWczg
         zDtG7MQ21Ps1ZswIr2KjnjhNfnNF3AwH3U6rRg7RsqOzAgwvr09ROIW1isG03EKDUicV
         48sPC2IdVgdoio+6uXzP84WBPbni+2rEyuo0gr5ZKVsNKa2LYuajr651w7TbzXZSQ+vi
         Xm4Q==
X-Gm-Message-State: AOUpUlE4/5dW7+yW2AZrXpTtBsnaX973tuF/c09RTf4avuZPp1m629wi
        0IZWheugKICwRu6vaUhSVMAOYXHRlzWSDaunXd8ZWw==
X-Google-Smtp-Source: AAOMgpc+MEQQFODsg/J5oQCT5F62gz/PzuAH+mBW5VkUnQ5aOXf/+4zig2gVdtgutW+hQGr4O7rg58MqmkGAEvzFqJ4=
X-Received: by 2002:a02:1cd:: with SMTP id 74-v6mr1956878jak.83.1533210391781;
 Thu, 02 Aug 2018 04:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180731173651.184716-1-hanwen@google.com> <20180731173651.184716-3-hanwen@google.com>
 <CAPig+cSbibJ7i8LwJqPe06xJObnq6dJdMUnJoC1uAg4zUQq3KA@mail.gmail.com>
 <xmqqeffi856n.fsf@gitster-ct.c.googlers.com> <CAFQ2z_PXfp60C-aiizUURjcqr-A+VJQDjMJ+fU_5DOo10x+rcQ@mail.gmail.com>
 <xmqqsh3y6jfp.fsf@gitster-ct.c.googlers.com> <CAPig+cR3WdYpZftK72MKMs4BBF2ZiuO-Bm_-edJ4tr1bRQvoGQ@mail.gmail.com>
In-Reply-To: <CAPig+cR3WdYpZftK72MKMs4BBF2ZiuO-Bm_-edJ4tr1bRQvoGQ@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 2 Aug 2018 13:46:20 +0200
Message-ID: <CAFQ2z_NOxB4E13hoUPwoP+kZ0rVofCf3mb+bdopyTLnzWu1kPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Highlight keywords in remote sideband output.
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 12:24 PM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> On Wed, Aug 1, 2018 at 2:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Han-Wen Nienhuys <hanwen@google.com> writes:
> > > Sorry for being dense, but do you want me to send an updated patch or
> > > not based on your and Eric's comments or not?
> >
> > It would help to see the comments responded with either "such a
> > change is not needed for such and such reasons", "it may make sense
> > but let's leave it to a follow-up patch later," etc., or with a
> > "here is an updated patch, taking all the comments to the previous
> > version into account---note that I rejected that particular comment
> > because of such and such reasons".
>
> Right. The way to know whether or not an updated patch is warranted is
> to respond to review comments, saying that you agree or disagree with
> various points raised (and why), and by answering the (genuine)
> questions raised during review. The outcome of the dialogue with
> reviewers will make it clear if an updated patch is necessary. (It's
> also a courtesy to respond to review comments since reviewing is
> time-consuming business and it's good to let reviewers know that the
> time spent reviewing was not in vain.)

Sure. My doubt is that it's hard to tell what the state of my patch is
at any given time.

--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
