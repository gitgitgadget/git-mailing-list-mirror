Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812EF19644B
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749698623; cv=none; b=FpSnKkYU2bwJL7dhck3RzSAFVeb1t/89ni4NN7KTfPJF+4/G36+rXFwV6pGVBXRau0VojVzlkm5+qf+oeCdWQt1nQ1xP0gXZ7yjyRHTu1ukZoz7GAVSnWZ6IlgndRB6NlSDIiNfqZiJnrkIGm4CTA+tfJEpwYz4kzN32ui6BPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749698623; c=relaxed/simple;
	bh=SmWHh7dYzEMfU0htK4MaeGFnq877OS40HLWofxA3tbc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=szXiMvMf17jx1bvogn1B/mQKHR6+3crfD8TbzzjmxcnH2M9fA1Wk4RBNCpEFraljwgKEey5YRSUg1CSQWR9s2jX87GYV1nWHPautOoNBb4dDilLDsuDuTP+WZXHvJTzu6Hr4i7cBOKoCddH9WpVLDP5QDVqx7/qSRoY1k/vj6pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=iyagWpg+; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="iyagWpg+"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4bHntN2rnqz8PbP
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 23:23:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
	message-id:date:mime-version:to:from:subject:content-type
	:content-transfer-encoding; s=default; bh=SmWHh7dYzEMfU0htK4MaeG
	Fnq877OS40HLWofxA3tbc=; b=iyagWpg+YXzZnL1shBypbIT8eB55e4f70aKcg1
	QXMeU7Rh2mGcAOy5Yz27k6BNUH8r/E6R5I6flFk+EWQlDFb77RSlr7T5n7oWUSvj
	lWFFcVVJrezKMNijUPzH2fn8hfzHw38bQIft6/Vl9Qio1hfx+n3rEo8O9fne+izE
	96CgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
	:date:mime-version:to:from:subject:content-type
	:content-transfer-encoding; q=dns; s=default; b=losi533snfgfatW/
	JclwNPvgeQMp0+/0nW57HzD8P8kKzxkQsPA9z8l7SMcIsbZaRIXa6aFLJB9b3jt+
	2DpzdTk25F+M8Jbt2CjbjCG8yIA66e9oKH9IqM7Gn8oR4VTdfT43SL9jBJ7qhoaM
	OoM3FIFlIFWZSAMQdEF2PaedKBo=
Received: from [IPV6:2001:470:b050:6:142d:4b81:8fea:90b2] (unknown [IPv6:2001:470:b050:6:142d:4b81:8fea:90b2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4bHntN2Hr2z8PbN
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 23:23:40 -0400 (EDT)
Message-ID: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
Date: Wed, 11 Jun 2025 23:23:38 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Brad Smith <brad@comstyle.com>
Subject: Solaris sed
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Building on Solaris I noticed the following two issues with Solaris sed.

 =C2=A0=C2=A0=C2=A0 GEN version-def.h
sed: Missing newline at end of file standard input.

 =C2=A0=C2=A0=C2=A0 GEN config-list.h
sed: illegal option -- E
Usage:=C2=A0 sed [-n] script [file...]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sed [-n] [-e script]...[-f sc=
ript_file]...[file...]


https://github.com/git/git/commit/e1b81f54da80267edee2cb8fd0d0f75f0302301=
9

The second issue being introduced fairly recently. Not sure what would be
appropriate fixes. Just pointing them out if someone has an suggestions f=
or
fixes.

