Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F3E34B19F
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580525; cv=none; b=aDpmJklEEVYp0HY/fUAZYXbpBP2lD7MvjFLs01Sx7MENduRhdejlj64pdZcENdaG2UMsgWxXH42loeJHEkYkDaTtXXysPiyLDUyX5t4gIW940oe+dO/x41aRKfI9rURQA25wkhZdyjjFIHw4SYz5qrf72v/2Ef09lEa+21kmtz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580525; c=relaxed/simple;
	bh=PftFSy9pPqkQ/fpDnLxuGUVJdaPEtNkmGERttk16c9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9Hdkdzqb5VjYyeH60MCrWMx3UJtlF/s45is554FSbhxFFQ1U2ZJN+UjWmWhr72Yl6mSmaRpXEpEWnYV3kbv4Z2riguIFoBjMLvZ1sl1Q82VGhdDHppyVSJI8qRXOgVF9EgrVj9B6teFkUiyUmu9zOXKin8Xu5yV4afpngDUxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=R+DkcFm4; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="R+DkcFm4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1787580521; x=1788185321;
	i=oswald.buddenhagen@gmx.de;
	bh=PftFSy9pPqkQ/fpDnLxuGUVJdaPEtNkmGERttk16c9g=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R+DkcFm4+teCN4a2aHcGjiiRzaftyZERqdT79AUk54PRJBJ4xA2r7iZvGBfmdLsc
	 yi58jMnQMrAmI4OLnatYjWIrffEvvwgQzobe1K/U55vr/xKTc7TTGkRbiJpyoWEFi
	 sl2FTIRFeBzj7fzS1Hw6Mf8geTrQdd2nnXHT1aGourQ090DC2lkIToNpJlOJACXhp
	 5Q+Qr90gaG31IfSvCGd84KmCux/mKhlibpMem/L8a1iDU5up3wvC0xmQEtdxHTAAa
	 KeHSJaIiKPBuupo/P3LqKstoZHji+KkdNxrrP8semFamvAEV8q7lo8Q6vt5I5X7cm
	 mYRc4TX2rTQqFufvnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKsnF-1xD1Wu2xMT-00LfHE; Mon, 24
 Aug 2026 16:08:41 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wyVLt-syf-00; Mon, 24 Aug 2026 16:08:41 +0200
Date: Mon, 24 Aug 2026 16:08:41 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <pks@pks.im>
Subject: Re: [RFC PATCH 07/14] odb: gather the odb sources under odb/
Message-ID: <aoxQaSGaDwqkP7Tb@ugly.lan>
References: <20260823171915.2662373-1-mmontalbo@gmail.com>
 <20260823171915.2662373-8-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260823171915.2662373-8-mmontalbo@gmail.com>
X-Provags-ID: V03:K1:wrw/1y3DP98UiP8I9PT1GabF0NVoAsdthK5wI0IbGqzUmgIclEQ
 B+JbzB/6hLYhCyC9/6Y/fqV2P6HHda5gCWRjn5serT9Qc1LNwY3dizzK8XVLhGnqEtAPDih
 30Yt8EIo79p4axhaJdQ4MI73qapM9mS5U4LNfog8+4Yy8m307B0ralJMVo4mhnaV98QMFVi
 d/nfo6l71e7X+ArqQsImQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P1UmpOmahtE=;DxVq/DS19HTL824U2KYZ3i9Jey0
 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
 z8Lxb8xRqMM38Hk0Q==
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 10:18:51AM -0700, Michael Montalbo wrote:
>Move the 23 odb C sources and 26 headers into odb/ as renames.
>
i for one would go with lib/odb/.

>+++ b/builtin/add.c
>-#include "object-file.h"
>-#include "odb.h"
>+#include "odb/object-file.h"
>+#include "odb/odb.h"
>=20
that's the wrong include style here.
it was already wrong in a lot of places, but as you rewrite everything=20
anyway, you could fix it just as well.

