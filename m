Received: from olivedrab.birch.relay.mailchannels.net (olivedrab.birch.relay.mailchannels.net [23.83.209.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F711C831A
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735684; cv=pass; b=e6qOZR02bRjC1fUXvLfXfnG6dv55yxMAKMoZj+BvtxokUoc70qaWEOGRNKR22EfXt7O3laPsD0rjcA6kD7eMfi9uF8RROzGuBm8oqiPwjP+C+zqNXcBSN0dypFECfLLcsz58JDiagNESUfdN8yFVAxsqXJQnDIinPHnFAx1hvCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735684; c=relaxed/simple;
	bh=kj+snmwoXM3SHHKkF6djOndXAQDMB56ektn98bp8OcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cniuP76/0qCRDu5Nm/BQS/mu2QJvjKLTUXZ2lGtkSs19nrOc0LnNo2tSWO2hTPsW3rIV11eHkTSTzGJOA8+i4RjPmuNLhI0StFYyM9HIaspAvzTo8Ng9608aKWrNNEUEGmBH25IN6iEF+OGg8qhXuuDE3UNoiFIYP01d/gmyCfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=Gn8fEFad; arc=pass smtp.client-ip=23.83.209.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="Gn8fEFad"
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 078672E1FB9;
	Wed, 24 Sep 2025 17:04:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a288.dreamhost.com (trex-blue-5.trex.outbound.svc.cluster.local [100.108.153.55])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 889152E1C1D;
	Wed, 24 Sep 2025 17:04:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1758733490; a=rsa-sha256;
	cv=none;
	b=xkB6+/cmc8E3fpGUAzp8b0rqhy+X85FEol6PVbfA76ay/b7vIbvYfB4vldjmnMvEnZsAcv
	hRAW39Q4zoGbN/HmkCyEFFUn5To8weHH/37NFA6aL6cz1YR4OlgpZbaeQNu3BB45iqtWMm
	u3CdArQ6gUynigB5u+oX9f1EZrViYjJJRqA8KK1eGv+VzTITJOK6wy7WTpk2vu2BpE/jT1
	qwlWHW470W55a6uFglPjaTgGdzUXKsh25204EZMgY7dR5RrEZYpq4pHuf0J5JOdrCzSYQb
	UIIWSwpgNW3weBfECUueVkGtiWTl/noY2rvUTo8zGr3+RBeUw5Ji5EuR/JbChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1758733490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MBYjA2MDUADGn8oeNyovvSr5XsXWDicmVYGxF6dayro=;
	b=S4Ceyd0/RusfSbq++LjV1djKYbADxct6CqGNsRJbUEZ2/8XcIuj4eVt/MfDkQ5Tf7Igh2q
	JvVtZFnr6lrx4OCjUjOLAgbLNUE/QIMkCIX1cdk4haB8O11f707HjjuZ8okAPv4qa2K02V
	geVZz2gbOO9i+YsmfnCJ1UrFWYl72Jf5ONnExg4cV9YthLJqsLRCAYgLE6kNXjcXILiqIz
	+n7iZlyaxVfV6i4VM37vqRwwFZNQOEleeqxWTwWMhtq2E0R9rGv0jDBJVenSj2Is3Kn/1I
	6qMNBrzFhuq1OdRupWPZbTImUc57uA+lfMrdXoZNwy+3f2ltzoZ4S865o+pzgg==
ARC-Authentication-Results: i=1;
	rspamd-7d8f59cbdb-zp5zh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Keen-Average: 684b37ba2adcc085_1758733490390_2207903884
X-MC-Loop-Signature: 1758733490390:1454128159
X-MC-Ingress-Time: 1758733490390
Received: from pdx1-sub0-mail-a288.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.153.55 (trex/7.1.3);
	Wed, 24 Sep 2025 17:04:50 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a288.dreamhost.com (Postfix) with ESMTPSA id 4cX39p6h4lzB5;
	Wed, 24 Sep 2025 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1758733487;
	bh=MBYjA2MDUADGn8oeNyovvSr5XsXWDicmVYGxF6dayro=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=Gn8fEFadjnoZb7ko2aAxW6BzTc6fQLz/vyPLH5GaHHI/BcBdQmswge24gxEsf7Ojg
	 wKoPeCJVhGeH8mEZlp9DpTRaLP7geBJB3E5Pb9RG0u1zhYFJLkMMZUvKqiCIeRLsT0
	 P7rF0SsrbVehyGYQ5iIizVEqJGgdba+e7Oka4/A5Nv9T9eVJquA7TpMavm5owUdogo
	 xpjIzrQ3980Vquhz6+kmbI4yZB4G/Trlpdo0Kt8ksf/KYfp4J8ZJLExKOvcZ7CqUze
	 hO3UnXi0xCeWynfpeC6fNVa8zAjItpXcTemHMEVix0x3KhZ8Tn0ymIjfRlGq8timgq
	 P61rPagTSR/AA==
Date: Wed, 24 Sep 2025 12:04:44 -0500
From: Nico Williams <nico@cryptonector.com>
To: =?utf-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?= <velocifyer@velocifyer.com>
Cc: git@vger.kernel.org
Subject: Re: 0-Based indexes for git log
Message-ID: <aNQkrF1k4ZCj4h9Q@ubby>
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
 <aNQRoMgSRVvNtStG@ubby>
 <75860b99-b7b5-4398-b32f-47a4873508aa@velocifyer.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75860b99-b7b5-4398-b32f-47a4873508aa@velocifyer.com>

On Wed, Sep 24, 2025 at 01:01:30PM -0400, 𝕍𝕖𝕝𝕠𝕔𝕚𝕗𝕪𝕖𝕣 wrote:
> > Day of month numbers are 1-based.
> 
> I consider day of month to use a 0-based index

The rest of the world does not.  You want to be able to interoperate
with the rest of the world.  So day of month numbers are 1-based.  I
also wish everything were 0-based, but it's not.  That's just life.
