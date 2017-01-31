Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39B311F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 22:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750873AbdAaWMx (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 17:12:53 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:36644 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdAaWMw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 17:12:52 -0500
Received: by mail-io0-f182.google.com with SMTP id j13so142793081iod.3
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 14:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=15hLcJbNw48ORQf8z9LSIE7DShJPFfXY7h0eUKIdMQo=;
        b=Zi6gooCJhCDxMzuG3Da4LmsUCI0rCrqS3a+ISBbqwVouB9jOfUKhnxGh6UVEjpHaey
         3U0i3KUniI8V9pdTa8qb4tz8imaLwE1+ZENei487RS8iaJTU2mkGEjgj1sr6j5KJmy6c
         /H4DM00et839gkjp9n9LHg8ENRATbcJaxNoGA9pJFLFWQXI4Ho2D2eXkynVWfCmhPH66
         Rr1o3xuHa9m8MxtdS7qRXFIGLRHqXr3CukEcxPsU3BJouKPh0/28ko/vuU2zI18XBcBu
         QAKTKLWWdXimd69xp+SmGRnDiv2qCZxCBuANhQExK4FWMR81d3U3KkZUpivj20k1goqD
         CtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=15hLcJbNw48ORQf8z9LSIE7DShJPFfXY7h0eUKIdMQo=;
        b=sjfeMeabt6A1iGnkGxab1334efN+6BTd2xFwRDzAOE0+dj9+Xjt6wkKclaB0vTb+kk
         muzMEWHEc55aQKaHlYDvOZUaDrHBsLm8wdyPAvCuvch0Ysys0FfDnA5aLLZxGq9H8/+x
         EfVRpUrJGenLhhVx1b4pWhLD8NsmztfMTDPy01e1KL97O5K+drCu7Wn0k/r3e5xJnCY8
         4fHsHyg3Lquos86ZXyon24xESidhVHP/a3mK99xeAXDdLm/ShRybgPaiMFhwtp+z/+ww
         Zc+d3ewfabu2NR5J2bUhMCR4+pmwciVdz1c6m0LdE8Q6yorGUKFsDosfybS4R6X3zSP4
         KXBg==
X-Gm-Message-State: AIkVDXLjm6mf+oOhBNE8wYzHPKm5prvjQobaiD5+KU3OsnbGilwGpxxbX1t6c8N/08WoFsV7Dq6cToOtZvzEe14M
X-Received: by 10.107.16.14 with SMTP id y14mr106852ioi.164.1485900771287;
 Tue, 31 Jan 2017 14:12:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 31 Jan 2017 14:12:50 -0800 (PST)
In-Reply-To: <xmqq37fyriji.fsf@gitster.mtv.corp.google.com>
References: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
 <1485809065-11978-5-git-send-email-email@benjaminfuchs.de>
 <CAM0VKj=j8Fy8AQvYbbvwPf5kkV1GYYONADNsQO5RDNTUzdYt8w@mail.gmail.com> <xmqq37fyriji.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 31 Jan 2017 14:12:50 -0800
Message-ID: <CAGZ79kZv=LoP+nG0GVtU_Zi+_SX8_98AXFqzXNh=xM6ASy+=Gw@mail.gmail.com>
Subject: Re: [PATCH 4/4] git-prompt.sh: add tests for submodule indicator
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Benjamin Fuchs <email@benjaminfuchs.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        ville.skytta@iki.fi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2017 at 2:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> On Mon, Jan 30, 2017 at 9:44 PM, Benjamin Fuchs <email@benjaminfuchs.de>=
 wrote:
>>> Signed-off-by: Benjamin Fuchs <email@benjaminfuchs.de>
>>> ---
>>>  t/t9903-bash-prompt.sh | 43 ++++++++++++++++++++++++++++++++++++++++++=
+
>>>  1 file changed, 43 insertions(+)
>>>
>>> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
>>> index 97c9b32..4dce366 100755
>>> --- a/t/t9903-bash-prompt.sh
>>> +++ b/t/t9903-bash-prompt.sh
>>> @@ -37,6 +37,11 @@ test_expect_success 'setup for prompt tests' '
>>>         git commit -m "yet another b2" file &&
>>>         mkdir ignored_dir &&
>>>         echo "ignored_dir/" >>.gitignore &&
>>> +       git checkout -b submodule &&
>>> +       git submodule add ./. sub &&
>>
>> ./. ?
>
> Good eyes.  This is a pattern we are trying to wean ourselves off
> of.  E.g. cf.
>
>     https://public-inbox.org/git/20170105192904.1107-2-sbeller@google.com=
/#t
>
> Hopefully this reminds us to resurrect and finish the test fixes in
> that thread?

I plan to eventually, yes. but that is a refactoring, that has lower prio
than getting checkout working recursing into submodules.
