Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524520;
	b=0y/53xrJa3GCwm91OS7ZzoFRnXAjsfeS8kfSPuPT4F9MrUrSNQUcCy/FJ6u73P7XtW2C
	 sPKFB4/VYWPRuiVoQ76+Q5CNFULL3N3fC9Iwgie0DX6UlyEcBiENZCrk3t9o+5rqcz2h5
	 9/YDAoEGNsG4qo11TRVGzmw2PLvfxuYgpogKPcKJ2+UYZW6k3K+S/mdVn4i2fB0Q05Fu7
	 f44DAXkyYqKHa0x3Z1DcYttfu873wKiMBY+kQp6+rNsykkJl9H5D1/itw9owZbw5kZWOj
	 t59o0k4dYU//MYELV6vaPIQrWG5pQKGFPnot9CwJkLt/kS0MqvxJY0DSekv9I/mzrHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524520;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=iY75Fpj04XpxD+L88wqMBr2JLhAW0tS8ePkrR2Sfl/I=;
	b=lNB0P6u+0A+E5zdNLxVn1lZjj73xxGYct+fYGSTDhhmNoZCaAtZXwK1pEMBdahId9nF1
	 T9hG0JqbEPMxSzL6KoZXSW7w6HSv5j+FWcAcfbSMSX0oLz/+QmLQoqt8/mo3TnsEre6/J
	 YFt3FtbSwvbOcx3BOLrl60OVZBg6g4tmTPZ74SG5bmmrdSv8amQiX2Bz/tsIxpDbI8tDR
	 9i61rspM170y/4+I8LgTNgt7h0kT04nkTSGa1uiGs6JKy3LbLA+NdBXCZGXzVf+MV7d+Y
	 hZ2Wv21ezN0F1I+SC4IX7k3N6H9qv3VwqfiKfGGVsGQ/ncXs/KT2esPQoQ/nCew/dhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=nuaQcFoi;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=S0qvxlYo;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B2606A31C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 19:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA1B2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=nuaQcFoi;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=S0qvxlYo
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id DCD2E1D00054
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:28:38 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 20 Oct 2026 15:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792524515;
	 x=1792610915; bh=iY75Fpj04XpxD+L88wqMBr2JLhAW0tS8ePkrR2Sfl/I=; b=
	nuaQcFoidOVQZShHIHg96qxdvaqVUgm1HYRbMYO6WGRp9PRAKb4VjnyC9mqyyiO+
	MFhFihSM08v5WTJzkjPO5bbyV1PScnMxVImhv2z+OwLy4En6p61Yu0vt6G1Fo0si
	lZmUP61bXQ8sSUkzWO8AuxRFRhjzEFiwMKri22IOBicDyaS2Ogwn8bQrCr7q94J6
	O1aERf05TAlOQ6/hDjMXtpi0liT0HrOKkjQEdVK9WQL00b8tBiIj5WnCTwTNNTBj
	mBAH3tjpvfbKKp4vSvGptuDvDqqtORcvsbfTY2Nhaioj4qH/ab/jDakk1MNy1O/x
	LZKN35Uw+fGU6XCjRebXuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792524515; x=
	1792610915; bh=iY75Fpj04XpxD+L88wqMBr2JLhAW0tS8ePkrR2Sfl/I=; b=S
	0qvxlYoSAkuaPPuINrv/n/+QjAsILGuLtI05vRtSopsF+2Q8x0/6pv0FOq0FwNqP
	vERrvwZkT/t4uzicHUgdIgtCicBt0DNBwtxMBI3gacmPOsxVtixGSD4Vv/1apdE2
	hGTGKQXSrgkueTtUQ651O18aCFEJ4TwpjLqWJNTQmp19ftjYUeObTyJgXVeXQI7r
	yX03GxJHZaLryTJSgUZYP2caqWY8b9KaXYavPtxILPzhNHYJDOymC6OjZqYREPiJ
	T8M0wgr5uhR0ckWFQ2HW4UjVrqDkpXqmK1K12zDXr640aWZBvbo/Z/YOvu8Bo57p
	k7S10d13OhmXGiQ6K48Tw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792524515; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UKr3WWcdU7AwjgjlSAclJz46Bl7VXtgJc1RtfKWqcrva8fE
	TySvA8i5RYkJ+xoAoL9AWt1UYS0NTf24+dBWSZaVKi8yzUTTYNqZ2WY1/G+PUBGJ
	24Iw+BX3B+DjIBwDcsVp/mtLYUG6vjQVQhxbyb1NuSN332UQT2+/wpAW3xmBpb2A
	dRfLH+k/c+jgsTUsMY71BwSePWlSmcLL5C5sT1i4hRZLVelL+f6ACqwXXnTC7NAD
	P77uvREKKjjugVcuDBbl0h55zNWgwEZAIMCcmlepbxOA2GB+WPX71JHUgxKPOtib
	OuiXCehv1/uX5832TzzLdujtYs/rjqAF4DItcFg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:gE+bdlEld2MCCQIqCTrm7utyA5McCHAv7kUm1FClNhg=:W32d5v4UnVt9iph5Llb6+/jFoi2fsrwEyy3cijiZS64=;
