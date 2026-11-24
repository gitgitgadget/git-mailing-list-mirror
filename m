Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561447;
	b=RBG19mJTXGL17jRufOax0qYFyYJEb3M4EDfPy7Q8vduLShZ8T2G9mASe9yvSrDWfs7Ei
	 WkgcXzPgAVF9L/Sd/4qcdHJ6+jfTUWYDitIbiN6PDzFcpaEcOP/vAHpgDVLTwe45fqOky
	 mKW2fqCnNGNPK3CGtj7NFE2cQWK2EHuoibzX0VNpZOfK5R56fjP7foF9FCOqS1ihrxaxN
	 KC2UDcu6C4kmls7nM7EErPTqbBs8TbpzBRsxDqQUVIRLOF4HT8WGTuEcvBKfPzj2cqXTk
	 aDGGby7JRuqBeMeQl87uvTXuzCyHzsXrV6bAx7hydvPHewASDcdCMGjGY91S0NPsGgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561447;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=FWELDs+IKEcqjMxoqPJDaN4ZVXyzMO0+qWpQK6hgN90=;
	b=uacfV0hWiM2KN84iheeHoEuM//J1aoW7Izd3Hg2fVUQK3VNI6vr74Kmn9nlj+3ogJhPK
	 3g58k0uk0HwUatRqz/quWJu+uzuuB8yeY52Xxr2Wvc846+Y9lljsHkSErf6uGJmsJgv4Y
	 QHQdv9J6LUi0/J4GgIe0c96EB4VweDMIO7RNBD6qQbcKEkINTj6NGUlSYmx962X7Jzv6H
	 gxVT9irZwgxZv2ccgieYnc0SzdT95mNhos28DU4Y9g6Uw1YaN3Al6YWWRxqhkA62XdDK7
	 Rp2dAC+4BRb3TfsZACdccW/xegtBfJCMXrP4fz++bafWxQCuWrgiM+bFs5xjfGSZypQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=B1Z0eDpu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jma9nLgb;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A00C606A32E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 23:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A00C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=B1Z0eDpu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jma9nLgb
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 59EC2EC0ACD
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 18:04:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 24 Nov 2026 18:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795561446; x=1795647846; bh=FWELDs+IKE
	cqjMxoqPJDaN4ZVXyzMO0+qWpQK6hgN90=; b=B1Z0eDpuFejj1dCmOhSe/Xsacx
	23xZcjNcvt6EmGjrHO7lzuEOAGiWj1RqIKotR5j1usYuFxzn69IpbNl3eeei2IKP
	5h6Ys+1lqguJRZsu/3xVttNQGCr8YQa3BfB4Ae2RzzttsZpa1mSvj1Wi7i3WR4At
	d3jkSqepUGUoBQOUSXNWZn8Oqwt0PBMFIltQ905GOMa82JlITebtH4QBtzIg7i9T
	YEUisVzN6pOFJNZA9/c5p38Zl8IzKNQHaUWuznU4eiSt9hSRDpjxwPrPA12Hl+rw
	hCgpGwv0vv+bNyJjJVsuC3WjrleLGITX1s4HFHBYd4YpI0cMuVV4jFHMw56g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795561446; x=1795647846; bh=FWELDs+IKEcqjMxoqPJDaN4ZVXyzMO0+qWp
	QK6hgN90=; b=jma9nLgbfHoPTthIaGXdcq/WhtXL47lI6s1P3QuNR6nnpcdk7D0
	Dj6yofJyTxB3ZOtwuQgkTazff2hg7ltSFxmZ8gMBTtTgL3yvZ1tlbMp02quRybqP
	ibHHixCyg+QtOvNrK2iv3OQi8/m3kuQL+sUHHUkaLvcYpxF9Rixoaf3xggBKXg/v
	s0rVGUUF70d4qMxQOobHoUqM+GDEJZOlA9+y7GyUmRERku1GanYmd7Bcv1opEouh
	aTzU6dbmDwHn+Wkj1gHqLFQv7GSJH46o+539lqcfvsCi0LfEOp1hP56yCIbp1+4K
	Frc4h9/ppgNDci8IHkkt0rr2XbiQ8V46Vgw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795561446; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Wa57RvAGz95qQiDyAdTS0mYFTzLx0+edmtuQWziQCRqKsGS
	V++dpsSgHGayzHBP6SfXVWaPwPciJEJyaCZPC8/3XKGP5ZVE+JMovSrE9/1OWSYm
	0bB2AeLntJSN6IQSBqrZEkpsDtuPMH3Vtigf6BgUOVxt0BZ2V/nkN74lpC46p04N
	fMXK5wg9ltJW6m4VH1Iup+aLMZITVgdGm97kfx4dwav075iEOvxZ+erctw+8zK3/
	VzU4GOJpURjXkBm5VyVhipx1Jfpe4v0CEVN2iDdwT7KYtU63PA/LNOX5vySpcNE6
	oOpEKmoekXk6+IZwlNKZgMZnMMmDkZFOUGGKhLQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:EDEImPRj88eptQGFevdG098KxME2N/wtQ2W1hisCnpc=:PEYqpFnxFwg6Vbg2ZyEVHUBKlf2gvx6C1yVhGWXnmGk=;
