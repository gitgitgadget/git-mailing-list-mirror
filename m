Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB44C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbiCJN3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiCJN3K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:29:10 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99AC427DE
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:28:08 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r65so3254894wma.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jU5s4UOII3zwlUYKxqh9SbL5Z72f49bLfvKH5+zQAbI=;
        b=c6eau1JVEpmZkEcdbg6aUMCb+wfiUkdfPkmhkYjwCASdvQ6mxUwWtdKpVpdtLa9Pru
         V+4aJj8HJCARhmxbWMZVi+hksv9XUBBvcorLeKABDOQgaG9kVBGDCxZzk4yM1ep4p0LA
         85AE0R374IeJO5bb14HoHMSDeAJgnuu+/YQ5mUc3sWVro3/rCuI6fjPsRTEDPJjPs4AF
         bMOACY2a4PreRAQI71rHpXLg2Ib6pZGXz5NQ9Q6wdCtC3NqvkiLv5Nrr80c7GADHC6HZ
         xevEe5zSf9r4F3WRx5pLgiJUyZXaa6xIPqZqHccwdRLGbmcX8eZcABLb3VcOL/O44Yus
         LWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jU5s4UOII3zwlUYKxqh9SbL5Z72f49bLfvKH5+zQAbI=;
        b=ZFv03RD/2NLy5MPCH8zcP1mGOBDyJMBeJXJcdEVecPv/SHsFDx6lWm2bUwiwNvEEb0
         wNP+Cbd3wEPNURTcE1dyseW/D8rVgdvKr3gdUYGr8WqZeTJXoAx56SwbxnEkmP9bScmf
         Kz1s5KCLU7j6EDIO0UyuMiTx2XidKCkhqzreHH9eiizIe+N4F7UF6MonwsssV7NJvgDX
         y/Vq3IIYr44+Pjx8Dn/oz/6gllXpi0ihLvRE3EsUoZGJIjpDrkdoG/b4CLU0B/JLnaKW
         TuBvEESVPt+Bnhz5RZgB4AxFoz2+AaF8o8L7vVVKWYR03hhMaQgU41JkjinJzXKXkUBo
         7Y1Q==
X-Gm-Message-State: AOAM533+7f2FiIPvYBAzjLIakK7PgklibWs9MPSPi6Mvngkp7fjPIqtW
        UkdzLXCn4nuXc0SlEKEV6UM=
X-Google-Smtp-Source: ABdhPJw8IlJCYGCQELbnhSObY67voHG0zFu2vgm/9OiCu32t4Q4UvkZMF4jSQSvJLAUtPpkEunFCuA==
X-Received: by 2002:a05:600c:3506:b0:389:d567:e9fa with SMTP id h6-20020a05600c350600b00389d567e9famr3616726wmq.74.1646918887370;
        Thu, 10 Mar 2022 05:28:07 -0800 (PST)
Received: from [192.168.1.201] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.googlemail.com with ESMTPSA id w7-20020a1cf607000000b00389a5390180sm4638961wmc.25.2022.03.10.05.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 05:28:06 -0800 (PST)
Message-ID: <93d197db-c52c-101b-bdb0-3b4c9b073705@gmail.com>
Date:   Thu, 10 Mar 2022 13:28:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/4] builtin add -p: hopefully final readkey fixes
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220309110325.36917-1-phillip.wood123@gmail.com>
 <xmqqilsmlo31.fsf@gitster.g> <xmqqzglyk89e.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqzglyk89e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 09/03/2022 23:37, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>> These patches are based on 'pw/single-key-interactive'
>>
>> Is it still true, or does the base only apply to v1?

The base is unchanged but does not seem to match
pw/single-key-interactive. I'm not sure what happened there. They are
based on 300db53b37 ("add -p: disable stdin buffering when
interactive.singlekey is set", 2022-02-16) which is the second parent
of e53fb7aa3f ("Merge branch 'pw/single-key-interactive' into seen",
2022-02-20)

>> $ git checkout --detach pw/single-key-interactive
>> HEAD is now at ac618c418e add -p: disable stdin buffering when interactive.singlekey is set
>> $ git am -s ./+pw4-v2-add-p-single
>> Applying: terminal: use flags for save_term()
>> Applying: terminal: don't assume stdin is /dev/tty
>> Applying: terminal: work around macos poll() bug
>> error: patch failed: compat/terminal.c:397
>> error: compat/terminal.c: patch does not apply
>> Patch failed at 0003 terminal: work around macos poll() bug
>> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>> When you have resolved this problem, run "git am --continue".
>> If you prefer to skip this patch, run "git am --skip" instead.
>> To restore the original branch and stop patching, run "git am --abort".
>> $ exit
> 
> I think I figured it out.  A merge of pw/single-key-interactive into
> a recent tip of 'master' wants the "return 0" in the preimage below
> to be "break" in compat/terminal.c
> 
> 
>> @@ -397,12 +433,7 @@ int read_key_without_echo(struct strbuf *buf)
>>   		 * half a second when we know that the sequence is complete.
>>   		 */
>>   		while (!is_known_escape_sequence(buf->buf)) {
>> -			struct pollfd pfd = { .fd = 0, .events = POLLIN };
>> -
>> -			if (poll(&pfd, 1, 500) < 1)
>> -				break;
>> -
>> -			ch = getchar();
>> +			ch = getchar_with_timeout(500);
>>   			if (ch == EOF)
>>   				return 0;
>>   			strbuf_addch(buf, ch);

That looks good to me. However unfortunately there are some semantic
conflicts as well. The patch below is based on 6b1f77214c ("Merge branch
'pw/add-p-single-key' into seen", 2022-03-09), hopefully Thunderbird wont
mangle it. Whilst preparing the fixup I realized I need to reroll to
fix a closing stdin in patch 2 and resetting the job signals on error in
patch 4. What's the best base to use when rerolling?

Best Wishes

Phillip

---- >8 ----

From: Phillip Wood <phillip.wood@dunelm.org.uk>
Date: Thu, 10 Mar 2022 11:05:26 +0000
Subject: [PATCH] fixup! Merge branch 'pw/add-p-single-key' into seen

---
  compat/terminal.c | 3 ++-
  editor.c          | 2 +-
  2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 3172f4f408..d1ed5c07dc 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -141,7 +141,8 @@ int save_term(enum save_term_flags flags)
         if (term_fd < 0)
                 return -1;
         if ((flags & SAVE_TERM_DUPLEX) && !is_controlling_terminal(term_fd)) {
-               close(term_fd);
+               if (term_fd) /* avoid closing stdin */
+                       close(term_fd);
                 term_fd = -1;
                 return -1;
         }
diff --git a/editor.c b/editor.c
index 6c5c95e6a2..192d6ea75d 100644
--- a/editor.c
+++ b/editor.c
@@ -55,7 +55,7 @@ static int prepare_term(const char *editor)
  
         git_config_get_bool("editor.stty", &need_saverestore);
         if (need_saverestore)
-               return save_term(1);
+               return save_term(SAVE_TERM_DUPLEX);
         return 0;
  }
  
-- 
2.33.0.342.g580a6b0edd
