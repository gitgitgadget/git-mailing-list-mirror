Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1066F1F71B
	for <e@80x24.org>; Sun, 31 Jul 2016 00:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbcGaAG6 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 20:06:58 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:32828 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbcGaAG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 20:06:57 -0400
Received: by mail-vk0-f43.google.com with SMTP id x130so77687289vkc.0
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 17:06:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4Yey543bROGLuCxzXxdH0swmetPbf+NUAFYyP9ik55M=;
        b=lABDQ5x8NDOqQuyBOE05dVQRKTSZdPMv9e8ZuF4d+0o8yykHovd8F5Mxa2LgL+xXuf
         tcYx4sFJtSzQn6MtGHc3VM2a8JRU+bI9FWulQzdEUqClSHCYJuqhQJTh1bmnL7hFGmDQ
         BAMJSTGuQpy5mZ07TtyCKurRVcjcwmc7KFakrM2BM6UZv0Rph7U92YIuxaXJFP6mxCjb
         /jpgX9WvaC38cWu55SybTDLqJPj8FQnN30tTEeXSeUBmO2TjbwdwdmqP2fLsY8YGAymt
         sbOF55tuUcY24U5E40tddyLb9K6WTMeldfpCONw1yMg4e5+qdbOQOc3pL74AFljavnkx
         0pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4Yey543bROGLuCxzXxdH0swmetPbf+NUAFYyP9ik55M=;
        b=BqWIU52SzJpXlODrxmxQfA17CpZznH2g0NMEt4Ddq/Azvf8XfILM8vIz+5Pk2JZR3Q
         5x0y81l92lqcJ89OmfTH+EmWHwCLXpcxTB3vHGP5l9uiOmzbiWr/EeuQBRwtJNYvK5Js
         1CUkgAS3j8jugLqrRKVKglPukIYX+DqOZs1bhWYjBD2Bb9lVNCVLdFLlnvMYgpJLE72G
         vEvKzUs2Xprk88ceRtdwp7JI6HYvD0ZHo0iIXOdYiH1XbRr2ZKK3v76yahipezD1Hehu
         LnnUaHnMkmXvO1ykM8sjobHMrgAoV4iClpFY4asmrtu0Z7ay9mxGa/Tb4SFMC8vnsGrA
         a6lQ==
X-Gm-Message-State: AEkoouu9fD4u5Sw06bvTdoKU45X3ZaW/+h1OQ7z/wYWe9yYvkKkKXkLpSib9pC4TeoAMM0ePXIo09c185szGGw==
X-Received: by 10.31.107.29 with SMTP id g29mr22679846vkc.56.1469923616115;
 Sat, 30 Jul 2016 17:06:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.10.69 with HTTP; Sat, 30 Jul 2016 17:06:55 -0700 (PDT)
In-Reply-To: <xmqqinvonwxc.fsf@gitster.mtv.corp.google.com>
References: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
 <xmqqinvonwxc.fsf@gitster.mtv.corp.google.com>
From:	Oleg Taranenko <olegtaranenko@gmail.com>
Date:	Sun, 31 Jul 2016 02:06:55 +0200
Message-ID: <CABEd3j-MW--YSC9=nwcgHzxd6cqmUY+ky3-wLxMiMmbBGsvS7Q@mail.gmail.com>
Subject: Re: git bisect for reachable commits only
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

Thanks for reply.
Let consider two pretty similar use cases.

************ SCENARIO 1 ************

mkdir bisect
cd bisect/
git init
git touch coffee
git commit -am "create coffee"
git branch develop
echo sugar >> coffee
git commit -am "add sugar" # we are still in master branch
git checkout develop       # get back to coffe without sugar
git touch tee              # cooking tee in develop branch
git commit -am "tee"
git merge master           #
cat coffee                 # after merge coffe has sugar
ex +g/sugar/d -cwq coffee  # introducing 'bug' by removing sugar from coffee
git commit -am "merged/amended" --amend       # the history is amended
echo "sugar" >> tee
git commit -am "sugar for tee"              # just advance for measure

# -------------- We are getting following state ------------------
git status                 # develop branch
git log --full-history --graph --pretty=oneline
* 83e9577b4a5d553fdc16806fdea9757229ea9222 sugar for tee
*   23a4aa69a9d5c03aa145844005555b7ee00c4d63 merged/amended
|\
| * 4c1caf7cb2417181c035a953afdf2389dd130aef add sugar
* | c080fb4df39d721e2f2e0fdd91fe16d8bdd77515 tee
|/
* 3c3043b7d0a0d260c78db55b565f26e430aa5c80 create coffee

