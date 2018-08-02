Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E95F01F597
	for <e@80x24.org>; Thu,  2 Aug 2018 10:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeHBMOp (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 08:14:45 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:38397 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeHBMOp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 08:14:45 -0400
Received: by mail-yb0-f170.google.com with SMTP id i9-v6so624628ybo.5
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 03:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=np75rPFSdV26L3EXQiy42ZWpzjdjP9d7sjSvppum2Nk=;
        b=Gjdbe2TSeNgNcJ7qG+KX3VeOCHjfHaScXdRGiu7va11I6AUZ3iY4gvLp7WgErmsAy7
         xCKaOVSLjMQCTRxOKr2K6v/Ho/6FPQCdTG3SrVM/PsUoPM+aaNl7y5Agn519eEKFtx+D
         8kbUBavbzy9IPPkzaTb50MESGjqGjnTLWn3O7B4UwbWY1/lTwvqHsdGD1b1WD598G3Mh
         QnhnPSjAwU8ELPDhJ3A5dmcanM6j/OdJHoS7wVO4slb2Or35SZfBUIiKOawqk7zSu/FH
         QTof2/AyLmx7fKGx2hPczEaziVTpx9T7lFIpjX4cF3BlrNMpF8fJ7ZpthLPVrgrAisrO
         7hOw==
X-Gm-Message-State: AOUpUlGGV883l5Hij43U3rhBWU0JRogzVvP/vUCDT0UczKmwPwtM5Y99
        B7AJI1cdcfYzVRzuQFwo8mgnl6s/E4fDaD4GmAk=
X-Google-Smtp-Source: AAOMgpcE7PadYPara1lznAbnkm0koaLxgwSxIgN30ylOvLzJnsWPmeGQqwkFEa+sqW2czcPzkgMnZdUYNgtZrdOy8rc=
X-Received: by 2002:a25:8b04:: with SMTP id i4-v6mr991294ybl.12.1533205453146;
 Thu, 02 Aug 2018 03:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180731173651.184716-1-hanwen@google.com> <20180731173651.184716-3-hanwen@google.com>
 <CAPig+cSbibJ7i8LwJqPe06xJObnq6dJdMUnJoC1uAg4zUQq3KA@mail.gmail.com>
 <xmqqeffi856n.fsf@gitster-ct.c.googlers.com> <CAFQ2z_PXfp60C-aiizUURjcqr-A+VJQDjMJ+fU_5DOo10x+rcQ@mail.gmail.com>
 <xmqqsh3y6jfp.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsh3y6jfp.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Aug 2018 06:24:01 -0400
Message-ID: <CAPig+cR3WdYpZftK72MKMs4BBF2ZiuO-Bm_-edJ4tr1bRQvoGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Highlight keywords in remote sideband output.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 1, 2018 at 2:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> Han-Wen Nienhuys <hanwen@google.com> writes:
> > Sorry for being dense, but do you want me to send an updated patch or
> > not based on your and Eric's comments or not?
>
> It would help to see the comments responded with either "such a
> change is not needed for such and such reasons", "it may make sense
> but let's leave it to a follow-up patch later," etc., or with a
> "here is an updated patch, taking all the comments to the previous
> version into account---note that I rejected that particular comment
> because of such and such reasons".

Right. The way to know whether or not an updated patch is warranted is
to respond to review comments, saying that you agree or disagree with
various points raised (and why), and by answering the (genuine)
questions raised during review. The outcome of the dialogue with
reviewers will make it clear if an updated patch is necessary. (It's
also a courtesy to respond to review comments since reviewing is
time-consuming business and it's good to let reviewers know that the
time spent reviewing was not in vain.)

Regarding my question about whether load_sideband_colors() can be
moved below the '!want_color_stderr(sideband_use_color)' conditional,
after studying the code further, I see that it can't be, because
load_sideband_colors() is responsible for setting
'sideband_use_color'. The fact that this code confused or left
questions in the mind of a reviewer may indicate that responsibilities
are not partitioned in the best manner, and that the code could be
structured to be more clear.

For instance, it might make sense to rip all the 'sideband_use_color'
gunk out of load_sideband_colors() and move it to
maybe_colorize_sideband(), perhaps like this:

    void maybe_colorize_sideband(...)
    {
        /* one-time initialization */
        if (sideband_use_color < 0) {
            if (!git_config_get_string(key, &value))
                sideband_use_color = git_config_colorbool(key, value);
            if (sideband_use_color > 0)
                load_sideband_colors();
        }

        if (!want_color_stderr(sideband_use_color)) {
            strbuf_add(dest, src, n);
            return;
        }
        ...as before...
    }

You may or may not agree with the above suggestion; it's good to let
the reviewer know how you feel about it.

Your follow-on comment about how Gerrit has for years used "ERROR" is
exactly the sort of information which should be in the commit messages
since it saves reviewers (and future readers, months or years down the
road) from head-scratching, wondering why the code was written the way
it was (strcasecmp() vs. strcmp(), for instance).

The more pertinent information you can say up front in the commit
message, the less likely reviewers will be confused or wonder why you
made the choices you did. My question about whether
maybe_colorize_sideband() is fed lines one-by-one or whether its input
may contain embedded newlines is a good example of how a more complete
commit message could help. As the author of the patch, you have been
working in this code and likely know the answer, but reviewers won't
necessarily have this information at hand. If the commit message says
up front that this function processes lines one-by-one, then the
reviewer feels reassured that the patch author understands the
implications of the change (as opposed to the patch author perhaps not
having thought of the possibility of embedded newlines). So, it's a
genuine question (I still don't know the answer.)
