Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3204B1F404
	for <e@80x24.org>; Sat, 27 Jan 2018 12:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeA0MPf (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 07:15:35 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:53663 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbeA0MPe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 07:15:34 -0500
Received: by mail-wm0-f51.google.com with SMTP id t74so5930906wme.3
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 04:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MqiBxcgq/tW63hgHuAHZSG4L/4ViNaTmh80ky8P+VY4=;
        b=rJxuBMlhanAoyxUl7+ph8SnkNlGFAocBq83FAmSasyY6dPrajjWFUEqSmKlSSfcfwu
         mI74PwfFurG+gvFDrjmQycNMJLMlNnQ8bBM1CW2FWidVMszXdC3YHFTGSvQeIh7sXCsz
         M/w5b0Ff9dLW4zylWb9aksFqIF11D01IxfpxqOQXUmdSvUKkrjNAcWEJLxG1dQLGl9I0
         gTcRWSN3gmFkU0K7bcHI9uJeoR4rXNfShOSUi5QGkF5GjSpQ4RYsAHJ/UKqaXg7gAFEz
         YtgsLxEsSZvnoxJ6TAzlC3ewbkhcIkfsKepebtEjeoZSYXUniOR2wJFpTkNatkr0aeYE
         /2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MqiBxcgq/tW63hgHuAHZSG4L/4ViNaTmh80ky8P+VY4=;
        b=kKXnFt75V+iZo/9gXJi0cFwK1VQCN+1s/9KHmCa18yfiHMURkWjYupZ1x4y7fhBxZ/
         1g/dHKtbbEc09sUfuffzztFImKOBa+NveuaZb/MLAKrB84Mc/9galBqh24/h06BPbrRd
         /W38QN8KfBG+BaLP10Qr6WfPgISc+Fa6Q973GwFsio4ZLeO1inlcmLp/pt0RKsoJRMIN
         pmDYWRcffYazYEm/3emuQNs0hzqRyLCKmscR7/fg+KCvD2cR8nSKcissjuE85RouF37f
         zjFY4t4YDj01ZVBntSzBG5X3AkrPxJPOkEJQAsF1vaTtdJuyFqFW949rBH1l6nMCqozu
         RNsg==
X-Gm-Message-State: AKwxytd8R1tVJ+XZlJk8hdIsgZ1W41pxzqI3j2M/Eva8BvGedmhaY94w
        d0ywuU0VOO4fM2WB3I+C1k4=
X-Google-Smtp-Source: AH8x224QBpBJKhDerPW5+vJxnzUbiSAGXwzdzIg/8JBfraPw6PImA0lnyh/xvwc3SSFbwI/e2FMi2g==
X-Received: by 10.28.48.10 with SMTP id w10mr13880761wmw.93.1517055333042;
        Sat, 27 Jan 2018 04:15:33 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id k60sm4618860wrc.2.2018.01.27.04.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 04:15:32 -0800 (PST)
Date:   Sat, 27 Jan 2018 12:18:01 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for
 other repos
Message-ID: <20180127121801.GC2130@hank>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180107223015.17720-2-t.gummerer@gmail.com>
 <xmqq1silpl4g.fsf@gitster.mtv.corp.google.com>
 <20180120115819.GR2641@hank>
 <xmqqpo62mncc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpo62mncc.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/21, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > On 01/19, Junio C Hamano wrote:
> >> Thomas Gummerer <t.gummerer@gmail.com> writes:
> >> 
> >> > read_cache_from() defaults to using the gitdir of the_repository.  As it
> >> > is mostly a convenience macro, having to pass get_git_dir() for every
> >> > call seems overkill, and if necessary users can have more control by
> >> > using read_index_from().
> >> 
> >> This was a bit painful change, given that some changes in flight do
> >> add new callsites to read_index_from() and they got the function
> >> changed under their feet.
> >
> > Sorry about that.  Is there any way to make such a change less painful
> > in the future?
> 
> One way is to do for read_index_from() what you did for the existing
> users of read_cache_from().  Introduce a _new_ helper that will not
> be known for any existing topics in flight, and use that to make the
> existing API a thin wrapper around it.

I'll do that next time.  My worries were just that the
'read_index_from()' API is broken with split index, which is what this
series fixes.  It would be easy to introduce new breakages if we're
not careful.

> I _think_ I got it right with evil merge, so unless this fix needs
> to be delayed for extended period of time for whatever reason while
> any more new callers of the function appears (which is unlikely), we
> should be OK ;-)

Thanks!  As mentioned there's one call that was added that the evil
merge didn't get quite right, for which I sent the diff below in my
previous email.  But I'm happy to fix that on top once this series
goes to master or next if that's preferred.

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6a49f9e628..4d86a3574f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -612,7 +612,8 @@ static void validate_no_submodules(const struct worktree *wt)
        struct index_state istate = {0};
        int i, found_submodules = 0;
 
-       if (read_index_from(&istate, worktree_git_path(wt, "index"), get_git_dir()) > 0) {
+       if (read_index_from(&istate, worktree_git_path(wt, "index"),
+                           get_worktree_git_dir(wt)) > 0) {
                for (i = 0; i < istate.cache_nr; i++) {
                        struct cache_entry *ce = istate.cache[i];
 
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index b3105eaaed..8faf61bbf5 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -90,6 +90,16 @@ test_expect_success 'move main worktree' '
        test_must_fail git worktree move . def
 '
 
+test_expect_success 'move worktree with split index' '
+       git worktree add test &&
+       (
+               cd test &&
+               test_commit file &&
+               git update-index --split-index
+       ) &&
+       git worktree move test test-destination
+'
+
 test_expect_success 'remove main worktree' '
        test_must_fail git worktree remove .
 '

> Thanks.
