From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 3/3] clone: add t5614 to test cloning submodules with shallowness involved
Date: Mon, 25 Apr 2016 14:25:44 +0200
Message-ID: <8AF410FF-23B9-41C9-A0B9-0086290A272F@gmail.com>
References: <1460504929-19208-1-git-send-email-sbeller@google.com> <1460504929-19208-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 14:25:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aufaH-0006gb-Rt
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 14:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbcDYMZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 08:25:47 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38433 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbcDYMZq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 08:25:46 -0400
Received: by mail-wm0-f43.google.com with SMTP id u206so124436457wme.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=in7OKqO6crzzkR94WDogM+a0yH5fCfsY31tAtw0g1ns=;
        b=mtMmJHuAnoSuYfNO1w9iqbfdlREC9A4yVw9cnGHVCWwwhP8yAozhQwIZrTH+aapPrY
         isajlcmu1s6PXuRGe22FqK24+DS+ag2wSPRruysOztH21AoEC+GFwNxa7gTP7yewHl0I
         FyeGF/WwOk/K9JqwcK1bp6206b7RgMGK17TYQwjmJk9LRvxhmcwRYUUKAqJzVdYzwVk3
         l6nZQ71B9dY47FS8HS6GVh1hz641GRXA3xpSLGhm8tljBsRcGqOnLiuXgWP5f0dtV/fy
         rORYdfdrNkoN98Rq9YPKUMfxIuJp+4zBMutXRaDFpBwMHwqRnSFs35oGM9Nw2dhmr4C/
         w7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=in7OKqO6crzzkR94WDogM+a0yH5fCfsY31tAtw0g1ns=;
        b=Wa22i0B+HLuDfGhEUQBAegoSSw+aVgWRLsOW9z4t9yRYy47ybM/88PNIN3A5iKuazY
         0c33Sv6spgzAq84yvx3KH1JjT42fYRf2V9DTF4PWK+YBStyBePuScmyEZSgwP8sA7Uew
         ULkWnanAaOhJpb5nk6VVV4dyqJwJsBn05BAhEavcnOXkjhFfEkF7DVapZWvvme1SYiNn
         lbIILd0QUdc5C/pW2is5L2yJStzsbFyeayvj8CnuIgwPhqXMafk/EYJ4+P4sMM+3Pzzf
         Ed7Tz7o7g5zXKqOKB8FVEslrVGiHPdIIyUvVH5M/djQ9a0mmVSDZ1BJDE1Rr0jlUxKDr
         K2rw==
X-Gm-Message-State: AOPr4FW4d50rWN0qAYvu6ZWF3U7bLkp6JnPHIw3/WKTFZ8JoJQD1JH+U4hbyxqtCnbxazQ==
X-Received: by 10.195.17.166 with SMTP id gf6mr33953334wjd.124.1461587144446;
        Mon, 25 Apr 2016 05:25:44 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w82sm16102824wmw.5.2016.04.25.05.25.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 05:25:43 -0700 (PDT)
In-Reply-To: <1460504929-19208-4-git-send-email-sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292472>


> On 13 Apr 2016, at 01:48, Stefan Beller <sbeller@google.com> wrote:
> 
> There are some inherent issues with shallow clones and submodules, such
> as having not having a commit available the superproject may point to
> in the submodule due to being shallow. Use the new file t5614 to document
> and test expectations in this area.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> t/t5614-clone-submodules.sh | 82 +++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 82 insertions(+)
> create mode 100755 t/t5614-clone-submodules.sh
> 
> diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
> new file mode 100755
> index 0000000..a66c2db
> --- /dev/null
> +++ b/t/t5614-clone-submodules.sh
> @@ -0,0 +1,82 @@
> +#!/bin/sh
> +
> +test_description='Test shallow cloning of repos with submodules'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	git checkout -b master &&
> +	test_commit commit1 &&
> +	test_commit commit2 &&
> +	mkdir sub &&
> +	(
> +		cd sub &&
> +		git init &&
> +		test_commit subcommit1 &&
> +		test_commit subcommit2
> +	) &&
> +	git submodule add ./sub &&
> +	git commit -m "add submodule"
> +'
> +
> +test_expect_success 'nonshallow clone implies nonshallow submodule' '
> +	test_when_finished "rm -rf super_clone" &&
> +	git clone --recurse-submodules . super_clone &&
> +	(
> +		cd super_clone &&
> +		git log --oneline >lines &&
> +		test_line_count = 3 lines
> +	) &&
> +	(
> +		cd super_clone/sub &&
> +		git log --oneline >lines &&
> +		test_line_count = 2 lines
> +	)
> +'
> +
> +test_expect_success 'shallow clone implies shallow submodule' '
> +	test_when_finished "rm -rf super_clone" &&
> +	git clone --recurse-submodules --no-local --depth 1 . super_clone &&
You could add another commit to the super repo and then clone with "--depth 2".
The super repo would then contain 2 lines and the submodule still just 1.
This would make it more obvious that shallow submodules always have a depth of 1.
 
> +	(
> +		cd super_clone &&
> +		git log --oneline >lines &&
> +		test_line_count = 1 lines
> +	) &&
> +	(
> +		cd super_clone/sub &&
> +		git log --oneline >lines &&
> +		test_line_count = 1 lines
> +	)
> +'
> +
> +test_expect_success 'shallow clone with non shallow submodule' '
> +	test_when_finished "rm -rf super_clone" &&
> +	git clone --recurse-submodules --no-local --depth 1 --no-shallow-submodules . super_clone &&
> +	(
> +		cd super_clone &&
> +		git log --oneline >lines &&
> +		test_line_count = 1 lines
> +	) &&
> +	(
> +		cd super_clone/sub &&
> +		git log --oneline >lines &&
> +		test_line_count = 2 lines
> +	)
> +'
> +
> +test_expect_success 'non shallow clone with shallow submodule' '
> +	test_when_finished "rm -rf super_clone" &&
> +	git clone --recurse-submodules --no-local --shallow-submodules . super_clone &&
> +	(
> +		cd super_clone &&
> +		git log --oneline >lines &&
> +		test_line_count = 3 lines
> +	) &&
> +	(
> +		cd super_clone/sub &&
> +		git log --oneline >lines &&
> +		test_line_count = 1 lines
> +	)
> +'
> +
> +test_done
> -- 
> 2.5.0.264.gc776916.dirty
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
