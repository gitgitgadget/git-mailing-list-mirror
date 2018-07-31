Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C9171F597
	for <e@80x24.org>; Tue, 31 Jul 2018 19:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbeGaVf7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 17:35:59 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41641 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732372AbeGaVf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 17:35:59 -0400
Received: by mail-qt0-f193.google.com with SMTP id e19-v6so17328549qtp.8
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MBtbu5zfNQLnvKWmKTEzeqwImfih/tITWK89VxlMGu4=;
        b=A4b3a0L4FPC4Wwvd3+NHxOe3lNBkJ95pXa79XVOvyKhFF5XlsRJDdTUuDe5UGKQjSX
         999T4XWWCqDI84LqHtdaAd29DvQ6Z7rJx8i3eOzbxlWqyNZgIhj1LfNYVB19u2XVtf33
         wRQeQ8EiiNVNct0WOP2t15VX4Iw4lrm+mL5E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MBtbu5zfNQLnvKWmKTEzeqwImfih/tITWK89VxlMGu4=;
        b=OuV4sXg/yL6JfDUsIZC07VQCQ6TlMxyPhZY9btKl8E/5rmgY7daJx39ZvjHnTHVWgC
         FENblQG8t0stdWhsVrx+AwWJHFkIrxYhhRvn3eEFT3RUcdT1NOHrQIirVLPNO7qCz57e
         COoG214V0izzzQbFJjDLMDx4Q/pQKapCjkQxKgK671kqB3QJ4CnoK5N9E7+GKtpQYql9
         Ky/nwm6MenNsKlAkW2O1X4P6xNchvs0J1yd+ZVU753VqEwLO6JfAZ765ffHGwCrcVPGq
         QN0vfQ54IY3wwugA6dZHpXHLykQLI3wElCDY/Hr8l0hJLaNNdvQUIm2KhVxTAhlEnMC+
         O/Tw==
X-Gm-Message-State: AOUpUlExCOqKaJotwpb6POww6LafSfeUe2VBZll/0heh0VFDxwS7i2yy
        V/nzWN7yY84X7r6mFMGeLXWw/tyfUH0OgI5LR6pbXw==
X-Google-Smtp-Source: AAOMgpdggC1yuWzeZcfb6ZssY8ztlGnTNfHi1D+q9vPjEFTSRhs2kLHf8Di7whRPHTDV0FLjuPeNKly+4txJ4IPI048=
X-Received: by 2002:a0c:d90a:: with SMTP id p10-v6mr20636616qvj.171.1533066845826;
 Tue, 31 Jul 2018 12:54:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:3763:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 12:54:05
 -0700 (PDT)
In-Reply-To: <xmqqh8kfeae3.fsf@gitster-ct.c.googlers.com>
References: <xmqq36w6rlh7.fsf@gitster-ct.c.googlers.com> <20180727112222.19061-1-chenbin.sh@gmail.com>
 <20180731084638.18793-1-szeder.dev@gmail.com> <CAE5ih7_jh55mLVBhiu12gmc0j3mGkm4s0VU2Stx5iGf1tK6yzA@mail.gmail.com>
 <xmqqh8kfeae3.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 31 Jul 2018 21:54:05 +0200
Message-ID: <CAE5ih7-pLAW8xrY_F2z6gDxaMuA4w+nuUQHeLvGdSyn0GXebWA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add the `p4-pre-submit` hook
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chen Bin <chenbin.sh@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31 July 2018 at 16:40, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> I think there is an error in the test harness.
>>
>> On 31 July 2018 at 10:46, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote=
:
>>>> +             test_must_fail git-p4 submit --dry-run >errs 2>&1 &&>
>>>> +             ! grep "Would apply" err
>>
>> It writes to the file "errs" but then looks for the message in "err".
>>
>> Luke
>
> Sigh. Thanks for spotting, both of you.
>
> Here is what I'd locally squash in.  If there is anything else, I'd
> rather see a refreshed final one sent by the author.
>
> Thanks.
>
>  t/t9800-git-p4-basic.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> index 2b7baa95d2..729cd25770 100755
> --- a/t/t9800-git-p4-basic.sh
> +++ b/t/t9800-git-p4-basic.sh
> @@ -274,19 +274,19 @@ test_expect_success 'run hook p4-pre-submit before =
submit' '
>                 git add hello.txt &&
>                 git commit -m "add hello.txt" &&
>                 git config git-p4.skipSubmitEdit true &&
> -               git-p4 submit --dry-run >out &&
> +               git p4 submit --dry-run >out &&
>                 grep "Would apply" out &&
>                 mkdir -p .git/hooks &&
>                 write_script .git/hooks/p4-pre-submit <<-\EOF &&
>                 exit 0
>                 EOF
> -               git-p4 submit --dry-run >out &&
> +               git p4 submit --dry-run >out &&
>                 grep "Would apply" out &&
>                 write_script .git/hooks/p4-pre-submit <<-\EOF &&
>                 exit 1
>                 EOF
> -               test_must_fail git-p4 submit --dry-run >errs 2>&1 &&
> -               ! grep "Would apply" err
> +               test_must_fail git p4 submit --dry-run >errs 2>&1 &&
> +               ! grep "Would apply" errs
>         )
>  '

That set of deltas works for me.

Sorry, I should have run the tests myself earlier and I would have
picked up on this.
