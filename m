Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD951F453
	for <e@80x24.org>; Mon,  4 Feb 2019 18:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfBDSMq (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 13:12:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55684 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbfBDSMq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 13:12:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so872091wmc.5
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 10:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=48b63FVdywKYvjdOKTUe4qwV1f9lFri42d47KVEni/w=;
        b=es+4Ku8Wg38OkHwd5FmzpgoIFLsByORU2u3bfyKZU0Jh9ECVPW171enxUV17mIZgcw
         FKiVjbnE3ELJ9UTJokSdouI3SEBgC5+jbzktrKkSm/VST1gjx3Z61zeHqN32Xt48f5gS
         Ke0hK34WCICAa027RrCbfoH2/zLDotMUd74yb9TY0MSgWAm2CKQzEF/ydgVJkCNCPA7k
         0Xyjasvp4bfmc2gbSm/gaNFsF3EHLCDqQtEcX6BQ+8I3ARmdMzqj4iIy/QPcE6lqK4F1
         TnO409MFOtUXeHgn5oFX1cYAiTm3vClIY1VRUeAW5/oYNa0SJ6TkvzzxxHLXDRvm0jfV
         Tzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=48b63FVdywKYvjdOKTUe4qwV1f9lFri42d47KVEni/w=;
        b=ejD62cRMi31BvHenBE01kDjwCvB7ePdulShcOg8181rSiPAIiRHCLlPQMrPmJVD7hf
         dwOgrSwV5FAav5AE3xttcbm8P4nvXtpDppkfKmy3gMJCkwu08mT5mGL9y5eDKtr8o0s1
         EAhaMGu7Sx8FIg8cpzkuq/8ltWOPp3ljmUC+4hXG8B6yJKf1EIEl5KbgpUdBuHFwKEi0
         mxDqDbBcT4jHeL1a07TOZYMWhB9BVoAtixaHOkmJRTJjAcqDegy3GB5m4TKLRIBw38DU
         17w6RHn4ff+ZJcN7hpJk/VIqpxP6LUbv93C1LUR61Lg1hj8Xh2/ypTTHQA5JHH9BP7t0
         TGOw==
X-Gm-Message-State: AHQUAuZ+B+HeYtIVyXIm9tifwHJFIG5mtg0jDGhNuNaXvcPQzlGLdk2M
        L7/bmTM0Y0wdzHUopGliNWs=
X-Google-Smtp-Source: AHgI3IZ9OOVSzXnyW6XnPcf/L+DvlTaoN/mDbaFhtS3Rp4P0G1coWW1ldJX7V6d7VqQCXNuJmmam4g==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr495847wme.73.1549303963865;
        Mon, 04 Feb 2019 10:12:43 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z9sm23170389wrs.63.2019.02.04.10.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 10:12:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/1] Makefile: improve SPARSE_FLAGS customisation
References: <3ccf0255-8a15-effc-ce6b-eabb61625f90@ramsayjones.plus.com>
        <xmqqmunfxjve.fsf@gitster-ct.c.googlers.com>
        <4a8f6b3f-3844-b4e8-2ed2-4078b592dd4b@ramsayjones.plus.com>
Date:   Mon, 04 Feb 2019 10:12:42 -0800
In-Reply-To: <4a8f6b3f-3844-b4e8-2ed2-4078b592dd4b@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sun, 3 Feb 2019 01:25:22 +0000")
Message-ID: <xmqqwomfv2w5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> Thanks for a detailed and clear explanation here and in the cover
>> letter.  I agree with the motivation and most of the things I see in
>> this patch, but one thing that stands out at me is if we still want
>> to += append to SP_EXTRA_FLAGS in target specific way.  Before this
>> patch, because SPARSE_FLAGS was a dual use variable, it needed +=
>> appending to it in these two places, but that rationale is gone with
>> this patch.
>
> As Luc surmised, in his reply, my intention was that SP_EXTRA_FLAGS
> should be used for any 'internal' settings (not just the target
> specific settings), whereas SPARSE_FLAGS would now be used _only_ for
> user customisation.

OK, if that is the case, then not using "+= append" on SP_EXTRA_FLAGS
and initializing it without allowing environment would be two improvements
that can make the intention more clear, I think.

> Anyway, its late, so I will look at redoing the patches soon.

Thanks.
