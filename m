Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5519B1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 23:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfBUXkO (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 18:40:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40600 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfBUXkO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 18:40:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15so302359wmi.5
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 15:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=3D1RE1fNvkvC7I75U9yrk6byIAvoCYvY+ImRlWfTs+E=;
        b=g60Ba44y2C46Fk9GY9vJ7kJSGEWZBWAMfidQV5T80SPnXJpYoaNr4M1G1qqH4BcQoZ
         hQ2e6641oLr0nJDXoAsn2nPDAzOJezCLWvS/cJUB88zZh94TboxSp7EmqgzcoBu2kLva
         nVIAT/SRc6WRgtADXR6Ix+wmqBuk2oeOW8czbiKvp3OT3kYy1ATLbru5ijZJv37ZJ4i4
         S/tbwyokABiGEhD5LbLBfmhlo8XBi42GNha8fuHxudPLmoYsGAwwFqunU0eT9gCA9UFn
         /63KY0JJx1X3YIbuAv6DTdq4h39q321rzGfkaMkJAzaLcfuAhVVQaf9jP+HvDUou6yTQ
         BzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=3D1RE1fNvkvC7I75U9yrk6byIAvoCYvY+ImRlWfTs+E=;
        b=USh8Y6fUZxCYVo9QYP92ykMPEueniYBPH8b34Gvlg9HpLKjpZjs1CWD7FIdqZN7Umh
         ZChVBb1B3akO3zGv1/07p+GvXgICF7uS1HNdz+SI3lKP8bfbAHJ5nkqbNdzKFxF7/JTP
         CcSCtoRzTAndsmcuD+TBYuTjnQFtCiFLF0ecG67rcgDa9htxPKB+J+ywhArtf6TyQDGN
         B3QaRvubyL6Du6MYXz/Gzm7qacf6nPxD2ltPn70L/RK751JEmXAxoUf6Kk/Qtmf74rCu
         jYkDsk7roz5BzUcArjYjJyktsLxhE1w9w56aiYihDw8mZh+lreRbVmeyQgsmJ7i3YD3W
         gePg==
X-Gm-Message-State: AHQUAuZjdvq8H3i/R7KabTtibLnvnlyBdY89LwSA/E2WhhW8xKH7yJ9+
        IkE7HtaT9az8pqpU87jMFv0=
X-Google-Smtp-Source: AHgI3IYac3MCoOwgOC5O96uw7uQEyB8zpUZyTH6qoLa1KmIeIpcXLKYMCa7n7b1l0RVVwjglBUni5Q==
X-Received: by 2002:a1c:9693:: with SMTP id y141mr572557wmd.33.1550792411725;
        Thu, 21 Feb 2019 15:40:11 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y139sm245517wmd.22.2019.02.21.15.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 15:40:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: git format-patch can clobber existing patch
References: <CAHMHMxVdpOnTkf9RHzCa+YjjvpqJApsSE03Jjyb_VbJp_4q-jw@mail.gmail.com>
        <CAHMHMxUfjnNXFikVD=rys_t5BUho=7uRw4LsXgAphFwSf3xOnw@mail.gmail.com>
Date:   Thu, 21 Feb 2019 15:40:09 -0800
Message-ID: <xmqqpnrksobq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Σταύρος Ντέντος  <stdedos@gmail.com> writes:

> During my work flow, I tend to use `git format-patch` to move patches
> around (nasty, I know, but bear with me)
>
> It has occured to me that, it is possible that `git format-patch` can
> clobber existing files, if they match in the name and in the "patch
> order".
> However, if the patch is one, then, it will normally start with `0001-x.patch`
>
> It was fine for me when I pushed updates of the same "patch series".
> Now that I wanted to diff a "previous patch file" with the patch
> upstream, however, it was almost a "disaster". :-)
>
> Would it make sense / be easy enough to have some clobbering check / flag?

Given that use of '-o' to redirect to a fresh/new directory would
reduce the risk of such clobbering, and use of '-v' to force
different filenames would reduce the risk of such clobbering,
it seems to me that aborting the operation when we fail to open
the output, without any option to override and allow clobbering,
would make sense.  If existing files record 4 patch series
0001-x.patch, 0002-y.patch, 0003-z.patch, and 0004-w.patch, and you
generate with "format-patch --allow-clobbering" a three-patch series,
it would overwrite 0001 thru 0003 but will not remove 0004, so the
end result will still be confusing.

This is not even compile-tested, but something along these lines may
work.  I am reasonably sure that existing tests won't let this patch
alone pass, as some may depend on being able to overwrite output
files left behind by previous tests.

 builtin/log.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 3e145fe502..cb7a9eb7f9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -864,6 +864,16 @@ static int git_format_config(const char *var, const char *value, void *cb)
 static const char *output_directory = NULL;
 static int outdir_offset;
 
+static FILE *fopen_excl(const char *filename)
+{
+	int fd = open(filename, O_CREAT | O_EXCL | O_WRONLY, 0666);
+	if (fd < 0) {
+		error_errno("%s", filename);
+		return NULL;
+	}
+	return fdopen(fd, "w");
+}
+
 static int open_next_file(struct commit *commit, const char *subject,
 			 struct rev_info *rev, int quiet)
 {
@@ -890,7 +900,7 @@ static int open_next_file(struct commit *commit, const char *subject,
 	if (!quiet)
 		printf("%s\n", filename.buf + outdir_offset);
 
-	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL) {
+	if ((rev->diffopt.file = fopen_excl(filename.buf)) == NULL) {
 		error_errno(_("Cannot open patch file %s"), filename.buf);
 		strbuf_release(&filename);
 		return -1;
