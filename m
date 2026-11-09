Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188400;
	b=pBSJGGquKqfTOA6tf1nYI2+RTiABpXCKIvhn00HDWvkmGbbWfH35UlegkY+k2luSO84Z
	 XY1LUnHa9Qq8JiCaYeil4MsOxS870Y9MF0WW/P5EE/7ma52sCK/xZbhnSIpj5mpqT41Mw
	 oN1nyj7A512EA+adnDFVkDyS5EJfCe7oXl6nLstazjmvja5WEt49YU0tdIWzCOzKFXbVE
	 Rp7gjOl98YTlRp31d9wa+s2FRrP8cS+HrUBZT/naaB9VUnavWOgf57YOGDaNBiJm5Tfiq
	 rS0o+IWCh/P3Ds771lnhulfI+7h9Zl8zfEeWetcVtbcGPPWY0o48979k7uWz8ZgFXiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188400;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2w5Do5y1BRiQt/Avu1LZO1NjmCiwWf8sOHF7lqg8PMo=;
	b=sPuZ7Hg9QSzQv2sK7Xz+cueMdT26ekr8zsrNDuzA0/573BrKAQEhbqHluTY1lMMlgJ0A
	 idNeZDLhnpGf4+XGcsdyTnMdXHHotCGMQtA0c4BewKcaEiuwCcL16caoS8naQ47CRVhVL
	 4TONbBD71cVW1PhSrtAkwxvlC0v2BXU1aZtLb8Mh0lOORbT17G/C0ca4JHjgItIRVI+26
	 7xUxnx7jGK90ISbH66bM2alFAsy7qtFdfTyAFcPgWPcBYGRn3PhpgnrVdfR3PLsTDZNzs
	 QqapwC07CRpA0Ka3+wACO2RDufqvb4SrdRYlLA9sEMrKUE8+OZJ0RaI56QGMx1d9ASw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=g9Gp5wmV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AwkqUc0C;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BD1606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 01:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8BD1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=g9Gp5wmV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AwkqUc0C
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BA16EC0309
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 20:39:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 08 Nov 2026 20:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794188399; x=1794274799; bh=2w5Do5y1BR
	iQt/Avu1LZO1NjmCiwWf8sOHF7lqg8PMo=; b=g9Gp5wmVWbagoKfTsqW0eccguW
	PbZHnrO9mP0b8twt1PMXuL/lbmwa34wC2NfAAZAkm1+UjSSJN280lmhDoTd9VQeu
	7qorL67jjT1V14sEpiB9urmbtKcr91ZXfCIiBy5AL8eJJZ/M47LKs1fbJpUFJL5x
	rzZ0fER8YLszavbYJd4PpyeDAxECYhCViSVTjKdm0Y2EYOtXMo6kAEGrpfJHGBtU
	YpEBFs1dO/yzzbEfmKOG3DzziEjYlbq/ER92eVFDIHKQT8ltGj7FZAFowvDAvpsa
	orwy6UtFUahsoXYmqUG/ur3qYfxbLJDw3yFvbnO/TjDpSU1NpnTl9wNa+UnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794188399; x=1794274799; bh=2w5Do5y1BRiQt/Avu1LZO1NjmCiwWf8sOHF
	7lqg8PMo=; b=AwkqUc0CJhu0k6XJVI0QFkvFqIkMPrGt1zHqSrE7Qw4KA/qS/N8
	IH6lc1wOGnbBS67LieZLcYlUiDQQurCWtmbp/ZjW+LsI5XBXN9bkkivSQxSufcDW
	QI2DOutYaTKDs9OMF4SIG3xYejhbERXeV5tkIXsLE+hTlW9Hg3GFuYoguvI4xgZ7
	Pp3FeVX8gGnAT1o7pH3J4UypXp5q8y/Iznaf6j2sc9ytFBDOJSt9qGOBbfq6OX27
	WiRBCImjq6k6kaqy6j+aRvdG0MXk3j7lxia/+bVQNvpFCcQwFATn5N7kpq1cX0ay
	uRCu9Ue9TVrGnCb3xN4FfXgtq37H5VZUE/A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794188399; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ArVhmF0CEnX23i7jzLAqRAH+mCvoaoCzwK67A8Pz2CAETVI
	u++uxz8PGLkgl+FMCfGXFdyJF2K5PwizOwbO+HRmwxMXgu8/xxF2odBEP8lW46C3
	RdRMKKig9fhI6OlHDJVwMbd7fD86xY04B+tJZOgJh5VxVT8OeTZkrmJG7dizU0d2
	b6qCTXdP6V8fF+k2jzITgSIVeX/reKDYMj5C7K9umq/Ujemn1y6hbaFzI4HGqlAv
	1B7dBT/YfwoUVvr/Z4P9zrew4MIY0rsN8kr/t5cLKg2B8fCBocnvmVInVkdl/j8B
	w1UQQTL0qhdcCE2imemvsFSPNKhW4gOQ4p8mGFg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:WnE7eK9sUbk0hzBf5vaNCbkUrkYRUSxAgtYqMoO07PY=:E1bullE15Q76cjL0TlwpB7gi6Yd4JXXt5qYznV7Q8bw=;
