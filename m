Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3045BC433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 12:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbiFBMmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiFBMme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 08:42:34 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C111084
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 05:42:33 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id u2so2373951iln.2
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=/gk2QR3UPAGTcHxMzysHmhj2KD79D5GKlG6ub7Y4FFM=;
        b=L3PSp/ySy6pHqAjI/8DWjCp+5nBKN7B6ez7gKW2q7+N/XbbWCdMlZwehJvOXr9HU0a
         0nWZvcyrwfjKey9Vx5hZwoyD04gk/VppL/dchV9caQIquFqSdFIfzn/3j/man7eL/Ale
         qjHf9Hxvu8sp5t94MKLiskGyZ3QL5/gnu+0E+uoZWfPqY8sTLw/ABCq6YEe9lmMgWv8K
         KemAivWjbsF0tdsSJRSlpubT2NxuDsW6dtb1VGCJuBxjm78DDX5FxFcTJEEVYV7UZiVu
         eMr/AcY+RvWxwUDNkd01W5EXGJ+KoXyJClkm3ZR321QocCadvRnukG46tAB0++8WCYsg
         a7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=/gk2QR3UPAGTcHxMzysHmhj2KD79D5GKlG6ub7Y4FFM=;
        b=nQgOkOsySsbyOlhOpLbk0WekljW+cnmvTrsm2TkWy3tkXxu0YqORNmIk44FtHTbjGX
         JTffXfs5t8Vwy1ps0YVLWWk5i0E1zhfbHeih/PYovQIuPTnGT/ZZtlM62H2/GqYupLMO
         ndDkeuPpNtstC/Hr9bz3FJkf5FuMXyPt+I9FWmHtSBxTWpdoSaj8D7pHnkqIkOCWxcLY
         BSwClba4H2fP36yB7rgaojgoVPrn8e4+Tbk0E9LSKsHvz5QJmdOvpElRFn1362Ohl70/
         rKKqVzdqgaWy9yXlouxuFmA2lou6eaN7JM0IJWW+Fm5t5Qj0qpQ+9rZaXXhUWYxkbfzN
         A1VA==
X-Gm-Message-State: AOAM532ahvluzeghXf9yE1Q+yHqkcmzymjDMR6JsK0wYPrJWekSavs4N
        H730NWICOBWHo2xwjnEWEoVnzwE+n02g
X-Google-Smtp-Source: ABdhPJwwcijGar+FrCCRqcfqXilCYqE/55bxWJFYhR5hP9yuHOMn3+MkkLOJbyJ+UhhUu3VhYEVfjw==
X-Received: by 2002:a92:1902:0:b0:2c7:94cb:14b6 with SMTP id 2-20020a921902000000b002c794cb14b6mr2950075ilz.70.1654173752380;
        Thu, 02 Jun 2022 05:42:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9cc9:fda3:3ddf:6700? ([2600:1700:e72:80a0:9cc9:fda3:3ddf:6700])
        by smtp.gmail.com with ESMTPSA id c11-20020a92940b000000b002d3a701e765sm1308723ili.84.2022.06.02.05.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 05:42:32 -0700 (PDT)
Message-ID: <2ed00ece-f8bb-c84c-0684-494692a71da2@github.com>
Date:   Thu, 2 Jun 2022 08:42:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 1/5] Documentation: define protected configuration
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
 <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
 <575676c760d9a2ce4a59d50e93aa0f45d54620ab.1653685761.git.gitgitgadget@gmail.com>
 <xmqqh75a1rmd.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqh75a1rmd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/2022 7:29 PM, Junio C Hamano wrote:
> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
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
> 
> I dunno.
> 
> It would make sense to give a rationale behind the seemingly
> arbitrary choice of what is and what is not "protected".  Not
> necessarily in the glossary, but in the proposed log message of the
> commit that makes the decision.  The rationale must help readers to
> be able to answer the following questions.
> 
>  - The system level is "protected" because?  Is it because we do not
>    even try to protect ourselves from those who can write anywhere
>    in /etc/ or other system directories?
> 
>  - The per-user config is "protected" because?  Is it because our
>    primary interest in "protection" is to protect individual users
>    from landmines laid in the filesystem by other users, and those
>    who can already write into $HOME are not we try to guard against?

I think the answers to these two questions is "yes", so they can
be turned into an affirmative sentence:

	We do not event try to protect ourselves from those who can
	write anywhere...

>  - The per-repo config is not "protected" (i.e. "trusted"), because?
>    If we are not honoring a configuration in the repository, why are
>    we working in that repository in the first place?

This requires an example:

	Some workflows use repositories stored in shared directories,
	which are writable by multiple unprivileged users.
 
>  - The per invocation config is not "protected" (i.e. "trusted"),
>    because?  If we cannot trusting our own command line, what
>    prevents an attacker from mucking with our command line to say
>    "sudo whatever" using the same attack vector?

With this argument, I agree that -c config can be considered
protected. At the very least, it is visible to the user when they
are running a command. This would unify our expectations with
uploadPack.packObjectsHook, too.

Thanks,
-Stolee
