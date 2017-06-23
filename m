Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB2B2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 15:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754172AbdFWPMe (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 11:12:34 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35371 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbdFWPMd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 11:12:33 -0400
Received: by mail-it0-f67.google.com with SMTP id f20so7518823itb.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PN9mwZ17TwiuOC4xeGy2MpkcERBNqgddnlTMYGOXVYs=;
        b=EqK5lMKvtmK9O/88aq5KDtqef8PUvvEQkEe9ejjQW7QV6qtFgg6W4NVR2p6BMpXwyV
         x6fexmWwDlDSCiYCXxm2iDldpVuoWkHofQuImF54Ayl9ov1aG7UTWSm7o6iLsrTVhITw
         yLfyT1GswWAFsRIln7v/AP/63d2Yy+DUUP8YT3eGD9sTkF7vbI0QX4Cp37UDbSlmDWpl
         1YsdEzLgSYhWBCxtPCXUSwOObNcRblRE3SREzoNG/a7nOM+boDgU5KwSTx/j8K/TzUJu
         3y0WPQigyZw1/XqfOJMdiYL3dGdaVmwLVyGOSA98+0OH2bONGpl903m2FGGPs/Z3e5lO
         kHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PN9mwZ17TwiuOC4xeGy2MpkcERBNqgddnlTMYGOXVYs=;
        b=REFOHhwbPEsDVQm71HzKht5iJIUvoMcK/P5siqK8c3kMxQS0YQPmn6eh0GPS9En3KW
         xMq3mFqDMjC7con2q8SEepKj1VNwk2lfATpJX2Seb9SL+HX/WTSMUwBve4dAIC+F+KZD
         YWogcDezgOfTka4BWEhyB69SmzkURQkYxRt71UGDxFM4N++/Cq9MwGWtAi5zdIZ5wlzU
         6yN6xxqU5EJs8qNthLBvnC37rZzFvD72kH4lkrKS+vJkkpal8F6KKg0cZln95Vjh4zwC
         +C7wvPWgMZ1X1YTVD5ei/iKjgEh2psXn6+7QLkxzWkOvBUiWHUVtKA5tjDCrigWW9KEp
         kT5w==
X-Gm-Message-State: AKS2vOz+JZLL7aVogLSoekCw6N8/Drh4OtzFaLKgiukk5YT4ROijGrWJ
        KEsquDIFp6VlmrVpbmtRNEQf4+/FHA==
X-Received: by 10.36.210.194 with SMTP id z185mr7520379itf.112.1498230752803;
 Fri, 23 Jun 2017 08:12:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Fri, 23 Jun 2017 08:12:32 -0700 (PDT)
In-Reply-To: <455cbce5-97eb-2fdc-6e38-b4feb4daaa6e@ramsayjones.plus.com>
References: <20170622190158.13265-1-chriscool@tuxfamily.org>
 <20170622190158.13265-2-chriscool@tuxfamily.org> <xmqq4lv7kdfa.fsf@gitster.mtv.corp.google.com>
 <455cbce5-97eb-2fdc-6e38-b4feb4daaa6e@ramsayjones.plus.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 23 Jun 2017 17:12:32 +0200
Message-ID: <CAP8UFD0HTpAN04YU=zqUYudXdNWEq19grVgO1WLAN9SxpN0xug@mail.gmail.com>
Subject: Re: [PATCH 2/3] t1301: move movebits() to test-lib-functions.sh
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 1:09 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 22/06/17 20:52, Junio C Hamano wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> As the movebits() function can be useful outside t1301,
>>> let's move it into test-lib-functions.sh, and while at
>>> it let's rename it test_movebits().
>>
>> Good thinking, especially on the renaming.
>
> Err, except for the commit message! :-D
>
> Both the commit message subject and the commit message body
> refer to _move_bits() rather than _mode_bits() etc.
> (So, three instances of s/move/mode/).

Yeah, sorry about that. This is fixed in the version I will send
really soon now.
