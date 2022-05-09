Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBE4C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 08:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiEII4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 04:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiEII0K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 04:26:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F301A449D
        for <git@vger.kernel.org>; Mon,  9 May 2022 01:22:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u3so18311803wrg.3
        for <git@vger.kernel.org>; Mon, 09 May 2022 01:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aEMYJy+mOnvD3L5Y+ZlIg9VK5mDcFBgwXx+M2Z7or0g=;
        b=ImKYJl7ob6Uc+9g9WhDCLySfcfKycp46uP4i9Gs6xKK7fSZlQWVdZjcISOm7CmgJgy
         cgkgwyfCEmuXJvgTuC1fkBG82HcR2OSzbx4TYjAetHGs/cYM6SSG6hTZuaZltPnad5Lk
         xRtcpc3mci9guWhircUjdqA0p3TcriKcoU35CHPPyNnvVYDIVkEsEEBbruRBDeyZaMnp
         s483xwfUUbgfpNKAwm/FQH52h7Qab/G/aUqDSdGMUsnJZVn/zhp8NVP749oAcmSveFRc
         H0hhYvB2+AWjGME42hTp3WjJMjup6fIs5kono1XEa9Roe5R3Ze4MHTY+0XJBRLLBSi4C
         naVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aEMYJy+mOnvD3L5Y+ZlIg9VK5mDcFBgwXx+M2Z7or0g=;
        b=r8Gkyu+MiEI3RqfmdZ5J/3gweIxvE+HhQWpBhyvBNoGGXLHCsrN4YusiyfgXovQ6kA
         KegcgDDfaoKJ1ZcRvGmhfvBTPP6TMNIJri8IT88M35FDtLW9qn2HGb//t99r8TJAa0fv
         jUMmgixpJofaEjREA1+cSodyGAhRyyE9O29JdtWVyIev8qVHwFB3hE7gOWJd3rctliKW
         lN/lPiq+jOE8JJk7hX0k4+ZYTPKyOjXmiFJt1JMgpzCl59dc657AhpO4mKbT54HmUSFF
         GTgL7f5x0G66xMo8upJgAIw0JJL51qmHKUcuIwGduhd4Uombnr7/wwdZHOcPFauyPyb7
         BUYg==
X-Gm-Message-State: AOAM5325EkJVLSDbTKu0xgpcXdbfEweeCQZGCQQmV2vwUTBCAwDnbyKP
        OU8RXLI7cevyON3315YyeCXiJtLrlKA=
X-Google-Smtp-Source: ABdhPJyk5K7tYEc090O6Wo13MDe9sPxbPvoo0FfeNDdYJYu+q+5KNhKWwTOiYdESC2x0yx619EZ8vA==
X-Received: by 2002:a05:6000:707:b0:20c:4fd8:1d61 with SMTP id bs7-20020a056000070700b0020c4fd81d61mr13067051wrb.407.1652084489888;
        Mon, 09 May 2022 01:21:29 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b0020c5253d908sm10293905wrb.84.2022.05.09.01.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 01:21:29 -0700 (PDT)
Message-ID: <4314bf6d-d76c-bc5b-a7f9-e59c7c181c7c@gmail.com>
Date:   Mon, 9 May 2022 09:21:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org, bagasdotme@gmail.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20220428105852.94449-1-carenas@gmail.com>
 <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-2-carenas@gmail.com>
 <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet>
 <xmqqlevfesnu.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqlevfesnu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 05/05/2022 19:33, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> Hmm. I would like to suggest that we can side-step all of these issues
>> (and the ones I outline below) by considering a similar approach to the
>> one Stolee took in t0033: use one or more `GIT_TEST_*` environment
>> variables to pretend the exact scenario we want to test for.
> 
> I like the GIT_TEST_ASSUME_DIFFERENT_OWNER because it is fairly
> clear that it cannot be used as a new attack vector, even with
> social engineering.
> 
> It would be nice if we can do something similar, but I am coming up
> empty while trying to think of "we are testing; pretend that ..."
> that is good for testing this SUDO_UID special case *and* clearly
> cannot be used as an attack target.
> 
> So I very much like the suggestion in principle, but I am not sure
> how useful the suggestion would be to make the resulting code better
> in practice.
> 
> Perhaps this may be a way to pretend we are running a command under
> 'sudo'?
> 
> 	test_pretend_sudo () {	
>              GIT_TEST_PRETEND_GETEUID_RETURNING_ROOT=1 \
> 	    GIT_TEST_PRETEND_LSTAT_RETURNING_ROOT=root/p \
>                  SUDO_UID=0 "$@"
> 	}
> 
> 	test_expect_success 'access root-owned repository as root' '
> 		mkdir root/p &&
> 		git init root/p &&
> 		test_pretend_sudo git status
> 	'
> 
> That way we can avoid having to run "chown" while preparing for the
> test fixture, and running "git status" under root, but I am not sure
> if we want our shipped production binaries to have these "pretend"
> knobs.

Lets ask ourselves "How could an attacker use these knobs to facilitate 
an attack?". They need to either (a) set these variables in the user's 
environment themselves or (b) persuade the user to set them. For (a) if 
an attacker can set them in the user's environment then they can change 
the user's $PATH or $GIT_DIR and $GIT_WORK_TREE so this does not open up 
a new way to compromise the user. For (b) I'm not sure it is easier to 
socially engineer the user to set these new variables rather than 
GIT_DIR and GIT_WORK_TREE which will also bypass the check.

Best Wishes

Phillip


> Thanks.
