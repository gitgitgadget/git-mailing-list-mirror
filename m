Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5BB31F407
	for <e@80x24.org>; Wed, 13 Dec 2017 23:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750886AbdLMXq1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 18:46:27 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:46166 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbdLMXq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 18:46:26 -0500
Received: by mail-wr0-f177.google.com with SMTP id x49so3614587wrb.13
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 15:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VLSRHgGTJ1bOeQta9cNvik+dJW3vHWc7q3YeG5/uuIU=;
        b=JrAEwxg4bnAHXIoDSygRgXDkxBVMSK3BJBdLCfHczW9CcP0O2LMcF2lCNOlLXzB2af
         5H1pTHstR9bfz7Rm8TYVNu3ux88NmzNSfU732m11zFKrKfYIqd3LMEhiv810HlDD9VfV
         V1hVUT15T2k/+4pLy/FGBoVwEhiLwH6jw83Ebq/UXBSGuWiyWenAi+faN0jNBS9QYgFt
         +b8pqR532r00VNcJTDuc+KS0eH/sVsb781Hi824UL2lkpzw2Yw6NgBLSPgCR/yd9S4h0
         S5NIwXQY8EXAeK9TzKm0iv+QccHeES9rZ3SXv9bS8hNpKsu2WAK+Du73oAlA1ht2hwsU
         D1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VLSRHgGTJ1bOeQta9cNvik+dJW3vHWc7q3YeG5/uuIU=;
        b=uKTXtAScgekuIdpMIrklF4SWgGcCsTJ8kuK0bgj7Pazvy9XrWk4/IUftlGmxWC9Fip
         YAQ/gDql92/bZBiEA3uEYCvVtGI8hznPK/KgYsngLTpIDMVNIuzJYa3w/lde7H1Nzg9n
         7VKC6/TnlMYiAzxv6twB23t6M0HrtA8vilc38RDYtXJ4OtMRWs7noV/ntwc5dsfSyeEj
         ZkQgA6QbUUWWf4B4G47dL4SpDsQq49NbLrXj1ah/fYueflfgjyW5L33fmktCobrG6p0M
         BwPDMmTg8niRJ3gzk0MJ/GjbfqSmI6lrf4xkyVHXyEKlhb9WMbTFQ8OgJ0PdMOZKpPE1
         9MHw==
X-Gm-Message-State: AKGB3mJR4knHHssYxYx4jwVP5ZX4ZUt9pME6midfgxz8bopROqv7m2q+
        E8dpFxD97M2UeL65JjFLT9XERPAW
X-Google-Smtp-Source: ACJfBotraQaD4ZtSAKA9/k2ZLIMPG4KL55qML+ScY9zGe1L0jWo7RAZHlNTQSpMYe9Z24je7ff8bsQ==
X-Received: by 10.223.171.13 with SMTP id q13mr3990014wrc.120.1513208785103;
        Wed, 13 Dec 2017 15:46:25 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id t65sm1615297wmt.39.2017.12.13.15.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Dec 2017 15:46:24 -0800 (PST)
Subject: Re: Apparent bug in 'git stash push <subdir>' loses untracked files
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Reid Price <reid.price@gmail.com>, git@vger.kernel.org
References: <CA+HNv10i7AvWXjrQjxxy1LNJTmhr7LE4TwxhHUYBiWtmJCOf_A@mail.gmail.com>
 <0692d5b8-5fc7-c34c-0712-11a913267441@gmail.com>
 <20171213231414.GD24597@hank>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <ee9e6b8b-278e-0b86-cd35-c5d490ed7700@gmail.com>
Date:   Thu, 14 Dec 2017 00:46:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171213231414.GD24597@hank>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On 14/12/2017 00:14, Thomas Gummerer wrote:
> 
> > For what it`s worth, using `git stash save <subdir>` instead seems
> > to (still) work as expected...
> 
> I think that depends on what you expect ;) 'git stash save <subdir>' 
> will create a stash of the whole working directory with the message 
> "<subdir>". So while it would indeed work for the presumably 
> simplified example Reid provided, it would not do what you'd expect
> if there are any tracked and modified files outside of the <subdir>.
> 
> In that case 'git stash save <subdir>' would include the tracked
> files outside of <subdir>, while what I assume Reid wanted is to keep
> them in place, and only stash the files in <subdir>.

Indeed, I didn`t pay enough attention to the fact that even `git 
stash save\push` produced different output messages, the difference 
being exactly automatic (push) versus provided (save) stash message.

And I did use `git stash save <message>` in the past... :$ Not too 
often, I guess.

> > but on the other hand, `git-stash`[1] manpage seems not to mention
> > this usage ("save" with "pathspec")?
> 
> "stash save" with "pathspec" doesn't exist, and it will probably
> never exist. We decided to introduce a new "push" verb for 'git
> stash' because the command line for 'git stash save' takes a message
> as its last argument, instead of taking the message with a -m flag
> like other commands do. Introducing a pathspec argument for "git
> stash save" would have either broken backward compatibility, or it
> would have had some syntax that's very inconsistent with other git
> commands.

Yeah, I`m aware of the "transition", thus teaching myself to use `git 
stash push` lately. That`s also what made me curious to try out the 
"old" `git stash save` behavior, but obviously in a bit hasty manner.

Sorry for the confusion, and thanks, for both clarification 
and your work.

Regards, Buga
