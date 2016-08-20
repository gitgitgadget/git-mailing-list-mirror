Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF331F859
	for <e@80x24.org>; Sat, 20 Aug 2016 06:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbcHTGQg (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 02:16:36 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:34624 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbcHTGQf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 02:16:35 -0400
Received: by mail-yb0-f170.google.com with SMTP id d10so22264456ybi.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 23:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7jlRmSkkr5ik4oca0Bs55t3bjEtJfbtLw6jzwPLjBdI=;
        b=LgBWxUV2QI48yVWkwTLF25qG7ibzynQd1aiu4eIID3qrZGFH1vLj81DRmpZCk5OeWj
         GNe8GotHPk76TsMjIoeYdwZu+iT2cRD7rHoOxVPrIv7y4ajHBPmfUzADZfPGAVGLF2Ah
         KSKazT19VKuEW40RAsSm2ZF8GgfdMC+f6YiEGdxAVTqU5lGZ/+02z/Ne8lk08GLudtdr
         TaSt08uJ2NYu6EFfmzjV3b7GeKMT1EHQP2prnw5pE4iInWeO64QEM9pqSUZ5pAM3P3fl
         9l4JDB+0+lUlSBfJBtzHtmxshmh/3NPTM2REV/mDNYn2Ge7QYo9+OEFLqRx3KJaWeU0M
         UygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7jlRmSkkr5ik4oca0Bs55t3bjEtJfbtLw6jzwPLjBdI=;
        b=MXNwHcXTbFuF+CFZ2cWSbX/bOn2m3d/8fGV2bUjLA9QYAIi4V7FW1RbmTWMpGacRrn
         8+IR6sYI2BYxT8WDWr4XLEXQiWyVrochsCVnfX6Ce1xcBnYVMJQLAazcH0pDtvIJl7AW
         dVRi1Fbk+JiMznp0FGdpoCWXohqYr7x5F6EiPCr5jG+VGNlu5Df8yY5f1I5wdMlM3bvg
         m6PScTVjsdP6/db31OFBkVprh81/dTJJH790vCAriXRbIOop5Bnfyk5qQZnrGBxdpAvt
         XOz8nVjOQPm+0IhYqSbk8GpjD5Ce95wZgwvPN5c8QWy324A+G6s+tKl8YKg/OjnjDWEs
         8wgg==
X-Gm-Message-State: AEkoousF/fIaO65VVRLP1bTvJ07Zyg+I42QwM0cJAj3n79G4Q2Xr2KIiv6Hw3HMGj0zMzfOMUEZjHoV9GyavGw==
X-Received: by 10.37.97.149 with SMTP id v143mr8945357ybb.164.1471673794178;
 Fri, 19 Aug 2016 23:16:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Fri, 19 Aug 2016 23:16:13 -0700 (PDT)
In-Reply-To: <CAGZ79kZqkHO58kUvP772jfTUgyYXxYuDkgGB1sOTYYQ6nLCP4A@mail.gmail.com>
References: <20160819233432.15188-1-jacob.e.keller@intel.com> <CAGZ79kZqkHO58kUvP772jfTUgyYXxYuDkgGB1sOTYYQ6nLCP4A@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 19 Aug 2016 23:16:13 -0700
Message-ID: <CA+P7+xoazoY49cXMghVQmCd=X-aEj6xCTqQqr69zciFZAqmw_Q@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] submodule show inline diff
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 5:02 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Aug 19, 2016 at 4:34 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> -               strbuf_git_path(buf, "%s/%s", "modules", path);
>> +               /*
>> +                * Lookup the submodule name from the config. If that fails
>> +                * fall back to assuming the path is the name.
>> +                */
>> +               submodule_config = submodule_from_path(null_sha1, path);
>
> In case you need to reroll: I'd got with just "sub" as the name for
> the config object
> (that seems to be used all the time and is shorter)
>

Sure.

>
>> +               if (submodule_config)
>> +                       strbuf_git_path(buf, "%s/%s", "modules",
>> +                                       submodule_config->name);
>> +               else
>
> I do not think we want to assume the path as the name for the fallback, though.
>

I couldn't think of anything better to do.... There is no error return
flow, so just... leave it as is maybe?

> If `submodule_config == NULL` then
> a) the path/name doesn't exist in the given version.
>     (If null_sha1 is given, HEAD + working tree is assumed, whereas
>     you could also check for a specific commit of the superproject
>     with another sha1)

I can't check for a specific version here because there is no
mechanism to pass in the value we'd check it in... Maybe I need a
separate function for that to check the specific sha1 instead of using
nullsha1? But.. no I don't think that makes sense, we use the current
working tree to get the submodule and then lookup old references in
it... but if we checked an old tree it might be in the wrong path
which does us no good because the name no longer matches? Hmmm

>
> b) or the submodule config cache was not initialized
>    (missing call to gitmodules_config())
>
> c) There is no c) [at least I never came across another reason for a
> NULL return here]
>
> Using the path as the fallback is errorprone (e.g. to b. in the future
> and then you get the wrong submodule repository which is shaded by
> assuming the path and it is hard to debug later or write forward looking
> tests for that now)

Sure, but if it doesn't exist we just fail.. so what should I put in
the string? just leave it empty? The function doesn't have an error
return at the moment.

>
> Thanks,
> Stefan
