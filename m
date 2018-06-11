Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20DB31F517
	for <e@80x24.org>; Mon, 11 Jun 2018 22:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbeFKWIp (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 18:08:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37192 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbeFKWIp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 18:08:45 -0400
Received: by mail-wr0-f194.google.com with SMTP id d8-v6so21978708wro.4
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 15:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ew4Wb9Uktyqxb+bl26k63ujdIw3QTvwzMUQ2x74s8H4=;
        b=rsKODt9SiBGumIXWcBLi42IzjqqXJ3z0zNuCD5q4ev9rvPtHMFWNHhphV9VZtnwKvB
         +tV1UVxmsj3JvAZgxJ8sUvWpMCioWAMvpFDkhMrnOIcCUDEQKQOOD9hyisVL9Cx/ReaU
         B0PgNhf5idZofJEWh/XsnmLOayUmLO2MYo5wnZxxTXe/2TN0Rt5vTRJQsZMkTKvUTJ52
         K7LUMUHlOsar5PRl54gEw2Vq/pvvbdQKdfNubR6/exXbNbCPlS+KwTinKXoVLcEcLAFB
         cyI8+V8cdF2kpdStKt83xZxOoYks3IavrTxN2b95UrdeGdqSvFNVCN352Jh4ZJC5i5dq
         gsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ew4Wb9Uktyqxb+bl26k63ujdIw3QTvwzMUQ2x74s8H4=;
        b=E3NqWBO7HhNNekOBxJV0t1Cp1sEBTTcFmTXgCJQGdd+oHWRIUNgeT6K/2/DFUhXy0/
         JRhBWoQZaPlhq8nrXTBMQNds5+7ORcv6DWTViRugYTh+emwjsymLT9b0ctprwlssJayU
         vsm342pWiCimNdWozjzZGnmeoTKO2Sqw+lVWRx+k6Hc+uiShQ8WRIE6yA2U9Hr2OpJCZ
         OTKy1S5lNS7dDfUzUGbCcLTi1WuDutCk3QTI3I7ckG7xpUBrj7AoAQ6wpl5HII608w4e
         pHzoCwOz/D4v3HEj2wpVmj7vt68XkXIRSMjNWG24bgfQqHbJqrvMugwsnwNDG8uJ+7IG
         a7oA==
X-Gm-Message-State: APt69E1YLSeIIMVJt9mq4FwziQf7DugTxxUKqv/ioS8XEiRCmtWbcTko
        SAcUZe/SOG2LvDl3TxJLJqjh9FSc
X-Google-Smtp-Source: ADUXVKIoQxeetGKUumMYu9OqLK9fbKDml3DHOKtAv5MP3yI569JWteYnGhMv8DZV3gPhIMzpE024Vg==
X-Received: by 2002:adf:b053:: with SMTP id g19-v6mr648449wra.128.1528754923375;
        Mon, 11 Jun 2018 15:08:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f2-v6sm11581294wre.16.2018.06.11.15.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 15:08:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2018, #02; Mon, 4)
References: <xmqqr2lm4pth.fsf@gitster-ct.c.googlers.com>
        <20180604141230.GA26961@sigill.intra.peff.net>
Date:   Mon, 11 Jun 2018 15:08:42 -0700
In-Reply-To: <20180604141230.GA26961@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 4 Jun 2018 10:12:30 -0400")
Message-ID: <xmqqmuw1asd1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jun 04, 2018 at 10:57:30PM +0900, Junio C Hamano wrote:
>
>> * jk/index-pack-maint (2018-06-01) 2 commits
>>   (merged to 'next' on 2018-06-04 at c553a485e8)
>>  + index-pack: handle --strict checks of non-repo packs
>>  + prepare_commit_graft: treat non-repository as a noop
>> 
>>  "index-pack --strict" has been taught to make sure that it runs the
>>  final object integrity checks after making the freshly indexed
>>  packfile available to itself.
>> 
>>  Will cook in 'next'.
>
> This second patch fixes a regression in v2.18.0-rc1 and in v2.17.1. I
> don't know if we'd want to consider it for v2.18 or not (it should be
> able to be applied independently from the first).

I gave the topic -maint suffix, but I'd need a little fix-up patch
on top to actually make it mergeable to the maintenance track.  With
that, let's merge it to 'master' before v2.18 final happens and then
also to 'maint'.


 builtin/index-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7b399478dd..3030c88d38 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1484,7 +1484,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		struct packed_git *p;
 		p = add_packed_git(final_index_name, strlen(final_index_name), 0);
 		if (p)
-			install_packed_git(the_repository, p);
+			install_packed_git(p);
 	}
 
 	if (!from_stdin) {
