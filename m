Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C42ED1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 11:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeJKTFg (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 15:05:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46989 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeJKTFg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 15:05:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id g32-v6so7916676edg.13
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 04:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9jdO5RSeknqXV3qs/d8RcN/834e/8cXrQxO+vyOoZJQ=;
        b=MkJ5s3HvDJlXEcbta2oTPR5aFV1i9Zbq+39EoI6Qh1sooZeybmyOOXnZLT/OW35iGq
         qot8HwMCHIynEbSXDDBfCKFPwQ/dOyshf/yNAT8LUpLVP8CeY+BqlsRRQ+TZYr91agzZ
         c6kMr3VXc00g+eXQlMGM6h9pwHGrH/W2FowkYGUw/eTpk0NTy/zS5vGvUPFrDBj1CLr7
         HYpTu9goWKYCykgp0JAU0hUS1hYl928DHipnww830JwASrOtuORjIuiMtCZRj50dEHdH
         DRnq3Te4gVQKu754gvWxReIsD5nGxQjkdPU494RTAPBIZoyHD8LSe0bJLS7k5YeHuBxJ
         PBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9jdO5RSeknqXV3qs/d8RcN/834e/8cXrQxO+vyOoZJQ=;
        b=iT51C4YCiZdnJOGYpOeFpMWYgxFVZRXhhOTk4QsDRn2RsWKCoXYCCdFlgbkNy6SHWH
         qFm9aE4blbeNVt1Dq9Hcbd4CXlKVo9hDozPC+jNjtuD2+dUeSlOEh2f19ew1MuuesjDF
         gbRK859ZH7moqFexM60GoSG4XOsnhCFa5cEYN09o8vovh+2GSo9qTfhyApj9Q9NGii7q
         gaGXsUmHsJLktTSarjTJRxGos0WW2YZ7527r2/kO90tSirKoE5Su60fyy4sEoHpHA0S7
         Cw0wUgzGZgxN6TjHRwuwlPpZVmk/KacVGQIbXj6uGz7d1oAC7FOlReC/LsjPZz2ZB2+X
         Fqfg==
X-Gm-Message-State: ABuFfojMrGy2AlmqzZZGLJbHBKFqnhR4UxtqXTsT5hjEXoXwA6iVP1R6
        AeazWCl2whcO7UfkUAOeKcw=
X-Google-Smtp-Source: ACcGV611W2a4XJ8l8V1MVq/lh+waiqNu7S7JKRHIj/qog2IZHhxfPleOvWvimBJqUeYgFv6tjAasDg==
X-Received: by 2002:a50:eb42:: with SMTP id z2-v6mr2219276edp.126.1539257924670;
        Thu, 11 Oct 2018 04:38:44 -0700 (PDT)
Received: from szeder.dev (x4dbd43b4.dyn.telefonica.de. [77.189.67.180])
        by smtp.gmail.com with ESMTPSA id dv2-v6sm4200919ejb.10.2018.10.11.04.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 04:38:43 -0700 (PDT)
Date:   Thu, 11 Oct 2018 13:38:41 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Fix the racy split index problem
Message-ID: <20181011113841.GB19800@szeder.dev>
References: <20180928162459.17138-1-szeder.dev@gmail.com>
 <20181011094309.18626-1-szeder.dev@gmail.com>
 <87d0sgepmo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0sgepmo.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 12:36:47PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Oct 11 2018, SZEDER Gábor wrote:
> 
> > Fourth and hopefully final round of fixing occasional test failures when
> > run with 'GIT_TEST_SPLIT_INDEX=yes'.  The only code change is the
> > extraction of a helper function to compare two cache entries' content,
> > and then a couple of minor log message clarifications.  The range-diff
> > below is rather clear on that.
> 
> Looks good. I'm not going to run the stress test I did on v5 on this
> since the changes are just moving existing code into a fuction, unless
> you'd like me to or think there's a reason to that is.

FWIW, I intend to carry this patch below and use it in tests both
locally and on Travis CI.  I could never trigger any of those three
conditions by repeated test runs with 'GIT_TEST_SPLIT_INDEX=yes', or
by deliberately constructing tricky scenarios where they might be
triggered.

Perhaps with enough time I'll get lucky eventually :)

If it's not too much trouble, then perhaps you could pick it up as
well?  While testing previous versions of this series it turned out
that your setup has much more "luck" in finding problematic timings
than mine.


diff --git a/split-index.c b/split-index.c
index 5820412dc5..4af535e236 100644
--- a/split-index.c
+++ b/split-index.c
@@ -254,8 +254,8 @@ void prepare_to_write_split_index(struct index_state *istate)
 				continue;
 			}
 			if (ce->index > si->base->cache_nr) {
-				BUG("ce refers to a shared ce at %d, which is beyond the shared index size %d",
-				    ce->index, si->base->cache_nr);
+				BUG("ce of '%s' refers to a shared ce at %d, which is beyond the shared index size %d",
+				    ce->name, ce->index, si->base->cache_nr);
 			}
 			ce->ce_flags |= CE_MATCHED; /* or "shared" */
 			base = si->base->cache[ce->index - 1];
@@ -293,10 +293,9 @@ void prepare_to_write_split_index(struct index_state *istate)
 				continue;
 			}
 			if (ce->ce_namelen != base->ce_namelen ||
-			    strcmp(ce->name, base->name)) {
-				ce->index = 0;
-				continue;
-			}
+			    strcmp(ce->name, base->name))
+				BUG("ce of '%s' refers to the shared ce of a different file '%s'",
+				    ce->name, base->name);
 			/*
 			 * This is the copy of a cache entry that is present
 			 * in the shared index, created by unpack_trees()
@@ -332,7 +331,8 @@ void prepare_to_write_split_index(struct index_state *istate)
 				 * set CE_UPDATE_IN_BASE as well.
 				 */
 				if (compare_ce_content(ce, base))
-					ce->ce_flags |= CE_UPDATE_IN_BASE;
+					BUG("ce of '%s' differs from its shared ce, but the CE_UPDATE_IN_BASE flag was not set",
+					    ce->name);
 			}
 			discard_cache_entry(base);
 			si->base->cache[ce->index - 1] = ce;
