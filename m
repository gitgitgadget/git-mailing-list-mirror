Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2BF31F453
	for <e@80x24.org>; Wed, 26 Sep 2018 16:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeIZWXW (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 18:23:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46112 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeIZWXW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 18:23:22 -0400
Received: by mail-lf1-f68.google.com with SMTP id q2-v6so13758828lfc.13
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fd7vHv9uvCTC/KV6WIO2BQeurOVMx6KZorG7qRFNmCg=;
        b=KhWgm0YGBrioRdaycg+ejYRMtztzyFSK8IBwQ+3usuZIHZeLjVKU4H2kUEchcDST5E
         bzYoJA8OqMrMMaJlSsKz2Z+JyrnbXFBmD/E265/dYZ4FXsVWb5G9B/qsTzUXtMnlJFuK
         cLR5BLDEoa8dudSD8sosexS32iYWwTk2ix2nNoYY81FI23qj1gvEaZH30Op+/r10Dd/B
         E9IR7l90pcxWQuo3YrzciZXHaRGQXqirKreegXnli3oBQSgEnNBWTs+4PNKcn58/2k4w
         3XTX+EVSLzC8oyfFvJZ79IXXX0FLTfXleoXJICe2pshYkK0bJeplQaAOIZ92L7rXOE2O
         9dBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fd7vHv9uvCTC/KV6WIO2BQeurOVMx6KZorG7qRFNmCg=;
        b=S0JdZObCImyAHea5w1v/l/N9A0ALeF6tGgn976O512/eeKMEUQJs+plb+Iua3rFODJ
         DIGfrK9bjkPDC1/ft8vd1brULGFqxUTO7d8M1Znc0APsNfUWi3/D1RpduyuKhTYXQ2cK
         GJ5kmZZFbBOyDStyahLV+0y4h2ZLgd/OoUeJPta7TbiDFFmVZjmOWeHNZQBRaFQMjSFS
         +tlf/g0rf1WU63D9MEwS62g0doENC2L4Inpmke+EX/LQnD5mXne/qV834BakWC8pg8mA
         FxGuWHuZPmEO1CuvfzYItnkLboQZlyzBSOjW8k04wExRM9l3Z35XTcHvosBwmm80pruV
         uPgw==
X-Gm-Message-State: ABuFfoiYfE5bw52Z2/ZUOpB9q3H4vfoc3OtGBIxqLCf7tbXjGw3fQtEe
        bfF9KoMm5WN6rnQFV/P1LZI=
X-Google-Smtp-Source: ACcGV61IAXEaaL8vNL3+PqB0L0rnzZ8LwG4EnDyS+s7La8iJ2xF1FgjICVv/Trk65xzU9OuwZikCuw==
X-Received: by 2002:a19:434f:: with SMTP id m15-v6mr1845409lfj.142.1537978181777;
        Wed, 26 Sep 2018 09:09:41 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f81-v6sm478453lfi.50.2018.09.26.09.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 09:09:40 -0700 (PDT)
Date:   Wed, 26 Sep 2018 18:09:38 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: git fetch <remote> <branch> behaves weirdely when run in a
 worktree
Message-ID: <20180926160938.GA15312@duynguyen.home>
References: <90301874969f7b11f33e504500c150a25d722ff8.camel@gmail.com>
 <39F9931A-B297-4525-A131-736B900F37AF@gmail.com>
 <CACsJy8AScp1v+R62vXWuP-45LLLYwfSBNaZJfR02=d+2CzDqhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8AScp1v+R62vXWuP-45LLLYwfSBNaZJfR02=d+2CzDqhg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 05:24:14PM +0200, Duy Nguyen wrote:
> On Wed, Sep 26, 2018 at 6:46 AM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
> > This is the most interesting part of the issue. I **did not** run
> >'git fetch ...' in between those cat commands. I was surprised by
> >how the contents of FETCH_HEAD are changing without me spawning any
> >git processes that might change it. Am I missing something here? As
> >far as i could remember, there wasn't any IDE running that might
> >automatically spawn git commands especially in that work
> >tree. Weird.

Maybe something like this could help track down that rogue "git fetch"
process (it's definitely _some_ process writing to the wrong file; or
some file synchronization thingy is going on). You can log more of
course, but this is where FETCH_HEAD is updated.

-- 8< --
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0696abfc2a..0dfb580e92 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -786,6 +786,13 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	if (!fp)
 		return error_errno(_("cannot open %s"), filename);
 
+	{
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addf(&sb, "( date; ls -l /proc/%d/cwd ) >>%s.log", getpid(), filename);
+		system(sb.buf);
+		strbuf_release(&sb);
+	}
+
 	if (raw_url)
 		url = transport_anonymize_url(raw_url);
 	else
-- 8< --

--
Duy
