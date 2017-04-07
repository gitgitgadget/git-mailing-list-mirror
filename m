Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A0DD20966
	for <e@80x24.org>; Fri,  7 Apr 2017 11:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933029AbdDGLyU (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 07:54:20 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34290 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932601AbdDGLyS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 07:54:18 -0400
Received: by mail-oi0-f49.google.com with SMTP id g204so9571583oib.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 04:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jQ5SA26Cpyk49uB5AfbnE809UfLfLOtSUTdQ1hzm1lk=;
        b=vQLW6NxOj7S310i3oxE1cpmhFlelvDnk374xFZbDqOF8jg+pz5SAVEqS2O/ZtBmZk+
         eqdjwf8odDua8hVUjziRKxXAhCICmUQdV48C2nlVJ2oC/XvM45a6PCTUtkYt2BdZpRXD
         Rr05msumqDzKEI/qH4T3n7ZQjeL4rRGvVuef+WT7l1ofvoNNNFCokEO0yvMN6hCN2vg1
         1fn+ELQ5PDS1JLUgdx0bbCSMRUbPiCRnj+7FH0QVAg+/Wdx2uPkgR1tMEOm7YMpTBOQa
         26yVbZpwY24a9UED/4gPF9f4dE+m3dQMju2p4hP9eB0SmeA+4oPROb9Opk909ilNsa4X
         YxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jQ5SA26Cpyk49uB5AfbnE809UfLfLOtSUTdQ1hzm1lk=;
        b=YkiGilTAw+8t63RVBTxsp/YBWcLRmI3dVnA2n0iCkYHmuBB6xHEuymzOV4TUcUlkTK
         Cw80xUoM8yzxC8HdMz3R5O04mKLpTAJOVHHZddfXZN1i9Fhm8OHiLgp0ogRgY8J48ONu
         czLyJKyxujgSBwqo1B1K+DiX9Y5b4OB23ACeYvCH9DRyaw5MfYUTs28wKAlkHIw7I8Uw
         7CexBZbxdYtJr5/EjgOoO6IQq76TlGMYBtzNJi6kII9MCGycOojOEVvbDpj95bf+QGaJ
         EljX9wLlWUoTazOs8CwcdlpgRop40VTILxvAe9DW8j9FJRnGDm5eAsT/gjEvlgNiMjnC
         uwaA==
X-Gm-Message-State: AN3rC/5fZ0T4Qcd7zbrdVDkxVjL2GiOoZEHxPTk6fCcV/HKeJ/+UCdjcYmsDsnSKYmkF1riDiQ79+AWrF3awyQ==
X-Received: by 10.202.205.81 with SMTP id d78mr3272873oig.65.1491566058077;
 Fri, 07 Apr 2017 04:54:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Fri, 7 Apr 2017 04:53:47 -0700 (PDT)
In-Reply-To: <CACsJy8BErEEmbq884XOvg=pQbcVhCkdmsaux58sMaNW_B0nSZg@mail.gmail.com>
References: <cover.1490966385.git.mhagger@alum.mit.edu> <xmqq1std1lmb.fsf@gitster.mtv.corp.google.com>
 <13eaacf0-5923-ad33-79ed-2cec47660904@alum.mit.edu> <CACsJy8BErEEmbq884XOvg=pQbcVhCkdmsaux58sMaNW_B0nSZg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 7 Apr 2017 18:53:47 +0700
Message-ID: <CACsJy8ArrVRjmBoXtxKVtftNaSoSX_nXkuExsXwaBFkayv9kQg@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] Separate `ref_cache` into a separate module
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2017 at 9:03 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Apr 1, 2017 at 12:16 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Duy, have you looked over my patch series? Since you've been working in
>> the area, your feedback would be very welcome, if you have the time for it.
>
> You probably have guessed my answer based on my lack of response :)
> Tomorrow is holiday though, will have a look. But I doubt I would find
> anything given that both you and Jeff are involved in this.

Overall, very nice. I made a comment here and there, but they're more
questions for my education than actual code review ) At least there's
another set of eyes on this series now.
-- 
Duy
