Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1E81F437
	for <e@80x24.org>; Tue, 24 Jan 2017 23:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750943AbdAXXnX (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 18:43:23 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:35951 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbdAXXnW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 18:43:22 -0500
Received: by mail-it0-f51.google.com with SMTP id c7so97453426itd.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 15:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aZ3rfeUxQTe2nae/uoxjoL76CBDq6uZ7jaNHB6d0D+s=;
        b=bAJVagAzyCHcf7hSN3nJw8X9OJ4mfz9Wn0yPfE2FOuSW2YnJRPfyl+9ISih6AmR0VB
         zSFWLAby06INpgnHL71LHmccU0MrEiz6zRtRZQV2frjHRuSCnstBt7qDyAw1k4tLDioC
         Y3InAaWrzK5KyIEzR9YL9EWnlkYdy2qQkdABuIu9L2mEqUcG3bmgtQm02U6wBAdcHnuP
         ic1UwNZoHTMScZ/C+xsbbSy3ee74HXmL6wZ5JnfHr9sdokjPom/PEFUya3qyBchMrxup
         Yb7tbIb4BOQhPLBLPyWoKcLwlUGk3ltW7u6b1nBpDDfiZzy1YXJjco4vLCbLBtJloNRa
         5FIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aZ3rfeUxQTe2nae/uoxjoL76CBDq6uZ7jaNHB6d0D+s=;
        b=TZIoR/UlvpIXOesWwDMS9/Do/tVmf9+qjC+G+bpLfvV4VfzoMJBKAUzqgNGTQzVOrt
         821bBedFy1rfqMYB5M0O2rAxc62bbc6rIIO9OaGfBum4zh6LgBcdToG2eiS2UxBlnING
         uSFAykz4I7E14f/q1D1S5odF6NHThWTLMJFKvxL1P/CXK1zPHXZ133exAwTisB1auCFN
         dxgcCQbWmJGRB9MCU/pIKBk524LitqhcFn2VdHVRYHubZlw91HVzDNo0OSnPVCl//cES
         jltip3hmoCHWIWvBLOVg84Q0aN5b8bkKsqp+u8AzcJyCFEth2QPJb7G+qbdlnNSJWibU
         XtjQ==
X-Gm-Message-State: AIkVDXJhD+qzHS2skhWt5sBjwVnYRs/gr8glk8CW33i4uQgjR8Te8sSa8423tcJF2Oyat8hytuj9RUOW5y5Qimtv
X-Received: by 10.36.169.12 with SMTP id r12mr22783821ite.69.1485301401770;
 Tue, 24 Jan 2017 15:43:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 24 Jan 2017 15:43:21 -0800 (PST)
In-Reply-To: <a921bc92-4f20-3284-6577-344470a60c6f@tngtech.com>
References: <20170122225724.19360-1-cornelius.weig@tngtech.com>
 <20170122225724.19360-8-cornelius.weig@tngtech.com> <74ecd09c-55da-3858-5187-52c286a6bf62@kdbg.org>
 <967937ff-e5ff-2515-2f50-80a96683c068@tngtech.com> <xmqqd1fcca8n.fsf@gitster.mtv.corp.google.com>
 <a921bc92-4f20-3284-6577-344470a60c6f@tngtech.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Jan 2017 15:43:21 -0800
Message-ID: <CAGZ79ka0PSb9L71tkiacZS+FH=YbUBrQr6a5UQu7ochpihRqEQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] completion: recognize more long-options
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        bitte.keine.werbung.einwerfen@googlemail.com,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        thomas.braun@virtuell-zuhause.de, John Keeping <john@keeping.me.uk>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 3:33 PM, Cornelius Weig
<cornelius.weig@tngtech.com> wrote:
> On 01/25/2017 12:24 AM, Junio C Hamano wrote:
>> Cornelius Weig <cornelius.weig@tngtech.com> writes:
>>
>>>> Please study item (5) "Sign your work" in
>>>> Documentation/SubmittingPatches and sign off your work.
>>>
>>> I followed the recommendations to submitting work, and in the first
>>> round signing is discouraged.
>>
>> Just this point.  You found a bug in our documentation if that is
>> the case; it should not be giving that impression to you.
>>
>
> Well, I am referring to par. (4) of Documentation/SubmittingPatches
> (emphasis mine):
>
> <<<<<<<<<<<<<<
> *Do not PGP sign your patch, at least for now*.  Most likely, your
> maintainer or other people on the list would not have your PGP
> key and would not bother obtaining it anyway.  Your patch is not
> judged by who you are; a good patch from an unknown origin has a
> far better chance of being accepted than a patch from a known,
> respected origin that is done poorly or does incorrect things.
>>>>>>>>>>>>>>>
>
> If first submissions should be signed as well, then I find this quite
> misleading.
>

Please read on; While this part addresses PGP signing,
which is discouraged at any round,
later on we talk about another type of signing.
(not cryptographic strong signing, but signing the intent;)
the DCO in the commit message.

So no PGP signing (in any round of the patch).

But DCO signed (in anything that you deem useful for the
project and that you are allowed to contribute)
