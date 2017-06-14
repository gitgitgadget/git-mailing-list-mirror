Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F272920282
	for <e@80x24.org>; Wed, 14 Jun 2017 17:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbdFNRxP (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 13:53:15 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35443 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbdFNRxN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 13:53:13 -0400
Received: by mail-pf0-f178.google.com with SMTP id l89so3774870pfi.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 10:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KX2MGTxYaAV+TpdfFqI9L161NXOumk6CmcfF3wCfmvY=;
        b=OK6xM5VmjXNAl+tiSUgkk+7jbbZgt3NssfgtvGOUXjRFUglNJzKkkXG6Jvai3MBwvk
         Fjge1rP1QZrJt07RpKkw28lyaDcs8s5ukYqX9cIuYN3jMZrA/cpZrEFiHa/5gTdk1C+s
         DlnII+VxzGxTM/7kT0cRGqT7VXGrDaeRhvs3j0/ETGUtqb21sZXt7bRf0BaUSGCl1sSA
         oC8TFUrMhdL5hHEz22nUk2Pc0ZoaVtlDi1JhnRAKz5cKu1NR59y2TvBevW6dGgj1tOnu
         sPVHsDrCrWCzhF+boo/Q7g1GHonM5Ah8xPBSri2vFDqq7RVA1DVN6ampixuGGh0dZsuH
         oW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KX2MGTxYaAV+TpdfFqI9L161NXOumk6CmcfF3wCfmvY=;
        b=cdO2wnJbvrurerFVcW8iq+5wsarr9IPHEQ9kbI1Xi/0mnNfGObPLs28ItjVSmSv3A+
         BZFZ1cXpL1XJgJkf+3xKDiI1WjFu2qYdbFzwSNbZayvvEBm1yH/jVLlgtO9wz3vWjCIU
         qaa3P21lRuANb6i/1X+WSqXnbwnv4VsuqJSjHe6uFhJSikZRekmvikk4UAFgzHDYO0WU
         owY3wWKDaDdhtQDvlYTw/hlucZNW7U6h36cNediMyjBW0lMphLtXWwdmVFEqW3ky3iAj
         KDw4TO8S+0bLf8UCAU7fLB6S7Z/GM8vluD2Kh8a3DCX6iWKXx9Ew5EMkATX6cuk/PzU4
         +rAw==
X-Gm-Message-State: AKS2vOzHLI8+4kdY++FQzIdLTSkwdZWz9s3qxCLMJNnIrASLWkXyXKjj
        aoTaVPc0jAeSEgdYM7JztGpvi5rmdL+k
X-Received: by 10.84.137.165 with SMTP id 34mr1320092pln.167.1497462793015;
 Wed, 14 Jun 2017 10:53:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Wed, 14 Jun 2017 10:53:12 -0700 (PDT)
In-Reply-To: <20170614063614.a34ovimjpz2g24qe@sigill.intra.peff.net>
References: <20170613091452.ew2rwx5r6axxo65p@sigill.intra.peff.net>
 <20170613092408.db22ygki6wg2t23d@sigill.intra.peff.net> <CAGZ79kbbTwQicVkRs51fV91R_7ZhDtC+FR8Z-SQzRpF2cjFfag@mail.gmail.com>
 <20170614063614.a34ovimjpz2g24qe@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Jun 2017 10:53:12 -0700
Message-ID: <CAGZ79kaN=XVe3OWE5DHsMfbzW_rZOdRurgSfpz52dSZDA_V6fg@mail.gmail.com>
Subject: Re: [PATCH 1/2] add: warn when adding an embedded repository
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 11:36 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 13, 2017 at 10:07:43AM -0700, Stefan Beller wrote:
>
>> > I also waffled on whether we should ask the submodule code
>> > whether it knows about a particular path. Technically:
>> >
>> >   git config submodule.foo.path foo
>> >   git config submodule.foo.url git://...
>> >   git add foo
>> >
>> > is legal, but would still warn with this patch. I don't know
>> > how much we should care (it would also be easy to do on
>> > top).
>>
>> And here I was thinking this is not legal, because you may override
>> anything *except* submodule.*.path in the config. That is because
>> all the other settings (such as url, active flag, branch,
>> shallow recommendation) are dependent on the use case, the user,
>> changes to the environment (url) or such. The name<->path mapping
>> however is only to be changed via changes to the tracked content.
>> That is why it would make sense to disallow overriding the path
>> outside the tracked content.
>
> It was probably a mistake to use normal config as the example. Junio
> mentioned it as a case that could work if you communicate the submodule
> URL to somebody else out-of-band. My understanding was that you could
> set whatever you like in the regular config, but I think that is just
> showing my ignorance of submodules.
>
> Pretend like I said "-f .gitmodules" in each line above. ;)
>
>> In my ideal dream world of submodules we would have the following:
>>
>>   $ cat .gitmodules
>>   [submodule "sub42"]
>>     path = foo
>>   # path only in tree!
>
> TBH, I am not sure why we need "path"; couldn't we just use the
> subsection name as an implicit path?

