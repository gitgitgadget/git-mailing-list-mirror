Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736AE2055E
	for <e@80x24.org>; Wed,  1 Nov 2017 17:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbdKARLO (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 13:11:14 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:54019 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbdKARLN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 13:11:13 -0400
Received: by mail-qt0-f181.google.com with SMTP id n61so3497384qte.10
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 10:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G9Yl3ISNlLrZka1RYwrOgWZwes5ccN2uMSgSpQpmDGY=;
        b=cElDxAr8+kG6JK37heCVrJLdTy4T7c/faFjvMOVn/sj/PGyZTZ9CT/0WhpwlWMLcIZ
         Y8ocawx/RFpFMv5WOD50yPYkzpLiylZAdWeA0cCkqPBR/4LpXbWP2jC2bVhNhvrU+l67
         rLD3f67xGOo/QK1MOutqe9t8CEdrx6P4c9+XyCbgdIbleEEcOIYueI+lQOQJrCnfctRx
         UNoucEBfgOy8NSw7QNMXYGCu+wcpO3U5TEQQL+LWBvsq7vEkhL098K3tF/aDDeQy3oPv
         +hBCqtVMIxYot6pM+pEKUxQTarNzHYANviEC9VgwcdLrR+rKliglvUSwm6C+ZX3heL30
         81Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G9Yl3ISNlLrZka1RYwrOgWZwes5ccN2uMSgSpQpmDGY=;
        b=UVsIUpjPXeevudcqjzKHI0jR/5exODoiewbKEDhf+6kCKg05WWheAerKwE5TfzRfxs
         AzBR1+J5Ev+wJmDoc7MvwRB0og4p+fQZ7vNPNToz/PZI7tUT8JVwfwTzc8Ha84AXSLkK
         NppgxLRvyfKqFWlUN+aJxVCXWipVSBOY/bLxf0JT4hZFUGmUVOgHN1/30iO/5r8xf/Yi
         G7Bw4fkCFyfaYCBpd1geQ1iVpNaCkrg6hA8YJstxlOPia632FaZoqPKbh11kDD3rP6d+
         C1s4ZlQl2uHitabTqAnOe1olMU4voOiIWyRALuhP6C2j68IaclAga0WBQL7H8F7mH5N/
         gd0A==
X-Gm-Message-State: AMCzsaUcnsBLdPqW1SVK4VR/M/GS0HvS2P23sjPveLif3EC9Lo+mJtYA
        8qvPpmT6A8niSEEnoQs9nuNjOE+kbp4/uFyo3Sp4Lg==
X-Google-Smtp-Source: ABhQp+Q3hMb+k/r3ThyfC5ToeygxsApIY7YUYKXcAmBm4T5QwtADh4BexY59+Xt9KuBngvF4anzCdPJk46P3uauCH+4=
X-Received: by 10.200.8.53 with SMTP id u50mr934245qth.260.1509556272695; Wed,
 01 Nov 2017 10:11:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 10:11:12 -0700 (PDT)
In-Reply-To: <xmqq8tfqyejq.fsf@gitster.mtv.corp.google.com>
References: <20171030194646.27473-1-bmwill@google.com> <20171031181911.42687-1-bmwill@google.com>
 <20171031181911.42687-3-bmwill@google.com> <CAGZ79kajX=FmGacDSv_dDzppE6WBHGqgyCpaG1zDyENcsDbwZg@mail.gmail.com>
 <xmqq8tfqyejq.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 10:11:12 -0700
Message-ID: <CAGZ79ka+WK2rtR0_LtWPWM7k-_Bs0aJLvVJ9CJx-u6eenp4FwA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] diff: convert flags to be stored in bitfields
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 6:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> After some quick research our coding style on bit fields is twofold:
>> Most older code is this way and more recent code seems to prefer
>>
>>     unsigned <FLAGNAME> SP : SP ;
>
> Yes, we are very inconsistent.  What does the clang format rules
> Brandon came up with have to say on this?  FWIW, checkpatch.pl is
> unhappy without spaces on both side.

clang-format --style file diff.h

...
#define DIFF_FLAGS_INIT \
{               \
                0       \
}
struct diff_flags {
        unsigned recursive : 1;
        unsigned tree_in_recursive : 1;
        unsigned binary : 1;
        unsigned text : 1;
...


>>> +       for (i = 0; i < sizeof(struct diff_flags); i++)
>>
>> I think most of the code prefers to put the variable into the sizeof
>> argument i.e. 'sizeof(*a)', as that is presumably more maintainable.
>> (If the type of 'a' changes, then we don't forget to adapt this place,
>> but the compiler can take care of it.
>
> Yup, but in this case we won't change the type, no?

Most likely. If we were to change the type we'd have to rename the function
and probably rewrite the body, too. I just mentioned it from a consistency
point of view. (exceptions are both a mental burden to humans as well
as to machines using .clang-format et al. The fewer "this time is different"
calls we have, the better)
