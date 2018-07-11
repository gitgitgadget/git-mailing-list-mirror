Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C051F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 10:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbeGKLAm (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 07:00:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39736 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeGKLAm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 07:00:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id t7-v6so19043781ljj.6
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 03:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RJPNWNX15wICaCQhQwpFoj0onRbarGt8C58Oyv43wE4=;
        b=gCJXQLX2LRAGuEdGPkM1sU1Xx4jvz77JVUXPztoPPJZxBB8Cx6vN3vHpYj3CbhfG25
         /LkoxTl9BPV4PoGtTFzpw2EkE6Fxg70q6xq+63RKy6E36dYaMfY6RJi7cMBBS9Py99Rd
         GFO6NuC6yLIOsz/YMR1X3vMjYkz/4MESpGYSocuVrjPLHy2aFnEcnb1TZIbVFDHv00+q
         ROnIy1m/4POF4By7xVZ7qL7dlHcAvSNKIfmgBQulcram8GjQT7ayYW1ifMTyTaCegFfj
         yXC/PuWEVqkv8Xk+Qz++yLPJg6wwhoQlU8WNmlLrGZG6UQ81DBDu8o/P9hN0wRvmS9Cy
         ODyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RJPNWNX15wICaCQhQwpFoj0onRbarGt8C58Oyv43wE4=;
        b=FxyucNrELygdJsAhFpMEgBwlP+GE4ekazmy230TH1u65nxCJPi+dGPeMVFtEyd9OZp
         bxegyhFC23fZnipEV03IRvqk8uH/Ibpik+OyMr0LjtbrkEJOIdFWHeIySg+EGcl8MAfo
         ZZj1eu8me7Vx+rYGN8CfMQ1VuRwPOWa/8ZSU/hjTP9FkKZu8TGp4Bsr5zqpt9f/523g6
         CoHvjksZHYGgO4CzEXY18pBazPC65EAldI8eh4jl/nmJvSSmzZLxSqlDmB52p4NIgHlF
         eFcAI3ZH9abAcY0oi52RpSvpnfgdlhWbMrJYro3bkpJmjl7+dF6gxXUEcUlZWpW5MB5v
         j2VQ==
X-Gm-Message-State: APt69E1ryVIL4skwsAc8Brj5kMHBNm9h+Gu1ZWwQ9/gfdI6YeTOGoTI7
        z2nzZezh1v9G8lhYuYf4PkK/eqfOrbpu09aPf3s=
X-Google-Smtp-Source: AAOMgpdhd4NJ4msGxwHRNvzreyxMadnInLoVvdgbWnc1tzWECT0Lq9aUQ0AT64q/AFX09k9IcXlqsuab/d5k6BmT6zg=
X-Received: by 2002:a2e:52c3:: with SMTP id n64-v6mr16899169lje.90.1531306616056;
 Wed, 11 Jul 2018 03:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180627073623.31725-1-newren@gmail.com> <20180627154804.3743-1-newren@gmail.com>
 <20180627154804.3743-2-newren@gmail.com> <20180627182805.28375-1-szeder.dev@gmail.com>
In-Reply-To: <20180627182805.28375-1-szeder.dev@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 11 Jul 2018 12:56:44 +0200
Message-ID: <CAM0VKj=rGHm3V_z4S6NNP2-fjyfrgrLz-bWrZ8t0gcVD-gTq_w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] t3418: add testcase showing problems with rebase
 -i and strategy options
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 8:28 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> > diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> > index 03bf1b8a3b..11546d6e14 100755
> > --- a/t/t3418-rebase-continue.sh
> > +++ b/t/t3418-rebase-continue.sh
> > @@ -74,6 +74,38 @@ test_expect_success 'rebase --continue remembers mer=
ge strategy and options' '
> >       test -f funny.was.run
> >  '
> >
> > +test_expect_failure 'rebase -i --continue handles merge strategy and o=
ptions' '
> > +     rm -fr .git/rebase-* &&
> > +     git reset --hard commit-new-file-F2-on-topic-branch &&
> > +     test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32=
 &&
> > +     test_when_finished "rm -fr test-bin funny.was.run funny.args" &&
> > +     mkdir test-bin &&
> > +     cat >test-bin/git-merge-funny <<-EOF &&
> > +     #!$SHELL_PATH
> > +     echo "\$@" >>funny.args
> > +     case "\$1" in --opt) ;; *) exit 2 ;; esac
> > +     case "\$2" in --foo) ;; *) exit 2 ;; esac
> > +     case "\$4" in --) ;; *) exit 2 ;; esac
> > +     shift 2 &&
> > +     >funny.was.run &&
> > +     exec git merge-recursive "\$@"
> > +     EOF
> > +     chmod +x test-bin/git-merge-funny &&
>
> You could use the 'write_script' helper function here.
>
> > +     (
> > +             PATH=3D./test-bin:$PATH &&
> > +             test_must_fail git rebase -i -s funny -Xopt -Xfoo master =
topic
> > +     ) &&
> > +     test -f funny.was.run &&

And please use 'test_path_is_file' here ...

> > +     rm funny.was.run &&
> > +     echo "Resolved" >F2 &&
> > +     git add F2 &&
> > +     (
> > +             PATH=3D./test-bin:$PATH &&
> > +             git rebase --continue
> > +     ) &&
> > +     test -f funny.was.run

... and here.

> > +'
> > +
> >  test_expect_success 'rebase passes merge strategy options correctly' '
> >       rm -fr .git/rebase-* &&
> >       git reset --hard commit-new-file-F3-on-topic-branch &&
> > --
> > 2.18.0.9.g431b2c36d5
> >
> >
