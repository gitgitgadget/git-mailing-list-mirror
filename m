Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2E81F404
	for <e@80x24.org>; Thu, 15 Feb 2018 16:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426178AbeBOQjb (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 11:39:31 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:39970 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423532AbeBOQj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 11:39:29 -0500
Received: by mail-vk0-f44.google.com with SMTP id o17so176423vke.7
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 08:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5GMdvbaMdmvbJ/5RrTkv9nmtWVIj0yIsEJIkvX0S/nA=;
        b=YVErvZuSfc8/9DTh4Pr5vPFT5L2MA8KcaMfk7za7ngt99XccHNl5QU3IjoaKnug14p
         PRN/cThSw0BKBroVY9UwuzDgOIVyom+1+CHETywdk7u0/yYvGnYEz9mYW+8L9eySdwZ/
         JfdtODX8qOYzSrmq6fw7/csxIFE/exRe3oECNsg8e4d3sWetvM5sDNA4JZZuD2+9MOBC
         xDvKWL2z5WICj0NHHOj9kS/+PA0qOFBRe/dfHTKYMjhf7CuzECM7x3UtMMey1Bb16P5A
         UkVHVAOxG9jiHPk7wt0vQrmmDKlxhL++u1FfAftDzFP/b+z1ITQwUI6m+Emlc0WcgTgS
         hr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5GMdvbaMdmvbJ/5RrTkv9nmtWVIj0yIsEJIkvX0S/nA=;
        b=nGz3J8b8VMb0eUQY+eLPx444Qq/FbUQ3wd8RC9y1cNVgqv6laKYQSm+OMSX+oaQJp1
         FsRRzgKjpznqxR2pha0/2h1d+NH1maqYC0W1Wf8qIASYmgg3kB25ipVoCO6pTpW2Bw8M
         9o8Qo4OHsVx8q1Epd5IPFSYuxpoJ6MGcVVm7tHO/tjLE44EYGQLak9yAQ9jFXEoJP5HF
         lOE/u/meESi/HqPkdu4YxMjrAzBHcx40eGgFIao7sF9UOxxE3TTYlw1ewNqLhNjXMsim
         591Icx+4ihkoBZUJgMrAbR1yJHyfTEzJAYmUMdnJke/pOO4slzbuLEBS8SlTIvnMvzQA
         slRg==
X-Gm-Message-State: APf1xPCxuz2VdDqcIBYoJHJ9wf2U1GsiBANOogWk4nY3zxLZqS2N2dHN
        x+RdcT5TGRrn6YlSFCSLiSUxGDcTM3do/jMW/uE=
X-Google-Smtp-Source: AH8x227ccIGoIkxXRpq3nVC3UwjxUxFKhLTd7mafhEoBBJ5Hlr8AHLUkTsQt3XfnOsGPQmB5xb1wcJ33QEVHn6+oeyI=
X-Received: by 10.31.189.12 with SMTP id n12mr2517976vkf.3.1518712768483; Thu,
 15 Feb 2018 08:39:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Thu, 15 Feb 2018 08:39:28 -0800 (PST)
In-Reply-To: <20180213222247.GA18401@sigill.intra.peff.net>
References: <20180213003601.7396-1-szeder.dev@gmail.com> <20180213222247.GA18401@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 15 Feb 2018 17:39:28 +0100
Message-ID: <CAM0VKj=YPkS=YLtEz93RWS2=cvyy6LcyrBsCyBCg14ihxuKzjA@mail.gmail.com>
Subject: Re: [PATCH] t6300-for-each-ref: fix "more than one quoting style" tests
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 11:22 PM, Jeff King <peff@peff.net> wrote:

>>  for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
>>       test_expect_success "more than one quoting style: $i" "
>> -             git for-each-ref $i 2>&1 | (read line &&
>> -             case \$line in
>> -             \"error: more than one quoting style\"*) : happy;;
>> -             *) false
>> -             esac)
>> +             test_must_fail git for-each-ref $i 2>err &&
>> +             grep '^error: more than one quoting style' err
>
> I suspect in the long run this ought to be test_i18ngrep, but since it's
> not localized yet, it makes sense to stop here with this patch.

I thought 'git for-each-ref' is plumbing and that means that it
shouldn't be localized.