X-ME-Sender: <xms:5hcGa7gFPcrGpqcRlHsffawo9EwXCgAK2TGWK5vZTVDVLmrdDWBAGQ>
    <xme:5hcGa6TDjMP52GYcxUIn4I05hfJ_zsGaj6XW5zk1b-aNFEq-MZPRZDOZjzjQBGiVx
    75a8kITFgStTyjmJI4snSkHfwjzSujY9lXVKCCoSMn5gbIA0Jw2qDA>
X-ME-Received: <xmr:5hcGa9WAKDkpOlYQ8-M6tki0QvhkmKn5zP9nDAPVeFkAN_zKEJYS83ksDlRMAxtZAJUL2PVFkJ7FNgiDQvcX5e-q__VymgoC-yri87w>
X-ME-Proxy-Cause: dmFkZTFw7v/Llc/+xKqkboWMxBOXHrUv1Kt4NK92j/+87Zx+XBsRrs4lW5a6Bp5CNbjxS4
    iugo8avUY0YJaWMUqfQoeXV1jJ1uv+MdB/XdmQvsV5c/YI5QThl897oZITX0SuyDu/k0hc
    Ds7oPrWlbMQKZ7mdEuIn3H3ibuUpiEbizovzoH0KXi9cv50SN50XCWHw5rSEiH2ANLFgxP
    haqTk79JrT8TjN0sAWoMTeFnkaTrMF5tKj87UhosjYMYePQUY2THz2mee1VLBZ3QXe5xj0
    SWY4tv4shasoKxV43vJpipu51iFkp/lWhCaUfY/J8cRBSvYLL0ePS64/P58lfU2CJQiWTJ
    2cnflR6xuH4IPMf1wNKpB83ImtNTQzN2+GgCivQ7QxqEHQ8ho76R+DY+bsy6ydA/dLNwrz
    z8rG63r8qK6IgYYILt+YKTY/ZPFfNrp15sMrAA+UwBQ5tTpJj6B9VRP1fn9biatc2qZL1/
    L+atZ81tmbRiAC5XswXv23ZM9xwHDqXrjAbN4b4GTlp8KyiqrsnygC/lwr92bxh2rdgt3W
    fqtTp7w0nN0hmAR4s4+yfvVN+/3EygC+uBmJK9cRDYcCy/nNG4TGSW5nQ83IQ0zZBS0NjW
    81kg42M6h2/Bm50FPXhOg/7FB0GiRaCg8v31rJy+56ywkPYH+SnfqpSNSwPQ
