Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809B2D061D
	for <git@vger.kernel.org>; Tue,  5 May 2026 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778022148; cv=none; b=JpXqXASXqu15cxCzz3jVp2YAq8lcs3gwsvWVqKBBArIriOy9CaD/1HJWWuD3VPEpjvNqw/KMLycfnvsd9FUr/Ixl4E/JpjXkCLmKDkNN3GjOtEdV1tlZRltHmaCnZOHFV4wGBxetebykStK/l70/pCEZAEHqamyUQm+/gCf5wgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778022148; c=relaxed/simple;
	bh=xj9laDG43Sp0Gv3VJe9rpP5WQ6WIG+FbeCRJmcCMB18=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JLYBrMGRPzwheSEJlNyGQ3fy83/jG7NwibFAaoSrqMpsqFwcGN4wWA0V82RZye1Vsiv8AQJdM0W3dun4Egl6PmBfStggAzHNLlNaMCgEwHXmr7INuVPWLB0gvlO8S3jMX4l4JtfOismg76GbEwY+QrVivexjTjSgXcnCEHitEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8ffRfV/; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8ffRfV/"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c15849aa2cso7876878eec.0
        for <git@vger.kernel.org>; Tue, 05 May 2026 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778022146; x=1778626946; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+/NmtU3Monq2/zg7NkFgl78V4pYux/3FbbaMmzcSEb8=;
        b=D8ffRfV/mVV1B/rZ65JPaIs1ZB+wF24nNJm9nXhnz522gc6fAGE1vsDmmtumR2Tm77
         io9ploZo1kkMXWwNmdUtdkil6mu8o2B/+x20+PseQ6U5DBXIeJDNUoc/hikuee6ypjwy
         gEu9qWKSpQhhBZWWt2EvUTZEZTHzH8o/u/2UW9NxX/yqh5hjIZTTiOzIt1nyzT/3U+az
         w/qFAlVz6kkDl7cG/6orBAPmlvfxC0yt1+56zp4KaP9JwsfI6q2rgnhZWEe2S6DzYDNq
         9GeSPHLBLSTixDI7pDFp9Uz5Q3Tx4KhP6KfFsNrOUYsWP5rSfEot4eSm6vUqnqhFAmD5
         dI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778022146; x=1778626946;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/NmtU3Monq2/zg7NkFgl78V4pYux/3FbbaMmzcSEb8=;
        b=M525dOwQKTLPVbn1ItUUnR64+CvDqm0mbCptYBY3I3nj1KY92DW6s7qZ0zp8NxcMQd
         KHkZ61hxoL/2jFRGVOrm0+vzA+Na01UCNt6pCruhUKEu04HX9h4AakbedJqPObF+tMPI
         tyXF5659z+cibRyhOMcZgmdalHoOyEjHyVcsbfQItRVaQRdW41+QNRzyvyA5qly09Rg/
         uvOXmqzpn2lSkbvsnjbcBfDyGES2df6AVHehmeHdlRRr3pxUy52kdQmnQVbWnOwxovk0
         qEuO1mThriePYMgie74nKWKO+qDFWInsZYSs3KUvLZc71ACYvEbeeVA2yTX7QwKfzgEe
         dL/g==
X-Gm-Message-State: AOJu0Yzi+cOyXY1U74jc+8/A6LJjcCJwKpQ3JnSnWTBKH0X4t6xzsyg7
	UeH4/8Jv/5bldL3WDB+sD5gj0a9fw3VvoVgFhMKVhibREl9kQnn+PUe6WL6FXg==
