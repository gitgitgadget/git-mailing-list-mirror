Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621F7C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 17:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352169AbiETRXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 13:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352155AbiETRXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 13:23:37 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ACA187045
        for <git@vger.kernel.org>; Fri, 20 May 2022 10:23:36 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id o16so5983819ilq.8
        for <git@vger.kernel.org>; Fri, 20 May 2022 10:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=9IOLb1Cp3RE0Xswr9MxNVGzxpFR/I/2+wjauaAo81rg=;
        b=H7jBUwk+jyncCC/4Jx8Obh8pHyw+Zq+5csnzCOP45u52TNWNNRAa6hmPTlt3qAbW38
         +KZpm5sMDMvM7kd3cwvysCv4qS/qIOpz7ciEZz8CT37e5+Qs16we6OFBnehikEAIq86a
         sAQdLNnXJZVonDCg+OKpMrRJ1EGoA2V+tw1f/vqdHuNftCdKllrcWQJ8vIKzqGof9FdX
         1W2rkkWT0E+RCn2ccVro4zm8n/OiFkyAj6p90fgGnuNhds8ccDi5GcvMNHJeECFsAVkX
         O/zEjEHFhUBRQA7fz6vZLcKReviRbITlEZk8TcP4FBSMT3/iq7tFiykky8T8aVfS9Tvh
         YUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9IOLb1Cp3RE0Xswr9MxNVGzxpFR/I/2+wjauaAo81rg=;
        b=XbVVAv19wOeSfQcyKHL5wbV97f9FqV6gGtW/hrj2kh3yVmP6nUnpXwK225i/6EDCkT
         oApEpo5jiiXb74oAWDQyQ5cCwYVm3PgCfjm8gDc4tpC7VAQbK9x0JZKSobRxRVIfJ+T1
         heD/3ghk6xvq4DxOz0CVXvdal6nDJyNFbh8fq42QSb2G5cmw6x08amna5lW6gegv8eJl
         jOFsUql3XY15zNIgmzRJbYFXr70UuYBE8U5x6NtvlwCsrlxnbbRLhh2nI4HnnHTybJeZ
         30jJXSHMol5RxWW8ykheNlcj30Gtt3q4R4lVcZzqIuJiEqYqi5qcprF9ZLM79D1/qhOK
         9PaA==
X-Gm-Message-State: AOAM533NHs9Z/yPxDl0mXRRdkmwjJ5fJNFiaSNIhbFOtnrBGYEwRmu7I
        Dle63UF5vgrQzHkFcLI5TP/8
X-Google-Smtp-Source: ABdhPJzNzsbla4Xhm+1gjdMEkd9nxLSt3aUaYwKdfk0ir8F+Ap4mUTRxbsyXwrlSHy9cbcTLT3Owsg==
X-Received: by 2002:a05:6e02:1747:b0:2cf:65d:4449 with SMTP id y7-20020a056e02174700b002cf065d4449mr5699991ill.77.1653067415403;
        Fri, 20 May 2022 10:23:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:34b9:84ab:204:3752? ([2600:1700:e72:80a0:34b9:84ab:204:3752])
        by smtp.gmail.com with ESMTPSA id w69-20020a025d48000000b0032b3a7817casm809145jaa.142.2022.05.20.10.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 10:23:33 -0700 (PDT)
Message-ID: <35e80e21-7388-8047-d8b9-02e136d20e04@github.com>
Date:   Fri, 20 May 2022 13:23:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [Discussion] What is Git's Security Boundary?
Content-Language: en-US
To:     rsbecker@nexbridge.com, 'Git Mailing List' <git@vger.kernel.org>,
        'Junio C Hamano' <gitster@pobox.com>,
        'Taylor Blau' <me@ttaylorr.com>,
        'Emily Shaffer' <emilyshaffer@google.com>,
        'Glen Choo' <chooglen@google.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, 'Christian Couder' <christian.couder@gmail.com>
