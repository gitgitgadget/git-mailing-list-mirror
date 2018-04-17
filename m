Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B02F1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 19:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeDQTfk (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 15:35:40 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33985 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDQTfj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 15:35:39 -0400
Received: by mail-yw0-f171.google.com with SMTP id h14so8487942ywm.1
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Auaw3NiOPa+X2hvyjUNNkHu/Sb3Xt2tuJKUlOtdgeqY=;
        b=A3jJP7lnF4j7mgNRN4VQlj0nZF1BO6TbVosUXEyZ+noMlhzI3XNwWamlM62nizQ8wF
         kpGvbswHsnMZd8oZ2Z0a9RKrezYVjjw50jUZ+hznoE0e5esQKnfmoWjjJZsYPx2AHnit
         kD+ayunbKaCA1q09ga1h2AV8ylBfUO36IXxAapUcPuhYZlQUL9mu57tLw4lkA2TfD01/
         52pc4lDCXE+ORk0JDZL/NIejt9yPvDB/WoD3dYeyDV+P7neOsXNhWTYTrTmaV2SbMBYn
         c6lc30qmfeMn/AsVjJd86kB9zcN0GX7rsh+AUK9YVh7fPHRFD0om8FbxZLIuekgcEL2M
         1fuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Auaw3NiOPa+X2hvyjUNNkHu/Sb3Xt2tuJKUlOtdgeqY=;
        b=kwqfpyRbZU/ircGoS0f6UMZju1JALD/gNi+F8gQSuCyFx01BuJkoow3YYmsUs4xmEp
         k5rVzTzfJTAAuccf8pMNjwFh5oshFBwe+/JR8U/Ld+Xhsl32Ht3unF0vI+EY16LX7BOC
         O9M3mnBfehsVDejNCjdSFKCt2ZW0bMwECsdaw+H6wxczHwfEgBJ9XnA9EI/vN7NuIOrD
         ijo6P/hRKFvBtJT5LHqbekD0jSY9GN7W+DyCnTkkH/0zQRrxo8LRjjXFHnkb9tfDGTfd
         HCTZQUUaZadHeRrgU7osNFsJSXmr4J5w4pl58Vd5PWsNvqPcEiugOvSAPn/QPrEKVm2d
         pgRA==
X-Gm-Message-State: ALQs6tBfc6LX4UdbCwPW6vnZVlVSVbPgrGNxPeQBD7Nr2cdK38v/9qlw
        SR0XeoH1ncd0ZRUUHo1tiinESSRCj+YVemto6r6OBg==
X-Google-Smtp-Source: AIpwx4+2wKI4lhLhtM2UeZmXE1W2ylYnD8nY6dfUJ4h/DxZGQJeWxAVmgrctXvEtMt9JoK8H9QJ7YgjbfRHFHUnfIvY=
X-Received: by 10.129.232.5 with SMTP id a5mr2514187ywm.421.1523993738955;
 Tue, 17 Apr 2018 12:35:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 17 Apr 2018 12:35:38
 -0700 (PDT)
In-Reply-To: <CAGZ79kb+MEJswk9NU3ktr9gAY7XVdCYS-w=e-Qmmp8knSNsHTg@mail.gmail.com>
References: <20180416220955.46163-1-sbeller@google.com> <20180416220955.46163-3-sbeller@google.com>
 <xmqqbmeiv7c2.fsf@gitster-ct.c.googlers.com> <CAGZ79kb+MEJswk9NU3ktr9gAY7XVdCYS-w=e-Qmmp8knSNsHTg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Apr 2018 12:35:38 -0700
Message-ID: <CAGZ79kYjV6Wpzymx1phL7EC3BxdWr5gitCOdE6=fJFFnz4zYiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/blame: highlight recently changed lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 12:31 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Apr 16, 2018 at 8:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> It seems that this
>>
>> $ git -c color.blame.repeatedlines=cyan blame --heated-lines builtin/blame.c
>>
>> refuses to run.
>>
>> Would it work if the configuration is in .git/config instead, or
>> would it forever disable --heated-lines once somebody choses to use
>> --color-lines feature by default by configuring it in?
>
> That is the unfortunate part of this series, I have not figured out how to
> treat these two options at the same time.
>
> One could take the approach to check the config first and see if there
> are conflicts and then overlay it with the command line options
> (and resolve conflicts there, but CLI taking precedence over config).
>
> Or we'd need to introduce another config
> blame.coloring={none, repeatedlines, highlightrecent}
> which breaks the tie.

Nevermind, we can overlay these color schemes just fine, which I'll do in
a resend.
