Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577879;
	b=EZlWWL/oYJ8vCGIaO62ffGfONGRu6Zg3Sjg2tkuRoQb6z3JjYdMZvdQGWfPvdGVtnEvF
	 +IcSEmbgeEB7o4C9lbfic6HwYplH+B3y69eQDoOb6EFjLlDi33gpyw9sc3Jkdidgpi3Lb
	 /OJocBfV97VUr7omFo8Zs8sz6q3gvk4lMlvqY0sz9rSqxehs0aVeEebKHxoKckGgUW3Nd
	 j8FU053hIaiKC586ytbhMOcYbh6PedWa5CWsiLluO4L2PGGKm4pb4AGTdiegGzsdDoN39
	 /2pz44JK/N/HXPT6Ha2JoW1at2Ues24Spq62AXKIRbgPjn3uFLU4Ph6UhZ/rszjAYng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577879;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VYaO0Uxzy0egRW0HjCwKD3xVImhwm6uwwWaqWtnm+mg=;
	b=ncOSqeTzTedB81Bgy7qXjcsOeJqdG2lgyFvQIkXWLniVg4dmp/KKLBNpZNVAK7mOpv6g
	 SS+NATd9doRgzLql6sIs35V6UJqWEMueuaLHbqqLQ0HnBdrBladru/NZizooYGI6zcCBP
	 9GGT2CilSdWefe+4RPbAulmDyxWfA5V1txpwtphPyjqSJMYARLskwSe9XgtnLjeLUKr1x
	 hfDRrXNy6mol8tSHq6bxeEfdZtHM3eaZz+/6zUOZtmd5r452RY6xGmVUNot7Ee8Z7m7oj
	 dOHiDO73OXuPsJ0dapRdDtMe6NVnqp2qkDUV8kJiWPNocDpsEVQ47Ft1d95Uu+/+5eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=FNanT0Ww;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LFJIoA7I;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A9606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 10:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 118A9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=FNanT0Ww;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LFJIoA7I
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 662561D00138
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:17:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 21 Oct 2026 06:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792577878; x=1792664278; bh=VYaO0Uxzy0
	egRW0HjCwKD3xVImhwm6uwwWaqWtnm+mg=; b=FNanT0WwVoRPuAuWaZCaEDzqPr
	6CdxIu20ID9hF8R2FaVuBddgVWoCgfmKNO/DCrRUPnrBya07pHTIYHNPnUdJ4Opf
	FOFYltmIqYhZ/BQzI1x5iBZfPGGk78rwvJHAUitDNUXBUwIMKG2tC7V0+z3dubp/
	BEV28vg2RRZgopziVC74Zh1ifGhhyOmLESv7Pb23O2OTycBaY1cGsrGOr02Pxt0g
	XKYawN5BqPuDwYX6uwGDwDW1OxXDvmVIoqrBbF/WWkYWL0NmSiQ5wPVjcxEEFyd2
	D0eWGTlZKuVjsnHSt2SRYDwVE3XcJVyXFw9B4GNBVyoTYRPbJaqrQVmk5sFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792577878; x=1792664278; bh=VYaO0Uxzy0egRW0HjCwKD3xVImhwm6uwwWa
	qWtnm+mg=; b=LFJIoA7Ixv09F2gxui91r8ldnMC/XbEQXl5DlP2KHNuIpCQ5NWi
	AQV+SDzk/CBR4XsNJrLrHVTQ4WlBL0bKHWsrYJz1mIjzHB9VxET89IEl0kJm1CD1
	0pUxc5GE4QQRkWNINw8/O2ijpSx4zpMexKDnuHOvFY/3GoN7t5/rYX4SVAILZQB3
	F2VAaHpHRz16qs1VsP0xATFShZf97+5EtpCXOouIk+IKacLQrxMRTsh7TcuAZVIl
	4gV+OMkXVk7SjIms9q4sM3Wzxu1T+aDjVYbVTuQadrRymZF3HIZNhmBijTLAIrcx
	sPi0jmn7qlzMqfq9KFrF/V+nAP80CbvNnRA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792577878; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iuqmTPaWhEkohvSqPxPK1aH1G4hTL4TJ6MesVuP/sTZ/zUb
	4mfF0yffeNwOh+ooZm8/dcbSZshsE0WVgewZy0sBVpVCrOZJg+bGU6vpE77gHJ6U
	vIZ4qzSQF4KAC867Fpwi2pFDzf4k4Z/a3GTr775gGdIvVaECHJr5s++YdA9na+mB
	PE2ibI6x5kKSegmjGecezcnD4JoplEG571SDlWBGRmOOXmzE1yxzW6VyGy9/XZss
	QePfmcEH6e9NxkS6ee5cAQDm9qeT9UwrmQ0RMJ0JOsTOvDjvYqDR4U4MlXu31GWN
	hXpe6HneehX+kfBisV4mcHp96ZaQUNiOfeWuslA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DnJh7adzdi6o/Dwe8XaqQtAToGqrPC1G4i4wx9TXHNc=:xRhbBfB+BoRyehtcuCOQIKo9kxSHDgEVWqmINQHRD28=;
