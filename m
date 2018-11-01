Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6CA1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 14:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeKAXdX (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 19:33:23 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44209 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbeKAXdX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 19:33:23 -0400
Received: by mail-wr1-f47.google.com with SMTP id d17-v6so19969715wre.11
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AKZ74aGV2WI834FP6EDwAJ6heUMfsbH84jNJD25e598=;
        b=ENxpccncOprzIvOmiZIM9gBZFUsmr3ECIdaChPowdsWo0FPOh8SJpNkoqdUFAHDYta
         neB2IgN2nB/HIT1uCX8cxzH23fPSi3FTzdlOy9zEEz/k5cw5tGgA/WJMoS6nW2GMwnlU
         HNFEOI2ctdLBWHMQVc76SxedBXrJ9KcdLIxd7fzLxlQudacUZfeLxgsLanyGFdhQc/Yn
         /tb4v4Uiyx75av3RdSKvaucJ1eOGUzVa//rUvYjhi3Jvu/rAmvNyWwWJkdtUB/uwbc/q
         TK8G5B3tQBi0kYSzvsazjM1hUGBr5LEoWPTdmBUAxI1o3D20LD+jjbTBN2yrNehaE4Ks
         6RYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AKZ74aGV2WI834FP6EDwAJ6heUMfsbH84jNJD25e598=;
        b=Z3Hp5fwWwtdAqaTVoKeLfcyxcZS+pmum1Std0LcVQQHkSCh63HpXePRImzksrGHJY9
         3fHCtEcyxwZrc4GRoiPA9tCz1VACbZhfheULr3OhG+McdTZ1LiZnPgXHNovCNXmag4z1
         pDXI8G5nvVkT8IeAg3/KXd4Jc2NCzJHXKH3AgMsTNyakaqA4HE35/4SZnhpt5wKW2M2l
         YvQ/YfHLBPw8KJPUApTuX4HQ06xee8fXNve34rWZlfEp6zVwad1CL1qburUwxDHUfs7o
         xqlyCpoVCSKsOhgcm3FNak0OTv958TNM/sNFurmbWDMF++UsTRKlewA5Q6Q3yZi78use
         CPdw==
X-Gm-Message-State: AGRZ1gJNywfIXKyG7OsVdtbAJr1M8CffmO/u50grW/exQBsldwO6NrJ1
        LdnVQVI38T1LkgHib3gZGrJYD/Jg
X-Google-Smtp-Source: AJdET5cFKPNQlMnO+k3MNnsH5AdA0Bn81UH1TZzSHpxd1XO9jOgcI/8I/UUUVYM9D20nLh/qYpIKJg==
X-Received: by 2002:a5d:698b:: with SMTP id g11-v6mr7107014wru.159.1541082609250;
        Thu, 01 Nov 2018 07:30:09 -0700 (PDT)
Received: from szeder.dev (x4db12d59.dyn.telefonica.de. [77.177.45.89])
        by smtp.gmail.com with ESMTPSA id t134-v6sm2968128wmd.18.2018.11.01.07.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 07:30:08 -0700 (PDT)
Date:   Thu, 1 Nov 2018 15:30:06 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ab/* topics (was: Re: What's cooking in git.git (Nov 2018, #01;
 Thu, 1))
Message-ID: <20181101143006.GV30222@szeder.dev>
References: <xmqqd0rpt8wy.fsf@gitster-ct.c.googlers.com>
 <8736slkqmu.fsf@evledraar.gmail.com>
 <20181101131022.GU30222@szeder.dev>
 <87va5gkj0e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va5gkj0e.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 01, 2018 at 02:46:41PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > However, if you push that patch with 'sh-i18n--helper' as-is, then I
> > do object now: parsing a boolean in shell is not at all that difficult
> > to justify this new command.
> 
> So instead of calling a helper (which is undocumented, and only used by
> git itself internally) you'd instead like to have some shellscript
> thingy like:
> 
>     if test $value = 'true' -o $value = '1' [....]
>     then
>         exit 0
>     elif test $value = 'false' -o $value = '0' [...]

Yes, but more like:

  case "$GIT_TEST_GETTEXT_POISON" in
  yes|true|on|1)
    GIT_INTERNAL_GETTEXT_SH_SCHEME=poison
    ;;
  esac

There is no need to check for 'false', 0, etc.

Yes, I know that this is not as fully-fledged as git_env_bool(), e.g.
it won't recognize 'TrUe' and '42' as true, but since this is "merely"
a testing aid, I think it's sufficient.

> Sure, if that's the consensus I can change that, but it seems like the
> opposite of the direction we're moving with the general *.sh -> *.c
> migration. I.e. implementing helpers whenever possible instead of adding
> new shellscript-only logic.

I doubt that we really want to implement helpers "whenever possible",
i.e. even instead of such a rather trivial piece of shell code.

In the discusson of v1 of that patch there were suggestions on how to
turn an environment variable into a boolean in a more proper way, e.g.
by extending 'git var', but I agree with Peff that "we should do
nothing for now and see how often this comes up" [1].  In the meantime
this builtin seems to be the worse direction of all.

[1] https://public-inbox.org/git/20181025212358.GA23257@sigill.intra.peff.net/

