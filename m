Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF41020954
	for <e@80x24.org>; Thu,  7 Dec 2017 22:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750929AbdLGWFz (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 17:05:55 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:46253 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdLGWFz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 17:05:55 -0500
Received: by mail-wm0-f43.google.com with SMTP id r78so377950wme.5
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 14:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GcrhQieH5cKUUmBNnG3m+RugJ9wQ9WRwZ+8UZ1s6CSE=;
        b=eDjJ6CYJDU+pQUpw0lPiFHIpH4ZUqO4Qvz3aspwCmlkcXfg5rEUs0SAHnNRFwyHP1D
         Q84RtwUJDBAIfmo7b72Ty3quNHY3CVjfjoN9+fTyWmGmGW3nbc4s9sUZfa8E6tmGBoAL
         twwNsHCWdBaL3zvUStG1uHBtnEblP/T+pjiZbUHl62AZ5L0gjzACVlp/dW11nuoEE+06
         lMz7gR2mE7jIwJHG36ZNejdag4GxdXPQCPmRErFaXsUWxS3mKXs2Lo+6hfJAZdTMKZ/7
         m7LryC9968TvJ+iUMiiyI32JNg99uAynePK843injTNlYEYBTpdIzb8fbS8wSXqRAKgi
         nnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GcrhQieH5cKUUmBNnG3m+RugJ9wQ9WRwZ+8UZ1s6CSE=;
        b=F/t3jx/TzXmyO02Ut1qXfM5Ved9RIGjbo1uT76p3EYn9K1JF6EQdSZsib0yGVaElYd
         YZWqzGJG5PgwuIaXQuaGh9SEktFkNrXrJHAG/3TJl2v+BmyM06sU5R4sNLDjMI6Jjyz9
         hgBCYm6zqnLklMROv7vTeyaeDCzbMMDyX2e/ShWostIwSnI3gZyGnT9qTUAEzta5i6TW
         BJFRDMNGRC1jPM6IfxXrbdrQJ+JpZn8xOL1wt4fU738ZfCaB5A+BHk9BKJafH9So90Fc
         RUA1J/+kazS8xK5ki2KXm48fEzOBEYYHGWNvQYpyvsTAVMCBPfxNxBnsqPQE4Ni8/nsH
         bPxw==
X-Gm-Message-State: AJaThX6EO9388mVsqI0Hm24dP4QDyuUoV0ZZpJAPmKCCIgQbRnrQJB+4
        PAWzHlTVPDQ/ni68mU1yQ9qVDKYazws9NCMEED81fQ==
X-Google-Smtp-Source: AGs4zMa4i6a9Vd3g4PPAhxEXvtTJStE0LMrkl2O+9uXGq1Cr3odBoWLIt+JAUg4HVErq7RxuN/6OAXRlGqOS8ebKDZ0=
X-Received: by 10.80.137.106 with SMTP id f39mr48780750edf.148.1512684353707;
 Thu, 07 Dec 2017 14:05:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Thu, 7 Dec 2017 14:05:33 -0800 (PST)
In-Reply-To: <xmqqtvx2b41s.fsf@gitster.mtv.corp.google.com>
References: <20171207190135.28660-1-jacob.e.keller@intel.com>
 <20171207211258.GB12850@sigill.intra.peff.net> <xmqqtvx2b41s.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 7 Dec 2017 14:05:33 -0800
Message-ID: <CA+P7+xoBrStdKtLZ+N3gkQTd1f+hX7D=ACdpk+9ou_NU7QxjFw@mail.gmail.com>
Subject: Re: [PATCH] diff: add tests for --relative without optional prefix value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 7, 2017 at 1:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Thu, Dec 07, 2017 at 11:01:35AM -0800, Jacob Keller wrote:
>>
>>> From: Jacob Keller <jacob.keller@gmail.com>
>>>
>>> We already have tests for --relative, but they currently only test when
>>> a prefix has been provided. This fails to test the case where --relative
>>> by itself should use the current directory as the prefix.
>>>
>>> Teach the check_$type functions to take a directory argument to indicate
>>> which subdirectory to run the git commands in. Add a new test which uses
>>> this to test --relative without a prefix value.
>>
>> This looks good to me (and I slightly prefer it over Junio's for the
>> simplicity).
>>
>> I agree on the ordering suggestion Junio made.
>
> I also prefer this one over the other one, provided if it is ported
> on top of the preliminary clean-up I did in the other one.
>
> Thanks.
>

Yea. I can do that if you want.

Thanks,
Jake
