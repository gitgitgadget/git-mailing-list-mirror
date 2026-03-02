Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48100390980
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772488599; cv=pass; b=aPghrBBrpUxcEiBiDS859WaMyiTYBTMDf2/24h0sVLmsm8WH/yUNAZdbEI/cPdR4ilF9kNHmJZg5yFroBuDRYzRzcj27J/qoPgHvXRY/bNhSxiPsWw0cFJc2xbpSGoQTVhKOxt/yWKRLGLrYG7Qd0N8PI0JBX2PJ4iCbkCYVtb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772488599; c=relaxed/simple;
	bh=8qQ0+YrTb/BRXIm9WTVP5vwVmk0RWX+wncccx4oP7Pw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OYOSfvg5MChk2qmJ+pmz1sFLzQNYAliCls49h80sWQP5g12KNNPppVT+SQE4lpYr7Ees+SVqxHclt/icMv7KgHrbRTzLVAQCvwcDz1byExE3tioY06X/n1djgfjgIbqjrvrx98Hfn8w8kKw0sGesdc15HuHJslrFVVkwXka6lyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeAeFOYP; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeAeFOYP"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5984621eec.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 13:56:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772488597; cv=none;
        d=google.com; s=arc-20240605;
        b=SG47I3ZH+h4SQDHbTuQpBlKuhnbYmDe2qrmYaeCd+72zaFny0X8vPEzec0UyxgopNx
         X23xHeMBBZSOQj3DlVos5yWL3EGATzbxpNMai9ur30SDqolgnYuKOANKh5Rv/VCi4Rhl
         hjYCb9xp99m/NfcBW5GVotMHBaLPLJ7MP8xtLv5K3QAEtLpEFjUGemU0jtCTl8/kvB0c
         0+khkIhjCCpwFS6hRC737rZ5duDYMdlVvL793qOJc9B4TemLtvCsStqVb55cCt+13OOy
         dno5EgSG6f57/ADpdcwrGGLyADoSDmTSWcIj1e8ZvnanR9/B8/rsu4AxC0lsGYCTabvH
         /vWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=bccZCXRHn4prXviPuUirwvsuWl1Yl0aeSpuj1Elg3ZM=;
        fh=RcSxp/iRoIX7Q/bav5aJdqea9/2Sdrg88sfURYTdI64=;
        b=Zp3yZnWYQ+UWoB/3lrOUAKdbvi7MPMGcLCwelVOhOaz51LnBG/egDgTJyIa6S1ZG2C
         YI0i692vMjpGGNLSS2IzMUyPlQEk5nH/qXQWTt07hlS3+xPPUGET3z3KIr1OOtOR/up/
         UE8hRP+mXfAdTV1eF2iHGA6Y535PsHg90Ro2DKTlkzyaG3ZRggDHOpfKxOS8xs5auLeE
         9P62z45sq95Of8piFvnAcGkD3UgFH8KvXCcEFeuHxcue+ee6zrmQ71vFZ8sJNwOteI/U
         ohcuRlxas5JbemMAk+xTe983Ou15LQg2cWiZtEVf0Cc5hFoGG2aHbI1O8DZ+P/hgJUFy
         Afwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772488597; x=1773093397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bccZCXRHn4prXviPuUirwvsuWl1Yl0aeSpuj1Elg3ZM=;
        b=IeAeFOYP4UMOObf1b7USiUFYv+ezC9qzZIZyBfXb40urFbd9b6OVjbB25oOHgHFkEZ
         PlNwMgS0YXz8BLJIjxHKl+9KEybizDb4D9fjmU0IZNal2IKpJ7PmkaTtTvFvvWtgSZI/
         x7hTrHXnY37acJQ2vWak7KsnMoeg7tuLMQjgv8CqNYRq2ydn1JCvd7EsIhEFni3HjvSS
         pkUZFsgoXk1h/FkOAO+muT/CNJSQLytPOx6X6KNFTLm1Ii3aFJWGCJFAr+lwHhHZAYpW
         Ag9iVNi75jXFfXaGTAINmiDfY6uhmHPYSIUHAuJqB8fltfLYOKhOPiqiewUROoiKc0F6
         lMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772488597; x=1773093397;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bccZCXRHn4prXviPuUirwvsuWl1Yl0aeSpuj1Elg3ZM=;
        b=oIpLPgVPQtSfvWGkwku3854YA0BMAfoFJgFMaDS8dCoorN5Gf643UHQ+PKUhDJ2X/R
         /7e9xF37kMTSnvdtUI+gH/IZfabR6E4W9jXIJesuz5nVfA4tfCV444SIly7MvQYVZC4c
         G3OKlqHG3e4bm4O4OU5SS/pkUfGuU4nO8pmjiS1RzQ8sSuDzboI8/zssxd/H8/yjWwB9
         DdsGw48SIOslbGQiwDSltUijSgpkSR7rLNpF716R3BbWdEBTsp5SLqOYNjs7fPrM24nB
         Qg9n6TZSZHk8Kfloy0HbdFpiFVwXT+7vHwzS25sXoPCCxXa4diLJPk1jeyHCWbx8D5hj
         0fGg==
X-Gm-Message-State: AOJu0YwzM18HwpAx4DeF1zbacab7nm5Lju4gp2hZGh13UdiSsMpVCISR
	JmFFP1DMQ6dkV9QRFBuumdKsZEqIajzWvHKJStFBsn0fuDzHwXfeGOjM5GPJOfT75J53Y8X/wFB
	nfjYb6TBWJVUal5gOAqRUNagNGipXaD/NEDwT
X-Gm-Gg: ATEYQzwt996ujZry6Oc8fVzQ/Yfe5klnICiJdUzDMxdjVFBfffEkfLljDHuxttzNE9a
	VEsLScl6EBC6JANrhekDGN2MQCozzpNwZWJKc+EuE3lYe93uo/9xfI3kNYqD4hZSxWqnyyhTVOC
	KCAaLLVkwHoQcCPf48+xLU4eszpKfRrIUo+rmexw1IKSvhwM9EAy89YNaHZugBkeysTlGGf9ADW
	KlP/oSoRwiuVqxagSRo42sA83QrsMhbaRddzEnUm0A2nPFnFIC6SZnKLyZV9MIVR+8yEYgIfNwH
	WIGQI8GcNFZUL5VJ0OOPLLuwNnvaDRPFquMERJg8P2u9n9qyIQFoK2pkkkBJ7WFku1vN
X-Received: by 2002:a05:693c:300f:b0:2ba:6978:2b4 with SMTP id
 5a478bee46e88-2bde1d6f327mr5424708eec.20.1772488596740; Mon, 02 Mar 2026
 13:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 2 Mar 2026 22:56:25 +0100
X-Gm-Features: AaiRm50BBSFIgjUJrrV91PDAzbneavWlDZLWx8s_b8E6wWf5QdtffO__GOc-plQ
Message-ID: <CAP8UFD0MGnKY78gLa-5hgH4_xB_eFCW+n-oEjn6yncUEydz=cw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 132
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>, 
	Martin Fick <mfick@nvidia.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Bruno Brito <bruno@git-tower.com>, Michael Ryzhikov <samonon@gmail.com>, 
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

The 132nd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2026/02/28/edition-132/

Thanks a lot to Bruno Brito, Michael Ryzhikov and Shreyansh Paliwal
who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/833
