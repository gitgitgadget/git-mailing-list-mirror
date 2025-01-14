Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008848493
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888740; cv=none; b=JAVXdyXSnn3pljbN1HcweFn73+qypuSKAl4fuDb4hlBH+GAbG0iDxysM93ihlFW01u7azlIjxn3gfo0zrj4oDtfy+NT2hynV/VNmZpCDRzS1Kt5q05k1xGj6Xh9D4I0ldxPLsVz8ENXbkmm1A7tx07uBJO70zowv1FnF18d+DBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888740; c=relaxed/simple;
	bh=qB0t0a63OnEFP5yrS/tgOD3cT1hlxCqeqNEXHbeWmBE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ik8ktFv8KNZaA0bWDfZQvGHYUbBhGahGHn1WjEVqWsjrd89tJLNcpsg9iV7HAWlPeOGpi6/oSRNEqBgui3X5hyB0f94TktT9sCyzPb3PCAj7xb+/UUfjNm8JPrM28vD2bEHREcc0lGrse+UE275JGE6Q9v42tdpFtPw3SCzsdCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=RS4Ev61j; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="RS4Ev61j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736888724; x=1737493524;
	i=johannes.schindelin@gmx.de;
	bh=qB0t0a63OnEFP5yrS/tgOD3cT1hlxCqeqNEXHbeWmBE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RS4Ev61jCqqTK2huryxFndj6OnufqfP73WgdbusiFjpLvgDSd2l3s21sqrMMEniF
	 fl4Q74dmC8R+NgPNsc2JNrRaTfDnm2w7Rgt7ga6wYiOGnRnFfUoWjL6O7iqXmxYNf
	 1awGZeWiRLBOC0UJRcr/lPYt5dIc2kqjIU7eAyt86cCOuSvOyXcCpVGnmuDzKcwM2
	 KlOUQNUGawoZN4IvQszws1vj/M9MSgDwZBR7Dr2efTqDL62bI29IGB4EcfL32yLU+
	 ZYxsTuPyEALQTfbq87V44umE1yphFjxRaaNUYbc4Hz0Y5Jq+2UQ5wPL020PSSWkio
	 yzKjy/Cnyup1hqYaew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.189]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mGB-1tV9Wp283n-0183lJ; Tue, 14
 Jan 2025 22:05:24 +0100
Date: Tue, 14 Jan 2025 22:05:23 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: rsbecker@nexbridge.com
cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org, 
    git-packagers@googlegroups.com