References: <6af83767-576b-75c4-c778-0284344a8fe7@github.com>
 <daadac3e-d4c2-431f-a0bd-d8734d4424d8@github.com>
 <004d01d86932$a36f95f0$ea4ec1d0$@nexbridge.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <004d01d86932$a36f95f0$ea4ec1d0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/16/2022 10:38 AM, rsbecker@nexbridge.com wrote:
> On May 16, 2022 10:14 AM, Derrick Stolee wrote:
>>
>> I'm sending this email as a hopeful ping that this topic could use some feedback.
>> I'm looking forward to your ideas.
> 
> Some ramblings, since you asked, and I hope I am not missing the point:
> 
> I guess some (me) were waiting for more ideas on what you meant by
> "Security boundary". In network security, the definition is fairly clear
> - the line where security needs change, so a firewall, DMZ, etc. When
> talking about applications, a security boundary would be an area where
> the concept of a user diverges from the system, so your GitHub logon vs.
> user ids on the servers where GitHub runs - or perhaps Amazon is a
> better example.
> 
> The line blurs for git because we depend on the underlying user
> authentication mechanisms of the platform. To do anything in git, you
> either have to have a legitimate logon to the server where git runs or
> are coming in anonymously in a read-only (hopefully) fashion. In one
> view, your boundary expands beyond one system, making the boundary
> non-traditional.

Yes, this is exactly why this is an interesting discussion to have.

> The "security boundary" line is different for git than what a network
> security admin would consider as a similar domain. In gits terms (my
> view anyway), the boundary is functional. Do we want git doing something
> intended vs. unintended given the structure of the repository. In strict
> technical terms, the boundary is at fopen() and exec(). Can git access
> something or do something on a system and if so, should it. Conversely,
> is git blocked from doing something it should be able to do. This seems
> like well structured problem except for the introduction of incoming
> changes that could trigger undesired behaviour either at clone,
> fetch/merge time, switch or other situations where there is a side
> impact.

I agree that the boundary is functional. We want Git users to feel safe
running Git commands that their data will not go anywhere unintended and
no unintended behavior could comprimise their security. This is all for
things outside of the umbrella of "doing what you told Git to do," so not
understanding Git isn't a way to claim there is a security issue. Git
should push data where it is told, when the appropriate commands are run.
Git should run the hooks that are configured in the repository, since that
is an important functionality.

The biggest questions are how much we can rely on a "properly configured
and secured" system? Should we consider the filesystem to be trusted
state, or are our only concerns with data that is sent over a network? The
recent CVE around safe.directory hints that we don't always trust the file
system. Embedded Git repositories can be placed by a "git clone" but they
are not dangerous until after the user has a chance to inspect the data
that is on their filesystem.

> So putting the fopen() boundary into a box, that seems pretty much up to
> the operating system. I am not 100% sure that the safe.directory
> situation is required for that - although I have had customers asking
> for something like that for about 3 years.
> 
> There are three areas of ancillary impacts that give me continual
> concern: clean/smudge, hooks, workflows. Each hits the exec() boundary.
> Clean/smudge has a well-defined control that is up to the user or system
> admin to manage. Similarly hooks, although hook import has become a
> topic lately. The GitHub (and other app) Workflow Actions concept opens
> up a new area that allows the exec() boundary to be traversed,
> potentially with undesired side effects. Actions depends on GitHub to
> provide safety controls, which is outside git's responsibility although
> git is the transport vector through which potential problems can be
> introduced.

My biggest concern (outside of our well-established concerns over network
communication vulnerabilities) is the exec() boundary. How easy is it for
an attacker to trick Git into running a bad hook? This goes hand in hand
with how difficult it is to "install" hooks and that efforts to make that
easier are also likely to make it easier to create this kind of
vulnerability.

> We then get into "trust" and who is trusted across that
> boundary and is the trust justified. If it were up to me, I would want
> all of the incoming changes to be signed at least for accountability,
> but more having some kind of authentication to ensure the trust.

This level of trust is interesting. Outside of introducing an opt-in mode
that rejects any commits that are not signed by trusted parties, we
cannot make this change without breaking almost all existing scenarios.
This is an interesting thing to think about providing for ultra-security-
conscious folks.

Thanks for your thoughts!
-Stolee
