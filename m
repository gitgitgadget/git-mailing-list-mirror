Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B6961F859
	for <e@80x24.org>; Wed, 31 Aug 2016 20:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932200AbcHaU3z (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 16:29:55 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37606 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753618AbcHaU3z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 16:29:55 -0400
Received: by mail-wm0-f46.google.com with SMTP id d196so7597948wmd.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=IPfoTs2wq2CEKyRHFZaoiwl1eO+vLEQF/n45GPgf74w=;
        b=jK8YZs3JEQNtKrYkdkccd75Y9kO+6HmBDzcAwMT+ntBIrmmM0tQs4EC6n190oMO3P6
         3Gvz9YgpQOqKTsdIdMaL1PgB/7CCjwcR3rbn1xgjyki4bh/nVMpvyymMxPyzJGWwg0sv
         St9chTCBHwKBYdjFVH2n5q39gybQEvlimLAdh1PVYF6ccHW4Z8X0Yzo9IN+1+dhvijnl
         UxXs3BXvcyG4xjXhwQYM8H8v1tRi4GEMSDO89T/pBnIZcok7vUUepUjGzr/ACHCbNHtx
         Pg8Z+4QhABEO4nbD7OX0saMxC5eP18UHG5n2P3p1DXzXj17y33xDig0KOuKMD1OP8FjB
         AQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=IPfoTs2wq2CEKyRHFZaoiwl1eO+vLEQF/n45GPgf74w=;
        b=MGBvKoW5+FgAi8B6UamTIQv/CgblSkyRvQMnd35nwOqyzNpL/l91k90UwrHUjm6nYS
         PwV7do+5TFqwb977loOpUD5yM5+BE5s1v74B+wMSGvebMdpHNPzW8fdzIyzrgJ5eURQb
         dR3ZGu2noyflmy5T/BhAaRLjucFWUGky5JyRlABGnLJ2kLxOcjSff87LDL6gCSU+Z2VC
         YblJ2Nbj9x06Ey4kBgRc8BTDPTVEVrqH6XyUf6h5rw6PJbjh1PGMMup+srwWwXeiX8Oa
         u33qKhdNC4Eth68sJIBxQrnZRtQNPhQLIo7A3+85oTS7wVO8CRXUkNW9FoJdh/pRTtS/
         RSQg==
X-Gm-Message-State: AE9vXwOQBsXtSWoAgTLMJC3PID3F3ljtewXrMadeptgXYI4Poi/cSEwfkSxR5+OUD8IvYw==
X-Received: by 10.28.111.213 with SMTP id c82mr23973801wmi.47.1472675393280;
        Wed, 31 Aug 2016 13:29:53 -0700 (PDT)
Received: from [192.168.1.26] (enu134.neoplus.adsl.tpnet.pl. [83.20.10.134])
        by smtp.googlemail.com with ESMTPSA id o142sm25441160wme.20.2016.08.31.13.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 13:29:52 -0700 (PDT)
Subject: Re: [PATCH 16/22] sequencer: prepare for rebase -i's GPG settings
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <c6a37af958f59390c00429a5b38b34d34c9a5b95.1472457609.git.johannes.schindelin@gmx.de>
 <104de15c-77e8-9474-9579-4934ca8a4323@gmail.com>
 <xmqqmvjszoia.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <a948ad4f-2145-bacb-0ec6-7edac14c4d4c@gmail.com>
Date:   Wed, 31 Aug 2016 22:29:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqmvjszoia.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 31.08.2016 o 22:12, Junio C Hamano pisze:
> Jakub Narębski <jnareb@gmail.com> writes:
>> Johannes Schindelin wrote:

>>> +			else {
>>> +				opts->gpg_sign = buf.buf + 2;
>>> +				strbuf_detach(&buf, NULL);
>>
>> Wouldn't we leak 2 characters that got skipped?  Maybe xstrdup would
>> be better (if it is leaked, and not reattached)?
> 
> An attempt to avoid leaking by calling free(opts->gpg_sign) would
> make it crash, which would be even worse ;-).
 
Actually, from C standard:

"If ptr [in free(ptr)] does not point to a block of memory allocated
 with the above functions [malloc(), etc.], it causes undefined behavior."
                                                      ^^^^^^^^^

Which is even worse if it does not lead to crash.


Note that if the last line was

    +				sequencer_entrust(opts, strbuf_detach(&buf, NULL));

we can make it not leak.  A bit tricksy, though.


Though xstrdup(buf.buf + 2) followed by strbuf_release(&buf) would
make free(opts->gpg_sign) possible without crash.  That is we can
work without *_entrust() mechanism at the cost of strdups.

-- 
Jakub Narębski