X-ME-Sender: <xms:VpHYasIy8Xu5rhwRUBtPfTa9SPtmyg2R4oq6HMAfCeMijgplQCeEIw>
    <xme:VpHYaiKIuFj9kh965NO58OT4r9Qcfour2aHm_kNLvgSb8SIk0GitsfajHSiBWUjBG
    _fbYsmm3kKbp24Fdg8x7t6wXo-H1jmcmHhtpmh7kjyVDBOnL9r0Fa0>
X-ME-Received: <xmr:VpHYaqV4gcDjSYxZzyccxt-9zBSQvBoMFfWIXtDVcZl4aDTrv0nr3Q>
X-ME-Proxy-Cause: dmFkZTGVV6pk4l08PaZw37lvuXro1NwnZPvJvQRrGmIKTSq1ZJdB5dsbKl/SKrCJDTcqTn
    ygRnG22qb+uh5522DlnjviSBrq2jdrG4OY36qOzRK2gwrcfkOMkyCBTbUXsC2ivSMSVjNK
    xar9M5jcfY6hrhVx0NB3+JzParc5L2/P/yA8S7IXCBqN4+uKu+LwaH3NiXOOSLjCTb4Bzo
    Fkt5ptP1igSC+aQlHE6USXWwIMKEsGGBwaJ5XuSdDOeHfwTV4qP9TWx92adEnwGgeHa0Bh
    pU9umJRiZ96yrXlF+VzFUn1h+Ts70cfY2rY+NDHpWHoZ/m1andUJYJ6MfDIRytIa6+hxP4
    V823D9MZeXz/eOTNRFGlUpeZdi9bdatiQq4XEKLqapsdOKFjTVpcT/87oN60gLkSmEZe7d
    aW2babeNRIMeU630GvjXoFgz23n7PFIK7aBozN5nzIaGVK08umrP3ZqnILzbFl+O2vMqCW
    2Xu39tFzC30IST3QqHYvqwaEA+QuZFKaR1I0ycWhA8i/vmfD5n7C1H4qUzoj8CNCDcr2UF
    C/6MoSDQ9hwE0rWIr+a8snAYG08LqwhP3Bt2MLeniFVgOR5It3b46PNOq9vQzs+pUZBMia
    4qpPBpLgV4+aRRs3mQyThlnvgyzH8zJqzj2rwoDOIOn3FmLSPQoNazkQF6fw
X-ME-Proxy: <xmx:VpHYakjler-jzOQJzGkghdiyFEzmR0niPugBzHcYoCFsPnno6xKEgA>
    <xmx:VpHYal_NeKmLXgb1yaSwZ0HZVno9s26W51oE6EcMjsVHQGMwLM3c3w>
    <xmx:VpHYauC2HgTngoK5VyC9q_7S1cvyTwW0CypsXDwngA24nvxSD4TQCw>
    <xmx:VpHYaiLQdQsFD2Yy0Gy4uLVmvSv-uAesd48H3xq0u8aCBx0qCcUqvw>
    <xmx:VpHYavjJcAT2PVRDfqMnSHLse4AShZpVeJGEW7cvs_A0C0ADPdvamV4C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 06:17:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 87f2280d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 10:17:55 +0000 (UTC)
Date: Wed, 21 Oct 2026 12:17:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] odb/source-files: only reload alternates when the
 file has changed
Message-ID: <atiRUOns9G_j3TVq@pks.im>
References: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
 <20261020-pks-odb-files-reload-alternates-v1-4-d9e156323836@pks.im>
 <xmqq33u0uoqp.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq33u0uoqp.fsf@gitster.g>

On Tue, Oct 20, 2026 at 12:59:58PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > +	if (!validity || !stat_validity_check(validity, path)) {
> > +		int fd = open(path, O_RDONLY);
> > +		if (fd < 0) {
> > +			warn_on_fopen_errors(path);
> > +			if (validity)
> > +				stat_validity_clear(validity);
> > +		} else {
> > +			if (validity)
> > +				stat_validity_update(validity, fd);
> > +			if (strbuf_read(&buf, fd, 1024) < 0)
> > +				warning_errno(_("unable to read alternates file '%s'"),
> > +					      path);
> > +			else
> > +				parse_alternates(buf.buf, '\n', object_dir, out);
> > +			close(fd);
> 
> When we update validity and then fail to strbuf_read(), say due to a
> transient I/O error or something that was caused by somebody else
> mucking with our alternates list at the same time, we warn, but do
> not roll back the validity update even though we failed to parse.  I
> wonder if it is safer to run the validity update only after
> successfully read the alternates file, and if the extra safety is
> worth it?

Good question. I doubt that the extra safety would really be worth it in
the general case as it's rather unlikely that we can open the path but
then not read from it. But that doesn't feel like a good-enough argument
to be sloppy, because "unlikely" doesn't mean "impossible".

So we could do something like this instead:

	if (!validity || !stat_validity_check(validity, path)) {
		bool successful = false;
		int fd;

		fd = open(path, O_RDONLY);
		if (fd < 0) {
			warn_on_fopen_errors(path);
		} else if (strbuf_read(&buf, fd, 1024) < 0) {
			warning_errno(_("unable to read alternates file '%s'"),
				      path);
		} else {
			parse_alternates(buf.buf, '\n', object_dir, out);
			successful = true;
		}

		if (validity) {
			if (successful)
				stat_validity_update(validity, fd);
			else
				stat_validity_clear(validity);
		}

		if (fd >= 0)
			close(fd);
	}

I've queued that change locally for now.

Thanks!

Patrick
