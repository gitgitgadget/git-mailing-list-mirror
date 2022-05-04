Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF28C433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 11:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348626AbiEDLTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 07:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348631AbiEDLTP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 07:19:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973D55FEF
        for <git@vger.kernel.org>; Wed,  4 May 2022 04:15:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p189so657894wmp.3
        for <git@vger.kernel.org>; Wed, 04 May 2022 04:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WbcaZ4/4GEM/xtwzIwumKua3t+u+DHhDrlaDFi1JTfY=;
        b=kOLiHn/5uKpVp+KG4YVbavza8I3eXc/fgINJ6f+YoRdLg+feRSslQp5RfKFFpyfh0R
         NL12PdvwUJev2FmESMJwahsyDmkYPoqvqyxhWouy6dqYCqlJ4ZB//h8JA835t6gPuhBe
         cwOXk72TRZgiYxB62m1F/Tg6DT8Q4i28SouNcu681+kVEr4FdGsyv+zkMZQ81gotAGhp
         A9t3Ec3cFE1BX6DmiTWYuYLRIRTq2vPgkFJ9QLbzfzeXqgPK7wGwy8X3wrD3gHFmJ38d
         fLMduE4bf6S2Ml9JhrVvrplny95W7tlHOOthcVwg2BhQG5KoJWZIzdFbYo2DhQkUdLGo
         UXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WbcaZ4/4GEM/xtwzIwumKua3t+u+DHhDrlaDFi1JTfY=;
        b=ShuXbv5OtFdp/Hb5Nu3SmRra/hXWVf+WLptuUYVmofxtSf1y92hV6ChvRa+eLs8IRu
         1izoj3UppSFnm2Pnrc1VANP1oqevItgeBj41VduZF6gpHZbdOS3Pb63/SF4lXHUZengW
         EnsOwCWOb5Tzzz46CoZbyMEfJqlGwNyQc5eW+vJ6HesDP9YjYg/VEfZjjkast/87ga8/
         ccCYfDuIs4Q0JSt5+LAoY7b/s/K5AnVIJeyGzt60g3B7N3YvvZb2SN70BT1KVRy/tn5S
         hNXmqteKc09w1PTEiT4wEAd9DUvEkXPcbL3fM9w1se1GmD9IXABbxCWCmttk66X0Bw9n
         0oCQ==
X-Gm-Message-State: AOAM532umpr2EczMQVsfH80RIkzZawYjmwWlwGUSimnNPJPNaIQ3efje
        CCeYjLh0GcTFoK5CjP/xZsg=
X-Google-Smtp-Source: ABdhPJylNtlihcfuiPbvxWUP7ggS9D0UymhdgDbOYNOyjKzlrSrK0VAtZjRg7zzWBpQljrQNz+Rl4A==
X-Received: by 2002:a7b:c202:0:b0:394:1e7d:af44 with SMTP id x2-20020a7bc202000000b003941e7daf44mr7201164wmi.139.1651662933974;
        Wed, 04 May 2022 04:15:33 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id x1-20020adfbb41000000b0020c7fb81b0fsm1458577wrg.46.2022.05.04.04.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 04:15:33 -0700 (PDT)
Message-ID: <d54b7672-36ab-a2b8-1a73-7d1a444a5936@gmail.com>
Date:   Wed, 4 May 2022 12:15:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
Content-Language: en-US
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20220428105852.94449-1-carenas@gmail.com>
 <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-2-carenas@gmail.com>
 <9b92b380-1da1-b76d-1eb4-469aba289694@gmail.com>
 <20220503155649.b4ehcez2ytfwyq6e@carlos-mbp.lan>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220503155649.b4ehcez2ytfwyq6e@carlos-mbp.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 03/05/2022 16:56, Carlo Marcelo Arenas Belón wrote:
> On Tue, May 03, 2022 at 03:03:59PM +0100, Phillip Wood wrote:
>>> +
>>> +# this prerequisite should be added to all the tests, it not only prevents
>>> +# the test from failing but also warms up any authentication cache sudo
>>> +# might need to avoid asking for a password
>>
>> If this is required for all the tests then it would be simpler just to skip
>> all the tests if it is not satisfied as you do above.
> 
> it is obviously not required (as shown by some tests in patch 3 not having
> it and by my choice if the word "should"),

I'm afraid it is not obvious to me. As far as I can see the only test 
that does not have this prerequisite is 'cannot access if owned by root' 
added in patch 3. That test needs a setup test to run first which 
requires sudo so there is no point running it if this prerequisite is 
not satisfied.

> but it still recommended, which
> I was hoping would be explained by that comment since if sudo to root is
> only allowed "temporarily" by someone typing their password, then sudo keeps
> that authentication in a cache, that could probably expire otherwise.
> 
> Ironically, this comment was meant to explain why it was not checked once
> at the beginning and being used instead in almost every test, but presume
> I wasn't clear enough, not sure if worth resubmitting either.

