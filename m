Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F16F23CB
	for <git@vger.kernel.org>; Wed, 28 May 2025 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438325; cv=none; b=ZomPF26dNsEafdhZ6YphaeUaRXVs31u8sbNEZSEhWwKCwbHc/yBl75difw5ysYLYN3Z/w1bODjq823AhwFlRS0/AsWjqkvv4NwfRN5wN8ydfkuOPSjil8IwvegW1Cp2EsnYXrUQQBdFY2owEeTNENLiPYcwyJHWvIwIuL5oCLK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438325; c=relaxed/simple;
	bh=UKTDQ6JcqvE26bDMv+3ZpmLzkwXH6+B1fhAz4O3GyKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ibgDFx+hUjsvMNqyAbxrEpucteGjA4xEoQGy+hzpX6p9Bg4Y8q7JgXAeygGL0W74U0aIeSp9efBfqRchIk3+uRFuOku18vKfxddzqCTmSOj8SlXarKfH5ElsRUvdUPAZC7IFcENhjT1vvUED1U3InFUQb9k9s/K99zB1V5rY81w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=hCKrHKay; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="hCKrHKay"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1748438318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2f+5+5SpJD2247tt8W1rqh2uDhxFCpFSqb5kTMDSQo=;
	b=hCKrHKayBskHfq7WUe/gGXYDNT6kVeG2hgOE2JVjX7jzbhw5yYV6bMgOpgVdT1AaugswLy
	bYvQfCID4W2O929eOob/XIR0qtGegvbLUrR3+RKyiSacI0KU36zwtkROragH9Dahc5onXO
	jAaxlPVEMhs+V5T8CgHPdm5lH43Wa/Y=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, Junio C Hamano
 <gitster@pobox.com>
Subject: Re: [PATCH v3 02/17] object-store: rename `object_directory` to
 `odb_alternate`
In-Reply-To: <euflgbipchqi7jvmz4yzwzx6ao5guen6xmupkdaubjbc5ksgkp@aheynye35bby>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
 <20250514-pks-object-store-wo-the-repository-v3-2-47df1d4ead22@pks.im>
 <tjsbotrnrffykmi3letktpb3bly4nqw4wxzyrszgbln7pznem4@3kwiq4zvaebw>
 <aDP_-VX_Rz-MqiAS@pks.im>
 <euflgbipchqi7jvmz4yzwzx6ao5guen6xmupkdaubjbc5ksgkp@aheynye35bby>
Date: Wed, 28 May 2025 15:18:22 +0200
Message-ID: <87cybs3mch.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> That's fair. Between `odb_backend` and `odb_alternate`, I would probably
> still prefer the former, but ultimately I'll acclimate to whatever is
> choosen. :)
>
> -Justin

I feel you. But speaking as a non-native English-speaking person, I can
settle for "alternate" because I can still wire my brain to give it the
meaning we're using here.

But if you like another name, I want to steer away from "backend" as
well. As mentioned elsewhere, a "backend" sounds like an implementation
of an object database, not the instance of an odb. But I'm open to other
suggestions. I've been browsing thesaurus for a bit, unfortunately I
didn't find anything better.


-- 
Cheers,
Toon
