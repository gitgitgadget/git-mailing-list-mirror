Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 565CD1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 14:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeDJOsB (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 10:48:01 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:39689 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753935AbeDJOsA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 10:48:00 -0400
Received: by mail-oi0-f48.google.com with SMTP id q71-v6so11407044oic.6
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hw23BibyCDd57zYc2L9/6N4qEwMvxf6y4eiMoohnqx0=;
        b=Aa3ycnjRt20pTGIc7NrDjAbgILiVGN+G4uyuj7wxSI/qqe9YXnRk6DINa21L7vucW1
         Dk33L1S9+Zk1AzG2KCBVHGneRVoG5USlx7JPxrhe14u0YOvGIxOZ5bSeeV9YH3PiJcJN
         WRpM+ktj3DR0Ka1AFNl8mYdJpenneCL1kV92B3mHcZZClZtJxocu7qLwkJozyHireK7s
         A4YhgCvje7KcXN+h+BcBWq6tOePe4isF6eUo3ltLn5KDvPZAuB62uqbF/7BrINRKB53E
         0aiLFYnavU63pBaMRLMh3m98RTK+gL35MkIFaJnL23wwH0kUEeBQLI676gkPHanYcphv
         hbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hw23BibyCDd57zYc2L9/6N4qEwMvxf6y4eiMoohnqx0=;
        b=lsk9qGtA890qqdOKHu1ztqVf6j7/iTkG6zt+5IsQBw518X2HwHDJCTSLOtCZS+KezY
         ZCuukCPB6kIvgRuK0Ha2x5nJGmAgebyHAobnclsYIlLRTKpf5eDfBHbgbXYPfZt7R9Pt
         gqrgAFV3lqPijuJxXDZ0kmMVNoF4psJHfHZwldLJYfU7t0ncb8ox1vS7aYJFywN04FjG
         1B0QGL3Z0j7Q6UL+HFNPM6+DUpymsn9rNOcyYOvTNcOe+ZEgKa9vHiwBkr0X89lLnKh3
         Qs6C5QNqBh0W63wrgN6k3ucpskiDq/eQBj3kGpS/DmGQpex2EfnMZHixX5uLaVhpMxG0
         gQXw==
X-Gm-Message-State: ALQs6tC1ct0SxgoVQ9JbL3hGz/BYMrPAI63+LDLuq94UWioJG0KZfpHK
        wGxnQFSmAq515qTRxjke2DkbjgwzXGPCtlQT8BIeWA+h
X-Google-Smtp-Source: AIpwx48WfKB+R9/aIuk8h2y4Tw0UCQNLtHePqm+AjAhEllN+ClsSlvNT8XcFF9J9V952Z77Dpd8lpI5ldt7knGmwXMg=
X-Received: by 2002:aca:801:: with SMTP id 1-v6mr510044oii.152.1523371679902;
 Tue, 10 Apr 2018 07:47:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.56.25 with HTTP; Tue, 10 Apr 2018 07:47:39 -0700 (PDT)
In-Reply-To: <xmqqlgdv2y66.fsf@gitster-ct.c.googlers.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com> <20180409204129.43537-7-mastahyeti@gmail.com>
 <xmqqlgdv2y66.fsf@gitster-ct.c.googlers.com>
From:   Ben Toews <mastahyeti@gmail.com>
Date:   Tue, 10 Apr 2018 08:47:39 -0600
Message-ID: <CAE=pOyFj+WZBB6Zp35d=mYNsxcJK-LwOxseWXSmY_hs+Lwugpg@mail.gmail.com>
Subject: Re: [PATCH 6/8] gpg-interface: find the last gpg signature line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 10, 2018 at 3:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ben Toews <mastahyeti@gmail.com> writes:
>
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> index ee093b393d..e3f1e014aa 100755
>> --- a/t/t7004-tag.sh
>> +++ b/t/t7004-tag.sh
>> @@ -1059,6 +1059,17 @@ test_expect_success GPG \
>>       git tag -v blanknonlfile-signed-tag
>>  '
>>
>> +test_expect_success GPG 'signed tag with embedded PGP message' '
>> +     cat >msg <<-\EOF &&
>> +     -----BEGIN PGP MESSAGE-----
>> +
>> +     this is not a real PGP message
>> +     -----END PGP MESSAGE-----
>> +     EOF
>> +     git tag -s -F msg confusing-pgp-message &&
>> +     git tag -v confusing-pgp-message
>> +'
>> +
>>  # messages with commented lines for signed tags:
>>
>>  cat >sigcommentsfile <<EOF
>
> Hmmmm, what vintage of our codebase is this patch based on?  Did I
> miss a patch that removes these lines
>
>
>     printf '      ' >sigblanknonlfile
>     get_tag_header blanknonlfile-signed-tag $commit commit $time >expect
>     echo '-----BEGIN PGP SIGNATURE-----' >>expect
>     test_expect_success GPG \
>             'creating a signed tag with spaces and no newline should succeed' '
>             git tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
>             get_tag_msg blanknonlfile-signed-tag >actual &&
>             test_cmp expect actual &&
>             git tag -v signed-tag
>     '
>
> which appear between the pre- and post- context of the lines you are
> inserting?  They date back to 2007-2009.
>

That test was fixed a week ago:
https://github.com/git/git/commit/a99d903f21d102a5768f19157085a9733aeb68dd



-- 
-Ben Toews