That is what was done back in the time. But then people wanted to rename
submodules (i.e. move them around in the worktree), so the path is not
constant, so either we'd have to move around the git dir whenever the
submodule is renamed (bad idea IMO), or instead introduce a mapping
between (constant name <-> variable path). So that was done.

Historically (IIUC) we had submodule.path.url which then was changed
to submodule.name.url + name->path resolution. And as a hack(?) or
easy way out of a problem then, the name is often the same as the path
hence confusing people, when they see:

    [submodule "foo"]
        path = foo
        url = dadada/foo

What foo means what now? ;)
As a tangent: I want to make the default name different to the path.

So yeah, we want to keep the name and not mingle with implicit path.

I think we may even have bugs in our code base where the
name/path confusion shows.

Talking about another tangent:

  For files there is a rename detection available. For submodules
  It is hard to imagine that there ever will be such a rename detection
  as files have because of the explciit name<->path mapping.

  We *know* when a submodule was moved. So why even try
  to do rename detection? As we record only sha1s for a submodule
  you could swap two submodule object names by accident.
  Consider a superproject that contains different kernels, such as
  a kernel for your phone/embedded device and then a kernel for
  your workstation or other device. And these two kernels are different
  for technical reasons but share the same history.

  Now the inattentive user may make a mistake and git-add the
  "wrong" kernel submodule.  The smart Git would tell that it is a
  rename/move just as we have with files.

>
>> > +       OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
>> > +                       N_("warn when adding an embedded repository")),
>>
>> We do not have a lot of OPT_HIDDEN_BOOLs throughout the code base.
>> We should use them more often.
>>
>> It makes sense though in this case.
>
> Actually, my main reason is that it's nonsense to show
> "--warn-embedded-repo" in the help, when it's already the default. I
> would like to have written:
>
>   OPT_NEGBOOL(0, "no-warn-embedded-repo", &warn_on_embedded_repo,
>                 N_("disable warning when adding an embedded repository"))
>
> but we don't have such a thing (and the last discussion on it a few
> months ago left a lot of open questions). So given that this really
> isn't something I'd expect users to want, I figured hiding it was a good
> idea. I mentioned it in the manpage for script writers, but it's really
> not worth cluttering "git add -h".

ok :) If you really wanted, you could go with a raw OPTION though. ;)
This is fine with me though.

>
>> > +static const char embedded_advice[] = N_(
>> > +"You've added another git repository inside your current repository.\n"
>> > +"Clones of the outer repository will not also contain the contents of\n"
>> > +"the embedded repository. If you meant to add a submodule, use:\n"
>>
>> The "will not also" sounds a bit off to me. Maybe:
>>   ...
>>   Clones of the outer repository will not contain the contents
>>   of the embedded repository and has no way of knowing how
>>   to obtain the inner repo. If you meant to add a submodule ...
>
> Yeah, I think we could just strike the "also" (I played around with the
> wording here quite a bit and I think it was left from an earlier attempt
> where it made more sense).
>
> Your "no way of knowing" is probably a good thing to mention.
>
>> > +"See \"git help submodule\" for more information."
>>
>> Once the overhaul of the submodule documentation
>> comes along[1], we rather want to point at
>> "man 7 git-submodules", which explains the concepts and
>> then tell you about commands how to use it. For now the
>> git-submodule man page is ok.
>>
>> [1] https://public-inbox.org/git/20170607185354.10050-1-sbeller@google.com/
>
> Yeah, I poked around looking for a definitive "here's how submodules
> work" intro. I'm happy one is in the works, and I agree this should
> point there once it exists.
>
>> > +++ b/t/t7414-submodule-mistakes.sh
>> > @@ -0,0 +1,40 @@
>> > +#!/bin/sh
>> > +
>> > +test_description='handling of common mistakes people may make with submodules'
>>
>> That is one way to say it. Do we have other tests for
>> "you think it is a bug, but it is features" ? ;)
>> I like it though. :)
>
> Heh. I didn't know how else to lump it together. Just "test git add on a
> repository" felt like too little for its own script. I almost added it
> to t7400, but I think that script is plenty long enough as it is (it's
> also one of the longest-running scripts, I think).

Thanks for not doing that. :)
