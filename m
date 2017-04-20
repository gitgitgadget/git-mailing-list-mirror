Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311B2207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 09:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031117AbdDTJ7i (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 05:59:38 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35150 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031112AbdDTJ7e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 05:59:34 -0400
Received: by mail-oi0-f46.google.com with SMTP id j201so43313924oih.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 02:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6M/sQl1Qe/59PZ1sIZ4Aureu1PRNM2iIj+BBaYXX/XA=;
        b=RBvN2vDYox3wAIl3AQAAS6xtWNZS1Ul6G9yp9DpKc8VAbXqDSji8u2urexDsaJekiS
         0EtA7qu584giPlVhessmCTDmbCvZ+qUD9eGN2Ft4ntREjmNA5X/+pYi2Wt8m6zZgU5YU
         8nHCddQKS0WOJRsx8uP48pd1ObU9P2VkUSVPNKCmoZbMCRGCtCMl64urTRsvxfs8DDHT
         TY0dpBlQ0RVJt4uOzm16KD6FLLiQPRuFMrYII8/LN71ruJznqiMw0h4GgBzDxbOzb2Bo
         ZQr5/rPws4Q+W4gFXWnDW3ROjdQZmP3SLSg+LCd2IxMbLisGHnt9ve8BWLrlPUucVCdw
         T+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6M/sQl1Qe/59PZ1sIZ4Aureu1PRNM2iIj+BBaYXX/XA=;
        b=lNA11BxvmViSvXhUrMngSqn6/gxigrO73b3koJEesqqvtWpwqBmh1hzqyEUklrLkau
         1162WKBrP1F7cD7XzzTlxeceX9rtX/3zthd/GlURA7rfaNCehdYzITunjrPUgtXAvO6H
         TviTYdpdC2wc9zs8peAakhmb1HNRtae1OAlXu8ZnVvJkIuZa9vFbI+rf0I34GlAnNbnE
         3rdXhPVwktKa0IskhHRVXtMbTFDUio4hhk6k9xCN5L5pLypo/aP1mRg5yNUWTR/0RkRs
         ThSbWk5kvn/05WfAX/B+iC9XcIMEWEvz1kM/xBHheOHAlO99xqmGJgxVStG6ZDDS4iik
         +Hkg==
X-Gm-Message-State: AN3rC/4+ri88PNSHuBPyuu9E8KUxCN4xKje1mLEYLH0NnM0P2c7WubEJ
        9NoE43MPPHJZqR2+
X-Received: by 10.84.224.70 with SMTP id a6mr9314087plt.25.1492682368330;
        Thu, 20 Apr 2017 02:59:28 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id 4sm9466698pff.17.2017.04.20.02.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 02:59:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 16:59:21 +0700
Date:   Thu, 20 Apr 2017 16:59:21 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
Message-ID: <20170420095921.GA23873@ash>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 10:37:21PM -0700, Junio C Hamano wrote:
> * nd/worktree-add-lock (2017-04-16) 2 commits
>  - SQUASH???
>  - worktree add: add --lock option
> 
>  Allow to lock a worktree immediately after it's created. This helps
>  prevent a race between "git worktree add; git worktree lock" and
>  "git worktree prune".
> 
>  Waiting for a response to SQUASH???

Looking good. I would add some comment, lest ';' feel lonely. But it's
really personal taste.

-- 8< --
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5ebdcce793..bc75676bf3 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -310,7 +310,7 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 	if (!ret && opts->keep_locked)
-		;
+		;	      /* --lock wants to keep "locked" file */
 	else
 		unlink_or_warn(sb.buf);
 	argv_array_clear(&child_env);
-- 8< --