X-Gm-Gg: AeBDietZLJJqgp2QnsSh6hE5xmrgpKJAROzYuQTNMLp68HClC5eEaqWMnDkPm+HGnXU
	pfVCM9u4meKY8KViifdygRWKQmj7iwj74WaYOL8gqnOQ+2E17SJeXegexU+mMs8iBpHicLyoouo
	wGyvcCxvlb2mL2UPfOdfD2pcMzRp2j+yQqLU5HXkE0hznrRGST5uG+SEuku7uJ8ww8eIuDeFKTT
	ln4m6FtyjJXS1nISkhpvjkLMCq+DYGt3Nw05Gpr9THsq2nRyeU2mBH+LnDb4CQVGFXDdQAe8SRh
	uetgYsTnyLG8MC4yuOokd381URBl7kYqAvg1HZVFFoCpYmJGUV1py7GfPtoStDr4ySesEcv2sPe
	k80/y5S3bDpl3IKLhjfi86v3pPmx+YRlcWwIYhoH3jZPYmSKlNlcBqjtsi2VWpywKrZT7XJoRQj
	Fh19GfOsTeFrpcxyKUR/3PJdjk+x2qS0+Q
X-Received: by 2002:a05:7300:6d03:b0:2de:3022:a459 with SMTP id 5a478bee46e88-2f549f7c266mr620819eec.21.1778022145993;
        Tue, 05 May 2026 16:02:25 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.4.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56d8c45acsm1015590eec.13.2026.05.05.16.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 16:02:25 -0700 (PDT)
Message-Id: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 23:02:20 +0000
Subject: [PATCH 0/4] diff: reject negative context values
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
Cc: Michael Montalbo <mmontalbo@gmail.com>

Negative values for -U and --inter-hunk-context are silently accepted
and produce structurally invalid diff output.

Malformed hunk headers:

$ wc -l GIT-VERSION-GEN
106
$ git log -1 -p -U-500 -- GIT-VERSION-GEN | grep '^@@'                                                         
@@ -503,999- +503,999- @@


Line 503 of a 106-line file, count "999-" is not a valid integer.

Overlapping hunks that cannot be applied:

$ git log -1 -p -U3 --inter-hunk-context=100 791aeddfa2 \                                                      
    -- git-compat-util.h | git apply --check --reverse
(success)                                                                                                      
                                                                                                             
$ git log -1 -p -U3 --inter-hunk-context=-100 791aeddfa2 \                                                     
    -- git-compat-util.h | git apply --check --reverse                                                       
error: patch failed: git-compat-util.h:118                                                                     
error: git-compat-util.h: patch does not apply                                                               


Both options were originally parsed via opt_arg() which gated on
isdigit(), making negative values impossible. When they were converted
to OPT_INTEGER_F / OPT_CALLBACK in d473e2e0e8 (diff.c: convert
-U|--unified, 2019-01-27) and 16ed6c97cc (diff-parseopt: convert
--inter-hunk-context, 2019-03-24), the implicit rejection was lost.
PARSE_OPT_NONEG was added but only prevents the --no-* boolean form,
not negative numeric arguments.

This series restores the original invariant with stronger guarantees:

1/4  diff: reject negative values for --inter-hunk-context                                                     
     Change type to unsigned int, switch to OPT_UNSIGNED.                                                    
                                                                                                               
2/4  diff: reject negative values for -U/--unified                                                             
     Change type to unsigned int, add range check in callback.                                                 
                                                                                                               
3/4  xdiff: guard against negative context lengths                                                           
     BUG() in xdl_get_hunk() as defense in depth.
                                                                                                               
4/4  parse-options: clarify PARSE_OPT_NONEG does not reject                                                    
     negative numbers                                                                                          
     Documentation fix.                                                                                        


The config variables diff.context and diff.interHunkContext have
always rejected negative values. This series brings the CLI options in line.

Michael Montalbo (4):
  diff: reject negative values for --inter-hunk-context
  diff: reject negative values for -U/--unified
  xdiff: guard against negative context lengths
  parse-options: clarify PARSE_OPT_NONEG does not reject negative
    numbers

 diff.c                             | 25 ++++++++++++++-----------
 diff.h                             |  4 ++--
 parse-options.h                    |  5 ++++-
 t/t4032-diff-inter-hunk-context.sh |  6 ++++++
 t/t4055-diff-context.sh            |  5 +++++
 xdiff/xemit.c                      | 16 ++++++++++++----
 6 files changed, 43 insertions(+), 18 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2105%2Fmmontalbo%2Fmm%2Freject-negative-interhunk-context-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2105/mmontalbo/mm/reject-negative-interhunk-context-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2105
-- 
gitgitgadget