X-ME-Sender: <xms:biTxavgkjli6kNrz6LzSwovVmB_jbTQUtU4qkCF8PxJ2dDWlNv8buw>
    <xme:biTxavvOzYXiS78XXYR-4aia3ca0k8VV2hUSdqO65_Z5CGjZEy7HKMohxVpHayVx_
    xbm0ghfkRTHk8i7DmPIW1QHYgmdru8NALQaq9VeY0OWDfJGLFaU3g8>
X-ME-Received: <xmr:biTxao79vaIF01ecgPbDfoKFYikhSFjvlPUr74Gp14Kz9BcqsI1wpb2H0acwff0_v5KZ8KqiY0tRA_ZtwVBsjNpi8Fx_Jyc3_uGN>
X-ME-Proxy-Cause: dmFkZTF/uvHEgSXiAIQdpQOIOI3yF+KFhoQRtHzZ+qh9uuGCC7uQtE5YRtIyLV4GOJiNpH
    tWycpmsrLcuPC2NDk1IteKYBf3SdIqKw5E+iOdHeB/Paa28OuWuSFhAado02UPXM/LWIJE
    erpxpUVyrQhEs08MBqZrZWj30ZavjxzUwImAU7/UzH1wR8ovKx4gIU1ciq+jcYAWw5WVL3
    pqKEX4DraA8ZcKhIFU83IL2CCQvrBmgO5zx+IQIm6M33bpAXv3t0WxRo+6I6YpUxQ83El+
    /g5cjk8hhTbfF+Ja+oAkg9W87mAT9QCX6x7l37CfldPy9V9EMCdgflvpzmcba3/sQjUmkZ
    bU998q+dGD0MrV+Sex+1ja1KlqSL2fI4plWK3NF+xC7/KtnIZ5XnRRPEJUBm3N3Zhh3DV/
    uVEHWhb+nKjmYp6ZCcR8BCiHvWvhPBlOSm4Ejt5vO8fm42NCunCsgErusPXDEhTbxjUEjy
    /e0HB841P+MH92UMk0tejEIgeJlJ9gL9Wr2AGWM2MZTTQGKW3UDt37HiAJ9yMgN3/m47VV
    Qcs0DJWbEtfmUEzJW00alTgyE+duB5qxsr0XuaLb3Oxung8anUql1hTjXUhf+HrAaHzW1c
    MSArBTG9uiN0Scbg62qXA8KktLH/RWbB31+DNNGRz3WUqTR8e0w+leoBPatw
X-ME-Proxy: <xmx:biTxajP5h8M71Q7mSUeJ6vFBJw1yQ4h2RsgB_aRqSTucGvGWzZGfUg>
    <xmx:biTxauu7QsaluFkfWsq71dCUK4xeFI8RMBiYLEo3xmptilywDstS_g>
    <xmx:biTxauZDE_Ws00eXaxvXQ7ezKesRYyi2gzo4d4ek6V0WVReI3_P2AA>
    <xmx:biTxaowDRcKZiseNX3EGekXYzF3wunTG5nJwKu8LW2yWBURnqz53ug>
    <xmx:byTxav1TjaHqlKa7aYk-dTOkjuphWHtdURjpjzy5bGNca36sv4cSLeGi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 20:39:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes Sixt
 <j6t@kdbg.org>,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2 1/2] t: add "test-tool genbytes" to avoid slow tr(1)
 on macOS
In-Reply-To: <54139a3a97127732e11fc5abbc9a3687542669f6.1794165304.git.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Sun, 08 Nov 2026
	19:15:03 +0000")
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
	<pull.2301.v2.git.1794165304.gitgitgadget@gmail.com>
	<54139a3a97127732e11fc5abbc9a3687542669f6.1794165304.git.gitgitgadget@gmail.com>
Date: Sun, 08 Nov 2026 17:39:57 -0800
Message-ID: <xmqqeccu3hqq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/t/helper/test-genbytes.c b/t/helper/test-genbytes.c
> new file mode 100644
> index 0000000000..b760326b24
> --- /dev/null
> +++ b/t/helper/test-genbytes.c
> @@ -0,0 +1,61 @@
> +#define DISABLE_SIGN_COMPARE_WARNINGS
> +
> +#include "test-tool.h"
> +#include "git-compat-util.h"
> +#include "hex-ll.h"
> +
> +/*
> + * Write "count" copies of "byte" to stdout, or an endless stream of them if
> + * "count" is negative.
> + */
> +static int generate_bytes(char byte, intmax_t count)
> +{
> +	char buf[256 * 1024];

Allocating 256kB on stack may not be a great practice, but this may
sufficiently work on most reasonable systems, as this is an internal
of a "run once and exit" test helper function.

Still, the stack memory for the primary thread of a process is
limited to 8MB or so on modern Linux systems, and I hear macOS also
uses 8MB.  I am not familiar with Windows, but some documentation
found on the Web seems to say that their linker gives 1MB to their
product by default, and among 1MB, 256kB is not an insignificant
fraction.

Again, this is an internal of a "run once and exit" test helper, so
declaring this as "static char buf[]" should not pose an issue; it is
not like you would need to have multiple simultaneous invocations of
this function, each of which needs to fill this buffer with
different values.
