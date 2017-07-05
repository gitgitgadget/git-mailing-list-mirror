Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37220202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 18:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752399AbdGESxh (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 14:53:37 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36266 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdGESxg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 14:53:36 -0400
Received: by mail-pg0-f50.google.com with SMTP id u62so128462416pgb.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6kuAv6iZRJx5W8y3N/PCGTWaaQ9OHJZjEbuJffK0TYg=;
        b=JLAyapgrgzP4mhilhRm7TNAukxBP0QtgU/2azILZWmEwAHc55HDxq+1qPuPBiZ0kFM
         S0xvZVS4D7ON4tqv5yXgU8BW1u4RdvdIktAk78Cfm8mleZxWUrFa3yoBDVuwfxkYrVqw
         8T3vm3nX+k44yxowx9ZXcwD98CktgpJMCfpRQ+6bOy2u7/T9RYbhAWMSt21IVsc6tDLF
         PIb5LDtuDXuqcdZ3fDuhgRPkHkRx8uy4dH8L+bctdMErgSLlM7mOxMS3EOHtt0B+tMgp
         CfEWEG/DEWfCNqzaZ955neChYbnKZkM/GrQm5RaJEWnKtt/y0bqxboGIOrHzF7OdZLIr
         2hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6kuAv6iZRJx5W8y3N/PCGTWaaQ9OHJZjEbuJffK0TYg=;
        b=V3dFkJrc/3sW+/hNucdQk6W/2SvMFNhdMnflwe/gxJ9S0sbf6RXcq53yTICMrGaqaB
         Zs3L/83Eo6FS/xt0Vboqj2BkXKInjlqEAjzt6VCeuPpJ9CmZzpgxlQ2IS75D1Y9sJL7/
         vygx3V56uxK3cjtFexj3QNL2+h6uNXrOj2j1CbFgKhf+I0V0+QgKrNtYIFrn1dGaHq/i
         /robBB9Ab1BOzpYB3fRXUItrWpukWNPYy3R+9ZLjgEzI0/dtnjBTN1NeIqMEjAvIOCug
         HavpvJmk39jkQBDIxW5V4rPW3x1yDib4+9aAUXQ9vIC7C0MrsROIRxBv96wqr98jHajo
         to7A==
X-Gm-Message-State: AIVw110iu1pLPtLcV/ocl4kGY+dKFYx+jOmZeWeLaQyFeKC5ePG6fmo5
        2Z6cmRl6ZJLJmI+VntS4vL194FA42cGs
X-Received: by 10.84.224.74 with SMTP id a10mr23503591plt.210.1499280801204;
 Wed, 05 Jul 2017 11:53:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Wed, 5 Jul 2017 11:53:20 -0700 (PDT)
In-Reply-To: <xmqqk23snjpm.fsf@gitster.mtv.corp.google.com>
References: <70c9a162-ac2f-c347-d13b-f24ac24d1133@web.de> <20170630162826.27711-1-sbeller@google.com>
 <xmqqk23snjpm.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 5 Jul 2017 11:53:20 -0700
Message-ID: <CAGZ79kZedckynRcBTGVOAJO_iNrrBR0eAo3XvBaW+LUbOJXQXA@mail.gmail.com>
Subject: Re: [PATCH] status: suppress additional warning output in plumbing modes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?0KHQtdGA0LPQtdC5INCo0LXRgdGC0LDQutC+0LI=?= 
        <s_shestakov@playrix.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 1, 2017 at 10:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When status is called with '--porcelain' (as implied by '-z'), we promis=
e
>> to output only messages as described in the man page.
>>
>> Suppress CRLF warnings.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Maybe something like this?
>
> This looks to me like a stimulus having enough time to go to the
> spinal cord to induce a knee-jerk reaction, without giving a chance
> to the brain to think things through.
>

sort of.

> Surely the reported symptom may have only been about CRLF, but who
> says that would be the only kind of warning that would be seen
> during "status --porcelain" codepath?

I was slightly worried about this, too.

>
> I tend to agree with =C3=86var's "output for the script can be read from
> our standard output" should probably be our first response.
>
> The patch _is_ a good start to document that we may want to do
> something differently under _PORCELAIN output modes and one location
> in the code that may be a good place to make that decision, but if
> we are to squelch the warnings, we should make sure we do not give
> any warning, not limited to squelching the safe-crlf warning, to the
> standard error, but still diagnose errors and show error messages,
> or something like that, I would think.

So for now we'd rather want to go with a documentation patch first
and then the refinement of the porcelain mode of potentially
suppressing more warnings?

Note that this patch was a one-off by me, so I no longer pursue
fixing the problem here, someone else is kindly asked to step up.

Thanks,
Stefan
