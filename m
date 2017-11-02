Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB399202A0
	for <e@80x24.org>; Thu,  2 Nov 2017 05:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbdKBFgX (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 01:36:23 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43091 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdKBFgW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 01:36:22 -0400
Received: by mail-io0-f196.google.com with SMTP id 134so11239616ioo.0
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 22:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=TvisUa2ZSlQweJMJ9OWwVws3mP5kWtAD/NMT5CBZ1Os=;
        b=oRkjosJJA8hhvrBBZanTI9HBhnQn0Nawg+68c068P1MU/b69U/apj5dmH3nR9yM2cb
         TDWuMrSnlwlAqE6SJm8kNfBHaC7lCxqhfwSu5xoV+2UU0qJMx2BLT1j/QN5w7RY6xQUX
         RjMu8yKwI+UbSTWx/fINWV98kYmjKNJiYjUzCyheV1ZyOZJuZUdcSsHPQtsLgBLumnu7
         b5YvVt8PNdVJ1n/PvWDY4aY2mpbv/4CPvxR6o34/cR2vyhLRN5ladHEde2IQjavRobJ2
         UwZYRyyITKpHRNRGDaiX4hgYK3d1CWrvXlHgbkmdoNClE86Nk7B6r1WjhQjbJ8efBSI8
         D0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=TvisUa2ZSlQweJMJ9OWwVws3mP5kWtAD/NMT5CBZ1Os=;
        b=uYN6SdtTfMNRPkSN3nugWogDIS419ydAdeyvrgbhGKjONCOqUoUZb8VjX6THdEexGl
         jjpk9uPZrQZBBIb29jjxjtwPsTJRjCEm5VLcybvPBrW1xdh6SYaXCa3MpE85j4Batyk9
         Z8nsRqbBlTaFb6z0MIQrKUEflP0Fqt3F3UxSUGZxDtg/MPykM6n1S6THJxFuMvfyBqzF
         qL3Pv1Fk31ni9FQ5aq8XFsNOKfHM4xUQvu9UpeI9jsWuvaAU6u9+zQnmRjoLRg5lEOIa
         0Ghbs+8MKhiduhfLfGoHCXD6ZnT1q44J8z7/5fg2Xd7LqmQjqr3uHN3le5kC/Al5KKAR
         gBnQ==
X-Gm-Message-State: AJaThX6t2Vgon4IT1LilB2ijVLWrsd5GT4KciQVLx4WKUTrbt1ngalol
        Ok9LFsiFJFSsE7bfmFvy6QD5KktL
X-Google-Smtp-Source: ABhQp+Q9H0CxNaGgRksnNmPJohgxIyebkJ/bfxGYZ2ipTh+vcv7HTxbNem0nJig4+PorgiM1L0KODg==
X-Received: by 10.107.35.15 with SMTP id j15mr3146058ioj.241.1509600981939;
        Wed, 01 Nov 2017 22:36:21 -0700 (PDT)
Received: from unique-pc ([117.251.237.9])
        by smtp.googlemail.com with ESMTPSA id q202sm1053958iod.85.2017.11.01.22.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Nov 2017 22:36:20 -0700 (PDT)
Message-ID: <1509600814.9254.6.camel@gmail.com>
Subject: Re: [BUG] Incosistent repository state when trying to rename HEAD
 in the middle of a rebase
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
In-Reply-To: <1509209933.2256.4.camel@gmail.com>
References: <1509209933.2256.4.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 02 Nov 2017 11:03:34 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was able to spare some time to dig into this and found a few things.

First, it seems that the issue is more generic and the BUG kicks in
whenever HEAD is not a symbolic ref. I noticed that because when HEAD
is a symbolic ref there was a change in the error message shown by git.
In (2.11.0) I get this error message,

    error: refname refs/heads/HEAD not found
    fatal: Branch rename failed

while in the version build from 'next', I get the following error
message,

    error: refname HEAD is a symbolic ref, renaming it is not supported
    fatal: Branch rename failed

    That made me suspicious and I wanted to find where the error message
    got changed and bisected this which pointed to,

    9416812db (branch: forbid refs/heads/HEAD, 2017-10-13)

    This is the same commit which also causes the bug of allowing HEAD to
    be renamed when it is not a symbolic ref. I found a way to fix this but
    am not so sure if it's the right way to do this. (the diff patch is
    found at the end of this mail).

    One more observation I made was that without the patch at the end it is
    NOT possible to rename a branch named "HEAD" created using the older
    version!

    On Sat, 2017-10-28 at 22:28 +0530, Kaartic Sivaraam wrote:
    >     git rebase-i HEAD~
> 

Small correction here. Now you could replace that with the simpler,

    git checkout HEAD^



diff --git a/sha1_name.c b/sha1_name.c
index c7c5ab376..4345e14c9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1334,7 +1334,13 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
        strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
        if (name[0] == '-')
                return -1;
+
        strbuf_splice(sb, 0, 0, "refs/heads/", 11);
+
+       /* HEAD is not to be used as a branch name */
+       if(!strcmp(sb->buf, "refs/heads/HEAD"))
+               return -1;
+
        return check_refname_format(sb->buf, 0);
 }
 

HTH,
Kaartic
