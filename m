Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21AF1FD09
	for <e@80x24.org>; Mon, 29 May 2017 04:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbdE2EU5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 00:20:57 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35890 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdE2EU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 00:20:57 -0400
Received: by mail-pg0-f48.google.com with SMTP id x64so17142162pgd.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 21:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nleHqJ1g87kLfkqrUoksGeySfIJJziXpLZqjgrL2k9k=;
        b=t0bck4It/qc8olQvlDsW0U+kKs5M7QlZZCddQs+rdoHcnTFp9DyBc3Km2+f1zqjOga
         BYtKlYqPD1rl6uOY7gDBEHZDZg3qUN+fC2V/WG3CzZEVDoxsHhKMHVLxOMY2/B8NBYxb
         sNvuHTlMIeMqTez4B1zjVbBf6brJf2vCHNxikcGqNGOfa73SwlzAexwagrWBmMHuh+do
         ih12X2WYdEtqmYaKhB49rqMrywVvlpCJ1W0bSM26/BB8rRZrldwHpeIvIIbNaKNolyBu
         9bgB15lPs7jQuhNVpeqc6qkGfMx6t7iW2dKMUViAwe7CNZW0rgmiJThBssa8uf04/qQD
         XZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nleHqJ1g87kLfkqrUoksGeySfIJJziXpLZqjgrL2k9k=;
        b=c0lFkqsSsFRwPI037iU3DV49DuS7gveRFo+8vjsNNF3I1ZpTc55d102y7apTyMt65J
         6WRH/e81bml70qg/KcAn3F6B4hgQdyOA9ufzh64hbNxCDuUhmhBsElmJBSEDC4nenk6w
         sMFrVdpU5qMAin4s1ON9qH9Ih75k5gCQirMwT2hG45VM4ZWSJKRNgpLa2stF77ffDo0L
         4PxL044+xx28c/xpVmp8rRgeVxVUc6LOVPpyPNtZseF6uW75BURUU7mjXnKOrwc3j44N
         fuYrBwRGrWDQ1NN69OAvwBG3ggudjfQRRBWsPOrvkGN+6EkkdvIEmSU2nkUX2IqALJZY
         aUHQ==
X-Gm-Message-State: AODbwcA7d1osfSHgDQjxkFwih4+vSnVK20cJyuAfXdxF46ppWiNiF6Eb
        vFjzxxGDhH4RsSaJistnhG5aGN3qNaTL
X-Received: by 10.99.116.7 with SMTP id p7mr16356774pgc.162.1496031656272;
 Sun, 28 May 2017 21:20:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Sun, 28 May 2017 21:20:55 -0700 (PDT)
In-Reply-To: <xmqqinkk8jqm.fsf@gitster.mtv.corp.google.com>
References: <CAE5=+KX57KM+6n9NpePw9KYPXFy7UH-WRgSwaJDnvRofYFXm7Q@mail.gmail.com>
 <xmqqinkk8jqm.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 28 May 2017 21:20:55 -0700
Message-ID: <CAGZ79kYHNpsasqhTY2WrCYgNU1if-pK7UznJV9AWEhxVf6_GvQ@mail.gmail.com>
Subject: Re: git push recurse.submodules behavior changed in 2.13
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        John Shahid <jvshahid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 7:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Shahid <jvshahid@gmail.com> writes:
>
>> It looks like the git push recurse-submodules behavior has changed.
>> Currently with 2.13 you cannot run "git push
>> --recurse-submodules=on-demand" if the parent repo is on a different
>> branch than the sub repos, e.g. parent repo is on "develop" and
>> sub-repo on "master". I created a test that can be found here [1].
>>
>> A bisect shows that the change to propagate refspec [2] to the
>> submodules is the culprit. imho this is an undesired change in
>> behavior. I looked at the code but couldn't see an easy way to fix
>> this issue without breaking the feature mentioned above. The only
>> option I can think of is to control the refspec propagation behavior
>> using a flag, e.g. "--propagate-refspecs" or add another
>> recurse-submodules option, e.g. "--recurse-submodules=propagate"
>>
>> What do you all think ?
>>
>> [1] https://gist.github.com/jvshahid/b778702cc3d825c6887d2707e866a9c8
>> [2] https://github.com/git/git/commit/06bf4ad1db92c32af38e16d9b7f928edbd647780
>
> Brandon?  I cannot quite tell from the report what "has changed"
> refers to, what failures "you cannot run" gets, and if that is a
> desirable thing to do (i.e. if letting the user run it in such a
> configuration would somehow break things, actively erroring out may
> be a deliberate change) or not (i.e. an unintended regression).
>

Before the refspec was passed down into the submodules,
we'd just invoke "git push" in the submodule assuming the user
setup a remote tracking branch and a push strategy such that
"git push" would do the right thing.
And because the submodule is configured independently, it
doesn't matter which branch you're on in the superproject.

Looking at the test[1], you run "git push --recurse-submodules"
without any remote/branch that was called out in the commit
message[2] to not have changed. Is that understanding correct?

Looking at the test cases of [2] we did not test for explicit
"still works with no args given", though one could have expected
we'd have a test for that already. :/

Thanks,
Stefan
