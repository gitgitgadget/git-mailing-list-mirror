Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435043E7145
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186952; cv=none; b=maBVk1XNXCTJNi0rOokQI3+yymlgf1xhH+BEY2tLeg0bRjpu9NiNH0pjW+8T9M0yaSsqvFHhS5saaf/abfsBy7YkMQ4Izbluf8qulsRaHlSrDcxkZDB/hmH+sIEs335vAxTAZxwF3uPE+kJrOnYD3b8WfuJCNyLqwDmhsGMOLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186952; c=relaxed/simple;
	bh=NvMmDGzXkIwCr3DKV5lvHvNBXHFYXf3dB0H0UDU73CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgZh4Nhp1iRahoiRxsgJVGVxulCdf2hKPsqX04jWzEPYih2hl1LyvrPdELyjExiD1dZxwyFNtbNeQpphs1LAmIhLuPCOYwi+FBOz+A9L6TgcXsG1OLXqEceRnIuNFy40GlaVRIep02wD8E5CCs6aZfRaOcS2flA+wxfsEwL6Odc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0yQWIn7; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0yQWIn7"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca80d708489so221574a12.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785186950; x=1785791750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BEeAALNX110uTebz3hnOeOlMCRtFg088hAAU/zIgqjE=;
        b=n0yQWIn7wBzJE94B/1zS/ppL3oXI0zN2ufesA32a2bPSgUdqozH9+OCA3MPWk+Pl0Q
         Bqf8Te6ge279swAcxuYU9lNMrEa953UiS+nvrqoweUjzQ6Y8TPsJe4tkNhvTbllEg9EQ
         tLBlJ4NkrXIUOWCNIQ2adxmki16mpzxaT19HA/YEwSNQ+IPu/pk645Sl49UAEns8zehd
         500Fpv2YpC1cLuliKGcU/McmItoCqMiv2y7McP1bTWP0mXfXfM5WwU8Q31qxtLnwhkdv
         pCq9MthxRBdJGW3I+IM66Rtvr/bzv74BLvrbML7clB5pViPc66MSBslfUq/eZZ5Icah/
         qrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785186950; x=1785791750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BEeAALNX110uTebz3hnOeOlMCRtFg088hAAU/zIgqjE=;
        b=Pn81UobmY0NtLBLE6N+lB0tBSjH31FlNNwcH2mRT1gnJTM2t3uwRQYg/vpU1UAZXzM
         bkUwwZCHr13/ENl0QbKYihMvr99Gw9MNtG8/5D52/MecAo4JT/elFaeWs6vEVnteG/19
         rQ3WNxvLVHfkbbuLXTQS5nIFrqUwp4YGAtemgDXzRqcKtWeZVasl//rtjmzQHOE7iPMZ
         6imRjqVpmyd+5n5g7XjiCVQW5eNaBL/F0BYWr8kOHVDTufZnSmjui8OHhNNaCSDmACJi
         obyZA1Rz46zxv+wq+Tv5mrxbS07wHmxwniRjqngVVvr3VDuERELPO4/ErDoFdli+0zer
         xRAg==
X-Gm-Message-State: AOJu0YzhDaqJZsXwVhrknijr9l7dy2qcDN5FUU37BfJUnD0evRjH3fl4
	CXFyEqh+HZ45hj2ctqlRxTziHelPem/Wd/pu0M5HI40fuVBNmx5SioditlqbYyeb
X-Gm-Gg: AR+sD139uw5Nj6a8TCbo71C5xLDSYL22CxqlehiUmg/attB3Cxp0Zs0LRadbIPee/vW
	nDkWS0mDJTY2urgEgjiKr4C75gCFqcl61/kQjyzVUFmJVIpXAU1cAVY3FSZWuqKRs8Px7HK6pQE
	ZyaVTOO6hMcUkmr0AGSXbTRK+5ZLt/4k3k4AHkagMlHcFDUyTKnauf/YVR4S7il0fFp7rCGsuUu
	Gi5PUgfu0EvtyN9ALDjuy4WZKa+PYvYyMRi1wyPstjZUeyGkPNfHVr/mU6AVXwH9DFMhWNGeBkx
	nphnH/SoRZa45rrWCFLy0J85gttT07uUQ5xGyWo070Zg7H/vvPCB3yemxhKBvz07U6XFyWAQWBB
	2BJPh0WuW8BcErwt8t4acBCIcDfERdaqg8cOJe6Kt4uh8MpaZ7Itd/1RAG4oMCqFpMhtBX1LyR/
	rh1pmJ82LUePo99V7MJLy7Mu1P4ro26twnQw4K6YrNF1gO84fD0oUJ8NR0HHciXVW44O1Dokv6j
	VtV5ik=
X-Received: by 2002:a05:6a20:2d24:b0:3a8:800:bdf4 with SMTP id adf61e73a8af0-3c79268afd2mr390798637.33.1785186950510;
        Mon, 27 Jul 2026 14:15:50 -0700 (PDT)
Received: from fedora.tail0f6912.ts.net ([112.133.220.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e0f4a039asm30070324c88.9.2026.07.27.14.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:15:50 -0700 (PDT)
From: Hardik Kumar <hardikxk@gmail.com>
To: git@vger.kernel.org
Cc: Hardik Kumar <hardikxk@gmail.com>
Subject: [PATCH v4] utf8: replace utf8_strwidth todo with descriptive comment
Date: Tue, 28 Jul 2026 02:45:20 +0530
Message-ID: <20260727211520.84289-1-hardikxk@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726123427.173877-1-hardikxk@gmail.com>
References: <20260726123427.173877-1-hardikxk@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `utf8_strwidth()` function is used in multiple places that all
expect the function to return an int. The result is directly used for
padding and width calculations and passed to `printf()` calls. All
these operations expect the function to return an int value. Changing
the return type here requires changing the types of all the callers and
other additional variables, that depend on the results from this
function directly or indirectly, to avoid overflow by implicit
conversions.

The comment precisely explains the reason why the explicit conversion is
done.

- Remove an old TODO that is no longer feasible.
- Add a comment explaining the behaviour and reason of the allowed
expression.

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
---
changes in v4:
- drop the todo implementation and remove from codebase.
- replace the todo with a reasonable explanation for the current
approach and why its not worth the change.

 utf8.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/utf8.c b/utf8.c
index 96460cc..1b55bd4 100644
--- a/utf8.c
+++ b/utf8.c
@@ -227,8 +227,9 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 	}
 
 	/*
-	 * TODO: fix the interface of this function and `utf8_strwidth()` to
-	 * return `size_t` instead of `int`.
+	 * The function is used in multiple locations where the callers
+	 * expect the result to be a signed int value. We cast the
+	 * result to an int to avoid changing signatures of all callers.
 	 */
 	return cast_size_t_to_int(string ? width : len);
 }
-- 
2.55.0

