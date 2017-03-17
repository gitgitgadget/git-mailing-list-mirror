Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2291D20951
	for <e@80x24.org>; Fri, 17 Mar 2017 21:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdCQVzv (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 17:55:51 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34420 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbdCQVzu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 17:55:50 -0400
Received: by mail-pg0-f48.google.com with SMTP id 21so16004262pgg.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QjvL6kx22OMN5NU0gGyWUC67zIofqSeLFNLjfLpCSU0=;
        b=Mqqr+L5vnX1StLljqYECoNARhBy0Cp67t89voSrwTX7TH+OueFkV7O6Npo4AyDZTrq
         4dFl11Rd0eN8KwNppwesFdNbcr6X8h5ngBx0NaPw3YvchGMHNrRKTmfvPcigbHJJ1dft
         QCABVF4hh/XeW1mupCSeWhhexZ6KkWooN//Q1y6AmrARy3dIzNgBNw9ia2QCWhdEdzbL
         3AEbVlL0hh0wDRhRn6aksca2H9VDJlaEavxhZwRY2tUA7JRcM4wXnjgg44Ur4Pwlc4aI
         /S7CCwwh75e9mjpuQTm0DwKzGEKUMJ6tMLm7B9XEDZuUJtqWuC+v5gf8I9TyN910ebl7
         0GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QjvL6kx22OMN5NU0gGyWUC67zIofqSeLFNLjfLpCSU0=;
        b=YwtraoP+GP289t23HCIMxu9+47u8O+A2Kp1dFBX++/DXgy7vU+CXQ2sDoVsY4mVF1C
         o4u8cNGZZiU2J3k52h4ZJn4ln1lenA1muS3jG7VIxoObkMWpRnhBMU6qUJV4rI4oNDCV
         G8geU6IPnCfdsL/BD/tIyUVsElSbUrCyUPG5Pj7qqlGX6/PWMwWigRJE3rcjMD7qI4wA
         81KtcVIcD7xuhYcaMZKeErrldWs6vhenaOMEiDyQLv6y6TfDWVJSo4KEbGOgEXKAVAGc
         BB/rwYQ/Wq6AP8aa3ZnysMWlib9PXrWSAVzevVvx15yOd7Npm/dYd5wA6n2JkyEaG+AA
         U63A==
X-Gm-Message-State: AFeK/H3nx0OAl09/b3omf4FE2FKa1kcFMUca/qPxr7I8m4i/vSiSGw5h2JyxgZlQR0C7fS2M
X-Received: by 10.99.156.2 with SMTP id f2mr18911799pge.189.1489787749025;
        Fri, 17 Mar 2017 14:55:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c001:d329:ba91:25ca])
        by smtp.gmail.com with ESMTPSA id a77sm18614193pfl.91.2017.03.17.14.55.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 14:55:48 -0700 (PDT)
Date:   Fri, 17 Mar 2017 14:55:46 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 09/10] submodule--helper init: set
 submodule.<name>.active
Message-ID: <20170317215546.GC63813@google.com>
References: <20170313214341.172676-1-bmwill@google.com>
 <20170316222952.53801-1-bmwill@google.com>
 <20170316222952.53801-10-bmwill@google.com>
 <CAGZ79kbUC+R1bB64N=wQZrjxdTfA5OzC-i9sU0ymHtKgRVPu=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbUC+R1bB64N=wQZrjxdTfA5OzC-i9sU0ymHtKgRVPu=w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17, Stefan Beller wrote:
> On Thu, Mar 16, 2017 at 3:29 PM, Brandon Williams <bmwill@google.com> wrote:
> > When initializing a submodule set the submodule.<name>.active config to
> > true if the module hasn't already been configured to be active by some
> > other means (e.g. a pathspec set in submodule.active).
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/submodule--helper.c |  7 +++++++
> >  t/t7400-submodule-basic.sh  | 11 +++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index e95738b42..a574596cb 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -361,6 +361,13 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
> >                 die(_("No url found for submodule path '%s' in .gitmodules"),
> >                         displaypath);
> >
> > +       /* Set active flag for the submodule being initialized */
> > +       if (!is_submodule_initialized(path)) {
> > +               strbuf_reset(&sb);
> > +               strbuf_addf(&sb, "submodule.%s.active", sub->name);
> 
> In case a reroll is needed, you could mark this location with
> 
>     /*
>      * NEEDSWORK: in a multi-working-tree world we need to set
>      * this per-worktree here.
>      */

I'll add this here and where this happens in clone.

-- 
Brandon Williams
