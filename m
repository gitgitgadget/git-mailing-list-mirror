Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD5EA20960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755320AbdDMTfL (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:35:11 -0400
Received: from mail-ua0-f179.google.com ([209.85.217.179]:32993 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbdDMTfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:35:09 -0400
Received: by mail-ua0-f179.google.com with SMTP id q26so38930369uaa.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h7va8w0ghER47FOWWRTlJE89lrpYE0/jgXBQMYeNGqg=;
        b=HzTcx1mDwOZck+yaWVLSSmpRJvPIw6xBOY1zFc5YIN8Wgr92qax1QVjdY9W5RdkkdZ
         2EwS2phHLsyBF+rdQSeSkE17Jgru3iKh11Jpyl/ZiQvDHaBsv2rGIVBW5frhhzT2x8fQ
         9FPuV7hql3cGACbEChqr0Zgic7OH1eH3aqOCd51o6fWLQ7E4K1S7P2Dday5QF1Uyg7Hm
         y60NlL3A2j7y51yh33C/g5U1Iltx7FfZyEkvB90OSKfTOd6IUgFyH9grq8ZJpHgCrplt
         potfx4TnvOYduF37yBQUavGXBRDob/qwOd5MZw0pcYY1z3WfsqJM4waJbIv2OUY3LdbW
         ILBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h7va8w0ghER47FOWWRTlJE89lrpYE0/jgXBQMYeNGqg=;
        b=rwD10Ib23PdeEATE4JEljCx0sOTXLdxPwdJL5KA37lBbB5qc2mdaRTdZ6LUTJ3ayC6
         IABROo7REjVSBZwFk8x4ik/BqGUfivsbJHk9Ier4R4pHipnrTNw1wr6BRWVTjnHe+s36
         LwqfbzAEnkt5Zors7AYnuioxcITelp9FVlUQLd00cYeb4craP8rNOJ0JaBO+ScBrtBnh
         HqItUjzO+V5zadgtnYjPvDL7VDEGsr0cNSsHJd+H1W12n3anQW+6BXQslXM4SX2QyWbK
         h6Jrm/AuOrzP/snbqxztwsSfPm6DZGu84IxPcWmUGnuFIcnRCfXams4tdKPFKHkcY5kt
         zruA==
X-Gm-Message-State: AN3rC/5HDtnrWlygYtF4q1z5j2XxgqNjb7oMNeyAL2FiFrjkMzzYsGBz
        g4F9UhxVE9eC8gJHd3Jdgp4kTn7mbw==
X-Received: by 10.176.74.80 with SMTP id r16mr1794644uae.39.1492112108648;
 Thu, 13 Apr 2017 12:35:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.211 with HTTP; Thu, 13 Apr 2017 12:35:08 -0700 (PDT)
In-Reply-To: <20170413191236.3usecfgkjujhblo6@sigill.intra.peff.net>
References: <CAM0VKjkdqjbkqOF6ucymtuBAAgBVJQ6SGe4Ep2gqVBtNp=s_CA@mail.gmail.com>
 <20170410170154.qwzaolflrvsduwzd@sigill.intra.peff.net> <426f08b9-79c8-0c5b-e07e-4dd6a49243e9@kdbg.org>
 <CAM0VKjmuCjLBFAErXP06wu0+-7SdWVMaVu_g25Q4V-uQz8T1uA@mail.gmail.com>
 <20170412005011.46tr4mgsxk7chgfz@sigill.intra.peff.net> <CAM0VKjkuoCotm8FB5qdTQsC0SaJiwBA9dXmdLJdSs8NwLdY8fQ@mail.gmail.com>
 <20170413163701.33zjwrgnlfxjfwjo@sigill.intra.peff.net> <CAGZ79kY6TmEV38NkYJwkb5=Bu69tCjx6k+t6An5_52h8rEo5-Q@mail.gmail.com>
 <20170413175701.5ogpe7qbflbkgljm@sigill.intra.peff.net> <CAM0VKjmK0ib+sjf0sMPeiK7DrwHq1dJ58ZhDdp6HZsuQdb-eRw@mail.gmail.com>
 <20170413191236.3usecfgkjujhblo6@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 13 Apr 2017 21:35:08 +0200
Message-ID: <CAM0VKjkVUPPsvpAu1WXeNg7sv1_V=Uxhhevf9fVkZvk9WERwwQ@mail.gmail.com>
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test script
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 9:12 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 13, 2017 at 09:03:26PM +0200, SZEDER G=C3=A1bor wrote:
>
>> > Yeah, I had a similar thought. I can't think of any reason why it woul=
d
>> > trigger a false positive, as long as we account for test-failure and t=
he
>> > --debug flag properly. I don't think we can just drop the "-f" from th=
e
>> > final "rm", because it may be overriding funny permissions left by
>> > tests.
>>
>> FWIW, I used the following rather simple change during stress-testing
>> these patches (barring white-space damage):
>>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 13b569682..d7fa15a69 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -763,7 +763,7 @@ test_done () {
>>
>>                 test -d "$remove_trash" &&

I'm not sure under what circumstances the trash dir could be missing at
this point...

>>                 cd "$(dirname "$remove_trash")" &&
>> -               rm -rf "$(basename "$remove_trash")"
>> +               rm -rf "$(basename "$remove_trash")" || exit 1

... but when it is already removed, then I think we should not exit
with error here.
Nothing that a pair of {} wouldn't handle.

> Oh, right. I thought "-f" would cause it to exit 0 even if some items
> failed to be removed, but that only applies to ENOENT. So I think that
> is probably a good change. I agree it's not a true error, but just a
> sign of something fishy, but I don't think it hurts to have extra lint
> checks.
>
> Replacing it the "exit 1" with a "die" that has a message is probably a
> good idea, though.

If we can't 'cd' or 'rm -rf', then they will tell us why they failed
anyway, most likely including the name of the trash directory.
Do we really need more error messages than that?
