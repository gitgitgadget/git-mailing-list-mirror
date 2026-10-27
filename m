Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112936;
	b=J10GgETxk1RKt3Z+xwssqgI0MhNAeDx7I6sKTEBhRTrQD5n4F2cqWnuWZiFfJArCcHge
	 oruCVaFvRlj4E3+J+HRPeSoGkVs3hwEdE8jnmzuEc0k+npd2gQRLrIWbgc01vfPovnnos
	 sacXyvuacQG+6cMa8n0r3Q16ylmsjMRBIDZ3Wyg4jOqatMp62jkS0waAha6qbvUJGt4nO
	 i2SXybKLnsq4gVogqZE2Ir6kS1XnPd6VB/EspklKlp2J4b/ORh1Ns0aliMWIBimhf09Za
	 wdEjHwy0wQFGoUvoTKdkVxkGxilQPbuNySU1Ty9K20Soafsa6NE/e3CTaQHcuLXmrYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112936;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=U0lZNAMpgQTU0J1ZPbk+G+6+B/vGuCGrSOzVRnWL0hU=;
	b=KeyGx6e4I451PhRdhpwQDUGHvJ33oxorEA7b5GoP2e4adCYDtvgxWJXvdp2pP4oRekKB
	 oYAJu/JFidDHByZprFwdViMLvEpW12ZIw59p9TRDxDCLGAD4aKcH9cKuTvudyTPfzGBcY
	 mg2xSc2NiaYGEySgPq+3XpEou/bMyenoS6hl6QmCiQqHZL0JENLCy1T8hjF6auyPQJnrR
	 UnvzOFwEwxRH1K6npotUl++uiWYfbnbCIw52HMrAG8vuTB9tILybJCCxb8GDhb2NZ7GW8
	 je4oSBNatqfXLPcl927QIIYxa79HSHiksPtpsSRhBd3ASnwuM/buO5ZLSBlay8JjboQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=pz1rblEf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WNkAoS4b;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8AC606A321
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B8AC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=pz1rblEf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WNkAoS4b
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65CDD1400082
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:55:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 27 Oct 2026 10:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793112935; x=1793199335; bh=U0lZNAMpgQ
	TU0J1ZPbk+G+6+B/vGuCGrSOzVRnWL0hU=; b=pz1rblEfDvjX0ADgM6f/i2QYyu
	okQp4HjDy50Q58KEyDXtC/uE2IcNzE/YTAi9sEIH5d8pNAqdTdZOakiibhbbTI/+
	edpu/H3q9WBMf99n6EDeoPfK7jPISZRFN2ufaGDmjcW+qtPtCOdopr/nV6KIApM5
	ODZlUUx6JHPEcMpZzxqTc2vAw+46wP/wjlNV8uXYuAOpIEQxaIxIXQV3tX+q5hKT
	ikWlzeiQhbhTi5nC2LQ+RZ9i5b7IXcxqsEmBlgZUN6j+UFi6F03r3o/Hv95AcaIL
	8hqr2irqwLMrwWmyRFOMXOSq9m8cfyCCzWbXgX1ASWAFYQGl+FBuMXmsCTHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793112935; x=1793199335; bh=U0lZNAMpgQTU0J1ZPbk+G+6+B/vGuCGrSOz
	VRnWL0hU=; b=WNkAoS4bxMGfT4OSslqNyiYiM+OGKuVi305RtanHMeuty2+LrmX
	iIWqkiPjaVn6bb8N7il8VLiwxdG1c1CLD1vAUWTdZ0veaIxIPDZQJX9f3j/68BqI
	+7iT79QIAFNen565Io7JtDBMN6J+v1ebaj6bqDw7yXaWr+Jh2WyhlgQAd5WsSpvo
	AHcGjp2Dv3Y7y6SoV3/AVMCOMGakvpSgHcwa0GdNkaqRnHZlpKTxig4yGTFsitKp
	+C7gQoIISYMtc0FYZigimNu3fIk7GQJReK5OISxdZFJtL2FYJurbFCjbeTycaB2r
	3wOwkFc81iiQlnApk0YGDlilW2k7+T/1dwA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793112935; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:e0f1IwuPA7TniHA2SjTRXIFabni3HQlno7nps5rQ1Hlo0bP
	oBgCU5FdDEkAfc35aUSL4C4qCZvHWSNc+qbV53J6q7sFO1AMoTzSeqgjqAHamXxv
	RMDlt6hqSi3A31hyiHONuQgrn9P6vgXPp+Zt2//ku54TempwqLkE9sgduCnMLQXk
	nLjdDzoOsbm3bKTmPOq6ISwwZJgfgL4YnaKXs3JfBfT1t23+HtP6xK5agEyyod1O
	dQV5fnS6+irF2QTA6qBePlJ8inaWDSuFkyNVpPuxPTB0tx2iu2Y9KkZqmJ7bWoJh
	zjT4oId7q9qoyqD1YJZ7OUcBO87BjSydp4LmwVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BnxaX5bWPnuT0BLF3fCazTkyyaU5eUJVLKlkUbZTDQ0=:QWqc7KR6dy32pnmWqi4rWrKNC23b99Y3VyTGdXP7dxw=;
