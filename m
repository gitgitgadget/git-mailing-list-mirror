Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646A71F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 17:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbdAZR5X (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 12:57:23 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:38335 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753855AbdAZR5W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 12:57:22 -0500
Received: by mail-it0-f42.google.com with SMTP id c7so38877216itd.1
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 09:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LqqO2J1XJrzmul0GU6wRqeJV1JUdXSGbxpaNFxrhlNo=;
        b=d7iVkjKvx1ScSgPk2rlzihCVGZ+M+G1piCBmtwGg3hTb9uIh8xppX5xBfwpxfz6tdB
         BBduFENGEeF85/WvZuKZb9gbvVILccBoDgZhPYIBj4kBXZs/e94lsqIkDIV90RDbUSXx
         mKgKuE0/qRUQ3uHPdCzeBYgxyMbtyBPOXyN16NYcQlGy6tSFCAfiE8s2YNN25y9KAEHt
         1G/S8+8EaZizk8S3EQBa68H3EBjWX0pC8iROtyJPwfFe6tPq8a/BhTnIfLwYD/3UfdeM
         C85uuGPz6fWI5TAVxk+9abGZun38sQZ/ivGazD+TWU/UkN2ZBgaebGScy/hV/BNK/n3V
         mGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LqqO2J1XJrzmul0GU6wRqeJV1JUdXSGbxpaNFxrhlNo=;
        b=Y+AXLbVj57+Bx4zjBP0/idLLmxnOoEwMbceuw1nF/NTWGXTealBK/1t5YEq3G6HGyO
         8m9uBDfx1+0g6LlqzPiulxrD2ARm2Oj9gNRhw5Im2myX/VzcDg6l9Lax73V06zlx6htb
         udBcSLMwBX2DbIUzbC6nJm4Bwfa49y08lsWID+4ny8EafI2dwsvQP3j1REq9t42AQejO
         JjCE3piqC9tiABhY8mN95cQ2uPmneasTC5a5ND3xq/C6CC0mt0ANWq6uoh7bmP1XDP04
         VRJrgOyn8gEklzSXahvOgpjHk03zCHmhEtmYPz9R0fdln0bMUUMRvFIWHVeJugj7M/DS
         DCpA==
X-Gm-Message-State: AIkVDXKLG5+ivs9a1AGvjMOD1nGLMPYSjKWhDnnyBiXKEN+fYR7y0Hi4DX6Xwzyh+R079nQxYsywFZIYXdjxeRg8
X-Received: by 10.36.65.4 with SMTP id x4mr30224319ita.69.1485453441505; Thu,
 26 Jan 2017 09:57:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 26 Jan 2017 09:57:21 -0800 (PST)
In-Reply-To: <baff65ba-1e98-d5a7-5b5a-a50a7fc723ee@tngtech.com>
References: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com>
 <20170125002116.22111-1-sbeller@google.com> <33E354BCDB9A4192B69B9B399381659E@PhilipOakley>
 <CAGZ79kaRdtKD7DNJRWXsyg07GbTM4OsKUmHHcFczEMJA1YK2KA@mail.gmail.com> <baff65ba-1e98-d5a7-5b5a-a50a7fc723ee@tngtech.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 26 Jan 2017 09:57:21 -0800
Message-ID: <CAGZ79kYChm3Y4T=Jk0-6cA3gEDpFDCHgXsP60pQ0afBDePWRXA@mail.gmail.com>
Subject: Re: SubmittingPatches: drop temporal reference for PGP signing
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     Philip Oakley <philipoakley@iee.org>, Johannes Sixt <j6t@kdbg.org>,
        bitte.keine.werbung.einwerfen@googlemail.com,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        thomas.braun@virtuell-zuhause.de, John Keeping <john@keeping.me.uk>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 5:30 AM, Cornelius Weig
<cornelius.weig@tngtech.com> wrote:
>
>>
>> Yeah I agree. My patch was not the best shot by far.
>>
>
> How about something along these lines? Does the forward reference
> break the main line of thought too severly?
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 08352de..c2b0cbe 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -216,12 +216,12 @@ that it will be postponed.
>  Exception:  If your mailer is mangling patches then someone may ask
>  you to re-send them using MIME, that is OK.
>
> -Do not PGP sign your patch, at least for now.  Most likely, your
> -maintainer or other people on the list would not have your PGP
> -key and would not bother obtaining it anyway.  Your patch is not
> -judged by who you are; a good patch from an unknown origin has a
> -far better chance of being accepted than a patch from a known,
> -respected origin that is done poorly or does incorrect things.
> +Do not PGP sign your patch, but do sign-off your work as explained in (5).
> +Most likely, your maintainer or other people on the list would not have your
> +PGP key and would not bother obtaining it anyway. Your patch is not judged by
> +who you are; a good patch from an unknown origin has a far better chance of
> +being accepted than a patch from a known, respected origin that is done poorly
> +or does incorrect things.
>
>  If you really really really really want to do a PGP signed
>  patch, format it as "multipart/signed", not a text/plain message
> @@ -246,7 +246,7 @@ patch.
>       *2* The mailing list: git@vger.kernel.org
>
>
> -(5) Sign your work
> +(5) Certify your work by signing off
>
>  To improve tracking of who did what, we've borrowed the
>  "sign-off" procedure from the Linux kernel project on patches

I like it.

Thanks,
Stefan