That was not clear to me. Prerequisites are evaluated once and the 
result is cached. Making it lazy just means it is evaluated when it is 
first required rather than when it is defined. You're right that we want 
to avoid sudo hanging because it is waiting for a password. We should 
define something like

sudo () {
	command sudo -n "$@"
}

to avoid that.

>> Running "sudo env" shows that it sets $HOME to /root which means that these
>> tests will pick up /root/.gitconfig if it exists.
> 
> I think this depends on how sudo is configured, but yes ANY environment
> variables could be set to unsafe values that would confuse git if it assumes
> it is still running as part of the test suite.

I think I'm using the default configuration for that setting (or at 
least the default configured by the linux distribution I'm using).

> My approach was to make sure (with the prerequisite) that at least we have
> PATH set to the right value, so we won't start accidentally running the
> system provided git, but you are correct that at least for patch1, the only
> thing I can WARRANT to work is `git status`, but it should be also clear
> to whoever writes tests using sudo, that it can't be otherwise since git it
> is not only running as root, but it is running in the environment that sudo
> provides when doing so.
> 
>> Normally when running the
>> tests we set $HOME to $TEST_DIRECTORY so they are run in a predictable
>> environment. At least anything pointed to by core.hooksPath or
>> core.fsmontior in that file is expecting to be run as root.
> 
> which should be the same expectation of anyone running `sudo make install`
> in their own repository, so we are just mimicking the use case we care
> about.

Two of the most important promises the suite makes are that (i) tests do 
not write outside $TEST_DIRECTORY and (ii) the tests are not affected by 
the user's or system's git config files. By having $HOME point to /root 
we are clearly violating the second promise and making it much easier to 
accidentally violate the first by inadvertently writing to $HOME.

> core.hooksPath or core.fsmonitor might be relevant now, but there is no way
> for me to predict what else might be in the future,

exactly, they are just examples and show why setting HOME=root is a bad idea

> and then again `sudo -H`
> will behave differently than `sudo` and there is nothing git can do to
> prevent that, so I keep thinking $HOME is not that special eitherway.

I think $HOME is important enough to worry about because the test suite 
deliberately resets to avoid reading the user's config. Whether some 
other random variable such as GIT_COMMITTER_DATE is set or not does not 
matter in the same way.

> it might be worth adding that as well as a constrain into the prerequisite
> though, so if your sudo does change HOME then we skip these tests, or we
> try harder to call sudo in a way that doesn't change HOME instead.

It would be better to call git via a wrapper that sets HOME correctly

>> I think it is
>> worth spelling this out explicitly in the commit message (currently it is a
>> bit vague about what the implications of not having better integration with
>> the test framework are) and the top of the test file. Note that t1509
>> sources test-lib.sh as the root user so does not have this issue.
> 
> As explained below, there is no way to "explictly" document all things that
> might be relevant, and being vague was therefore by design.

Being vague by design is unhelpful, just because it is difficult to list 
all the possible implications of a changes does not mean that one should 
not list the important known issues. Commit messages should be 
transparent about the known implications of the changes the commit 
introduces and whether there are likely to be other unanticipated 
implications.

> t1509 has also a different objective AFAIK, which is to test in an environment
> where everything is running as root, which is not what we want to do here.

Indeed - I brought it up because we're reusing IKNOWWHATIAMDOING but not 
documenting that we using it in a different way.

> root is relevant only when we got it through sudo, hence I don't think that
> just reading test-lib.sh through sudo as well would be a "solution" in this
> case, but I agree with you that for a full integration a lot more would be
> needed, which was again documented and punted explicitly.
> 
>>> +test_lazy_prereq SUDO '
>>> +	sudo -n id -u >u &&
>>> +	id -u root >r &&
>>> +	test_cmp u r &&
>>> +	command -v git >u &&
>>> +	sudo command -v git >r &&
>>> +	test_cmp u r
>>> +'
>>> +
>>> +test_expect_success SUDO 'setup' '
>>> +	sudo rm -rf root &&
>>> +	mkdir -p root/r &&
>>> +	sudo chown root root &&
>>> +	(
>>> +		cd root/r &&
>>> +		git init
>>
>> Using git -C <directory> would eliminate a lot of the sub shells in this
>> file
> 
> My assumption (and help me understand if it was incorrect) is that these
> tests should document the expected use cases, so you are correct that
> both cd and -C accomplish the same in the end, but I think that cd is what
> users would more normally use, and by writing with it (specially since it
> requires a subshell) is also more easy to spot and understand that an
> invocation of git with -C.
> 
> I have to admit I didn't even thought of using -C originally because of
> that, but if you think that makes the test easier to understand and better
> I am sure happy to include that in a reroll.

I think it's pretty common to use -C in the test suite when running git 
in a repository that is a subdirectory of $TEST_DIRECTORY.

Best Wishes

Phillip

> Carlo
