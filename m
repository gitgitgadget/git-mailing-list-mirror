Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B2D1FEEF
	for <e@80x24.org>; Tue, 22 Nov 2016 02:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754434AbcKVCJo (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 21:09:44 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:32931 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754309AbcKVCJn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 21:09:43 -0500
Received: by mail-qk0-f170.google.com with SMTP id x190so5231768qkb.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 18:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nFfixyDijk1N0lksf1Oo2HzFE6oylDOCjHpHCA9Ue14=;
        b=O72+TIezYN8nVXBtR4kokOho9KwPIwtk9/R8BwNlD78aNculxR6NEvt94VdZDhS5cI
         SeYNSF6qHd0vYcXQe2/vkNpTpVwy9X38vwknuDvNyCVx67MG9qaWG2sy/nP3MY1jS1b/
         smNIxOQuNcgB7tblzzGFlVWlu4v0c/e75HUdvjR/YLEWdBplrvzQLOKtZHG/nHRNwO6q
         jgUPuMc5Tw8zP+tA7QHg0D67eUaoID7JpDkE7DCsYZhzhERqrldtncx/Po0Taq78RSSP
         8Q1FBJlddmvqZ+5Mp03vc/dp1L1ajS2fjXastGPkSux7XFwZVIomEDRAL+Y8sOQoFNQs
         jmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nFfixyDijk1N0lksf1Oo2HzFE6oylDOCjHpHCA9Ue14=;
        b=JoPFdtmrmn1seA/e+zk3hbA6ltxgBo9aJKEs85OM9BdR9IDqiFgpdg3KAmU0G67QsO
         y6Hl9yxXo587mN0zdudL/tfSw06KDXikbCxS3UwcUDSkAazdzrBT/3MegwN5JwV9FX77
         uOO5JhdpBRzCb1IUVHUpWrOOpjaqO8KnMQGEDaZIc7MYcRYafbcFyoUoyy3/l3tKz6rk
         ViLt0jC9Y5X3ifwBjt19D6QJFvG+aE3bDPWesfGAIUAJ49GyMHH2CtrB4XGg5GyZ44qU
         Ek3YjszQOKA71JFlxfsTG/IkJMT5mOZRy4oVGVMvEHQfrC/lJVC3c8Xh8SOFnNBYKweM
         AO5g==
X-Gm-Message-State: AKaTC02A52oShQj7o3AHvNBoi/C/CDQxlUKlSkXozEFeRcX2fWFq+LPIk/rMVNkhIJZXyzh+mi8laHaPn7Zk4tDj
X-Received: by 10.55.186.3 with SMTP id k3mr21596816qkf.47.1479780582667; Mon,
 21 Nov 2016 18:09:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 21 Nov 2016 18:09:41 -0800 (PST)
In-Reply-To: <xmqqy40ch6wp.fsf@gitster.mtv.corp.google.com>
References: <20161121204146.13665-1-sbeller@google.com> <20161121204146.13665-4-sbeller@google.com>
 <xmqqy40ch6wp.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Nov 2016 18:09:41 -0800
Message-ID: <CAGZ79kb_4wWs_90AfsT932iPWbCXf6yRq875JUxoRZjUcsBW5A@mail.gmail.com>
Subject: Re: [PATCH 3/3] submodule--helper: add intern-git-dir function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 1:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Does this format correctly?
>
> I somehow thought that second and subsequent paragraphs continued
> with "+" want no indentation before them.  See for example the
> Values section in config.txt and see how entries for boolean:: and
> color:: use multiple '+' paragraphs.
>
> If we do not have to refrain from indenting the second and
> subsequent paragraphs, that would be great for readability, but I
> take the existing practice as telling me that we cannot do that X-<.

Will fix and test in a resend.


>
>> +test_expect_success 'setup a gitlink with missing .gitmodules entry' '
>> +     git init sub2 &&
>> +     test_commit -C sub2 first &&
>> +     git add sub2 &&
>> +     git commit -m superproject
>> +'
>> +
>> +test_expect_success 'intern the git dir fails for incomplete submodules' '
>> +     test_must_fail git submodule interngitdirs &&
>> +     # check that we did not break the repository:
>> +     git status
>> +'
>
> It is not clear what the last "git status" wants to test.

Any errors that I ran into when manually truing to embed a submodules
git dir, were fatal with `git status` already, e.g. missing or wrong
call of connect_work_tree_and_git_dir were my main failure points.

So I guess we should test a bit more extensively, maybe

    git status >expect
    git submodule embedgitdirs
    git status >actual
    test_cmp expect actual
    # further testing via
    test -f ..
    test -d ..

>  In the
> extreme, if the failed "git submodule" command did
>
>         rm -fr .git ?* && git init
>
> wouldn't "git status" still succeed?

    In that particular case you'd get
    $ git status
    fatal: Not a git repository (or any parent up to mount point ....)
    Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).
    $ echo $?
    128

but I get the idea, which is why I propose the double check via status.
That would detect any logical change for the repository, e.g. a
change to the .gitmodules file.

>
> What are the minimum things that we expect from "did not break" to
> see?  sub2/.git is still a directory and is a valid repository?  The
> contents of the .git/modules/* before and after the "git submodule"
> does not change?  Some other things?

I thought about making up a name for such a repo and creating that engry
in .gitmodules. But I refrained from doing so, because it seems too much
for this command.

I dunno, but I would suspect the double status is fine here, too?
