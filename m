Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D1B820A36
	for <e@80x24.org>; Tue,  7 Nov 2017 20:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755471AbdKGUcN (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 15:32:13 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:53491 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbdKGUcM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 15:32:12 -0500
Received: by mail-yw0-f169.google.com with SMTP id q126so445507ywq.10
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 12:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Wvl5uKIa/JQrcMLW/Thv4ob/LnsbyHV0WYfE4GP5dLc=;
        b=ShYDCd/BDIHfXBquDyAugVt50opZGG/9Fysp86HkAU00jClEwf8EwSnAvy09H1nV7E
         tTdsOlMMy5CaqZTugtSzS+dpTdWhNOagjrPwhf3OEku6qOhFXQHvncAqzjL6AM5ZfWQS
         hrTjr2T94UhhO/quN+cpfcKhj48elQQuxSF98DraTKwTPMaGpdRY5wREacwgqbamNA6M
         EZGXzuY9RHp2bgMcAi0TszUcLUxfFfLgUqjl6YrcX6l8TXlPSWVWrJbSNliqdCJkArbS
         SkDXb6H3RHh6an0bvrYd3YKjK8tvjIcRxSZQWNySLpKAmhxEpiQ1GdoxOHHEyClaEol6
         Q81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Wvl5uKIa/JQrcMLW/Thv4ob/LnsbyHV0WYfE4GP5dLc=;
        b=OKGIZojiwqMa0MrV17EW/IqXzAcBjjMDcIFpn225c0SbbuBbjcqTzHolQMoWKZa9ys
         yiNsi5oPLg/keaWispy++u7V/SNou7+IubZw9vs5aB53wMhSrvZ2kkEq/EGevJNwCEvU
         Y/u5xfuRggiosSsKdecihLwJyqXv/C9OLeH2eJPtFuAzYAGLgv491u31r6ncWxiUlgQN
         G5OvCQ/UfklRuayElzNK2Nc35nuxoQyJ9usXhzHnMgDjXbRt5cGxckKy+Nmn4C7/LDNe
         kkU+Ky8ZXGAEHGy50lBMHPMIOReeL0EbdEcrztAEBJKtYJ5Tgl8qPoWYGXLACCvIV+dE
         vVMw==
X-Gm-Message-State: AJaThX6WkmpqyrFnIui85MvWS3p0qu7UOW4bqjcsAz4f9C+o1cTttUlh
        7M4Fm8f7hucmWRnbn2X8xutlsfB4uUto38qvvFU=
X-Google-Smtp-Source: ABhQp+T1HtoCb0xSx4CfPFeTqeqR4VgNY5m2Qub08S2/j8OLYnTTu0WBaGKLzp0cGMsPsGVJKAkd7SdaM4Qpkrif7us=
X-Received: by 10.37.117.4 with SMTP id q4mr1724638ybc.487.1510086732014; Tue,
 07 Nov 2017 12:32:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.65.194 with HTTP; Tue, 7 Nov 2017 12:31:51 -0800 (PST)
In-Reply-To: <CAGZ79kbWEe=TyqPFSc+D8HCRh3cOkGbkqFKZbpkdisjvkfiaFg@mail.gmail.com>
References: <CAFA_24+svnt4uSpx1tjj2t6iAt4G3p9UvrxahEYj=VZWeJxC=A@mail.gmail.com>
 <CAGZ79kYbeVcpEXsei8Lr=Zw+YgJE_E4mBSRWYcYDqOWz20z5oA@mail.gmail.com>
 <CAFA_24Jov7FDw7AxUtFDV6avOj40LD6ptEVMPpVuSdAo_6L_1A@mail.gmail.com>
 <CAFA_24K99LkeJBKV7+a-m-m9PUZik49cOd40+cEn-6zCvGmMsQ@mail.gmail.com>
 <CAGZ79kZHapHLXDM-iU9T_BU5qoYAAAS+yKWLVvfUhxMmp+6mxg@mail.gmail.com>
 <CAFA_24JXc=qJw1-_aJJUMPhW9DaBofxSb6hkVD6n4MWyeT5UOQ@mail.gmail.com> <CAGZ79kbWEe=TyqPFSc+D8HCRh3cOkGbkqFKZbpkdisjvkfiaFg@mail.gmail.com>
From:   Max Rothman <max.r.rothman@gmail.com>
Date:   Tue, 7 Nov 2017 15:31:51 -0500
X-Google-Sender-Auth: NWM36xVPJTLNQMw2d_fP8ZL4YGk
Message-ID: <CAFA_24L5nTUhO=PbMB9SdnCB1Lj+5rmOHmMJwkuLGWgy-ooxBA@mail.gmail.com>
Subject: Re: No log --no-decorate completion?
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback!

>> * Add bash completion for the missing --no-* options on git log
>> * Add bash completion for --textconv and --indent-heuristic families to
>>   git diff and all commands that use diff's options
>> * Add bash completion for --no-abbrev-commit, --expand-tabs, and
>>   --no-expand-tabs to git show
>
> This describes what happens in this patch, but not why, which helps
> future readers of commit message more than the "what".

How about:

> Teach git-log tab completion about the --no-* options for ease of use
> at the command line.
>
> Similarly, teach git-show tab completion about the --no-abbrev-commit,
> --expand-tabs, and --no-expand-tabs options.
>
> Also, teach git-diff (and all commands that use its options) tab
> completion about the --textconv and --indent-heuristic families of
> options. --indent-heuristic is no longer experimental, so there's no
> reason it should be left out of tab completion any more, and textconv
> seems to have simply been missed.


> At the end of a commit message, the Git project requires a sign off.
> (See section (5) in Documentation/SubmittingPatches;
> tl;dr: add Signed-off-by: NAME <EMAIL> if you can agree to
> https://developercertificate.org/)

So the sign-off should include my name and email? I thought it was
supposed to be the person who approved the patch, but I must've gotten
confused.

> The patch looks good, but doesn't apply because the email contains
> white spaces instead of tabs. Maybe try https://submitgit.herokuapp.com/
> (or fix/change your email client to send a patch; the gmail web interface
> doesn't work. I personally got 'git send-email' up and running;
> The Documentation/SubmittingPatches has a section on email clients, too)

Yeah, I was using the gmail interface. I'll give the heroku app a go.
It has an option for sending a message in reply to another, and I
assume I should send it in reply to this thread. Do you know how to
tell what the appropriate ID to use is? Looking through the raw email,
I see several, so it's not obvious to me which to use.

Thanks,
Max
