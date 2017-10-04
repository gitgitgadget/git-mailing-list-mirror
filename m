Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6FED20281
	for <e@80x24.org>; Wed,  4 Oct 2017 06:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbdJDGj5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 02:39:57 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:55376 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdJDGj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 02:39:56 -0400
Received: by mail-pf0-f179.google.com with SMTP id g62so202461pfk.12
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 23:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1DqUj25YOUw5Dd2AXNQdYMPW+zAugoAwp2wFYczYhx0=;
        b=Xe5hI75FLlgY6CnYmd7Z+qwZK0o0gNUSn3rmviF2e8zoqB50xPmf1dLQrg0NOGlQYu
         bRGRrjvG46bmIrErYgtmx8YDmDuuNjz9SrmVApXWFWN1d7x+ru9xpF6YG4zlj6gFkBR7
         MC/ZgrcNrvOFipit0Cw5ez8ciubR9Oivd7Qms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=1DqUj25YOUw5Dd2AXNQdYMPW+zAugoAwp2wFYczYhx0=;
        b=poOEZEwXjaZMQa+47yfR3rXVbwa3Ize3W3jh3A8mch2+uWgWEXVl/Spt5Um657dUPH
         NEg/BbvU8ck43qKIyVD5eLXxthyQ9hnCorbf1pKdanDbMPxBWH1IsnBk7Z/tN73jTn+x
         lxBbHQOAf3+zwitZXjTl98A9joxZYFsqLmtYU/aEEYgukqNokJL667H70T2Psx8sBysu
         wupbaeMLGgT2B447D3lSYSK2OKqRHNEj/qj3WCIikVNkhmp8DanNrwwMZMuKuVXRcdQ4
         cMyv16bUn2CA9khYV+2Dpy9x/6OupXXGKjgcPXkUv4qWN7Ymfd/Pprry9cNUUz0hYS/Q
         t3Pw==
X-Gm-Message-State: AMCzsaXO5kRkE95KASLN/aFJk+hKxR5W/zF+o00AzYrRWg+RmzLyWuwQ
        LLtoPqV2Lo/E8TeLLV4Urf0LZA==
X-Google-Smtp-Source: AOwi7QCqxj1AObVtqa8ncfFneD1AvyFMPHRZ2ZbNo+OJvQlhr9NI76MzEFC0J9kwc+YIRDwRNODJIQ==
X-Received: by 10.101.82.131 with SMTP id y3mr4857992pgp.65.1507099195874;
        Tue, 03 Oct 2017 23:39:55 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (Guest-GW2.corp.dropbox.com. [205.189.0.166])
        by smtp.gmail.com with ESMTPSA id g25sm24095316pfg.166.2017.10.03.23.39.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 23:39:55 -0700 (PDT)
Date:   Tue, 3 Oct 2017 23:38:39 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "David.Turner@twosigma.com" <David.Turner@twosigma.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: Re: [PATCH v8 00/12] Fast git status via a file system watcher
In-Reply-To: <xmqqzi97fytt.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.10.1710032325310.28521@alexmv-linux>
References: <20170919192744.19224-1-benpeart@microsoft.com> <20170922163548.11288-1-benpeart@microsoft.com> <xmqq7ewiz1mz.fsf@gitster.mtv.corp.google.com> <MWHPR21MB0478B8D1C5442B2FCE1ED465F47E0@MWHPR21MB0478.namprd21.prod.outlook.com>
 <xmqqk20fuvg7.fsf@gitster.mtv.corp.google.com> <fd972756-4ad3-4b96-23d0-e2c9e59189d1@gmail.com> <xmqqzi97fytt.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 4 Oct 2017, Junio C Hamano wrote:
> Rats indeed.  Let's go incremental as promised, perhaps like this
> (but please supply a better description if you have one).

I think you'll also want the following squashed into 5c8cdcfd8 and
def437671:

-- >8 --
From 445d45027bb5b7823338cf111910d2884af6318b Mon Sep 17 00:00:00 2001
From: Alex Vandiver <alexmv@dropbox.com>
Date: Tue, 3 Oct 2017 23:27:46 -0700
Subject: [PATCH] fsmonitor: Read entirety of watchman output

In perl, setting $/ sets the string that is used as the "record
separator," which sets the boundary that the `<>` construct reads to.
Setting `local $/ = 0666;` evaluates the octal, getting 438, and
stringifies it.  Thus, the later read from `<CHLD_OUT>` stops as soon
as it encounters the string "438" in the watchman output, yielding
invalid JSON; repositories containing filenames with SHA1 hashes are
able to trip this easily.

Set `$/` to undefined, thus slurping all output from watchman.  Also
close STDIN which is provided to watchman, to better guarantee that we
cannot deadlock with watchman while both attempting to read.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 t/t7519/fsmonitor-watchman                 | 6 ++----
 templates/hooks--fsmonitor-watchman.sample | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index 7ceb32dc1..7d6aef635 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -50,9 +50,6 @@ launch_watchman();
 
 sub launch_watchman {
 
-	# Set input record separator
-	local $/ = 0666;
-
 	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
 	    or die "open2() failed: $!\n" .
 	    "Falling back to scanning...\n";
@@ -83,7 +80,8 @@ sub launch_watchman {
 	close $fh;
 
 	print CHLD_IN $query;
-	my $response = <CHLD_OUT>;
+	close CHLD_IN;
+	my $response = do {local $/; <CHLD_OUT>};
 
 	open ($fh, ">", ".git/watchman-response.json");
 	print $fh $response;
diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
index 870a59d23..1b8ed173e 100755
--- a/templates/hooks--fsmonitor-watchman.sample
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -49,9 +49,6 @@ launch_watchman();
 
 sub launch_watchman {
 
-	# Set input record separator
-	local $/ = 0666;
-
 	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
 	    or die "open2() failed: $!\n" .
 	    "Falling back to scanning...\n";
@@ -78,7 +75,8 @@ sub launch_watchman {
 	END
 
 	print CHLD_IN $query;
-	my $response = <CHLD_OUT>;
+	close CHLD_IN;
+	my $response = do {local $/; <CHLD_OUT>};
 
 	die "Watchman: command returned no output.\n" .
 	    "Falling back to scanning...\n" if $response eq "";
-- 
2.14.2.959.g6663358d3
