Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57FC1F4C0
	for <e@80x24.org>; Mon, 11 Nov 2019 19:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfKKT4p (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 14:56:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40152 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKKT4p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 14:56:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id i10so16005501wrs.7
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 11:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eyduzFCtMWPi2qm2+8EsXE5knf9Hsd2s+snCjC68dHQ=;
        b=eI1D+Wo3xu0Sbuhlj9+ImXDo2oyKI5B/OyuLKPVo+hIgHdgLos2VjUxPRGumIP+uWW
         JNJD1LG9s2IHyVOkEnbU9DxiNLWsA2ZiVaqA17ODgGpsYaLlGRNSqQPBZbyRQ3yrIyGo
         6BfXWP+K0HDDoALvUkGujaiJBipXRpplo0bYZK2+1H9AZPE8Rvg7lvaLwcwitwxrQNSB
         b7lomeu2MjVZNYjxjmxj10paZn7UlssbUkkyxMTsE2WqOcJyg21YEDyiux3Ef1mcBsey
         HswfUSc5riL6gNKYUfCvgozsy2wRx9LJhkOISyfn92Ue4LrGVcu4H9jcShCQhjZ+AqCj
         7h5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eyduzFCtMWPi2qm2+8EsXE5knf9Hsd2s+snCjC68dHQ=;
        b=Muyn/gYbO8ZN+6w1MQ6BqegN/dXdxGnpg0+P8kva2gG1+fjxgX7H0sER+WYx9CfZMA
         zW6OeXMAQyMVHT6ROjepehv9jt8ESwPDuc5l16GPdyB4+8TpcIXzAm55aWARw11FM0Oo
         mnSXeLna+G+2i2Bi+HATajoiannZ+kdc9pG/jabBWP98wAW1rrAz+Xmh+Udk9hC9BEdD
         mGe21FMtnG0eXHlW9/angGsuczF5BGmV1gQ77nDqvEvtxvVzrwXiwCYwl6whdptafmQ+
         ycCRrU5MNdpKSkD5b52LZo3UuISNDAAEPIUVtzCJWeaAJhPqv5YO9rBNRtMWryo3sMK2
         u4cg==
X-Gm-Message-State: APjAAAXDUBOQrZxtO1DSbTRbt5TanW43TGIQvSpOT+A3fkC1+UdHfLAQ
        nCRCQ9iNujHGhaSqQ9prM4U=
X-Google-Smtp-Source: APXvYqzHaJrgEk7skMfruptP9dIxk/2QkqrW/kWOtyLwatMBfNLmZ3g+Xu3lr3oj8NqpJ+rEl8JwfQ==
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr22630773wru.211.1573502202824;
        Mon, 11 Nov 2019 11:56:42 -0800 (PST)
Received: from localhost ([95.149.189.152])
        by smtp.gmail.com with ESMTPSA id n1sm19482277wrr.24.2019.11.11.11.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Nov 2019 11:56:41 -0800 (PST)
Date:   Mon, 11 Nov 2019 19:56:41 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Grzegorz Rajchman <rayman17@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] git stash pop --quiet deletes files in git 2.24.0
Message-ID: <20191111195641.GC3115@cat>
References: <CAMcnqp22tEFva4vYHYLzY83JqDHGzDbDGoUod21Dhtnvv=h_Pg@mail.gmail.com>
 <20191107184912.GA3115@cat>
 <xmqq7e4bp06l.fsf@gitster-ct.c.googlers.com>
 <20191108165929.GB3115@cat>
 <xmqqk188l0pn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk188l0pn.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > On 11/08, Junio C Hamano wrote:
> >> So, I do not think removing that discard_cache() alone solves the
> >> breakage exposed by 34933d0eff.  Discarding and re-reading the
> >> on-disk index there would restore correctness, but then you would
> >> want to make sure that we are not wasting the overall cost for the
> >> I/O and refreshing.
> >> 
> >> I think the safer immediate short-term fix is to revert the change
> >> to the quiet codepath and let it only refresh the in-core index.
> >
> > Yup, this is certainly my bad, we shouldn't be writing the discarded
> > index of course.  I don't think what we were doing here before was
> > correct either though.  The only thing that would be called after this
> > is 'do_stash_drop()', which only executes external commands.
> 
> Right.  Removing discard alone would not be a correct fix exactly
> for that reason: the in-core index was stale wrt the on-disk index.
> 
> If the program later used in-core index for further processing
> (which is not, and that is why the short-term solution of reverting
> that hunk would work), we would have been operating on a wrong data.
> So for the fix that keeps data we have in-core always up-to-date, we
> should be re-reading from the on-disk index there after discard().
> 
> And in the longer term, it would likely be the right direction, as
> the "git status" invocation on the non-quiet codepath would want to
> become an in-core direct calls into wt-status machinery instead of
> fork+exec eventually.

