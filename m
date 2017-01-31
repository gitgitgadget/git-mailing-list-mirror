Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C64C1F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 22:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750935AbdAaWPD (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 17:15:03 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33865 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdAaWPC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 17:15:02 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so29993641pfb.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 14:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=oxaKwc+/FEgRr57UVfAjvrd+8LRvgh/DYSYCNQMBqdo=;
        b=b7WdzVkbewMphMwd9GX9hpFjs45aSByVTwlebwxh1rBceRR33EPwL+kzAw7206719x
         zkdFC19yFT2gBLU6DkSCaY3zIU70IMZF14qM6pocHZ7nFbMOr/giv+QTps2crzFcxGNE
         A2ZufNcd7rbkhh2OIqrk65AtR23cm9weWJeJ14twLp3beOtKvTgCZ1NVgjjHkfVh3Sli
         xkevhWw7HURf40rwwjlgXGXC9VIyMrB85jbRKagJo8shXvYMoblu/C9NgOY4B/EM1YHt
         /+QSYRQn9NuRBmXZzm5YfX3Z3YC5MHZm0FxmNCJ0wEEU5ec/SNs5VM+vh3RY+lv8G4kT
         w9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=oxaKwc+/FEgRr57UVfAjvrd+8LRvgh/DYSYCNQMBqdo=;
        b=cMvWZ4NeRQauHAijBul9dvDZwcqgCYtluRXznjd7mJYTyseuw+BSvQDI0ZOP6AXBoY
         n1S45hrMVUU1iWu0gjWRSoEhe1LQGuNSZOQVCz0TeY728mLL32Kmul2zwrypitznvKGj
         XtVKRaAQ2EkslPtwr53GDlVqSjr3fTeW7dpwOcRQ80qXNsCESAVpCZJXDLuI8I6CrCp5
         BD/TzMs9J2VoQSTakbwFUbY9AhDUWAcVBdnmO7YJjVw7qNanEXX15nkVKGa2pI0MOU1B
         H//onjnyFbCpamHP5YZc8sXUWOui1ZuaS9bHqaiveiu6nwbelR7/kG5AI511Ix3r9Lj5
         hCFQ==
X-Gm-Message-State: AIkVDXI8JdgGcIDKCfTwiT6Dru3ztQ0l+CzxvzABEfb/ZUrwiLrWKj/vNyIHqSJAIOjdhQ==
X-Received: by 10.98.73.74 with SMTP id w71mr31812790pfa.52.1485900387191;
        Tue, 31 Jan 2017 14:06:27 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a052:8a35:4bb5:b253])
        by smtp.gmail.com with ESMTPSA id d78sm43573057pfb.43.2017.01.31.14.06.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 14:06:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Benjamin Fuchs <email@benjaminfuchs.de>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        ville.skytta@iki.fi
Subject: Re: [PATCH 4/4] git-prompt.sh: add tests for submodule indicator
References: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
        <1485809065-11978-5-git-send-email-email@benjaminfuchs.de>
        <CAM0VKj=j8Fy8AQvYbbvwPf5kkV1GYYONADNsQO5RDNTUzdYt8w@mail.gmail.com>
Date:   Tue, 31 Jan 2017 14:06:25 -0800
In-Reply-To: <CAM0VKj=j8Fy8AQvYbbvwPf5kkV1GYYONADNsQO5RDNTUzdYt8w@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Tue, 31 Jan 2017 19:32:45
 +0100")
Message-ID: <xmqq37fyriji.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Mon, Jan 30, 2017 at 9:44 PM, Benjamin Fuchs <email@benjaminfuchs.de> wrote:
>> Signed-off-by: Benjamin Fuchs <email@benjaminfuchs.de>
>> ---
>>  t/t9903-bash-prompt.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>
>> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
>> index 97c9b32..4dce366 100755
>> --- a/t/t9903-bash-prompt.sh
>> +++ b/t/t9903-bash-prompt.sh
>> @@ -37,6 +37,11 @@ test_expect_success 'setup for prompt tests' '
>>         git commit -m "yet another b2" file &&
>>         mkdir ignored_dir &&
>>         echo "ignored_dir/" >>.gitignore &&
>> +       git checkout -b submodule &&
>> +       git submodule add ./. sub &&
>
> ./. ?

Good eyes.  This is a pattern we are trying to wean ourselves off
of.  E.g. cf.

    https://public-inbox.org/git/20170105192904.1107-2-sbeller@google.com/#t

Hopefully this reminds us to resurrect and finish the test fixes in
that thread?
