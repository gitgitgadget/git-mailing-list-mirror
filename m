Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CF7C202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 18:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932892AbdCISIg (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 13:08:36 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35927 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754884AbdCISIV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 13:08:21 -0500
Received: by mail-pg0-f46.google.com with SMTP id g2so11686322pge.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 10:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MlhIKavtn4F3YlECLdPBu1nIlONtpaSBVsvY4ElL0Gs=;
        b=LkZP9f6rjJI2Ii6Vbnh4E/urceU1LamJPGYXL915T7WQVNDGJGTF0jPHYSL48nHSGP
         KEe2zeF3Z4MFlAzE0UX+ZpPGTYO6A2xDgObYRP9+tZb2VQNmkJuCkvr4HipMvt5N6c8x
         T5Yzo6FYiXyFo/djreJ8rrYFRF6XWTuP2/NPi0H0eFS9RbSKPGMErCE3jbZzdDAvZTfs
         9IHX721XIAGtt5UczgUrQnSIofsjqII/XQ5xq+Kudyb5QrfJhl4wTbSy+FJOJWyuVoil
         fkJLkRxP7LemZuKbf+nNVqgNgCnW95sOKIfb4+ZLaHsG1IU1KB7AqHiDGojpqwOfa1z7
         blow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MlhIKavtn4F3YlECLdPBu1nIlONtpaSBVsvY4ElL0Gs=;
        b=CVIFM7OYaN8xQPqhXHYVBbo0I7TkybWBB/MKD2EDlXxTTanJ+7Qt9K2GseZVRfb01Q
         CSAbRyxZtmK8LJmtpfHGG+u4WkNN+r1Zy6BdJDzxMbCU0HC045T10JBnZpRktSfXemge
         0RRgb/EHFWAl/0Znf6ShJZjit+GoWrZ+Y7j2kuYWCJpIE4FomRxI5YPFTo2DdSXskUjR
         cik7CqrVWEF46vovBYMhkp2IRQhZA1Gl+GaVR353CRbZhmvT5Met5jjRWkPkfNUgZMHH
         aGm1k+2PleFHAwypSRYRSW1G3X+Z8b/bltwMEM28V3PJqjyVWbfGg+SPPO5juTlZIJqp
         Verw==
X-Gm-Message-State: AMke39mCC6i0CHB6pYENvJHpIUXauDrBkfRLf3HJvxphYxKsmqFPP8THTx4MlFW5vJLNeDbA
X-Received: by 10.84.215.155 with SMTP id l27mr19142489pli.31.1489082894861;
        Thu, 09 Mar 2017 10:08:14 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:24ad:64a3:afd2:c7bd])
        by smtp.gmail.com with ESMTPSA id e68sm13770138pfa.85.2017.03.09.10.08.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 10:08:13 -0800 (PST)
Date:   Thu, 9 Mar 2017 10:08:12 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/11] submodule update: add `--init-active` switch
Message-ID: <20170309180812.GD153031@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170309012345.180702-1-bmwill@google.com>
 <20170309012345.180702-8-bmwill@google.com>
 <CAGZ79kbyyJCZ7iP6c7RBgrv8NNSMjb9fov3eFazpOb2QL5aAcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbyyJCZ7iP6c7RBgrv8NNSMjb9fov3eFazpOb2QL5aAcg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/08, Stefan Beller wrote:
> On Wed, Mar 8, 2017 at 5:23 PM, Brandon Williams <bmwill@google.com> wrote:
> > The new switch `--init-active` initializes the submodules which are
> > configured in `submodule.active` instead of those given as
> > command line arguments before updating. In the first implementation this
> > is made incompatible with further command line arguments as it is
> > unclear what the user means by
> >
> >     git submodule update --init --init-active <paths>
> >
> > This new switch allows users to record more complex patterns as it saves
> > retyping them whenever you invoke update.
> >
> > Based on a patch by Stefan Beller <sbeller@google.com>
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> 
> 
> > @@ -568,7 +573,17 @@ cmd_update()
> >
> >         if test -n "$init"
> >         then
> > -               cmd_init "--" "$@" || return
> > +               if test "$init" = "by_config"
> > +               then
> > +                       if test $# -gt 0
> > +                       then
> > +                               die "$(gettext "path arguments are incompatible with --init-active")"
> > +                       fi
> > +                       cmd_init "--" $(git config --get-all submodule.active) || return
> 
> What happens with submodule.<name>.actives here?

Nothing?  I am still not 100% certain that we really need the
submodule.<name>.active config but it seemed like what we decided upon
last we discussed this.

Maybe we don't even need this as an option?  Maybe update should be able
to just 'update' all active submodules without having to make an
explicit call to cmd_init?

-- 
Brandon Williams
