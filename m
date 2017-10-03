Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E022C2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 22:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdJCWYS (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 18:24:18 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38228 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbdJCWYR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 18:24:17 -0400
Received: by mail-pg0-f65.google.com with SMTP id y192so11271342pgd.5
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 15:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X8aqNZv+UekpOMz1zLjgsEi8FpKcxkfm+yMoJ8iq+Ak=;
        b=kQO8evF1Sr4g3yF1fv0hrDTx62qWjPn6usNxE/aQl1fy20wiqKBuU3No9tmBNR8kR9
         moCOG7V2ASY4aheJqK7DYtP2EupLgXfY9RUG4qdScU6taYd4TQ1izsjZZvLCwINyjKom
         6knEDaXD90mjTR5IfFAyJT8wvuUsTCJ+SzHIHpRZCwf8PSRVSNZ5Mlx6I890qbPoWJ6O
         03a7Ub3MZjSzXHZwewuQ04sZL3owYR9o68bmmTSUZVVBcj/2/gxnH8+OUL3G2AhEgx0+
         corW5wbtzbwB4dQraFuu0+1FNFhdJtLDlYjLmJaZ/BhihlFr/Au9FQMKAAltavl73TWs
         kI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X8aqNZv+UekpOMz1zLjgsEi8FpKcxkfm+yMoJ8iq+Ak=;
        b=H73aSTRk9jnNJiqdQ9mPccBi0Muz0c45cRFyxf2+m6lYCqGBfmfwbO1E7sBwzjdy0D
         CuPmJ+KLvf4VYEam/881lhxbuHc/o2HZ6ABHM1d/ebHNnoOWczTczAwTxRr1MI1o/3WR
         RJCc5S3/7DaJZh279Sd11wHN7TNoc3fMHjqBGM+AGvzXNlOUKLha2kNAb8xWqLEtvLAg
         HMeggFGHBOrCvVsFYEIhXYooKG84c5n4Yn8IHiFgQA2xeYGSUmNojH5vyVD47V4x2tEN
         7d+Hzwsk28ByHg5haLsRLdFwMNh11NhyWi4xdfrEYO+nJu8uvz/ZuW38OPao5t4HqQTh
         nV7Q==
X-Gm-Message-State: AHPjjUiHVKrc0vmGqoddDVqImuwoz03ehhjLL3QQ2uIWZYdIu4VnkGLk
        PIvSZuwXiKWodXbop0365fo=
X-Google-Smtp-Source: AOwi7QDznqNlxSNhz82SZYQE///OCw6QBl+jHajK5We2PMbjbnUenE0FGIxPTVdg8jcreklYNrnp4Q==
X-Received: by 10.84.254.70 with SMTP id a6mr17987325pln.71.1507069457118;
        Tue, 03 Oct 2017 15:24:17 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:3463:ab6b:5863:927c])
        by smtp.gmail.com with ESMTPSA id p6sm20949834pga.93.2017.10.03.15.24.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 15:24:16 -0700 (PDT)
Date:   Tue, 3 Oct 2017 15:24:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: reset instead of release a strbuf
Message-ID: <20171003222414.GC19555@aiede.mtv.corp.google.com>
References: <20171003214646.GZ19555@aiede.mtv.corp.google.com>
 <20171003221740.26325-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171003221740.26325-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> Our documentation advises to not re-use a strbuf, after strbuf_release
> has been called on it. Use the proper reset instead.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

This is indeed
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thank you.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/branch.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here's a patch to address the surprising strbuf.h advice.

-- >8 --
Subject: strbuf: do not encourage init-after-release

strbuf_release already leaves the strbuf in a valid, initialized
state, so there is not need to call strbuf_init after it.

Moreover, this is not likely to change in the future: strbuf_release
leaving the strbuf in a valid state has been easy to maintain and has
been very helpful for Git's robustness and simplicity (e.g.,
preventing use-after-free vulnerabilities).

It is still not advisable to call strbuf_release until done using a
strbuf because it is wasteful, so keep that part of the advice.

Reported-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 strbuf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.h b/strbuf.h
index 7496cb8ec5..6e175c3694 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -83,7 +83,7 @@ extern void strbuf_init(struct strbuf *, size_t);
 
 /**
  * Release a string buffer and the memory it used. You should not use the
- * string buffer after using this function, unless you initialize it again.
+ * string buffer after using this function.
  */
 extern void strbuf_release(struct strbuf *);
 
-- 
2.14.2.920.gcf0c67979c

