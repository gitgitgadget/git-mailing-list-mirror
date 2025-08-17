Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7612746C
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755435688; cv=pass; b=U4okHzm5dDbdyjlXUYdY0UZGRx/EZSbT1a/gfLvv6GR1ue8sRuE0l/io53MJntGbH7SZWNcYjg5xrLWahpOjpkrLE//jC+flTDXiBm9ZyeeGiq8aVteMB+mmOq8uw/6edl2rztJDsSEk07dF+17o5D108wRLr66grDknQJdYer4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755435688; c=relaxed/simple;
	bh=NxhJNisMCLBqKvcGj9kdJWUPnpE4aGHpD+YOWHD+eM0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AGCNwADJN5xOkZ+A+GJ+Nry7QqwTr1xdeMZATztRFb3udG7ZGBdc3SMJp67W48ZlvFH5wY4jGpccLM/m9Z1XN30GPe8WLbPuje6m4IqPsByA0Dkr+olzvZSSGNfm6JqEiYdfG4jtfkaI47KjEPuVvcuSirB0qfTckdKGCspFdFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=LCevyPHw; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="LCevyPHw"
ARC-Seal: i=1; a=rsa-sha256; t=1755435667; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EwMCMgfGMSO/6fj6ALZ+x1ZaFnBrjJ+rLCdW745YsrIN42kDTaE4w9zNhhg1rMynRTSNTTNoQ0JScdIszUOPZ1zwdUJnjPgvjaeFUjXOtSecc7AxyPgH1cmEWZoXzlIE17DCR2H7ODYULFk7fA9Wnopv0j1B3zkJkVNQhLB2Ubw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755435667; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hp5rtW0kIc8dJNM04bED6LSZ0DQzw+VxmaS39VirW+Q=; 
	b=jBdPqpKsW4w9Ha8CYlJRK3qqY3rCtwKsL+/uZKKk5wgHV85eH1xMRjsOZ/ef4bWG8qBtMdc2xZZRGce7/a5zYjZCy9y6/7V2VBQxubBprp+EVA9wtLz+fJvG+NSeCO0+uF8ygsDSzMkhpePTa34NaEj8xZM6U5G3raydg8/unoI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755435667;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hp5rtW0kIc8dJNM04bED6LSZ0DQzw+VxmaS39VirW+Q=;
	b=LCevyPHwNqh8p8MPSLHCFbnNbi4jddH9Pe9GqLMIJrYn54sz2rLGgZJ9wzA3xgyp
	8BtTuuWu8wW3hDFLOkcb9CYnVG4qPPmtKoMFPPHcct/BWHlchSMvCVBceDrcpLNO7Gz
	wElYdh23uD8VGM4LtaFEzdqdyJskfmfnC8Y4HWxs=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755435664500376.2084194044497; Sun, 17 Aug 2025 06:01:04 -0700 (PDT)
Date: Sun, 17 Aug 2025 16:01:04 +0300
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: "git" <git@vger.kernel.org>
Cc: "Emily Shaffer" <emilyshaffer@google.com>,
	"Rodrigo Damazio Bovendorp" <rdamazio@google.com>,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	"Aaron Schrab" <aaron@schrab.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Stefan Beller" <sbeller@google.com>,
	"Patrick Steinhardt" <ps@pks.im>
Message-ID: <198b81e845f.3d0b85c81892243.3876804306135930880@collabora.com>
In-Reply-To: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
Subject: Re: [PATCH 0/9] Encode submodule gitdir names to avoid conflicts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

 ---- On Sun, 17 Aug 2025 00:36:33 +0300  Adrian Ratiu <adrian.ratiu@collabora.com> wrote --- 
 > Hello,
 > 
 > This is a continuation of work done back in 2018 [1], so a big thank you to
 > everyone who participated in the initial thread, especially Brandon on whose
 > code this is partially based upon. Hope you are still around and doing well. :)
 > 
 > It's mostly a rewrite from scratch addressig open feedback. I decided to
 > iterate upen Brandon's url-encoding design instead of pursuing alternatives
 > like a custom encoding, name hashing or round-trip encoding/decoding using
 > an in-memory git mapping (we'd still have to encode/hash the paths to avoid
 > colflicts so IIUC this last one is more complicated for little gain).
 > 
 > I tried to organize and explain the commits in a logical way which is also
 > easy to review, keeping the encoding parts, new tests, code moving around
 > and path update churn as clearly separated as possible.
 > 
 > This is based on master and I've merged and succesfully run all tests in
 > both the next and seen branches.

I also ran the GitHub CI pipeline and noticed there are failures on Win + Mac.

I will address those in v2.

In the meantime I'll leave v1 for a while on the ML to gather more feedback.
