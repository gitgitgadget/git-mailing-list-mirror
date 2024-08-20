Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324BF18E35A
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184926; cv=none; b=FKtTYzKr7nx2+RjP0DMsKzJ8RWz3riKyQNLy0hL8HWlZRo6vDcM042j7W2Ub7sv+S6YB8u83+V/olhEqXoY+vqtfz7XzSUX8W3h20VDlN24+pOF2SLfaziQdUwyBHCvTfWv/tmQR7Cv1PzXSephkJAoh0CvFlvGz17bd3xl03SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184926; c=relaxed/simple;
	bh=/lln2NYfD54WVDUAWKDXBNDiWAv10dtDgGQK5bCfpM8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gz+Y9q/MR8IgomAoHI+d0oMATKxDpc3sq/fO9qLIn3ASByJW5wE8IjsUxJtlmuswVx28dYeyJKtAWM8KGU+MNVtr4yEXlAeFpuBQ2xACeILiP2X8Xyc2m4rREdACmNdj2/PPhRSuXl48tgm1z0xhF6r++O1IPLvsL218zy5Ax5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=XNZSsYBX; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="XNZSsYBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724184916; x=1724789716;
	i=johannes.schindelin@gmx.de;
	bh=i32+vexcrLKvwe9b0sE/Ul+mln8NwhezMJcKbDeXOhM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XNZSsYBX57AZ8SyDs01af26CcZDLx5SbwkuI3N5m+NPhhMxgFJPVsg7L/mevbGZl
	 0jQZmjVLhc43jTbxkG3ykLgZMOUi1RVpJmwGB1/2cMdr0uHD3HWVXWEmeXL5tMEQm
	 S6FMF6ZrHzeT3y56Ie90fhsEXLyHtcrrNjHYoPjpB+vcQg1zMX9SpeJSsBVQcVXaY
	 FQKx0xxZ9oLMURhjiwDqpvJ19nx5je0jZmiYXUHa7CKIszUd0YVO/+fVSYewXmeDb
	 wdZ8DVFm+EWaAwOPBL9fWJ9UlPmV4nR6b4EvzEs3uhAQ4h3DpvnlLMjPzbKyq6S07
	 cir0ogMol+xOvVfAKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.249]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXFx-1stvOc4BH7-00FtRM; Tue, 20
 Aug 2024 22:15:16 +0200
Date: Tue, 20 Aug 2024 22:15:15 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Re: v2.46.1? was Re: What's cooking in git.git (Aug 2024, #06; Fri,
 16)
In-Reply-To: <xmqqplq4e31c.fsf@gitster.g>
Message-ID: <7fcc8d92-d60b-2249-233d-7ce99ba96565@gmx.de>
References: <xmqqwmkgjomp.fsf@gitster.g> <b6e3763d-945f-fdf7-e620-cd26b8c72419@gmx.de> <xmqqplq4e31c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TpCowXGoA+lFQ1TDARjiWMtHAgCwJ+ffQukxV185vKPViht36MB
 /QWve+wXQdRn8ELINVeok1olj96F33vfdhszAZPQ0wbwObSxgrE8FpLULgfLYnpLMsJq0bK
 L3BhD2xkCp6qrFCyLlnwdl+kaAOBscaZy99KjULBQnjVWCt0pn2Lvvc/eJT8OHMgmnls8Z/
 oa3BszE+xb1hAkwOj/UyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2Evl/4B1YI0=;4DJFbhJ569DyPkTyPxu3Laza3/i
 iFtB98lfWFkd5oxxanJiEB6b+O1YOSZ/a9nBJbyVJcOZo4lLnBcUYBbehACHEuK/LG6IR3ojI
 riRfr513bq27B3KK7wRgubbovNsQTzNlamKrGaV1azr8y4svRPOc09tkeelyBQCNj1bxToM8/
 dAMdGaVpSMzw3DHtt85vGm4SrNJLaj9zAd05ytjQRaV6bXYDSo9HOJ0Wi8BACH+tknGw5buZs
 fXuPGFu+ag0h5oOjNmkMA5JHE614fulBV3TChj9y0/LyVzJDGwT+zVxVdFvqt445iN380R/iE
 mtuI48Rc1PgSZrgyl74NGv+T3HNaLJDcfJ8sHGWJvWuWtQSgg16GUO+FQCIqGYOpLm/Gn3adV
 MBPAsU8EQ1yXakMxi4+BI1937QF/17Sz2qo/5yfVVfpvX7xFZlmJMjc7g+Fm8rLGs0niZqCUm
 OHMvM7bVnsOVOG3Co+kxNzEla0P78ZrkCp1QgExc4xLQtdF4Vcr5QzNaZCG/BQ8V7WiSr0y1Q
 0o11Rf+1QFcE6F6qiqN5+eSAFO0tixSNkGriTLNo+sE4egTHjAl0PGJ0lyBUrDaG+s8ARdD9E
 f9Lf+wSa3eINKru2eL3SYM9tSyheIO7apiIKXvAkp+m/3b+5t1cw6xnd+UfLP3KIlp380lI80
 fLieotlrzbEwnYgpPzpKSFZDhNUoJsAzp/oItqT7IZrykIJ9Bu8RH4BdSP412mqq7JdpsEhhK
 bUYWj0n6ClUDMN6EfY95GyQROIiLYqaE6lEwiQvQLYFRsmiaAsYPJ/27Zjp5hPUdWXcpOSC0J
 5jLqY78BwSBTZm/OTV8fqF0Q==
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 19 Aug 2024, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I frequently look at these two paragraphs in the What's cooking mails,=
 or
> > more specifically: at a paragraph inserted between these two occasiona=
lly,
> > to get hints about imminent maintenance versions (to allow me to bette=
r
> > prepare for them such as keeping back component updates in Git for Win=
dows
> > that strike me as needing some exercise before being released in an
> > official version).
> >
> > About 2.5h after sending the quoted mail, it seems that the `maint` br=
anch
> > was updated with a hint that you plan on releasing a v2.46.1.
>
> There is no immediate need for it and 2.46.1 does not even have to
> happen.  Just a grab bag of topics that are safe and are already on
> track for 2.47 are kept in case we accumulate enough of them.

Thank you for the clarification. I am a fan of getting things into the
`maint` branch early, so I like what I am reading here.

Ciao,
Johannes
