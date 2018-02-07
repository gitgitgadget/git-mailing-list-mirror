Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6D21F404
	for <e@80x24.org>; Wed,  7 Feb 2018 19:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754867AbeBGTto (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 14:49:44 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42017 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754301AbeBGTtm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 14:49:42 -0500
Received: by mail-wr0-f196.google.com with SMTP id 41so2342333wrc.9
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 11:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZcoymGFIJ6fl3IDDoIFyE5ZB4lu9U4gRY4KQYjn0Rlg=;
        b=iCnHZTnBwS1Rs24COVB7R6zt/sPzlpJldNeADAzf+gsNv1qr/m/cYodyujeMyTast5
         aCYSJEzhB6WNmlJ/oO0EG+xCeIdfYIGodj2prLyOLZsOJDmAU5zYvkCN3P4gc98dHSdS
         NcEuXSU9/ZeYY35RqV8zoMIhPnGLFkXiHZ5x6wf/FMbIdQgFw8PYUqXhzy4TojNCs0pK
         Xo+WnV57w9IwYCydSK3qBmrk/44oQx/lGmshHVudlem9gwvitslRbwT16LypCtObv8uj
         NLsSdDV2CxoAJhcZ9t4msbIQu88+W8sOvxyJQnCGO0vzFrC/9tpSHX0pqaivUVZTKUWa
         PGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZcoymGFIJ6fl3IDDoIFyE5ZB4lu9U4gRY4KQYjn0Rlg=;
        b=WB56Y1wYHBtaQSJ5+8khcyNgC909OVRqXkdqP+bgPhIHCmyXcTi92ZoP0DgMo6hJbk
         brN/2ZC+epa4ziPjqdfkb/GPl4bFH6Cb27dzVON1B4QTuAakAN4weEAdRG+6hUSqiuLM
         2jFURnkyNI2T4l88Y0XD6P0Meg1T3DEERgiBSq+eMJvzjIOZThUs+UZe2PxRKTApycnL
         yKCnkt3dijGNHvqcUjBK7DlLb4uH4gUFFeKCS9Hob6ZESb0kx5qkQ3oubXh8wh0/hg0x
         Z+HKfltzoZcqsZUez4/Nf2hHXtGPbOQA+YGJZiMX2LM4MW32Td2yUNDiceTJLglnu3L9
         6ETQ==
X-Gm-Message-State: APf1xPA72YGGsUGPEXcC0UD597WQerVGop1k7jNy/liOdNApQ/CezZUY
        fA9AlUiGMgtDreeNyRsX56U=
X-Google-Smtp-Source: AH8x2255egHTjEJHt747cVb3sS8nmlNf8OBFoVmavcckwpDlL7sFktGJI2ldrwkvTWjiL0gCQQuocw==
X-Received: by 10.223.142.105 with SMTP id n96mr6320178wrb.54.1518032981094;
        Wed, 07 Feb 2018 11:49:41 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e67sm6523699wmf.7.2018.02.07.11.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 11:49:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Moch <stefanmoch@mail.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Simon Doodkin <helpmepro1@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: Re: feature-request: git "cp" like there is git mv.
References: <20171216013130.GB188893@aiede.mtv.corp.google.com>
        <20171231191156.28359-1-stefanmoch@mail.de>
Date:   Wed, 07 Feb 2018 11:49:39 -0800
In-Reply-To: <20171231191156.28359-1-stefanmoch@mail.de> (Stefan Moch's
        message of "Sun, 31 Dec 2017 20:11:54 +0100")
Message-ID: <xmqqinb87f70.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Moch <stefanmoch@mail.de> writes:

> * Jonathan Nieder <jrnieder@gmail.com> [2017-12-15T17:31:30-0800]:
>> This sounds like a reasonable thing to add.  See builtin/mv.c for how
>> "git mv" works if you're looking for inspiration.
>> 
>> cmd_mv in that file looks rather long, so I'd also be happy if someone
>> interested refactors to break it into multiple self-contained pieces
>> for easier reading (git mostly follows
>> https://www.kernel.org/doc/html/latest/process/coding-style.html#functions).
>
> I looked at builtin/mv.c and have a rough idea how to split it
> up to support both mv and cp commands.
>
> But first I noticed and removed a redundant check in cmd_mv,
> also added a test case to check if mv --dry-run does not move
> the file.

I guess these two patches went unnoticed when posted at the end of
last year.  Reading them again, I think they are good changes.

As a no-op clean-up of a127331c ("mv: allow moving nested
submodules", 2016-04-19), the attached would also make sense, I
would think.

Thanks.

 builtin/mv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 9662804d23..9cb07990fd 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -266,10 +266,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		const char *src = source[i], *dst = destination[i];
 		enum update_mode mode = modes[i];
 		int pos;
-		if (show_only || verbose)
-			printf(_("Renaming %s to %s\n"), src, dst);
-		if (show_only)
+		if (show_only) {
+			if (verbose)
+				printf(_("Renaming %s to %s\n"), src, dst);
 			continue;
+		}
 		if (mode != INDEX && rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;

