Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C11798F
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749706820; cv=pass; b=V6L5oz9VAyaKhYIwUdKUmD5FtH5zb/iJc+x8lSvq9IFACLMsQBLiYdDOhMT2q+GBC5pOJuSk+zdC/9+ZtBAkq/8T/gAHcd+msWe/RuXXJxgp/Kf3GLyNlKXpkehUPuG1ac9K7zIDuNupvObzGhJ/0YoYqaMnGxxWMipeaa41JZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749706820; c=relaxed/simple;
	bh=ALNfS0Au5HS2f7k+JBSNo6WcBvlYvSJm68xA0tE9OU4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=I9VA+lFAZz2PcBy/O+1xaRA3W92jHefOU3QoH+Ksd9flpv0kg+k6r81W9iG5FXXUlKjA3lq9cHtl7prO8zZenBwTzsLXCMas4oKQn4R/ugiqQvRNu01DN4uwYXPyiYrlOg9ZPlRSt9xGa+iWg6YsdIH/QKTaD6bmm7Vjld82Olg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=srLb2CO+; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="srLb2CO+"
ARC-Seal: i=1; a=rsa-sha256; t=1749706809; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j7UmRMAKgDBRnP/kJd7eAExMJXY87QDbLtuvkPAWDZUHXsPxJgl/XUANTBjkNav3vOT5CJa1MSBu44BYQjR0vSzj/hFGtJ3FphkZ1tHaETN/oVsKyJ49+GKHvExqob3oTE/7DkRjIlrZu7z2FJvttsmxUr45N51P0frbwU5fJvo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749706809; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NQvVUCtqMPLEe87dL4grWxoI8V0fQzdaXVjMETkJNIE=; 
	b=AHg8wSMd7mOYGgDKx5nkRL8UkGrfIETPXIMGMEqhJYf0ax9dFZVwtX45FmbmG1FOXenKEfrksaQ4VawGiVoDyjWhRFpxvM/VBhzMtFO6qqhlXiQ5P3a4o58o/BwiMDyr/bNXFAe65dwPWqaarNdkisPVR4hQSvsvC83eUMqpNHM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749706809;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NQvVUCtqMPLEe87dL4grWxoI8V0fQzdaXVjMETkJNIE=;
	b=srLb2CO+XaNAuWPQWAXH0Jeogle1uAr8f31qb55HJXgpf1TgDAMAA/oXs7ZfT13Q
	ljNamrB9YfeAtTsvxJfRBuB8QB663/8EuUPcWdh59UPsb7iSFBerUXtUDkHHql/wGa9
	sqz4ICrXKGPg8JVbLDa+UlQIv7SJxr22aYsinV0E=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1749706808013465.52131788262375; Wed, 11 Jun 2025 22:40:08 -0700 (PDT)
Date: Thu, 12 Jun 2025 13:40:07 +0800
From: Li Chen <me@linux.beauty>
To: "Junio C Hamano" <gitster@pobox.com>,
	"phillip.wood" <phillip.wood@dunelm.org.uk>
Cc: "git" <git@vger.kernel.org>
Message-ID: <19762a71ab1.d16b43db461922.5615394257517989238@linux.beauty>
In-Reply-To: <xmqqa56ejnrk.fsf@gitster.g>
References: <20250610123459.278582-1-me@linux.beauty>
	<20250610123459.278582-2-me@linux.beauty> <xmqq8qlzkukw.fsf@gitster.g>
	<407631ab-1184-41b1-8043-fd91d860e845@gmail.com> <xmqqa56ejnrk.fsf@gitster.g>
Subject: Re: [PATCH v2 1/2] trailer: append trailers in-process and drop the
 fork to `interpret-trailers`
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

Hi Junio & Phillip,


 ---- On Wed, 11 Jun 2025 23:34:07 +0800  Junio C Hamano <gitster@pobox.com> wrote --- 
 > phillip.wood123@gmail.com writes:
 > 
 > > Exactly - I was expecting to see a refactoring of interpret_trailers()
 > > in builtin/interpret-trailers.c that moved most of the function body
 > > into a new function in trailer.c that added the trailers to an
 > > strbuf. This seems to be a parallel implementation which doesn't sound
 > > like the best plan.
 > >
 > > I'm going to be off the list for a couple of weeks, I'll take a more
 > > detailed look at this series when I'm back

Thanks for your suggestion; I will refactor it in the next version.

Regards,
Li
