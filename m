Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B4E1F462
	for <e@80x24.org>; Fri, 24 May 2019 10:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390503AbfEXKtQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 06:49:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55646 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390402AbfEXKtP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 06:49:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id x64so8866739wmb.5
        for <git@vger.kernel.org>; Fri, 24 May 2019 03:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LMelrTpYGv8j9tdwUFEQl94SWrVNmVpjy7KduyNZN/U=;
        b=E7iBTj+Sa/l4mhMtzVFBllK/JzI2okLSPuZCRz0DD2ms8Z1gIitOx5LEiIQhMhfVlR
         f2zrs75jQZ0+Bft5niaiCM9TIJ/cccrYXdgYyI4JwcTq9V7G5MMY5N6fSHEexailMlaP
         6/yz4JeMeT/K23rbxb0yTgKUm9PXuERU/mSu4uXkXbAdZd5Oiy8ptO+7dVFk6+JCONfk
         N4r+x7fW0xNSLgeb1UMJiEir898GVIm6xkDcuqSTC51ZAF4ZgFXcLpxEIehOL5CcIOYI
         wgZz6nomrhzXZwvo2ey7n9NqKZ7YE4MnPKs5oIBxzXpX+UXpXFMV9XxcH4Cld9P4MMkl
         Y3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=LMelrTpYGv8j9tdwUFEQl94SWrVNmVpjy7KduyNZN/U=;
        b=Pj53gXNL0dbQUCtp03zOT8TwDrsBjYIOTvC4mBW8zfePFYt9M+HI2SbJIJTrdTfFFb
         N5Lx0zi2HEo7NUURVhWnOzzzmCF/1nCN/HAyE3sJCZSnGRza2DqstfcsO2eMxCl0SSUk
         oyLxTxpDZASTasEAPt3JkifKvQWFbuSIr5g/m8hQQRes9ODQVoMLm+UKbcyt/hSZMgz6
         gdXLg8Bk+yMcZsjLaiEAsKhWeCojS2iLSDM/Aqkt1SqGdO15WlRbPM7+b1Pd4+z1wGFv
         0nwDAhCOk3kwNuJsN+oGLAJfT2rAmok3MZyKGeBBns6S4SZXLndix/y+Idje1PwGke9/
         bssw==
X-Gm-Message-State: APjAAAUX6eu1/vv/uw6Yo1Fd2JtXhMScDSgNewo3Wr+/t2VvPREhDEsG
        W23puNagNuhTvfwT0pOKIC9YXy3jYbM=
X-Google-Smtp-Source: APXvYqwEHzVSAZoN0NrkzRhoMcbh8j+sTOgta6cH7Dmp/hEiJaqZu68u5JNz/CAVE3Ns7CwTuv+QGQ==
X-Received: by 2002:a1c:be19:: with SMTP id o25mr14906691wmf.138.1558694954185;
        Fri, 24 May 2019 03:49:14 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id y132sm2939630wmd.35.2019.05.24.03.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 03:49:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Karl Ostmo <kostmo@gmail.com>, git@vger.kernel.org
Subject: Re: standalone library/tool to query commit-graph?
References: <CAECbv94KF9MhzZqa8BR-RL93mh0NuD3vA69pAT-sY5O74e_duQ@mail.gmail.com> <be719a37-ffa0-26d3-eb9c-0f5ccde52e7f@gmail.com> <86blztq8ap.fsf@gmail.com> <87tvdkg7ld.fsf@evledraar.gmail.com> <20190523222031.GC951@szeder.dev> <f05405d7-c78d-a0e4-75a1-d623f977400a@gmail.com> <20190524093459.GE951@szeder.dev> <87o93sfahj.fsf@evledraar.gmail.com> <20190524100653.GF951@szeder.dev>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190524100653.GF951@szeder.dev>
Date:   Fri, 24 May 2019 12:49:12 +0200
Message-ID: <87k1egf7pz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 24 2019, SZEDER G=C3=A1bor wrote:

> On Fri, May 24, 2019 at 11:49:28AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Fri, May 24 2019, SZEDER G=C3=A1bor wrote:
>>
>> > On Thu, May 23, 2019 at 07:48:33PM -0400, Derrick Stolee wrote:
>> >> On 5/23/2019 6:20 PM, SZEDER G=C3=A1bor wrote:
>> >> > On Thu, May 23, 2019 at 11:54:22PM +0200, =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason wrote:
>> >
>> >> >> and since the commit graph doesn't include any commits outside of
>> >> >> packs you'd miss any loose commits.
>> >> >
>> >> > No, the commit-graph includes loose commits as well.
>> >>
>> >> Depends on how you build the commit-graph.
>> >
>> > Yeah; I just didn't want to go into details, hoping that this short
>> > reply will be enough to jog =C3=86var's memory to recall our earlier
>> > discussion about this :)
>>
>> To clarify (and I should have said) I meant it'll include only packed
>> commits in the mode Karl Ostmo invoked it in, as Derrick points out.
>
> No, even in that mode it will include loose objects as well, if it has
> to; that's what the "and closes under reachability" part of Derrick's
> reply means and that's what I showed in our earlier discussion at:
>
>   https://public-inbox.org/git/20190322154943.GF22459@szeder.dev/

I should have said "include any commits outside of packs [to seed the
revision walk]".

As you correctly point out there *are* caveats to that, e.g. it's
possible to have packs & loose commits but you include everything
because of reachability.

For the purposes of the discussion Jakub started upthread the
not-quite-correct-but-close-enough mental model that we generally tend
to accumulate loose objects that later coalesce into packs is close
enough.

I.e. for that reason for most users a "git commit-graph write" won't
produce a graph with all reachable commits, e.g. try cloning git.git,
"git am"-ing a patch on top, and generate it again, it'll be the same
(unless you picked a humongous patch).

Similarly it'll be incomplete for most users that have
gc.writeCommitGraph=3Dtrue on since they use "gc --auto", and they're
likely in an in-between state where they have a semi-stale graph.

So building tools directly on top of it shouldn't be anyone's first
choice, instead walk the DAG and see if that walking code can as an
optimization optimistically consult the commit-graph.
