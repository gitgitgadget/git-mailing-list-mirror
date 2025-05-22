Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23206223719
	for <git@vger.kernel.org>; Thu, 22 May 2025 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747913211; cv=none; b=oZ+jcxrWokx5y9G85Sb8GM7zg4/sqcgu+/IqaFRNYb2PoxXDUBlDW76u2SHAh+zvLPCpszl7phyA3NiL/IzIMjPrPSedhhGCNmXWqBx4HVHEAcwecn7ogHsgWfNj9W9cIismBRLEXNdcpYyImXvEC1guQbe28wXoH61Uoj+mULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747913211; c=relaxed/simple;
	bh=zdX09u7P/xv3qOwPav0nVw7WEWFPE+mJEKc/LJWb+Uo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Fdv5TCW1ABjb/le3b3h9az7G04a/cbhNsoVZDeFV/CL52hmJQOdz1qBPM50ZAZb6mqBH5/KYTUonfqsIkC/U7u6uTyhSXJLIOx4VJe79sdRY3F5PlDgYUhwEXCDco/ihNgjJXAXhLKGvJYVBvMN+nD/BFrNO8987OwDvbi+vlT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaqBiKpg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaqBiKpg"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a35919fa8bso3367034f8f.0
        for <git@vger.kernel.org>; Thu, 22 May 2025 04:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747913208; x=1748518008; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO3IyRRNUOslkHuIg5kOXC0SYH2+Vh79ezE354GyJ+I=;
        b=aaqBiKpgdEIqwBW5q3dc4kga6tBUohUQXet3arcsTvfgejVyakahaz7ol8XA7UYqBa
         9255EXZfTEuqhDVnLWnadx77/t05quqZdtm0RtcDLXJQjgJgZyVnqtHjDUiv4ED/gYn3
         2L/bvA6LFvZOpushADfrk2ROEIRpcb8atnUksm9cX3gagdYtfzYFMPhPv1pVNbL8m86A
         EeJG5IZmv6onszZlay4wX3rw7C1yQlYuiHOXw2w0JePUNx57LyhycyaO18zYWCixoue3
         N3jCr9xzLfl0GIvG8iMJlXuWR5X1cUkmQ2JtPvcK/WhFlR49X6XP9ql1eDgRJMGfX9JF
         UnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747913208; x=1748518008;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HO3IyRRNUOslkHuIg5kOXC0SYH2+Vh79ezE354GyJ+I=;
        b=ZUY2GbBl5HLhKOtwDwK0mupuZw0RiAXloJ5nz18klCB/xikk6A9hp9BfC61mUCphtO
         RyM9OQEuO79vGBPtKMsxQbTjcraaqktawn4sxyXTrjQQNCiMSmo31tQjp3Wa0NajyCK4
         icF02zdwOrgZcwfg6HZx735jAT6p/pGJzUV3UtzhiCv9+TR5bGy8LBtrQ4sRh6ntfXvC
         YDF/THzkOuaYaHp/ZFhelkY+t4rni4pQLmRSTkWGpN4RUbUX1ux+KRFw9Xmpo48HWfX7
         9WCUkC92lhVz0I9yOo1LaKpVkWd4ejI17TAuhZmpbId5YTQRCOd098vf/VKk7kq62Teo
         twHg==
X-Gm-Message-State: AOJu0YxpCpb3yrD60WXRMuD5ysts3sBxqJwnNcUJTh0M4ogEAgTaWkdJ
	SrtNdUIKTW+Z6ar7VQB0f6BlWVrS6kPqagfFRLYdmt5mJXP/s1MSqECeGpv6fA==
X-Gm-Gg: ASbGncvhJ6SdIDcpol2iHdDfE4dGB3T0YwOGCIlnwrAM5MI8gcwJpOwmwug1eW1ZSKl
	NQUKYl0XijoxWwoyino+4/WqXlR+1e5k1Koo1fVCj8OvIxFlCP7Osq8XUd/s6dGqZoQJ83jyB/z
	DBjPJJi6t6NpFTyHdewZoty9Z/n1nwP1FbK1APln07FVLh5FSUaJaBjAFfI9Tc1L3Y511vasn4z
	QTlM2ZvT07JSsI1SWCWV8ICWF32DZ3VE/OLNx5AziclBkUwWDCTYJxkr2QTMbX87RusjpTjl6If
	xAelgQ6nACodds0kShBWOTMvjImTXAQ3t/tdCf/B2AQFiXyMEDWY
