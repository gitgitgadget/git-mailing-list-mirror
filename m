Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32BFA1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 16:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755667AbcHXQqu (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:46:50 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:36483 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754658AbcHXQqt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 12:46:49 -0400
Received: by mail-it0-f42.google.com with SMTP id e63so221054240ith.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4HvF10Uf5bvkn70XU9nfYw4br2jqg913qV4Mxb1UDn8=;
        b=EOPPyKEV39r8wl7fTAXHcBij+14VtEnY/QLgAqoDbiURvpJlw31hmDp6ANoRyoN4Cm
         Aj2ovHP95JKHE3FlkXigzQOZN7dla5P3SFQcfD1g92Ech2LRg57yX+Us1N0v1dCsJe3G
         U1zdU1C0UVIJz0gnS48F7/gEy1KZDNZBnj3YGGDWleFpW2MA1iUnKjzH2IRIbPyxV8wi
         eEgM/VjdPXQHPXECrprjXGIcwUfWwBoq7e3ZmdKI6VQXUOf60mz0GNEv2QyzYNg1EApj
         +ZBgXtXlI3I2ITqyVv0JBfYiqsJlzTfONWwS3ZnuULj+Vklfckr1ZfnKbPpjsvtqfOmP
         XjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4HvF10Uf5bvkn70XU9nfYw4br2jqg913qV4Mxb1UDn8=;
        b=UA4rCobiuXaLnwKMXLWZznMY2h+fyrkGNcXr4PmIOs3SLbSgqEw6KnHPA55deCFL4M
         Od/DgRYoRlzdWTTuds55AAjpvpDmXK7xnIcTeDec6JBO72DIKjp2nUnU0OQKhuhoWpY2
         qTlXCrvxcFsQ11jUAlPJZCCfEQcjbHIAsLvFqpSS7H1V+IrX+a2JEE9WOh391J8CMoFj
         jjOV7DhJHSim8aboHAozai2yJCQb+NRiVxvaac2sgKRf7Bl7ieixtEQpjmAf1uHFDNYD
         lUDJ/J27ulNi3PKeyuDCyOlAJD+0MzpSaJjRjT63rIiwDiWxWMhBWW+m/E5bRMu8hAep
         OKDA==
X-Gm-Message-State: AEkoouvcTnayf2UunLdofp54RcwSrektyU4ITUHLr1ksCeHYxz7b1G7guOIOXsfaAkoTexan5iKStwTb1MsmWHap
X-Received: by 10.107.178.129 with SMTP id b123mr5317824iof.83.1472057203167;
 Wed, 24 Aug 2016 09:46:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 24 Aug 2016 09:46:42 -0700 (PDT)
In-Reply-To: <20160818140922.GA5925@sandbox>
References: <20160817204848.8983-1-sbeller@google.com> <xmqqmvkb85sw.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbb=oL7b93W-x=dxVh2aBN-H+tg9y5o4RwbepYtijQTXg@mail.gmail.com> <20160818140922.GA5925@sandbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 24 Aug 2016 09:46:42 -0700
Message-ID: <CAGZ79kYxu_x2qA9fq4qAWt7GgCY3Nz51TMGQS7EbGnbm9c+kqQ@mail.gmail.com>
Subject: Re: [PATCH] push: change submodule default to check
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 7:09 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Wed, Aug 17, 2016 at 02:14:11PM -0700, Stefan Beller wrote:
>> On Wed, Aug 17, 2016 at 2:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Stefan Beller <sbeller@google.com> writes:
> [...]
>> >> Flipping the default to check for submodules is safer
>> >> than the current default of ignoring submodules while pushing.
>> >
>> > That part of the assertion, on the other hand, is justifiable.
>>
>> ok.
>
> I also think that this is a good reason to flip the default. IMO more
> people will be annoyed by not being able to checkout a certain version
> if someone forgets to push a submodule then people deliberately pushing
> something with a submodule hash that is not on any remote.
>
> At the same time I am wondering whether it makes sense to keep this for
> a bigger version change (like 3.0) or so? Since that is were people will
> expect such changes. Not sure when 3.0 is planned though.
>
> Cheers Heiko

I guess we can postpone it until 3.0, though I currently think it is not a big
issue as it helps avoiding "bugs in your workflow".

On the other hand if you really want to push out the superproject without
the submodules, you need to adapt your behavior (i.e. set an option or
give a command line flag), and such breaking things we should delay
until 3.0.

I think I'll resend it with a proper commit message, such that we can just pick
it up when 3.0 comes around.

Thanks,
Stefan
