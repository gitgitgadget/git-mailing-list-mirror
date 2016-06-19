Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13031FE4E
	for <e@80x24.org>; Sun, 19 Jun 2016 11:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbcFSLa4 (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 07:30:56 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33448 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcFSLaz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 07:30:55 -0400
Received: by mail-qk0-f178.google.com with SMTP id a186so131442833qkf.0
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 04:30:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NdulpzvzvWmBKezLd0G0vE1PJtS+a7HehNP7nBw9c9c=;
        b=ZqARo9/qkZSaHG0Q+tAoTOfFc6fH7bnDEHhk1cDct+Q1NVGZZ0rVcvOb5SpgwiTwCB
         rm+uYDoiLWV5JfyRji0ty1lrzr5njjwYG9xhiWf8mbNjDSmMnHpkblQhi4Me2+bOcVYD
         xsJF1Mmqu8+jgZ/omchczv/Jv4EufD18LkrnhevMsQgDZO64//JbJRpVFtuGBpPBTq7K
         jLWe/o6jHQoMypBNrvV4rHPxU59wtEcddVUqFq1iZC/kB1TNhDwK3ZW32Rp/aT5/DiyT
         3pUzrcjsy7FlJHiIZsCmk2jd54UGNvjK4NMKKQgBcYgiCF8vWGcoOvyYq80bCiMGCqrC
         mysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NdulpzvzvWmBKezLd0G0vE1PJtS+a7HehNP7nBw9c9c=;
        b=kHzX9DzaIT7qpFJ033z9ysHxA7CNj5mWsWBWpTU/IswR+05Bhcqa38AUXo8Cc/esuD
         trt7v0x2sviCh3PWFw8X4mJrH1qQNaP/fVs7RNHQaavtEdAhuaMlQkndLt6j+tt3BTjI
         zNgkx6g7ZBLszUYIL5+873KiOZYXMUcnsr9S1NuUxlky4ommOGmrOfH3KoHg484gjsEc
         GMWybLUdeF+n/eGr9ANDnRTS0n3L/OMF5wNrs9CKn62/GEYe5c/ezKID6/+3ZtbY7Xd/
         O2Dp3vUC2g0BPisHHvDF55VbTXV3OdAPoOeGrJK6GgZUfujH+PtrI4VkwOjwCjqOAht+
         GZ0w==
X-Gm-Message-State: ALyK8tI5SHgVTSFrmhO/CrrKt4cdMRLIBp/sfs+XguE2L6npx5fMXoA/qpzQIU4VI8bRKuiBj+19VwTU4+bvpg==
X-Received: by 10.55.160.132 with SMTP id j126mr14064305qke.108.1466335853937;
 Sun, 19 Jun 2016 04:30:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.123.6 with HTTP; Sun, 19 Jun 2016 04:30:53 -0700 (PDT)
In-Reply-To: <CAPig+cRZyCZuec1GuxtW0p_8G1VPq1y846USM-TNmP3bbTYxQA@mail.gmail.com>
References: <20160618122510.5105-1-mehul.jain2029@gmail.com>
 <20160618122510.5105-3-mehul.jain2029@gmail.com> <CAPig+cRZyCZuec1GuxtW0p_8G1VPq1y846USM-TNmP3bbTYxQA@mail.gmail.com>
From:	Mehul Jain <mehul.jain2029@gmail.com>
Date:	Sun, 19 Jun 2016 17:00:53 +0530
Message-ID: <CA+DCAeTvaYNm3fPfO_WH7ZKo56mBnD8McfENJtQbNwjAL9eDcw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] log: add log.showSignature configuration variable
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Eric,

Thanks for your review.

On Sun, Jun 19, 2016 at 12:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Jun 18, 2016 at 8:25 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
>> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>> @@ -900,6 +900,31 @@ test_expect_success GPG '--no-show-signature overrides --show-signature' '
>> +test_expect_success GPG 'log.showsignature=true behaves like --show-signature' '
>> +       git checkout -b test_sign master &&
>
> It appears that you copied the bulk of this test from the 'log --graph
> --show-signature' test and changed it to create a new branch named
> 'test_sign' rather than 'signed', however...
>
>> +       echo foo >foo &&
>> +       git add foo &&
>> +       git commit -S -m signed_commit &&
>> +       test_config log.showsignature true &&
>> +       git log -1 signed >actual &&
>
> ... you're incorrectly testing against the 'signed' branch rather than
> the 'test_sign' created specifically for this test.

Yes, I made a mistake here.

>> +       grep "gpg: Signature made" actual &&
>> +       grep "gpg: Good signature" actual
>> +'
>> +
>> +test_expect_success GPG '--no-show-signature overrides log.showsignature=true' '
>> +       test_config log.showsignature true &&
>> +       git log -1 --no-show-signature signed >actual &&
>> +       ! grep "^gpg:" actual
>> +'
>> +
>> +test_expect_success GPG '--show-signature overrides log.showsignature=false' '
>> +       test_when_finished "git reset --hard && git checkout master" &&
>
> So, in the first of these three new tests, you're setting up some
> state by creating and checking out a new branch named 'test_sign', and
> leaving that branch checked out while these three tests run, and
> finally use test_when_finished() in the last of the three tests to
> restore sanity (by returning to the 'master' branch) when that test
> exits.
>
> This is ugly and couples these three tests too tightly. It would be
> better to make each test more self-contained, not relying upon state
> left over from previous tests.
>
>> +       test_config log.showsignature false &&
>> +       git log -1 --show-signature signed >actual &&
>> +       grep "gpg: Signature made" actual &&
>> +       grep "gpg: Good signature" actual
>> +'
>
> In fact, the original 'log --graph --show-signature' test which
> created the 'signed' branch, the new --no-show-signature test added in
> patch 1/2, and the three new tests here could all just work against
> the same 'signed' branch. There is no need to create a new 'test_sign'
> branch for these three tests, or a 'nosign' branch for the patch 1/2
> test.
>
> Therefore, it probably would make more sense to add a new distinct
> 'setup signed' test (or just enhance the existing 'setup' test) which
> creates the 'signed' branch and update the original 'log --graph
> --show-signature' to take advantage of it, as well as each of the new
> tests introduced by this patch series. And since each test would
> mention 'signed' explicitly in its git-log invocation, there's no need
> to leave that branch checked out, so the setup test itself only needs
> test_when_finished() to ensure that the current branch is restored to
> 'master'.

Adding a new test 'setup signed' will work, where I will create a new
'signed' branch and use that branch in new --no-show-signature test
introduced in patch 1/2, and the three tests in current patch 2/2. Also by
creating a preparatory patch for this series, I will modify the 'log --graph
--show-signature' test, so that it can also take advantage of new 'setup
signed' test.

Though I'm wondering if whether there is a need to create the new 'setup
signed' test. In 'log --graph --show-signature' test, we already have the
'signed' branch, which could be used in the test introduced here. But this
will couple the tests, 'log --graph ...' and new ones, tightly. Because if in
future someone changes the 'log --graph ...' test, then there is a possibility
of new tests (introduced in patch 1/2 and 2/2) to fail. So creating a new test
for creation of 'signed' branch seems fair.

Thanks,
Mehul
