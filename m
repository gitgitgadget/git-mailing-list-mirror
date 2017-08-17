Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9055720899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753480AbdHQVza (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:55:30 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35483 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753470AbdHQVz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:55:29 -0400
Received: by mail-yw0-f170.google.com with SMTP id n83so21278997ywn.2
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 14:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PR78wPXpyyDPx/M7REy0S6I25n+3gZHUbgJ7uldZaws=;
        b=q8MApmpjAV1+7aCtxCsc3DbMvEpQifvEti9Gd55jMqb9eqFlWILBGm6SrdJal67Syk
         qxhP9yXlD574S3xAj5Me1gYfy3yGx8IO7nq+kyMPU7Kq9X1AAcvo1QAw7vt58yDW0TrU
         p1mg/sqYR7dusOHWD3ED1inNr/mBLIpXArsKj5uwJFWwFW7vu8Vth5VCido8NMKQP8zi
         F2SKxjufZwYx7oqY2jlt0/zX/7EVzeyMiWTcnhxcCYABkLdw0ALK6DCAEm+XXyxIQYbI
         PUuX2x5ZGnljupFUB/lEOBjNcWmYfPc8OCkdwpERadZ3nCb1Jg+Bx9/1CbWwiNct4s9O
         +/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PR78wPXpyyDPx/M7REy0S6I25n+3gZHUbgJ7uldZaws=;
        b=YTSD9EH4bDdF1kuhLm0WpF/TiAPK5N/IwLpMIIsaiWo7DyHRuxl14KDus5493SQJq/
         Pfn3MeoQ+vc9pBnmgFfAYh+niJD0hy64wxnwAxwLeA38DRdL1tupZMAKzhIYvZ2Ona+f
         sOVRPYaMlhNbalt7OoG0NBzBKRQTev69fNi8stuSqfEl9Ptq5Hu4d3XmnVBscCdl1JRl
         fTbCgoWeRLV0eX1CdZDJyLR9TbbXMpPFh2cYEUPATLyfMdxgO5dXZrNkv+D0K5zAUGF7
         yJK9C6Wf2wyi+RaZ5nmCkvOBWHDoBsgR13Hw4QQK8aKWZRg8Art0WasyxIJmclxGuPol
         atXQ==
X-Gm-Message-State: AHYfb5jYSRU0WAQwPkU4LMs+Y/YeZVyc5vNnAAnP4T4Zw5oLhnFWO53m
        OgTWi+yXy6TKgMign4iK8rtFb9WoEGFG
X-Received: by 10.129.93.194 with SMTP id r185mr5448245ywb.33.1503006927900;
 Thu, 17 Aug 2017 14:55:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Thu, 17 Aug 2017 14:55:27 -0700 (PDT)
In-Reply-To: <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com>
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
 <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com> <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Aug 2017 14:55:27 -0700
Message-ID: <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
Subject: Re: Submodule regression in 2.14?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 2:21 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> Oh, wait.
>> $ git log --oneline v2.13.0..v2.14.1 -- builtin/pull.c
>> c9c63ee558 Merge branch 'sb/pull-rebase-submodule'
>> a6d7eb2c7a pull: optionally rebase submodules (remote submodule changes only)
>> could also be a culprit. Do you have pull.rebase set?
>
> I bisected the problem today and "a6d7eb2c7a pull: optionally rebase submodules
> (remote submodule changes only)" is indeed the culprit.
>
> The commit seems to break the following test case.
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index dcac364c5f..24f9729015 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1289,4 +1289,19 @@ test_expect_success 'init properly sets the config' '
>         test_must_fail git -C multisuper_clone config --get submodule.sub1.active
>  '
>
> +test_expect_success 'submodule update and git pull with disabled submodule' '
> +       test_when_finished "rm -rf multisuper_clone" &&
> +       pwd=$(pwd) &&
> +       git clone file://"$pwd"/multisuper multisuper_clone &&
> +       (
> +               cd multisuper_clone &&
> +               git config --local submodule.sub0.update none &&
> +               git submodule update --init --recursive &&
> +               git pull --recurse-submodules &&
> +               git submodule status | cut -c 1,43- >actual
> +       ) &&
> +       ls &&
> +       test_cmp expect multisuper_clone/actual
> +'

Thanks for providing this test.

cd trash directory.t7400-submodule-basic/multisuper_clone
cat .git/config
[submodule "sub0"]
  update = none
  active = true
  url = file:///.../t/trash directory.t7400-submodule-basic/sub1


submodule.<name>.update
    The default update procedure for a submodule.
    This variable is populated by git submodule init
    from the gitmodules(5) file. See description of
    update command in git-submodule(1).

The first sentence of .update is misleading IMHO as the
these settings should strictly apply to the "submodule update"
command. So "pull --recurse-submodules" ought to ignore it,
instead the pull can do whatever it wants, namely treat the
submodule roughly like a tree and either merge/rebase
inside the submodule as well. The user *asked* for recursive
pull after all.

Are you saying this might be a design mistake and
the .update ought to be respected by all the other
commands? For example
    git reset --recurse-submodules
should ignore the .update= none?

When designing these new recursive submodule functionality
outside the "submodule" command, I'd want submodules
to behave as much as possible like trees.

ideas?

Thanks,
Stefan

> +
>  test_done
>
>
> I am not familiar with the code. Does anyone see the problem
> right away?
>
> Thanks,
> Lars
>
>
