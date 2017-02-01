Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E0F91F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 18:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754283AbdBASky (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 13:40:54 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36515 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754277AbdBASkx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 13:40:53 -0500
Received: by mail-pf0-f195.google.com with SMTP id 19so32329879pfo.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 10:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KXH9dSRHFtF0i/J1Vl/zitrtEatNKzrfAXs2dP1o81k=;
        b=bIvULOAZxT5zrBcg/6rFdeiYqM6JhnmhMhLLUR4bN7QX+viaQuS/6i+BXYnfrM25qc
         mVdlBo4g6OrrvldkdWQRtEDIG7gqwUFWH3XfVL6rbQF5/Fvga21qV7ezaPauE1Eqb7xM
         XzWNXGNKl3WrHHt4sqhg87DFNXw938c4meP9YMT/gCmhYwGmMfHSrgg6PpcAqhQ1ivm/
         dk6pNk/w+q4WxGcTfd8+JVECcc4I1Ktc6tjitc/LWbdcnZyaxMjcFdNUnqSopGYTh2Xo
         596WTnaxq1+cFmVkLegt8XIRo9wAtusYVBHMnRocQ6sPTQZHZsgMtpRF5KDn9RoiQX9U
         tTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KXH9dSRHFtF0i/J1Vl/zitrtEatNKzrfAXs2dP1o81k=;
        b=uAUOeniYdugjC9E2xmX5lc7ikOVJIlXME3RGYsp2/fa0EMU8hLSPzkSPUg+6/Oh5sh
         CcCCjnVznuydihi6y2JyTYNlo/vtx3/whRmlDbtQ4JeiG96e9uHsbWJyeZt/1W48Gjn2
         xXQhAsGrXpjfm6XyxNOvpVV0+cWbEz3aNAae0oyv7vO/yYMVEJJNkO2Y+h7NjP/HdDMJ
         bvtMYaCWz89rHtufrb1MNZ64o5MbqnEKPkiUryzftOEMuNmlQ3GYyigpNqYmVLU5hEE1
         EaUBcw2OV7bUEskjl9KlIHprUg4JCc2Juvk+RIeQbQhhk/KFtlpovF9gLqrtHl+zRzFP
         OjYQ==
X-Gm-Message-State: AIkVDXIXrSi7anJVYDFLYmslnYhBpk/kXZPgiFTXP+Hd1usPsM0dkS1sm9iPyTgiS+8sIQ==
X-Received: by 10.98.56.196 with SMTP id f187mr5338250pfa.131.1485974442787;
        Wed, 01 Feb 2017 10:40:42 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id o18sm51995276pgn.36.2017.02.01.10.40.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 10:40:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, psteinhardt@elego.de
Subject: Re: What's cooking in git.git (Jan 2017, #06; Tue, 31)
References: <xmqqpoj2q25n.fsf@gitster.mtv.corp.google.com>
        <20170201110851.GA475@pks-pc>
Date:   Wed, 01 Feb 2017 10:40:40 -0800
In-Reply-To: <20170201110851.GA475@pks-pc> (Patrick Steinhardt's message of
        "Wed, 1 Feb 2017 12:08:51 +0100")
Message-ID: <xmqq8tpppxef.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> I just tried to write additional tests to exercise this in our
> config-tests by using `git config --get-urlmatch` with multiple
> `http.extraheader`s set. I've been stumped that it still didn't
> work correctly with my patch, only the last value was actually
> ever returned.

I think that is very much in line with "git config --get" works, and
"--get-urlmatch" being an enhancement of "--get", I would expect
that "--get-urlmatch" to follow the usual "the last one wins" rule.

If you want to see _all_ values for a multi-valued variable, you
would say "git config --get-all".  IIUC, there currently is no
"--get-all-urlmatch", but there may need one.  I dunno.
