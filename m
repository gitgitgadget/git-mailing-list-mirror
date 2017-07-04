Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B76A0202AC
	for <e@80x24.org>; Tue,  4 Jul 2017 22:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbdGDWu2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 18:50:28 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38492 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbdGDWu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 18:50:27 -0400
Received: by mail-wm0-f44.google.com with SMTP id f67so96132320wmh.1
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/gIKnel3dLPobI/yzyp8vC+XbsLSeQr796puuvrR7JI=;
        b=L9E5UOdQkd+0AMAN2zVfvnZZwf790bP8ktvE/jdktB2+/QGpNfjMk4IWN6enxIr9U3
         Jhzv9pz9TJdLANI2k9FA52ueUN7tUo8yZJCaYePNXPmimj7Ihc5/VGZVR/7WxOE/mmLq
         wH3Hxq6OAT396QPGb30R+0ANVVGn2i8DI/jVOMRLnAADyN9c93R9mgrXTDDn0tUJShRf
         eQFD7aWUi59NqUak4zeI5lO/cuiHrZTlDIBa5Ds1L8Vr86eers5gNsPblAuDpz7QngiM
         JLsOIovlYkvFBT3ldtJCEEd1UjgFvr//tgj6N3nm6rYQLwEl3Ub9fLQfpwgT5wGiQ1uN
         rzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/gIKnel3dLPobI/yzyp8vC+XbsLSeQr796puuvrR7JI=;
        b=YwCaCT9lo1tNFMnzMb+0uEK49A5FFHyOjJZBZ4CFYKgBUMUp8gJe8z2xYgIFo5X6Yq
         WT+udn+d86BLUhnpnSeFw/y85yZn0hO3laymKsjawwcmJDBZ242jwYfB3xzLv7+QETmE
         GZ2IUIvROvN4nKJE92IHdVx7uUCRP6PHzPwCvyPptfOmg0pQcwbMG+GFMs9HC5EfblnA
         Pk16TadwCzD4s+n4tMvkr+E1kmqYnRJvLKTuV8oQOMv+DA8Q4PzsGLp7jA3/Gspz0LFk
         PYn+eyKS0fIo1EdcqNW7WhbAK57joKGXud2oBWGtzBlPbjAuHS0hKHl1AtA/nHeB1m2k
         OJQA==
X-Gm-Message-State: AKS2vOxKMENjFv5Y8SXCBBlQNQd4C0hWV9e/yRvm0KTasPa7Gf/fUjgs
        mSPPf8GtBg6R6A==
X-Received: by 10.80.134.42 with SMTP id o39mr19809386edo.93.1499208625885;
        Tue, 04 Jul 2017 15:50:25 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id l3sm10183621edc.32.2017.07.04.15.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jul 2017 15:50:23 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dSWeE-00063h-1P; Wed, 05 Jul 2017 00:50:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
References: <20170701220547.10464-1-avarab@gmail.com> <20170627121718.12078-1-avarab@gmail.com> <20170701220547.10464-3-avarab@gmail.com> <xmqqa84lmonj.fsf@gitster.mtv.corp.google.com> <874lutclie.fsf@gmail.com> <xmqq4luskt9l.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqq4luskt9l.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 05 Jul 2017 00:50:22 +0200
Message-ID: <87fuebbyvl.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 04 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>>> diff --git a/.gitmodules b/.gitmodules
>>>> new file mode 100644
>>>> index 0000000000..cbeebdab7a
>>>> --- /dev/null
>>>> +++ b/.gitmodules
>>>> @@ -0,0 +1,4 @@
>>>> +[submodule "sha1collisiondetection"]
>>>> +	path = sha1collisiondetection
>>>> +	url = https://github.com/cr-marcstevens/sha1collisiondetection.git
>>>> +	branch = master
>>>
>>> Do we need to say this "branch" bit?
>>
>> Yes, it's to make future updates easier, see b928922727 ("submodule add:
>> If --branch is given, record it in .gitmodules", 2012-12-19).
>
> Why?  It's not like we want to _follow_ the 'master' branch of that
> sha1collisiondetection repository.  We declare that a specific
> commit from the (sub)module is suited for our project, and do not
> really care to automatically update from whatever happens to be at
> the tip of 'master' there.

I'm honestly at a bit of a loss as to to what the confusion is here. So
to try to unravel that let's start from square one, explaining some
things you surely know already, but hopefully clearing this up.

> It's not like we want to _follow_ the 'master' branch of that
> sha1collisiondetection repository.

Git has no support at all for submodules that somehow follow an upstream
branch in the SVN sense of remotes, so no, that's not what putting
"branch" into the .gitmodules config means at all.

> We declare that a specific commit from the (sub)module is suited for
> our project, and do not really care to automatically update from
> whatever happens to be at the tip of 'master' there.

There is no automatic updating involved. The "master" branch here is
just metadata. If and when we bump the sha1collisiondetection submodule
that's going to be from the master branch, so by recording it we save
ourselves one step (in theory) by issuing some "pull updates from the
branch we always update from" command, rather than being at a loss as to
where we should go from the currently detached ref to N potential
upstream branches to update from.

Now, it seems git-submodule's tooling for doing this is still rather
crappy, but I think that's the idea, maybe I'm just holding it wrong.

Before git ever got this "branch" key in .gitmodules I'd added it to my
own aliases (and they're happily compatible with git-submodule). It
still (for me) works better than what git-submodule does:

    $ git config alias.sm-mainbranch
    !git config --file ../.gitmodules submodule.$NAME.branch || git describe --all --always | sed 's!^heads/!!'
    $ git config alias.sm-pull-all
    !git submodule foreach 'git checkout $(NAME=$name git sm-mainbranch) && git pull'

So in a repo with submodules I can simply run "git sm-pull-all" and
it'll update them all to the branch they're tracking, and at this point
I can "git add" them and review the updates.

I think some invocation of "git submodule update ???" will do the same,
but I can't from the docs see what that is right now.

In any case, if and when I/others figure that out the metadata will be
there, saving us one step in updating this in the future.

>>
>>> Other than that looks good to me.
>>>
>>> Thanks.
