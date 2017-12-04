Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F8E620A40
	for <e@80x24.org>; Mon,  4 Dec 2017 10:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753547AbdLDK4A (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 05:56:00 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:45620 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752922AbdLDKz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 05:55:59 -0500
Received: by mail-pf0-f175.google.com with SMTP id u19so8221938pfa.12
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 02:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:from:message-id;
        bh=YJyhatkY0pyDsAY2mxAemGv8sm1xKhnZBNi97iPn8/g=;
        b=d/8sum33c90P5wU1PSL3I8WWlDzGzjHmFAK2A0o0jTZM2bUsy8hMUCxtLoA3UbTjdO
         G7yaI2qmBktWO0K/Fn0B6gqe4hQsST8hYMTO9zETMHiu689HnaJhOxhM2QsDY2xCBGSG
         e0H0OtaAwDSthbwNT+39MIvFi82ZPlbvwzyiDk2zIso3BYXX0y6QivWC3dKljr9gVK4X
         osgrVdLlrGqTztnLJWe8TUX7qG1f+l0YHLWRG4a6hN9HLpSlFkrNG/3b09e3s1FquwbP
         4tU69V9F+FoELQTatCzPqJ32tfYEVHedl0STX06tVRCiAE2bRr/x6Pax4hWC6CreeJ7U
         RRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:from:message-id;
        bh=YJyhatkY0pyDsAY2mxAemGv8sm1xKhnZBNi97iPn8/g=;
        b=KjebBUfDct099bu0OxES87XrL+b6d34kabuQDXmr0GR9ckFFl9vMpDJcW8ZoJtl56h
         dEq3r7cpySgM8QboY1z8EQ12srev7921dEKZsI1vUt8yUT60BsxCZ1hZQV3n/YGqMGVd
         oUyDZg8sXRsWVZ5GdCxOh5vJ6l0RFqE1xigDXEhXLENpTD9bQzwTPe+6ucWxhzXNQbT0
         J5kBTRGpOfMM1tM1Ty5dc4kqughcHjkt/fvQGOdACr6dQ9eGMSgfB87nKXWi327FInml
         jqbXBWGPJY0vLG+jhHTUeIyRo9wJTQVHok4Hy48PNBg0xYijSbzK8XNpD738epRfw+U3
         m/Xg==
X-Gm-Message-State: AJaThX7fOFoziB9vT13ZEsO6Bi/fL2V/wpVQD7TUe1er1cKHL90T2dR0
        3609iz5SusBA6HBlgqbh31g=
X-Google-Smtp-Source: AGs4zMaOYIAf8lzwPSH66D7Y8vXZykxb+6Gs+JhvQtnjdWvVAAXnCV4Prjw5fjU0AM1k8wevJ94jpw==
X-Received: by 10.99.95.194 with SMTP id t185mr13219554pgb.177.1512384958928;
        Mon, 04 Dec 2017 02:55:58 -0800 (PST)
Received: from [192.168.1.124] (50-39-169-152.bvtn.or.frontiernet.net. [50.39.169.152])
        by smtp.gmail.com with ESMTPSA id o5sm3218593pgv.49.2017.12.04.02.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 02:55:57 -0800 (PST)
Date:   Mon, 04 Dec 2017 02:55:52 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJsT1ck6dCPLLMLjgq9jrQmOAC-6jF6kFEX6aaRJGw3Hn9He=w@mail.gmail.com>
References: <CAJsT1ck6dCPLLMLjgq9jrQmOAC-6jF6kFEX6aaRJGw3Hn9He=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Git stash (or git rev-parse) doesn't inherit the '--work-tree' parameter
To:     marc PINHEDE <marc.pinhede@gmail.com>, git@vger.kernel.org
From:   Jacob Keller <jacob.keller@gmail.com>
Message-ID: <70EAB5BC-F04B-475D-9F82-8CFDD7817C1F@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On November 29, 2017 11:02:10 PM PST, marc PINHEDE <marc=2Epinhede@gmail=
=2Ecom> wrote:
>Hello guys,
>
>I don't know if this is a normal behavior, so I'll just explain it
>here=2E
>
>* Behavior:
>
>from a directory OUTSIDE my git repo, I can run this command
>successfully:
>$ git --git-dir=3D/my/repo/path/=2Egit --work-tree=3D/my/repo/path pull
>origin master
>
>But this one:
> $ git --git-dir=3D/my/repo/path/=2Egit --work-tree=3D/my/repo/path stash
>Will fails with :
> 'fatal: $program_name cannot be used without a working tree=2E'
>(Yes, the error message has been corrected since, but I use debian, so
>I'm at least 6 month late)=2E
>
>* A bit of investigation:
>I don't know many about git internal functioning, but with a bit of
>googleing, I would point out git-sh-setup=2Esh:204, in function
>require_work_tree, called by git-stash=2E
>I could test (from outside my git repo, again):
> git --git-dir=3D/my/repo/path/=2Egit --work-tree=3D/my/repo/path rev-par=
se
>--is-inside-work-tree
>return:
> false

It's possible that is-inside-worktree is testing if current dir is inside =
work tree, and not if the work tree variable is=2E=2E=2E Thus I wouldn't ex=
pect this to behave as you seem to expect=2E

>
>What surprise me is that 'git-dir' seems to be passed ok to rev-parse:
>git --git-dir=3D/my/repo/path/=2Egit --work-tree=3D/my/repo/path rev-pars=
e
>--git-dir
>returns:
> /my/repo/path/=2Egit
>
>* Question
>Is this a normal behavior? Stash can only be applied in current
>working directory?
>If yes, I'll have to change my script to
> (cd && git command)
>If not, should I push a bug report somewhere?
>
>Marc


It doesn't sound like normal behavior to me=2E=2E=2E Does "git -C" work?

Either way id expect setting the work tree and got dir to work for most co=
mmands=2E

However, it may not of the command expects current dir to matter=2E That's=
 where using -C comes into play=2E Try that and see if it fixes your proble=
m=2E

That is, git -C <path to work tree> stash

Thanks,
Jake

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
