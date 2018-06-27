Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CDC1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 02:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeF0CPs (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 22:15:48 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45384 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeF0CPr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 22:15:47 -0400
Received: by mail-ua0-f195.google.com with SMTP id l5-v6so268013uad.12
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 19:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HXnn9BbzeTHOlYksS31Wpl9zfFLkDRAC0m6GhTr7AA8=;
        b=EPOUPGAM4npMynVXF+IwVa7sb550eTC1Uns39+PG3AA9XXsPRTC429B54lcyL5WfKc
         ffd6TrCVtoMHpCQWFDuy2MmyoPWej05tuneSTvPIc5HlyDdyWSJNVmPuiPZcAR6WG14n
         wzDWj8VV+GVfilIQNniXdd+AR44MatuvfXPDkVq3S5VncZ6jxSGToXmtwUhQ6UOirL5K
         OVx/FBiDbBTOPw1m8j5QUWsHslo5Nq8gKDwrmMgUuTBfnpxFd+wvahzPf+AakxN1CwHi
         PO/++2acnyNpiJvYtU5CTCFYcR9F3eBk9RQaVzbG+f25E/7asP06UWNU8rV8e3DmaP1O
         s88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HXnn9BbzeTHOlYksS31Wpl9zfFLkDRAC0m6GhTr7AA8=;
        b=SXb7IARDERXZKcFddvto6nZLpFzpO6aDA1Pdn1JNL2fxukoS9c2FuhJbMqKv+ICLNP
         qc1RF605BYk/OsAOpiW9LgHexeUXOEBBrGrTyrsaqf/v6a4bEM3qrRGfL8+gvt6B9NC5
         UZJeUbY3gM2HkxGhhlo7N8J5kVkRtywna6aJugsZynoJ39yJBsyL0N083B/YpLrrI6dw
         a0uLxc+BlykJ4MD2O9W6bQaCaFesN0cK5k880ZNyAQ7VyX4MQRcxPcZtqX5ER9MZFRl9
         oSLk/Ota6ybm0oea0fZqLIALDz6sntvGrSA4JtJTLbQAYJVfGrSXvtitFtGitnSI9ky0
         U/TQ==
X-Gm-Message-State: APt69E2ph5yjiUAA2vRIdA2Z7dY9R3g5trwZYDWb4cqyyrSSHF55XlYZ
        udtDhOA6MEzXbKljFx+wCx3BolCjh5JOnrHeC4s=
X-Google-Smtp-Source: AAOMgpd1EEdPpmWMpzTol7hpdHzKPP9V03G9QR+/ThFl6hCG/PiM4Vn7flImdsnKIpOd5WNezg6CC2R6S/zmAYvdeso=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr2533372uae.199.1530065746356;
 Tue, 26 Jun 2018 19:15:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2310:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 19:15:45
 -0700 (PDT)
In-Reply-To: <20180626210100.GA3682@sigill.intra.peff.net>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-30-sunshine@sunshineco.com> <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
 <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com>
 <20180626201708.GA2341@sigill.intra.peff.net> <CAPig+cRvgsu-6f+mzjGVDWTVhFrhLY5MsNxEQBJYckKDpeaMAg@mail.gmail.com>
 <20180626210100.GA3682@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Jun 2018 19:15:45 -0700
Message-ID: <CABPp-BHgPgkgQj7i3rZtdbinVZvqH35uGraUK9doL-E8Y5QuSQ@mail.gmail.com>
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 2:01 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 26, 2018 at 04:46:18PM -0400, Eric Sunshine wrote:

>> Some of these dangers can be de-thoothed during the linting phase by
>> defining do-nothing shell functions:
>>
>>     cp () { :; }
>>     mv () { :; }
>>     ln () { :; }
>>
>> That, at least, makes the scariest case ("rm") much less so.
>
> Now that's an interesting idea. We can't catch every dangerous action
> (notably ">" would be hard to override), but it should be pretty cheap
> to cover some obvious ones.
>
> -Peff

Crazy idea: maybe we could defang it a little more thoroughly with
something like the following (apologies in advance if gmail whitespace
damages this):

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 28315706be..7fda08a90a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -675,7 +675,7 @@ test_run_ () {
                trace=
                # 117 is magic because it is unlikely to match the exit
                # code of other programs
-               if test "OK-117" != "$(test_eval_ "(exit 117) &&
$1${LF}${LF}echo OK-\$?" 3>&1)"
+               if test "OK-117" != "$(test_eval_ "cd() { return 0; }
&& PATH=/dev/null && export PATH && (exit 117) && $1${LF}${LF}echo
OK-\$?" 3>&1)"
                then
                        error "bug in the test script: broken &&-chain
or run-away HERE-DOC: $1"
                fi
