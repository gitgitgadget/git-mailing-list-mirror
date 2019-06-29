Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742401F461
	for <e@80x24.org>; Sat, 29 Jun 2019 08:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfF2IZC (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 04:25:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34197 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfF2IZC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 04:25:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id u18so375910wru.1
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 01:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lAJJ9ANFYzsa3KcaGvysvyCgjfEPvuUqViD63nvZ6yk=;
        b=bJDpQd/FHZ2PqWMqT9e+cbDuUUD4izRcqYd8WnoWE9+sA8xbV4XDHhEaQ9TdH65z0f
         gcEpZtwlsvy3TFEF1M99eYMBBKPdUWoTB3SMgfjpesSdVabjIVKR/ehFn/QLqYinmVqB
         1vGjMIOHW6VJoslSKJfID5cxOltNy04mko+mTUC+xMFopPPuVew6AYJBmPFQGVwinsa+
         SNtkGAGT1Ho11UONpTYzRl8le3kFBk/enef2r7X88AS/6GeykyshjER443pJVzwGb/wM
         /9E+Mm544rL5d1PU020LosJbcFym83LwnmGbUpJ6J0zeKMQfQr3NFKG6rdCjiUkCL26k
         jpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lAJJ9ANFYzsa3KcaGvysvyCgjfEPvuUqViD63nvZ6yk=;
        b=e1VA30P5OJaAzsYQqUQPXy04kwkqnuRMffU4ZMwQiof9NLF4U/KMhOg1gfiLjq0Qdk
         jzW1F/suHLVt18E86lSTXSBelqhkS/tGSYwvGT8hZAeIgyOxwolhcYGQX7dnI8U98eo3
         9dRgjVfrYvVydZscRsd19dc1Cc6EM4HBkbdkoiff/UnAzteXDMkhs5wgPhsw9j4gbnE0
         c1b5+uGiVnd7VU++ipaUenp2jv4nHdFoGjTUofnbTFNYOmNm6zelXQIHBiBBhw1TUrMp
         OlXb9Tpj5RZGxJv+Lz8JIq1wp2FgzEw0zmXyrEoq02qoEMXS606mZZtb8KU0aO7Wd/8A
         GW1Q==
X-Gm-Message-State: APjAAAUuCHE2nKD58AOLHBmzABdY+jtZ/0Y6IegGjlzkLCSJKHDdMpFE
        QWiaTOWwGutFfhgRDjqKaNM=
X-Google-Smtp-Source: APXvYqxUlHbGoWy0/5w1P1S3pN6xmRvi16C5Gj4x39z1c5fJAhPOANhkhbGXzdzibDPLRtV+Y4k3TA==
X-Received: by 2002:adf:fb84:: with SMTP id a4mr11733664wrr.41.1561796699649;
        Sat, 29 Jun 2019 01:24:59 -0700 (PDT)
Received: from szeder.dev (x4db511ea.dyn.telefonica.de. [77.181.17.234])
        by smtp.gmail.com with ESMTPSA id l1sm3293600wmg.13.2019.06.29.01.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 01:24:58 -0700 (PDT)
Date:   Sat, 29 Jun 2019 10:24:57 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] test-lib: introduce test_commit_bulk
Message-ID: <20190629082457.GE21574@szeder.dev>
References: <20190628093751.GA3569@sigill.intra.peff.net>
 <20190628093911.GA27329@sigill.intra.peff.net>
 <CAPig+cQAKVOqYH-CcqzViP_zuKwg5fWO2_i8=Z5t=BVf9uoAXQ@mail.gmail.com>
 <20190628230417.GC21574@szeder.dev>
 <CAPig+cQnvotvJakCp1ic_WP3AMojNmfZw-PoinR=VOODmtNBtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQnvotvJakCp1ic_WP3AMojNmfZw-PoinR=VOODmtNBtw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 07:46:02PM -0400, Eric Sunshine wrote:
> On Fri, Jun 28, 2019 at 7:04 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > On Fri, Jun 28, 2019 at 05:32:35PM -0400, Eric Sunshine wrote:
> > > On Fri, Jun 28, 2019 at 5:39 AM Jeff King <peff@peff.net> wrote:
> > > > +       in_dir=${indir:+-C "$indir"}
> > >
> > > Doesn't this suffer the problem in which some older/broken
> > > shells[1][2][3][4] incorrectly [...]
> >
> > I think we don't need any of those "${indir:+-C "$indir"}" parameter
> > expansions and could simply use 'git -C "$indir" cmd...' everywhere.
> > $indir is set to empty right at the start of the function, and 'git -C
> > "" ...' works and doesn't change the working directory.
> 
> I recall the discussion around the meaning of `-C ""` when that
> command line option was introduced. The conclusion was that  the
> zero-length argument should mean "this directory" since that's how `cd
> ""` behaves. However, I don't think that behavior ever got documented,

Although it's not documented (but see the patch below), we do
explicitly test it since 6a536e2076 (git: treat "git -C '<path>'" as a
no-op when <path> is empty, 2015-03-06) and e.g. our completion script
relies on this behavior.

> and it's not necessarily obvious. An alternative would be to default
> 'indir' to ".", which should give the same result and be easily
> understood.

That's fine for me as well.


   --- >8 ---

Subject: [PATCH] Document that 'git -C ""' works and doesn't change directory

It's been behaving so since 6a536e2076 (git: treat "git -C '<path>'"
as a no-op when <path> is empty, 2015-03-06).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/git.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index f9b09db89b..a9deca0acb 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -57,7 +57,8 @@ help ...`.
 	Run as if git was started in '<path>' instead of the current working
 	directory.  When multiple `-C` options are given, each subsequent
 	non-absolute `-C <path>` is interpreted relative to the preceding `-C
-	<path>`.
+	<path>`.  If '<path>' is present but empty, e.g. `-C ""`, then the
+	current working directory is left unchanged.
 +
 This option affects options that expect path name like `--git-dir` and
 `--work-tree` in that their interpretations of the path names would be
-- 
2.22.0.589.g5bd7971b91

