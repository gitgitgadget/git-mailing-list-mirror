Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 142E91F404
	for <e@80x24.org>; Sun, 21 Jan 2018 08:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750873AbeAUIHg (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 03:07:36 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33872 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbeAUIHf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 03:07:35 -0500
Received: by mail-io0-f196.google.com with SMTP id c17so6387309iod.1
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 00:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rp09lshik2O4O1ferIRZlKuT5VrzrQPKv7b2vHfeIOA=;
        b=Bf9ZpC4ZnZROewR1s7FGAyut06VcPtBD/UIILH35XCVH/tjJAV7+tGkZOWRtuMmhvm
         H6SaWcRHeXS77YQAkQFphSaloygJQb73LGhrZJVn/+3MN8aeR28U6frhTpzYUu6rdt0q
         8BuZUv1sChZZ+aB1uyRanqL/Oqi9x4Vd9KO0JsLjJoD3MsmfwDTxjrFIIXUc4vBKbcdK
         19o/B63n2BbGFd0sTyDVudf4jz83fMvx8OisEpc4dtnc0m5ysO+1egbj02JGE4SukbVn
         zZlrhggsVUbD/5eJfuY+qRL5+kAjdn/PdUqwHHSnNkPBr+xGAjICZusL1TdfK5QG/4oh
         05ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rp09lshik2O4O1ferIRZlKuT5VrzrQPKv7b2vHfeIOA=;
        b=hXYGFTs7BuyvvjpkSYRpHR5occbEmVcMJJ/lsrK6oOFuyQjpS1D2Bb7FiWC1etrgzd
         zg/zgxkodWlp3fWAUn3P8jqVb8AzHbnnB0mDtUV4Z/p99KvU5e5Fq5MONvkCsASH6Ntl
         wCQNa7cBxelf9mDrzAThrrZ/+RFqoYMOzswV+yUh1S16od37T2ttO5QmBU+zxyMWXheD
         KGRktZBhJIl0tTtGE+zhUuBTdMQ1wJrGdOxgkrllSEek3v6OPf9RO+cfoFzFtK2PZ3Bl
         PZH+/jKBF9zLznPAjerr0/Wl1rIUPFF2wzCHDO92XpfvSyjqwmvIbd8WVr219b8/JpRF
         bMGw==
X-Gm-Message-State: AKwxytcWcsQifwftPiYP7H0/d1oqs/+GrSmja9REpMehe8RuY+gTDuUo
        t5g3twpDw6t/CVez86nUEGI=
X-Google-Smtp-Source: AH8x226HJx9ecrJxuF5QE/9d5hUTuMNTd9QUptUTqTxCA2gSqqTJjT/72HvO4AeC+FYlItw3U81JZQ==
X-Received: by 10.107.145.138 with SMTP id t132mr3895666iod.235.1516522054737;
        Sun, 21 Jan 2018 00:07:34 -0800 (PST)
Received: from flurp.local (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o137sm2640225ito.5.2018.01.21.00.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jan 2018 00:07:33 -0800 (PST)
Date:   Sun, 21 Jan 2018 03:07:28 -0500
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>
Subject: Re: [PATCH] t: add clone test for files differing only in case
Message-ID: <20180121080728.GA20770@flurp.local>
References: <20180119041825.727904-1-sandals@crustytoothpaste.net>
 <20180120203324.112522-1-sandals@crustytoothpaste.net>
 <xmqqa7x7oecq.fsf@gitster.mtv.corp.google.com>
 <CAPig+cTW+vO7FWYViUrO-aV8pPL=KKhGf7Wkgh_51cbrxKZPEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTW+vO7FWYViUrO-aV8pPL=KKhGf7Wkgh_51cbrxKZPEQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 21, 2018 at 02:46:15AM -0500, Eric Sunshine wrote:
> On Sun, Jan 21, 2018 at 2:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >> +test_expect_success 'clone on case-insensitive fs' '
> >> +     o=$(git hash-object -w --stdin </dev/null | hex2oct) &&
> >> +     t=$(printf "100644 X\0${o}100644 x\0${o}" |
> >> +             git hash-object -w -t tree --stdin) &&
> >> +     c=$(git commit-tree -m bogus $t) &&
> >> +     git update-ref refs/heads/bogus $c &&
> >> +     git clone -b bogus . bogus
> >> +'
> >
> > Hmm, I seem to be seeing a failure from this thing:
> >     fatal: repository '.' does not exist
> > even on a case sensitive platform.
> 
> Yep. In pretty much any other test script, this would work (it was
> developed in a stand-alone script), but t5601 (which nukes .git as its
> first action) isn't the most friendly place.

Here's a re-roll which fixes that problem (and has a slightly
re-written commit message.

--- >8 ---
From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] t5601-clone: test case-conflicting files on case-insensitive
 filesystem

A recently introduced regression caused a segfault at clone time on
case-insensitive filesystems when filenames differing only in case are
present. This bug has already been fixed (repository: pre-initialize
hash algo pointer, 2018-01-18), but it's not the first time similar
problems have arisen. Therefore, introduce a test to catch this case and
protect against future regressions.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t5601-clone.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0f895478f0..2d1490f631 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -611,4 +611,21 @@ test_expect_success 'GIT_TRACE_PACKFILE produces a usable pack' '
 	git -C replay.git index-pack -v --stdin <tmp.pack
 '
 
+hex2oct() {
+	perl -ne 'printf "\\%03o", hex for /../g'
+}
+
+test_expect_success 'clone on case-insensitive fs' '
+	git init icasefs &&
+	(
+		cd icasefs
+		o=$(git hash-object -w --stdin </dev/null | hex2oct) &&
+		t=$(printf "100644 X\0${o}100644 x\0${o}" |
+			git hash-object -w -t tree --stdin) &&
+		c=$(git commit-tree -m bogus $t) &&
+		git update-ref refs/heads/bogus $c &&
+		git clone -b bogus . bogus
+	)
+'
+
 test_done
-- 
2.16.0.312.g896df04e46
