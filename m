Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A10C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 18:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiLVS6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 13:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiLVS6J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 13:58:09 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C98112C
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 10:58:08 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m19so4178078edj.8
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 10:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ODegHHSNxaPgsD1LFjPoiB5uQwFJDXYPyhhRWNNUDKw=;
        b=XFUz0zYWHV8zXW50QjE+uqsSHe9Kf6Lb8vJIJorMVsQ5W5qL1mztUdVRXJglfe4GPl
         JT4pPXTsXl6ILrBd5DaderPvHm2OxW/yFe1T4gBuZvW6FLMD5AkSYU646Tqrjx/Khh6c
         CxjwoC7F56KRhJzM6navcJjbLTM4Cw1oo3qeYWLglaiP5dn5XIXMrik/AC39INYFmCA8
         seLixL9RItNIkmUEAMGja+ymHW7WSfPUTDwmqyqxbjraiG3oLMIVF36RUk2CBWrbLvrl
         B+uvx7ve3rKFrek09BRr8rIBhUTxBbZCIZuoYhKXVtfuP8fPbnTLIZBx2ZErav5BTMvL
         oJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODegHHSNxaPgsD1LFjPoiB5uQwFJDXYPyhhRWNNUDKw=;
        b=D9FzkICEoWBwzlc4QplxWh/agUadztTZV3oyIryGkaYYCxIUHvdhSTK9gk7p6T20x2
         eSXkO2zHjDu6p/4NByUN3e6YzqSvQ8LleYVeu04dXDaWm3Wj12sjF19cELW9rIqwqWwg
         Df9u+0PVGotdimcsThj6xXAO7cGcXHW1KhhRqFunHYuDnng9naCIjCc1XhD0U/bbs3M9
         Yb2uJ27zSWtx7CTTYUI5tbbpJAm3WWBPKEWmN3ZZFPTF1heItyqijoFEzuYNGhO2ZZYo
         R3DRC6Q7PsVxKlqatbtFfgENF9c7jHqrBYJUVoWmsgPXGwQkdXigBvspe1Ha5gQqOfE7
         Nr0g==
X-Gm-Message-State: AFqh2kp3v1tH4DpNgQ6JbuXQ8hdb1lyY/ptk0D0xlnhb9fu6V7RiKnXL
        WzIpSFF+bZYJ8tRZqrBB6ao=
X-Google-Smtp-Source: AMrXdXtNRR71LE6gBuhQB6QDFtWLMN69QwGaaihWG6pbwn7w5HsjSDrF3NhXhbg08lJH8djTPxLPMg==
X-Received: by 2002:a05:6402:4005:b0:46d:87a5:4dac with SMTP id d5-20020a056402400500b0046d87a54dacmr6271442eda.36.1671735486601;
        Thu, 22 Dec 2022 10:58:06 -0800 (PST)
Received: from localhost (94-21-37-252.pool.digikabel.hu. [94.21.37.252])
        by smtp.gmail.com with ESMTPSA id t4-20020aa7db04000000b0046f73b46c5csm658739eds.23.2022.12.22.10.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 10:58:05 -0800 (PST)
Date:   Thu, 22 Dec 2022 19:58:04 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] tests: make 'test_oid' print trailing newline
Message-ID: <20221222185804.GE3411@szeder.dev>
References: <20221218162905.3508164-1-szeder.dev@gmail.com>
 <xmqqy1r4usjy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy1r4usjy.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2022 at 09:48:49AM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> >       $ git grep '\stest_oid ' -- ':/t/*.sh'
> >       $ git grep 'echo "\?$(test_oid ' -- ':/t/*.sh'
> 
> I found these examples in the log message a bit annoying to see, as
> both invite an undefined behaviour by having an ordinary character
> ('s' or '?')  preceded by an unescaped backslash in a POSIXly
> correct implementation of BRE.  GNU libc seems to be OK with it (I
> double checked by adding "-G" on the command line to make sure my
> experiments are not affected by any grep.patterntype), but they may
> fail for folks on stricter platforms.

Please feel free to amend the commit message as you see fit.  Usually
I would do that myself as I'm rather picky of my commit messages, but,
alas, I'm not versed in portability issues of regexes, so I'm not sure
what the right regexes would be.

