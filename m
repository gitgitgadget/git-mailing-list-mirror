Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9FF61F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeHMUpL (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 16:45:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39777 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729835AbeHMUpL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 16:45:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so9732083wmq.4
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=07joYg6fa94CrR5UkeztM9Nsgdehxzl4CtRoHNlJ5Q0=;
        b=IUFfd4Qk5jeaw008CA4AXXwkmG/ZUF6gyzoEsYr22PIbm3+ygSTVzEW7Y+DHCO760/
         tWfFz8p1CDah6+QE+Cc6I5LPbtGbWWH1+wlh0NQhkSaijlEGKhQwxyrU4OrIxaDnf9Iz
         WCHU0QfJbGlQWwpC4icNTSVxz4yWy2tlODb1Ms+bAdbyP6If2gEQ1xqJ+V6pTLTl10qO
         lE++gPgsykmRMktnamWgrti1DfA9dnR2CcLG49jX1QLlD8XIr+lv4nUeyZUgEQlpSSbM
         pK6X7+yvi1z4kaJzc2p9xARB0KQVxAy7Cbyxq51s9BPVn9G5EqGEl6h/T1ZqT3siVjW8
         b2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=07joYg6fa94CrR5UkeztM9Nsgdehxzl4CtRoHNlJ5Q0=;
        b=O/prMvXKOSXuFw+Ovl/YXAtmUeZWTPQekW1BR/Ap5zT3KdA7wh7pKR+KhmnDQTJ1Ht
         fSoggyMuO7bG+1MsR8jPpM4CF45cD6PP0r4N6sxWdT6plt7W4Tps5KLIjjjM1BYRpFV6
         r8lUWzcqbUPcMmipsi6EzsSHxMQxKEkwMCyp2ADH/COBPM/uC+eH8Ej5tZOpddEm8TFC
         pgXlM99vM2cz6+OcohxHZVMsY8cE9B3uV97F9fc58K9YkoOcn5K+uv5i84zgIvxn1f2e
         W8vMy+D8Oed1mNsK1mJmVLa4uR6PRgG0zrt6Kpm7G5wULRmYPc9NHKWS2HDicnkQrIu+
         pCOw==
X-Gm-Message-State: AOUpUlGWNWyE4KakZaEh8K9O6ck5AON2x/y546mvZqIj+vnx07NOmZrz
        8zoJjre4gQYWaAnsfX1ISwU=
X-Google-Smtp-Source: AA+uWPyN7tngB+07IL13AfjWAwBPZ6ZIsugzLSZ3/tu2a18/x8sMfRlMmWWRbup0Hr1O32VkUKvTKQ==
X-Received: by 2002:a1c:28c2:: with SMTP id o185-v6mr8887789wmo.40.1534183313086;
        Mon, 13 Aug 2018 11:01:53 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id 66-v6sm22077703wmw.34.2018.08.13.11.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 11:01:51 -0700 (PDT)
Date:   Mon, 13 Aug 2018 19:01:50 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 05/21] range-diff: also show the diff between patches
Message-ID: <20180813180150.GC13316@hank.intra.tgummerer.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
 <pull.1.v5.git.gitgitgadget@gmail.com>
 <9e1e660077d41c479ae46eb07371204c01dff4cd.1533939264.git.gitgitgadget@gmail.com>
 <20180812214741.GB13316@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1808131135290.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808131135290.71@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/13, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Sun, 12 Aug 2018, Thomas Gummerer wrote:
> 
> > On 08/10, Johannes Schindelin via GitGitGadget wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > [...]
> > 
> > I don't think this handles "--" quite as would be expected.  Trying to
> > use "git range-diff -- js/range-diff-v4...HEAD" I get:
> > 
> >     $ ./git range-diff -- js/range-diff-v4...HEAD
> >     error: need two commit ranges
> >     usage: git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>
> >        or: git range-diff [<options>] <old-tip>...<new-tip>
> >        or: git range-diff [<options>] <base> <old-tip> <new-tip>
> > 
> >         --creation-factor <n>
> >                               Percentage by which creation is weighted
> >         --no-dual-color       color both diff and diff-between-diffs
> > 
> > while what I would have expected is to actually get a range diff.
> > This happens because after we break out of the loop we don't add the
> > actual ranges to argv, but just skip them instead.
> 
> Ouch, good point.
> 
> > I think something like the following should be squashed in to this
> > patch.
> > 
> > --->8---
> > diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> > index ef3ba22e29..132574c57a 100644
> > --- a/builtin/range-diff.c
> > +++ b/builtin/range-diff.c
> > @@ -53,6 +53,11 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
> >                 else
> >                         i += c;
> >         }
> > +       if (i < argc && !strcmp("--", argv[i])) {
> > +               i++; j++;
> > +               while (i < argc)
> > +                       argv[j++] = argv[i++];
> > +       }
> >         argc = j;
> >         diff_setup_done(&diffopt);
> 
> I do not think that is correct. The original idea was for the first
> `parse_options()` call to keep the dashdash, for the second one to keep
> the dashdash, too, and for the final one to swallow it.
> 
> Also, if `i < argc` at this point, we already know that `argv[i]` refers
> to the dashdash, otherwise the previous loop would not have exited early.
> 
> I went with this simple version instead:
> 
> 	while (i < argc)
> 		argv[j++] = argv[i++];

Right, that's much better, thanks!

> Thanks!
> Dscho

