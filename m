Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95CEC1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 19:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934363AbeFKTHs (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 15:07:48 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33728 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933183AbeFKTHr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 15:07:47 -0400
Received: by mail-yb0-f194.google.com with SMTP id x36-v6so7079061ybi.0
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 12:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc;
        bh=gmSrUOpU7oIFiZCoHw8Mi+hm98ZG53NRCvvaiUKO8fU=;
        b=GvFCUjnyhzbGmMqO9SgyrCc5bkCXCZbSGq0xHxRNQTh0J0VODzE+/ly3i5CfEYEHog
         W/tZBYcEhIFsYUhiqrBhRPJA5npCPtbhzsLt+EiRpIBma87JijDBynLaz013TP69j+mQ
         Bn93rPewdTg0OMaShZkuc334urraEz9djythEn5j81k4f8E3FeVk9UfHvBn2F3YcPwJQ
         Ob2Yl9uLeXnuj7V7FNpPGjKkCWEqW3yS8UwoQ8IQbZBZFHxq9wGtvPqrRbGFUT1tz4Pu
         N+meMFbkcP4HZrVKZmwfQlOLER+VVX0uTgYvOUdpEtVNgkAqWRINQqW1DSR9UgXWqvII
         U8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc;
        bh=gmSrUOpU7oIFiZCoHw8Mi+hm98ZG53NRCvvaiUKO8fU=;
        b=eDVv4j/CEskTIAvN2oIXVIdM9TkZFXskdh0uhyHePYBnHxVxb1iuA2Q2xi4tmMEx0K
         jwztlv0qNtP33rAmiCacVR56Vz8MSJtQYD+mhC086cowB0qN2G1jcn3P+foRtew0s2RG
         Vs1QqDRFKUqVC6Pmvt4ufCdAo4wIm3G6daSYqZljy0pZkKaY53NGPVzSQWWrniiHGVWd
         zJjAFuhc/eUKcJ08pSAZPJkI5iCZ620veLJK8C5bIBr8He2Rim4CyReoIzxWqvF/dlEy
         cm09gK/BqrcHHDguFzlWvq0J75701vp62lWYu3+PomEEnub0KZd1Re8ci3CqlH+CuODY
         g9OQ==
X-Gm-Message-State: APt69E1WYghAuVbQYrkpSN4a4QsHZuZy8XDqUJrvyBIJ/ful49t/r3DV
        X6y+dFJdgz7jqCKPbMiIRH8wcnPyZ3Yi8DhXWvU=
X-Google-Smtp-Source: ADUXVKJrf0NVxCh1xk0i/PLANdAZZ2uS6pFPYV/y9q0Sum/i+HcbWSZIQuz9MBSPcFbyM2FOC1XsQmSS9xdSg9mFZKo=
X-Received: by 2002:a25:31c3:: with SMTP id x186-v6mr249323ybx.352.1528744067291;
 Mon, 11 Jun 2018 12:07:47 -0700 (PDT)
Received: from 1058052472880 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Jun 2018 15:07:46 -0400
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
In-Reply-To: <xmqqr2ldb3oe.fsf@gitster-ct.c.googlers.com>
References: <CABPp-BEdaSVG9GGwxLwr=neWGq-vO39njC+Ri4tDmN5PPtAntg@mail.gmail.com>
 <CABPp-BEdaSVG9GGwxLwr=neWGq-vO39njC+Ri4tDmN5PPtAntg@mail.gmail.com>
 <20180611173128.9917-1-leif.middelschulte@gmail.com> <xmqqr2ldb3oe.fsf@gitster-ct.c.googlers.com>
X-Mailer: Airmail (481)
MIME-Version: 1.0
Date:   Mon, 11 Jun 2018 15:07:46 -0400
Message-ID: <CANw0+A9TAD5q6ux4sRd=L65vkqWzzapE=4nE7uSM=BH1imipsw@mail.gmail.com>
Subject: Re: [PATCH] merge-submodule: reduce output verbosity
To:     Junio C Hamano <gitster@pobox.com>
Cc:     newren@gmail.com, sbeller@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Am 11. Juni 2018 um 20:04:19, Junio C Hamano
(gitster@pobox.com(mailto:gitster@pobox.com)) schrieb:

> Leif Middelschulte writes:
>
> > From: Leif Middelschulte
> >
> > The output shall behave more similar to ordinary file merges' output to provide
> > a more consistent user experience.
> >
> > Signed-off-by: Leif Middelschulte
> > ---
> > merge-recursive.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
>
> Thanks, both. Very much appreciated.
You are welcome. Thank all of you, who participated in the discussions
about this topic, for your patience, advice, and guidance. I am sorry
it took me so long to reply and provide the patches.

Cheers,

Leif
>
> >
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index ac27abbd4..5eb907f46 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -1208,7 +1208,7 @@ static int merge_submodule(struct merge_options *o,
> > output(o, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
> > output_commit_title(o, commit_b);
> > } else if (show(o, 2))
> > - output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(b));
> > + output(o, 2, _("Fast-forwarding submodule %s"), path);
> > else
> > ; /* no output */
> >
> > @@ -1220,7 +1220,7 @@ static int merge_submodule(struct merge_options *o,
> > output(o, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
> > output_commit_title(o, commit_a);
> > } else if (show(o, 2))
> > - output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(a));
> > + output(o, 2, _("Fast-forwarding submodule %s"), path);
> > else
> > ; /* no output */