Right.  I'd argue that that's even the right direction in the short
term.  It does require some more I/O but it also prevents similar
mistakes.  And I don't think one additional read of the index is going
to make it or break it for performance here, there are plenty of reads
already, and there's probably better ways to speed 'git stash' up.

> > From what you are saying above, and from my testing I think this
> > refresh is actually unnecessary, and we could just remove it outright.
> 
> Perhaps.  But later it will bite us when somebody wants to rewrite
> the "status at the end" part in C.

Hmm, wouldn't the not re-reading the index part bite us there, rather
than the not refreshing the index?

In the 'has_index' codepath, we write the index to disk, so we already
have a fresh one in-core.  This codepath is what used to require
refreshing the index afterwards, but no longer does.

Previously we used to use 'git read-tree "$unstashed_index_tree"'
there, which does require a 'git update-index -q --refresh'
afterwards.  However we have replaced that with an internal call to
'reset_tree', which always sets 'o.merge = 1' for unpack-trees.  Which
in turn means that the index is already refreshed appropriately iiuc.

In the other codepath we do 'git update-index --add --stdin', which
also doesn't require refreshing the index, but does require the
'discard_cache()' + 'read_cache()' afterwards, so we're not left in a
half state.

> Besides, if the original was "update-index -q --refresh" in the
> scripted Porcelain after an pop was attempted, it would have shown
> the unmerged paths as "needs merge", wouldn't it?  For that, we need
> to have something (I do not remember if refresh_and_write_cache()
> would be the in-core API call to do so offhand).

The original used 'git status >/dev/null 2>&1' to refresh the index
after the 'git read-tree' I mentioned above, but would not show the
"needs merge" message, so I think we're okay on that front.

Below is the patch that I believe has the least chances of biting us
in the future, with the appropriate updated tests.  I had considered
leaving the 'refresh_and_write_cache()' call there, but as I was
writing the commit message I had a harder and harder time justifying
that, so it's gone now, which I think is the right thing to do.
Leaving it there would be okay as well, however I don't think it would
have any benefit.

--- >8 ---
Subject: [PATCH] stash: make sure we have a valid index before writing it

In 'do_apply_stash()' we refresh the index in the end.  Since
34933d0eff ("stash: make sure to write refreshed cache", 2019-09-11),
we also write that refreshed index when --quiet is given to 'git stash
apply'.

However if '--index' is not given to 'git stash apply', we also
discard the index in the else clause just before.  This leads to
writing the discarded index, which means we essentially write an empty
index file.  This is obviously not correct, or the behaviour the user
wanted.  We should not modify the users index without being asked to
do so.

Make sure to re-read the index after discarding the current in-core
index, to avoid dealing with outdated information.

We can drop the 'refresh_and_write_cache' completely in the quiet
case.  Previously in legacy stash we relied on 'git status' to refresh
the index after calling 'git read-tree' when '--index' was passed to
'git apply'.  However the 'reset_tree()' call that replaced 'git
read-tree' always passes options that are equivalent to '-m', making
the refresh of the index unnecessary.

We could also drop the 'discard_cache()' + 'read_cache()', however
that would make it easy to fall into the same trap as 34933d0eff did,
so it's better to avoid that.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash.c  | 6 ++----
 t/t3903-stash.sh | 5 ++++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index ab30d1e920..d00567285f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -482,12 +482,10 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 			return -1;
 
 		discard_cache();
+		read_cache();
 	}
 
-	if (quiet) {
-		if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
-			warning("could not refresh index");
-	} else {
+	if (!quiet) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 
 		/*
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 392954d6dd..b1c973e3d9 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -232,8 +232,9 @@ test_expect_success 'save -q is quiet' '
 	test_must_be_empty output.out
 '
 
-test_expect_success 'pop -q is quiet' '
+test_expect_success 'pop -q works and is quiet' '
 	git stash pop -q >output.out 2>&1 &&
+	test bar = "$(git show :file)" &&
 	test_must_be_empty output.out
 '
 
@@ -242,6 +243,8 @@ test_expect_success 'pop -q --index works and is quiet' '
 	git add file &&
 	git stash save --quiet &&
 	git stash pop -q --index >output.out 2>&1 &&
+	git diff-files file2 >file2.diff &&
+	test_must_be_empty file2.diff &&
 	test foo = "$(git show :file)" &&
 	test_must_be_empty output.out
 '
-- 
2.24.0.155.gd9f6f3b619

