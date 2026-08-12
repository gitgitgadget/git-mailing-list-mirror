Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8583FFFA7
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570448; cv=none; b=fXMSkTYwnlb5GUrc/a/jW4BX0wLdTkUXzp/L5BLPTardXU96wdA9fAnlWe5b5CtIgIdaawOTQ5UuK3Y2Jpd3de2HrKVrA6LVymrOK09Mrk6BH64eWuU+QtEFIauYP3xdOovmRfiDB3WhOwt1hWWsCggpZTf3+IliMe/B0nnkXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570448; c=relaxed/simple;
	bh=lmYsjxHKGQCoGjS3GT4u7WHXdDbXVa7qWhTQEAmGLD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cVKAq3GLd/UZncWqOA7JeRtBoFm/SnAB17f9dbvzz1nxVXdPKS+w8Ti/CHDvHsUmo+UTBDeUuX1JvgMU+GFt5n5av8Zcybuvh8SL6Pqf1YqOBTtUmRKB6hlLYKSn7RcurMTn+ttrD5lDWkgI+pia6Nw0vvbT/l99v99JPidnXf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fefEBafa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JNnRNj1C; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fefEBafa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JNnRNj1C"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C9F27A010E;
	Wed, 12 Aug 2026 17:34:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 17:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786570444; x=1786656844; bh=S9Emw++MQf
	+pJC9ovtSwA16Opuc9dcbGSiZGTLGFfL4=; b=fefEBafadlfLyiBJqdMNK9KWJN
	zTGzDAdQ5ucSX/od2JhsRi5ypqtT1Q4UBi1EtIU9e3MAsyKi9aEtmvWFCLMDz1zR
	EyAOIb94+N67gTGqsUPNqkrDqTT0AArF4MNwxQicM9jzdXgTrUSyrOSf+xF6qgdO
	AHr04rOvdGjMqK8AiTOZYWVBW7yPKoAcI9VvJttm7Cho1uRrtYyHW94MW8UMqV5N
	AoErrwVbFum68OzpXaLms0rIbrGmHAhyu1+u56VzQO4vtKWtyWoy4p+5OipWSU7v
	rAVMbIUxRiXAJ4H8MgHar9lYI+/9JhIAT3N1chhlqWY9iEuk0ixwtRj6V3FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786570444; x=1786656844; bh=S9Emw++MQf+pJC9ovtSwA16Opuc9dcbGSiZ
	GTLGFfL4=; b=JNnRNj1C39UxFzy6WMd9N4/Dhf7io3uCCNCgGer1y+o6MVPdUbC
	+Pk8APSh+d5/obiqMx8afxP4FGyuBhQZHWQoUyL/Tx7nPIJxSKF5FFhGqxC7Qbsg
	gbjsQ4xMda1g9K4GogzJUcvgi8qU8dVoIpNqywahGRqNwjHaRXLYHVXszkOoI6aY
	bIgaYu3hX9vnrpDWK3/OhUJrTMVAmtueTSeRP6Uuu2m8Mj7ZbWij8+Tu5aYkZIo5
	RqsTPeovUhQmQBCHPeKQ9TlqLoEkMQjOh5rxpmYgMZ1zyPP/WfTHJmsGs6kUjRLo
	KdJeW5s+z6VPEvzTpwy6MEC3cvmtL4leOuw==
X-ME-Sender: <xms:zOZ8auzbcwv5Cfngm50tCs4xV1VtsMXbYCYXph-LFIdJdc7HXJntBw>
    <xme:zOZ8at_s61T1leH-2ae_g8D9tsFdt_TVTceLdV1sZJz8l4RHCVHWQ0jAqM3fDI0A-
    Sc_BTb_9kCGKf8foIwB3spQL_SjNKZ13adPTlrS1Cvbx7McqD3KrWA>
