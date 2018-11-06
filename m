Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188DC1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 16:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389192AbeKGB5X (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 20:57:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38268 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388658AbeKGB5X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 20:57:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id d10-v6so14250246wrs.5
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5NTBfHOxCPxKvYtX8dMXRchGtgISYP6Ts8a7yOCJQlI=;
        b=FICPMU5WgwwVFFhIB9+sX1+p5wSVg2lxt2cnB4lqS+R8EsiJ9LId0+kfy7qClS020U
         vFMCfpj7KBpcHj8uiPjNpyeeugC7YYXZmunqY0A5s6ecz/coyNGFOTMVR4oK/Gr8Y/3t
         r3oQolnnMeaJg8sRG4FpUXMPhAJ+6G12Wjc3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5NTBfHOxCPxKvYtX8dMXRchGtgISYP6Ts8a7yOCJQlI=;
        b=G60sTXMxf6m3oBsuA06BT6Aryajtns02ffRWEnhNKz/YMrEVQCvXemQEjwlQnJRFuF
         Sau13kjMunzv5AoRbrVIZw7KJXqA5ddJHtY9cYhmQZBBp/VbwK8CD8ZqtyBwU3sqlnFS
         quWEBOVMPD5tngO1DYL89H7iKMyQm0VKDnT0gK89PYhMrzXCaGP7/x+q+MZGMIifGs4i
         5qFeVDPkALD51I1067dLNsOOVMYBF22zuCQKUBkcNY7ev7ieL64R32t+L7EXnjDoo3df
         IcjsEHTuJlquLl/MzJEolvAAe5KNpZQyswu10KTaUHdX+aK9uLEdwH9QZLjWayZyMvjr
         205w==
X-Gm-Message-State: AGRZ1gIXZR8F/ixCsugHeBPeOy3rcphZzT4VF/irHIyxgHUX8KxzCusT
        hW9hmtueTf+qtO7Bv7nYBo4sUg==
X-Google-Smtp-Source: AJdET5dnas2m80NkkEN+/Socos5Y/OKk16sSFG9L9KFoxw0MFedJ0v+tRVm1VuQ3jt2q1wr86j2Baw==
X-Received: by 2002:adf:fb89:: with SMTP id a9-v6mr22640222wrr.219.1541521881630;
        Tue, 06 Nov 2018 08:31:21 -0800 (PST)
Received: from bivouac.eciton.net (bivouac.eciton.net. [2a00:1098:0:86:1000:23:0:2])
        by smtp.gmail.com with ESMTPSA id u14-v6sm7246855wrs.27.2018.11.06.08.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 08:31:19 -0800 (PST)
Date:   Tue, 6 Nov 2018 16:31:18 +0000
From:   Leif Lindholm <leif.lindholm@linaro.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, lersek@redhat.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: respect --stat when explicitly specified
Message-ID: <20181106163118.wkvcjvb7uxjvnryk@bivouac.eciton.net>
References: <20181106104811.14625-1-leif.lindholm@linaro.org>
 <CACsJy8AjY1-KT9x_CXuo+L3-g947OaC5Av0KwuJF-Xkz6VMiPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8AjY1-KT9x_CXuo+L3-g947OaC5Av0KwuJF-Xkz6VMiPQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 06, 2018 at 04:56:11PM +0100, Duy Nguyen wrote:
> On Tue, Nov 6, 2018 at 11:48 AM Leif Lindholm <leif.lindholm@linaro.org> wrote:
> >
> > Commit 43662b23abbd
> > ("format-patch: keep cover-letter diffstat wrapped in 72 columns") made
> > format-patch keep the diffstat to within 72 characters. However, it does
> > this even when --stat is explicitly set on the command line.
> >
> > Make it possible to explicitly override the new mechanism, using --stat,
> > matching the functionality before this change. This also matches the
> > output in the case of non-cover-letter files.
> >
> > Cc: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> > Cc: Junio C Hamano <gitster@pobox.com>
> > Reported-by: Laszlo Ersek <lersek@redhat.com>
> > Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> > ---
> >
> > Note:
> > In TianoCore we have LotsOfGloriousFilesNamedInReallyLongCamelCase, so
> > our official submission guidelines specify the use of --stat.
> >
> >  builtin/log.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/log.c b/builtin/log.c
> > index 061d4fd86..07e6ae2c1 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -1009,7 +1009,8 @@ static void show_diffstat(struct rev_info *rev,
> >
> >         memcpy(&opts, &rev->diffopt, sizeof(opts));
> >         opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
> > -       opts.stat_width = MAIL_DEFAULT_WRAP;
> > +       if (rev->diffopt.stat_width == -1)
> 
> I don't think we get -1 here when stat_width is not defined. The
> "undefined" value is zero but I'm pretty sure we get MAIL_DEFAULT_WRAP
> in here unless you specify --stat.

From what I could tell, if nothing is specified on command line,
rev->diffopt.stat_width is set to -1 at this point (I assumed by
rev->cmd_log_init_defaults(), but didn't go digging).

The patched version certainly gives the <= 2.16.* behaviour with
--stat and still restricts stat lines to 72 characters without.

> So I think you can just drop the below assignment. But if you want to
> be on the safe side, check for zero stat_width instead of -1 and set
> MAIL_DEFAULT_WRAP.
> 
> > +               opts.stat_width = MAIL_DEFAULT_WRAP;
> 
> How about a test to make sure this will not be broken in future?

Sure. Only today was the first time I had a look at the git sources,
so some guidance would be most appreciated.

Should I add a function to t/t4014-format-patch.sh and just put
something longer than a/file for the expect template?

/
    Leif

> >
> >         diff_setup_done(&opts);
> >
> > --
> > 2.11.0
> -- 
> Duy
