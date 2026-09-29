Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C3451DE07
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684450; cv=none; b=c1b37DjMAhYmQNgQdTAntLWI99zKdkC6ehrH8rMkbPwjzg5TqQx0ODLU6FgEIurwtWK991eXQ8GZ/QnFp8tc25TUoyCBHlSTM26HL9Z+aFLx232wKcr60SrmbPIr0i0LKqGSc0jUCm/WPdcTZ0pTU63ldEd7V50khpRcMqLYgfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684450; c=relaxed/simple;
	bh=p7xie7cZGWb8gwDDMkc1J9SR+hsK60nGRxwL1K7G3W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ieg67BwGHp99uz56o32Qz1mlub3tMvJtDVfeNvHbVmbwjfkmeFRJf7yXWjRpTHr+cWQnowC9sl5NG6VLMfK7XGAtbaMq6W6jruDgm7E3mO3yV1DYLzhdZYL0Y4rn/ZwidLMwwRaTPtRinZjy0xpNKwpvhENhX2Q2+MV3jLgMq6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbxUpOSc; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbxUpOSc"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-6737f0593faso3354946d50.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790684447; x=1791289247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9qPgX+LLvKa2/wCdxRYUjP5wgcqU+WzZpQHJSXaw20=;
        b=nbxUpOScAgOdKpzP2gJcgLBw/WiTenbR0IbksF+DXHlYDIKILmiB8tQR0saGDgjkW+
         F7OA5Po8NlB22xC7Yro+zwtS9jjilZMTKyjpG5aWSRgaKitSLRabpLu6ux/NNln3D0y1
         oeuQzea0WwbPq4A2wTa3BVcV6epSNZq5s2fAIPbcRR3SyTy8FrLPIjHw72eL4sx80Z1T
         lm9UIqSDr2FiUvL40Fw5yj5SoN9oBmjcFYOOqAKJu9lDp/QjINFxjRnJJD5iyLB7k80y
         nMN/gIn6copXJ52pDaJbmqJseydlutLEdyj5/ZbuvteiO7btAfxKCOIosUY+D44Ag4vC
         VWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684447; x=1791289247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x9qPgX+LLvKa2/wCdxRYUjP5wgcqU+WzZpQHJSXaw20=;
        b=Grq1VGvElACL+/Q06ylW5B8MzBoZNYkWkwfUqJPI0NtyR5LpCOPtpeB+1QwED2FPWi
         58N0LtLZERUrwx6OIikTsfvrztmcra3GdqtLF0ctKqt7vYyCp0zTJY55Vz2BOhixnYWT
         NUaNQzIXscN59Mr0+Jf4ZMriaxa0mOW7xgs+spVA75MOJbgpTQIBIH6T1IhDku7JUcrK
         ReQ8Khtl142Wg7ls9LGC5z1zlsm91+505gzXItH4XCYbDDYYEWnWcuXGabwMRB1iC95P
         8ZhTuCX0tWTXMckwpyZOQwTXi5XWDnkRW/9q6ZTVSFJ8EcAwmcK2VHSze6QuLggKjza5
         5cNw==
X-Gm-Message-State: AFuF++kPQ/s4G1UfLSNa/4luRDH6z+4+kDdSFElSe42N72ZvhVQTUxM3
	a2cIy0lf4QsTrBsaeYlHBJ6e0YZDjsz2+M5tzs52w/0DvoJC8mSSr5UnlbcTa976
X-Gm-Gg: AYBFou3yCAK7jTrStbkU9mhJ/28FGkWCPwR/4KkUqzhSm/1UNw9UihXZPl1GLxVQTxO
	MVDxvrNcRNA0k/mJ+jruM1S70DgV6w0nw+d6yzVql3Y/lcB5jfsBNzIuH5ARqq8Ti60G/pk5dWe
	GFtrOzyRto09pV+mPj6GBG0zLccCQHCRSRKymsshyT+x8N/yMjcFCGpI2LARE9TZwXjmJdH3Md1
	Qw6mUT7GiXYPZvwxDjaPV0ioaIzzBbtV/WGEyi6o6iRvr7Mtx4l9yTNsdVUzyBJxb3t7dm8w44j
	QInQ8M7SQBUCRPFFm00hFOrGJiiss62Kk0YpXqTAEUJTvCuWixgF3+/fWCssm02sFTyp6V2G6Gt
	XhbQlPiA8TZOcKmpMhjNLWj5KFdyHt7tkiIAXfuYTxoCdP7fzhpv9sQDhcXKgpaGu+Xptybgmdv
	wFT9bTX0bEqpiMIhLo9XdVwwPwbgG0PNXN0BcKVhM0I0d6P0EeF286biMwYF3inl2f+GufUJGhQ
	iGGckX9cYA1KsoqMGT38Vu1fL6a9VfiR47P2wS611znKiO92IeXuDfFJ9Kja5kUOwg7xsG9Hth2
	HS5ZX1Bkp/XzKn+Zj1RsfQ==
X-Received: by 2002:a05:690e:d07:b0:672:964b:f071 with SMTP id 956f58d0204a3-672ed568fe0mr7438657d50.94.1790684447190;
        Tue, 29 Sep 2026 05:20:47 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-674e5a7a556sm4499112d50.19.2026.09.29.05.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:20:44 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: Thomas Bachem <mail@thomasbachem.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v4 4/5] t5520: don't expire reflogs where it matters
Date: Tue, 29 Sep 2026 08:18:30 -0400
Message-ID: <2ac371d2dc1425cc47bf369e88b321d3c0c8c605.1790684309.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790684309.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790684309.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Bachem <mail@thomasbachem.com>

The "--rebase -f with rebased upstream" test computes its fork point
from the reflog of refs/remotes/me/copy, and the entry it needs is
the one that the fetch of the test before it wrote. Like every reflog
entry the suite writes after test_tick, it is dated 2005, so the
first "git reflog expire --all" after that fetch removes it. Pull
then finds no fork point and rebases onto the merge head with the
merge head as the upstream, and the rewound commits come back as a
conflict.

Since 452b12c2e0 (builtin/maintenance: use "geometric" strategy by
default, 2026-02-24) auto maintenance runs that expiry once the reflog
of HEAD holds a hundred entries it would remove, the default of
maintenance.reflog-expire.auto. Which run crosses the threshold
depends on the entries and maintenance runs before it, so the script
passed by chance: a stash topic that no longer runs "git reset" from
"stash apply --index" and a rebase topic that runs auto maintenance
at the end of "git rebase" together move the expiry between the two
tests.

Pin the expiry as ea7d894f44 (t34xx: don't expire reflogs where it
matters, 2026-02-24) did for the rebase tests. That covers a "git gc"
as well, which expires reflogs on its own, where turning off the auto
trigger of the reflog-expire task alone would not.

Reported-by: Junio C Hamano <gitster@pobox.com>
Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 t/t5520-pull.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 27f38ab3c8..bc818605a5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -35,6 +35,12 @@ test_pull_autostash_fail () {
 }
 
 test_expect_success setup '
+	# Commit dates are hardcoded to 2005, and the reflog entries will have
+	# a matching timestamp. Maintenance may thus immediately expire
+	# reflogs if it was running.
+	git config set gc.reflogExpire never &&
+	git config set gc.reflogExpireUnreachable never &&
+
 	echo file >file &&
 	git add file &&
 	git commit -a -m original
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

