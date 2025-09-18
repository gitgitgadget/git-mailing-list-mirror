Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4039243946
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184584; cv=pass; b=V/I5+9fmdSFUONcRNqbwxMRw1Bqw7le2EfeCin1v4eNzbrAPNYeg7bssHLX+GxfR8zRtrPmOHBbkTwjz0XZTAxF/RT9FrYQ9O/1yIPHXkw5u/cle4UyFH3/LalomJ5YJrCQ3IkmTxV8EsQzMoo88jSouEuIiI1fk1bN3tF0awZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184584; c=relaxed/simple;
	bh=GDFPSgLrclqYsTpgmrv7YE0n1bplbBQerY5f60T3OXc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=E3/Fr/417foK79LoqQvropdwv+LD3hhIC1ifJEbACklmG0oGDKt+CxQ+ePo1zrEcbTYTXbdeKNrFJaXxRqhrqg1Y9Qrq8y1QDEtRV18BrgplBSa1pKHoR25Kh3Kpjn+Z/aHUBz8WmaX687KN1v6nC0GZH5B/Nphu6KfCdvluuM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=l/LvbsZT; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="l/LvbsZT"
ARC-Seal: i=1; a=rsa-sha256; t=1758184572; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D2qonu58GeCxvxuQSoHcIwxg1M/61ntgFWWe2tiis9P3OOCAh1Aty1Fwzhbt6gqsFdMz/gTEidyunf/qhiD4mJNokLOykHKTw68IF+1yO55BtkxA0F/fIwCuRYNUaOtjBJJ8pPDm+ooTodobeu/Qa57qEXIIJnuucQzAXSbHf8M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758184572; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IcAGUyxY9L9D7Xx5BwjLAeYUyrQIlI+fgEziH5eA6dE=; 
	b=eRfvfakNe723ifsVFTLzJqrmDbJ0CaDPRnmDuEfkTh5xzhx3Z+jYkHfsDxoN2vC6xuCkHKMryZRwCKFnO3sbUhNPuAW8TqPZ0SzTVgFWrpBUCP7AEckkbmwbwFaZ84/k9eCWaooWT8v8C+LMiQfvWcXDIdw9X9u71EmOY0Hl99E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758184572;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IcAGUyxY9L9D7Xx5BwjLAeYUyrQIlI+fgEziH5eA6dE=;
	b=l/LvbsZTUZOifoPH9QU4/auo9oRt9XHqpdJVOC9uYvdz2T9fiZRyUyqu59iGY3GQ
	w9nGr7K6TagloISfOjbFGQGIFHTbWrGkP/4iJFOk33QqdbB6WBOXbKKQMIlqfs8PTt7
	BRNRr6m+XxjRYqMonrnv7B7K2Lx1OxY9tekqU+7s=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 175818457002865.47840102961004; Thu, 18 Sep 2025 01:36:10 -0700 (PDT)
Date: Thu, 18 Sep 2025 16:36:10 +0800
From: Li Chen <me@linux.beauty>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "phillipwood" <phillip.wood@dunelm.org.uk>, "git" <git@vger.kernel.org>
Message-ID: <1995bf77c93.3eeb42b4972717.3783775021840050008@linux.beauty>
In-Reply-To: <xmqqiki7qasu.fsf@gitster.g>
References: <20250803150059.402017-1-me@linux.beauty>
	<20250803150059.402017-3-me@linux.beauty>
	<e911d897-8664-40a7-b7a9-8eb9f71a8735@gmail.com>
	<499da566-66a8-4c38-a2b3-13c06092568f@gmail.com>
	<198826665b6.317113211709957.1514728503207030488@linux.beauty> <xmqqiki7qasu.fsf@gitster.g>
Subject: Re: [PATCH v3 2/2] rebase: support --trailer
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

Hi Junio,

I apologize for the delayed response.

 ---- On Fri, 29 Aug 2025 07:35:45 +0800  Junio C Hamano <gitster@pobox.com> wrote --- 
 > Li Chen <me@linux.beauty> writes:
 > 
 > > Hi Phillip, 
 > >
 > > Thanks for your thorough review; I will address them in the next version.
 > 
 > As I do not want to keep an inactive topic in 'seen' for more than a
 > month, I was doing my usual "sweep" of the topics, and found this
 > exchange.  
 > 
 > Is this still being worked on?  No rush, but just checking to see
 > what the status is.
 > 
 > Since the summer is a slow season, I do not mind keeping the topic
 > for a few more weeks in 'seen', but I can simply discard the one I
 > have, and requeue a new version in 'seen' when it materializes.

Yes, it's still in progress, though I've had limited time recently. I aim to finish the next
version before October 8th, taking advantage of the 7-day Chinese National Day holiday
to work on it.

Regards,
Li
