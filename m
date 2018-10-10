Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93011F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbeJKFS0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:18:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53032 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeJKFS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:18:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id 189-v6so6989889wmw.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=joHtBdyVKVXK0cA4cj7X8m6b43EV9cqz6i65BIXmjQs=;
        b=NmAZiVvOlcdUcUcdw3JX5NxfPamilVeVSQqdZ1WAeIIv9ksvsyPiHrPNczHawwC9vb
         xiIjYnfHrbEA8ycrn62Ulo4bh0Dg3yWdFVZ8pZ8oLNyx3DJ46i9eOPrtAn7zgiQ9S0hU
         Y9YF1PfR/JDH6zTKWd+9IrickGmmLxeg47wuUeUa5uigIhg+BPJGrQNXINWCpvqjjeSD
         Lajalak12gfyLVoaansHTkvqHFsOknPW5Peywx7vSx9CawGeRhH8MPD0WlUWjrZ8pAPy
         72ez/LYaqNG9JiX7kHeJngkd2S1SbXm6HmTyF+XPk4elGr4d682vNOoOEqYwGRXwBwVN
         JSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=joHtBdyVKVXK0cA4cj7X8m6b43EV9cqz6i65BIXmjQs=;
        b=Ulf2212mizCFxqos5bFk68ERtuVywih35b3o3qKIbTA6ooiNTInLlNajxhi2q/HJo1
         gYy+dPJrPSbALJ/inyF76K5QrEgWvDEeKmGw+lpqCC7tlgnrm6sQA5WO5fKPqrvM7Ov2
         cXf/p3Nl9pm4ZUsYs9Z29fZX+rQ3mOYut7lUKtCZ2XXDOxjjZtqIGsx0781CIrQ9HBv7
         iGpe2Wbk3HLg/BgN9RmGqnqIyYMgE8If53FAKswY3GErkgPYFcyxPSmEPbs13YHIbGkF
         8LoBMw194qsKDm4sEd1Uf1dwVpVFB6S3he1zmEsBTEraFEOjDcXtL9GLs48dYaysvO5t
         J5nQ==
X-Gm-Message-State: ABuFfoilMdc1lNBQy3wxkXGvXPL3W0lxSpWBDYNsuCRgThcSYh+axRLB
        YbpmpQPO+EpughDMHn5zjHk=
X-Google-Smtp-Source: ACcGV637F+tGvYzH418aPTYYtQu7KgXbmica2Uh7k8szsusYOHzmYubHomA6sFxZosenh0L/OGgCpA==
X-Received: by 2002:a1c:9cc9:: with SMTP id f192-v6mr2365048wme.135.1539208457314;
        Wed, 10 Oct 2018 14:54:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s132-v6sm11503629wme.14.2018.10.10.14.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 14:54:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] push: add an advice on unqualified <dst> push
References: <20181010104145.25610-1-avarab@gmail.com>
        <20181010104145.25610-3-avarab@gmail.com>
        <20181010205505.GB12949@sigill.intra.peff.net>
Date:   Thu, 11 Oct 2018 06:54:15 +0900
In-Reply-To: <20181010205505.GB12949@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 10 Oct 2018 16:55:06 -0400")
Message-ID: <xmqqbm81lb7c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Fix both of those, now the message will look like this instead:
>> 
>>     $ ./git-push avar v2.19.0^{commit}:newbranch -n
>>     error: unable to push to unqualified destination: newbranch
>>     hint: The destination refspec neither matches an existing
>>     hint: ref on the remote nor begins with refs/, and we are
>>     hint: unable to guess a prefix based on the source ref.
>>     hint:
>>     hint: The <src> part of the refspec is a commit object.
>>     hint: Did you mean to create a new branch by pushing to
>>     hint: 'v2.19.0^{commit}:refs/heads/newbranch'?
>>     error: failed to push some refs to 'git@github.com:avar/git.git'
>> 
>> When trying to push a tag, tree or a blob we suggest that perhaps the
>> user meant to push them to refs/tags/ instead.
>
> This is much better, and I love the customized behavior based on the
> object type.
>
> I wonder if we could reword the first paragraph to be a little less
> confusing, and spell out what we tried already. E.g., something like:
>
>   The destination you provided is not a full refname (i.e., starting
>   with "ref"). Git tried to guess what you meant by:

s|ref|refs/|; I fully agree that "unqualified destination" was a
poor way to communicate the failure to those who would likely hit
this error path, because somebody who can ell what's qualified and
what's not would not be triggering the error in the first place.

>     - looking for a matching branch or tag on the remote side
>
>     - looking at the refname of the local source
>
>   but neither worked.
>
>   The <src> part of the refspec is a commit object.
>   Did you mean...

Looks great.

> I'm not sure about saying "branch or tag" in the first bullet. It's
> friendlier to most users, but less technically correct (if you said
> "notes/foo", I believe we'd match an existing "refs/notes/foo", because
> it's really just using the normal lookup rules).

An alternative may be "looking for a ref that matches %s on the
remote side".  I am no longer a total newbie, so I cannot tell how
well that message would help one to connect notes/foo one just typed
with refs/notes/foo that potentially exists on the remote side.

> Also, as an aside, I wonder if we should allow "heads/foo" to work as
> "refs/heads/foo" (even when no such ref already exists). But that is
> totally orthogonal to changing the message.

I am neutral on this point but agree that it is better done outside
this patch.
