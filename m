Received: from grace.univie.ac.at (grace.univie.ac.at [131.130.3.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3A2F549F
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.130.3.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291107; cv=none; b=KlDb1XdFvDEVYVJYwZ+pUFiJ1uvbr6xS1KBzTuKXQNCd+3mprjszGAOAAiP/2z5A3DnDJaOCWoX4u5ZvqMjNAHsWrQKb5T1IC6MUKVzm3qVac1scLqXORlaRRNZjhasEVekB26GaEWY/YneIpStQpoTJ1VFJ+80OJiZZ8QBzVUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291107; c=relaxed/simple;
	bh=HN3wTTPX8tFuJ1nayfuMGdEbKhs2Ie/3GWLYGyNb0PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYcRVAX3+jMuhFDD0gzn1ztfl0LSy1D/8n4sTLw4lt+RBbFHLWesKizgcuOYRN50wKruKwTtTavJYdt+yjET/6J7hvpxrMcF3qqcbgjP8Q4wCi9wDvGXr5Nglg6yh7JSjZucw+g+W0HI07/BGOvURbebehvNgXZBPdOredsoaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at; spf=pass smtp.mailfrom=univie.ac.at; dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b=C7DTX24M; arc=none smtp.client-ip=131.130.3.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b="C7DTX24M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=univie.ac.at; s=rev4; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=HN3wTTPX8tFuJ1nayfuMGdEbKhs2Ie/3GWLYGyNb0PA=; b=C7DTX24MMnlfTU/Kl/ITZDwZla
	PO9/ZH5qqzli/IEWO/VfICTAVUjg2LHqci4rCXxZuaU1ngwv1WJ+1l9AFafi55LevRgFvrUFWs8yX
	4A4ra9Mnh9lhHpAFwmsh4EE+UF5S3gHLs6Pbk26wqSMlvfMNu9XNQfzs47F65lc4p0MDkiKT7/0od
	5S6cs7rAPV/e5fAzuyM9f15YMFbZVcq1Jhd0y/XvkHOJCrAWB5USpGLrRbpOl5tUjKlZTYNp7ktW3
	uy891Et4U0ewn14uItG1r106N5Y6S04e9xu8kxL54+K0SxewHZx+pE+5UDozWSBrA7eJ/4KGiJncx
	W8NkUEMw==;
Received: from jarvis.univie.ac.at ([131.130.3.112] helo=jarvis.univie.ac.at)
	by grace.univie.ac.at with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wY7BX-00000005Hq9-21FM;
	Fri, 12 Jun 2026 21:04:55 +0200
Received: from 84-115-215-81.cable.dynamic.surfer.at ([84.115.215.81] helo=eduroam-077-080-003-247.wlan.univie.ac.at)
	by jarvis.univie.ac.at with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wY7BX-00000003ngB-1QbI;
	Fri, 12 Jun 2026 21:04:55 +0200
Date: Fri, 12 Jun 2026 21:04:31 +0200
From: Dominik Loidolt <dominik.loidolt@univie.ac.at>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, asedeno@mit.edu,
	asedeno@google.com, avarab@gmail.com
Subject: Re: [PATCH v3 2/2] compat/posix.h: simplify GIT_GNUC_PREREQ()
 comparison
Message-ID: <aixYPxWiWO9iryKl@eduroam-077-080-003-247.wlan.univie.ac.at>
References: <20260605094647.94805-1-dominik.loidolt@univie.ac.at>
 <20260608124419.38905-1-dominik.loidolt@univie.ac.at>
 <20260608124419.38905-2-dominik.loidolt@univie.ac.at>
 <aiwJSBfRbUFZ70gP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiwJSBfRbUFZ70gP@pks.im>
X-Univie-Virus-Scan: scanned by ClamAV on jarvis.univie.ac.at

Thanks again for taking the time to review my contribution.

On Fri, Jun 12, 2026 at 03:27:36PM +0200, Patrick Steinhardt wrote:
> > It is also more future-proof, as it no longer assumes that GCC version
> > components stay below 65536.
>
> I feel like all the message needs to say is "let's do it for
> consistency, and it's easier to read". That would've been sufficient,
> whereas this argument here feels a bit thin.

Agreed. I'll simplify the commit message. The "future-proof" bit was a joke I
just couldn't resist, but it may cause more confusion than it is worth.
I'll drop it.

> It would've been nice to either move these changes into a preparatory
> commit or at least mention them

Agreed. I'll split the cleanup into a separate commit.

> I'm not sure myself whether this could use another reroll. It's all just
> nits, and the intent is clear enough.

I think it's worth rerolling.

Thanks,
 Dominik
