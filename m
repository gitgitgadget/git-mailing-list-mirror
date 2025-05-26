Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237A8488
	for <git@vger.kernel.org>; Mon, 26 May 2025 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267311; cv=none; b=B31c2N5q6P8slSiwv0vDOZdnzL48RCbfyXBYtVF7Nbcee0nkZtPq0UEuPNHLhOdxPU9IYneRG2fyGBnOJwo51t5n52j4Fvj/STNbR76A5m5nYCh/v/lFYUNdxs/wrofHpVhhEJT/RGhEaI8Z2v5Ltb9GLc+cV9GrjS4sFvURnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267311; c=relaxed/simple;
	bh=7YzriAL7T1n+P1yVDfisnJp+a6JsgU+j05X5vhoDRyU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=uCy3eiNf00G3y6onv9kjtmcm93s4K6q96BrTy3hFOsg24+F9TizAMl1MioEY2XFvwyLogcow+LwTSWm3/rr4KN6rhtLImo6FjDyzEQesv+JoqEnEWPIFZ8ZJ0C/qgbI2tpLRs+/d5pOp7hFqdOueBlkfV3uoh1MDSYTcug001Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhlXbH6h; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhlXbH6h"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so20691755e9.1
        for <git@vger.kernel.org>; Mon, 26 May 2025 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748267307; x=1748872107; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X6Yf/DYNG7Af67EzzxvJdHkoibMAcm4d9rsljSIAsI=;
        b=OhlXbH6hK6QDyTG59XWo0aCQTsRYafUrnm6kGDirdifjNnAMbgLbH2bEuCdIoKDdV4
         oSYpXnLbq421hmr6FqZIukKZqq1kaUgeSBXWoOAkBPndvpGmk8qYiBV+xeayA8AyLWvU
         zHR6oCYIWgF+ZVjOIavza7KgO1hcKCx6E/nrwD0CIFfJxN/pcewHSEo+dzQ93UEWgZJJ
         SDbZ91ynqJmoSEdcJk3lmttiHyvPplXl+C73xjAfatCp3c3ZdcAtzfaYv0bNuzPlcY/O
         FhJTY3K708M620U4VbuiXB1wNDTs1/bMnB2FCb9aY+zY09YVuzYd5O19bDAzpzIpPO0p
         L1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748267307; x=1748872107;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X6Yf/DYNG7Af67EzzxvJdHkoibMAcm4d9rsljSIAsI=;
        b=hDjvQ6OoUOQYH/jMlqM0T3eJPxuUj4pn1TOmDrTR652B/YZeLy7Gzv0ImpfjvRZedc
         eFyTJexkqKHkVIuANy+VFUxbX/FAnskR4fADmaeZYHR0501p/Gv+Y2ojkcQJVvyORu37
         7vUMqKyuEWz2b3X0CvGMW+vwwlQplCDfvo70RXXQ8mm7OhRlP2KudeH373hiyc3jhj6d
         PSdvp3OLhGtl/KuDAXjwvZidwEpxrtE2pIa4BKFyEo2TfkBdJcTNpQJzGJgKQU7mftVd
         rx3Ud8rhNOqpBPAXTe7B7/yRYfR581QByPeDZegDNTE9mTyuyUJBsBldpnywfSdAH4cN
         PgvA==
X-Gm-Message-State: AOJu0YzSA5pLy9ZUX1qR4hPv4WW7rL1HdiYgHrSzX8kxzumXU8sPv75N
	33jEmjK73hC+Gt0RaXaoKLE+yZ/HQbHSTuDCBf91hvv88fBPuGgGr8VPyY5qeg==
X-Gm-Gg: ASbGnct3yCEegEdcRNZB00Np/MxTewf51W++Y2R1czZV82ucABCN0Hww1XfyKIlltuz
	eAk8JuFsqvmEHp/TOwcMO88JIyUSqqp7U/FKecVTO1f36eK7e0SE+cwTpwkoSFesnUqREABW93w
	n4W702fKd2gfumogodvZL1BOdGrsMjzFBVcqgvCjNOu5BD+porXjeFbud31s7U4+ejtXk6rVIlp
	vTKg02dJBxMm1sTpu63Jg/M2zfMQrF2ojCtIF3YMCYJOZUvfm+m6IQbUl3fyU3Tc6T3s9mbpsuM
	3PCJouv6xCPY1gTNcy6FheaNktkRXZUql6DWyjKuwK2YZqBuC+Yq
X-Google-Smtp-Source: AGHT+IG3nrK7Ye0IgGtOl+9EE+m5CQqkM6fPjBGNdsapSrrQV7iS25ZjeXyK9CJf6c/qvLU9XwJfgA==
X-Received: by 2002:a05:6000:22c3:b0:3a1:f78a:42f7 with SMTP id ffacd0b85a97d-3a4cb464890mr6251095f8f.32.1748267307289;
        Mon, 26 May 2025 06:48:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a37fb452e5sm17364428f8f.20.2025.05.26.06.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 06:48:26 -0700 (PDT)
Message-Id: <pull.1925.v4.git.1748267305871.gitgitgadget@gmail.com>
In-Reply-To: <pull.1925.v3.git.1747913206622.gitgitgadget@gmail.com>
References: <pull.1925.v3.git.1747913206622.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 May 2025 13:48:25 +0000
Subject: [PATCH v4] cvsserver: remove unused escapeRefName function
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

Function 'escapeRefName' introduced in 51a7e6dbc9 has never been used.

Despite being dead code, changes in Perl 5.41.4 exposed precedence
warning withing its logic, which then caused test failures in t9402 by
logging the warnings to stderr while parsing the code. The affected
tests are t9402.30, t9402.31, t9402.32 and t9402.34.

