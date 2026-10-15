Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D74BE45C
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061240; cv=none; b=MB703jilkLfOQ7nMg+eKT/QOAsuURzBwHwHow1LSv567Rq1L5L/EyreMTZ6qhBngoJxK+M3eE+2bm56RgXcrpQH3/sdQxdP25lF4vFJn5AlOzmXvdowk/aXdgbyxHsrLe1UObIlH8AL/jdT4zUSUZGCKHCwb5OtFE5orINq3030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061240; c=relaxed/simple;
	bh=KIFqdXO2/An6pCFs7WlKUz67SPfS0sd0uKjEA/bUhso=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hsEorm3rS+zmJ+Ue1//DuFl/j+NYfUyS0U7SeXrG5lLk+tspkzDN0ViYxNo3hZSH8NIbZkMB7TyWAMgNUVeZ0g8SHm/IlW14YNog6KruCRQKsA4C/Qzql+ZJDVyELKWoqGxCPQwzDJVGv9vJAC6EEb0nU1rBYCA8jX0wmANzUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4U2HNax; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4U2HNax"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91b813ac020so62075736d6.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 03:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792061237; x=1792666037; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hOkGxAc2JN/NX/7+J0eROsqHF89+TnB8yhT3aCgLHtI=;
        b=Z4U2HNaxqOy1YTzdkr2yH6o5vZce2huTxz+qUwezzsBdO1PcDm50VwtDxmbVRldhqx
         HZlgCwEETQCEsW2dphzoaG7yiWCsx4VSkHFaoCnFyr3e3IIFk2U6PdULpW5Kf67zzSn7
         0+EorvWIvulTIVSEgl598IbVHOeFrh/aBTLW7p3RLvPI9kvXwQcTPZMHcMvtvXXPPz+N
         YY75Bk1E0kmw5VNrGXpggQ/VTdmh78rMNbohnFOKI52uyfVlnjMV43ZJIlMITb9Xi0SW
         loZ62Z3rtEnf4sznCJqqALdFHkwFoUNTtQe5ZLwK3FI9bZhbPRLX8dVg8kJdX43Cqliu
         PYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061237; x=1792666037;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hOkGxAc2JN/NX/7+J0eROsqHF89+TnB8yhT3aCgLHtI=;
        b=G9le8qSsN1G7l+c1hQxdEe79sOaIPAaqE6qrB6OaVY5NcWXrHjSPJyJbfLv2TYW59v
         JEOUaV8fuA0DDjhkVlk0D/sNHs/nvUxXbWPSR0kAGyS/o7HrgLjfOiXi41SfwTpNyOr+
         P+9YVoV8sbGuD+hrxdWNpD2OnNBfPl0AOdW0nT0W3XtBX9RDIZPfaspZzUfVxBNbmk4x
         Ob11eLJkGHOMkEGSLOB4cQBUdrygNXUnowL6ItbZk2cfsyDanBfDkKN61wv8BvielpCN
         uS2z1wWSr2IrCClHHn2j12Np2SpyM+Yu497cUnX/QT8lMxXmdJg37cRXabMoZLxjUvdt
         XjHA==
X-Gm-Message-State: AFq9FYJI/5UriZu+o0dnOnQ0gwCSqAoazyv6Wo7frbQxicup+vshKS4d
	I64ZVlfd83tZt1gf4Ltp7vEhxWzOtQ3/6Pk+NoYh/M8sxBZhwKPijreyYYUrJrM2
X-Gm-Gg: AYBFou2SdSptsSroyXNlC+911LLXKCbpk8uZOSqnUHb7bXD3Hd2uo+S/bHbUE8r96+d
	2kRItB/hCNbst6UiTpb5xIgvJ2mufU+UTYlQ6HmYv29js+gJaJh+0oFaVD0qBsUDb6H7zgbsWcE
	nlnwmX26qbYhnc5UjQmhIYNX3KdKQelrosMmDX1qS+9iF6g5KXa9pl7jjs1n3RdpsC4IAflDjKQ
	aVyF6pXjlhMZF6ctsQc2p4hbn3SEgdWQI5r6vsCojO3oqxh80TOcm7Ehd2MoDLn6K5M2PgnxJLY
	DZoH1u2K/In0cddYzWnILUzac9Dw6dzKdzm5RcoHYYIvKei6e+4mKOEqXKgcCaKiKtOD/IjsxU2
	LkPJj0ZgUtZ8OFmwvK8vX4ic9AOghc/H9vxhsy4HIC+CQVWpDY5I5RHRaDitzO4qBSJPm35CFD0
	6FXBh6EMI6Da3yyEXHrc6eqdnetALK1Wrp5u+d74K0+REFejHcf7wpbeFjINfo+Yi8uBUA7qQ3J
	L3uERu0GU5U
X-Received: by 2002:a05:6214:4b08:b0:919:860b:1cdc with SMTP id 6a1803df08f44-91b5551e80cmr326519626d6.29.1792061237144;
        Thu, 15 Oct 2026 03:47:17 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.70.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b62225sm78969586d6.19.2026.10.15.03.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:47:16 -0700 (PDT)
Message-Id: <pull.2254.v2.git.1792061236183.gitgitgadget@gmail.com>
In-Reply-To: <pull.2254.git.1791962806807.gitgitgadget@gmail.com>
References: <pull.2254.git.1791962806807.gitgitgadget@gmail.com>
From: "Shashank S via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Oct 2026 10:47:16 +0000
Subject: [PATCH v2] [Outreachy] t0081: modernize the code testing whether a
 file exists
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
    Christian Couder <christian.couder@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Shashank S <shashu8660@gmail.com>,
    Shashank <shashu8660@gmail.com>

From: Shashank <shashu8660@gmail.com>

Replace the old-style shell `test -f` command with Git's modern
`test_path_is_file`.

Signed-off-by: Shashank <shashu8660@gmail.com>
---
    [outreachy] t0081: Replace the old style 'test -f' to new
    'test_path_is_file'

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2254%2Fshashu8660%2Fupdate-t0081-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2254/shashu8660/update-t0081-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2254

Range-diff vs v1:

 1:  906c628765 ! 1:  d4807f2751 t0081: modernize the code testing whether a file exists
     @@ Metadata
      Author: Shashank <shashu8660@gmail.com>
      
       ## Commit message ##
     -    t0081: modernize the code testing whether a file exists
     +    [Outreachy] t0081: modernize the code testing whether a file exists
      
          Replace the old-style shell `test -f` command with Git's modern
          `test_path_is_file`.
      
     -    This instance was found using:
     -    `git grep "test -[efd]" t/'
     -
          Signed-off-by: Shashank <shashu8660@gmail.com>
      
       ## t/t0081-find-pack.sh ##


 t/t0081-find-pack.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0081-find-pack.sh b/t/t0081-find-pack.sh
index ff9d56fbf1..7d5082c487 100755
--- a/t/t0081-find-pack.sh
+++ b/t/t0081-find-pack.sh
@@ -32,7 +32,7 @@ test_expect_success 'repack everything into a single packfile' '
 		".git/objects/pack/pack-"*".pack") true ;;
 		*) false ;;
 	esac &&
-	test -f "$head_commit_pack" &&
+	test_path_is_file "$head_commit_pack" &&
 
 	# Everything is in the same pack
 	test "$head_commit_pack" = "$head_tree_pack" &&

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
