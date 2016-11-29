Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354E71FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 13:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754976AbcK2N4z (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 08:56:55 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33641 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754053AbcK2N4x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 08:56:53 -0500
Received: by mail-pg0-f66.google.com with SMTP id 3so16520823pgd.0
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 05:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EWUUxWbCagVhe/hCj4y7mBpKB1fkH2OG+BPqppZCHlg=;
        b=S0jiO3+Rw5K0KMcr4n+2RlluJbqCKRIOHvpFl9tmdBn1AqTvDzH1Ri3EJuBAyOjixy
         mU9qtrrUAZqt65KUCzTwri9Ph1PT+GPVKs5DEuutKFkreHXML+nmpB7koSeq/6rkqu12
         yFYAaY1DpnExjgwBxJM8gL+URhRQOxZZfY+cjNnEvz+e/v6l/trNzV4xokVsego/ukrO
         Y/kjnfLoZAayl2kMTblZiWsd2Pyhriw0el+v25jMI9FmL8Edulh0ui+zar6ukZ3VQzK2
         3+Rxy0zov0CbTP5N1QZuabAOvMCTS1oewo5MNZHdvm/BAH5l32I+xrUDawApYBwSsJch
         xfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EWUUxWbCagVhe/hCj4y7mBpKB1fkH2OG+BPqppZCHlg=;
        b=FApFHbfiqfvZfEew+FknkpnBt/dAB0n5M6OzhQ57ZsV4XN8K8ssckMCOAYjNYDf3Mo
         BzOcGSqvCCog+pXmw8HjvnRXl2jI5xZje35U7fW48rCsRxy3XHJPczbC0So6bZYS3a9/
         blp4DSFritpHVeLotH4WTXly9bQROfu5m9qr2yY9qHPbtL6MYCpS7N7J5OhLKY02jZSQ
         wI37V31n2xhLia5LqG4ufMMcxmTHuDOFBpSNCJuNp61zXvED2YCvtBaFLAFNI5vUReiv
         EInK8hZ9CRZ117z46ZAZn+KWQ96Qg/4kJJg79eApChuDKYWw43W/7AqVZzyPVKW99UH+
         q/oQ==
X-Gm-Message-State: AKaTC0139kVKHxINhuPv2a1n6O9w6XryUnFpei2DW+DnEjqsRZjgKaAztAH7I5o68K0J8A==
X-Received: by 10.84.171.1 with SMTP id k1mr62510420plb.169.1480427812935;
        Tue, 29 Nov 2016 05:56:52 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id i76sm95499376pfk.89.2016.11.29.05.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 05:56:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 29 Nov 2016 20:56:46 +0700
Date:   Tue, 29 Nov 2016 20:56:46 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 00/11] git worktree (re)move
Message-ID: <20161129135646.GA19797@ash>
References: <20161112022337.13317-1-pclouds@gmail.com>
 <20161128094319.16176-1-pclouds@gmail.com>
 <xmqqwpfnidxm.fsf@gitster.mtv.corp.google.com>
 <xmqqshqbicga.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DQDPzZGJXLpTVHVFUeupPpp5e=b9z4m7xceJWrxPfF3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DQDPzZGJXLpTVHVFUeupPpp5e=b9z4m7xceJWrxPfF3Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 07:08:16PM +0700, Duy Nguyen wrote:
> On Tue, Nov 29, 2016 at 3:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Does this round address the issue raised in
> >>
> >>   http://public-inbox.org/git/alpine.DEB.2.20.1611161041040.3746@virtualbox
> >>
> >> by Dscho?
> 
> It does not (and is sort of expected), quoting from the commit message
> 
>     copy.c: convert copy_file() to copy_dir_recursively()
> 
>     This finally enables busybox's copy_file() code under a new name
>     (because "copy_file" is already taken in Git code base). Because this
>     comes from busybox, POSIXy (or even Linuxy) behavior is expected. More
>     changes may be needed for Windows support.
> 
> I could "#ifdef WINDOWS return -ENOSYS" for now, which would make it
> build. "git worktree move" won't work on Windows of course...

Another way, as pointed out by j6t, is go with "move within filesystem
only", at least at the first step. Which is probably a good idea
anyway so we can concentrate on git-specific stuff before going to
minor and complicated copy/move details.

If you drop all the "copy.c: " patches and squash this to "worktree
move: new command", and if Windows rename() can move directories, then
git should build and new tests pass.

-- 8< --
diff --git a/builtin/worktree.c b/builtin/worktree.c
index f114965..d8d0127 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -569,9 +569,9 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 				  wt->path, dst.buf);
 
 		/* second try.. */
-		if (copy_dir_recursively(wt->path, dst.buf))
-			die(_("failed to copy '%s' to '%s'"),
-			    wt->path, dst.buf);
+		if (copy_dir_recursively(dst.buf, wt->path))
+			die_errno(_("failed to copy '%s' to '%s'"),
+				  wt->path, dst.buf);
 		else {
 			struct strbuf sb = STRBUF_INIT;
 
diff --git a/cache.h b/cache.h
index a50a61a..2d4edf6 100644
--- a/cache.h
+++ b/cache.h
@@ -1857,6 +1857,7 @@ extern void fprintf_or_die(FILE *, const char *fmt, ...);
 extern int copy_fd(int ifd, int ofd);
 extern int copy_file(const char *dst, const char *src, int mode);
 extern int copy_file_with_time(const char *dst, const char *src, int mode);
+extern int copy_dir_recursively(const char *dst, const char *src);
 
 extern void write_or_die(int fd, const void *buf, size_t count);
 extern void fsync_or_die(int fd, const char *);
diff --git a/copy.c b/copy.c
index 4de6a11..b232aec 100644
--- a/copy.c
+++ b/copy.c
@@ -65,3 +65,9 @@ int copy_file_with_time(const char *dst, const char *src, int mode)
 		return copy_times(dst, src);
 	return status;
 }
+
+int copy_dir_recursively(const char *dst, const char *src)
+{
+	errno = ENOSYS;
+	return -1;
+}
-- 8< --
