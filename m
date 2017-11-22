Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FEE120954
	for <e@80x24.org>; Wed, 22 Nov 2017 16:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751762AbdKVQVc (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 11:21:32 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:46096 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdKVQVb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 11:21:31 -0500
Received: by mail-it0-f49.google.com with SMTP id 187so5137568iti.5
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 08:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dZ7L+yMN5qeIU7a8EDDFMxzW40Lh2EjmrLawtsdpf1w=;
        b=ke/Wkywz7gktjhPQROxlUb3QoREDPK5mLATTAnwYJoZhvXM5kJ7iymsJNt1ZZVYU0c
         JXMm4GXpyZhqBq63HdTGTE7Fh9oE2bOgHGEccsY0K1+Qw0p6V7dgph0Ug/SeuPcVoTs2
         AcVdJ/DzSXZ6vYBS48qPfMP9JDw6DtVDS1CRTCTg+2JsUwBmA1KUygJVgb2qtqK2f9jI
         kJSxvvsVc13SIdaylRlI4dbhJPv4SEx1cVUFgGR2MCA5ZR8oGmgAcgxmxlL0DjgW7iZ+
         m/T+B6PhJjxkiafsJ21vrM00wRsJsS7dnt6yvN6Kk7Z/+j2t/lTA3m4VKxh0ftjGOkzk
         1A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dZ7L+yMN5qeIU7a8EDDFMxzW40Lh2EjmrLawtsdpf1w=;
        b=poBRq6oy0L7D64AMnrTDRkfGFeh7/bcBuP+FoJ0PkLdSEoA6TL9pzoKPCbFJzOSDRJ
         t1kVboqOxzUrEp3HoFBXEjyGzeErPhjxovOPaAZnTFxGM76RwFZo7HGSX1CJV8Z6AHAV
         FZAl5XqPTiWcF3GdhLGB1t26pA1A6g9L9aakAG5RzZ+Sdhah+nQJQWmTB0D9lTtjb2Lp
         SilKn1wMCguH5KwkqLVOB6GXUR77IZIkk5ZIOIV/hbrmafiNPnP99WlLVsImvfbapfQH
         IV8wEMQpsMM8HK2s7JrmrR3TqYCuddYW4ulZcOW/wMhlqj/5oR5EJkE4SBt86NNdst94
         FWfQ==
X-Gm-Message-State: AJaThX5d3L9HJVzEMV2WIMfJjGRN6ZtHVHuhnaqvxugdL0Xqv/lVnj9m
        HusJzj9l97nf/waPZCdLE269JDqin1E0lA4zIMARWwG3
X-Google-Smtp-Source: AGs4zMZ+ScRGuaopl9HOLle860vkH0GCQd9nJomV4IlpVruvLiwhoFMy2lyZJVALVjDMJkmViDcLEzTtUsZkNW4z+Ik=
X-Received: by 10.36.228.68 with SMTP id o65mr7883680ith.128.1511367690598;
 Wed, 22 Nov 2017 08:21:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Wed, 22 Nov 2017 08:21:29 -0800 (PST)
In-Reply-To: <20171122143902.GO20681@dinwoodie.org>
References: <20171122143902.GO20681@dinwoodie.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 22 Nov 2017 17:21:29 +0100
Message-ID: <CAP8UFD35-z9qA_m28EbpvN-X_HVcDvEirn69DJNESikJ=Txg7g@mail.gmail.com>
Subject: Re: Bisect marking new commits incorrectly
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 3:39 PM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> In trying to do a bisect on the Git repository, I seem to have come
> across surprising behavior where the order in which `git bisect` appears
> to forget that previous commits were marked as new.

Yeah, the algorithm uses many "old" commits and only one "new" commit.

[...]

> As you can see, in both cases, only the most recent "new" command
> appears to have any effect.  I'd have expected that both commits would
> have been marked as "new", and the bisect run would use both facts to
> work out which commit is the target of the bisection.

I didn't look at your test case, but the algorithm to find another
commit to test is described here:

https://git-scm.com/docs/git-bisect-lk2009.html#_bisection_algorithm

and you can see that the first rule of the algorithm is to keep only
the commits that are ancestors of the "new" commit (including the
"new" commit itself).

The reason for this rule is that other commits cannot have introduced
the behavior we are looking for. The result of this rule is that git
bisect will always ask you to test a commit that is an ancestor of the
"new" commit.

So if you test a commit that git bisect asks you to test, and it
appears that this commit is "new", then you can just discard the
previous "new" commit because it will give you less information than
the new "new" one.
(The old "new" will not let you discard any commits that the new "new"
commit allows you to discard, because it is a descendant of the new
"new" commit.)

If you don't test the commit that git bisect asks you to test, then
git bisect assumes that you know better and discards the old "new".

> This is using v2.15.0.  It's possibly relevant that 95a731ce is a
> direct parent of 14c63a9d.
>
> Is this a bug, or intentional behaviour?  Am I missing something that
> means it's actually sensible to have Git silently discard some bisect
> commands in this sort of circumstance?

Well, instead of silently discarding a the old "new" commit when the
new "new" commit is not an ancestor of it, git bisect could perhaps
warn or ask you to confirm that you know what you are doing.