Remove this unused function to simplify the codebase and stop the
warnings and test failures. Its corresponding unescapeRefName function,
which remains in use, has had its comments updated.

Reported-by: Jitka Plesnikova <jplesnik@redhat.com>
Signed-off-by: Ondřej Pohořelský <opohorel@redhat.com>
---
    cvsserver: avoid precedence problem between ! and %s
    
    cc: "Kristoffer Haugsbakk" kristofferhaugsbakk@fastmail.com cc: "brian
    m. carlson" sandals@crustytoothpaste.net cc: Jeff King peff@peff.net cc:
    Todd Zullinger tmz@pobox.com cc: Matthew Ogilvie mmogilvi+git@zoho.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1925%2Fopohorel%2Fcvsserver_parentheses-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1925/opohorel/cvsserver_parentheses-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1925

Range-diff vs v3:

 1:  b7563182492 ! 1:  ce853594ceb cvsserver: avoid precedence problem between ! and %s
     @@ Metadata
      Author: Ondřej Pohořelský <opohorel@redhat.com>
      
       ## Commit message ##
     -    cvsserver: avoid precedence problem between ! and %s
     +    cvsserver: remove unused escapeRefName function
      
     -    With perl-5.41.4 and newer, test t9402-git-cvsserver-refs.sh
     -    (specifically t9402.30, t9402.31, t9402.32, t9402.34) fails, because
     -    of the new warnings[0] populating cvs.log.
     +    Function 'escapeRefName' introduced in 51a7e6dbc9 has never been used.
      
     -    Use the 'does not match' operator '!~' directly to express the
     -    negated pattern match, resolving the precedence issue.
     +    Despite being dead code, changes in Perl 5.41.4 exposed precedence
     +    warning withing its logic, which then caused test failures in t9402 by
     +    logging the warnings to stderr while parsing the code. The affected
     +    tests are t9402.30, t9402.31, t9402.32 and t9402.34.
      
     -    [0] https://metacpan.org/release/ETHER/perl-5.41.12/view/pod/perl5414delta.pod#New-Warnings
     +    Remove this unused function to simplify the codebase and stop the
     +    warnings and test failures. Its corresponding unescapeRefName function,
     +    which remains in use, has had its comments updated.
      
          Reported-by: Jitka Plesnikova <jplesnik@redhat.com>
     -    Suggested-by: Jitka Plesnikova <jplesnik@redhat.com>
          Signed-off-by: Ondřej Pohořelský <opohorel@redhat.com>
      
       ## git-cvsserver.perl ##
     +@@ git-cvsserver.perl: sub gethistorydense
     +     return $result;
     + }
     + 
     +-=head2 escapeRefName
     ++=head2 unescapeRefName
     + 
     +-Apply an escape mechanism to compensate for characters that
     ++Undo an escape mechanism to compensate for characters that
     + git ref names can have that CVS tags can not.
     + 
     + =cut
     +-sub escapeRefName
     ++sub unescapeRefName
     + {
     +     my($self,$refName)=@_;
     + 
      @@ git-cvsserver.perl: sub escapeRefName
           #   = "_-xx-" Where "xx" is the hexadecimal representation of the
           #     desired ASCII character byte. (for anything else)
       
      -    if(! $refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
     -+    if ($refName !~ /^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
     -     {
     -         $refName=~s/_-/_-u--/g;
     -         $refName=~s/\./_-p-/g;
     +-    {
     +-        $refName=~s/_-/_-u--/g;
     +-        $refName=~s/\./_-p-/g;
     +-        $refName=~s%/%_-s-%g;
     +-        $refName=~s/[^-_a-zA-Z0-9]/sprintf("_-%02x-",$1)/eg;
     +-    }
     +-}
     +-
     +-=head2 unescapeRefName
     +-
     +-Undo an escape mechanism to compensate for characters that
     +-git ref names can have that CVS tags can not.
     +-
     +-=cut
     +-sub unescapeRefName
     +-{
     +-    my($self,$refName)=@_;
     +-
     +-    # see escapeRefName() for description of escape mechanism.
     +-
     +     $refName=~s/_-([spu]|[0-9a-f][0-9a-f])-/unescapeRefNameChar($1)/eg;
     + 
     +     # allowed tag names


 git-cvsserver.perl | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index a4e1bad33ca..d8d5422cbca 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -4986,13 +4986,13 @@ sub gethistorydense
     return $result;
 }
 
-=head2 escapeRefName
+=head2 unescapeRefName
 
-Apply an escape mechanism to compensate for characters that
+Undo an escape mechanism to compensate for characters that
 git ref names can have that CVS tags can not.
 
 =cut
-sub escapeRefName
+sub unescapeRefName
 {
     my($self,$refName)=@_;
 
@@ -5009,27 +5009,6 @@ sub escapeRefName
     #   = "_-xx-" Where "xx" is the hexadecimal representation of the
     #     desired ASCII character byte. (for anything else)
 
-    if(! $refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
-    {
-        $refName=~s/_-/_-u--/g;
-        $refName=~s/\./_-p-/g;
-        $refName=~s%/%_-s-%g;
-        $refName=~s/[^-_a-zA-Z0-9]/sprintf("_-%02x-",$1)/eg;
-    }
-}
-
-=head2 unescapeRefName
-
-Undo an escape mechanism to compensate for characters that
-git ref names can have that CVS tags can not.
-
-=cut
-sub unescapeRefName
-{
-    my($self,$refName)=@_;
-
-    # see escapeRefName() for description of escape mechanism.
-
     $refName=~s/_-([spu]|[0-9a-f][0-9a-f])-/unescapeRefNameChar($1)/eg;
 
     # allowed tag names

base-commit: cb96e1697ad6e54d11fc920c95f82977f8e438f8
-- 
gitgitgadget