X-Google-Smtp-Source: AGHT+IGoNdd0DE57hpWSVZkb+THvQCa94U5MVLFrFuRZYoI9Lf3m6wAKxDb5wHS8lXompF4kXBDmPw==
X-Received: by 2002:a05:6000:4285:b0:3a3:71c2:f753 with SMTP id ffacd0b85a97d-3a371c2f94dmr13129281f8f.34.1747913207887;
        Thu, 22 May 2025 04:26:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3631c728esm21541549f8f.60.2025.05.22.04.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 04:26:47 -0700 (PDT)
Message-Id: <pull.1925.v3.git.1747913206622.gitgitgadget@gmail.com>
In-Reply-To: <pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
References: <pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 May 2025 11:26:46 +0000
Subject: [PATCH v3] cvsserver: avoid precedence problem between ! and %s
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>,
    =?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>

From: =?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>

With perl-5.41.4 and newer, test t9402-git-cvsserver-refs.sh
(specifically t9402.30, t9402.31, t9402.32, t9402.34) fails, because
of the new warnings[0] populating cvs.log.

Use the 'does not match' operator '!~' directly to express the
negated pattern match, resolving the precedence issue.

[0] https://metacpan.org/release/ETHER/perl-5.41.12/view/pod/perl5414delta.pod#New-Warnings

Reported-by: Jitka Plesnikova <jplesnik@redhat.com>
Suggested-by: Jitka Plesnikova <jplesnik@redhat.com>
Signed-off-by: Ondřej Pohořelský <opohorel@redhat.com>
---
    cvsserver: avoid precedence problem between ! and %s
    
    cc: "Kristoffer Haugsbakk" kristofferhaugsbakk@fastmail.com cc: "brian
    m. carlson" sandals@crustytoothpaste.net

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1925%2Fopohorel%2Fcvsserver_parentheses-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1925/opohorel/cvsserver_parentheses-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1925

Range-diff vs v2:

 1:  a15f924657c ! 1:  b7563182492 cvsserver: avoid precedence problem between ! and %s
     @@ Metadata
       ## Commit message ##
          cvsserver: avoid precedence problem between ! and %s
      
     -    With perl-5.41.4 and newer, git-cvsserver fails to build because of
     -    possible precedence problem[0]
     +    With perl-5.41.4 and newer, test t9402-git-cvsserver-refs.sh
     +    (specifically t9402.30, t9402.31, t9402.32, t9402.34) fails, because
     +    of the new warnings[0] populating cvs.log.
      
     -    Added parentheses avoid this issue.
     +    Use the 'does not match' operator '!~' directly to express the
     +    negated pattern match, resolving the precedence issue.
      
          [0] https://metacpan.org/release/ETHER/perl-5.41.12/view/pod/perl5414delta.pod#New-Warnings
      
     @@ git-cvsserver.perl: sub escapeRefName
           #     desired ASCII character byte. (for anything else)
       
      -    if(! $refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
     -+    if(! ($refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/))
     ++    if ($refName !~ /^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
           {
               $refName=~s/_-/_-u--/g;
               $refName=~s/\./_-p-/g;


 git-cvsserver.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index a4e1bad33ca..7ccd720019b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -5009,7 +5009,7 @@ sub escapeRefName
     #   = "_-xx-" Where "xx" is the hexadecimal representation of the
     #     desired ASCII character byte. (for anything else)
 
-    if(! $refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
+    if ($refName !~ /^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
     {
         $refName=~s/_-/_-u--/g;
         $refName=~s/\./_-p-/g;

base-commit: cb96e1697ad6e54d11fc920c95f82977f8e438f8
-- 
gitgitgadget
