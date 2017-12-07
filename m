Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EDD120954
	for <e@80x24.org>; Thu,  7 Dec 2017 19:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbdLGTBf (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 14:01:35 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38200 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbdLGTBe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 14:01:34 -0500
Received: by mail-wm0-f67.google.com with SMTP id 64so14642024wme.3
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 11:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JtnrIJICBCVrD+7tzS3c9lE11oPZYRXImYsfNNc8rSQ=;
        b=u1f/W9T9lYXA6HTE//88mH4mXfCqpyozGbTvw/khFzmuNW8YPdvlWDOsD9gcQ29c2g
         7v2+dj1RclkH1wFGOTOiPyLW0DHEX5j19KeYiL7SvJ1UaXSxNprMBXu2rmjZuwXaPC2b
         MDdE0X21vEBXlQm6Tss3l/xTa9l5iP+1LXqwL3/vi/M+tJXZ50EUbJMLYK87TqCGRuqn
         LAmYmhJlB4Reui2OpOovXliIrGXe9wsvF256uWW5RIVI23f9tOy+I5YSumodP0Adbylx
         sJqNFZvM5ihBtfxFFHbotDVMImbNjOUE10VlYCSA8wrP+zq/Nejy6tSY/RRTGBbglOKV
         MkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JtnrIJICBCVrD+7tzS3c9lE11oPZYRXImYsfNNc8rSQ=;
        b=OsH9SHRPZmvpQFoQY7oo0PW7iZfIwE4/VJwuVGjLmPH+a1IDnAfoE0wYNl0ujRMo2a
         F0G5iqmG6HQDxEhqHzQr0IjzZttyNyRW31pP9cQ3lrNRcaGOvNDZu9XU69wdRZTbz3KI
         qg0PO/IggxGDU7nuovG6XTxkeiLzes4m0e5zTLgMyV7WcbYowzFqGkaBO5IeMBCnvl2K
         lLKp/DflCCBqDMpIEbjHPJDfgoKiZb7iA7Ly4NLIewlwUePHqfH2xRl6tUDTI4r4RjUr
         cNCxet1R9uXQBBk4jrlApiRFH4tg3aimR+r289bUWDGSZtssHdYaetfXBiEJ6kJtAN+7
         JGIw==
X-Gm-Message-State: AJaThX73HYt5N3NCMN2HuIs+7dAMRxlpDqFX4SxGv0jq7d1f3Zgvm+ga
        WpnzmQfVWyBqVku/oOsnNTHDgdkurNFltTrMjNb7ug==
X-Google-Smtp-Source: AGs4zMZfrJGx5csANrzjRM/itJR1Po2wLS87AUHrxqB38pjhLwpSsDvEIC6wOd5Qznq+lxYKVnDmUqMmsbmJOD874Xg=
X-Received: by 10.80.182.217 with SMTP id f25mr48072035ede.104.1512673293663;
 Thu, 07 Dec 2017 11:01:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Thu, 7 Dec 2017 11:01:12 -0800 (PST)
In-Reply-To: <xmqq4lp2ftjt.fsf@gitster.mtv.corp.google.com>
References: <20171207005929.24109-1-jacob.e.keller@intel.com> <xmqq4lp2ftjt.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 7 Dec 2017 11:01:12 -0800
Message-ID: <CA+P7+xpAFJcvcQ9PN5ZsnQxf8GpSG2yYKSYEg5wHebyCLtvdsw@mail.gmail.com>
Subject: Re: [PATCH v2] diff: fix --relative without arguments
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 7, 2017 at 7:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Recently, commit f7923a5ece00 ("diff: use skip_to_optional_val()",
>> 2017-12-04) changed how we parsed some diff options, preferring
>> skip_to_optional_val instead of a more complex skip_prefix() setup.
>
> I'd expect a moral equivalent of this squashed in when Christian
> rerolls the skip-to-optional-val series (with helped-by: attribution
> to you, probably).  It does not make much sense to leave the initial
> breakage like this one in the history.
>
> Thanks.

Quite correct. I'll be sending a patch with just new tests shortly.

Thanks,
Jake
