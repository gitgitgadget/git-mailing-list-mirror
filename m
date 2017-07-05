Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DBDF202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 19:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbdGETTu (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 15:19:50 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33228 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdGETTt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 15:19:49 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so33342390pgb.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3W1ApYsqX783eak6LdlRs7BF8UMci7Ni+vJWowXSoG0=;
        b=PubFAwsCKEzo83ZBRZKj/F7CXoiJpQsHhtIBTiDsfUKZt2KYC3Re+/3M3w9gmx1Wq1
         HjXa2ROtG7uqtWRX2c8IV0L2D710DPU39Me8J2hOIZW+rdjFmdzzDdd2qRI0FR1zqIJ2
         joidRtE6vtxEp29VhCCVNSDLCU8NZjOuXwFunnPpkZGSbtjS/a61xajcDPSp1ApmrwQe
         F9P3e85V103cMhVSEmHFf6zZt1yMm28/7z1hYGwHiH2oP4EY5X6nB9hD5w/AgyTlySUo
         NwrQX6TiJsooKUnS+4s2fYh8h8qFg6yIHgNuCcJCsSJ5Cq5loltBq0XcdQP6MKrnVHnU
         9wHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3W1ApYsqX783eak6LdlRs7BF8UMci7Ni+vJWowXSoG0=;
        b=WoWxxYkUKwNYJX2uy1AKjcdpIiGEuy3o8reRo8PS0gH4paxMy8zte8g5JZvTiYxdNw
         25VKRGVXylZstzv0Db6zFtiybVAhjcz5SN/lRUCKyio4gz7h/Vg1sK98nbpDChnrSjRf
         4RGS/myC950LnIAL4JRAsg6lMaHzjqjbVcsH8m6BW+EdTYyLdLLwbSzBhLBsGzWBr9r7
         fKyfQ3rh/qAXwOINE84fKe9121HQLNDfFbgxpwIHPlq9dfT52cZKW280TRpfbCxkZd7R
         NbhociWzctYC3T6wkzlplRe9NXYk1pfq67YCsuO3RRBujqPQ1aT58EXQBYvKepcmILnI
         JHdg==
X-Gm-Message-State: AIVw112nvijd+MNMKwZc1L+Iv0KXicGXRZtQIXv7QaJh0emtF18mEh7S
        CH8TVo5h5wE9yg==
X-Received: by 10.99.4.6 with SMTP id 6mr22828256pge.126.1499282388766;
        Wed, 05 Jul 2017 12:19:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id p11sm46000341pfk.128.2017.07.05.12.19.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 12:19:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Requesting suggestions for a good sample "prepare-commit-msg" hook
References: <1499273152.16389.2.camel@gmail.com>
        <xmqqwp7miztv.fsf@gitster.mtv.corp.google.com>
        <1499275601.16389.6.camel@gmail.com>
        <1499278787.1791.2.camel@gmail.com>
Date:   Wed, 05 Jul 2017 12:19:44 -0700
In-Reply-To: <1499278787.1791.2.camel@gmail.com> (Kaartic Sivaraam's message
        of "Wed, 05 Jul 2017 23:49:47 +0530")
Message-ID: <xmqqzicihesv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

>> On Wed, 2017-07-05 at 10:00 -0700, Junio C Hamano wrote:
>> > I am not so sure that we are searching for them, to be honest (who
>> > are we in this context anyway?)
>> 
> Imagining HTML could be used in plain-text,
>
> <strike> I think I misinterpreted your sentence in one of the other
> mails (found below), </strike> Sorry for that sloppy sentence. More
> correctly, the "we" in that context is the same as the "we" in the
> context of the text quoted below,
>
>>     That sounds like a sample that is there not because it would be
>>     useful, but because we couldn't think of any useful example.
>> 
>
> Link to the post that has the quoted text,
> http://public-inbox.org/git/%3Cxmqqy3s7nbkm.fsf@gitster.mtv.corp.google.com%3E/

I honestly do not see your point.  Yes, I said that the change
indicates that there is no useful example found (so far).  That does
not necessarily mean that we must find a useful example so that we
can keep this sample script, which now became useless, alive.  

I am questioning the assumption that it helps users to have a sample
for prepare-commit-msg shipped with our source, and I suspect that
it may no longer be true.  If the sole purpose of finding a useful
example is to keep the sample script alive, when the sample script
is no longer a useful thing to ship, then it does sound like "a
solution looking for a problem", no?

