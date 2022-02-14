Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB9AC433FE
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 03:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbiBNDOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Feb 2022 22:14:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239896AbiBNDOm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Feb 2022 22:14:42 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D2051309
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 19:14:35 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m22so7695982pfk.6
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 19:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gAbvS6V1pG0a038pSxB6kDpsssYEfJoxCVpMYLIAg/o=;
        b=h+ot6zf83FLBu3P8g4hN5kWKxYw5toFP7cRuTyeBnom3DFfwP1gnWQAoRrfMIOhZJF
         k2YB6VJNhBEZ+9nTz1k/bJRpYzPKg3Xn/0hA2mYnmVX0WMYY0xJ3MaD+t+8OjDDQuVos
         5g3jCXG4wr4blzys8S4HXIRaGkFLSrpw8k3FkBSJBUF1olbhZm7kmcx6GeBgnkqn9Y+u
         HCak1oYaJJ04zGS9rbcuc4YitepDQTjssVnXVjYad+yFGJp83WmxplCPRttwWPDLviCc
         ioKJeoE9ffA25VzaE+zb89uARhw+wfwyuOwcnI/tJMmPFVCFBQUSLj67Q+o+tFleNQ/9
         kcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gAbvS6V1pG0a038pSxB6kDpsssYEfJoxCVpMYLIAg/o=;
        b=qAEgU+ndoDx9ssuxT5ovFa7eLO/ikXrVbcq2Y9TkhT9nF91G/LbIKIyEYZ+Hp9wl3/
         H/QE19KzmEVs+mqoN+XuHw4OCKa7JOmBqC3KAIDywEr6SnHiuWH8hm3DUObt34b/4pC5
         yxulQPrhBtE52dIB8NpJwYA9x0/8OS3h7HxgUhUef1FmGNQ0rFOZJug93wu6yZ1pjw8d
         vHWnL4yNN2ODSbt0sumUpiq6m19XNcknUYDsna7dV5+IbVUdihsXOgWvaMex86Jb+nyp
         B74UPuhsj21nz+4PahSVnyxcjrL1DUedCXX0ATgif6k8jBCymS30s1GPnLXMRdQg46wT
         MMtw==
X-Gm-Message-State: AOAM532VPiJWXl0Cs8HCfVnp7xMoiipSru3Ia1gHU1eaXsj/a//J0iDF
        k4bmVyFXpzfjACtL3/pMyKM=
X-Google-Smtp-Source: ABdhPJzjLsIUtB9thNk63L3R/4RAcKtomGec8SwqzJPTLLviWbvJgWuI/3y5GIJeOpMOcYwrRgoLmg==
X-Received: by 2002:a63:e64d:: with SMTP id p13mr10259366pgj.233.1644808475292;
        Sun, 13 Feb 2022 19:14:35 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-75.three.co.id. [180.214.233.75])
        by smtp.gmail.com with ESMTPSA id f15sm35203100pfv.189.2022.02.13.19.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Feb 2022 19:14:34 -0800 (PST)
Message-ID: <c81e1226-2184-0f16-b81d-c11d894b4654@gmail.com>
Date:   Mon, 14 Feb 2022 10:14:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] hard reset safe mode
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Viaceslavus via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Viaceslavus <vaceslavkozin619@gmail.com>
References: <pull.1137.git.1643802721612.gitgitgadget@gmail.com>
 <pull.1137.v2.git.1644618404948.gitgitgadget@gmail.com>
 <xmqqee4980qz.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <xmqqee4980qz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/02/22 06.03, Junio C Hamano wrote:
> "Viaceslavus via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Viacelaus <vaceslavkozin619@gmail.com>
>>
>> The power of hard reset may frequently be inconvinient for a common user. So
>> this is an implementation of safe mode for hard reset. It can be switched on
>> by setting 'reset.safe' config variable to true. When running 'reset --hard'
>> with 'reset.safe' enabled git will check if there are any staged changes
>> that may be discarded by this reset. If there is a chance of deleting the
>> changes, git will ask the user for a confirmation with Yes/No choice.
> 
> There needs an explanation on how this avoids breaking scripts that
> trust that "git reset --hard HEAD" reliably matches the index and
> the working tree files to what is recorded in HEAD without getting
> stuck waiting for any user input.  "They can turn off reset.safe" is
> not an acceptable answer.
> 
>> +static int check_commit_exists(const char *refname, const struct object_id *oid, int f, void *d)
>> +{
>> +	return is_branch(refname);
>> +}
> 
> The returned value from a for_each_ref() callback is used to tell
> the caller "stop here, no need to further iterate and call me with
> other refs".  I think this wants to say "if I ever get called even
> once, tell the caller to stop, so that it can tell its caller that
> it was stopped".
> 
>> +static void accept_discarding_changes(void) {
>> +	int answer = getc(stdin);
>> +	printf(_("Some staged changes may be discarded by this reset. Continue? [Y/n]"));
>> +
>> +	if (answer != 'y' && answer != 'Y') {
>> +		printf(_("aborted\n"));
>> +		exit(1);
>> +	}
>> +}
> 
> I'd think at least we should use git_prompt(), instead of
> hand-rolled prompt routine like this one that assumes that an
> end-user is sitting in front of the terminal waiting to be prompted.
> 
> If updating "git reset" like this patch does were a good idea to
> begin with, that is.
> 

I think it's better just to error out when there are staged changes.
The message will be something like:
"error: there are staged changes that will be hard-reset. Please
commit or stash them before resetting. If you want to remove all
changes from index, you can do so by running 'git reset'."

-- 
An old man doll... just what I always wanted! - Clara
