Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648491F404
	for <e@80x24.org>; Fri, 30 Mar 2018 17:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbeC3RSP (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 13:18:15 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34651 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeC3RSP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 13:18:15 -0400
Received: by mail-wr0-f171.google.com with SMTP id o8so8552910wra.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YYMCJQuX4IuzxrmRK79Q6wU0Vx8sofwCXnwjtrOPcws=;
        b=HiTRB+AE6yJ0POIeVvYuFIU7jeHnpK+8idxD5Cctfzd5I/ybkGVIb2OsA17/eyxCKw
         xWZFBwxvziCbQPbXWS+muCBzv2Unm7FYS86xUUV+zfng5RssrnejsUQLkrrJmqKSXVSD
         EIVFTHgUG4foMMJ5HdyEZrX0j9FhV8xPUjNBsf+M6fh3nnpL4OhTDDu8682COpSyLdY7
         I91wKeYAF6BE96FoXxHsO0IgxJ0T5Gtrwg+ZbEclryySPc+x8wwrR8GXUaiuP//z2l8k
         eazFkmVwGFpAWCXl8eIQf/hZOQzUd9eRyNwzR3NhdEdDksFs7kldGkBB/u2npMSrWUju
         QDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YYMCJQuX4IuzxrmRK79Q6wU0Vx8sofwCXnwjtrOPcws=;
        b=bfmnuP2PHllHI976mxBYvnUYABqN015XUt0bVplF3VAJz6tJWhfMliFj08Q916J+PG
         xbrDmwokf9VWqwzBoZSzagRy9rRphu+bmd0LtRyOR/gMgZNllyDNLlbYwql1k+920tNp
         sBx5TNWLZF9mJaJVWUnm2l6ETkM+M7JNdphUNF0TAkhek7V5RN1Hs/Z8VWu0ifCtmx5J
         6x9xZ9nXLQ2waOb5lVeSS2kzYFZ1vK+usGtraFVVYFm8iVyMlCaeU8Dc9G4VrPhrvkt0
         iwXgNqBMmDSKCXNmbfWfpaeOskHpxL5wi57lLT0ODRgeH39AgjWUn+x82pDqq/BHsOzM
         OkSg==
X-Gm-Message-State: AElRT7F8eRAYwRV1DfTnmEE+r5qGn2+toodRcytHEWaqJfgztfqSkMfw
        O2sjhCu03wF77nSUYwo3pU0=
X-Google-Smtp-Source: AIpwx4/YHvYMUuOWX8ioRxxDya5gsfkbvekL59RbErQKcPTyKVWWjQRw5B0lWGPtsYoyMLwe7T3ocg==
X-Received: by 10.223.141.162 with SMTP id o31mr10449219wrb.167.1522430293530;
        Fri, 30 Mar 2018 10:18:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e196sm5438809wmg.26.2018.03.30.10.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 10:18:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Luciano Joublanc <ljoublanc@dinogroup.eu>, git@vger.kernel.org
Subject: Re: Bad refspec messes up bundle.
References: <CAO+-ZX_-COVpzqoAZLRGu4mvLMkLYiR3y7rkCtwmnvJ8kA7txQ@mail.gmail.com>
        <xmqq370wvugk.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803301102430.5026@qfpub.tvgsbejvaqbjf.bet>
Date:   Fri, 30 Mar 2018 10:18:12 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1803301102430.5026@qfpub.tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 30 Mar 2018 12:20:21 +0200
        (DST)")
Message-ID: <xmqq370h4h4b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Luciano,
>
>> > Is this a bug? Should bundle allow providing multiple refspecs when
> ...
> I agree that it is a bug if a bundle file records a ref multiple times.
> Luciano, here are some pointers so you can fix it:
>
> - probably the best way to start would be to add a new test case to
>   t/t5607-clone-bundle.sh. The script *should* be relatively easy to
>   understand and imitate. The new test case would probably look somewhat
>   like this:
>
> 	test_expect_failure 'bundles must not contain multiple refs' '

s/multiple/duplicate/.  It is not unusual for a bundle to record
more than one ref; it is (1) useless and harmful to unsuspecting
clients to record the same ref twice with the same value and (2)
nonesnse to record the same ref twice with different value.

Other than that, the outline seems to go in the right general
direction.

