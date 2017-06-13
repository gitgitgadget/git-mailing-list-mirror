Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F89A1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 18:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753778AbdFMSJI (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 14:09:08 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35370 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753766AbdFMSJG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 14:09:06 -0400
Received: by mail-pg0-f53.google.com with SMTP id k71so64051278pgd.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CMJd3M2uzxqgrGQkFcGm/NFyckNtBjtr3cFqBwjK3fU=;
        b=QQ+ln60YC//uEwRR8qP3CQI2Grzea0xYuTJGJyXfhYYI2A4f1uzHS/2Jsx2xdDDcSs
         2o8D1jcVWV8YIAL1lQ7Nu6IqsXKY71olqyl1a2b0tg4du+uQ1YTBOvA9ExJ4bK2aUKWK
         ypGnYKrJjt3V0QI4E4uDDLQkqf46gUlMoPAApxUYZdJBMYr2RcK1j4TQkU6rYRYt4cIx
         /cu38GA1J6/aZEKbVHWb45d0xfQYvlumFihj3Y5Bx7yyTYg/QginJUJnQUt0gLGotP6Z
         KZxA6UjWJZLrDAaewsHGJUh1LKcdADg6KZWayF7QxqJtYss3VI4w7OZP5CfLHx8EZKQw
         i0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CMJd3M2uzxqgrGQkFcGm/NFyckNtBjtr3cFqBwjK3fU=;
        b=iCZPZFlIt1mEYa489T6oloVtPOX97dojGxjwwiGCXKTi/tHqrsaeV+HpRj/jBDwNZK
         lBtq9zute7RYwQJh9HAOPslBDGiG0+cpubOi87Hq/D0ZFCuYzww2bnIqDtddAP+oLgps
         VplI2/o5ZEoNXAHUqNza3rl3EgyZPRoz0EFSsC8vzr5L2aiRSgtKhpDsZl25aQ5JzWv1
         DlJH57g9Wg+qpLlyxQO6vW2WEBIt0I26lzQWgSJNfydgr1byXKzzYr36iDRQqRrVPrAK
         yBAKozbh8/9FRCkUjwCOb56sMfB3AVt+Le7EEXAvpD2a7JTWBg0x4BqC2x/jtEd/OFx2
         4BkQ==
X-Gm-Message-State: AKS2vOy0uIw0XcDn1nIBZQl8C4VrfycDPOTFZpvH1WgWMlHMv7LM+wqW
        Uc879M5SzbQrw7337UU=
X-Received: by 10.98.153.6 with SMTP id d6mr622590pfe.223.1497377340293;
        Tue, 13 Jun 2017 11:09:00 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:e453:89d5:deb:c7b6])
        by smtp.gmail.com with ESMTPSA id 62sm22515757pfz.39.2017.06.13.11.08.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 11:08:59 -0700 (PDT)
Date:   Tue, 13 Jun 2017 11:08:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] branch: add tests for new copy branch feature
Message-ID: <20170613180857.GI133952@aiede.mtv.corp.google.com>
References: <0102015c5146c8ca-e5144538-326b-47b8-8c81-af31da4cdfe0-000000@eu-west-1.amazonses.com>
 <CACBZZX4LpRK5q+cxToWqGeW2ZgN4ggo4h9SJpx0mZkZUR15jNw@mail.gmail.com>
 <CALiud+mGovAoPriJxzCB93jwkChyRb49yxVtNijfag2zx-jZ0Q@mail.gmail.com>
 <CACBZZX6LcTzFKTe0fENj95Vm7GrxT5HHs3pzrqajG0XApN-rbw@mail.gmail.com>
 <20170613175501.GH133952@aiede.mtv.corp.google.com>
 <87o9tr3gxs.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o9tr3gxs.fsf@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Tue, Jun 13 2017, Jonathan Nieder jotted:
> > Ævar Arnfjörð Bjarmason wrote:

>>> My understanding of that last part is that Jonathan/someone (see
>>> reported-by in that patch) had some script which was renaming
>>> branches, and it was easier for whatever reason to just make it no-op
>>> if the rename would have yielded the same result as doing nothing at
>>> all.
>>>
>>> Most likely your implementation will consist of just re-using the
>>> logic in rename_branch() (and renaming it to e.g.
>>> copy_or_rename_branch() ...) so you could just re-use the no-op
>>> behavior we use for -m, or if there's some reason not to no-op and
>>> error instead for -c we could just do that, but in any case this case
>>> of `git branch -c master master` or `git branch -c currentbranch`
>>> should be tested for.
>>
>> I may be missing some context, but notice that the above mentioned
>> commit is about -M, not -m.
>
> The context was just that that commit added a change in how -M
> interacted when clobbering the current HEAD, and that -C should have a
> test for that behavior, which the patch now submitted to the list has:
>
>     +test_expect_success 'git branch -C master master should work when master is checked out' '
>     +       git checkout master &&
>     +       git branch -C master master
>     +'

Perfect, thanks.  Carry on. :)

Jonathan
