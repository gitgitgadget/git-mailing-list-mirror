Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0BE51F404
	for <e@80x24.org>; Sun, 22 Apr 2018 11:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbeDVLRf (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 07:17:35 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:45093 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbeDVLRf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 07:17:35 -0400
Received: by mail-wr0-f175.google.com with SMTP id p5-v6so5869792wre.12
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 04:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3rDKBR+Lmao/G/PifXvJXXXy9d/wtzm7bK9fu+oylto=;
        b=ansjVSeruHw1dJ/nocbJdMYTsvCbQifrQ0Pt5Q7mqb9kn3PMPSA3cEM7sWPj7xuAYp
         jwUepEPnguYCIksOM4wQgZIYkMCnQ8gtyGWUUT3ZZB6Q8BGug+Jni7swxoaE1DS7Jada
         x8c44+9nuo+1ynTUM++aeYvfuBwo8Zks6prx4GLRHWObH56d6fKjlmIxXAJTuTMs6ADf
         N1YjMUdK8j2kkY0G7eBf3EnOS7+Ap6qN9bflVIxsEpGqjoZRxLgWTG6htGS39yh7zQ8k
         Mc4KMelKe9WuaTRGbmXHWN/6NVcD6P5AtPlTqHsGAljC5A62iI46h4eQtmxYCQ5RC7eX
         kkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3rDKBR+Lmao/G/PifXvJXXXy9d/wtzm7bK9fu+oylto=;
        b=SaiRhZh7vD/lO9UC5IRO6Tsmyb+cwqIlwwIOL8E0PlnvsgijhR1YFCxNgq3MyGiz/w
         hlRKnV7wcD2VcOb1wKiS9BqtCVTPbQw9YbeXepJXSn0ypFPTtuKHKKjs5CBtQPGtmoEx
         16DoD+LR8zktfuXjH5A5HJ+iegcWPtEZuHW8wk7DzHxGYuad92f4BqHf3SjGWv1wNRS3
         p6V4wyw0AFaCUwvqYbDEZNlBj5XVR4yq6Ra0yp+kUZJjKvDVToqcekeNJy9dxM5Tf9r3
         CiZ+ZEklSaiBAix5euS/uF1T0kgxfqkoO2lPZMiZk7IT7ofIi4kUTUPqZ+Hm/FZHP70S
         8Dqw==
X-Gm-Message-State: ALQs6tAffrBjloZp1bDm/gskKl2ZWTdambP5oQi6TxpnwggBGet1VDAE
        fWXQ773y5WFugIa15qIeqfU=
X-Google-Smtp-Source: AIpwx4+dqqwkMwRwjHU6TrBfHQi2wJBCAlPPsYAOqGXA33hdETnPkIahnRO//5t0zjBBIiBbMCw35w==
X-Received: by 10.80.149.9 with SMTP id u9mr23703133eda.268.1524395853701;
        Sun, 22 Apr 2018 04:17:33 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id c5sm6697759ede.63.2018.04.22.04.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Apr 2018 04:17:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: RFC: How should we handle un-deleted remote branches?
References: <87in8mdqhr.fsf@evledraar.gmail.com> <3fcd1b50-2aeb-0ea4-fea7-b5705e76c027@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <3fcd1b50-2aeb-0ea4-fea7-b5705e76c027@gmail.com>
Date:   Sun, 22 Apr 2018 13:17:31 +0200
Message-ID: <87d0yrebhw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 22 2018, Andreas Heiduk wrote:

> Am 20.04.2018 um 14:14 schrieb Ævar Arnfjörð Bjarmason:
>> But this is a possible work-around:
>>
>>     git init /tmp/empty.git
>>     git remote add avar file:///tmp/empty.git
>>     git remote prune avar
>>     git remote remove avar
>
> This won't do it also?
>
> 	git remote prune origin

Yes, in this particular case, but that's just emergent behavior in how
we handle refspec prunign, and the fact that it "works" is arguably a
bug in "prune". i.e. this:

    (
        rm -rf /tmp/git &&
        git clone --bare --mirror git@github.com:git/git.git /tmp/git &&
        cd /tmp/git &&
        git remote add avar git@github.com:avar/git.git &&
        git remote add peff git@github.com:peff/git.git &&
        git fetch --all &&
        git remote remove avar &&
        git remote prune origin
    )

Will delete all the avar/* and peff/* branches, even though I still have
a "peff" remote.

IOW the guarding logic we have in add_branch_for_removal() for not
deleting the branches of other remotes isn't in the corresponding
"prune" function, and that's a bug.

In the specific example I picked "git remote prune origin" just so
happens to do the right thing since I have no other active remote, and
there *is* an alive remote so I can "prune" against it, but it doesn't
help in the general case. In my case I have a remote URL for a git
server called "upstream" that doesn't exist anymore (but as noted, I can
fake it with an empty repo...)>


>> I started to patch this, but I'm not sure what to do here. we could do
>> some combination of:
>>
>>  0. Just document the current behavior and leave it.
>>
>>  1. Dig further down to see what other remotes reference these refs, and
>>     just ignore any refspecs that don't explicitly reference
>>     refs/remotes/<our_deleted_remote>/*.
>>
>>     I.e. isn't the intention here to preserve a case where you have two
>>     URLs for the same effective remote, not whene you have something
>>     like a --mirror refspec? Unfortunately I can't ask the original
>>     author :(
>>
>>  2. Warn about each ref we didn't delete, or at least warn saying
>>     there's undeleted refs under refs/remotes/<name>/*.
>>
>>  3. Make 'git remote remove --force-deletion <name>' (or whatever the
>>     flag is called) be a thing. But unless we do the next item this
>>     won't be useful.
>>
>>  4. Make 'git remote prune <name>' work in cases where we don't have a
>>     remote called <name> anymore, just falling back to deleting
>>     refs/remotes/<name>. In this case 'git remote remove
>>     --force-deletion <name>' would also do the same thing.
>
> Possible 5):
>
> 	Don't fix "git remote remove" but "git remote add" to complain that its
> ref-namespace is already occupied by some other remote. Add "--force"
> for the experts.

Indeed, that's another bug here, i.e. in the above example:

    git remote remove peff && # won't delete peff/ branches
    git remote add peff git@github.com:peff/git.git

Will happily add the "peff" remote again, even though as you point out
it could be an entirely different remote.
