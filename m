Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539B82010EE
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228476; cv=none; b=ofucLzcsLN7LwMJY9mCZFnuVc0w8pg3Hvkvi04lkLgJ2Q6GYoS3pYeHDzumcf04E/wxDFcVThUkmuEpXU37gKLlO/zrJw7EfE93f1v4i1FpbddWIcUqpkqUCZNR7VJYoJc5UR85hB4vhKVbYdzT0wRGOeZZIoMXqHXaLmLC6SM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228476; c=relaxed/simple;
	bh=BJuk6d+Vo58r0DIAZ/O3zs8HZKR/Dm/VGY0HS9Ec7e0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a/6O+6CqUrKHZFJcbHs/Fyj1I2SPVwCNa9L23+47FNleBrO2LH5MfjPRUwh3wX8t/PVnlJQM08djICyVmqeB2eQLLo5YAk8Z7D4yhKxJjWZ8pB4dlBgJChkE0usH11pmkqRZI/wbhvajKpdLATiUkIbGWP7+4HpAiyuG/3BNAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZaJ5hXNl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NN5Bc703; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZaJ5hXNl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NN5Bc703"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 89A571400126;
	Mon, 12 Jan 2026 09:34:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 09:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768228474; x=1768314874; bh=XQjnrDCVTa
	taoMFzPEHtOFVjMh/XL9q11iMHjMKlSfI=; b=ZaJ5hXNlsnq1Cwg4qPZ9d7gcKV
	HjupYtntILE6jBQsVaoA5vDEHqEV3hO+Jci53tW5a19Y4BBTjQExxW3W3ut0Kdw8
	BFZL/AqtqlWZBST4Dlc5/MZzip5w4tz5DNTIAEh9CyqulOLoILiycWrc8AIkQtMk
	X2Ay+5wuEBle/ZCesuadcwTuFgXdy/hwlOmd4yyA2qKE2sz8RtHAyk6KIusUdGj4
	4VfnaGWDIkij7H+B4ZFDVsm3QZGuPKEljSuQtJW4j45LmbIUYtbkDrBa4eFprEzb
	j4J80LvlJFUlVJWneMtjyiWrURfr1WvdahKVl3nwgktCNRsaGb79INfV2+3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768228474; x=1768314874; bh=XQjnrDCVTataoMFzPEHtOFVjMh/XL9q11iM
	HjMKlSfI=; b=NN5Bc703tU5SBvBApkd1T2Z43N/FWLG9+BhW6yX71vlqUQiSDm5
	oIke4MZZJTG0lsTC3IyEW/+D9luoxd086MmZ6OmQK3pVOlt41bksOS1jm9+4l514
	qEAlSsQ01FTQjkkroVyRTmSjtLHFgCYgMgov4n+0OtACzUSwfrmkawghd/gWRe1L
	KdL7Jh6Ja4vzicHrdzpmovFfsw5YFyvzF1THZ7fdxFpToOojU3iY1jvh5bL2Tp2f
	Lsj3mh+5Ln4EABiDWDsDO4P4e2ntJJuKNOEypTZyiy5PWLBZCnJMK3VQHdBTwQm3
	fZ1T8HULA3tQik7uGQ8fiCoPxM9JYDcD43A==
X-ME-Sender: <xms:egZlabrexCnrXwREfcSnlyiI-sGZxYRrPferyHhMZnhR23dFOX25PA>
    <xme:egZladHoN_q17Evbf16tSKMKHJYNQgYDsPM4wMnZ30GdfI1HruZwStVETISrxOuH4
    bJrVfzaVOknzmaQtdgjJWpH1ORCKTJRhA6yU9X9FH9ju3CT0Wc>
X-ME-Received: <xmr:egZlaVnvI9hqvOr-VGf0N3vqwBnXa-pep1_un1iv-iYsX5v5RcX28Q1bm3vPDREOlTytbQ2k4ol3n6IUTZ-1kE7zIbTYUl0n1EbKsHk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:egZlaYliLQ3YDM2-yLLx2eXLvPUgkUhYoW1eh6MPXYbJuxI3C7QieA>
    <xmx:egZlaeuFh3Hyd3HrYqH8FtWKLVnet7Au3uCWqT5jqA45y_8-kYb0hA>
    <xmx:egZlaTmoOmIC0jCPjLnLPMPL98qPCn-9wNwM99UAtjdPXZGPdVlRfQ>
    <xmx:egZlaRvge3amD-nkVhIqzznR8c6QpeC9RaschDUa9hAXdodWdvlfDQ>
    <xmx:egZlaVFioVykYm7pZU4mA3egq7lH2HWoO83DjD0Ei30AardaspYawYQV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 09:34:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: MyFirstContribution: fix missing dependencies and
 clarify build steps
In-Reply-To: <20260112094030.314203-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Mon, 12 Jan 2026 15:10:23 +0530")
References: <20260108174651.1618874-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260112094030.314203-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Mon, 12 Jan 2026 06:34:33 -0800
Message-ID: <xmqqcy3eoq6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> Fix several issues in the MyFirstContribution guide that can lead to
> confusion or test failures when following the documented steps.
>
> * Add missing header includes in code examples (environment.h and
> strbuf.h).
>
> *  correct manpage synopsis formatting to prevent failing documentation tests.

Two spaces???

>
> * clarify documentation build prerequisites, particularly specifying for DocBook-XSL.
>
> * specify the use of parallel test execution with -j$(nproc), noting that
> it runs tests using all available CPUs and may be adjusted.
>
> These updates improve accuracy and make the first-time contributor
> journey smoother.
>
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
>  Documentation/MyFirstContribution.adoc | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index f186dfbc89..38f2a23e77 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -331,7 +331,8 @@ on the command line, including the name of our command. (If `prefix` is empty
>  for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
>  helpful. So what other context can we get?
>  
> -Add a line to `#include "config.h"` and `#include "repository.h"`.
> +Add a line to `#include "config.h"`, `#include "repository.h"` and
> +`#include "environment.h"`.

Good.

>  Then, add the following bits to the function body:
>  function body:
>  
> @@ -429,6 +430,7 @@ Add the following includes:
>  ----
>  #include "commit.h"
>  #include "pretty.h"
> +#include "strbuf.h"
>  ----
>  
>  Then, add the following lines within your implementation of `cmd_psuh()` near
> @@ -504,7 +506,7 @@ git-psuh - Delight users' typo with a shy horse
>  SYNOPSIS
>  --------
>  [verse]
> -'git-psuh [<arg>...]'
> +git psuh [<arg>...]

Removing "-" does make sense but did you really want to remove the
quotes around the command?  If you are moving to the [synopsis]
style from [verse] (*), it may make sense, but otherwise...?

    Side note: see de56e1d7 (Merge branch
    'ja/doc-commit-markup-updates', 2025-01-29) for example.

>  NOTE: Before trying to build the docs, make sure you have the package `asciidoc`
> -installed.
> +and `docbook-xsl` installed. See `INSTALL` for details.

I suspect this is highly distribution specific.  The asciidoc
package is typically packaged to depend on or suggest the docbook
toolchain including docbook-xsl, and if we start adding more "to
help newbies", we'd face the problem of "where would we stop?".  For
example, on Debian derived systems, the docbook-xsl package
typicallly depends on the xml-core package---should we also list it?

I personally find that stopping at asciidoc and let the user deal
with their platform convention to get asciidoc working, like the
current documentation does, draws the line better than the above
updated text.

