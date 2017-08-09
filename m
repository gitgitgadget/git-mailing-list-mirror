Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A89631F991
	for <e@80x24.org>; Wed,  9 Aug 2017 14:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbdHIOZq (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 10:25:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34495 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752734AbdHIOZp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 10:25:45 -0400
Received: by mail-lf0-f66.google.com with SMTP id o85so4603027lff.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IKiqnyH552IDNzTHleW171/+ms4rWopbxb9Lb3+kEUw=;
        b=SWxrRkuj3MyXj7axGc3R/q41eVysgtGJcLCzRQ8m/PaKgTmk3ukXwz54LirvKmpEx+
         hWZKcYJgKdzczx2XMVv4WeiD7EZNOk0YJjPozX3K3q4lypxysCqDLQWPRSgDd/GQXPW1
         ctRSOZPB/V5YG2C9QjEFpNESx/jtEYvubKNdyaXk7YTSYBi6pYHBS+W4QXrNq1QwlA6L
         dylLQsBC2pSiZ8hwdIylZSosRAJXBYMnr7C20f60fXoIJbZOkFMmMnpY8kAAA0oezuvJ
         Gs1y3XxtaO+uOtVnA9tgrSUAES7RtoWmcY4k5UmvSnai45fwDAeZCePfM3McdwVtiRIq
         /tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IKiqnyH552IDNzTHleW171/+ms4rWopbxb9Lb3+kEUw=;
        b=TRy9C1KMFM7YcmqjfYcDFAWsS4Ei0SX+LHR+hi+ttq1Y2jyu42Uv1+g8KUsDBbRdAo
         1xNmGOp6He8ExB+sbDr8r2kcd2nyX98ieUQcPwHVSoEpqrqkIt0bQRRJnT53oFybZiIJ
         63z2QQXAJQ/qZ/2whrEdVBydmz70cX+KKBD+/MsS4OKh6f57qh+IQnpOHz8lPNQiN+du
         5U8XKZZgSqCBr6oV1s2hTgfMbfaprWdmdHwG1CXhbWx3nxLbzZOCrFDhXufg1S7WT0F2
         s8vdLSrMvsYrpWRYsgiyySsqDuVZzYQQOdp26Ax1lXPMKquExkMLoCS8HL/1Z9jOVf2A
         2cJw==
X-Gm-Message-State: AHYfb5gDtW+Ac/JyCKn+mAT3fts++C14fZLCTdfp/zcXfVZ1X5u8xoW4
        ZJikLnH3CxrBzgWYcRGmYGD1pMdxNg==
X-Received: by 10.25.19.85 with SMTP id j82mr2562351lfi.155.1502288743934;
 Wed, 09 Aug 2017 07:25:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.179.9.142 with HTTP; Wed, 9 Aug 2017 07:25:23 -0700 (PDT)
In-Reply-To: <e3e65635-2dc8-de58-5662-3eab619aedb3@web.de>
References: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de> <alpine.DEB.2.21.1.1708081648130.11175@virtualbox>
 <1e7ed028-77fe-195a-4acf-6c80d1704463@web.de> <xmqqinhxaf0i.fsf@gitster.mtv.corp.google.com>
 <xmqq7eydae7r.fsf@gitster.mtv.corp.google.com> <cd60d779-fe38-4f0e-4d36-2c40b2afec7d@web.de>
 <xmqqtw1h8g1u.fsf@gitster.mtv.corp.google.com> <50c2eaab-d1d8-3376-6e7a-1c898d978d12@web.de>
 <e3e65635-2dc8-de58-5662-3eab619aedb3@web.de>
From:   David Coppa <dcoppa@gmail.com>
Date:   Wed, 9 Aug 2017 16:25:23 +0200
Message-ID: <CABM=MFLYkVDjpeVKbErbX+szv7_NXre6U_Z_cOtKakcPDR5U3w@mail.gmail.com>
Subject: Re: [PATCH] t4062: stop using repetition in regex
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        David Coppa <dcoppa@openbsd.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 9, 2017 at 4:15 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 09.08.2017 um 08:15 schrieb Ren=C3=A9 Scharfe:
>> Am 09.08.2017 um 07:29 schrieb Junio C Hamano:
>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>
>>>> Am 09.08.2017 um 00:26 schrieb Junio C Hamano:
>>>>> ... but in the meantime, I think replacing the test with "0$" to
>>>>> force the scanner to find either the end of line or the end of the
>>>>> buffer may be a good workaround.  We do not have to care how many of
>>>>> random bytes are in front of the last "0" in order to ensure that
>>>>> the regexec_buf() does not overstep to 4097th byte, while seeing
>>>>> that regexec() that does not know how long the haystack is has to do
>>>>> so, no?
>>>>
>>>> Our regexec() calls strlen() (see my other reply).
>>>>
>>>> Using "0$" looks like the best option to me.
>>>
>>> Yeah, it seems that way.  If we want to be close/faithful to the
>>> original, we could do "^0*$", but the part that is essential to
>>> trigger the old bug is not the "we have many zeroes" (or "we have
>>> 4096 zeroes") part, but "zero is at the end of the string" part, so
>>> "0$" would be the minimal pattern that also would work for OBSD.
>>
>> Thought about it a bit more.
>>
>> "^0{4096}$" checks if the byte after the buffer is \n or \0 in the
>> hope of triggering a segfault.  On Linux I can access that byte just
>> fine; perhaps there is no guard page.  Also there is a 2 in 256
>> chance of the byte being \n or \0 (provided its value is random),
>> which would cause the test to falsely report success.
>>
>> "0$" effectively looks for "0\n" or "0\0", which can only occur
>> after the buffer.  If that string is found close enough then we
>> may not trigger a segfault and report a false positive.
>>
>> In the face of unreliable segfaults we need to reverse our strategy,
>> I think.  Searching for something not in the buffer (e.g. "1") and
>> considering matches and segfaults as confirmation that the bug is
>> still present should avoid any false positives.  Right?
>
> And that's not it either. *sigh*
>
> If the 4097th byte is NUL or LF then we can only hope its access
> triggers a segfault -- there is no other way to distinguish the
> result from a legitimate match when limiting with REG_STARTEND.  So
> we have to accept this flakiness.
>
> We can check the value of that byte with [^0] and interpret a
> match as failure, but that adds negation and makes the test more
> complex.
>
> ^0*$ would falsely match if the 4097th byte (and possibly later
> ones) is 0.  We need to make sure we check for end-of-line after
> the 4096th byte, not later.
>
> Sorry, Dscho, I thought we could take a shortcut here, but -- as
> you wrote all along -- we can't.
>
> So how about this?
>
> -- >8 --
> Subject: [PATCH] t4062: use less than 256 repetitions in regex
>
> OpenBSD's regex library has a repetition limit (RE_DUP_MAX) of 255.
> That's the minimum acceptable value according to POSIX.  In t4062 we use
> 4096 repetitions in the test "-G matches", though, causing it to fail.
> Combine two repetition operators, both less than 256, to arrive at 4096
> zeros instead of using a single one, to fix the test on OpenBSD.
>
> Original-patch-by: David Coppa <dcoppa@openbsd.org>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  t/t4062-diff-pickaxe.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/t4062-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
> index 7c4903f497..1130c8019b 100755
> --- a/t/t4062-diff-pickaxe.sh
> +++ b/t/t4062-diff-pickaxe.sh
> @@ -14,8 +14,10 @@ test_expect_success setup '
>         test_tick &&
>         git commit -m "A 4k file"
>  '
> +
> +# OpenBSD only supports up to 255 repetitions, so repeat twice for 64*64=
=3D4096.
>  test_expect_success '-G matches' '
> -       git diff --name-only -G "^0{4096}$" HEAD^ >out &&
> +       git diff --name-only -G "^(0{64}){64}$" HEAD^ >out &&
>         test 4096-zeroes.txt =3D "$(cat out)"
>  '
>
> --
> 2.14.0

I think this should work w/o problems on OpenBSD:

$ uname -a
OpenBSD open.bsdgeek.it 6.1 GENERIC#54 amd64
$ git diff --name-only -G "^0{4096}$" HEAD^ 1>/dev/null
fatal: invalid regex: invalid repetition count(s)
$ git diff --name-only -G "^(0{64}){64}$" HEAD^ 1>/dev/null
$

Ciao!
David
