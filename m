From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] worktree: add: introduce --checkout option
Date: Sun, 27 Mar 2016 15:49:48 -0400
Message-ID: <20160327194948.GA9295@flurp.local>
References: <01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
 <01020153ad85c135-8ca8cff0-9e6f-48ea-89f3-4036814feeca-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ray Zhang <zhanglei002@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 21:50:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akGhB-0002g8-EH
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 21:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbcC0Ttx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 15:49:53 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34988 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbcC0Ttw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 15:49:52 -0400
Received: by mail-io0-f196.google.com with SMTP id 124so18174850iov.2
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 12:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vdF/11LYivDLttgrnKUJTXDq8C2JcbUABTO5hyEmvqw=;
        b=YP5jXOboiSDNcPevl5tyk65VxPrqNivoRMb5n1nnDmdK/NGrpUtspwvB8UgLVd2zAc
         CGiOzHC/Guyx/mGRYRq3W0lOhUCf1Cq2SxquKp3HPXumvnJcTBYTCGGeCCixrq3IMEwX
         /CrGDnksPbwGJhWvTqIpEdlH66LSVANghK2zbSrrVvXbYC0Of1ijga4VpT4xG/YTnkjD
         fOSXOX2MIpbbTwfwsKdNtYANHYCzpylvPh82VbB3zdkeGwI+zqj6Wc/xcBgxrcRmMtcj
         J92Lb3cUs5u2wl/50yIpB4PlBWpy3rqdIZj/Whl8rL2SEG8FQUxjGG+rJrvOOdsLa8ao
         Fu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vdF/11LYivDLttgrnKUJTXDq8C2JcbUABTO5hyEmvqw=;
        b=O179mh9IRWp8FXzWkQnguTbXzr6i0xn3OuT4sEUAQRekm1qf7Ca6m4wwWad0lanCrp
         oOmKEyv+rZIOZj0BjklfYyznHJ9gcJztihvkPVhUogZDwQPhkDaENZXMrOag10wKDkBi
         egGjUqz1wm9jZPwSExo984txtK40ocaHgDlesMWxUOAJqBSh3OQ4ozPdiViv3UeTvTNG
         pa7qbWDO7ZrscvdgGM9ALd0cHK4Il++bHa9CfmPjYYXWTNjmXc5Dr1yOSfaNDspq1o44
         gMw+9+LFEz3zBmTjdy0hV9RBn3hVzs9MZfLBvznB2PefeU3UACghTQkwM0RQ4BSoYBFK
         6rAA==
X-Gm-Message-State: AD7BkJJsB8h8E3p0Xjs8118njiQC2Kq8D8U3XNE1GfFkMO8oWoWSTF4nEpr+Ar2WPlD4hA==
X-Received: by 10.107.18.214 with SMTP id 83mr22061572ios.130.1459108191790;
        Sun, 27 Mar 2016 12:49:51 -0700 (PDT)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id a126sm9076926ioe.7.2016.03.27.12.49.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Mar 2016 12:49:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <01020153ad85c135-8ca8cff0-9e6f-48ea-89f3-4036814feeca-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290021>

On Fri, Mar 25, 2016 at 11:25:37AM +0000, Ray Zhang wrote:
> By adding this option which defaults to true, we can use the
> corresponding --no-checkout to make some customizations before
> the checkout, like sparse checkout, etc.
> 
> Signed-off-by: Ray Zhang <zhanglei002@gmail.com>
> ---
> 1. reword on `--no-checkout` in Documentation/git-worktree.txt
> 2. update the test for `--no-checkout`
> 3. add a test for `--checkout`

Thanks, this version of the patch looks good and is:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

with or without the minor suggestions below. (If you do re-roll, feel
free to add my Reviewed-by: if you include these suggestions but not
if you make other major changes.)

> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -87,6 +87,12 @@ OPTIONS
> +--[no-]checkout::
> +	By default, `add` checks out HEAD, however, `--no-checkout` can

I realize that this description is just a verbatim copy of what I
suggested during review[1], but in retrospect, I think
s/HEAD/`<branch>`/ would be clearer and more consistent:

    By default, `add` checks out `<branch>`, however, ...

[1]: http://article.gmane.org/gmane.comp.version-control.git/289840

> +	be used to suppress checkout in order to make customizations,
> +	such as configuring sparse-checkout. See "Sparse checkout"
> +	in linkgit:git-read-tree[1].
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> @@ -213,4 +213,18 @@ test_expect_success 'local clone from linked checkout' '
> +test_expect_success '"add" worktree with --no-checkout' '
> +	git worktree add --no-checkout -b swamp swamp &&
> +	ls swamp >actual && test_line_count = 0 actual &&

Style: One statement per line, so this should be split over two
lines.

> +	(
> +		cd swamp && git reset --hard &&
> +		test_cmp ../init.t init.t
> +	)

No need for the subshell. This can be written more simply as:

    git -C swamp reset --hard &&
    test_cmp init.t swamp/init.t

> +'
> +
> +test_expect_success '"add" worktree with --checkout' '
> +	git worktree add --checkout -b swmap2 swamp2 &&
> +	( cd swamp2 && test_cmp ../init.t init.t )

Likewise, you can drop the subshell:

    test_cmp init.t swamp2/init.t

> +'
> +
>  test_done

For convenience, the above suggestions would look like this (applied
atop your patch). Feel free to fold them in if you re-roll.

--- 8< ---
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index c2796bb..c622345 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -88,7 +88,7 @@ OPTIONS
 	in linkgit:git-checkout[1].
 
 --[no-]checkout::
-	By default, `add` checks out HEAD, however, `--no-checkout` can
+	By default, `add` checks out `<branch>`, however, `--no-checkout` can
 	be used to suppress checkout in order to make customizations,
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 1ff96af..472b811 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -215,16 +215,15 @@ test_expect_success 'local clone from linked checkout' '
 
 test_expect_success '"add" worktree with --no-checkout' '
 	git worktree add --no-checkout -b swamp swamp &&
-	ls swamp >actual && test_line_count = 0 actual &&
-	(
-		cd swamp && git reset --hard &&
-		test_cmp ../init.t init.t
-	)
+	ls swamp >actual &&
+	test_line_count = 0 actual &&
+	git -C swamp reset --hard &&
+	test_cmp init.t swamp/init.t
 '
 
 test_expect_success '"add" worktree with --checkout' '
 	git worktree add --checkout -b swmap2 swamp2 &&
-	( cd swamp2 && test_cmp ../init.t init.t )
+	test_cmp init.t swamp2/init.t
 '
 
 test_done
--- 8< ---
