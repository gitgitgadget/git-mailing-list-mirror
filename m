Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27602BE05F
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236467; cv=none; b=T5hQ1Z7Mv9fcNr4OIWgLmG5h98h2QRsurqSQhTVFlGIXa0N0fP8uzJY+Fz+XnquvT8bOZRQhO51jXip83tPg81gxTLOyH2i+OtzzAX92fiMGsdUAeMxy/OOCToCmLnqlYmIVxdGTRuylZnaxtdo/yG9f+8rThhQ/YkY7cx1p3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236467; c=relaxed/simple;
	bh=dhoKposuzgkGLHYsreK6e2aMBPe6BH1FQ5cIRWMO4ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZSTtcn0FDBbpFBzg1h2f1bCEDuj7j2tjvszh037ySnr2ZS2tw5YjoyVS8PNgUmUIzDEVNLqJUXxoJzUqs+fZCmLNMPcGW3v2MJc5/+GdynbckIcDNFdlFS+4bOuRrLBAK0kf95Ug3tXNE3dYbEULgQp87XO1/UN0nq2uqahyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=dOlkZ9EC; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="dOlkZ9EC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773236461; x=1773841261;
	i=oswald.buddenhagen@gmx.de;
	bh=dhoKposuzgkGLHYsreK6e2aMBPe6BH1FQ5cIRWMO4ZE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dOlkZ9ECY9yUGXAowgEyCcbEUDr4jDqwEGBiE1QpQJ0KhtUX3EjZKyUGzLZ8q4CG
	 ebVi1xJ/0rl1niytYM7+f6H/ac3devjvK4n2RxJwiABg6zETvZt+58YlRRB0cQiuU
	 62fye3uqs+i/UrZTUm+qxUuXZ/aRPLFnE32ds8yaizNNrapcLWI6VoA30/mGSWgLP
	 C7tGJmdNCMkR7SUD31TEZliEn9X+zlp3dc+cX4krpTKsIF6JCjllBikDPHLHMJa8/
	 ZUXvaGPwLMq4JUm8kp9SWlBsvQ+97ec7Y52aCXCkD22RtZRtcn9oRPzwR4HH3AJpB
	 OOuvgTloCW7sa3wsCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ygt-1w2nyg09rH-001ioU; Wed, 11
 Mar 2026 14:41:01 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1w0Jo4-8bQ-00; Wed, 11 Mar 2026 14:41:00 +0100
Date: Wed, 11 Mar 2026 14:41:00 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] imap-send: remove two string length checks
Message-ID: <abFw7FMAwHPPWOBT@ugly.lan>
References: <20260311121107.1122387-1-dev+git@drbeat.li>
 <20260311121107.1122387-4-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260311121107.1122387-4-dev+git@drbeat.li>
X-Provags-ID: V03:K1:vB3q5CUHA43j62qaaTx9QkCPWGTc545Y3P7Kpa7iCQoTgcz21fk
 LoXSyIWDvO2KirK7zJKXKtAaBCvEvH8B9AzbxbyLVuDswP35d4vyGuDSCO+IvRbrhz1BcAa
 r6VWBGd/GV0h26f8Y8Q5oYcqUtqHqluijLA/bLy1iVJZYpi0zv0CjB/mgNfewvf/U6w4tr9
 m2l6E4TAy4X3/9n1ygTew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Izr1deoYhls=;RwxQbZepiei0kzcRovfo006VPAK
 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
 af7zwfKCOa0HKKpF78rYIgfJOSIDX
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 01:11:06PM +0100, Beat Bolli wrote:
>At this point, these two checks verify that the ASN1_STRINGs are
>internally consistent. This may have been ok when the fields were
>accessed directly, but now that the API is used, is unnecessary.
>
that argumentation makes no sense.
the purpose of this check is to ensure that there are no embedded nulls,=
=20
which the matcher would be unable to deal with, which may be a security=20
hole.
