Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070AB1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 20:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfBEUjK (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 15:39:10 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:39105 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfBEUjK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 15:39:10 -0500
Received: by mail-wm1-f47.google.com with SMTP id y8so354964wmi.4
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 12:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wqT1TaC2ydU5MSYi5/Z7rvm6ufdQBatK5YhtuNPZ/zc=;
        b=gAZ7/oVMimwPvVxq0Fiv5cifTK72oCQq+p73Lc/1l1jtn99POVmZM2/elE0jl+CiHD
         LYC6Eh00nMhFebgZFMPBfPwCS85WIC3FDzDLuZVLRcHeE21XUW8icSrCYCFjqaE+6mn8
         Qu6/EYbC/fHEQD0oaN3lzLktvT0ZXZF/VAncV1EatpczeAkTWKUiMVXkwiQga9lW/YeX
         2+dnoAJEaqc16+hh8OVXLz+0g5azdF7fZ/+0fUBVh15K748m+WlDbGLWVx8TKhHUNGnZ
         bqopbaTM0oH/GvHJEQCFjuPc2cYXbO5IT60QOadyuvvDg47qiy2EgkwbFy4FgNFv3s+d
         hYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wqT1TaC2ydU5MSYi5/Z7rvm6ufdQBatK5YhtuNPZ/zc=;
        b=hFhlsae9xiF0jEv+j9vSMNfvuE0DPD71Lht0xvDf/s33FshaP8VMHt8MTQlSi02Lu+
         nfdQ7x0OUnPVMMLs06arjOIiiCXNOXDDKY4fXaPZ6BhJvHo1zNyizIWtfDaDRLWniBEO
         DRoBKMZFUwRCf2ELgEGBixhTR2W7U8pILqEA+5w+w2go1WaEk3F3HM0L7CF3m58HAehc
         N34QOTTUnPG9lUUwhBchlTM2OiI5nICWE0rdX8cwvPqdmHWA15UogEsJXTHj2rfF+3CR
         hcf/hEDaA8Sx+wVJG8KWvbiuo5bqX8QEhT7zt3HqZU1D4QBMFboFkQd3AGAP4zxZxteB
         Zi1w==
X-Gm-Message-State: AHQUAubKq8xfv1DHnHT5AhK9IEVbqqtU+/6XgkIDOurGxDFNzCzkstDC
        3f+V9uT+VzFyyaM9HPv+FTA=
X-Google-Smtp-Source: AHgI3IZArRzhM7FaRxGrmb3dCX2Wzlfe87Up2/TNn5TvOYbdBRckJUhJ/yfYq5Xr3wI7jZiv7EuGrg==
X-Received: by 2002:a1c:1a8a:: with SMTP id a132mr387421wma.109.1549399148285;
        Tue, 05 Feb 2019 12:39:08 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r14sm1335704wrr.65.2019.02.05.12.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 12:39:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4] log,diff-tree: add --combined-all-names option
References: <20190126221811.20241-1-newren@gmail.com>
        <20190204200754.16413-1-newren@gmail.com>
        <xmqqlg2vtfmo.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGyL5BAejK-P-EdscFdH3C6uR7e6CbgNe-9doy-mkw-vg@mail.gmail.com>
Date:   Tue, 05 Feb 2019 12:39:07 -0800
In-Reply-To: <CABPp-BGyL5BAejK-P-EdscFdH3C6uR7e6CbgNe-9doy-mkw-vg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 5 Feb 2019 07:51:56 -0800")
Message-ID: <xmqqa7jarmvo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> > Further, in patch format, this changes the from/to headers so that
>> > instead of just having one "from" header, we get one for each parent.
>> > For example, instead of having
>> >
>> >   --- a/phooey.c
>> >   +++ b/phooey.c
>> >
>> > we would see
>> >
>> >   --- a/fooey.c
>> >   --- a/fuey.c
>> >   +++ b/phooey.c
>>
>> Do we have the three "rename from fooey.c", "rename from fuey.c" and
>> "rename to "phooey.c" extended headers, too?  That's what I meant in
>> my response, but I do like what I see in the above example ;-)
>
> Ah, gotcha.  I'll look into whether it's possible to hook it up to
> diff.c's fill_metainfo() .

Just to clarify.  I do not think these extended headers are "must
have"; the "--cc" output is not meant for machine consumption, as it
simplifies the output by omitting hunks that preimage trees agree
with each other etc., and making the resulting "patch" not showing
the whole picture, and these extended header lines might only become
waste of the screen real estate.

So, do not spend too much effort to emit these textual info that can
be easily seen with the N+1 plus/minus header lines.

Thanks.

