Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A341F404
	for <e@80x24.org>; Sat, 24 Feb 2018 13:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeBXN73 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 08:59:29 -0500
Received: from mail-ot0-f174.google.com ([74.125.82.174]:39529 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBXN71 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 08:59:27 -0500
Received: by mail-ot0-f174.google.com with SMTP id f18so9721109otf.6
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 05:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mYXSN7SD9i0WCG+VN6iFF+5261GJ/5X2Wq3s4X5v4Fg=;
        b=P+Mt6ZeAcHk+DQOGRJ2eiOnNJyFJvrokCnGj8tb+0aVmjrJeQygCEzHRwIldFspphR
         jb3w2tgGRefhvwPhsfdDBnabvG1/sEhTJ7XwHftlA3CyLw8Xo91sGofjL2WOLvxW9pi2
         M5NzN3+rboStwCoEnQZQ7UvcaIDb5AktHmttl0BBWspdxp+Gu6aO0K8xjgYiiHwXw557
         e0UpJy+79Q1+8f0jQSCyFo8MUTlfuVW6K/9s+zDuzM1phVvPYUfM9QIVfQ4OqJnseKSB
         +hefpTbKUXFZDFjXADb5GM4ZXgiFNXRXjZAgBe+XUNwaS+uWXF0LOjPDPqUQD/j6JtbF
         y3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mYXSN7SD9i0WCG+VN6iFF+5261GJ/5X2Wq3s4X5v4Fg=;
        b=HjwskKJDNvdqxusAUYmJwSNUh4SFjMSxnuCeei5oY56aUiAqb3DEl5Ycr2I+h/W2wB
         VmLHQmax4TiAQJyXGf4npYpGkn3PMJPUzGOn7Dp+hvqprWLUOV4xpAtFfrz8zUYBVgTy
         vqujDbNc/uUE1zzG5nC/+5IlpBXKeTykTQxkfeYcBKPQ/DcgqDxe1x+FN0Cw5CZlL9qR
         D7TIpwhXtbhSPDorSvAi38rZ3RTDwmMszH64s6G3EW+sqHDBweZ03esrHlMkw4vPQlGh
         LbtJ6VCA+jLl70JLhfRIxBcXQJMLYtbdKg7MnyIdY0D0NQB6bVJ1QGcCqss/3pqN3n+Z
         Rs0w==
X-Gm-Message-State: APf1xPCphg4Yi84ZMAj4Z5JOtIggD0lP1u3tVk/BFnDYdW02nTVOJ4KT
        fyjuLw/XiSsXuKa+AK+7O6sOXK0dRN58/nRAyoo=
X-Google-Smtp-Source: AG47ELuPIyMDEZa/AWRvE0xl50VjiIfpA0YqGHUANA9CHRzcxL3QIah27rQqlY+u958H1/mtyUXMObf/Em5aZ0FwOBg=
X-Received: by 10.157.81.92 with SMTP id u28mr3653026oti.152.1519480767146;
 Sat, 24 Feb 2018 05:59:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Sat, 24 Feb 2018 05:58:56 -0800 (PST)
In-Reply-To: <xmqq1shbvas1.fsf@gitster-ct.c.googlers.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com>
 <20180209110221.27224-7-pclouds@gmail.com> <CAM0VKjmFEyr4qHdc1qfW0M_RZ7cM9bCfsn-M4Rapzt6CPhZE1g@mail.gmail.com>
 <CACsJy8CWdJJigQSEjGuhoH1URGY8=YSAHiqhaGBZK7Zr8GZUGg@mail.gmail.com>
 <xmqqsh9sx4xk.fsf@gitster-ct.c.googlers.com> <CACsJy8DWwOezWpTVmpndhvhujzGV79uT2RqpZJxcp7oLr7G+-g@mail.gmail.com>
 <xmqq1shbvas1.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 24 Feb 2018 20:58:56 +0700
Message-ID: <CACsJy8CNUG4sWgMiiyD5CPVhoQ4uYvLDBb+RDiyYUNZ0s9N6kw@mail.gmail.com>
Subject: Re: [PATCH v3 06/42] completion: use __gitcomp_builtin in _git_am
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 24, 2018 at 1:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Fri, Feb 23, 2018 at 1:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>> Now that you mention it, the only command that completes
>>>> --rerere-autoupdate is git-merge. Since this is "auto" I don't think
>>>> people want to type manually.
>>>
>>> Sorry, but I do not quite get the connection between "since this is
>>> 'auto'" and the rest of the sentence.  Is it just it is so lengthy
>>> that people do not want to type and are likely to use completion?
>>
>> Well, if it is to be done automatically, I should not need to tell it
>> manually (by typing the option on command line). Granted it's a weak
>> argument.
>
> Perhaps I am not reading what the option does correctly, but my
> understanding is that merge operations:
>
>  - always allow rerere to intervene and auto-resolve in the working
>    tree, as long as rerere is enabled;
>
>  - by default they however do not add the rerere-resolved result to
>    the index, so that the combined diff output from "git diff" can
>    be used as a way to sanity check the result; but
>
>  - if the user says --rerere-autoupdate, they add the
>    rerere-resolved result to the index, letting the user blindly
>    trust it, so that such a trusting user can even commit the result
>    without looking at it by merely making sure there is no path
>    remaining in the "git ls-files -u" output.
>
> The "autoupdate" could be somewhat dangerous depending on your
> workflow, and that is why the user can selectively enable it via the
> command line option (when known to be safe) even if the user does
> not set rerere.autoupdate to true.
>
> So I am not sure I understand "an option to allow something to be
> done automatically should not be given manually" as a valid argument
> at all, whether it is weak or strong.
>
> Or am I grossly confused?

Nope. It's just me not understanding rerere functionality.
-- 
Duy
