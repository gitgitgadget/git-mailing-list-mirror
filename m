Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BCFC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 15:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbiFCP5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 11:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343545AbiFCP5u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 11:57:50 -0400
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB4E7659
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 08:57:47 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id 62-20020a9d0dc4000000b0060b1e18e8d6so2313217ots.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9FnNzWikfYNc+otVKI0LOdkcGwIxRIN8hQLfdIMQf/Q=;
        b=SbgW+rwtH6DA8pTWZM9+zqVopE15JPpJasigjyGOjn5nznr7VFAuV5FT3MHLEAKJ4j
         k7zmF7Lzc06DyCYILDYC+FNnmFmUMO5DUyRXkKPIG6MCbtEprCMPWEtOoBhDDRe1E4MK
         KxivVcMOVuTsEuDOjgENo106UowPFzbg5dMmNatH7kACl/5w3Bi6ZXwnwm7LqdW/psMc
         np/P88tQMJGUQ+1x2N1GuMmfOtZxDR7rNj7E43ev6BJKhITwoDxS/Gwcrcrx6cvzX5sY
         1AhNxyKSSnbcbsnKExbczdQmvUI/rdxrfFsU3PEa3iGVmyyW4Ue0JNlZdsW5VPsHYSkb
         QMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9FnNzWikfYNc+otVKI0LOdkcGwIxRIN8hQLfdIMQf/Q=;
        b=ffZRsi3hbyW8pG//hSn3V3GaydQvKEuXuEQg+Vk2BVoTly0Wrlu0KVfoSty6MkAMMI
         74S6U/TMULyramy2k19XuSv7Kl1Cm0kWIxLTlD9iO0jhEE/x22qMp5ajYawtdF1YcD5G
         e7O9FBTL9949DvQCU7B7wtTkarI9j3agcBYlvDE4GJsMObjttLGhiKZr0NM/oRyIKPiV
         xwzFh0XTzciKxVqFCSYNe2fTGj7HE/KJq08EyfFksiXWj2SUDHvHsiAgTMlJfx2mGFM0
         6DimhOZmu/j50i2OuvEVGZUv00MvMjkpLOoGSSfxJS3An2/PpxTyQ+V0mnceIQCOtL1e
         n0Bw==
X-Gm-Message-State: AOAM531BsuKE1Gp1VHaXvtZHJhJ0QaFytTo/bhwb1EA3FDqPSRUVEsOL
        TYRBV9D7k993lFDGWWGlAiBrLKkRmZsFeQ==
X-Google-Smtp-Source: ABdhPJydCgJbGnPGUtd/Y3EuZlLYTkDloRUqEUsQ6cfFJ65gSbDvDAvvAi1DTxs5w2Xs/K2mpMIL4cKO8S/63w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6808:181a:b0:32b:7a93:f6c2 with SMTP
 id bh26-20020a056808181a00b0032b7a93f6c2mr5994001oib.272.1654271866479; Fri,
 03 Jun 2022 08:57:46 -0700 (PDT)
Date:   Fri, 03 Jun 2022 08:57:43 -0700
In-Reply-To: <xmqqh75a1rmd.fsf@gitster.g>
Message-Id: <kl6l7d5xeo3s.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
 <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com> <575676c760d9a2ce4a59d50e93aa0f45d54620ab.1653685761.git.gitgitgadget@gmail.com>
 <xmqqh75a1rmd.fsf@gitster.g>
Subject: Re: [PATCH v3 1/5] Documentation: define protected configuration
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  safe.directory::
>> -	These config entries specify Git-tracked directories that are
>> -	considered safe even if they are owned by someone other than the
>> -	current user. By default, Git will refuse to even parse a Git
>> -	config of a repository owned by someone else, let alone run its
>> -	hooks, and this config setting allows users to specify exceptions,
>> -	e.g. for intentionally shared repositories (see the `--shared`
>> -	option in linkgit:git-init[1]).
>> +	'(Protected config only) ' These config entries specify
>
> What's the SP in "only) '" doing?

Silly typo. Thanks for the catch :)

>> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
>> index aa2f41f5e70..a669983abd6 100644
>> --- a/Documentation/glossary-content.txt
>> +++ b/Documentation/glossary-content.txt
>> @@ -483,6 +483,24 @@ exclude;;
>>  	head ref. If the remote <<def_head,head>> is not an
>>  	ancestor to the local head, the push fails.
>>  
>> +[[def_protected_config]]protected configuration::
>> +	Protected configuration is configuration that Git considers more
>> +	trustworthy because it is unlikely to be tampered with by an
>> +	attacker. For security reasons, some configuration variables are
>> +	only respected when they are defined in protected configuration.
>> ++
>> +Protected configuration includes:
>> ++
>> +- system-level config, e.g. `/etc/git/config`
>> +- global config, e.g. `$XDG_CONFIG_HOME/git/config` and
>> +  `$HOME/.gitconfig`
>> +Protected configuration excludes:
>> ++
>> +- repository config, e.g. `$GIT_DIR/config` and
>> +  `$GIT_DIR/config.worktree`
>> +- the command line option `-c` and its equivalent environment variables
>
> The description is a bit unclear what "protected configuration"
> refers.
>
> If it is the scopes (as in "git config --show-scope") Git can trust
> more, in other words, a statement like this
>
>     safe.directory is honored only when it comes from a protected
>     configuration.
>
> is what you want to make easier to write by introducing a new
> phrase, perhaps use the word "scope" for more consistency?  E.g.
>
>     Only safe.directory that is defined in a trusted scope is
>     honored.

Good point. I think using scope would be a lot clearer, and maybe I
will consider s/protected configuration/protected scope. I'm hesitant to
call the scope "trusted", because I don't want to insinuate that
repository config is "untrusted" since we _do_ trust it in most cases.

I don't think Documentation/git-config.txt has adequately defined what a
'scope' is though, even though scopes have been with us since 9acc591111
(config: add a notion of "scope", 2016-05-18). The best I could find is
"--show-scope", introduced in 145d59f482 (config: add '--show-scope' to
print the scope of a config value, 2020-02-10), which mentions scopes
but doesn't link the idea back to the specific files or CLI options
("--system", "--global", etc).

So I'll see if I can improve the docs around scopes since that will help
the language in this patch.
