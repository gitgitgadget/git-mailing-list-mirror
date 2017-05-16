Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09609201A7
	for <e@80x24.org>; Tue, 16 May 2017 03:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750836AbdEPDmb (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 23:42:31 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33442 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdEPDma (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 23:42:30 -0400
Received: by mail-pg0-f42.google.com with SMTP id u187so69503614pgb.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 20:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zL+pWvROV28BK5EKSjxjeO3Mbl54OkirPELw0ETcdnw=;
        b=dd6T7j9DgCDtbL6WaUMW5RHDxZmDfD1Puy+rXniHNYEKsACDhKoiUtYUjI6lwffUIQ
         QRBCKS5noExl7LFNdzZpUM0tGVcEuykvH7STeeLqRXoRycWJURMvd9svs6yP4p9LqhcS
         0fvkgNoj4d3/UYN1G/9fB64ipRg4UrcQJtNCwICWmiy/GBpwuPVTA9LUtOtN3bMNa88y
         UqO1STsva92F9oB71wGyfobSErNIKzoCcoefSaUdSy8fjR5jMZaZIUuTsN/mncQ4FR44
         FFqnZjvU73AvgsdieZR91edEwhzGB9jyL46TZGO8+x7eEjOYIrxKo7v2tWzKeBDN/UH0
         uESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zL+pWvROV28BK5EKSjxjeO3Mbl54OkirPELw0ETcdnw=;
        b=nB4h9fySgzup71TJwLTNaaiuHkCBeEGSn4tPXdHxxXh06Eo2TLkMgcNaAbIaMVBckr
         Cf6uhfu8xth2iQFr9nMmVRkoAsVOamuaPmymHcmrcguIXAS59TM1EqezrtX7oJJRiLHe
         Y9f/kgaLPlGXsRQWx2aAn+/kSZzYCKWWN14iV8Go0AuFMtrvqqE097QOE468CaCOVXOu
         DWo5P6KU8bt5XWcnK0uepbvtEmtpqgUznirdzrR2wr+oTM5qZedGFKFeZFDwRqFKWzUg
         Z/dL3CAtVy797sArfNYrdzvSG7/HLRiPg0SCTxU/iwxYFhY7VivFoF3yUvLD+nywEPY7
         z4Fg==
X-Gm-Message-State: AODbwcBAJCTTf/ibW7cU/uPz7oMi13/jHmpI0IU9f3MPGZmHCour49zn
        osDGT4On0eWArA==
X-Received: by 10.84.142.101 with SMTP id 92mr13092913plw.112.1494906149501;
        Mon, 15 May 2017 20:42:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id d123sm23352713pga.61.2017.05.15.20.42.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 20:42:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How to force a pull to succeed?
References: <CAH8yC8k8sTGDA=C8vLCE090Y1B4TK86bOnZMNjj13C-JXVEBHQ@mail.gmail.com>
        <xmqq8tlx4h1y.fsf@gitster.mtv.corp.google.com>
        <CAH8yC8mOc68A-0uM8b3AKAYo9VqYNUjHkGw0knbXL0suM25tfA@mail.gmail.com>
Date:   Tue, 16 May 2017 12:42:28 +0900
In-Reply-To: <CAH8yC8mOc68A-0uM8b3AKAYo9VqYNUjHkGw0knbXL0suM25tfA@mail.gmail.com>
        (Jeffrey Walton's message of "Mon, 15 May 2017 23:32:33 -0400")
Message-ID: <xmqqmvad31sr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> On Mon, May 15, 2017 at 11:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeffrey Walton <noloader@gmail.com> writes:
>>
>>> I scp'd a file to another machine for testing. The change tested OK,
>>> so I checked it in on the original machine.
>>> ...
>>> How do I force the pull to succeed?
>>
>> Git doesn't know (or care) if you "scp"ed a file from a known to be
>> good place, or if you modified it in the editor.  When it notices
>> that there are differences you may rather not to lose in these files
>> (because they are different from HEAD), it refrains from touching
>> them.
>>
>> So the way to go forward is for you to make sure that you do not
>> have such local changes in the repository that your "pull" is trying
>> to touch.  An easiest way would be to do
>>
>>         git checkout HEAD -- <paths>..
>
> Thanks. That's an extra command. Is there any way to roll it up into
> one command?

        git checkout HEAD -- <paths>.. && git pull

;-)

>> before doing a "git pull" to clear the damage you caused manually
>> with your "scp".
>
> There's no damage. Its expected.

The fact that you think it is expected is immaterial. Git doesn't
know (or care) how you made the files different from HEAD, so it
looks like a damage to it.

