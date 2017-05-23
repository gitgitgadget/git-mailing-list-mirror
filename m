Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7ED2023D
	for <e@80x24.org>; Tue, 23 May 2017 05:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761112AbdEWFOy (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 01:14:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35730 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761106AbdEWFOx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 01:14:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so24883983pfd.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 22:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xOIADFWyPcllr8i0g2o8gjtXaEdbTALMLNcGKEHE//0=;
        b=vDnr16FQaFb/B6lmVbb0hIYSexb0Ycll+w3I41v9TuHm00JJ5vVUpV0cXDkCFYzLDY
         0KGRgI/n9r1vf4FN2ESuFStAXEWYPJT/irmSjXx7Fqqv8pPcGW7jNP8KhcdRxO7/mbG8
         MPJqp61G8SMofKSk/ceM0HhHTFu0FKpkf4XIyPbWMfcKXlc7SOrV8dGPKW8NqFB3DAFk
         o5tbxDM1IDw+vNkM15S7XoYlY9m2nBo/h3Y0uFQ523NisntXPi7Z+dXnZ13P2iaOCBrd
         RHOlGBVnHotp+nb42sH/ojQkFFpDhVauf2Nn0EWdm4JTqBCGVLVvgksYYJnd7Nrd5jd9
         bDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xOIADFWyPcllr8i0g2o8gjtXaEdbTALMLNcGKEHE//0=;
        b=OF+k0lsd41A+tuAaWzvU9hVvTbTk52QfpKdfGTOYGa35kHr1ZcS+7dEEsFYmzItqvj
         rDGv2iKxIF/So1+Ywn/DclBGWWtriAwWRcOTFaKwXvM3kdlzu7N3HtZfHFbg25vQXpk3
         uneyVMuHzTPmCBQGEUftqietF4NBfCe5W1dsnnkW9jd66Kl7jTu7yV3Ac0oOcmA+kUPs
         yeqbDxPD13Wocv2CQm2iKmttVCrvVJkbNin+yGwmvMO5tKAgrMy5kcESOiH8cJsBQDhA
         /Y29+Rxs0vTfPvKWk66Y/7ZqcomLTtC8n5xI2Yk8Cgbq3bOSnAXBGhkHbWgYcIhGaD3i
         +r0A==
X-Gm-Message-State: AODbwcCNo97LJ9Nc21NSVZ8DM2Q6HlsFgFZqXt7oEMwUjonKXLkT7U6T
        L82aO5uQm9dv9A==
X-Received: by 10.84.253.23 with SMTP id z23mr34113930pll.11.1495516492647;
        Mon, 22 May 2017 22:14:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id x5sm32741554pfi.94.2017.05.22.22.14.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 22:14:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2017, #06; Mon, 22)
References: <xmqqo9ulo1yn.fsf@gitster.mtv.corp.google.com>
        <20170522174208.GB17710@aiede.svl.corp.google.com>
        <xmqqlgpomelp.fsf@gitster.mtv.corp.google.com>
        <20170523050236.GA21264@aiede.svl.corp.google.com>
Date:   Tue, 23 May 2017 14:14:51 +0900
In-Reply-To: <20170523050236.GA21264@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 22 May 2017 22:02:36 -0700")
Message-ID: <xmqq60gsm9x0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>> Junio C Hamano wrote:
>
>>>> * bw/forking-and-threading (2017-05-15) 14 commits
> [...]
>>>>  The "run-command" API implementation has been made more robust
>>>>  against dead-locking in a threaded environment.
>>>>
>>>>  Will merge to 'next'.
>>>
>>> What's holding this up?  The deadlock it fixed was a real,
>>> non-theoretical issue.
>>
>> Does "Being down-sick over the weekend" count?
>
> Yes.  Sorry, I should have asked in a more productive way.
>
> I applied the patches locally to ensure tests continue to pass
> reproducibly but was worried because the patches had been ejected from
> "next" and had been in "Will merge" state for the last couple of
> pushes.

There also is "which ones should go first to 'master'".  Regression
fixes want to go earlier than fixes to age-old issues, for example.

In any case, today was my "move them to 'next'" day (I aim to have
approximately 2 such days a week), so quite a few things will now be
in 'next' when today's integration cycle finishes.


