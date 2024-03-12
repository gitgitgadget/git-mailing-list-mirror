Received: from ra.horus-it.com (ra.horus-it.com [65.108.3.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23369944
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.3.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710228518; cv=none; b=hjWYg+GGyxESWvc4zfTpXl/3ZG3DEe2Z7uzJEc/eN9Vat9ftxrcS5hv765suGnu/lIdsmbokaYuK4iS5DG9HM+qcSmkxa/04FmE0vJDGJbDptXaTvQumpj3iQECYhuBEGzJZJWmofbYS2tDzXT+YZWdtNXI/4iEQqIuNmuEWA84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710228518; c=relaxed/simple;
	bh=YpAYGN8k4B71hWAN3jOUij0lGcnovMvCTezgtpy6GSw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S+61QJRdimxkgZ57R69AF/QZpCDkX9PP/P1hvutMrIql5NjBkfN3Mck9G5C3OltiK+uVAZnAL5E/bQgZrkoMvH8g+/jNzhIhTA4sKVkmRERA/apY1W82g/Qaxwp9hUnk4EF1BzuzVN9GxMB6az+kh/i++Lfl+CDOlASx6EUlVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de; spf=pass smtp.mailfrom=seichter.de; dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b=gXjoK96j; arc=none smtp.client-ip=65.108.3.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seichter.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b="gXjoK96j"
Received: from localhost (localhost [127.0.0.1])
	by ra.horus-it.com (Postfix) with ESMTP id 393F2BE0036;
	Tue, 12 Mar 2024 08:28:27 +0100 (CET)
X-Virus-Scanned: at horus-it.com
Received: from ra (ra.horus-it.com [IPv6:2a01:4f9:6a:528d::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	by ra.horus-it.com (Postfix) with ESMTPS id 124D7BE002A;
	Tue, 12 Mar 2024 08:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seichter.de; s=k23;
	t=1710228507; bh=YpAYGN8k4B71hWAN3jOUij0lGcnovMvCTezgtpy6GSw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type;
	b=gXjoK96jOfr5nM/yK078Un+d/oKQQXgvoC22PpMJ9VF6XFicUTtj4f5G/nxPAaOnn
	 tvH+a2IQ2ubjMYNcKBIivN0z9jUZEYMbM5UaFrN8OoD86CVB64lmWWbKvj7K9pYGMh
	 zq0z13BP18k2mgDQUPmqotub7Sf4UqDtOaLN18NY087jCaJEyIN0+CPfiPUNqO0KLU
	 Nv8vADMp9JSUlyyOoybTSMXBh1FyOrvsgbwytAdcfqQ894yON6s58S6PW/s27+21Gy
	 uxcbAqRo+MLYO5wdnQKoxGSL8Jrocm+RJ79O8DAbf01IG2LCyIvwevJXT/2pmDLobj
	 Uk1zEg8V/g3IA==
From: Ralph Seichter <github@seichter.de>
To: Chris Torek <chris.torek@gmail.com>, Ralph Seichter <github@seichter.de>
Cc: Junio C Hamano <gitster@pobox.com>, Ralph Seichter via GitGitGadget
 <gitgitgadget@gmail.com>, git@vger.kernel.org, rsbecker@nexbridge.com
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <CAPx1Gvd4FjCTSn4oUWNDtLS2G4V3yrddggafX0WHfHEdojtCNQ@mail.gmail.com>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g>
 <9166fa83-4ed5-41fd-83f7-337fd524d0e2@seichter.de>
 <cf21edb2-7681-42a9-8b58-beca5d04c179@seichter.de>
 <CAPx1Gvd4FjCTSn4oUWNDtLS2G4V3yrddggafX0WHfHEdojtCNQ@mail.gmail.com>
Date: Tue, 12 Mar 2024 08:28:26 +0100
Message-ID: <877ci7lxid.fsf@ra.horus-it.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

* Chris Torek:

> You must use a literal line feed, e.g.:
>
> LF='
> '

Of course, silly me. Easily done in a shell script. I was too focused on
trying it in an interactive shell. Thanks, Chris.

Do you perhaps know of a function in the Git code base which could be
used to sanitise strings? It is quite a lot of code to sift through if
one is unfamiliar with it, so I'll gladly take hints.

-Ralph
