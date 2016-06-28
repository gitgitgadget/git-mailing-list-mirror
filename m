Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F1B1FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 06:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbcF1G2v (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 02:28:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35968 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbcF1G2t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 02:28:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id c82so2991006wme.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 23:28:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c797zA83vcpy30KGewZVGlF6aQvkfL++Kf+T2bv00BU=;
        b=vBURRftt09ch/NT6vR/0HYqnDrba7JlB+KeynpwhbpRFN4ZEcVjQYFB8mMhN3qlxVv
         s2yn7/6rVtLxYXwTtbwlFJ1Yse9ITGGeS4Jj9VkphwEr6g+l/q/589p+zzTmu7W2c3j8
         qgXlEhj0972/Mg5lXE4XSLDfvwA1pk1NiXniTHDUzuYc2wsq3e5dES52uC6f1EqSGKg2
         8lsIDUU6qaHnB53zV52Rv0gn4923/ij66LnP2w/0N9HWTdmxUpcPO7TGIX5BBYFfpiNu
         DZEfeVTTrbbzmdF1HDjA+9/5F4scVTOsgG/Z1AvQi931jdK7bxmyMd4x1iovL6mTKMMU
         y1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c797zA83vcpy30KGewZVGlF6aQvkfL++Kf+T2bv00BU=;
        b=O+8F/Km3duvIMqK9g+v/gfgX1PEPZ/6fhRznAD59aXOIfewq0dy8B2E5Rr8rVCkTAR
         cJhM98PHyg2VJEdAe9aUO/6CADSwEag1QngqxA29TfkksTzeoEatm2InlbNqNDGrnUVr
         sgXgELOMqfNg+N5oxRxJ/4y7TrrGeApNFQM+jwkNYsIZBLdTm1Gz4naPIJoA7W2oQr0R
         cayBEczNvwl+FZs8TkDXqN+mda/IU7Bax2YZNn52wDOUrxtGFoxnWlBBP/FXZ/KAMgaj
         fdkdtNemFpYYnwtfTCGZa8zfkvSouLLHhRLAnFLiaFWB77hNbFxrmn7o6KBbZXliB1DT
         t3Ng==
X-Gm-Message-State: ALyK8tI4fGkw49BvGVuH4nX8eEIce1434I5hVq5skw1dGuXfG+Z/lLutE9KtMaFZYlh2eqDyyw4gxPl07/VD7A==
X-Received: by 10.28.70.3 with SMTP id t3mr1603784wma.20.1467095327917; Mon,
 27 Jun 2016 23:28:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.107.170 with HTTP; Mon, 27 Jun 2016 23:28:08 -0700 (PDT)
In-Reply-To: <CAOG-3G+xAZQV8rPgdxz8S8bqzJfm1fFNg2Y4suC-a--tbCWXow@mail.gmail.com>
References: <20160628001559.29204-1-sbeller@google.com> <CAOG-3G+xAZQV8rPgdxz8S8bqzJfm1fFNg2Y4suC-a--tbCWXow@mail.gmail.com>
From:	Bart Bogaerts <bartbogaerts@gmail.com>
Date:	Tue, 28 Jun 2016 09:28:08 +0300
Message-ID: <CAOG-3G+umq4iqDz1aMu4qnjxSQrhO76N8wc4WwtBiN8n58=3Yw@mail.gmail.com>
Subject: Re: [PATCH] submodule: test moving recursive submodule
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I dit some more testing.

It is important for the bug to occur that all submodules are initialised.
So my suggestion is not yet complete, you need to add the line

git submodule update --recursive --init




Below is a complete script that show the bug occurring:



mkdir repo1 &&
mkdir repo2 &&

(
  cd repo1 &&
  git init &&
  echo "test" >> test.test &&
  git add . &&
  git commit -m "initial commit"
) &&

(
  cd repo2 &&
  git init &&
  git submodule add ../repo1 &&
  git commit -a -m "added submod"
) &&

#create the directory to test in
(
  mkdir testdir &&
  cd testdir &&
  git init &&
  git submodule add ../repo2 &&
  git commit -m "added full structure" &&
  #important to initialise .git files!
  git submodule update --recursive --init
) &&

(
  cd testdir &&
  mkdir 2015 &&
  git mv repo2 2015 &&
  git status
)

2016-06-28 9:13 GMT+03:00 Bart Bogaerts <bartbogaerts@gmail.com>:
> The only thing I still see that might cause the bug is that there is no
>
> git submodule update --recursive
>
> present in your test cases .
> This command creates the .git file in the nested subsubmodule
> It is that .git file that is not correctly updated in the move.
>
> So after the line
> +       git submodule add ./outer_sub ./deep/outer_sub &&
> I would add
> +       git submodule update -- recursive &&
>
> 2016-06-28 3:15 GMT+03:00 Stefan Beller <sbeller@google.com>:
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> This tries to reproduce the error as pointed out in
>> http://stackoverflow.com/questions/32782382/git-moving-submodules-recursively-nested-submodules
>> but the tests pass. This still seems to be missing a detail.
>>
>> Bart any idea how this setup may be different than what you have?
>> Instead of applying the patch, you can also checkout
>> https://github.com/stefanbeller/git/tree/submodule_recursive_mv_test
>> which is the patch below applied on top of Junios (the maintainer) master branch.
>> To look around on the filesystem, you can drop "test_pause &&" in a test and
>> then run the test with `(cd t && ./t7001-mv.sh -v)` (more info how to run tests
>> in the Git test suite in t/README, maybe -i -v -x are interested)
>>
>> Thanks,
>> Stefan
>>
>>  t/t7001-mv.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>
>> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
>> index 4a2570e..404e5bd 100755
>> --- a/t/t7001-mv.sh
>> +++ b/t/t7001-mv.sh
>> @@ -295,6 +295,28 @@ test_expect_success 'setup submodule' '
>>         mkdir -p deep/directory/hierachy &&
>>         git submodule add ./. deep/directory/hierachy/sub &&
>>         git commit -m "added another submodule" &&
>> +       mkdir inner_sub &&
>> +       (
>> +               cd inner_sub &&
>> +               git init &&
>> +               test_commit initial
>> +       ) &&
>> +       mkdir outer_sub &&
>> +       (
>> +               cd outer_sub &&
>> +               git init &&
>> +               test_commit initial &&
>> +               git submodule add ../inner_sub &&
>> +               git commit -a -m "add an inner submodule"
>> +       ) &&
>> +       git submodule add ./outer_sub ./deep/outer_sub &&
>> +       git commit -a -m "add outer sub" &&
>> +       git -C deep ls-tree HEAD |cut -f 2 >actual &&
>> +       cat >expect <<-EOF &&
>> +       directory
>> +       outer_sub
>> +       EOF
>> +       test_cmp expect actual &&
>>         git branch submodule
>>  '
>>
>> @@ -488,6 +510,27 @@ test_expect_success 'moving a submodule in nested directories' '
>>                 git config -f ../.gitmodules submodule.deep/directory/hierachy/sub.path >../actual &&
>>                 echo "directory/hierachy/sub" >../expect
>>         ) &&
>> +       test_cmp actual expect &&
>> +       git commit -a -m "mv a submodule in nested dir"
>> +'
>> +
>> +test_expect_success 'moving a submodule with a nested submodule' '
>> +       git mv deep/outer_sub outer_sub_moved &&
>> +       # git status would fail if the update of linking git dir to
>> +       # work dir of the submodule failed.
>> +       git status &&
>> +       git config -f .gitmodules submodule.deep/outer_sub.path >actual &&
>> +       echo "outer_sub_moved" >expect &&
>> +       test_cmp actual expect
>> +'
>> +
>> +test_expect_success 'moving back the submodule with a nested submodule' '
>> +       git mv outer_sub_moved deep/outer_sub &&
>> +       # git status would fail if the update of linking git dir to
>> +       # work dir of the submodule failed.
>> +       git status &&
>> +       git config -f .gitmodules submodule.deep/outer_sub.path >actual &&
>> +       echo "deep/outer_sub" >expect &&
>>         test_cmp actual expect
>>  '
>>
>> --
>> 2.9.0.4.g35eb263.dirty
>>
>
>
>
> --
> Bart Bogaerts



-- 
Bart Bogaerts