X-ME-Sender: <xms:Z7vgapsiqLVsdYZRSj1bI6NTmFqo_PAMOUKXe_M56sCrJBomzaW0DQ>
    <xme:Z7vgaoedJZGDBxkUXMnwyxUvX8Zsd3qejFM4eset7ls2Hjk3Vgf0bPcfoA1LuXSqc
    yhqGhsWlfXPNyVraMzDIiuHmVcjh4pEXiP1_iEORyGjyY2OGjzuGA>
X-ME-Received: <xmr:Z7vgaqZSSBfJvncG3BCixpSx2x0fVgS-EiXHYkPZYblrUmjfIz1exg>
X-ME-Proxy-Cause: dmFkZTFtW5N5GRtFQZdyyoIvJX4mPq8Se0LtbnzJNpc4T3CpPUZkG9LuLlO0Abc5bppnMG
    YLwiaV9wml1X7YtLVWNsAxcLrHN2Gy8lukaoyfsyadREQWcSW/NdyjKx+9mXyM0vuEJKgk
    Bu7IdBC1/r2HLcFtHXyvCPTTNqYJOWuFrzKFU8DJGclfSXMCLFRivWdnzCfJjOUTce8d9f
    7Fz/YVsQMzlESECtpCuA9oEhToQtTf5xE5XnfcT635r1wd/HhdannL7siIcQgx682pvQwv
    oKZO2sxoYaR1NDyeoSkOfTDmQwf9cObCAyKFHjI7EzwrNdeZnj2hsTuVGP+KmpRZJxbDmd
    vDcD+4T0yhwkLgttSgYfK1sPUcgVUvNlFluJ+DQ5swO5DlJs4gKXJju0Wue0daO9E/Y/7V
    VZO3ZfM7jGJepgm6VOkBCiTPpmV4j57yBgxDIYVZT7wJVO+O+dYeNKdhPo2sCAnJ2GFAvx
    mPH2rdOj745YMojyDkOJWo1sEAh1HPqzJamUAiNtvb7GR/WIITm+aCXPsD3A4ULVQb+Bz4
    LqcNVsIGxysx/u3+/K6qKMVfUjImBnsga3m8VqhasDJ2fuCspDFK7VdUsiG3+xYYV+LRDA
    kSg++PDuf7zmjdJQBAvw2LLCbPE+6Zdm1VBS34GT9ROzi3XZCeIZkg6sewww
X-ME-Proxy: <xmx:Z7vgarWd7jAsTd_DEToNocA8y8y8BeVbWM3HW447PE_-DA8k78vNcQ>
    <xmx:Z7vgashB7HkwQ2cPADNGkNJ3eukV1gDm-h1SXfP_N1OAfMJou8L4lQ>
    <xmx:Z7vgapWdqd5N_IAikSo6BAKm_mMDDBAK5MFgXOUr5kTqL4MqffVXyw>
    <xmx:Z7vgajOpvIj7WkZp6SQeBwP-ecw_O72m4snrjHdv-Zz8RnSwOh2DLA>
    <xmx:Z7vgalGaQaqN93IBlaGRc_R47QEZkW_BMCW4zZQBmBc25iw5iMjYIHH5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 10:55:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ffe3c219 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 14:55:33 +0000 (UTC)
Date: Tue, 27 Oct 2026 15:55:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] repo: add documentation for level-of-concern.
Message-ID: <auC7YzhTbn3q7GPt@pks.im>
References: <20261026-b4-repo-structure-concern-v2-0-e0df34228dc8@fastmail.com>
 <20261026-b4-repo-structure-concern-v2-3-e0df34228dc8@fastmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-b4-repo-structure-concern-v2-3-e0df34228dc8@fastmail.com>

On Mon, Oct 26, 2026 at 01:43:56PM -0400, Mark C. Chu-Carroll wrote:
> ---
>  Documentation/config/repo.adoc | 59 ++++++++++++++++++++++++++++++++++++++++++
>  Documentation/git-repo.adoc    | 27 +++++++++++++++++--
>  2 files changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/config/repo.adoc b/Documentation/config/repo.adoc
> new file mode 100644
> index 0000000000..811b099d72
> --- /dev/null
> +++ b/Documentation/config/repo.adoc
> @@ -0,0 +1,59 @@
> +`repo.concern.commit-count`::
> +	Sets the value of the concern threshold for commit count.
> +
> +`repo.concern.tree-count`::
> +	Sets the value of the concern threshold for tree count.

I think this commit can be split and squashed into the other two
commits:

  - The change to synopsis and documentation of "--concern" should be
    squashed into the first commit.

  - These config values here should be squashed into the second commit.

Thanks!

Patrick
