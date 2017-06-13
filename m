Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8189A1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 19:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbdFMTy7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 15:54:59 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35569 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbdFMTy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 15:54:58 -0400
Received: by mail-ot0-f193.google.com with SMTP id z48so362561otz.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 12:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JSAJ9rZKq/2lKbUKEAYf3+kJTiTFK/E2pbb0UmgoqRg=;
        b=a1xg1TZaZo+2/w/7SfPgBY/HH4K5rtjI4GHiOlLUIRbyDeLFLISv1YU7KqH9Dp41op
         BUBFnzcvEw6gPck2/RC/PtoOgz2Uw1RD1eYpaufVCqoo+izW0yT87T0wK3cO6v2apTJe
         wPNOi9GRhL5oOHmgnXsCF+UD0edKQ8mwtOfSvbIfJOWsGUWjXFaZbAPbimh1NS5yvNvp
         /34VM6c0z34T8+ubcRDrxY1nxCJ4A5YDfVHHYbAf4WJhNVdPMa7TGjPMVO8oc7/6TZm0
         +39+LyGuhiJ6WjuI7LTgI1s8Xi6wpUAW6/x3SkgAIMGfFQ43WWAYH/SnGlTpGzLWis7h
         cfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JSAJ9rZKq/2lKbUKEAYf3+kJTiTFK/E2pbb0UmgoqRg=;
        b=lf81nwB00civC2zstaRdHy6KDhq+sDADeb9m9bqtj846l5jfSDKWSVsg0ZTAGxTbRj
         7SF0aEgClhOE1dB12AGHmJhMGtrEyOTN6WSS4IwqqzxGYMbVRV5gxegorPdIWvIgPVJ1
         Brn0O28kEgEII2svWBT/Drrmnql7s9BJ9HTSW5HTh3of+zWWk2rZYUgA9z5lDsOMH0A5
         00ndzxPaJTm5OqxdxFVyhU/ToB6o0M+LGsmbrCcQa0kDWeehH/2wdrxEWWpfx1G2zHj/
         Uq7C8eIYK92of0lhAgtRQwHW+bDo4p6k2HCc+mZYXkpw5OmIEU16FMsUQMX4DEmlGa1O
         LMcQ==
X-Gm-Message-State: AKS2vOwk8EK+Hi+Ip5VcE798iFAHOK3y2P7dCKZMgpgPHvir33pdG9Oa
        NzCuSjpu+ufQ5qZS8pRxFvROyVVauvQgtv4=
X-Received: by 10.157.29.194 with SMTP id w2mr1228797otw.15.1497383697865;
 Tue, 13 Jun 2017 12:54:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.51.169 with HTTP; Tue, 13 Jun 2017 12:54:37 -0700 (PDT)
In-Reply-To: <xmqqefun65h0.fsf@gitster.mtv.corp.google.com>
References: <20170608005535.13080-1-joel@teichroeb.net> <20170608005535.13080-3-joel@teichroeb.net>
 <xmqqefun65h0.fsf@gitster.mtv.corp.google.com>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Tue, 13 Jun 2017 12:54:37 -0700
X-Google-Sender-Auth: q1r9KUlFIRjfd5OEMOC860wCy-w
Message-ID: <CA+CzEk8QiSu4heMDsx7XC729UEPNm6hdZfs9W5uwoJBvuLWr+w@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] stash: Add a test for when apply fails during
 stash branch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 12:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Joel Teichroeb <joel@teichroeb.net> writes:
>
>> If the return value of merge recurisve is not checked, the stash could end
>> up being dropped even though it was not applied properly
>
> s/recurisve/recursive/
>
>> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
>> ---
>>  t/t3903-stash.sh | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
>> index cc923e6335..5399fb05ca 100755
>> --- a/t/t3903-stash.sh
>> +++ b/t/t3903-stash.sh
>> @@ -656,6 +656,20 @@ test_expect_success 'stash branch should not drop the stash if the branch exists
>>       git rev-parse stash@{0} --
>>  '
>>
>> +test_expect_success 'stash branch should not drop the stash if the apply fails' '
>> +     git stash clear &&
>> +     git reset HEAD~1 --hard &&
>> +     echo foo >file &&
>> +     git add file &&
>> +     git commit -m initial &&
>
> It's not quite intuitive to call a non-root commit "initial" ;-)
>
>> +     echo bar >file &&
>> +     git stash &&
>> +     echo baz >file &&
>
> OK, so 'file' has 'foo' in HEAD, 'bar' in the stash@{0}.
>
>> +     test_when_finished "git checkout master" &&
>> +     test_must_fail git stash branch new_branch stash@{0} &&
>
> Hmph.  Do we blindly checkout new_branch out of stash@{0}^1 and
> unstash, but because 'file' in the working tree is dirty, we fail to
> apply the stash and stop?
>
> This sounds like a bug to me.  Shouldn't we be staying on 'master',
> and fail without even creating 'new_branch', when this happens?

Good point. The existing behavior is to create new_branch and check it
out. I'm not sure what the correct state should be then. Create
new_branch, checkout new_branch, fail to apply, checkout master?
Should it then delete new_branch? Is there a way instead to test
applying the stash before creating the branch without actually
applying it? Something like putting merge_recursive into some kind of
dry-run mode?

>
> In any case we should be testing what branch we are on after this
> step.  What branch should we be on after "git stash branch" fails?
>
>> +     git rev-parse stash@{0} --
>> +'
>> +
>>  test_expect_success 'stash apply shows status same as git status (relative to current directory)' '
>>       git stash clear &&
>>       echo 1 >subdir/subfile1 &&
