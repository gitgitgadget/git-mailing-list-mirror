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
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A6E1F462
	for <e@80x24.org>; Mon, 27 May 2019 14:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfE0O3d (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 10:29:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39719 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfE0O3d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 10:29:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id e24so27012775edq.6;
        Mon, 27 May 2019 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=R1AzxQRXU80ZX5XlNuDiv+NBZP+OSp10LmHxXSL0x0w=;
        b=AiCWHoCAvp7FsuBpthidNFx/02mjK0qH0iS0s0JJyqwmtUEJ7pK46F519eHsPQK9YD
         iHApNZRWjr9Sqaj9pfDK11l1BTfugz2Aw2qi67tjsJwz9JdfyZ21ictjTY4OtHF9lfqk
         UAT1fB1y84EsTHu7RIidW4w/pP025+m6r8rq4+sNHf1D8yHSDSkYLMUV1Vhm20aMmPuX
         j5N8KxFO/30zdUe637oW2mJrZ4on+E0uMtGuGhYUGs5gL228gRn8aTuiXdupz+8ICsa2
         wIUl11FDF34EqNDQS+5QhSPlyX2Y1kdeQfsiupaIfFesi40cWWfHnGugFAbF0PAvDtZF
         zqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=R1AzxQRXU80ZX5XlNuDiv+NBZP+OSp10LmHxXSL0x0w=;
        b=Ipxhhq3np0zp48SMXBBuQZ8DzNBvLssk7C8Kphg4/c+W5orPqgsPKGFq9QYME+wku1
         +0q84AlonhsaSbnl+Jo+TKMfeLotxUu6Gnk7qlcEkwJBIpdPyJdpglO0IiIH7626uu3j
         nGOurZD2ebztN5OdJeJ0vfJl945ArRHmt0LPVqa3LfnmdrmItp1diTsoja+XnHVl0eV9
         atelkbNMrK7IpU7Eq7TetMUt2X5QcpxqckVODlR/zmRdl6e9TxFuaa+0lyoYake0xoNp
         FIcdBZVghKZNeFyGx8peEP1gK9gm4vZYrzibrSAbk9Zk9otLA5x2/sNKoffFcofi9YbJ
         UPMw==
X-Gm-Message-State: APjAAAXMFMV4Q9isB32P639sW0G26MkXOevb2M88F4FfczI+Ro6x6KLp
        1KhnuL8Sv1CR/EmfBPZOtME=
X-Google-Smtp-Source: APXvYqxY4ajZ79OyA5ygAapQwFXXc0kzlW/Sjz7E9RhvuT2PC6ddGjwjP1kAcvHkPzknFkbdDKyoYg==
X-Received: by 2002:a17:906:d215:: with SMTP id w21mr53198737ejz.122.1558967371143;
        Mon, 27 May 2019 07:29:31 -0700 (PDT)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id v16sm3358696edm.56.2019.05.27.07.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 07:29:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] refs: tone down the dwimmery in refname_match() for {heads,tags,remotes}/*
References: <CAHk-=wgzKzAwS=_ySikL1f=Gr62YXL_WXGh82wZKMOvzJ9+2VA@mail.gmail.com> <20190526225445.21618-1-avarab@gmail.com> <5c9ce55c-2c3a-fce0-d6e3-dfe5f8fc9b01@redhat.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <5c9ce55c-2c3a-fce0-d6e3-dfe5f8fc9b01@redhat.com>
Date:   Mon, 27 May 2019 16:29:28 +0200
Message-ID: <874l5gezsn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 27 2019, Paolo Bonzini wrote:

> On 27/05/19 00:54, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> This resulted in a case[1] where someone on LKML did:
>>
>>     git push kvm +HEAD:tags/for-linus
>>
>> Which would have created a new "tags/for-linus" branch in their "kvm"
>> repository, except because they happened to have an existing
>> "refs/tags/for-linus" reference we pushed there instead, and replaced
>> an annotated tag with a lightweight tag.
>
> Actually, I would not be surprised even if "git push foo
> someref:tags/foo" _always_ created a lightweight tag (i.e. push to
> refs/tags/foo).

That's not the intention (I think), and not what we document.

It mostly (and I believe always should) works by looking at whether
"someref" is a named ref, and e.g. looking at whether it's "master". We
then see that it lives in "refs/heads/master" locally, and thus
correspondingly add a "refs/heads/" to your <dst> "tags/foo", making it
"refs/heads/tags/foo".

*Or* we take e.g. <some random SHA-1>:master, the <some random...> is
ambiguous, but we see that "master" unambiguously refers to
"refs/heads/master" on the remote (so e.g. a refs/tags/master doesn't
exist). If you had both refs/{heads,tags}/master refs on the remote we'd
emit:

    error: dst refspec master matches more than one

(We should improve that error to note what conflicted, #leftoverbits)

So your HEAD:tags/for-linus resulted in pushing a HEAD that referred to
some refs/heads/* to refs/tags/for-linus. I believe that's an unintendedem
ergent effect in how we try to apply these two rules. We should apply
one, not both in combination.

And as an aside none of these rules have to do with whether the <src> is
a lightweight or annotated tag, and both types live in the refs/tags/*
namespace.

> In my opinion, the bug is that "git request-pull" should warn if the tag
> is lightweight remotely but not locally, and possibly even vice versa.
> Here is a simple testcase:
>
>   # setup "local" repo
>   mkdir -p testdir/a
>   cd testdir/a
>   git init
>   echo a > test
>   git add test
>   git commit -minitial
>
>   # setup "remote" repo
>   git clone --bare . ../b
>
>   # setup "local" tag
>   echo b >> test
>   git commit -msecond test
>   git tag -mtag tag1
>
>   # create remote lightweight tag and prepare a pull request
>   git push ../b HEAD:refs/tags/tag1
>   git request-pull HEAD^ ../b tags/tag1

Yeah, maybe. I don't use git-request-pull. So maybe this is a simple
mitigation for that tool since you supply a <remote> to it already.

I was more interested and surprised by HEAD being implicitly resolved to
refs/tags/* in a way that would be *different* than if you didn't have
an existing tag there, but of course if we errored on that you might
have just done "+HEAD:refs/tags/for-linus" and ended up with the same
thing.

As an aside, in *general* tags, unlike branches, don't have "remote
tracking". That's something we'd eventually want, but we're nowhere near
the refstore and porcelain supporting that.

Thus such a check is hard to support in general, we'd always need a
remote name and a network roundtrip. Otherwise we couldn't do anything
sensible if you have 10 remotes of fellow LKML developers, all of whom
have a "for-linus" tag, which I'm assuming is a common use-case.

But since git-request-pull gets the remote it can (and does) check on
that remote, but seems to satisfied to see that the ref exists somewhere
on that remote.
