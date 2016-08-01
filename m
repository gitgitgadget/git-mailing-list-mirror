Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50B61F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 10:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbcHAKej (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 06:34:39 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33660 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbcHAKe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 06:34:26 -0400
Received: by mail-vk0-f52.google.com with SMTP id x130so96202476vkc.0
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 03:34:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lLp1nsz/NZJ6KYJPfob6glKy/G1/gbBfMH3vUu3naME=;
        b=X7Ah4uTP5woCEqhSRfBBq6MEzqwkP2G/StraNjadJiChXh1Xe7aZRy72D9zfP5c6nC
         5qdp3mVYbjKSz8GpsdjWSsqJxSbs+FXv2LZS3ug3a7Kme6a/VLyb4Md2Chv1DdAhgxJr
         3l9k+qEmtLeIgDtk0CG3jRjUkx/KZ7Fa5eNbPdF8v583+5ze2SdnLW51/Rv0tH5qS9pS
         V/2fCpA7U10goABsbQcIj1szcZOZnmUHnXTxKT5GtIxFmQ8bmVaQJvp5rYk0772p5rpb
         YT/Q8tisjIIz9VBrC6QPyMS+tlxi3BkRtmjLEDgzyVOUSBtuJuev/AovYtxayxcW2LEe
         iMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lLp1nsz/NZJ6KYJPfob6glKy/G1/gbBfMH3vUu3naME=;
        b=kDOGbEHID09wG2FQrUUmUcs0N90bMCRvzTjmk39tUoVhLWvI8GXtoto2b+n5Uu8plS
         jT3VmOlTD9EkmlmZuVKJIRxeTcfPhm2oDrsgIL4jEfRpTk2C7+bpgLRt7U+J9I5ETowN
         lvsl/Anlft/UMNHfNFPPq7eUDCu8fJmUbai/5GhtNeW0C5EmSf3uQnx9tODQPfVATfh4
         GaVX0/s9/dmn2wm/7OfC/6qeNS2oKxvoKNhJ6znujhVjHLu2Anm8I+1c7yIRhLPOi0Sd
         u+//g+ErosExzOqUJBWCZTuM33m6MndINxVETg4L6WVeAMyb6JbVYZwUhT9TPzW0eiCu
         XsRg==
X-Gm-Message-State: AEkoouvAeU2yjBRpCmPtB+CehK6lgabf70HsteVUuNysErEA6qIHinX7YiepvzmmajearuJtrASosUO1dvs8Lg==
X-Received: by 10.31.147.197 with SMTP id v188mr25927880vkd.103.1470045769300;
 Mon, 01 Aug 2016 03:02:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.10.69 with HTTP; Mon, 1 Aug 2016 03:02:48 -0700 (PDT)
In-Reply-To: <CABEd3j-MW--YSC9=nwcgHzxd6cqmUY+ky3-wLxMiMmbBGsvS7Q@mail.gmail.com>
References: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
 <xmqqinvonwxc.fsf@gitster.mtv.corp.google.com> <CABEd3j-MW--YSC9=nwcgHzxd6cqmUY+ky3-wLxMiMmbBGsvS7Q@mail.gmail.com>
From:	Oleg Taranenko <olegtaranenko@gmail.com>
Date:	Mon, 1 Aug 2016 12:02:48 +0200
Message-ID: <CABEd3j--sxCwv6fWmNxTtdpgwU0_YKbfiFONX6TsQFZGn79yuQ@mail.gmail.com>
Subject: Re: git bisect for reachable commits only
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Guys,

further investigation shows, git bisect is broken from its core... really.
Let consider 3rd a bit more complicated scenario

#cd ..
#rm -rf bisect3
mkdir bisect3
cd bisect3
git init
git touch coffee
git commit -am "create coffee"
git branch tee
echo sugar >> coffee
git commit -am "add sugar"  # we are still in master branch
echo "milk" >> coffee
git commit -am "milk for coffee"
ex +g/sugar/d -cwq coffee  # introducing 'bug'
git commit -am "somehow remove sugar"
echo "mixing..." >> coffee
git commit -am "coffee mixing"

git checkout tee            # get back to coffee without sugar
git touch tee
git commit -am "tee"

git branch cocktail
echo "sugar" >> tee
git commit -am "sugar for tee"
echo "milk" >> tee
git commit -am "milk for tee"
echo "mixing..." >> tee
git commit -am "tee mixing"

git checkout cocktail
git touch cocktail
git commit -am "prepare cocktail"
echo orange >>cocktail
git commit -am "add orange juice"
echo rum >>cocktail
git commit -am "add rum"
echo mixing >> cocktail
git commit -am "cocktail mixing"
cat cocktail  #orange, rum, mixing
git merge tee
git merge master

git touch serve
git commit -am "serving..."

git log --full-history --graph --pretty=oneline

* 059adf903a2cbc06fe05dda4c916e2c586907f23 serving...
*   efc89d5253d3126defc7362c25ef069ae9b43fc7 Merge branch 'master' into cocktail
|\
| * dd41e230a3cac5d51a1e994747ff470e2af03cae coffee mixing
| * c2a44672f1197f34e04cd0fd66434a2b286b574e somehow remove sugar
| * f50352cfb6bc4a237b73c95ed7ebca074603ae11 milk for coffee
| * 79b253b316cdc3668697afe473610e35b453ab2f add sugar
* |   2d626eb5cfaa40a4503be58a5ed27f1ececa6d02 Merge branch 'tee' into cocktail
|\ \
| * | 7aba690c6c6f73f1906871c9dbf9737ec11a152b tee mixing
| * | eca611a93697359ec7a52f4a045461180bc365c3 milk for tee
| * | 7d6844724d0e81751ec1a67c1ffdf0d0fb932350 sugar for tee
* | | 6754e816922989d5870ec3452437bbbe6aca4d0f cocktail mixing
* | | 5cbbf0f0882c497590838b163210db3a393b647e add rum
* | | b46d7d8a361daae382fbef7acabda5416d23da46 add orange juice
* | | e571fdd09582e40fc54ffc5a4f112eac2b9f2c8e prepare cocktail
|/ /
* | 041a5a53704bccc60c489f8c9a4742bad79d5a95 tee
|/
* a52a4fa6770d000a9f4e9e297739a6dc88c0cc50 create coffee

As you can see, no tricks with amended history, but...

git bisect start HEAD 79b2
Bisecting: 8 revisions left to test after this (roughly 3 steps)
[6754e816922989d5870ec3452437bbbe6aca4d0f] cocktail mixing
cat coffee
git bisect bad
Bisecting: 2 revisions left to test after this (roughly 1 step)
[e571fdd09582e40fc54ffc5a4f112eac2b9f2c8e] prepare cocktail
git bisect bad
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[041a5a53704bccc60c489f8c9a4742bad79d5a95] tee
git bisect bad
041a5a53704bccc60c489f8c9a4742bad79d5a95 is the first bad commit
commit 041a5a53704bccc60c489f8c9a4742bad79d5a95
Author: Oleg Taranenko <olegtaranenko@gmail.com>
Date:   Mon Aug 1 10:53:52 2016 +0200

    tee

:000000 100644 0000000000000000000000000000000000000000
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 A tee

git bisect ever not looked into the path where good commit is
declared. Instead it found somehow most common ancestor from whole
tree (a52a create coffee),  assume it is GOOD commit (why !?) and
check only ^1 (not ^2) parent commit for testing as a potential bug
commit.
No wonder now, I got a disaster result, looking in my heavy enterprise
repository.

Can somebody take care of this issue?

Thanks, Oleg

On Sun, Jul 31, 2016 at 2:06 AM, Oleg Taranenko <olegtaranenko@gmail.com> wrote:
> Hi Junio,
>
> Thanks for reply.
> Let consider two pretty similar use cases.
>
> ************ SCENARIO 1 ************
>
> mkdir bisect
> cd bisect/
> git init
> git touch coffee
> git commit -am "create coffee"
> git branch develop
> echo sugar >> coffee
> git commit -am "add sugar" # we are still in master branch
> git checkout develop       # get back to coffe without sugar
> git touch tee              # cooking tee in develop branch
> git commit -am "tee"
> git merge master           #
> cat coffee                 # after merge coffe has sugar
> ex +g/sugar/d -cwq coffee  # introducing 'bug' by removing sugar from coffee
> git commit -am "merged/amended" --amend       # the history is amended
> echo "sugar" >> tee
> git commit -am "sugar for tee"              # just advance for measure
>
> # -------------- We are getting following state ------------------
> git status                 # develop branch
> git log --full-history --graph --pretty=oneline
> * 83e9577b4a5d553fdc16806fdea9757229ea9222 sugar for tee
> *   23a4aa69a9d5c03aa145844005555b7ee00c4d63 merged/amended
> |\
> | * 4c1caf7cb2417181c035a953afdf2389dd130aef add sugar
> * | c080fb4df39d721e2f2e0fdd91fe16d8bdd77515 tee
> |/
> * 3c3043b7d0a0d260c78db55b565f26e430aa5c80 create coffee
>
> cat coffee # nothing                        # discovering coffee has no sugar
> git checkout 4c1c                           # but we remember it should to have
> cat coffee                                  # ..."sugar"
>
> git bisect start
> git bisect good
> git bisect bad develop   # 23a4
> cat coffee               # nothing
> git bisect bad           # c080
> cat coffee               # nothing
> git bisect bad           #
> c080fb4df39d721e2f2e0fdd91fe16d8bdd77515 is the first bad commit
> commit c080fb4df39d721e2f2e0fdd91fe16d8bdd77515
> Author: Oleg Taranenko <olegtaranenko@gmail.com>
> Date:   Fri Jul 29 09:08:47 2016 +0200
>
>     tee
>
> :000000 100644 0000000000000000000000000000000000000000
> e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 A tee
>
>
>
> We are getting first bad commit c080, but git bisect fails.
> We remember is was introduced in the 23a4 commit via wrong merge and
> history amending.
>
>
> ************ SCENARIO 2 ************
> cd ..
> mkdir bisect2
> cd bisect2
> git init
> git touch coffee
> git commit -am "create coffee"
> echo sugar >> coffee
> # we are still in master branch
> git commit -am "add sugar"
> git branch develop
> echo milk >> coffee
> git commit -am "add milk to coffee"
>
> # get back to coffe without sugar
> git checkout  develop
> ex "+g/sugar/d" -cwq coffee
> echo milk >> coffee
> git commit -am "coffee: replace sugar with milk"
> # cooking tee in develop branch
> git touch tee
> git commit -am "tee"
> git checkout master
> git merge develop
>
>
> #Here we are getting real conflict
> cat coffee
> #<<<<<<< HEAD
> #sugar
> #=======
> #>>>>>>> develop
> #milk
>
> #resolving
> git checkout develop --theirs -- coffee
> cat coffee             # milk
> git commit -am "conflict resolved"
> echo "sugar" >> tee
> git commit -am "sugar for tee"              # just advance for measure
>
>
>  ---------- State -----------------
> git log --full-history --graph --pretty=oneline
> * b88a3cb3df58fc018d635d559d212707e953f84d sugar for tee
> *   138824139c0237fe05419d4f40a693e4c19405a3 conflict resolved
> |\
> | * e1ddbfe05d632d6f12dd7ff9d9b61475c2cde867 tee
> | * ddfb5188c98b8fc803a036ac4eee0610e2bba53f coffee: replace sugar with milk
> * | 0e1c55363e5b2fb04a6072fa470f90770b3eee22 add milk to coffee
> |/
> * 465d0c68c597f1534c3c1e19ed9a086c5da190ae add sugar
> * 24b73ce9085a6d411c06c08cca0536dc8f2239c7 create coffee
>
>
> cat coffee      # only milk, no sugar... bug
> git checkout 792d
> cat coffee                 # OK, milk & sugar
> git bisect start
> git bisect good
> git bisect bad master      # e1dd
> cat coffee                 # milk only
> git bisect bad             # ddfb
> cat coffee                 # milk only
> git bisect bad             # first bad commit !!
>
> It happens, git really found that somebody (me) was replaced sugar
> with milk, because ancestor of both branches already has sugar, and
> commit ddfb
> explicit removes it.
>
> As we can see, both strategies can coexisting, and now I ever can't
> state for sure, which one is more intuitive correct.
>
> I think if repo has relative straight history, more productive to use
> bisect with auto search in un-reachable commits.
> For messy repositories (especially, with lots of aliens code) more
> safe to use --reachable bisecting strategy.
>
> Then, I suggest as well additional to defaulting via 'git config
> bisect.reachable true/false' use per bisect session switch
>
>     git bisect start --[un-]reachable-commits # which will override
> default setting
>
>
> Thanks you for reading to this point,
>
> Oleg
>
> On Fri, Jul 29, 2016 at 8:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Oleg Taranenko <olegtaranenko@gmail.com> writes:
>>
>>> What I suggest change logic of bisecting to something like
>>>
>>>       git config bisect.reachable true
>>
>> Such a configuration should not be needed.
>>
>> When a history with this shape is given to "git bisect":
>>
>>     ----o---o---X---Y---B
>>          \     /
>>           o---G
>>
>> and you gave G as good, and B as bad, it is a BUG that needs to be
>> fixed if bisect strayed outside G, X, Y and B.  Setting your new
>> configuration to false would mean "please run a buggy version of
>> bisect", which does not make much sense, I would think.
>>
>>
>>
>>
>>
