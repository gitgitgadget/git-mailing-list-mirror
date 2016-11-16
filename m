Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 915DD2042F
	for <e@80x24.org>; Wed, 16 Nov 2016 13:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbcKPNFl (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 08:05:41 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36806 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbcKPNFk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 08:05:40 -0500
Received: by mail-pf0-f196.google.com with SMTP id c4so7290812pfb.3
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 05:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Oasq+V392nG8B40ACbqi2kXytIRtxEEqg6OM4qXsZ7s=;
        b=OoJpAZLH7VKDvB4tgKWCiCQoTBbDgoLNs7EPhuW0YWpCrmbPboIrTjaDWaYCXrVmRS
         /+qUgf2S5mW15ygdI83bSMs68d5TxxRaA8X0eZjXL8zqtsj8ojrzd2lUFo9i0EuycZ3C
         nspmMleaDYmaIbypgkx5u3f5J7ki0ebzROfldCH7oCwEHLuM9r8DF3019wRMMCBp6xv5
         AdILbKjHr1tKzE43sN9TTlLQ9JzCGCywwLYgA3KEQB9lU885lg2pEs0iZI/WcjpvZ1b8
         aH5E5Ew7A7fmicL5yEnvNZ+9/W+fVhw5RW76aWCsxCsEjwQr95m2OQKJv2AfoVpuv894
         aI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Oasq+V392nG8B40ACbqi2kXytIRtxEEqg6OM4qXsZ7s=;
        b=JsGY2xXZIuk3gALSRAOlkEnY/3d3/HFZJZtwUYm5eNWMr+rrdT4BMWZnP1OfodUnoD
         zcF3Xp8bW7RhSAgk/Ho3PHHvGnGGeF0M6kWFNoooJ1T1Be5eyIsiZZv1IAu94gB4KSrY
         55oRew/H8pKxHowwBkg98LHGwJhbkUIv7mwdAEqGlWMKjyRD2WjD4Yz1Do5peFIzhFvu
         jIybS2Wi7dz5R40oKlOC5N34mdHWmjgUZ+0RFMffV8F+Nrw3UPIyECH3p9iLPxJXOx1W
         YTnlQ6ymoQ/xRF3xs80S7BNX2KLtafUaWilWz4uIZkw891UKBjrge6jswY+E7xM6drYY
         lnEA==
X-Gm-Message-State: ABUngvezmKwYF8QE3JzH/+bilFbbCDgKcmg6p4frXD4dACz50FFvBJ3DHeTLQidSO2sHBA==
X-Received: by 10.98.56.149 with SMTP id f143mr4320521pfa.106.1479301539937;
        Wed, 16 Nov 2016 05:05:39 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id m19sm21112731pfi.24.2016.11.16.05.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Nov 2016 05:05:38 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 16 Nov 2016 20:05:34 +0700
Date:   Wed, 16 Nov 2016 20:05:34 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] git worktree (re)move
Message-ID: <20161116130533.GA5393@ash>
References: <20161112022337.13317-1-pclouds@gmail.com>
 <xmqqeg2gyv1v.fsf@gitster.mtv.corp.google.com>
 <xmqqa8d4yts7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa8d4yts7.fsf@gitster.mtv.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2016 at 06:53:44PM -0800, Junio C Hamano wrote:
> not ok 12 - move worktree
> #	
> #		git worktree move source destination &&
> #		test_path_is_missing source &&
> #		git worktree list --porcelain | grep "^worktree" >actual &&
> #		cat <<-EOF >expected &&
> #		worktree $TRASH_DIRECTORY
> #		worktree $TRASH_DIRECTORY/destination
> #		worktree $TRASH_DIRECTORY/elsewhere
> #		EOF
> #		test_cmp expected actual &&
> #		git -C destination log --format=%s >actual2 &&
> #		echo init >expected2 &&
> #		test_cmp expected2 actual2

I think I've seen this (i.e. 'expected' and 'actual' differ only in
the order of items) once after a rebase and ignored it, assuming
something was changed during the rebase that caused this.

The following patch should fix it if that's the same thing you saw. I
could pile it on worktree-move series, or you can make it a separate
one-patch series. What's your preference?

-- 8< --
Subject: [PATCH] worktree list: keep the list sorted

It makes it easier to write tests for. But it should also be good for
the user since locating a worktree by eye would be easier once they
notice this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 worktree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/worktree.c b/worktree.c
index f7869f8..fe92d6f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -173,6 +173,13 @@ static void mark_current_worktree(struct worktree **worktrees)
 	free(git_dir);
 }
 
+static int compare_worktree(const void *a_, const void *b_)
+{
+	const struct worktree *const *a = a_;
+	const struct worktree *const *b = b_;
+	return fspathcmp((*a)->path, (*b)->path);
+}
+
 struct worktree **get_worktrees(void)
 {
 	struct worktree **list = NULL;
@@ -205,6 +212,11 @@ struct worktree **get_worktrees(void)
 	ALLOC_GROW(list, counter + 1, alloc);
 	list[counter] = NULL;
 
+	/*
+	 * don't sort the first item (main worktree), which will
+	 * always be the first
+	 */
+	qsort(list + 1, counter - 1, sizeof(*list), compare_worktree);
 	mark_current_worktree(list);
 	return list;
 }
-- 
2.8.2.524.g6ff3d78

-- 8< --
