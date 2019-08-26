Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCDA81F461
	for <e@80x24.org>; Mon, 26 Aug 2019 07:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfHZHsr (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 03:48:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36789 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfHZHsq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 03:48:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so14311331wrt.3
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=05jnekHehjUvgkBjmNb/wt6aWv/2rWl+wlkQzmm/3rs=;
        b=GQGKOt7ucvpHZRil7y7Z3v7YMXEHlamCj2pMOJwQ6QcjHnIedlV3iC2VDbyFkIUpCf
         Nf9tDZgIOCCgbBXIe9wyqqjvcAjkbNMosJQWbFozOY7U86B/Yy72MZpI/OE70T4V5CfF
         ZGwpIiTq+ZkUnbBsulT4dLIzJWzdtHbDXGGZskv/kBSWL3CnWWkll/OvNQpVeHOMoKiQ
         ETucLwKxHweaf91liqcDtJPH9Im5ZhCfyIWAaJ1Ug+2mSCjUVMyp8zHV6+KdLONmRjme
         FCA4ZL1iLfCX1XfHrh7237ypDCxzrGZErZZESViHqXxCL6qeFbBktZcx/jRiSCZBf2Y0
         UaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=05jnekHehjUvgkBjmNb/wt6aWv/2rWl+wlkQzmm/3rs=;
        b=QEs1Qks9QCpZb8ONtXJIM1fxc/wnypzO5e80BI38UH/3pUrgLjBjgtd7uOwqkZvi+W
         +o3gDnxbDo8cAdL1TtZrbNi0IYX/3RXxMPSn3VUiY5cDPz2bkIv/ZgTGVa0J3EcYMvH6
         kf9sa6lTh9vp9m/NCq+gw9R01o5D+JvBry5Dftbmr80a9+d0tVfxuLbI8WK9sMrKPWFe
         TEJ71TJAx0rvB2G7HGl9wLK2Q7iOZiYi1ezNgDveNE1zSOIJe6NAG1b+hh+6bWYGLpjk
         BDjMMG2nSiU7XRyX08H0nbjLjY8WuANci+pkG0LBHhVWElRY88a3SgqykgVX7lNImy2y
         35hg==
X-Gm-Message-State: APjAAAWc6p5ujafMy/CGrqAIrwEaGvoiXI0yZTXkVDxq2SI0wE55kynn
        Eh0aXpODtcWHEJceNLMMJxE=
X-Google-Smtp-Source: APXvYqws4ZHRScfuDDy2ieyCYFp01DZpdvysMyvBuMRgqmmS97B070h7QS4wE8HMDeBPKVLRifz26A==
X-Received: by 2002:a5d:4205:: with SMTP id n5mr20515225wrq.52.1566805724504;
        Mon, 26 Aug 2019 00:48:44 -0700 (PDT)
Received: from szeder.dev (x4db5125e.dyn.telefonica.de. [77.181.18.94])
        by smtp.gmail.com with ESMTPSA id m188sm32787401wmm.32.2019.08.26.00.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 00:48:43 -0700 (PDT)
Date:   Mon, 26 Aug 2019 09:48:41 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH] t7300-clean: demonstrate deleting nested repo with an
 ignored file breakage
Message-ID: <20190826074841.GP20404@szeder.dev>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20f71f02-4895-fe57-8704-a44494b971b9@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20f71f02-4895-fe57-8704-a44494b971b9@iee.email>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 11:32:28PM +0100, Philip Oakley wrote:
> Hi Szeder,
> 
> On 25/08/2019 19:59, SZEDER Gábor wrote:
> >'git clean -fd' must not delete an untracked directory if it belongs
> s/untracked//
> I don't believe it should matter either way for a sub-module
> (sub-directory).

I just paraphrased the documentation of the '-d' option for a bit of
context.

   Remove untracked directories in addition to untracked files. If an
   untracked directory is managed by a different Git repository, it is
   not removed by default. Use -f option twice if you really want to
   remove such a directory.

> >to a different Git repository or worktree.
> msybr split the assertion from the fault explanation.
> >  Unfortunately, if a
> >'.gitignore' rule in the outer repository happens to match a file in a
> >nested repository or worktree, then something goes awry and 'git clean
> >-fd' does delete the content of the nested repository's worktree
> good so far.
> >except that ignored file, potentially leading to data loss.
> this appears at cross purposes as the description has changed from
> 'ignored/untracked directory' to 'ignored file'.

The description does not mention any ignored directories.

> I'm not sure which part the
> data loss is meant to refer to.

Well, there is only one part where the description talks about stuff
getting deleted... and that's what it refers to :)

> >Add a test to 't7300-clean.sh' to demonstrate this breakage.
> >
> >This issue is a regression introduced in 6b1db43109 (clean: teach
> >clean -d to preserve ignored paths, 2017-05-23).
> >
> >Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> >---

On a related note, 'git clean -fdx' does leave the nested repository
or worktree intact in the same situation, as it should.

> >  t/t7300-clean.sh | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> >diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> >index a2c45d1902..d01fd120ab 100755
> >--- a/t/t7300-clean.sh
> >+++ b/t/t7300-clean.sh
> >@@ -669,6 +669,28 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
> >  	test_path_is_missing foo/b/bb
> >  '
> >+test_expect_failure 'git clean -d skips nested repo containing ignored files' '
> >+	test_when_finished "rm -rf nested-repo-with-ignored-file" &&
> >+
> >+	git init nested-repo-with-ignored-file &&
> >+	(
> >+		cd nested-repo-with-ignored-file &&
> >+		>file &&
> >+		git add file &&
> >+		git commit -m Initial &&
> >+
> >+		# This file is ignored by a .gitignore rule in the outer repo
> >+		# added in the previous test.
> >+		>ignoreme
> >+	) &&
> >+
> >+	git clean -fd &&
> >+
> >+	test_path_is_file nested-repo-with-ignored-file/.git/index &&
> >+	test_path_is_file nested-repo-with-ignored-file/ignoreme &&
> >+	test_path_is_file nested-repo-with-ignored-file/file
> >+'
> >+
> >  test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
> >  	test_config core.longpaths false &&
> >  	a50=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
> 
