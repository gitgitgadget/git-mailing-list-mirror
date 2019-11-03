Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4E901F454
	for <e@80x24.org>; Sun,  3 Nov 2019 20:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfKCU1C (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 15:27:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45019 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfKCU1C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 15:27:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id f2so5874418wrs.11
        for <git@vger.kernel.org>; Sun, 03 Nov 2019 12:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=U1Td/8WKxmB4dcTpgqaEvtBclWh5EqskS73oQ0jrVy8=;
        b=e90wxnB6kCv8cd6kDPdASMuC3AIsWl39eFpQKxDP2zO8XxrUpgxMeMbn+pRTi1q3mw
         yirHRWqV9FYsv2Q7K1nOlMtdPP4QxHACDPi8BUrrANFHD+5KamBjJ6fzUsPeLcz66E+B
         TtRv6W4dbhuY21RIaUvfh8n+I5IhDpotyBUnyL00zvTpVFFiG0Eqx/5kOFRJD/U+TT1k
         q/93X7eVUCN8Ds1vr0gFQDT70W4UdBdmVrS18OoJA+xhVFy9UiDl1wDOuEjug9+kI5xk
         XrsufJDvm9blVYqQFLdFMKzFjD7JJo1tLsO3PDreyN4o9BcIU2OHkEe6pKdQUr8k6i3B
         ocug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=U1Td/8WKxmB4dcTpgqaEvtBclWh5EqskS73oQ0jrVy8=;
        b=pgxrDzeZ9yxnEgnViCy51TcUZPA4kv/IfHqrblWbgSj03lUnDI0iAp0SIYUC06BXdn
         qxo4cZfD4X8zKnc8yXMApFT9cqH+f00aZMx0SM3kQ3etzoeWlIKuhiPFgoKCB5AEaTlq
         arPAM4KRr2Kx1lCAELvlRDkNx8QVCStTsZBHENL8tDgACkNjPoHNDBBLAdOEn+kMV7Qr
         fakgFdbOZTUAt/U+QP/+QIqMqqrLJKYHssOtuId/xean5QKcz4Ig8ui1zQGAdBnyS8t8
         yDjUbfVB0SBD06SskbBpEb7HU3Qw2W2RhZ5amYRiutPI7IBUlAty/fVj0v0RIJmRhdvg
         hgHg==
X-Gm-Message-State: APjAAAUk00pvxwOT6BxbCUr0T+OAy9K5zZlLL6nwhxGDKmqYkQWT3rW+
        vWnCX07ohk3tM29UID6hI7wWIoIr
X-Google-Smtp-Source: APXvYqwHAM3Q8L3Dh2eCy1Zm3ti2bCZsr5b+HhH1DGcV4v0Vn8JL0+QPlqhdCOri77OR9+3cduIc0w==
X-Received: by 2002:adf:f452:: with SMTP id f18mr21275997wrp.264.1572812819904;
        Sun, 03 Nov 2019 12:26:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16sm14096211wmj.48.2019.11.03.12.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Nov 2019 12:26:59 -0800 (PST)
Message-Id: <pull.432.v2.git.1572812819.gitgitgadget@gmail.com>
In-Reply-To: <pull.432.git.1572127149.gitgitgadget@gmail.com>
References: <pull.432.git.1572127149.gitgitgadget@gmail.com>
From:   "Qusielle via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 03 Nov 2019 20:26:57 +0000
Subject: [PATCH v2 0/1] add: respect --ignore-errors when lstat() reports errors
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git add --ignore-errors" command fails immediately when lstat returns an
error, despite the ignore errors' flag is enabled.

There could be files that triggers an error on stat(), when other files
proceed correctly. Issue can be reproduced when running git under Cygwin and
some target files have utf-8 long names (200+ utf chars). Windows can handle
them, but all operations on them failed under Cygwin. Issue can not be
reproduced with usual latin/numeric only names. For example, create a file
with 220 'й' letters by Windows Explorer, then in Cygwin:

Here and below "ййй..." means the line of й copied 220 times.
=============================================================

$ echo -n 'ййй...' | wc -c # check the real size 440

$ ls -la ls: cannot access 'ййй...'$'\320': No such file or directory
-????????? ? ? ? ? ? 'ййй...'$'\320'

$ ls й* ls: cannot access 'ййй...'$'\320': No such file or directory

$ stat й* stat: cannot stat 'ййй...'$'\320': No such file or directory

In my perspective, it's okay to skip these problematic files when ignore
error flag is specified, but official Git terminates entire git add command
when such files come up. But with proposed patch it is the desired behavior:

$ git add --ignore-errors . error: ййй... can only add regular files,
symbolic links or git-directories

All other files have been added correctly.
==========================================

Signed-off-by: Qusielle <qusielle@gmail.com>

qusielle (1):
  add: respect `--ignore-errors` when `lstat()` reports errors

 read-cache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-432%2Fqusielle%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-432/qusielle/master-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/432

Range-diff vs v1:

 1:  fd022f88f5 ! 1:  d88ea544d9 add: respect `--ignore-errors` when `lstat()` reports errors
     @@ -46,7 +46,13 @@
       {
       	struct stat st;
      -	if (lstat(path, &st))
     -+	if (lstat(path, &st) && !(flags & ADD_CACHE_IGNORE_ERRORS))
     - 		die_errno(_("unable to stat '%s'"), path);
     +-		die_errno(_("unable to stat '%s'"), path);
     ++	if (lstat(path, &st)) {
     ++		if (flags & ADD_CACHE_IGNORE_ERRORS)
     ++			return -1;
     ++		else
     ++			die_errno(_("unable to stat '%s'"), path);
     ++	}
       	return add_to_index(istate, path, &st, flags);
       }
     + 

-- 
gitgitgadget