X-ME-Sender: <xms:4MDXai0dz-xswmnQwFH1D64RD95YDp5siT49sA1HGrr6ZxMIHgIVYZQ>
    <xme:4MDXav6tcK9zz4Nmz95HdruELofQC4iURdLcdE-LucPxyalZ8ubVZ_V7vfsYZShnn
    j-AhH6HLYKo9nrK8gdRudmmI0qVyqX0oLnf_y9fZnmKFRLOPEqbQoM>
X-ME-Proxy-Cause: dmFkZTG3OTN/zVxjEl/cVSdq7N8k4LTjS3Vt3Jk52vquvQ/yoDLgpqTRdfv9GdrZwK4CVL
    AqGa4CtkeDVE9RxYNGuBrZZRarDU/26QWCHwA8DV32rVjhpHdPK+Ept21dEFR6LDB/EGmK
    4eiTG/6hhmOxDtpZ7xmF5ZzbRzoaHH8ZHM4BnVjFq3ncsEEgagekDaotPYZuHtLC6bGAKW
    hbNBL+0WsEo41IZUBBf3ydo4BMxV9j2NoXlxMGEBPDNkU9Trb52eLGz9e8pTSrd+biHohs
    Xzt5/MqL7AoS5TjHPOxMj+puYpKsCI+DdfyG4xNVB8vYrWFBcup7VZ++/AxVinr7iT4Ac7
    TpYLY2EmWqYLL/cDxTq8Dul000RlRaUNJGInChEo0NtOGuRlCy7wYLF+kLAb4cQ+poqTnZ
    nYMU0Jx5WDlw9g8MOfkO0cNJzXZn+QBA4FSJfRQwfPipcI98u92BmUOTL0fuzKuqOzLw48
    +/hxq/M3VZuldvyiW/9IdWNdXZB1GDhUY0ta6wFRrt9HwNZKSri9XrT2mFvuaXRIpO2XYP
    viaP6yHK2HpExbiJiLihRuMCSTjTQAUXC/8NIPal10K/AoAhGW7WGm4AUw3L3mg/NaN6BD
    fxfrlTdGixqydXv601DcKaWRKBUdUQGBHFK+PYHLkpkY1WSUJZNFpdnBnULQ
X-ME-Proxy: <xmx:4cDXavXQMpR3UEsn8FngWghzf6h4kaRIRCO0IAp1cvWXY6g0xYpY9g>
    <xmx:4cDXaig1a2giqJ85wSKfg-RuJZV5R2dIVuAn75Ov7PbpiS4gfydcpg>
    <xmx:4cDXaqYIUIZYL2a_SfSDW_gsrDo3dcF0_1SxfIpYZaV04xOce3wIBw>
    <xmx:4cDXavrWrgPlSAaCbBhX47IADmHdb7LsBdiyg1eOHBMfwM-s9o6J_g>
    <xmx:48DXalYr5_0qws33_CEdP5v152-RTJ76dT-ASevCXaZXRqt_-5Gou_ny>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2237322C00A0; Tue, 20 Oct 2026 15:28:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 21:28:10 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Jonas Rebmann" <kernel@schlaraffenlan.de>,
 =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Message-Id: <83c59078-f6f1-456a-a99b-688eaf56bab0@app.fastmail.com>
In-Reply-To: <20261020152354.165ad128@gandalf.local.home>
References: <20261020141011.0015d172@gandalf.local.home>
 <xmqq8q3sw75e.fsf@gitster.g> <20261020152354.165ad128@gandalf.local.home>
Subject: Re: FYI, git output messages are being used by other tooling
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 20, 2026, at 21:23, Steven Rostedt wrote:
> On Tue, 20 Oct 2026 11:37:01 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Steven Rostedt <rostedt@goodmis.org> writes:
>> 
>> > Hi,
>> >
>> > I just want to let you folks know that ktest.pl (tools/testing/ktest/ in
>> > the Linux kernel repository) parses the output of git to display the first
>> > bad commit found in an automated git bisect.
>> >
>> > The output was recently updated via: 0c0f93e7fa64 ("bisect: print bisect
>> > terms in single quotes") which made ktest.pl fail to find the bad commit.
>> >
>> > The change is being addressed:
>> >
>> >   https://lore.kernel.org/all/20261009-ktest-git-bisect-v1-1-1d1428f6cbf4@marliere.net/
>> >
>> > But I figured it would be good for you to know about this dependency.  
>> 
>> Shouldn't the script instead seeing "git show bisect/bad" instead?
>
> Hmm, it also is used to see if the bisect finished or not. It looks at the
> output of the last git bisect action and has:
>
>     if ($output =~ m/^(Bisecting: .*\(roughly \d+ 
> steps?\))\s+\[([[:xdigit:]]+)\]/) {
> 	doprint "$1 [$2]\n";
>     } elsif ($output =~ m/^([[:xdigit:]]+) is the first bad commit/) {
> 	$bisect_bad_commit = $1;
> 	doprint "Found bad commit... $1\n";
> 	return 0;
>     } else {
> 	# we already logged it, just print it now.
> 	print $output;
>     }
>     return 1;
>
> Where returning 0 means the bad commit has been found.
> Otherwise it keeps looping.

Is this different from git bisect run?

>
> Is there a git command to know if the bad bisect has been found or not?
>
> -- Steve

Sent from mobile
