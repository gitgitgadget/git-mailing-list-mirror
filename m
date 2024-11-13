Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6A71FBF4F
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493448; cv=none; b=OcLu4qspqnSsjohXSNzt8PlrZxllKGTtDhD/MA80cpDkYcgz90ZzG6uubbrgwPSro9MR0Ej2eEY2aMmk+C2FNsZIY0URYGc0Cq73Y1db2zcjjnAkpoA3ha47VE5mxmtZeVLiblERb5oreJf3WqwuGXWO8/MTFj5IPBuVv7qV3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493448; c=relaxed/simple;
	bh=mjoK1UFgnX6KKbxWSVzRychYucphrsjkacOWkRLzVFU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n0I/nD2ZRae9P5+gyE2BWWFWL9R41bieCBrMpcRZjW08mVPSB26rPie2URDkHYKteYC6nQOiTqJXLr38KImF7SNvdDyU0rukDQxz0NiHh5CZQ3fqstIumZLhMlp7ZkVn8VUEKeRKxPpevMqICaXmygnFOU9st75z03bFvMqbjKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=iTjQCm+n; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="iTjQCm+n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1731493440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjoK1UFgnX6KKbxWSVzRychYucphrsjkacOWkRLzVFU=;
	b=iTjQCm+n/LRQSELZ+mRu9bBy6T7CISlywm7kBhoOvtXYODScGlIZrt03LLbToePbFo5OVZ
	SNhnNrjXFAY9+G9eRh8UlKZx/eiB07PgD51fjb11n45VbLAszxlrbTw8DIyUr7AkvM14VW
	Gs7fob0JgcPoW3XkoQpe3V7dM/4YbFY=
From: Toon Claes <toon@iotcl.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 git@vger.kernel.org
Subject: Re: Shallow clone of a specific git revision?
In-Reply-To: <ZzNJGHMlxGQyFV_c@kitsune.suse.cz>
References: <ZzNJGHMlxGQyFV_c@kitsune.suse.cz>
Date: Wed, 13 Nov 2024 11:23:47 +0100
Message-ID: <87wmh7ig98.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> Hello,
>
> Looking through clone man page it supports shallow clones of branches
> and tags only.
>
> Would it be possible to do shallow clone of a specific revision,
> and checkout specific revision on clone?

Hi Michal,

I'm working on a patch, and I've submitted a first version [1] a little
while ago to allow users to pass a reference on git-clone(1). Would this
change fit your needs, or what else would you like to support?

--
Toon



[1]: https://lore.kernel.org/git/20240927085438.1010431-1-toon@iotcl.com/
