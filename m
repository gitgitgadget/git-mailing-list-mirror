Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988C91FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 01:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbdBIBBo (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 20:01:44 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36717 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdBIBBn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 20:01:43 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so12519878pfo.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 17:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aamtYfbSfmBxtOxbV+V1f0Tq9bgzqVeAm42S2Xvt+9k=;
        b=lAe0xovnmO6GYXCv0HSyu4HFE4DkOF4Yx6WWT5iWsBcIvDQbVzqa2hMtPs6ipiHRLx
         mWAQV0BIC8FPVJoQ+x944gzzL4cAY/DiXkmt6It1wl2WcdElEWstCu6dErpjmFBWPYhP
         ApxuvJPWAAp+9AyFOnyarxqT0l/dAcTxYUorHhy0ag3Y3PpzFZfxdxcg+1zuiOmR3w7X
         iRRTCCto1OLerUdd4C9cBa1mvnOv3ysyvwuWyieDiumAuXU9hgv9Bd1v8MQ5svx6ipk6
         cZG222W/CYyl0QFNZ1I8IImpnOO63JeNQ68oA2DjQJKveSyfB4fGuKvJy6ZZ2jTcVDV3
         gFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aamtYfbSfmBxtOxbV+V1f0Tq9bgzqVeAm42S2Xvt+9k=;
        b=CNHKlS1eF78+0xCKURLC7OUxhhT2BdfsDdrGI6faFRuFgq6igUVO8N/fEj5xvxPpM3
         rvIbfFxoFAV4u4piuoMxmHJIIX6ladSr39r4YtwqnfPtS2rcePWfl/F++K0/WXFYQuWG
         3bkhrHlzyY9n8FM3WpMCIQ71mijTnbWwfTCVGJeOMD4zlRztoXEFlMGOys8EZYN+jAnk
         YzTYoowZtP4495zq8B1qpDrTVzek1baSUrdZDS2b3Z7ycAFAuG09/+WHjidaqT45ARr0
         lLbG65NImgjyAJbVTaLPn6ZZd5viiU9X+WQTQfS74lSydyy4bBTjk7PDHqMhVTZUw9/+
         Kmbg==
X-Gm-Message-State: AMke39n8rYgQVcpNjzFVxNLesCCuhF4rh+rENSVmTo4Oob5awS1vZXDvxJCBAojr9G+oUA==
X-Received: by 10.98.100.69 with SMTP id y66mr516352pfb.174.1486602102588;
        Wed, 08 Feb 2017 17:01:42 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id 199sm23140884pfu.91.2017.02.08.17.01.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 17:01:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZ6m1NGz9Lhhd5BDxayLW-UC8MqexMyhHBhHKrmg-tB+w@mail.gmail.com>
Date:   Wed, 08 Feb 2017 17:01:41 -0800
In-Reply-To: <CAGZ79kZ6m1NGz9Lhhd5BDxayLW-UC8MqexMyhHBhHKrmg-tB+w@mail.gmail.com>
        (Stefan Beller's message of "Wed, 8 Feb 2017 16:25:20 -0800")
Message-ID: <xmqq37fotbwq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> * sb/submodule-doc (2017-01-12) 3 commits
>>  - submodules: add a background story
>>  - submodule update documentation: don't repeat ourselves
>>  - submodule documentation: add options to the subcommand
>
> The first two commits are good to go IIRC as you seemed to be
> positive about them at the time. Though I have a hard time finding
> evidence of such.
>
> I am currently reworking the 3/3 "add a background story" patch as it is
> RFC-ish, so no need to review that any more.
>
> Maybe we can get 1&2 merged and then 3 comes on its own?

Yeah, sorry, I keep forgetting this topic, it seems.  Let's advance
the earlier two.  Tentatively I'd drop the third one as you plan to
redo it separately.

Thanks for prodding.

