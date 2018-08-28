Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88A31F404
	for <e@80x24.org>; Tue, 28 Aug 2018 17:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeH1Vbk (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 17:31:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39217 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1Vbk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 17:31:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id o37-v6so2338422wrf.6
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dj3BlDZVviv6PJ+3ZcqcoqlNwTDDzgZfsonlIcNtJDI=;
        b=lX5JgK66OXsO9xWUA3u0OkGiuouw3aI1IFORnHeoz1omiECFsCtcrV7n1+RgcKSwtZ
         W5D76icajiZ33a3dEgbbHKwzKhLJDs1tVof5BUGHDGgHfMd9h1yhX9PqPS2JQnf7KS6Y
         6x4F83VveBN6keIehHWvJ03osW6jJK4WHgfY/EszcwVdHiaWFpevv7AbZymTDG+mLNOK
         VYS+O7B5Z7SEgiVzeo5I3zQRcY1ly7MIcXfLQi/BeEC/6lCqObyueXmapcDav9LIJqiP
         UI213/vi1CbBge3hhg85kBS0L9IunXm90Z7Foy4BJHOIlPBTzj9lP1n7RC3aZWHCS2h3
         sYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dj3BlDZVviv6PJ+3ZcqcoqlNwTDDzgZfsonlIcNtJDI=;
        b=LUK8h54lp7djqigRqb0afgNQ895fD0iH75sS1pQxPduOplNcRyBBqiRrMMAU1dXKD9
         jDj7f7rzqMZ5TEWXuXk6MLtJSooFNflcR5hclpaEK+SzPes82uMLshRpBPzn74hY+U6u
         yf749SbZsfe7APvZ/azl1XpnI2Z6A03f0vcVXT+x733lybeqUIQi1Ns14kjgtBLqMvjF
         N+/o5QOozVqM/YPcE4x1eGZN0goTyV5Mfc248olbOvu9oP9Rb2p9z/iECJNfzq4jZEQc
         0QMEnfcwyld+j0t1RRQ3KYUQ5c+A/uaDN7zFgsig4FshDNHVZDgZ6hPbfdUBMbWsT/CY
         YUvw==
X-Gm-Message-State: APzg51ACY/0uu04v4VhFmGDsRTn3i4I4DYYuDOBGa12XL0JCJ9MgBHG2
        saQIz4tuOrrJgPVz4O0gkv8=
X-Google-Smtp-Source: ANB0VdYMxtgkwSvyO/y3UvESrc8yOb4rQ/D3gEKwSjZaZMyluC8KQHDzhOxqFukMlsBwaqKgWCoZiA==
X-Received: by 2002:adf:e1c5:: with SMTP id l5-v6mr1883173wri.36.1535477936055;
        Tue, 28 Aug 2018 10:38:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y184-v6sm3056226wmg.17.2018.08.28.10.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 10:38:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 00/25] RFC: structured logging
References: <20180713165621.52017-1-git@jeffhostetler.com>
Date:   Tue, 28 Aug 2018 10:38:53 -0700
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com> (git's message of
        "Fri, 13 Jul 2018 16:55:56 +0000")
Message-ID: <xmqqd0u2gzma.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> This RFC patch series adds structured logging to git.  The motivation,
> ...
>
> Jeff Hostetler (25):
>   structured-logging: design document
>   structured-logging: add STRUCTURED_LOGGING=1 to Makefile
>   structured-logging: add structured logging framework
>   structured-logging: add session-id to log events
>   structured-logging: set sub_command field for branch command
>   structured-logging: set sub_command field for checkout command
>   structured-logging: t0420 basic tests
>   structured-logging: add detail-event facility
>   structured-logging: add detail-event for lazy_init_name_hash
>   structured-logging: add timer facility
>   structured-logging: add timer around do_read_index
>   structured-logging: add timer around do_write_index
>   structured-logging: add timer around wt-status functions
>   structured-logging: add timer around preload_index
>   structured-logging: t0420 tests for timers
>   structured-logging: add aux-data facility
>   structured-logging: add aux-data for index size
>   structured-logging: add aux-data for size of sparse-checkout file
>   structured-logging: t0420 tests for aux-data
>   structured-logging: add structured logging to remote-curl
>   structured-logging: add detail-events for child processes
>   structured-logging: add child process classification
>   structured-logging: t0420 tests for child process detail events
>   structured-logging: t0420 tests for interacitve child_summary
>   structured-logging: add config data facility


I noticed that Travis job has been failing with a trivially fixable
failure, so I'll push out today's 'pu' with the attached applied on
top.  This may become unapplicable to the code when issues raised in
recent reviews addressed, though.

 structured-logging.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/structured-logging.c b/structured-logging.c
index 0e3f79ee48..78abcd2e59 100644
--- a/structured-logging.c
+++ b/structured-logging.c
@@ -593,8 +593,7 @@ void slog_set_command_name(const char *command_name)
 	 * the cmd_<command>() and/or it may be too early to force a
 	 * lazy load.
 	 */
-	if (my__command_name)
-		free(my__command_name);
+	free(my__command_name);
 	my__command_name = xstrdup(command_name);
 }
 
@@ -606,8 +605,7 @@ void slog_set_sub_command_name(const char *sub_command_name)
 	 * the cmd_<command>() and/or it may be too early to force a
 	 * lazy load.
 	 */
-	if (my__sub_command_name)
-		free(my__sub_command_name);
+	free(my__sub_command_name);
 	my__sub_command_name = xstrdup(sub_command_name);
 }
 
-- 
2.19.0-rc0-48-gb9dfa238d5


