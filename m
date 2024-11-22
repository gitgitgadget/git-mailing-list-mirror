Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1C816131A
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732305034; cv=none; b=ZgxFz3Yt8hn9onmBGg/QwzDDLfGIIrRNFEvJw/aDR4vPxXPp0z/Dfl1CmqVXtvU/xFg2S8Amdl4g+ZdxYpBKM0VoQyYL/i4wX93HMqs36tzDQRhTnX1n5MzhFJJryQSj5Y4aJIs4JIeWrd8yqE3edaQWy6J9d1p7NYhysmVik+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732305034; c=relaxed/simple;
	bh=cjrNcDybg+eotxIuIDwjKtIzIcasPSG0L/pSBxlJA9U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MEh0jxRMT8r2m5GAHrdG6LifjovRIN9c3n0vFuYDxdZ1KOSvyAIdafubReRORJKeZPiubYZCjfyM1uCYlNEl6X14FITzMRUELyXRi2XT+G2/Vpqyk45evVXzsNMimv1j5n8F/c76k8qHWiQvL9YV8Jzk7PYX+XfIW3V/2Uw2M6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V80OeyAz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V80OeyAz"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-432d9b8558aso20878425e9.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 11:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732305031; x=1732909831; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFDhg1t7IvcLQqH4U2PxGRD4pEqla4b+K0WdwT4ZPyU=;
        b=V80OeyAzVjPG2nUotAG2TjZ/PGVqHTlFkLHg9ySw3UgUraDO33libzc5HpJc2F5d8N
         W1nwkvlvhSC5202IodphuYd4Z5qxAr61UpbCFKr+l50p3DQxz424qU1pzsKtnUZagOHG
         Ai0CNOJvcak4yvWw1eGJpm5GzY6XQmxiWtQC+BTSFXChxJ0oNjdw2ZA7/yjHH2zm4UgW
         CH6NNRc5WhI8FKBdSEU7zMHLiIztTQmpLiX710C2hd08yoDxiVw9UUDAPo0TmMkjJSJ/
         /LHs+BgtxT2VFfWTrCB0bee1Y2nr/f3G1QqFa7F2NTdupUfWz+iWx0we1no+ifDcnAOt
         y24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732305031; x=1732909831;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFDhg1t7IvcLQqH4U2PxGRD4pEqla4b+K0WdwT4ZPyU=;
        b=Ljww+VsQ3CctfVDRRF0AJafPuEClaYdIsiqogbg8R4LNGlVs8UJkC9VD/rRSjX6rMq
         YgoKazJcjDZkaHOEqoolZHarUg8drFjvsO6W4VXny8+zn0l4oig5PQs5SX+ZjV5D9Wzw
         DjlyLcAWaqAMW5VdUPUmq1u87eoPI9qMsp+TUhv8hsfcEnYuV8fZnilUkFw6QrUdy+Va
         ZVViwIBrq0mXGQXg7LtLW7EZ0LsUTtStxkX8mn3JylYKogS+im2OoHvcFKOG5pOAAQel
         HwDO/7VbujLN6Md6Bwbp9k5PDooXOSrjzrE2riJKZmsYcASFBjJujRRMREpICWAa9hyk
         mHVg==
X-Gm-Message-State: AOJu0Yw0hJlZKmZftJkg4GBUZKWUEmVkj9T8t1jpGvWftTHU+cwOa6U0
	zTa2wqiDwTMG2wKwCG91zATPvJ3DfMv5XLFuqbSyEe+JroHkhJl4i0llzA==
X-Gm-Gg: ASbGncs6aRVvlDNaTqfwEDjvTwNMep7hzUt+tHlF2hWhh/Ym+XHYFGuzvN0q/QiOlYb
	XzP/ztMt0EUUwckTfiM4LkpKyNr11li1Nlfy4MFcWx2ErxbORM3akddq1EzSG9vUB5q9hjncxMz
	wxIuVEQzBDRKNOCdCzS9r++tYXjdrlbSGNr8lKiCB+KCFxdifHOvJ91EhAQCe8za9ZaiQvTjIp+
	eALg9x2ksrYHykJUCBUmUBS1mKtgvVuEagIj08S3R2pED3TTRA=
X-Google-Smtp-Source: AGHT+IGfH8xO3BNv0Ka8lIK7ldci2FY3BM6JQyk9JWbNc025WEZNRWnKCz7M0/+TXZUF4vKsMpWLhA==
X-Received: by 2002:a5d:6d8d:0:b0:382:395d:bf93 with SMTP id ffacd0b85a97d-38260113288mr4010719f8f.6.1732305030973;
        Fri, 22 Nov 2024 11:50:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb05e3esm3316386f8f.42.2024.11.22.11.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 11:50:29 -0800 (PST)
Message-Id: <c16e9229ebb46916a59dc9c9fdc7b973480153d4.1732305022.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1827.v2.git.1732305022.gitgitgadget@gmail.com>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
	<pull.1827.v2.git.1732305022.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 Nov 2024 19:50:22 +0000
Subject: [PATCH v2 5/5] git-difftool--helper.sh: exit upon
 initialize_merge_tool errors
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
Cc: Seth House <seth@eseth.com>,
    David Aguilar <davvid@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since the introduction of 'initialize_merge_tool' in de8dafbada
(mergetool: break setup_tool out into separate initialization function,
2021-02-09), any errors from this function are ignored in
git-difftool--helper.sh::launch_merge_tool, which is not the case for
its call in git-mergetool.sh::merge_file.

Despite the in-code comment, initialize_merge_tool (via its call to
setup_tool) does different checks than run_merge_tool, so it makes sense
to abort early if it encounters errors. Add exit calls if
initialize_merge_tool fails.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 git-difftool--helper.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index dd0c9a5b7f2..d32e47cc09e 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -61,9 +61,7 @@ launch_merge_tool () {
 		export BASE
 		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
 	else
-		initialize_merge_tool "$merge_tool"
-		# ignore the error from the above --- run_merge_tool
-		# will diagnose unusable tool by itself
+		initialize_merge_tool "$merge_tool" || exit 1
 		run_merge_tool "$merge_tool"
 	fi
 }
@@ -87,9 +85,7 @@ if test -n "$GIT_DIFFTOOL_DIRDIFF"
 then
 	LOCAL="$1"
 	REMOTE="$2"
-	initialize_merge_tool "$merge_tool"
-	# ignore the error from the above --- run_merge_tool
-	# will diagnose unusable tool by itself
+	initialize_merge_tool "$merge_tool" || exit 1
 	run_merge_tool "$merge_tool" false
 
 	status=$?
-- 
gitgitgadget