cat coffee # nothing                        # discovering coffee has no sugar
git checkout 4c1c                           # but we remember it should to have
cat coffee                                  # ..."sugar"

git bisect start
git bisect good
git bisect bad develop   # 23a4
cat coffee               # nothing
git bisect bad           # c080
cat coffee               # nothing
git bisect bad           #
c080fb4df39d721e2f2e0fdd91fe16d8bdd77515 is the first bad commit
commit c080fb4df39d721e2f2e0fdd91fe16d8bdd77515
Author: Oleg Taranenko <olegtaranenko@gmail.com>
Date:   Fri Jul 29 09:08:47 2016 +0200

    tee

:000000 100644 0000000000000000000000000000000000000000
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 A tee



We are getting first bad commit c080, but git bisect fails.
We remember is was introduced in the 23a4 commit via wrong merge and
history amending.


************ SCENARIO 2 ************
cd ..
mkdir bisect2
cd bisect2
git init
git touch coffee
git commit -am "create coffee"
echo sugar >> coffee
# we are still in master branch
git commit -am "add sugar"
git branch develop
echo milk >> coffee
git commit -am "add milk to coffee"

# get back to coffe without sugar
git checkout  develop
ex "+g/sugar/d" -cwq coffee
echo milk >> coffee
git commit -am "coffee: replace sugar with milk"
# cooking tee in develop branch
git touch tee
git commit -am "tee"
git checkout master
git merge develop


#Here we are getting real conflict
cat coffee
#<<<<<<< HEAD
#sugar
#=======
#>>>>>>> develop
#milk

#resolving
git checkout develop --theirs -- coffee
cat coffee             # milk
git commit -am "conflict resolved"
echo "sugar" >> tee
git commit -am "sugar for tee"              # just advance for measure


 ---------- State -----------------
git log --full-history --graph --pretty=oneline
* b88a3cb3df58fc018d635d559d212707e953f84d sugar for tee
*   138824139c0237fe05419d4f40a693e4c19405a3 conflict resolved
|\
| * e1ddbfe05d632d6f12dd7ff9d9b61475c2cde867 tee
| * ddfb5188c98b8fc803a036ac4eee0610e2bba53f coffee: replace sugar with milk
* | 0e1c55363e5b2fb04a6072fa470f90770b3eee22 add milk to coffee
|/
* 465d0c68c597f1534c3c1e19ed9a086c5da190ae add sugar
* 24b73ce9085a6d411c06c08cca0536dc8f2239c7 create coffee


cat coffee      # only milk, no sugar... bug
git checkout 792d
cat coffee                 # OK, milk & sugar
git bisect start
git bisect good
git bisect bad master      # e1dd
cat coffee                 # milk only
git bisect bad             # ddfb
cat coffee                 # milk only
git bisect bad             # first bad commit !!

It happens, git really found that somebody (me) was replaced sugar
with milk, because ancestor of both branches already has sugar, and
commit ddfb
explicit removes it.

As we can see, both strategies can coexisting, and now I ever can't
state for sure, which one is more intuitive correct.

I think if repo has relative straight history, more productive to use
bisect with auto search in un-reachable commits.
For messy repositories (especially, with lots of aliens code) more
safe to use --reachable bisecting strategy.

Then, I suggest as well additional to defaulting via 'git config
bisect.reachable true/false' use per bisect session switch

    git bisect start --[un-]reachable-commits # which will override
default setting


Thanks you for reading to this point,

Oleg

On Fri, Jul 29, 2016 at 8:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Oleg Taranenko <olegtaranenko@gmail.com> writes:
>
>> What I suggest change logic of bisecting to something like
>>
>>       git config bisect.reachable true
>
> Such a configuration should not be needed.
>
> When a history with this shape is given to "git bisect":
>
>     ----o---o---X---Y---B
>          \     /
>           o---G
>
> and you gave G as good, and B as bad, it is a BUG that needs to be
> fixed if bisect strayed outside G, X, Y and B.  Setting your new
> configuration to false would mean "please run a buggy version of
> bisect", which does not make much sense, I would think.
>
>
>
>
>
