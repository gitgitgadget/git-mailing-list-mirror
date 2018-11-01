Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09B211F453
	for <e@80x24.org>; Thu,  1 Nov 2018 13:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeKAWtr (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 18:49:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37366 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeKAWtr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 18:49:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so1387463wmc.2
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=kmB+ormu07hxiTNEdsYQkt9YI7ASownZGeyqz5c4MqE=;
        b=N49dwAscw4PoRW4sRZfHgrtlHGsqsv9ZHZ3e+j960QYeZlK4lJNXd1a7i2dAMQ7+nM
         dv8Z9WIcqaqlvcwDTSi4hFmJi1/Xp0V7Wvvw2/V7Vj1YI//C1MEljWAWxRUB4Ev3xuv6
         U5TFNT2q99yRBdzL3R2C/3igFTM+fIz3h24mlhWzNkSxYqGwS4ULBhRJDIu+CK1CQa2N
         Vp/SQSKiPpOBwFG9HvQBQSpc5k29OEjsaqzuefSZH+Ft5DG3QW9o0oGzKNN0cIkCs7ul
         ZIAg5yQ7QFAkIT2/4R/gJNYeGq9kpsu2DGNAOEEGnOudIqEx7Uy70pTPU3T62bbCA2aH
         BmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=kmB+ormu07hxiTNEdsYQkt9YI7ASownZGeyqz5c4MqE=;
        b=FK0axWQVkdrRTORd41Zky+iUyU/Ux8wHXHW4Am+fWO2yNlGnr/49c6k83uphWD4Ki+
         mZy++V+mwoWwLHPLmQxNN2YJe8j1bziqHKTtP/E1dDKiMuHmUG9wHSfXeufdNzhflXsk
         yjKAt+LRuPs7llGAAKwCBc1DkNRvHaHRcbtXQsUOxVinsgZlEFzB6FbAiRrgIE/C4FwU
         8DMtMJafiSOoSrFmMZrG0Y9Mri2S9jFhnVPfMaML5B+ViMDmAIS5t344LEcuGV0uk65G
         kScfVaTlPmxqu5PCQLz/hIset8sxilZh/+akcwjBEZ8ZnB8D5DYcAb66jI38q1Usg7zH
         HRIA==
X-Gm-Message-State: AGRZ1gJqPqoymiA4brma+kRmRAtlDoW9NzOsQ0uTHzFU7b5i4iS+W2sC
        1+CTTbt4ajU1qg4T6md+5Lk=
X-Google-Smtp-Source: AJdET5f0AnxBDkDu6vDsS2Bfdx6YrBrSImxqtrSRhAChVc98PtizsCzbnVTkTTNxmyNM2lW2fgsOMA==
X-Received: by 2002:a1c:8b53:: with SMTP id n80-v6mr6040631wmd.118.1541080003851;
        Thu, 01 Nov 2018 06:46:43 -0700 (PDT)
Received: from evledraar ([2001:981:2f6f:1:6765:91b4:348a:a673])
        by smtp.gmail.com with ESMTPSA id r73-v6sm23033519wmb.37.2018.11.01.06.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 06:46:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ab/* topics (was: Re: What's cooking in git.git (Nov 2018, #01; Thu, 1))
References: <xmqqd0rpt8wy.fsf@gitster-ct.c.googlers.com> <8736slkqmu.fsf@evledraar.gmail.com> <20181101131022.GU30222@szeder.dev>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181101131022.GU30222@szeder.dev>
Date:   Thu, 01 Nov 2018 14:46:41 +0100
Message-ID: <87va5gkj0e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 01 2018, SZEDER Gábor wrote:

> On Thu, Nov 01, 2018 at 12:02:01PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> Could you please pick up
>> https://public-inbox.org/git/20181024114725.3927-1-avarab@gmail.com/ ?
>> It seems to have fallen between the cracks and addressed the feedback on
>> v1, and looks good to me (and nobody's objected so far...).
>
> I didn't object, because in
>
>   https://public-inbox.org/git/87muqzllh0.fsf@evledraar.gmail.com/
>
> you asked for "a more general review than just the problem of how
> we turn an env variable into a boolean".
>
> However, if you push that patch with 'sh-i18n--helper' as-is, then I
> do object now: parsing a boolean in shell is not at all that difficult
> to justify this new command.

So instead of calling a helper (which is undocumented, and only used by
git itself internally) you'd instead like to have some shellscript
thingy like:

    if test $value = 'true' -o $value = '1' [....]
    then
        exit 0
    elif test $value = 'false' -o $value = '0' [...]

Sure, if that's the consensus I can change that, but it seems like the
opposite of the direction we're moving with the general *.sh -> *.c
migration. I.e. implementing helpers whenever possible instead of adding
new shellscript-only logic.
