Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F39FE1FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 07:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbcLHHuc (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 02:50:32 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37124 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbcLHHuc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 02:50:32 -0500
Received: by mail-wm0-f43.google.com with SMTP id t79so12208023wmt.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 23:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NntAU5SeYSKx/6Cf4xZi3tf0fWk5OBAM4LURRHAW7lU=;
        b=ZB/kknAH1x+kkvw7i2HOUhLerAFDVMcg/4c/vm1b6/wSRIJvU/qdK2MJ+w9t551Qr1
         AnrAfoqZL5XxR7/Pvgzh0fqAHYNXTC+Iq2ebN49JD5nz8OfsVe9fXSQva1OcLRqjIfSV
         gz926bDQTEU6/Qs6eoD+0WI0rEKoY7xhoiTF124Y0RVPx0VJmN9el5wVG1knZULf041m
         HuA0UM4+z0aF7L+e0d7Zgq1aaNXt20sJk8HDKSxOvX37k1Bm4lDRqzOD20ApaSv2cZjm
         mJ7O8VnC0sP7twCKPAP0lca7mT0kcJqjPpHWCfqqOEVGIwLQ6ZB2XJg9ln5oNOXgJyHv
         BWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NntAU5SeYSKx/6Cf4xZi3tf0fWk5OBAM4LURRHAW7lU=;
        b=VhgyUxt3qbBhagXjMXVuAmYBYEXX7nBtL5Nok4Ez1HewuJlK5OLIflSYE+hV5fFYNS
         0c0ni8TzCBwx7Pg4Bm0GP7yIgduLhAVhXbOe3TF7/YStv9gMl3JAsUQPBHqa2496nLio
         K9Wy66rkJyyBXfRQXH16ZYu7nAI97a9fZVQ2lpX132gzO1JTzF4naZtSWfAKH2DpClXG
         tcAsuqYKD28dw6oYcxz6ohAdC2vIWeh4W2gmcsFRMA1jVY2JHav7bNQUjHGmukvp37q7
         tXcHlhH0ICs/062j/grC/+VfmYAud4z+G3JMWfOiY748uUkcwoLBxO1FTF3kTw3odPKz
         zEdg==
X-Gm-Message-State: AKaTC01+9VTB4kOeX8wufOELAjYvAoGFGjMWvve6ics7l6cbLWGXFgKsLJghHsHc2r7f6uTCNHCgBFeR5DWbvg==
X-Received: by 10.25.18.167 with SMTP id 39mr25251672lfs.81.1481183430538;
 Wed, 07 Dec 2016 23:50:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.74 with HTTP; Wed, 7 Dec 2016 23:50:30 -0800 (PST)
In-Reply-To: <6facca6e-622a-ea8f-89d8-a18b7faee3cc@gmx.net>
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com> <6facca6e-622a-ea8f-89d8-a18b7faee3cc@gmx.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 8 Dec 2016 08:50:30 +0100
Message-ID: <CAP8UFD0amsoo=QSZyc8rKcJqjO-o7P4TNDQjReXQK+m4hJCB6A@mail.gmail.com>
Subject: Re: BUG: "cherry-pick A..B || git reset --hard OTHER"
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Dec 7, 2016 at 7:36 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> On 12/06/2016 07:58 PM, Junio C Hamano wrote:
>
>>  (1) The third invocation of "cherry-pick" with "--abort" to get rid
>>      of the state from the unfinished cherry-pick we did previously
>>      is necessary, but the command does not notice that we resetted
>>      to a new branch AND we even did some other work there.  This
>>      loses end-user's work.
>>
>>      "git cherry-pick --abort" should learn from "git am --abort"
>>      that has an extra safety to deal with the above workflow.  The
>>      state from the unfinished "am" is removed, but the head is not
>>      rewound to avoid losing end-user's work.
>>
>>      You can try by replacing two instances of
>>
>>       $ git cherry-pick 0582a34f52..a94bb68397
>>
>>      with
>>
>>       $ git format-patch --stdout 0582a34f52..a94bb68397 | git am
>>
>>      in the above sequence, and conclude with "git am--abort" to see
>>      how much more pleasant and safe "git am --abort" is.
> Definitely. I'd volunteer to add that safety guard. (But (2) remains.)

That would be great if you could take care of that!

Thanks,
Christian.
