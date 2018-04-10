Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3911F404
	for <e@80x24.org>; Tue, 10 Apr 2018 00:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeDJAsg (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 20:48:36 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:46237 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeDJAsf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 20:48:35 -0400
Received: by mail-ua0-f177.google.com with SMTP id a17so6239451uaf.13
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 17:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=fWCBn+kItrikxUbDE6PJhe+y2DpbgHsKX1IizLUlVBw=;
        b=uPa742PhbUeWdtpcMDd1htXMXzc60evMj3Oj5wcCao19mvqTTojtTM9/tMwtwv+YNW
         sV9GGLgGuva+8QGtGvWMmuLtJ7HW0sajBgXym+izGmcLNux9gyF9K2WXzGbGkDxfYei/
         Q0hBaXz1RVdmLt2Cp7Dc8VS/udsPU8a690fxi5KyGMtHnvi9yq72TXfbPDQMJ6/I1Utb
         TLldfMQ+ZJbG4bzLIFM5MM5a1mW5CBsS5d2D7o4RlVoWuaz3r4IjCuhW8Bq9lxnN0EMV
         UPMCFXe98KyfD8G77He1A5jukwODnnz6OBlwwPSHBwn5y+ZhgIIgsvzm9b+Z94V8WUGx
         LeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=fWCBn+kItrikxUbDE6PJhe+y2DpbgHsKX1IizLUlVBw=;
        b=t7I4cyxqeQVNIkbA1xhQLmhGwurzjWfgKQy8t7kjqJQgew8AjFcdQtmobdoD/aYT85
         vdRvrxePDlaL7Qq9IJBl05P2XV9URrigTPl9Msm+U+bVGhKPDBThOzRM/vM73giMUFEx
         WiOVq6PuFsc+uS/l6gISxLR3lSiPSm5dJZMCtiAd4F7VnavB5uWSLU6sbmWgy5bFoJUu
         X42BlGb2frjI2RP0bVdGNuJUWmO+oDm5i1D7Hm1b4e7AQrTITB1VbopiS8PdJFWsnNBK
         m292u3WtnyTaiy4MMsMZCKlKRVpGkltzazx+j+R1UbVCZezZfXa2hrHGvjjfRCdlE3Zd
         EGYg==
X-Gm-Message-State: AElRT7HbgizdoX1xBJSRPzZtf/HlKy7GZAkuxxLLFugyHmhUG/rq3Vg9
        CUCfq99nmxMOMoIDOsZhRuueHv38/2HV9/bWpGq0NQ==
X-Google-Smtp-Source: AIpwx49mG/Hu/UyAve8l3iwRckgsm/vBSk1QQabXPscWtUDzC/6pawykjLAJxCERsEQwRa1cCxqMq+YGd3G4UkyiuiU=
X-Received: by 10.176.10.152 with SMTP id d24mr25267498uak.154.1523321314515;
 Mon, 09 Apr 2018 17:48:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.40.42 with HTTP; Mon, 9 Apr 2018 17:48:33 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804092316280.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405174935.598-1-newren@gmail.com> <20180409185136.4880-1-newren@gmail.com>
 <nycvar.QRO.7.76.6.1804092316280.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Apr 2018 17:48:33 -0700
Message-ID: <CABPp-BF4x-ppjptq1TBj+VicvGeWGbfj4e3f5ne_13AEKmvSQQ@mail.gmail.com>
Subject: Re: [PATCH v2] Make running git under other debugger-like programs easy
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Re-sending, making sure the annoying rich text mode isn't turned on
in gmail...]

Hi Dscho,

On Mon, Apr 9, 2018 at 2:19 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Elijah,
>
> On Mon, 9 Apr 2018, Elijah Newren wrote:
>
>>  debug () {
>> -      GIT_TEST_GDB=1 "$@" <&6 >&5 2>&7
>> +     case "$1" in
>> +     -d)
>> +             DBG_FLAGS="$2" &&
>
> Maybe we can find a way that does not require setting a variable other
> than GIT_DEBUGGER? After all, DBG_FLAGS will be visible to the script
> calling `debug`...

I guess we could instead do a
   export GIT_DEBUGGER="$2"
here.  Short of explicitly using 'export', I think we'd need another
environment variable.

I would have stuck with your original suggestion, except that by running:
    GIT_DEBUGGER="$1" debug_aux "$@"
GIT_DEBUGGER would be set within the debug_aux function and would NOT
be set once bin-wrappers/git was called, making git not run under the
debugger as desired.

>> +*)
>> +     GIT_DEBUGGER_ARGS="$GIT_DEBUGGER"
>> +     unset GIT_DEBUGGER
>> +     exec ${GIT_DEBUGGER_ARGS} "${GIT_EXEC_PATH}/@@PROG@@" "$@"
>
> It may not be a big deal, bug GIT_DEBUGGER_ARGS (if it was exported e.g.
> by the user calling the script) is now visible by the called process... (I
> thought I had tried my best to avoid such a leaking variable in my
> patch...)

You had a separate, per-process variable:
GIT_DEBUGGER_$$="$GIT_DEBUGGER"

The problem with that line is that the $$ apparently makes bash treat
it as a command to run rather than as a variable and a value with the
desire to set one to the other.  Prepending the line with 'declare' or
'local' or perhaps 'readonly' would fix that, but those aren't posix
and my reading suggested that while some other shells did support some
of those builtins, the support was somewhat spotty.  Since
wrap-for-bin.sh runs under /bin/sh, not /bin/bash, I didn't have a way
of making the per-process piece work and just fell back to a separate
variable.  Maybe we want to change that script to /bin/bash?

Do you see any alternatives I'm missing?

Thanks,
Elijah