X-ME-Proxy: <xmx:5hcGa-SmCcM3W5ED9NBvDepmgmazUA1_TpPFoXZJS6vOqQrAst1I1g>
    <xmx:5hcGa3m78ZALVO6HgWl3hVRxF19p1OXrrtCv4ef-SpZnY0mlbSbfYg>
    <xmx:5hcGa07oNPk8zYkG7gGwncGxaKWLzAx1AnXv-qj4SGKSBgrYvV4zuA>
    <xmx:5hcGa9hY_-PJvz_UyxwEjvF7XgjpIoGq52GmkwpDcjgqm3mr_hTkWw>
    <xmx:5hcGa5Tlr0sBTJZ5Paiy04lUZ0l26fT4bTgOhLoSUXSlQA2Hde_hdNbS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 18:04:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
  Patrick Steinhardt <ps@pks.im>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v4 0/5] http: exponential backoff, configurable status
 codes, and post_rpc() retries
In-Reply-To: <pull.2287.v4.git.1795103883.gitgitgadget@gmail.com> (Ravi Mistry
	via GitGitGadget's message of "Thu, 19 Nov 2026 15:57:58 +0000")
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v4.git.1795103883.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 15:04:04 -0800
Message-ID: <xmqqzeuxj0gr.fsf@gitster.g>
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

"Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Commit 640657ffd0 (http: add support for HTTP 429 rate limit retries,
> 2026-03-17) added HTTP 429 retry support using http.maxRetries,
> http.retryAfter, and http.maxRetryTime.
> ...
> This 5-patch series addresses all four gaps:
>
>  * Patch 1/5 fixes the off-by-one retry count bug and extracts Retry-After
>    in finish_active_slot() before Trace2 logging runs.
>  * Patch 2/5 doubles http.retryAfter on each subsequent retry attempt
>    (capped at http.maxRetryTime) when Retry-After is absent.
>  * Patch 3/5 adds http.retryStatusCodes (and GIT_HTTP_RETRY_STATUS_CODES),
>    defaulting to "429", so environments can opt into retrying codes like
>    "429,502,503,504".
>  * Patch 4/5 extracts a shared http_retry_wait() helper and extends retry
>    support in post_rpc() to read-only services ("git-upload-pack" and
>    "git-upload-archive") without retrying "git-receive-pack" (git push),
>    while fixing a missing Content-Encoding: gzip header on retry.
>  * Patch 5/5 changes the default of http.retryAfter from 0 to 10 seconds so
>    Git does not immediately hammer a rate-limiting server when no
>    Retry-After header is provided.
>
> Prior discussions:
>
>  * https://lore.kernel.org/git/20201012184806.166251-3-smcallis@google.com/
>  * https://lore.kernel.org/git/pull.2008.v6.git.1773752435.gitgitgadget@gmail.com/
>
> Changes since v3 (thanks to Patrick Steinhardt for the review):
>
>  * Patches 1/5, 3/5, 4/5: Un-indented shell case arms in
>    t/lib-httpd/http-429.sh to match CodingGuidelines.
>  * Patches 2/5, 4/5: Changed the retry attempt counter from int to size_t.
>  * Patch 3/5: Documented in http.retryStatusCodes that providers are
>    expected to return 429 when rate-limiting or overloaded, and that
>    configuring additional status codes is a temporary workaround while
>    underlying provider or proxy infrastructure is fixed.
>  * Patch 4/5: Restricted retries in post_rpc() to read-only services
>    ("git-upload-pack" and "git-upload-archive") so "git-receive-pack" (git
>    push) is not retried, documented the retried request types in
>    http.maxRetries, and added a test covering push.
>  * Patch 5/5: Inspected the Retry-After header via curl_easy_header() when
>    CURLINFO_RETRY_AFTER <= 0 so an explicit "Retry-After: 0" or past
>    HTTP-date retries immediately instead of falling back to the 10-second
>    default, restored the past HTTP-date test in t5584, and added a test for
>    "Retry-After: 0".

Thanks.  Even though I admit that http transport code is one of the
areas I am less comfortable working with, I tried to see if I can find
anything questionable.  Thanks to your effort with Patrick's previous
reviews, I didn't spot much, which is good ;-)

