Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA2761F597
	for <e@80x24.org>; Wed,  1 Aug 2018 22:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbeHBABc (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 20:01:32 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36447 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732068AbeHBABc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 20:01:32 -0400
Received: by mail-wm0-f51.google.com with SMTP id w24-v6so283178wmc.1
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 15:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lf7g8bSCDTtKJsPFzzcHUYDL6dq7qLxIVjuVcBzi+10=;
        b=CjSWzT1P+X/0uXl6zsgfnkFMv+rdt5PEPxNon14tA1tfJzi4d0f2J3/rHho9sSWu99
         LF9y0IEmZcShaQrSOE5qjmAtOc8q60mKnBRW9R03d83Qhmdjw/99FYV0oj9ee7PLHXEj
         o/XvPI19kAm732WnJbFyeOJA2nSvCrfHfIyz/oBp16XIOdrVgn13n5RhvkI4bNBB44qV
         gOtcmjLAQaNni72Xcky1FHql1aFcJPtPyRteiu4PnyXaPxVasGEiyjvdi5FP/vcyStmF
         68r5j6d/JqYYQx8fC+sPKGhMHZCQan2Acrp+dBVvxlHODstSuStWQzxdP8MCbEArGlOm
         RsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lf7g8bSCDTtKJsPFzzcHUYDL6dq7qLxIVjuVcBzi+10=;
        b=U33hphhSmi4ldJicnyn7RlPvUccSAH+cVF8sm9ynr4c5BdAaEZ/FOyn0Ru1HWFw1S9
         sm1yfoLazKqmOfAwPiQMwwxLODxk/cWkHt0/vqY4l/XXB0UNBXbDNla8vS5DXcdnxQqu
         jU/3jhWODBPDuE8fOxw/wVY1BtfPVjsguiIY7GAnk8bRitX70F+bMLdtF4VmiRLNqfw3
         C6O7+nwkFRV0kaBGjIiZTfzD0xxR9cpwRhOamO9q2QipQ7SeKPwOnHLoY8K2J6MPHzzD
         5PbAtn9s9oc0Qh8CRNrC1QRX7HakgqnweWK8PyHT94qSzxGmV4lewS1gN0vfR2/brYuM
         xxcg==
X-Gm-Message-State: AOUpUlF1bbYqz0EzCEhqiiNqwy50C4V6X0mkYYJRJyWqdXCv3NZRFKQb
        qLUP4e6eX63ON7d2gjd9C+MycAdK
X-Google-Smtp-Source: AAOMgpdT9jS1Q/n8u5E8diNBm1X/n59ifWh1zghaIuPu50dgBY1lrkRVFdK6cWTjvMd3nr48vANZqA==
X-Received: by 2002:a1c:ee15:: with SMTP id m21-v6mr207618wmh.112.1533161614217;
        Wed, 01 Aug 2018 15:13:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i205-v6sm302205wmf.30.2018.08.01.15.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 15:13:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: ds/multi-pack-index (was Re: What's cooking in git.git (Jul 2018, #03; Wed, 25))
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
        <f17a6d57-e6cb-9efa-d648-cd4f298dc47f@gmail.com>
Date:   Wed, 01 Aug 2018 15:13:33 -0700
In-Reply-To: <f17a6d57-e6cb-9efa-d648-cd4f298dc47f@gmail.com> (Derrick
        Stolee's message of "Wed, 1 Aug 2018 16:53:01 -0400")
Message-ID: <xmqqo9el68he.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 7/25/2018 6:13 PM, Junio C Hamano wrote:
>> * ds/multi-pack-index (2018-07-20) 23 commits
>> ...
>>   Ready to move to 'next', with some known issues to be followed up?
>>   cf. <xmqqefg8uplg.fsf@gitster-ct.c.googlers.com>
> I'm not sure if there is anything actionable for me to do in response
> to this message.

As I said elsewhere, "cf. <msg>" list does not attempt to be a
complete enumeration of things to be fixed.  It is a (sub)set of
pointers into list archive to help me in integration cycles to
decide if I can comfortably merge each topic to 'next' (or update
"What's cooking" to mark the topic as "Will merge").  FWIW, that
particular message is not even an objection ;-) It was telling the
future-me "hey, I looked at this series and found nothing wrong in
it, so no need to read them again to refresh your memory".

The other one is a good reminder, again, given primarily to
future-me, that the topic is known to be imperfect and the
discussion seemed to favor moving "with some known issues to be
followed up", so I should not waste time re-reading and poke the
same holes.

