Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECDD9201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 17:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755557AbdGCRVg (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 13:21:36 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33550 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755529AbdGCRVf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 13:21:35 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so23741927pgb.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 10:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KwxQPtIgs2WOv1cgFyGi5MG6UpFLH+IGjLKwUT9fQ/w=;
        b=N5QrPNbPtf6vu6nr4Z4WddsNst1GYr9sapl0RNK/Z4I9i5uTAsaExXR0+srV2e8JQh
         g+3eOm+Oixs/URM0BtVJDvnXvfq5ij95q/P6g4bT43JkRSvHkF0LR5ziElZDMGrs/XKV
         lg/Ir/aP67QSxMH34jQ+5HBi+6AjtsNZTttDmVyqdxJrRPDYS8X8RbXGTM0Krlyuezyg
         4aEpKh2QsF3H6PgyRyy9UdhBcq42Ka6erL2lweQu0Ba4wXoqm+x5jHkoVmXukaQVQaqc
         L2mEYoHc+wJ+y3dCJKtO+hootidZWV+s0Pe2CrLhYpA8e21UtUCpjml4c9Tux+Nw/HEo
         k2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KwxQPtIgs2WOv1cgFyGi5MG6UpFLH+IGjLKwUT9fQ/w=;
        b=NIFhI3HIL5KZTi9NAaBy+Xk1r9MeKJoSPoVY/pIljqM66cgh1GSeru1wtXXmoww3Yt
         kHJ+X20NxAOFUK0i3Qvu+TimVAw5UWYBILtkGjEkODL54XNpjXJlhI5HRjVuZbzvib1A
         ht9zNMpfVuHOWQUQWRfzLMF3PYs/2DKFjQ8JPKlkgShdP2I0kv/L5mhVszuu/0ak34Di
         v/mQtLAGCQ6oBD5a7ia/xVrVgUt0fPDT/eGaztXiGSS20CGIRt3/sntJYCA3aw0vvqYm
         kXq0LnU9dRMXskl2NEWAcOxB66pz+iMS3ZnmiPkPmUz/OvyBcw/HMJYVtsSHuIswRXeQ
         BpRA==
X-Gm-Message-State: AIVw1133rR122oyqbXBl80olR30KOWSbSYJpFT4/w/Ig3YBAJlCF84LZ
        X3hoA6oGG9/PlQ==
X-Received: by 10.84.231.15 with SMTP id f15mr11991539plk.131.1499102494513;
        Mon, 03 Jul 2017 10:21:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:30:4739:ca21:b5b4])
        by smtp.gmail.com with ESMTPSA id e124sm29096202pgc.17.2017.07.03.10.21.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 10:21:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Why doesn't merge fail if message has only sign-off?
References: <1498996988.26970.1.camel@gmail.com>
Date:   Mon, 03 Jul 2017 10:21:32 -0700
In-Reply-To: <1498996988.26970.1.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sun, 02 Jul 2017 17:33:08 +0530")
Message-ID: <xmqq60f9mo6b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> While trying to merge a branch using "git merge" if a merge
> message consists only of a "Sign-off" line it doesn't fail.
> To be consistent with the behaviour of "git commit" shouldn't the merge
> fail?

I think that it is not by design that it doesn't fail.  It's not
like we decided to allow s-o-b only merge because we found a reason
why it is a good idea to do so.

So I do not think anybody minds too deeply if somebody came up a
patch to "fix" it.  It's just that nobody tried to create such a
silly merge in real life so far (I do not think you did, either--you
found this out by playing around trying to find corner cases, no?)

