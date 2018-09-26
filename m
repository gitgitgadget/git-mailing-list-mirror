Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1274E1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 16:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeIZWcI (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 18:32:08 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37582 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeIZWcI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 18:32:08 -0400
Received: by mail-it1-f193.google.com with SMTP id m9-v6so3647785ita.2
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxKiYRJ7ef42/v6kQCHIRsnwo/+flDLxbuj2b/eMK7k=;
        b=NjaMAWbMGbkv2P7MGkBre6FXGYdEPSv0mZLWgBLDn3owkD+TVOveOyCdqQAkHqvmew
         1phcKbBRsTyIh9dJekA3VSwZbMyMWez18mDNNa6vmH/zIEVJ5vqaA7BmwCegcN20liw/
         kl9t9Gx06cTjd+suCNYlrVmn3Ia/AtM2/AgKSiduKfgl7hVP1WKUKWSwx3VTBxWO2M0B
         NAm885+chaiVi11qfLLxEPNQfh9TJQSsSSZgS0OYc3QPeEqr8SupY2kUE2M1w9ukb09z
         nyq3a2J9TvzvSCMdk5XkiujaWSei0tlv3BoqVWUfo19onBE6ymslazEOsOi+25xmXA+W
         XFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxKiYRJ7ef42/v6kQCHIRsnwo/+flDLxbuj2b/eMK7k=;
        b=AH2iEOq7+t7WH77xb5qV/D8QOtdDCpImgWpwsWRn8Ef2BCr87jHa4QvgDVBuNy5D6c
         yFrICXiPSKUaxJRDhJHx+0vjXXRcVerZ5c01n7u1W4ibSbpQTpArupO593bJ8ymz6LW9
         XDWez38gVE9qVsh8pfZZA+6bTi8M7IgWSGcUzigHSUIb37diA0qBXz29n0XzPezsxmQm
         81XEEzu+idPxukvhfCExl/NE35LhmPU2XLi19Dfvj1/qXyDO2cMPucsOCzbPs5PuIiZ8
         m5M3tSiZnYVSC6lInCBRqnB20sGfeLPhng9XdkiJPR6CsCw2Q26QyvXA8bSCW40yAgtr
         kqVw==
X-Gm-Message-State: ABuFfohgzbKcmRmig8UQKnm3Vb+g1pWpQE5x4adm7XEyO2hNVOLhP66D
        FSqkr1Lc7h1oUUoq6RgT9JTkNmT/hygzByXH1JE=
X-Google-Smtp-Source: ACcGV61oeeb94bwqXpvvM1vXxB9NmfNmvyit/VZrcElKqWlS2YO8GWneX/dQxp6NXKM7zdefzO2ZXrNI6qM/mpULNeQ=
X-Received: by 2002:a02:49d7:: with SMTP id p84-v6mr6314381jad.97.1537978706986;
 Wed, 26 Sep 2018 09:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180922174707.16498-1-pclouds@gmail.com> <20180924181927.GB25341@sigill.intra.peff.net>
 <xmqq4leesjdc.fsf@gitster-ct.c.googlers.com> <CACsJy8D1EMCqvBdxbta4oocMF33jwDf1=opXwZ0aRN7LYu=JXg@mail.gmail.com>
 <20180925174451.GA29454@duynguyen.home> <20180925205446.GB21956@sigill.intra.peff.net>
In-Reply-To: <20180925205446.GB21956@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 26 Sep 2018 18:18:00 +0200
Message-ID: <CACsJy8DCdwAre9dhwwC_5STNq_BuWahv-9Hoim+YUtVssJbzdQ@mail.gmail.com>
Subject: Re: [PATCH] git help: promote 'git help -av'
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 10:54 PM Jeff King <peff@peff.net> wrote:
> Mentioning aliases seems reasonable to me. The definitions of some of
> mine are pretty nasty bits of shell, but I guess that people either
> don't have any ugly aliases, or are comfortable enough with them that
> they won't be scared away. :)

I have one with a very long pretty format for git-log. Well, you wrote
your aliases you learn to live with them :) We could certainly cut too
long aliased commands to keep the listing pretty, but I don't think we
should do that until somebody asks for it.

> > -- 8< --
> > @@ -53,7 +52,6 @@ static struct option builtin_help_options[] = {
> >                       HELP_FORMAT_WEB),
> >       OPT_SET_INT('i', "info", &help_format, N_("show info page"),
> >                       HELP_FORMAT_INFO),
> > -     OPT__VERBOSE(&verbose, N_("print command description")),
> >       OPT_END(),
> >  };
>
> Would we want to continue respecting "-v" as a noop? I admit I did not
> even know it existed until this thread, but if people have trained
> themselves to run "git help -av", we should probably continue to give
> them this output.

-v was recently added just for the new "help -a" in May 2018. I think
it's ok to get rid of it. Memory muscles probably take a couple more
months to kick in.
-- 
Duy
