Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11571F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbcHARTV (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:19:21 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38763 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726AbcHARTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 13:19:17 -0400
Received: by mail-wm0-f52.google.com with SMTP id o80so254355649wme.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 10:18:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tsC8QLTaXVfVxH7VS82150yCM7hK4gqCNQlU4tkJnTA=;
        b=IVuHBrBmfYRkdicFhDLPXTE6TpLLqReV2Gk94W3CRFeHyMxox/w6jdFnynUQTLeFZa
         AJXcPN8UvWP+1uigVDE7oWr3Lk8QY+h+XHvm9KPP41BHiexzavYOFbLYYJa309ltORWq
         B2xp6NdahP3jdoRQJ4GW37cwCgV1A1fvieqjxho1GKGqOyqeRye6vjXJi8AlOiNPMgiS
         ql5pipcnKqAvqOx/I95Mu5T3owFsGLkRp6jhVtbjRdpgnCbSGCprvb4Ob0DpGk0HPhqu
         qklvnf7ClG9FBvEaWH12AWN/eR0WJAo2koK2Y+WIC3h3rGT1TuYXpSQ91BByhXcJ+hu1
         viMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tsC8QLTaXVfVxH7VS82150yCM7hK4gqCNQlU4tkJnTA=;
        b=QpNbApg4AWw6S7KlkEl9MUmjY6dJZAxjdnCzfwwltSokv0Hpmlh8vd/FtTNRtQPH4h
         X4Rf6ydxenUZN9Nrhfr9bfzp9KSJWyOQVq94I6VF+uc3dmZoBNApDkp8GfFad1TFPK73
         /q12nQ7eMjsrTLpUsXUZSWslZavNNUJvhSuPmIgdDlhPkhhsmuFGm0oc4j/Uq0lLC0QT
         HQ7svdlSs7FdI3a7yYrYd2gEsYu/HLUl59DP0+Aff3JylZyfR1zF2ZgPYjD6SilONRXL
         /VztKJzAmSnA5ypQC821RJnETXeLm6++5jlxtK5WaTRF6HAT7QbAWeFRekT9d3h9cHQg
         YGmQ==
X-Gm-Message-State: AEkoouujSXJBQ+sfeF4xkDa2Qt2WwDlCbPzk+V9azh5o7oHvcS1dX/jdMpu7zZNl4LCJyiDuEdljmq0Wks6+8A==
X-Received: by 10.28.88.144 with SMTP id m138mr54268416wmb.79.1470066095756;
 Mon, 01 Aug 2016 08:41:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Mon, 1 Aug 2016 08:41:35 -0700 (PDT)
In-Reply-To: <CABEd3j--sxCwv6fWmNxTtdpgwU0_YKbfiFONX6TsQFZGn79yuQ@mail.gmail.com>
References: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
 <xmqqinvonwxc.fsf@gitster.mtv.corp.google.com> <CABEd3j-MW--YSC9=nwcgHzxd6cqmUY+ky3-wLxMiMmbBGsvS7Q@mail.gmail.com>
 <CABEd3j--sxCwv6fWmNxTtdpgwU0_YKbfiFONX6TsQFZGn79yuQ@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Mon, 1 Aug 2016 17:41:35 +0200
Message-ID: <CAP8UFD118RdB5dX2-wEm5VnKud7sirHhdC9kvWmXV0eAQHvfsA@mail.gmail.com>
Subject: Re: git bisect for reachable commits only
To:	Oleg Taranenko <olegtaranenko@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 1, 2016 at 12:02 PM, Oleg Taranenko <olegtaranenko@gmail.com> wrote:
> Guys,
>
> further investigation shows, git bisect is broken from its core... really.
> Let consider 3rd a bit more complicated scenario
>
> #cd ..
> #rm -rf bisect3
> mkdir bisect3
> cd bisect3
> git init
> git touch coffee

git touch is not a git command

> git commit -am "create coffee"

you need to "git add coffee" first otherwise it doesn't work

> git branch tee
> echo sugar >> coffee
> git commit -am "add sugar"  # we are still in master branch
> echo "milk" >> coffee
> git commit -am "milk for coffee"
> ex +g/sugar/d -cwq coffee  # introducing 'bug'
> git commit -am "somehow remove sugar"
> echo "mixing..." >> coffee
> git commit -am "coffee mixing"
>
> git checkout tee            # get back to coffee without sugar
> git touch tee

git touch is not a git command
it might be an alias you have that does `touch "$@" && git add "$@"`

> git commit -am "tee"
>
> git branch cocktail
> echo "sugar" >> tee
> git commit -am "sugar for tee"
> echo "milk" >> tee
> git commit -am "milk for tee"
> echo "mixing..." >> tee
> git commit -am "tee mixing"
>
> git checkout cocktail
> git touch cocktail
> git commit -am "prepare cocktail"
> echo orange >>cocktail
> git commit -am "add orange juice"
> echo rum >>cocktail
> git commit -am "add rum"
> echo mixing >> cocktail
> git commit -am "cocktail mixing"
> cat cocktail  #orange, rum, mixing
> git merge tee
> git merge master
>
> git touch serve
> git commit -am "serving..."
>
> git log --full-history --graph --pretty=oneline
>
> * 059adf903a2cbc06fe05dda4c916e2c586907f23 serving...
> *   efc89d5253d3126defc7362c25ef069ae9b43fc7 Merge branch 'master' into cocktail
> |\
> | * dd41e230a3cac5d51a1e994747ff470e2af03cae coffee mixing
> | * c2a44672f1197f34e04cd0fd66434a2b286b574e somehow remove sugar
> | * f50352cfb6bc4a237b73c95ed7ebca074603ae11 milk for coffee
> | * 79b253b316cdc3668697afe473610e35b453ab2f add sugar
> * |   2d626eb5cfaa40a4503be58a5ed27f1ececa6d02 Merge branch 'tee' into cocktail
> |\ \
> | * | 7aba690c6c6f73f1906871c9dbf9737ec11a152b tee mixing
> | * | eca611a93697359ec7a52f4a045461180bc365c3 milk for tee
> | * | 7d6844724d0e81751ec1a67c1ffdf0d0fb932350 sugar for tee
> * | | 6754e816922989d5870ec3452437bbbe6aca4d0f cocktail mixing
> * | | 5cbbf0f0882c497590838b163210db3a393b647e add rum
> * | | b46d7d8a361daae382fbef7acabda5416d23da46 add orange juice
> * | | e571fdd09582e40fc54ffc5a4f112eac2b9f2c8e prepare cocktail
> |/ /
> * | 041a5a53704bccc60c489f8c9a4742bad79d5a95 tee
> |/
> * a52a4fa6770d000a9f4e9e297739a6dc88c0cc50 create coffee
>
> As you can see, no tricks with amended history, but...
>
> git bisect start HEAD 79b2
> Bisecting: 8 revisions left to test after this (roughly 3 steps)
> [6754e816922989d5870ec3452437bbbe6aca4d0f] cocktail mixing
> cat coffee
> git bisect bad

Why is it bad?
Is it because there is no sugar?
In this case you are searching for a commit that removed sugar.

> Bisecting: 2 revisions left to test after this (roughly 1 step)
> [e571fdd09582e40fc54ffc5a4f112eac2b9f2c8e] prepare cocktail
> git bisect bad
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [041a5a53704bccc60c489f8c9a4742bad79d5a95] tee
> git bisect bad
> 041a5a53704bccc60c489f8c9a4742bad79d5a95 is the first bad commit
> commit 041a5a53704bccc60c489f8c9a4742bad79d5a95
> Author: Oleg Taranenko <olegtaranenko@gmail.com>
> Date:   Mon Aug 1 10:53:52 2016 +0200
>
>     tee
>
> :000000 100644 0000000000000000000000000000000000000000
> e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 A tee
>
> git bisect ever not looked into the path where good commit is
> declared. Instead it found somehow most common ancestor from whole
> tree (a52a create coffee),  assume it is GOOD commit (why !?)

Yes, and the reason is that all the ancestors of a good commit are
considered good.
That's because git bisect supposes that there is only one transition
from good to bad.
Otherwise we would need a more complex algorithm to find all the
transitions from good to bad, and that is not generally needed.

> and
> check only ^1 (not ^2) parent commit for testing as a potential bug
> commit.
> No wonder now, I got a disaster result, looking in my heavy enterprise
> repository.
>
> Can somebody take care of this issue?

I haven't looked at your previous issue much, sorry I have been busy these days.
