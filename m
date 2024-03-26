Received: from ra.horus-it.com (ra.horus-it.com [65.108.3.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724D1F61C
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.3.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493755; cv=none; b=SHvRN99x3sOSdsmB06z0aMYSZwvQiwvWCFri/C/F6I0ALolAKlWOEZ9myVFbtMhFnAkEByPIgiJJN3wOltxobgNhDrpYK0CTzD9In7T7kv95eixOjL1YwpccHd2Z2FRjGDHSpMmWURSHZrKsa8qvalZQ/nZqm3gSdE51xmtdvh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493755; c=relaxed/simple;
	bh=RhoiOucwz+J5fRE+cMdYj+KxfhMKu/XWbM78Mvx4B8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H+spZwAOoPEBcxfrylYdDVX1z4KZsuXGSi+3+8dU24xu0JSwZ+b6DvLiT/UBHcUH9riSn0Q8EZUzy/aPntYB8d9W9hubDOrxi4V2JtPv9Tb/fFahz4S6nWDETQlvDQGPVlAY4M2xFeb8sckK6FSt1BIdljz0+qNkb6lI7vDzmiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de; spf=pass smtp.mailfrom=seichter.de; dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b=Eiklk0Kn; arc=none smtp.client-ip=65.108.3.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seichter.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b="Eiklk0Kn"
Received: from localhost (localhost [127.0.0.1])
	by ra.horus-it.com (Postfix) with ESMTP id 586A3BE006E;
	Tue, 26 Mar 2024 23:48:21 +0100 (CET)
X-Virus-Scanned: at horus-it.com
Received: from ra (ra.horus-it.com [IPv6:2a01:4f9:6a:528d::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	by ra.horus-it.com (Postfix) with ESMTPS id 3384DBE002A;
	Tue, 26 Mar 2024 23:48:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seichter.de; s=k23;
	t=1711493301; bh=RhoiOucwz+J5fRE+cMdYj+KxfhMKu/XWbM78Mvx4B8U=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type;
	b=Eiklk0KnFxm/z4wbYA/fmUp94CP2HiJXVWsy8OdkeRs/H7fSGsc3VBa8ZCvPRWSRX
	 6rm0IPDIr+0RIxcgFVKouuiqtAhC4JVNP/6kr/pDeS3oKbenkIUEXQAAXsD0whpp8H
	 GB2sAmZ6hMSwK1/EbpTVrPLSlA2kwPIOJh5JI6zJiXJzVZl5GKkwvIsXJARpcwNOGt
	 J/Yql5ugCn1sOUHaBpQ4xdMRQHoT3jewau1hmOmaE0WiDwbDidqeykaz7KewVaLkri
	 TZeGP75z3LR7+igGrmmdWF2z6VWyY/i6flaMC/hwOIVj9TpRd6GELATYFjCfo294CI
	 n5C41NqpvD99A==
From: Ralph Seichter <github@seichter.de>
To: Junio C Hamano <gitster@pobox.com>, Ralph Seichter <github@seichter.de>
Cc: rsbecker@nexbridge.com, Dragan Simic <dsimic@manjaro.org>, Chris Torek
 <chris.torek@gmail.com>, git@vger.kernel.org, Ralph Seichter via
 GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 3/1] config: allow tweaking whitespace between value and
 comment
In-Reply-To: <xmqqcyrg7imy.fsf@gitster.g>
References: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <pull.1681.v3.git.1710280020508.gitgitgadget@gmail.com>
 <xmqq8r2jp2eq.fsf@gitster.g> <xmqq4jd7p1wf.fsf_-_@gitster.g>
 <xmqqcyrg7imy.fsf@gitster.g>
Date: Tue, 26 Mar 2024 23:48:21 +0100
Message-ID: <874jcsvccq.fsf@ra.horus-it.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

* Junio C. Hamano:

> Can you unblock [this topic] to let us move forward?

I don't see any obvious way to alter the pull request's state, or where
a response of mine might be inserted to move things along. I also have
not found anything related in the GitGitGadget docs. Thus, I'll try to
issue another /submit command in the hope that this might affect the
process.

-Ralph
