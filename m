Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1AFA1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 13:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbcHaNlO (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 09:41:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35259 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760636AbcHaNlL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 09:41:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so7720766wmg.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DQMq3E1+bfcEiPW4JpQqz/EBcEWfASKFAssgn8uzc8s=;
        b=z8IQ6gWMofCFCa6rqW8D/9W/X5LWpJCJWZt3o0sQUgIjZVBb1I1pURFSEd0kZxvhwC
         pIy+3ZYRgG0NbEh5USqXR3REXlSKNJr2aXSbI4QumU08HfxdlLsk57IY1KqNcpTrc+X6
         lz/gYEI8fkBHp5juS39RpfFyZynbjI309yrULPYMxRMDFWNcdxoN8Lgc1k9H661DVKLL
         v3ywlwnHUtqu4biNm5ZrnqBzDntyEZwRcYFrxErx+ioXu5EUijMTHUVldi4Kcm/cBBqT
         xS7XVkGnK1S640rvosGC2d4jJON64oJXEkQtnzHpZ0S+lH1+Q1n5lrwGbEkoRi2qZmkR
         3O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=DQMq3E1+bfcEiPW4JpQqz/EBcEWfASKFAssgn8uzc8s=;
        b=F9XumOsoTO88xnXkS2KC1lVqG/3bdJFtrn4nh3t7mKI+0AF2W7L3NjOwWhiM+Qdkyp
         r/rXtdW3wcdNQdLGtpzOd2SvVpJR57P69+wZ0lriCgwqxyNAYhNtCggbvL7r5zXgHN0s
         tWMkjgKx7paful3LVvmkzc57uilqzu5C+o8E1A0lgKZiAnjk4Wjs7OQ6jnzBkitxNxoq
         labIoki53Nhrvb+eND2F3YRluy6zFu1yNMazoir+Sgl6B2jsHdjtHXDxUV7ioi0n+PXg
         adobDgbzXyqBWnAtWktNcaGUYGVsBmahM/XqqvNzsdtSDGVJYxgWmyaD5IRWyl2AFbsn
         5plA==
X-Gm-Message-State: AE9vXwPTq+fSrZolATFV6/eppyFRtvoIA9uN/xt9mDwQm+jCJEEr5UOU42nlvydkAmFX7Q==
X-Received: by 10.28.223.9 with SMTP id w9mr10306708wmg.65.1472650869928;
        Wed, 31 Aug 2016 06:41:09 -0700 (PDT)
Received: from [192.168.1.26] (enu134.neoplus.adsl.tpnet.pl. [83.20.10.134])
        by smtp.googlemail.com with ESMTPSA id yt4sm22450723wjc.48.2016.08.31.06.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 06:41:09 -0700 (PDT)
Subject: Re: [PATCH 08/22] sequencer: remove overzealous assumption
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <3c8c60e0799fdf176c72e7e17c257d33b2a362bc.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <09fd1436-301a-b0e1-c32a-81a47e4eb351@gmail.com>
Date:   Wed, 31 Aug 2016 15:41:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <3c8c60e0799fdf176c72e7e17c257d33b2a362bc.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:
> The sequencer was introduced to make the cherry-pick and revert
> functionality available as library function, with the original idea
> being to extend the sequencer to also implement the rebase -i
> functionality.
> 
> The test to ensure that all of the commands in the script are identical
> to the overall operation does not mesh well with that.

Actually the question is what does the test that got removed in this
commit actually check.  Is it high-level sanity check that todo list
for git-cherry-pick contains only 'pick', and for git-revert contains
only 'revert'?  Or does it check that at the low level sequencer
fails when instruction sheet includes only identical operations?

Only if it is the latter (we are testing too low level details of
how sequencer code works, tying too tightly test with implementation)
the test should be removed.  I see that earlier test check that
sequencer handles correctly invalid instructions in todo.

> Therefore let's just get rid of the test that wants to verify that this
> limitation is still in place, in preparation for the upcoming work to
> teach the sequencer to do rebase -i's work.

Is it "upcoming work" as in one of the patches in this series?
If so, which patch?

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t3510-cherry-pick-sequence.sh | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 7b7a89d..6465edf 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -459,17 +459,6 @@ test_expect_success 'malformed instruction sheet 1' '
>  	test_expect_code 128 git cherry-pick --continue
>  '
>  
> -test_expect_success 'malformed instruction sheet 2' '

Hmmm... the description is somewhat lacking (especially compared to
the rest of test), anyway.

BTW. we should probably rename 'malformed instruction sheet 2'
to 'malformed instruction sheet' if there are no further such
tests after this removal, isn't it?

> -	pristine_detach initial &&
> -	test_expect_code 1 git cherry-pick base..anotherpick &&
> -	echo "resolved" >foo &&
> -	git add foo &&
> -	git commit &&
> -	sed "s/pick/revert/" .git/sequencer/todo >new_sheet &&
> -	cp new_sheet .git/sequencer/todo &&
> -	test_expect_code 128 git cherry-pick --continue
> -'
> -
>  test_expect_success 'empty commit set' '
>  	pristine_detach initial &&
>  	test_expect_code 128 git cherry-pick base..base
> 