X-ME-Received: <xmr:zOZ8aqKPmyd64l_9MA8m0xp_MdGN0TXd8VpS8X7W1e2nEO5YrrIJR-24JGfCB_GvM-J_D-hNADpH1AprWmF2zcvQ0cdHHFtrwg>
X-ME-Proxy-Cause: dmFkZTEeBFSpHWFjP4Ws5r4u403ARwNpTsVyQNLud1ksmzGrdGhbtmWxd2uRpvfd3ohrTm
    Gwyydn2SIqhAHGLVr0SGS23fbww/W4OBgV8LIXcAhwMGj/FlKv0iR4z68dqG+caCvCKM2c
    OVeEV/yRiVMhkMQtcksc6TjzK3n8OzZvQ+CJuiHOQrZnfJmaw32E3qgeW1w6gJlR5HLa4u
    I/pwPFP88LIiMq8++SSAFPSYT5iuEj6T4QEZsYDTcuNdyPQG7q+Xt/l2qNF8z6gk+RUtPm
    5BuLfDwPC2xmml1WAXfDwYnT63L/pUuO+Etitpyl8Q9Ex+TqmKlvdohhKGBzkOp0l/FdGQ
    Rqbct+GcCoOgviugC4gwhcj2DRRU/LyupzWH5O7UX8GCwfNA9trC/PI7D9e9uLsptQVa2i
    o3TrRvZ0XNv6OqmRcz1VlLVQ75qz0cbjVVD6evBv4N/uobHoSJiRFy2oXaI8MHbs2jEosO
    FDwhho6Tajm48f1VuOtJTpZ2IJWE/UNZrr9vxYS6+Yq6lAmFqDEwdg7vdud9nFQX40T3oI
    7v3aqnxQpd1wEbSBdnL22DUR3I8CgAmiJK42nEl/3VhOCud+ULcR7pYxsEE9XsM62+pNM2
    vBXpVhqCNcq6k3363FinaXy6bFzfgPY5tPvMR1tHbyJHcbq3WSQWy7h53ysg
X-ME-Proxy: <xmx:zOZ8arcjjWk3xTDWa07tGlzB5TCdyA3kDF3m0Lp8Qd8IvtzSxU7Ftw>
    <xmx:zOZ8ah9uWMTpKyA4FT1hZE2MuXYCqqkm1AxtetZREkdCQ8CS3de6OA>
    <xmx:zOZ8agrcWgK9pUnxdY4_p9rk2IlftCHDy4aWmvJwKu5yTkLTjEgakQ>
    <xmx:zOZ8auAioTVtDuTX9Sv3S_jwAfSgXMNLMF_9l_IQWTCHhxCbvQjmxg>
    <xmx:zOZ8aiicvHOObUd9Xf7lgFn68OmrVxlLjeIue-U1QjydglWf2qRrDMLf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 17:34:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: graysongordon-gl <graysongordon1@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  avarab@gmail.com,  ps@pks.im
Subject: Re: [PATCH v3] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <20260812182509.67358-1-ggordon@gitlab.com> (graysongordon-gl's
	message of "Wed, 12 Aug 2026 14:25:09 -0400")
References: <20260811170200.43097-1-ggordon@gitlab.com>
	<20260811204407.52471-1-ggordon@gitlab.com>
	<xmqqldabzamj.fsf@gitster.g>
	<20260812182509.67358-1-ggordon@gitlab.com>
Date: Wed, 12 Aug 2026 14:34:03 -0700
Message-ID: <xmqq1pc3vx9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

graysongordon-gl <graysongordon1@gmail.com> writes:

> v3: rename the test from t5567 to t5568. t5567 is taken on 'seen' by
>     mm/lib-httpd-cgi-safe. t5568 is free on master, next, seen, jch and
>     maint as of b9720e4723, and sits next to the other http tests. No
>     other change.

I thought I first asked whether we need a new script before
suggesting moving it out of the way because 't5567' was already
taken.  It is much better not to waste a scarce, shared resource
such as a test number, and doing so avoids breaking the build if we
are not careful.

If we really need to add a new script, you would need to squash in
at least a patch like this to avoid breaking Meson-based builds.


 t/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git i/t/meson.build w/t/meson.build
index 3219264fe7..3d68f67680 100644
--- i/t/meson.build
+++ w/t/meson.build
@@ -707,6 +707,7 @@ integration_tests = [
   't5564-http-proxy.sh',
   't5565-push-multiple.sh',
   't5566-push-group.sh',
+  't5568-http-verify-status.sh',
   't5570-git-daemon.sh',
   't5571-pre-push-hook.sh',
   't5572-pull-submodule.sh',