Subject: RE: [ANNOUNCE] Git v2.48.1 and friends
In-Reply-To: <041901db66b7$c0c759a0$42560ce0$@nexbridge.com>
Message-ID: <41d5de4e-c4b5-9564-6210-d9b8efddacb7@gmx.de>
References: <xmqq5xmh46oc.fsf@gitster.g> <4a3c949a-416f-734d-f63b-cb1b7f9b362f@gmx.de> <041901db66b7$c0c759a0$42560ce0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1thYhK/iOI8hP9qLZLZycQMSy4g1fUZNgLC6Xn1xC90b1GwNBhH
 UoY7zbXs1ZPEVLrMLNphTk1isYOMDURziPRsZktM2W2cmbXAVM4qlcRM8lkWmsW/g6Igxxp
 pIM7qBTfATOGau2Pm7F0cW69p2FxMQTSpyrAypSsODUlEXDAmwcAneMmjyRqQuzgzPlf9l0
 PcuP0I6AZkcPC7B0SoC8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sT9x2HKSbuY=;nRNy3/mqsiXhq1lngQVgKB6P1f+
 /UTE4M8+wLYPSCzU/tOivJjeqtwmNRgOq7nzM9TcMTsHGKckAPFl+QP+PizSR12JNG3ogqTxG
 bC3yORyumexNKK6zVEtZRDo8X84xs0X973cQfCMR4aqUj3B180osUMyEedwJhHSaOArIgXEiz
 Jkj0QwljAOfzYDU3j2UQ0QFeWPGn876HH69mvduo7NEpDxPmLKma9JzKWfaMI0ePr6qNPK3jB
 793yMwJeY20Dae38nmFjgLDDhelvfqpNAqucO5yCTLSS72vT44BTmDv3CEa4OlipWz6XMVjBL
 fsG7XjcfDCf3NDRF+9hlxdz5+gghoEIMFunDBXH4uY74SmQCDY4Nn/XDIWIOzw5Sw24Nwwcvy
 s1SGoI0l++m62kAWkg8vRJT+qJl+TjgrQ1nJM929XMZpZPXwZBgYGNSe4j5uR7uD+sPpi3hMU
 KiLbFybdUjQHysJVnID48CxfCXs0mawROl2wYA0vkNjsauoJbNyVF4Qxa+sYTovFHrZEBOdnx
 EqHBefTiWhkdeHQq3AcM3eHfFBUD94SEmTV7XgCs5C6UqbLOIeii4a/oFGxtQqXBmNUTNlhpC
 dX6NVdNSmrEA8bZSnjCOmDhIZNlWP7cW8GF16smHx1Fv8AeRSCCdeduXM5sE17I6Yg2RKsKF9
 YFAWc0WyN+6jjz0yCgW+4xD1AOGiVj6JxhGcXrLlM7/0pMWkJIMAa82IAJyizY9ixU3FnJZtU
 sHVDHmAy3xtWQres1whJj7NOgulvGAqIdHeuWIbzVe4XKerO/CHUtHMbeyqYQA2Nk1DncPr6Y
 qKt6g/byNX/XKCmxbfTprPGfwjaMjsBd3SnO9hm1ST8ITwGsi0HSPO3qC09+zxE6PzvATzU++
 auOmECeqnSaBill+B6iTYZZPLo9MK2F18dTK57l2DgJqPQ8/ivIMiPLuuNZ1YPdPxPIYmad70
 IS96CZsb8zHZnS3ay1Q3YdWto+e2AeW1z8CZ9s4m5hEVxNIQG4I5gFgxkr8hVayiJpnTib5VS
 GdZg806aOe3Tw6wiQLNIT+A0X0eC0kicE+QbgNuihaxEgjca4kuf6gp/Ulie7iXsQ2SSpDGKO
 mq3JgE2sixFWHY5wVixV+f/6msryRYlr5UBlsAutjeItV6zRZWJMAG6HPq6UhXrqNqMrh2R6H
 OokPmlPOPwD7BCaIrINkkTDYXFgoEvzt+mLpdVWWwFclLQhqmqVK86pdkaY1FjKdFtB+KRnIk
 21Ix1Eu1a0W7KtetLlqQuaUFDT2vvJ9ACw==

Hi Randall,

On Tue, 14 Jan 2025, rsbecker@nexbridge.com wrote:

> On January 14, 2025 1:44 PM, Johannes Schindelin wrote:
>
> > my apologies, I only realized _now_ that I had forgotten to update
> > `GIT-VERSION-GEN` in v2.47.2, it still has `DEF_VER=v2.47.1` (but all
> > other mentioned tagged versions have a correct `GIT-VERSION-GEN`). I
> > am very sorry about that.

[I fixed the formatting, not sure how it got screwed up, it had verbatim
mbox headers and inconsistent `>` prefixes in the quoted lines.]

> Oh gosh. Glad I did not hit the "build" button.

Well, depending what that "build" button does when you hit it, it might
not even affect you, have you tried it or at least looked at what
`GIT-VERSION-GEN` does? `DEF_VER` only sets the default version when
building e.g. from a tarball.

When building from a Git checkout, though, it uses the tag and everything
is fine, the output of `git version` will say that this is 2.47.2:
https://github.com/git/git/blob/v2.47.2/GIT-VERSION-GEN#L15

Also, you can always hard-code the version by writing it to a file
called... wait for it... `version`, before calling `make`.

> I will hold off packaging that version until this is resolved. It is
> definitely needed by the NonStop community.

I'm not sure what you're implying by "until this is resolved". I hope that
you don't intend to suggest to re-tag and force-push v2.47.2 because
that's kind of a serious no-go, those tags have been relayed to quite a
few people well in advance of today during the carefully-orchestrated
coordination of the embargoed release process. You cannot pull that
v2.47.2 tag.

In any case, if you don't want to build v2.48.1 instead, and if you cannot
build v2.47.2 from a Git checkout, at least that `version` file method
should work for you and you don't need to put pressure on anybody else to
get the version that is so definitely needed out to the NonStop community.

Ciao,
Johannes
