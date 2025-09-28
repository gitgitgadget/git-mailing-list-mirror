Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA72BE032
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097443; cv=none; b=rRwj+MM/VdEYeB0zc6Rclqa/qYkQpTY00nJ5A628+zt/kMBni2Z2uEYmqLZyjZLiq+S20XZm9b6Y3CFc86T/vPs43UxBn7XX6icuOoyHCInhVHcTJbdmw0T1TanUylKYl3lrwWRFPEb3QfJlfh62ZCQPBH1cnILnEF+ACKa3pfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097443; c=relaxed/simple;
	bh=+aPW7p598sBtFZCKk2SCT0Rnv8+L61332L+5bolSmpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHohoseTMr9IzfKJqBNSyibVxGJ8M+nDKzGOGF5BOxhZLIxnYSYQ443yTIAwrun9xsofToqqQdnrZ6K0SHC7LX92GpNWPhD2COQmyuZASFdYlg16DhL4BE25F26gOOlXOdrkm/SHdzKHuyAkli/APPL3oDqUoCYNlSkR00oiItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=BDR5NreZ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="BDR5NreZ"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d603cebd9so50170547b3.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097441; x=1759702241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TfLZIQ0Vju+2EHekgGw5kdXMbzL3zbtWOYWyavWvMb8=;
        b=BDR5NreZI6F+/u4yqW8sQxuwbTYJwQy3Hrq7He2BP7j1osHrjpcu+FXRGnKCoVD4zR
         h/6LO1Ff2J/jXh6hz7cWK1OYfr+r5rIBmvuq0e2I5Q46okl30bWHTJhc52ZSLa1MQe+f
         ZDUcttNeG0UZ8XdSgS7eHL0Wbq6B6sqwspptPySNKl+CzagkPnplLcIKwx2qYgDhukpc
         QixTYI9d+g95hsB78hMxENt3tYdk6tsHYkZJB6NTwrlXMD0OaAfWYMaqYMvJE60DW9Qq
         AQYevTTMf+f/QW6KYFTMWoRjNDzxo/Ozqwy0q3Fc367yQIGhCLSSMmjCTsOwD4cH4vx6
         1Sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097441; x=1759702241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfLZIQ0Vju+2EHekgGw5kdXMbzL3zbtWOYWyavWvMb8=;
        b=nKZgWHli6pX+eRtgx29MHd84kJzRtEuvH/cnEYhAOhV4mGEYwSnCsgsMVslo7bCf0O
         dVwB6jVUgLNx3sgTKGrsbdlqQ8q999mT2CeLj45L+frlq4MkcFo9DBoxVQYDlTQvPjuj
         6leiyVTeUX0Q9TTAbUaL7oMQv8abwbeGk8Q2CMucwIzF6EH3gqRe6ShONOffPEVQ9Lh5
         DBPOEskQpFcV09D4+IeP/lkIZqkfhndVPMhttpeSeYEsOOKRS3clct/L9OCblwMBmvNl
         DWgez/zRtRl4UQrrUeSi4ZCRNlLm4I4Jln/R+at4vZLbRThnHUJwuu0TrwdlKmPwErsm
         pn0w==
X-Gm-Message-State: AOJu0YyqtD8pjDqvDFFoTqJ0gsUlMV3W4Dt02/ldHQtn60UGq1vQxrVq
	RiR01ZREdNr9ER2+nfKG1aGestgBBMP12On2YJXQTTHMur87w7eRLgmMPvOPYRQygCcP8+yD2Lf
	aKGTQYC8=
X-Gm-Gg: ASbGncts7avSRaAgFliInsMfH9B90OYL/tslgV/6yU7vgleSlJ18Y74SxO0/t0zS/cn
	T4mZw3flEJa627wNrwGRYtFDbnARb75R4PYE427Ij+t8A2PII4N1OHc/CENp8lKXGDsI7AdGqkw
	b1SmRX+7mIt+ATTUQnB6FbM8J5BKblH1dJOJ4Llc+YUVwxjfzZfOplATRXjyTq19EbA6hBU/9VO
	IBFMwPSciASHxV6VyoTyMDuvMoblj1BTb+u//vLJyOF/A0namamkHSBZxd4xol8IrIVRq5WO8gB
	/fUWbh8R09OJTlUfmCf7/bkhsRMe2Qs4y67jdRUyejQdzIbgm41HGSQ7WrKLiolAuNdel/FOMlT
	k+yVf4phcIag3CDBvFoeoNJTeA0yAmhLpG8CG5F5Ry/QbrJxcdVYMUnLk0CgqVrrqSlNTANbC+E
	z6MsKRZYus8HtIbNwbkVcbpiCFIBcVTvIU9HPl9Q+d0Yi9qLs=
X-Google-Smtp-Source: AGHT+IGAW6ED9JYZHxgApVCSfiGyyTNyRsTBN3GVWwcxAmYv62sU3vWfbeJc5KfIpD2hnReSTkDnhA==
X-Received: by 2002:a05:690e:2451:b0:635:4ece:2414 with SMTP id 956f58d0204a3-6361a8a9489mr13087005d50.52.1759097440782;
        Sun, 28 Sep 2025 15:10:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb383970501sm2963524276.35.2025.09.28.15.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:10:40 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:10:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 49/49] builtin/repack.c: clean up unused `#include`s
Message-ID: <16eca91f2c04b430ed40d1aa296a086d75195b14.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Over the past several dozen commits, we have moved a large amount of
functionality out of the repack builtin and into other files like
repack.c, repack-cruft.c, repack-filtered.c, repack-midx.c, and
repack-promisor.c.

These files specify the minimal set of `#include`s that they need to
compile successfully, but we did not change the set of `#include`s in
the repack builtin itself.

Now that the code movement is complete, let's clean up that set of
`#include`s and trim down the builtin to include the minimal amount of
external headers necessary to compile.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 9171ca66a7..ad60c4290d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -4,26 +4,17 @@
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
-#include "gettext.h"
-#include "hex.h"
 #include "parse-options.h"
 #include "path.h"
 #include "run-command.h"
 #include "server-info.h"
-#include "strbuf.h"
 #include "string-list.h"
-#include "strvec.h"
 #include "midx.h"
 #include "packfile.h"
 #include "prune-packed.h"
-#include "odb.h"
 #include "promisor-remote.h"
 #include "repack.h"
 #include "shallow.h"
-#include "pack.h"
-#include "pack-bitmap.h"
-#include "refs.h"
-#include "list-objects-filter-options.h"
 
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
-- 
2.51.0.243.g16eca91f2c0
