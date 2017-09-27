Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308AB2047F
	for <e@80x24.org>; Wed, 27 Sep 2017 22:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbdI0We0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 18:34:26 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:51349 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbdI0WeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 18:34:25 -0400
Received: by mail-qt0-f176.google.com with SMTP id q4so15288485qtq.8
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 15:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5Dbu90xqPQaILnJ/et74/zfDG6CE3IqOvhVbnG7JXCY=;
        b=oNB16nIdswHazzOG2MWySsdU9zgTQecBZeAPYNMH5gRvZ2f5Nb3zOyC1dA5HcJDirC
         0kJJBsprbL6J5BFTkqSPu6FTNzrVZATum9U2iTnkbyOrHWt8Jhwve+hVixHzZX63XP1i
         FvNOTgGMgnLiVacT8r8CaZwmqAervcte1dTxHrV7Kj3orztUuMSSFfVG3GQidVaIefyu
         zGX+tC4ptLs4v4ZVBeYyPxdD5ufjFdEnfdGXE9cDR+JNII298Qm+CXryVGbz++jgW+CO
         rnutjbP3djJtiLPKdUtbhzWoIeKwQE1FkByHQ22MQo/iBOdsIb4rWdEAk8NCoprpAxFU
         rirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5Dbu90xqPQaILnJ/et74/zfDG6CE3IqOvhVbnG7JXCY=;
        b=a6Y1mObrcvc7srU/YKRIRfvgiwY3wWBg/zfa9y63ukLu4UTggmNp/KPdxYtpztwV0t
         yMCLx9XZquFBPkhXDRSM3pOMK0g1OquOcEb689hmAHDh5TyaZiEFjd2YOO/0yGUZgBsl
         SR0OIGnuRE6ALofuXxLEVEf2p1PRraLfnW7vmFiGr1K8vYdWJZ7PoM7LQkpE9V/xeWg1
         D3fmo14Aad8ltznwpFKkmcCd3YEo5mmmVV8jE8ykkRHu3xbMJZqjvDjWHa/u3YIDRYU7
         QJy+BCgXXNrmkaT5b2yc9WrI/qME8M1JEuamwNU/TyO4k5MdS/q2sJzsjjMIXW8P2j9a
         tDNQ==
X-Gm-Message-State: AHPjjUiQ7GO3MDCL8mlCcr1jZDm6JuY5fN6GndoIg4Z3CSwm5X94Uqyl
        l/ui0TAOLXUg2l6dqy4H7rgzqjd+I5CZQ8nbf0RQVA==
X-Google-Smtp-Source: AOwi7QBfQ0Lv0rv5P3mddJNRregx41g3S31PJykFu4Kq4+Pssdxt1bBmU2apmS+638SGaXoKHV+stVVSBN/m8LcvkeA=
X-Received: by 10.200.48.49 with SMTP id f46mr4430254qte.260.1506551664662;
 Wed, 27 Sep 2017 15:34:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Wed, 27 Sep 2017 15:34:24 -0700 (PDT)
In-Reply-To: <20170927220925.u622metv2fcdtcfq@sigill.intra.peff.net>
References: <CAGZ79kbCgTNaunfneWHP3xkLeXwW72CZZWs7Sv8A7QL_UYE_HQ@mail.gmail.com>
 <20170927215852.20163-1-sbeller@google.com> <20170927220925.u622metv2fcdtcfq@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 27 Sep 2017 15:34:24 -0700
Message-ID: <CAGZ79kbqLqPBbzH_c6=YhjSNr+4QAAf=JD7QUNY=aJQ355w8Cw@mail.gmail.com>
Subject: Re: [PATCH] diff: correct newline in summary for renamed files
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 3:09 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 27, 2017 at 02:58:52PM -0700, Stefan Beller wrote:
>
>> From: Linus Torvalds <torvalds@linux-foundation.org>
>>
>> In 146fdb0dfe (diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY,
>> 2017-06-29), the conversion from direct printing to the symbol emission
>> dropped the new line character for renamed, copied and rewritten files.
>>
>> Add the emission of a newline, add a test for this case.
>>
>> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> The overall substance looks good, but...
>
>> diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
>> index 9c48e5c2c9..514056dd10 100755
>> --- a/t/t4016-diff-quote.sh
>> +++ b/t/t4016-diff-quote.sh
>> @@ -30,6 +30,7 @@ test_expect_success setup '
>>       git add . &&
>>       git commit -m initial &&
>>       git mv "$P0.0" "R$P0.0" &&
>> +     chmod a+x "R$P0.0" &&
>>       git mv "$P0.1" "R$P1.0" &&
>>       git mv "$P0.2" "R$P2.0" &&
>>       git mv "$P0.3" "R$P3.0" &&
>
> Won't this chmod be a problem for platforms without an executable bit?
> I think you'd need to use "update-index --chmod=+x" here, or require the
> FILEMODE prereq.

I was experimenting with git add --chmod=+x for this patch, but as this
test runs "diff --summary -M HEAD", we need it change don the fs.

So let's find another test. Changing the setup of t4013 is a lot of work,
but maybe worth it? Looking into t4031, that would also work.

To be fs agnostic, we can only compare commits against each other.

> The whole script is marked as !MINGW, so that makes it less of a
> problem, but it's still possible have !FILEMODE on a Linux system, if
> you're on a funny filesystem. That also seems like a good reason to make
> sure this is in a script which is run more widely, since Windows folks
> would want to run this test, too.
>
> -Peff
