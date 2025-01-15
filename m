Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEBB35944
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980052; cv=none; b=DvBYtDRxqz2QgCaHf43t4RHt6QYKIU96jOpJE/0/JLSUHjEVLjfNw+RGQD2b1KQQFGq8phP3RoukVQNfGaHRsP4uhTToCTEVOnMsEIyl2T8iRbZ4KmpzRK8pOtPmlQyLXbA82+sofwvY3sG56RU7tjOUz4ztqX3qIetWYK717Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980052; c=relaxed/simple;
	bh=xhO1lJQkUXrFf4LX73nLuYOAkD+tZBmBKTzOUZUX4+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2H16CjWqUlb37aamZqLpv9wLVHRZ9zi1KIuzC0diIyZI7x1zQGh+ZlXbm0jWZWq06plxo1ihy/ka3mAODs429zuO8uBYY6Os0BwngP7n9yooitgIR9WyQc2AjvBj487TgxazqNaZe3vnV8CKDaJ53Vo3yEY0dA7cXeeUGYmAD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=THFpRBRx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="THFpRBRx"
Received: (qmail 7984 invoked by uid 109); 15 Jan 2025 22:27:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xhO1lJQkUXrFf4LX73nLuYOAkD+tZBmBKTzOUZUX4+Q=; b=THFpRBRxoi5giOyw/K1U0Epicw25aZj3L3SP9Ya9EQPz6xoHvymsbNv84+Gc3xu+RNUh6rvCUArQQa3Fcl6ClxxPiZiPw1hiCkLUGkVXDqC/IN75Anqs1E+F8cjMB6/0BskPLqYG0TN9cvy6ygQWR3b496H8n3jzg2BlnRNnwRdDwjA1Ksm3YFyYtscpHnxxQT3ov9rvXl8PaEz5KGc1mqE3ulEAkAqp4qn8kRCrApXjx+yhJGVkPo8GoROXHKT8WiONHzY+dMASdRiLXeYjg3nyAyi2p0ZnPDHL6OaAWIJkcOBtFX6pC2CxbKO9fWsfghtDPBmkViJJ0yxmzr+rrg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Jan 2025 22:27:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16158 invoked by uid 111); 15 Jan 2025 22:27:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jan 2025 17:27:31 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 15 Jan 2025 17:27:28 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>,
	Jonas Konrad <jonas.konrad@uni-muenster.de>, git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
Message-ID: <20250115222728.GA132248@coredump.intra.peff.net>
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
 <D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu>
 <xmqqed1414gt.fsf@gitster.g>
 <c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
 <20250115171423.GB57018@coredump.intra.peff.net>
 <xmqqmsfsx8oo.fsf@gitster.g>
 <20250115182419.GA86610@coredump.intra.peff.net>
 <xmqqa5brydz1.fsf@gitster.g>
 <20250115212952.GA96537@coredump.intra.peff.net>
 <xmqq5xmfyc4w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xmfyc4w.fsf@gitster.g>

On Wed, Jan 15, 2025 at 01:56:31PM -0800, Junio C Hamano wrote:

> Here is what I have as v2; there will be patches that touch
> builtin/*.c in between and I expect that the last patch to conclude
> the series will end with an update to parse-options.c (to exit with
> 0 when asked to give a help) and t0012 (to stop expecting 129).
> 
> --- >8 ---
> Subject: [PATCH v2] parse-options: add show_usage_help_and_exit_if_asked()

Thanks, this looks fine. The name is clunky but probably OK. ;)

I don't know if we'd want something like this on top. If somebody is
interested in just doing all the conversions in the near-term, we could
do without the optional flag.

-- >8 --
Subject: [PATCH] t0012: optionally check that "-h" output goes to stdout

For most commands, "git foo -h" will send the help output to stdout, as
this is what parse-options.c does. But some commands send it to stderr
instead. This is usually because they call usage_with_options(), and
should be switched to show_usage_help_and_exit_if_asked().

Currently t0012 is permissive and allows either behavior. We'd like it
to eventually enforce that help goes to stdout, and teaching it to do so
identifies the commands that need to be changed. But during the
transition period, we don't want to enforce that for most test runs.

So let's introduce a flag that will let most test runs use the
permissive behavior, and people interested in converting commands can
run:

  GIT_TEST_HELP_MUST_BE_STDOUT=1 ./t0012-help.sh

to see the failures. Eventually (when all builtins have been converted)
we'll remove this flag entirely and always check the strict behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0012-help.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 1d273d91c2..9c7ae9fd36 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -255,9 +255,16 @@ do
 		(
 			GIT_CEILING_DIRECTORIES=$(pwd) &&
 			export GIT_CEILING_DIRECTORIES &&
-			test_expect_code 129 git -C sub $builtin -h >output 2>&1
+			test_expect_code 129 git -C sub $builtin -h >output 2>err
 		) &&
-		test_grep usage output
+		if test -n "$GIT_TEST_HELP_MUST_BE_STDOUT"
+		then
+			test_must_be_empty err &&
+			test_grep usage output
+		else
+			test_grep usage output ||
+			test_grep usage err
+		fi
 	'
 done <builtins
 
-- 
2.48.1.434.g4084d8f956

