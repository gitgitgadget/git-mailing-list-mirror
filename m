Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 568D61F424
	for <e@80x24.org>; Sun, 22 Apr 2018 14:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757524AbeDVOah (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 10:30:37 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34085 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757344AbeDVOac (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 10:30:32 -0400
Received: by mail-wr0-f176.google.com with SMTP id p18-v6so15186814wrm.1
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 07:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DCpmG18Abx/3hqmSL2loyo62LeFC7TZTVoy63ZOe5ko=;
        b=G3nosfBPOFvkCdyS3Ri7wJxjIScavBD3w/sd+YP+K3zn9zuHBVhswpOltHQEpv27Pw
         /RMaWSo11p8IaSHlejbF0hHlOtqlfE2Ca+800dq0OAKh+6wd4j5np7le6UazX7SRnk+P
         XgcMIv1t5NRuRQQ55QM1p9+eke4qXFPAp1rVo42Jctcsb8nR13AESN9quR0k/ce5Zqs8
         EwxqIyiGIlGytk0RXcBAaifCdekqm4hs3vMATaGXu/8Hs2d9G+QCzMzl48lu12ggV1ct
         Ht//Ou0nJ6ll1yyVw23uu59Pu8GRjB6+/L4PCx0WA2qW3G7pvDmm1uxjo1rDSHQ0Xe7A
         UkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DCpmG18Abx/3hqmSL2loyo62LeFC7TZTVoy63ZOe5ko=;
        b=mqBKduNBEuNRdbwljEANURRsG6+/qBMmkVLwtv8deU4T7fXvvmjNEshwSWrHG1k6bM
         +S6kbdDr7Y+mm7weZUBZjk+XapKoa4vjqvZmAqiU7M3YiipMNKSIUuf/7ATQ+m6cHhm1
         rJWj4+peYokco6RNkXhHPQ0dNKxT1b9wOP/zmr5QvpXco/lMf84AjTx/ESN5drR9mg7J
         LZezlNjwpsKQh0TDmn6aTaxcKsijua62FXpjSi4pXvuProGgABGImJl1AK3p4Ug35x/d
         ht1sYbejFD2EGgg1GOgiyE9sEALhPd49e7kfHppMRX1bL4DYfhiJYxjXNUXcnOta9tFs
         X5VQ==
X-Gm-Message-State: ALQs6tAxqpKR30wUNxQrjHqiHoD/jxsy5ols2bqRk+UKz1CHsT/UwEhO
        cFKH+8tmqRa7gvwzZnN7HhGiDw==
X-Google-Smtp-Source: AIpwx4/pXHUwTgV5p5w9lS4mKoyus+y2F3Zubs2GupaZFAkI1j7/1B7CdFyZjgysap0gQ7Ubw51xug==
X-Received: by 2002:adf:9d8c:: with SMTP id p12-v6mr8426395wre.14.1524407429900;
        Sun, 22 Apr 2018 07:30:29 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:1c9c:1351:48bb:17f9? ([2001:a62:81d:ab01:1c9c:1351:48bb:17f9])
        by smtp.googlemail.com with ESMTPSA id b5-v6sm14290680wrh.67.2018.04.22.07.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 07:30:29 -0700 (PDT)
Subject: Re: RFC: How should we handle un-deleted remote branches?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <87in8mdqhr.fsf@evledraar.gmail.com>
 <3fcd1b50-2aeb-0ea4-fea7-b5705e76c027@gmail.com>
 <87d0yrebhw.fsf@evledraar.gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=asheiduk@gmail.com; prefer-encrypt=mutual; keydata=
 xsFNBFIo21kBEACwIGWAi7h1lxEJr/uU/T+zkeyWXbYPakWHP7F7+pczi+3zRjVvPyvY/4GD
 8+FkVt2p3xTYi7kyA6QMPXDDqjxakuLFFbqM7kC2X9d/LjZKuT8+wGPLb9EkpP5r+TwiV+E1
 zzd3YL/TgAGcnUgoPXIOZBVNlqEncB8SZcDCzt+zbptf9oG+xcweqVec3v/s22smWwavTI4w
 nTHgNwxnc8JbMCMprxOS8z/G7tJU8Yb90HTKFOx8S3NVpvkCs9YGZcYsVc4xoXAsZA8KPlUu
 sH72TIB6P9Kcg9ZZCKlSKajt2O8ocjVqii6KVLCTLzLMWLPSMv/TvTR+mqv5brD3bUDOG/2v
 DPGYhfnanwEklvPDXhHSsRSP4sxck4EA7zySNY46beDmZHbdn5wmuKLDibR1KRXMZvJ5/Md5
 5MiYkM6/P3CTcREXrlZ8kDpFtklVA4nOq7btPqjR/SSnOTqz66lZx0jJwhb8x2uIkKkF9Txu
 sWL5FAZ78QI+Ugl+xwCdhfYlx1LV9opRwgYN0DSlMVcG12jBzPcYBxDagjSGVK+3WKe4Hkba
 Sm1n+DP6bL5lC81chnc+EC2lOiH3U58eoIc3mWaQ6jBuniBa/VF4xQouZSZ7tZUpdSDxoFqF
 R0wYVECD8cbaxVnPbOUOjVV3ioTyUbPNGmGHf89zRz/cw81V6QARAQABzSNBbmRyZWFzIEhl
 aWR1ayA8YXNoZWlkdWtAZ21haWwuY29tPsLBeAQTAQgAIgUCUijbWQIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQlzRUDvLYQIK+XQ//UnJEDB8LYJKKaBUuI3DvXHqQSQodt5nr
 53jzKQkSZuvRDgk/TMZMj8o++Kg4c+N9eMuKeFd2FWLJ2hOx8rNEILcvICaLCpavegSg6BeR
 jWN5T9E74LXfTFGkCIt39eSz4u+MQiKhorhNuZb1L4HTouJKw7xaL935P59gWaQGMg0raVS/
 6ehpSVH0TYNc4pv4hJ9pTrVZ6IYXuOdq8Mpb5SGG/Zi21+RLKrEsxIgz1CuhN5FRMiw3gm7/
 GRxOJ1EhV5EbPw+1d+nLUCnuCZo3oE6XQTPQp5UsU/adCP74FnIjsvp5Em8mqHM/X2+QY1VU
 4vBABhXH1UvcnYctZrHRqMpFCFEYv3iaNOrayDg7auhe+ajcCg5IhzqNaN3CJlxvjJbLW/xx
 H1sM3uYM/X8C3gZVgj6W1ez/W57MRX7jcvw/ityO1Ok/mjTxi+fVzPD9et7/kx6ellmylMQM
 4/xDFmXvOmSl/ldhtnlOEH66aM2qw+31fE2FsdykDLK4xVguJ2ogL7lYqCfegKSzDEbrrPa0
 0bJ4UbwAYq2WoY65OKsS3WAHyhzM5Lz2DAMLK00OjRovz/zqWc5nIhFPcN2tI3syAzMYmnRz
 hwBiLradGdI1I0+bOlTATtZU1mCX2vhrpSlvb1m2vyeAK+rxw62tMwc7Bg51d6Zbt+5pTvCz
 BfPOwE0EVKV0gwEIANqQ9sUKTc/55e2rcbYIJoTPcEyeCxhrxYlurQz4/JalGdH/Y9GhPQpM
 oxlz+tvhUwBJwhm2RCnz3buM+NC8aWFhxoyX/zMDtDUT3oNwtbKOJchgZ4YwGWPaFVqzhTXA
 h6c/vDPVbA5xNNlHEh+OPGy1Zgi14Jfn/38J6EfYOaoXI1ZvDI91QgWVd7ddv2aRKPwgJfhQ
 q2M89/dAcLsTjHIbsKf0lLzFDmjBWrGKxvj/C0GDEGdkOwH0SM9icRoVh8IvMe6j0+qFAc58
 LiKkQ0ilfB/Cb/Nkn2gUbcilUvVEZydSo2BvkrdV4xMTvQYo3ffVzEjRIQygiGGcA5gWJW0A
 EQEAAcLBXwQYAQgACQUCVKV0gwIbDAAKCRCXNFQO8thAguG6D/sHCqX/mmZGrJxcIRN9l1wM
 EMmJLKY/Hw9wuIO7DiZuZFrKl0ZX7IfmDhC6wq33nj+oRV+k3HdfgZ+flrTmaO/h5X4Rpb8l
 6quvrvMBPVyArH1dUEVJEdKybHIZlg2zZ1CS2O0feQWcZ9PsK1IUTbPb2hafiuPVYqrkviDO
 JQgvAQWj6SDdjl17CbY5lV3g6ZBGOxpK5pydONixc1ZxoEiz2bRZki42FxrIoilhsmrlUSmA
 ts0ERqutxb+8GIG+UO63FhanMkeRERsxWP4ByiIXZ7F0BOssgIyhfWKErtF1Ms+FcOne1Y6U
 fvopf934Sp62EFOURdeEwzOFOy3gVvilBfbdJ1NtjvL/K/Y5c3sR3aheyQ/s6nohVMtEkmh2
 4IFc/clxD9zBLZsJbQWOSjdbELUQK1I+G9iJ5XxkaiCCJKt/Ns805G/iowB5BQ5lw1Wv42Ss
 uFGPgfIXs4wDXWldG+pDwmamKWqJrcFBiuLzGH6joK56bYoCVu9YKbyaP2J9gEFZ606TcE73
 0h2On7SlyXSb9PgDfH1fuxPzMWmbvJ99KiYVaLoyp1ObW50Ie3pPysj+6QNN8JxXDQv3L5tw
 eDjOFE4iXiXYUQUeZWIVgLoEiveS8RP/RaBSNYXA9NXLtQ0iwNqgEjwia/PXUoIIdoIRRc3p
 khKIKhAKu5lezA==
Message-ID: <f2fc89c6-14a9-b700-b7c9-a646148e9206@gmail.com>
Date:   Sun, 22 Apr 2018 16:30:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87d0yrebhw.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.04.2018 um 13:17 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Sun, Apr 22 2018, Andreas Heiduk wrote:
> 
>> Am 20.04.2018 um 14:14 schrieb Ævar Arnfjörð Bjarmason:
>>> But this is a possible work-around:
>>>
>>>     git init /tmp/empty.git
>>>     git remote add avar file:///tmp/empty.git
>>>     git remote prune avar
>>>     git remote remove avar
>>
>> This won't do it also?
>>
>> 	git remote prune origin
> 
> Yes, in this particular case, but that's just emergent behavior in how
> we handle refspec prunign, and the fact that it "works" is arguably a
> bug in "prune". i.e. this:

Its not emergent because "origin" is the other remote responsible for
that ref and cleaning stuff "belonging" to the remote is the job
description (I'm arguing from a user's perspective, not as a git-developer).

> 
>     (
>         rm -rf /tmp/git &&
>         git clone --bare --mirror git@github.com:git/git.git /tmp/git &&
>         cd /tmp/git &&
>         git remote add avar git@github.com:avar/git.git &&
>         git remote add peff git@github.com:peff/git.git &&
>         git fetch --all &&
>         git remote remove avar &&
>         git remote prune origin
>     )
> 
> Will delete all the avar/* and peff/* branches, even though I still have
> a "peff" remote.

Exactly my point: When you are in a the bad situation of "shared
responsibility", then there is no easy and always correct way out,
because there are uncountable possible situations.

To give another, slightly modified example expanding the problem space:

(
    rm -rf /tmp/git &&
    git clone --bare --mirror https://github.com/git/git.git /tmp/git &&
    cd /tmp/git &&
    git remote add github https://github.com/avar/git.git &&
    git fetch github &&
    git fetch origin &&
    # note new fetches for "github/master" using with "(forced update)"
)

For ... reasons the first repo publishes some references like

	github/maint
	github/master
	github/pu

So when this repo is mirrored AND another, suitably named remote is
added then there will be also namespace conflicts. You can call

    git fetch github
    git fetch origin

in a loop and most likely each fetch will update the same refs, always
toggling between two states.

So: not only "remote remove" and "remote prune" are at stake but every
command handling remote references.

How should "git remote remove github" work in both situations? Remove
the refs/remotes/github/master & co? remove them only if the last fetch
was for "github" but not when the last update was for "origin"? Should
"git fetch" use the same logic?

So it seems better to me to avoid that bad situation altogether. Don't
allow overlapping/conflicting refspecs when adding a new remote. Using
*your* last examples both

>         git remote add avar git@github.com:avar/git.git &&
>         git remote add peff git@github.com:peff/git.git &&

should have failed and hence the "prune" problems won't exist. Same for
my example.

>> Possible 5):
>>
>> 	Don't fix "git remote remove" but "git remote add" to complain that its
>> ref-namespace is already occupied by some other remote. Add "--force"
>> for the experts.
> 
> Indeed, that's another bug here, i.e. in the above example:
> 
>     git remote remove peff && # won't delete peff/ branches
>     git remote add peff git@github.com:peff/git.git
> 
> Will happily add the "peff" remote again, even though as you point out
> it could be an entirely different remote.

Ummm. That was not my point. My is: "git clone --mirror" uses a refspec

	fetch = +refs/*:refs/*

and hence "occupies" the complete "refs/*" namespace. So adding another
remote (for the first time or for the second time is as irrelevant as
the url) will use

	fetch = +refs/heads/*:refs/remotes/peff/*

and now the "refs/remotes/peff/*" part is in conflict with "refs/*" from
above. The conflict exists not only for "prune" or "remove" but also for
"fetch", "rename" (didn't check) .

This kind of conflict should not be allowed right from the start - when
the first "git remote add peff..." is executed. Then prune, remove AND
fetch would be OK.


