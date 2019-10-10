Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D95BC1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 11:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfJJLWJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 07:22:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35110 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfJJLWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 07:22:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so6370071wmi.0
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 04:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gaEOmTbZAL/i0Bfz8HhverFNxdPenA/EkHMczjPF9D0=;
        b=KWmVf3x7zPWzwhNdpv/2brBamm1oBCVIvKXYxR3cHBbHvWFGacDQnfsoHeuiyCnwjm
         C9E4ZsBUodNxWYWI56UXosypyEz99HghV9GwQwtH8A9LNz+krD1NBZz1OOczUW3FCJvQ
         6dlyaWOjLuvWDi/dQZjTt62q1mBI2P4hfFxHNNU4douuXyGcn2NKsmm9QQstbav+PWhs
         i7nkdyO58/3TNXX4sfaSurHZo5NNZ39LEU6gvFbfFmh1yfcGgsPvmXoO/KRzICoIxgES
         pvKfcDIOpCfPu2LH9x+7qX6o0ssA9Scd1XSYnogyCjKJsLPUFq3zbv8+BfIrnyRC+v7E
         XQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gaEOmTbZAL/i0Bfz8HhverFNxdPenA/EkHMczjPF9D0=;
        b=e5yo9t6IX3rz+j2nf1QCVy/7BsBALjB2/e4HgNMKxjhZyUmDyHUVd5CjHMwi7VCVHx
         N5lgJJTI8eYdsR/ejBvtf1A5+jHRKDpifKNIvGjXy1X1W47ZiU3anpWhTGw/1segrDQe
         8HDDC4q0P9TQOaNWBFWo0hBfB1aklgGQoU13VvDPtN/Zb5cqVOSvrSvJhm4reoaPTes7
         hJ8SrogSn7mJZ4ag6wsVYqQmGmfMADHDlsCltW8FVJHxjv3sDoGmpNKynGVUO+JjSjXd
         T/H+cUm0JPMx6DQv7A3tWua7ha3vYnfkF5d/2/v4kyd3HT7QLayzBqB9okKJ2SUe4HT9
         5ooA==
X-Gm-Message-State: APjAAAXvTLfpyOD06TVW3X8YhvNd9nP1IOzH26JuopGGAi0T7KMhQkXi
        EX4CcPh/swZsRrAIE8ktTLkFISBM
X-Google-Smtp-Source: APXvYqzS4tWWZ4cKxkfS/pyV2nUppjDieLVycinNVnd74wMdNox2qiZdmOgRhZt+wEPXvju/owRm8A==
X-Received: by 2002:a7b:ce07:: with SMTP id m7mr7391509wmc.117.1570706527309;
        Thu, 10 Oct 2019 04:22:07 -0700 (PDT)
Received: from szeder.dev (x4dbd29c2.dyn.telefonica.de. [77.189.41.194])
        by smtp.gmail.com with ESMTPSA id 33sm13089521wra.41.2019.10.10.04.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 04:22:06 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:22:04 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     William Baker via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, Johannes.Schindelin@gmx.de,
        jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/1] fsmonitor: don't fill bitmap with entries to be
 removed
Message-ID: <20191010112204.GK29845@szeder.dev>
References: <pull.372.git.gitgitgadget@gmail.com>
 <pull.372.v2.git.gitgitgadget@gmail.com>
 <08741d986c2b51828f115ab50f178d62e9982978.1570654810.git.gitgitgadget@gmail.com>
 <20191010110732.GJ29845@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191010110732.GJ29845@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 10, 2019 at 01:07:32PM +0200, SZEDER Gábor wrote:
> On Wed, Oct 09, 2019 at 02:00:12PM -0700, William Baker via GitGitGadget wrote:
> > diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> > index 81a375fa0f..87042470ab 100755
> > --- a/t/t7519-status-fsmonitor.sh
> > +++ b/t/t7519-status-fsmonitor.sh
> > @@ -354,4 +354,17 @@ test_expect_success 'discard_index() also discards fsmonitor info' '
> >  	test_cmp expect actual
> >  '
> >  
> > +# This test covers staging/unstaging files that appear at the end of the index.
> > +# Test files with names beginning with 'z' are used under the assumption that
> > +# earlier tests do not add/leave index entries that sort below them. 

I just read through Junio's comments on the first version of this
patch, in particular his remarks about this comment.

If this new test case below were run in a dedicated repository, then
this comment wouldn't be necessary, and all my comments below about
that not-really-initial commit would be moot, too.

> > +test_expect_success 'status succeeds after staging/unstaging ' '
> > +	test_commit initial &&
> 
> This is confusing: this is the 29th test case in this script and it
> creates an "initial" commit?!
> 
> The first "setup" test case has already created an initial commit, so
> this should rather be called "second".
> 
> OTOH, none of the later commands in this test case seem to have
> anything to do with this second commit, and indeed the test case works
> even without it (i.e. 'git status' still segfaults without the fix and
> then succeeds with the fix applied), so instead of updating its
> message perhaps it could simply be removed.

> 
> > +	removed=$(test_seq 1 100 | sed "s/^/z/") &&
> > +	touch $removed &&
> > +	git add $removed &&
> > +	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-env" &&
> > +	FSMONITOR_LIST="$removed" git restore -S $removed &&
> > +	FSMONITOR_LIST="$removed" git status
> > +'
> > +
> >  test_done
