Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED0353A70
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134865; cv=none; b=kxNYUzgPx/QQ6NTPprmtLgrLYwDvpjFoce2llRbOq6CGh96+okEVQk3IE2JBqhiVqpMNws+7u3awldAXCrM9zVh02Xof/1HKI23cRkUFSsuNYtesWwVaOdIdUgSBIApBUtEOMh6lJ0vHEqrvj09tDoW77DcsTi6t7p5Z432ZuAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134865; c=relaxed/simple;
	bh=TCzsxfp5h7/s8UQJWSDwXAKo+KSK/ktfwuuB1DKY1pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4775fxH694NRVRzQ/d7dXXEns+YKtlrTiblgITNWMc2bpqUZewmIo7OgvLma6RNPGVr2J7VuqVek/0ZzU+XGXR5V4Lgp0EFPsUTs/YftJoSIohUeSm27mciRyjIiqzEdgGHVkpDUjIQvyyrIFw3kE3u6HFTwazeRmhatKwQRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=Cq+K1Kpd; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="Cq+K1Kpd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789134852; x=1789739652;
	i=oswald.buddenhagen@gmx.de;
	bh=TCzsxfp5h7/s8UQJWSDwXAKo+KSK/ktfwuuB1DKY1pI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Cq+K1Kpd9NKJJDzf0VCCP9lVkH7qHFUZOemKj0c6rvpPOlL3RMD62KdG6YxQfrHi
	 sEfiXSjVt4++olasz3EH/vy2Vi6hU3jdkC/ebmiCClpNxTsvrubrbK2AnATiwyqn/
	 pEU60HKjoalN+FqD2zbfQ2lnIP3D2YOCkJyxSbmd/skdHRmCuQTo6tRJb8F4oWScj
	 vygWU4xvcj//EwsLCzggIn7znghDfbuINYwcRrsVbKdt4ddZcFVhvhDClL66Ug6MR
	 UMmjrNvD6U+Fv8MNk5ftJegalI4ec0YfWWOf1nfJadoYxhxzPtPOBn7lpumY6gK0s
	 sMxCMI9SSHmgbuCLBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4JmT-1x5Iov1PRR-00BFxS; Fri, 11
 Sep 2026 15:54:12 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1x51hj-DyS-00; Fri, 11 Sep 2026 15:54:11 +0200
Date: Fri, 11 Sep 2026 15:54:11 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v9 4/4] hook: introduce the receive-report hook
Message-ID: <aqQIA37pZL0TZaDR@ugly.lan>
References: <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
 <20260909-758-introduce-hook-v9-4-3043d417e0ee@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260909-758-introduce-hook-v9-4-3043d417e0ee@gmail.com>
X-Provags-ID: V03:K1:5Z2Xm+7tSls9dy84/Hz5EsK+qqMb+sCPpUzrOiym+EnL699xKvf
 Rnljlvlvs4qMinP5BjeuSgazHOOgH2id0TYMn972Kixhz64OCsU31yirXsvYMrvusOWTMIR
 rPviafGCMAWnQOCtzolonvV5B/viLrxEhSiK4AxrjQLSH+heq+dRixmURW83ITCz42MSFHQ
 b0YPISTSxSf2b5B0eemQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:74nOTgxLmE0=;Ew2rAe35d3AvLBm/90vQCJk6yAO
 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
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 04:51:39PM +0200, Karthik Nayak wrote:
>[...]
>Introduce a new 'receive-report' hook. The hook receives the complete
>pkt-line encoded status report on standard input, after all ref updates
>have been applied to the repository by execute_commands() but before the
>report is sent to the client. See linkgit:gitprotocol-pack[5] details on
>the protocol structure.

i suppose it's a matter of taste/policy, but around this point i find=20
the commit message's verbosity to be counter-productive:

>The hook's stdout fully replaces the report sent to the client.
>[...]

i would cut it down to the parts that aren't redundant with the "proper"=
=20
documentation in the diff, keeping in mind that the central question to=20
be answered by the commit message is "why?".

