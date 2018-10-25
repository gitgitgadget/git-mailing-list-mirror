Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB1281F453
	for <e@80x24.org>; Thu, 25 Oct 2018 07:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeJYPm2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 11:42:28 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50702 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeJYPm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 11:42:28 -0400
Received: by mail-it1-f195.google.com with SMTP id k206-v6so424929ite.0
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 00:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KpzFra14Fy5eDYmY7qh4hyMsYFx/S1surUqrKoj/Awo=;
        b=MKBZp4qfPZPAHg4DemBTB7pnWv/pfXvEeK15TEF7Vh3Qh+vYgTygQ7dklN41UuA4xD
         Gtun3U1S/abGSi5WLKXG9FaEAV+nWwNVqovlZvjce8Z8/K+b1SF44d8tScIbBupSSBQR
         Ot2BrExQ7aM29zWJ+SURPj1exjIcYG5iiq+vDgTsqw1QjFNImW0So68CPpTujOABTiSA
         ergjse4Tv7tDG9VGHl2OV2hkevSMKgnvuzFxkFCdKfGz0Ji09+EDpzoPKLFDwqmcz911
         rwbVYrj1rDmRr4Rat0sKig7/BK32SiV2yyQ4Vcb/GaGtmra/rhQy1rgj1ZRp+ZrlakG8
         1A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KpzFra14Fy5eDYmY7qh4hyMsYFx/S1surUqrKoj/Awo=;
        b=QgxVNTKrbMDjAG9g6IRcfO/Ipg/2/9+jYVP6gIhztRkZXOpG3mYIkw86qRkBuIWhKb
         +yudgPTM2tpzopH3kxzFLfaDGC5Y0Tg+zAFfaI+dSQsfwMQz52IeC+KUwwdMhN7nVUSt
         750qvSO/JRwa/iOc1XhZV5tHDaupogaMz6GiBv7hgI3MgQMpUdMP7b4KsQg9p0LZWtHK
         qupooYYwfTvpzn7VmMrc8V7seBdJiN2r591UjkkaE304KRPu1Khdu9GsURJpz+8Pt+Ee
         IMWb4f1vpx7b3dqjaT0/lvnz5NaTmFI0aA+AC9W3TTz8kZLTk0SHXB9JGtjolxbVc5T/
         ERuw==
X-Gm-Message-State: AGRZ1gL0xuM4l3VqGjVvG0MMGeZVXc+M0Tt92CeZ5xbtghUJEZFQd6tm
        VEeQhsRGtmUQV/qf8Eb1AlEyBjiy1n+jJyNhrxU=
X-Google-Smtp-Source: AJdET5ce3XGUBHkAb0GEWpZPN08FTBHYxDKDL5Ic2/AZgHO5u31z6MXgfkm9TJ1PShp6ozJjrY7nz+dFHxMlX2ed/0w=
X-Received: by 2002:a02:5841:: with SMTP id f62-v6mr276838jab.4.1540451461284;
 Thu, 25 Oct 2018 00:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181025001406.6729-1-carenas@gmail.com> <xmqqlg6mk2pd.fsf@gitster-ct.c.googlers.com>
 <xmqq8t2mk0jo.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t2mk0jo.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 25 Oct 2018 00:10:50 -0700
Message-ID: <CAPUEsphHsWVzdGXBB0EOSNuUb5gNgjyJ+i7PnDJx7LBqejQrNQ@mail.gmail.com>
Subject: Re: [PATCH] sequencer: cleanup for gcc 8.2.1 warning
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, alban.gruin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 11:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> and they would read naturally.  But may be it is a bit too cute an
> idea?  I dunno.

my first idea was to replace it with a helper called touch_file, since
I was expecting it will be a popular operation as flag files are
common in shell scripts and that name will be second nature to anyone
porting them.

the fact that the quiet flag was created with a single '\n' in the
code just immediately above this make me go for the proposed
"solution" instead (which I verified wouldn't change behaviour as you
described in your post; I apologize for not documenting it in the
commit and wasting your time).

would something like this work better? (not to apply, and probably mangled)

--- a/sequencer.c
+++ b/sequencer.c
@@ -35,6 +35,8 @@

 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"

+#define touch_file(path) write_file(path, "%s", "")
+
 const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";

@@ -2389,7 +2391,7 @@ int write_basic_state(struct replay_opts *opts,
const char *head_name,
                write_file(rebase_path_quiet(), "\n");

        if (opts->verbose)
-               write_file(rebase_path_verbose(), "");
+               touch_file(rebase_path_verbose());
        if (opts->strategy)
                write_file(rebase_path_strategy(), "%s\n", opts->strategy);
        if (opts->xopts_nr > 0)
