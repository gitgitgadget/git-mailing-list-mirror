Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7057202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 20:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbdJ3Uov (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 16:44:51 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:52501 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbdJ3Uou (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 16:44:50 -0400
Received: by mail-io0-f195.google.com with SMTP id f20so30217797ioj.9
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 13:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sYaf81EufUz/rpMFk76EzUv3v+AA6wfGPohPK9Mu/qU=;
        b=lwVsKrFah0FCTVA26CZLqK4YhS1EbkuBZOyB8fMKCuX8yV3QYbgyRoh9SouaSuCd+P
         OVAG23RnFdSi0+Ecbr0XNHzgRa+7YPUfbFiXdvKwb8YQQLPCBjJOilKBJe98qpMZOVkD
         fvoICFxmceq61rqLyJWSOp5UpcEPYeEg0x5CD9YPeL+5n7j7AaQQji6w5uNkAz1itp+S
         UngHJ1Jw/Ey5vcPwwPfIh6y1S8bp3YaHmSe3unKZP7dh4rRX7D4ddLBP2AXXT4uTZWsp
         NNNLKio1pZSUqCgE1fplbqPTVGHM7MJMoW53qKl/c8PMciNtPLJak06u3/5jL6hMYQRk
         IkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sYaf81EufUz/rpMFk76EzUv3v+AA6wfGPohPK9Mu/qU=;
        b=fWZD1xg8Sg/I77qdAYKV9aktMgHE5aDuJcusZv5zAnMtCP1OY3+7msFA5kOG+GcB/M
         YxnlTtzP4yy/uTNl0bAS1kxWxHl0VGvZTNeoBAAwodXtlOPAK8Wz8h551Sq4jQZ04gNM
         pmnFX/mkDtSOd472k5NZxn285tCs96TgqHTWeSKZhIME23gBVGShXs0Sb+YE+DB6cD8C
         Myo5sbKU/FRvOOowqcayYmUgHx+fWRi3ICeyzZv3lXcRMy42V2FjndK5GO/j/a1LogHG
         IpZVFCcA11llHnq3N9jTIgAjgfN2ycgF/Q43WriaqjMfcOrg7aB/CV3PfDbZ3+AZCWJn
         D82A==
X-Gm-Message-State: AMCzsaVO6qRC3KiCWgkTS4xW/VDnkeuEMOlkr89ZPcqJBZn68zb6pjOp
        1S7qPXhPJQTvnVvA3QOLO+pxPdw4GNo=
X-Google-Smtp-Source: ABhQp+SE9nPcKVOpmqWXZ+P7PqXD0AhhakoVSW1GPV2iwJ3LGEzJFt3LlHz1DAxnUqZwjUynTEiYHw==
X-Received: by 10.36.197.130 with SMTP id f124mr16250itg.99.1509396289530;
        Mon, 30 Oct 2017 13:44:49 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9c29:988d:323f:ada0])
        by smtp.gmail.com with ESMTPSA id 200sm49856itm.13.2017.10.30.13.44.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 13:44:48 -0700 (PDT)
Date:   Mon, 30 Oct 2017 13:44:47 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] diff: add flag to indicate textconv was set via
 cmdline
Message-ID: <20171030204447.GD125460@google.com>
References: <20171027222853.180981-1-bmwill@google.com>
 <20171030194646.27473-1-bmwill@google.com>
 <20171030194646.27473-4-bmwill@google.com>
 <CAGZ79kaLX881vi3MJaOCE6h=h_eRGjJ+gYCUEV-2rNSg0exFOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaLX881vi3MJaOCE6h=h_eRGjJ+gYCUEV-2rNSg0exFOw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/30, Stefan Beller wrote:
> On Mon, Oct 30, 2017 at 12:46 PM, Brandon Williams <bmwill@google.com> wrote:
> > git-show is unique in that it wants to use textconv by default except
> > for when it is showing blobs.  When asked to show a blob, show doesn't
> > want to use textconv unless the user explicitly requested that it be
> > used by providing the command line flag '--textconv'.
> >
> > Currently this is done by using a parallel set of 'touched' flags which
> > get set every time a particular flag is set or cleared.  In a future
> > patch we want to eliminate this parallel set of flags so instead of
> > relying on if the textconv flag has been touched, add a new flag
> > 'TEXTCONV_SET_VIA_CMDLINE' which is only set if textconv is requested
> > via the command line.
> 
> Is it worth mentioning 4197361e39 (Merge branch 'mg/more-textconv',
> 2013-10-23), that introduced the touched_flags?
> (+cc Michael Gruber FYI)
> 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/log.c | 2 +-
> >  diff.c        | 8 +++++---
> >  diff.h        | 1 +
> >  3 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/builtin/log.c b/builtin/log.c
> > index dc28d43eb..82131751d 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -485,7 +485,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
> >         unsigned long size;
> >
> >         fflush(rev->diffopt.file);
> > -       if (!DIFF_OPT_TOUCHED(&rev->diffopt, ALLOW_TEXTCONV) ||
> > +       if (!DIFF_OPT_TST(&rev->diffopt, TEXTCONV_SET_VIA_CMDLINE) ||
> >             !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
> >                 return stream_blob_to_fd(1, oid, NULL, 0);
> >
> > diff --git a/diff.c b/diff.c
> > index 3ad9c9b31..8b700b1bd 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -4762,11 +4762,13 @@ int diff_opt_parse(struct diff_options *options,
> >                 DIFF_OPT_SET(options, ALLOW_EXTERNAL);
> >         else if (!strcmp(arg, "--no-ext-diff"))
> >                 DIFF_OPT_CLR(options, ALLOW_EXTERNAL);
> > -       else if (!strcmp(arg, "--textconv"))
> > +       else if (!strcmp(arg, "--textconv")) {
> >                 DIFF_OPT_SET(options, ALLOW_TEXTCONV);
> > -       else if (!strcmp(arg, "--no-textconv"))
> > +               DIFF_OPT_SET(options, TEXTCONV_SET_VIA_CMDLINE);
> > +       } else if (!strcmp(arg, "--no-textconv")) {
> >                 DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
> 
> Also clear TEXTCONV_SET_VIA_CMDLINE here?
> (`git show --textconv --no-textconv` might act funny?)

Oops, thanks for catching this, I added it in the wrong place! (as you
can see below.

> 
> > -       else if (!strcmp(arg, "--ignore-submodules")) {
> > +               DIFF_OPT_CLR(options, TEXTCONV_SET_VIA_CMDLINE);
> > +       } else if (!strcmp(arg, "--ignore-submodules")) {
> >                 DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
> >                 handle_ignore_submodules_arg(options, "all");
> >         } else if (skip_prefix(arg, "--ignore-submodules=", &arg)) {
> > diff --git a/diff.h b/diff.h
> > index 47e6d43cb..4eaf9b370 100644
> > --- a/diff.h
> > +++ b/diff.h
> > @@ -83,6 +83,7 @@ struct diff_flags {
> >         unsigned DIRSTAT_CUMULATIVE:1;
> >         unsigned DIRSTAT_BY_FILE:1;
> >         unsigned ALLOW_TEXTCONV:1;
> > +       unsigned TEXTCONV_SET_VIA_CMDLINE:1;
> >         unsigned DIFF_FROM_CONTENTS:1;
> >         unsigned DIRTY_SUBMODULES:1;
> >         unsigned IGNORE_UNTRACKED_IN_SUBMODULES:1;
> > --
> > 2.15.0.403.gc27cc4dac6-goog
> >

-- 
Brandon Williams
