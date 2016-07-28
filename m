Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99BC81F955
	for <e@80x24.org>; Thu, 28 Jul 2016 18:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbcG1SrP (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 14:47:15 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35342 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbcG1SrO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 14:47:14 -0400
Received: by mail-it0-f49.google.com with SMTP id u186so175558956ita.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 11:47:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mguOS3ZABaJVItDqueP+MP81jI9J8e1U0T5TVH7t1sM=;
        b=GuyXDbcYcTR52Wy8dQQ/eM4Bvg3FPdKZsMMZbpoGbiTKjBLIhOd42S5rM05XGjRo8c
         RXZ74b/OEtiZmkhEoIHqWZfvl51DndSBDOTX7WYROzNz2VpipVk0ocikeFZwZFF3wiLK
         4e7R8tejEsUExmnmONNk7iKIxV60jlhHkAwh/MJ4QQS1Wb4FSoZ9Xep6bfHgP8lgMbUq
         t6sTKuNPXq0CEggWD63N6kGjC0XW60Px8ef8gvhBWAJt3+IHQojlRqVLDW7+NOhPHkUh
         9etbeJOdU19nq/cmLaP9fdekQHmWyPsZwsqLADuK19wnXWPJUa1IvxMX0d+jFBk/f8KW
         QCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mguOS3ZABaJVItDqueP+MP81jI9J8e1U0T5TVH7t1sM=;
        b=KJERTvGyhy+3zM8My8xo6QJXFM9r/iLtYQJ2Ke0we4pwWB9lPHDR+gNppYapu7/jwH
         7Nfgonhb6bfEbineaLPgNQPqhQBtJmEc5XyFIcXMYqlGhzNgcCDGdKRgjeu4fT1tmkFs
         J+727B1H2GcIa1jT4Fy+Txp5hIuiQveOX9kUA7E9CBdUIDgjKnSXkUuTgAsTrK6TvbKx
         /513CBifCjTj7yDpWSoRzMichUKFhTiML9DnEF83ctzHrm6VPNAsXhuxG9j61FwaLb0f
         9mKdQJqO8pvrD2/c43M3GgKc/RNoICGiFhEAAfqxusk4VxWkMHKSFAcF7og6ZUGbjaQ0
         i+zw==
X-Gm-Message-State: ALyK8tIdH2U6NowouJohoSrKJifzP72byzkk0HfYkKTOYvC7zFAFohLPrRk78dDshAO9pcSqsIBd2qIChFK2141i
X-Received: by 10.36.250.132 with SMTP id v126mr83829778ith.46.1469731632796;
 Thu, 28 Jul 2016 11:47:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 28 Jul 2016 11:47:12 -0700 (PDT)
In-Reply-To: <xmqqeg6dsj33.fsf@gitster.mtv.corp.google.com>
References: <20160728172641.8376-1-sbeller@google.com> <20160728172641.8376-2-sbeller@google.com>
 <xmqqeg6dsj33.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 28 Jul 2016 11:47:12 -0700
Message-ID: <CAGZ79ka5n1_5CM3DOGHcd3W=4KJb9d-sb=E1pyvzP=XWGVXE3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] t7406: correct depth test in shallow test
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> We used to ask for 3 changes and tested for having 1, so the test
>> seems broken.
>
> I am not sure what to think of "seems broken".

When asking for depth 3, I would expect a result of 1,2, or 3 commits.

But when testing the depth argument with a history less than 3, and then
implying: "I got 1, which is less than 3, so the depth works", seems
to be a logical shortcut to me.

I would have expected a history of >3, then ask for 3 and confirm we did not
get 4 or 5 or 6, but 3 only.

>
> Asking for 3 and having 1 is broken in what way?  Should we be
> expecting for 3 because we asked for that many?  Should we expect
> less than three even though we asked for three because the upstream
> side does not even have that many?  If the current test that asks
> for 3 and gets only 1 is not failing, why should we expect that
> asking for 2 would get 2?  In other words, why is it sane that
> asking for fewer number of commits gives us more?

I think there is a subtle thing going on, that I did not examine properly but
it is hidden in the modernization from

    test 1 = $(something)
 to test_line_count = 2

I'll investigate the actual reason.

>
> Also most of the lines in this subshell seem to be breaking
> &&-chain.

Thanks for pointing that out, will fix while at it.

>
>
>
>> Correct the test by using test_line_count that exists in the test suite.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  t/t7406-submodule-update.sh | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>> index 88e9750..bd261ac 100755
>> --- a/t/t7406-submodule-update.sh
>> +++ b/t/t7406-submodule-update.sh
>> @@ -846,9 +846,10 @@ test_expect_success 'submodule update clone shallow submodule' '
>>       (cd super3 &&
>>        sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
>>        mv -f .gitmodules.tmp .gitmodules &&
>> -      git submodule update --init --depth=3
>> +      git submodule update --init --depth=2
>>        (cd submodule &&
>> -       test 1 = $(git log --oneline | wc -l)
>> +       git log --oneline >lines
>> +       test_line_count = 2 lines
>>        )
>>  )
>>  '
