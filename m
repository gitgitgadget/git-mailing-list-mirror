Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17D11E570A
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040001; cv=none; b=ZUuS9XmWwjUcA8/epphLKRgiyZK29pOaSaGHEbyqzU56i2NOaurH0KTgliQP99Zh+i517r9juvxgkiYwb4QGJ7UL8K5xl733n7kJ6VQONwGWX4oxemh/uBsSbkg6qLXcy4GmEIjgQ2neOJXooLdxxjZo1dcnsf7ZjHh2MmEMCS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040001; c=relaxed/simple;
	bh=BfxgiyYLS9OIRmCCvqWBzWUMfPttemRvEzIgot6E2I8=;
	h=Date:From:To:Subject:Mime-Version:Message-ID:Content-Type; b=pQ02WimLD8tYpCmrG1AzEx98fJqyotP6W88kF3YzMtyaOaF3Vo722gegSkZymVGXq1oZmukpVp8BEmA+/m6Bp/FWltT+rtHpIXd6DpCurs6udZ5S+8RKwbkOXGqpu5jV+4Y/6Y1xwUk5U8bmqpPegDBPaGf0hmIOIk7+0d/EZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P+1Tb7nJ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P+1Tb7nJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Mime-Version:Message-ID:
	Content-Type; bh=BfxgiyYLS9OIRmCCvqWBzWUMfPttemRvEzIgot6E2I8=;
	b=P+1Tb7nJMt84AK+pMXA+zsjFqEZUs6bMwKDwL2oEj/utzntysCMjbK3EC/pQhn
	MqMx8SGD8fdPnPD4PFfAAwafXw2/NAnjjSO6Dk97KnbYIGyyYfCgNG9rdmLPUEAw
	kOAXbZIHLvHftyzu5N7FG1h7kFfThgGEpJjypFHq6dnHc=
Received: from LaptopOfAcezio (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnWZY557ZntUGEAQ--.60693S2;
	Thu, 20 Feb 2025 16:26:34 +0800 (CST)
Date: Thu, 20 Feb 2025 16:26:34 +0800
From: "bolide2005@163.com" <bolide2005@163.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug or just a mistake : --shallow-exclude parameter behavior anomalies in Git 2.45.2: "no commits selected" and "ambiguous deepen-not" errors
X-Priority: 3
X-GUID: 777DC411-20CF-4D9D-AD8D-38DB7236D345
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.317[cn]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <2025022016263355354612@163.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-CM-TRANSID:PygvCgCnWZY557ZntUGEAQ--.60693S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4Rt18BDUUUU
X-CM-SenderInfo: peroxvrhsqiki6rwjhhfrp/1tbiJQL5QWe2188HOAABso

V2hlbiB1c2luZ8KgZ2l0IGNsb25lwqB3aXRowqAtLXNoYWxsb3ctZXhjbHVkZcKgcGFyYW1ldGVy
IChzcGVjaWZ5aW5nIGJyYW5jaCBuYW1lIG9yIGV4aXN0aW5nIGNvbW1pdCBTSEEtMSksIHR3byBk
aWZmZXJlbnQgZXJyb3JzIG9jY3VyOgoKCgoKQ2FzZSAxOsKgZ2l0IGNsb25lIC0tc2hhbGxvdy1l
eGNsdWRlPW1hc3RlciA8cmVwby11cmw+CgoKCkVycm9yOsKgZmF0YWw6IG5vIGNvbW1pdHMgc2Vs
ZWN0ZWQgZm9yIHNoYWxsb3cgcmVxdWVzdHMKCgoKCgpDYXNlIDI6wqBnaXQgY2xvbmUgLS1zaGFs
bG93LWV4Y2x1ZGU9ZWY1OTc0ZmM0NzBhZDdhMDhmOWI1OGRjZDc4NzI0ZTkzMjk5MTBkYiA8cmVw
by11cmw+CgoKCkVycm9yOsKgZ2l0IHVwbG9hZC1wYWNrOiBhbWJpZ3VvdXMgZGVlcGVuLW5vdDog
ZGVlcGVuLW5vdCBlZjU5NzRmYzQ3MGFkN2EwOGY5YjU4ZGNkNzg3MjRlOTMyOTkxMGRiCgoKCgoK
R2l0IFZlcnNpb246IDIuNDUuMiAoQ29uZmlybWVkIG9uIENlbnRvcyA3KQoKCgoKYm9saWRlMjAw
NUAxNjMuY29tCgoK

