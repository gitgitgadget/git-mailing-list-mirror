Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 620C02035A
	for <e@80x24.org>; Tue, 11 Jul 2017 19:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933615AbdGKTOB (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 15:14:01 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36362 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932802AbdGKTOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 15:14:00 -0400
Received: by mail-pg0-f44.google.com with SMTP id u62so693847pgb.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 12:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iYeKwwq/L70Wy8ZXHlzymUV06A+SWHjpLHo8uFdJr5w=;
        b=aeFPe5Bi8s9JwDN5OTot1JXIeqsHhPEirlz2P2XBfNxvEJ2KGx04Kv8O1NI9SY++gk
         0vIN/brjvIOBgRSpNivMhb9Q3GXDpa0VsEb6wuiwlRzhgjuKhfzM6+C0Vl0KwRMIm9Cr
         Anau7F8yZ6mkGiAVUpwUCAG3VLmLwwYRdnLU2CNT/7keQAWMBX0/+ry6h0Svpjn1j4df
         swuBxK5FV6d18zCKTse6ndDb+je0VIZ4FyzKk/iL93YMY000+PMgn2cnFFFb+fH1OsV5
         wvjYO9mMfHj+boRI1WaIKuBXfnv+Ky/FX/mCa3KDy7OAAcRhcpKhFVdHXiqhK9MTksai
         +TTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iYeKwwq/L70Wy8ZXHlzymUV06A+SWHjpLHo8uFdJr5w=;
        b=kUtpjZJKIm9ckbRbjap2w0Bwg1vZ6UHyO8BzYX7LaoflvFQaDSSH2iSAYXzCxL/Ez2
         4zB34YPmPR18GrfxsAYh3i9Vth1ndZ9iaFA9gXAjHVXxwA81muGivtm62to97HfJ7dpX
         coQNyaGn/VA2nZ9ULxOntRo824J5G7InM75gH2yRAaIz/G0sznRdw/v1yTY2oRIbGCwx
         U4Z2BSNZWooL1ewkNr6qMaq6YjEPIY7weIGo+d4CnWpUqzfLHupcITgfzKJxT5g7aEQ/
         ke48nEQtmPkyR9T8VTzcWS6UJYAuLhIrIWJ1KYXvxsgioK469fKwGGh6NjMtnKuUJk+3
         O/hA==
X-Gm-Message-State: AIVw111fTD1+jfj28aWXyGMh6esiMY2i/Cpd0hSE5hiQLYFI4Ym0QPhu
        bBfpdznjXzs0IdpHZCKrW5YSOYB3WlgS
X-Received: by 10.84.232.74 with SMTP id f10mr1486412pln.154.1499800440133;
 Tue, 11 Jul 2017 12:14:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Tue, 11 Jul 2017 12:13:59 -0700 (PDT)
In-Reply-To: <20170711190846.jr53xhwa42uz4ky2@sigill.intra.peff.net>
References: <alpine.DEB.2.00.1707111541150.18163@ds9.cixit.se>
 <20170711175342.mllx7efdsqlzv5lo@sigill.intra.peff.net> <CAGZ79kbQsRQaHjRccs-0jkYkfhBwU-gX-M3A9sP4hqTtqqpFYw@mail.gmail.com>
 <20170711190846.jr53xhwa42uz4ky2@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Jul 2017 12:13:59 -0700
Message-ID: <CAGZ79kbL=Ry_6L9iJw1GQA39gdPsS=twoJFpKPc3ZP+M2saoWA@mail.gmail.com>
Subject: Re: git config --help not functional on bad config
To:     Jeff King <peff@peff.net>
Cc:     Peter Krefting <peter@softwolves.pp.se>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 12:08 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 11, 2017 at 12:05:01PM -0700, Stefan Beller wrote:
>
>> > diff --git a/builtin/help.c b/builtin/help.c
>> > index 334a8494a..c42dfc9e9 100644
>> > --- a/builtin/help.c
>> > +++ b/builtin/help.c
>> > @@ -273,7 +273,7 @@ static int git_help_config(const char *var, const char *value, void *cb)
>> >         if (starts_with(var, "man."))
>> >                 return add_man_viewer_info(var, value);
>> >
>> > -       return git_default_config(var, value, cb);
>> > +       return 0;
>>
>> Instead of ignoring any default config, we could do
>>
>>     git_default_config(var, value, cb);
>>     /* ignore broken config, we may be the help call for config */
>>     return 0;
>>
>> I looked through git_default_config which seems to only die
>> with useful error messages for compression related settings,
>> but these we may want to convert to errors instead of dies,
>> when going this way.
>
> There are other die calls hidden deeper. For instance:
>
>   $ git -c core.ignorecase=foo help config
>   fatal: bad numeric config value 'foo' for 'core.ignorecase': invalid unit
>
> Those ones are hard to fix without changing the call signature of
> git_config_bool().

Good point. While looking at it, parse_help_format can also die,
so building a safe git help config is hard:

    git config --global help.format foo
    # everything is broken, how do I fix it?
    git help config # breaks, too, for the same reason as you outlined :/
