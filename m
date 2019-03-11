Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A80F920248
	for <e@80x24.org>; Mon, 11 Mar 2019 09:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfCKJrW (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 05:47:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42869 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfCKJrV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 05:47:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id b2so3608933pgl.9
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 02:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QeQexjqTV5Wy7eISETlPhelzTW+ozrBLtrFieIWmAso=;
        b=mD8uiF2TYRHcp2pJEfuCW2TkMITjgd6tmFrFIacfljZxB9gPrT+RQOLsTXoDzEk2HR
         SksH4/ygo4xfGiGkmq2bwL6rhEDRk6WVVwsndRwGnDt2q2i29+k9cfnvLXuqCdXt2xL9
         QadzcCrM3KqV0sjIQongV3cswekRzYwgYbqaobT/SZR9JjXkadMfIXko4E6pzfyNb6El
         b+5mGtgy1DnioPxgI6/33/q8m0WUc333HPY08DTdKuPqaxdWBBH2jbA11bB0pef9tVwo
         AdPnrCodNJtbgvYmNwW9PDZwe0ut9oCq7xeUZZD9lDAZjL3xnRiEDfuPElmxde+xUWZ5
         LaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QeQexjqTV5Wy7eISETlPhelzTW+ozrBLtrFieIWmAso=;
        b=Ro2b2lolpdtPjq0FsC3GkdYYzEC/9sWFGFHnD/pyuqZmCFb/HxXFl0oRU7CZafeNzJ
         mVlnWdDiCcHoWWdmX1OybbyRmoNrKyN7Yr6xEY7moCMH+eSwQo+G01kcuanwjyFd2pfV
         3UH8xLWsr1bxzH8n6+RwO2YPCIO0QrtYMzFQCfjb8W24c0vyO+lKf2ZAftgPDTpojkxW
         t4ndRMUOepy9OZZmeXSZEapqKWC2oIS0hEOlYc0OLbMiNj7CaBrVHcwhas5y067eWIS8
         XRLdtsjPfgmh3mSE7aojHZ0WPcXuzCU4zolLXadc6LDgEb5Iw4wV0SWc2cmGIrBvdTLx
         /fDA==
X-Gm-Message-State: APjAAAVuKD8Fm7xRTvdOcizu4+hqlW0PA3hV/Stsv7YpcbQwWAQQQpBf
        vV2b0un4e/KRgCRTfumbaoCp8oT9
X-Google-Smtp-Source: APXvYqydlcplQfYNj/0X2BhDKbEHhVKS28d50C8ssjJRGaCY2pYwsZzp4qxEVSaarLU1FWaaXoYAWg==
X-Received: by 2002:a62:69c3:: with SMTP id e186mr31477675pfc.169.1552297639671;
        Mon, 11 Mar 2019 02:47:19 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id k74sm13560917pfb.172.2019.03.11.02.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 02:47:18 -0700 (PDT)
Date:   Mon, 11 Mar 2019 02:47:17 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     gitster@pobox.com
Cc:     apenwarr@gmail.com, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] contrib/subtree: ensure only one rev is provided
Message-ID: <20190311094717.GB31092@archbookpro.localdomain>
References: <cfd86853cce8a2cd5fae9e6fb9a84f1e3d6daaf4.1549538392.git.liu.denton@gmail.com>
 <xmqqftszpgy1.fsf@gitster-ct.c.googlers.com>
 <CAHqTa-3bDnAm=49uBDLWxLrpOMd6sh1ve1fmmnf5kCbVxHsawg@mail.gmail.com>
 <20190212100002.GA28167@archbookpro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212100002.GA28167@archbookpro.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 12, 2019 at 02:00:02AM -0800, Denton Liu wrote:
> On Thu, Feb 07, 2019 at 05:34:38PM -0500, Avery Pennarun wrote:
> > But I don't see any major problems with the patch in this thread.
> > 
> > Thanks!
> > 
> > Avery
> 
> Hi Junio,
> 
> If there are no other comments, I think that this patch is ready to be
> queued.
> 
> Thanks,
> 
> Denton

Hi Junio,

Sorry for the spam but it seems like this patch was dropped. If there
aren't any other comments on the patch, then I think it's ready to be
queued. Patch below for your convenience.

Thanks,

Denton

-- >8 --
Subject: [PATCH] contrib/subtree: ensure only one rev is provided

While looking at the inline help for git-subtree.sh, I noticed that

	git subtree split --prefix=<prefix> <commit...>

was given as an option. However, it only really makes sense to provide
one revision because of the way the commits are forwarded to rev-parse
so change "<commit...>" to "<commit>" to reflect this. In addition,
check the arguments to ensure that only one rev is provided for all
subcommands that accept a commit.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/subtree/git-subtree.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 147201dc6c..868e18b9a1 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -14,7 +14,7 @@ git subtree add   --prefix=<prefix> <repository> <ref>
 git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <ref>
 git subtree push  --prefix=<prefix> <repository> <ref>
-git subtree split --prefix=<prefix> <commit...>
+git subtree split --prefix=<prefix> <commit>
 --
 h,help        show the help
 q             quiet
@@ -77,6 +77,12 @@ assert () {
 	fi
 }
 
+ensure_single_rev () {
+	if test $# -ne 1
+	then
+		die "You must provide exactly one revision.  Got: '$@'"
+	fi
+}
 
 while test $# -gt 0
 do
@@ -185,6 +191,7 @@ if test "$command" != "pull" &&
 then
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	dirs=$(git rev-parse --no-revs --no-flags "$@") || exit $?
+	ensure_single_rev $revs
 	if test -n "$dirs"
 	then
 		die "Error: Use --prefix instead of bare filenames."
@@ -716,9 +723,8 @@ cmd_add_repository () {
 }
 
 cmd_add_commit () {
-	revs=$(git rev-parse $default --revs-only "$@") || exit $?
-	set -- $revs
-	rev="$1"
+	rev=$(git rev-parse $default --revs-only "$@") || exit $?
+	ensure_single_rev $rev
 
 	debug "Adding $dir as '$rev'..."
 	git read-tree --prefix="$dir" $rev || exit $?
@@ -817,16 +823,10 @@ cmd_split () {
 }
 
 cmd_merge () {
-	revs=$(git rev-parse $default --revs-only "$@") || exit $?
+	rev=$(git rev-parse $default --revs-only "$@") || exit $?
+	ensure_single_rev $rev
 	ensure_clean
 
-	set -- $revs
-	if test $# -ne 1
-	then
-		die "You must provide exactly one revision.  Got: '$revs'"
-	fi
-	rev="$1"
-
 	if test -n "$squash"
 	then
 		first_split="$(find_latest_squash "$dir")"
-- 
2.20.1.522.g5f42c252e9

