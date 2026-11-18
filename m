Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030218;
	b=Qesgpwx4w6tC/OBU7FOWwFjU2qkhxevG7ubsCGM3qbScXoFb5WsrtYPBMIHVRH1kVPnP
	 UOZizXO1qdj1tv0uVV+LUcZROlCyjJe7fMWo/748IzSMju7Xj77aw9xeOgySRBuzoByBD
	 1+DUdG2UWGJr3Pg2AkHiFrTt7mCsyPQVLqqKjmMPH8ygkeUB3DMa7h/LYJFm/SYPO0B2H
	 qaCGlkZJsnSaU6nxoQLnymQ0Zd14Wk1kAJp4todyb+v4gll1IzZtwLjrnEPUGRBVsYOON
	 M5jNTeTR3tYV7AeqHmNgHQo/rPpj91tQBOtOLcwZGcRaaE4bhj3vDk81q+LVnq6iEWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030218;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=ARz0ZCZgJH/OtGctZQ0ZouLU+xhCS4xli8bXNhXOgNo=;
	b=GxwaJysvBWqDPt7i8+MhcPRY8mbG1N46TXogAjWs99TccRdqOzP+ggTDTJOLWhvZ7vBR
	 a1erIA3PA1p0Bf/fF2CgMGaySB4hfm+S7AQvVEM1DsN+z4TovJ6YGrdkOrSIodKlCHDFb
	 2UNyTZbVTVfNuwTSkxi0j/FNLPGdrSKH56x83YcvTG0AzvcWYaZf8C24XSNilszIxbVU8
	 h6wogYQWPnoR02ekEpCyEflR/C/V2+HggwpaOksV/sqTtNattBQAS922L5PQjE3pxEa2d
	 r22gOJFcZRwiuLgKqPiP/fSbpWOBAmwM1P7yN174ioplG0yIfW2JyCzbrLQDDLLpKxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=VCbW5RmP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="udN/zx0y";
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D87606D377
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 19:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47D87606D377
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=VCbW5RmP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=udN/zx0y
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D5327A01D4
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 14:30:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 18 Nov 2026 14:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795030217;
	 x=1795116617; bh=ARz0ZCZgJH/OtGctZQ0ZouLU+xhCS4xli8bXNhXOgNo=; b=
	VCbW5RmPy4FVnAQNfXeqEY2YAZUQ2WjFAiLSr29I3ALLKue1UxiFtv7473mUJTTL
	HU/io2OpMqQW6qpyhdcJTUboaB5ObyHh4mXNjVwS7cOATw/HOM/9gcHvEbTHbl/m
	gejZA3JAgpMt+n63RImqv3m48pWptq1mLQOGQ3Xk2MdTv7FXxCoPAqKRoh/y8pwT
	cfl9f+TeGcMkC1VxI2OnixAnje/+4sgQtWlgV3sAvnfuFthrsH8Ksa5iuJxL7Et4
	3Zp9mNdnThE3+Tdq+bQX4IScjlbBhxXrTcE6/5E5Y5dTmfOOpdlLenqNBk/fKT8X
	qm9a/2uUwFDkbSMuBNJtgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795030217; x=
	1795116617; bh=ARz0ZCZgJH/OtGctZQ0ZouLU+xhCS4xli8bXNhXOgNo=; b=u
	dN/zx0ydxqLdCfEndsuYyKaADwW8gUUOU85LumEgH6+5q9QCe0k7mvtrF+Z1APXi
	KNTSslTXPXh/p/4psw00qFJm/R0W55UGT09aCsJ1Jrzd/S/0G2kIkuUxVMRRlBHg
	RYdxo+npMaEu0jxmxei1Z9cWMQHRxizB7/2YTUzuCQXcOJrDltgWcSdytv6frnyq
	g6cq9fDNuROC+K0RN3OuJSiBPm4NZBv8BxjFztOFLax6njAT2qrmigWeCgn5qWgy
	w7AM1TxngfWTn+nBW6JIXuL7m+TRYLUGG/Gi5Nf85Fo4ECDOKVAk3V4IQ1gpLsQW
	WWUgUuS4eT+tjO7FQ8v+w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795030217; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:VyDQOigvAifwhaVxG8LnO+aDosXGc0ePQYhzTzTZWMC59Qd
	MEvdpv0i/pqvOUYFdbphaRmlXzkGlHOB5No5j8DNsErGC8UpJgqC4EjubVZkAUi6
	rv0E/0RGHedeFSQbB22Ea2Tz6kAQ9anWrk149sVil9jxmyL9+whyAVHwvAqvtJCR
	r+jBF2kaqi+O8Tu8vWVZaOAhc9tyCTL3vQMVwsr3nT+8VJApOo7P/0nSwwcfYBUg
	sCsW8CvIi/Zipy4+1fzKqLsTCkEK1dX6uEbTTjRkqkc2anEEGFwAAjb2vBt5inxI
	Kb5B931x80jLjRW+yOMB3ll/jYtmmROaEP0znFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4tpVm2Ts4YzTDSQBdtE/P/nXxl5v4nE9OZTEnOImdWY=:DtQWpTyO1sjNdCp8vFOuKqvYQ6c60cErhz0RZh8+5JI=;
X-ME-Sender: <xms:yfz9ajuPlSpQcf8cco5ZdJ2BQZiXQbylmRpiuXSoWJrTd23AW8rCCg>
    <xme:yfz9arXk7c_UNsmW-JVbUC8FyeRyH9rRiYab8bPKJXW3lAXlX1NzHYiLHeOe4iMlv
    SzHt23ZW9snrHj3Z34ajFIy9YyX2AWdNK5KGDDmJPMfQAYbh4MW55DKOw>
X-ME-Received: <xmr:yfz9avGRs7N8HLVJxypLGzzFGlD20zrdx4-SGQEHV_2MLiktnj70O9m1gUOl517QAJnhyAquO663taSIPuBFugx8>
X-ME-Proxy-Cause: dmFkZTGL7A7nLvMHiCUyTPt7beThl+AjZ6wFidXldNLrI91JAiUacmbv0XsqkYppmeqvjO
    fwqYj/KXiOmL6hYtNAuAPLMaJj77Sh40KUOxIn4+aMOErdyoNjv7b+o7W87tOgYnu0wkrA
    Xw/aFJt90jSG72jYqus+ZePD2F1hyvDVAmjsTnDG458w+svHB4W8kmUIwnCvlR2Fw/GHa5
    oqEUMjypS4L0MQlAflSRZ15aCud6yjtc5bd66g8VMet0A42SUF2/kRb0hLnJ6yh33CQkVg
    qZpWN+hcCrxNT48aoBMp5ecK5+F7nD68q2IzbE3gFBYuuAcA1tbHNBu2siu04KHsjm2ln8
    pPPIQ6Mw8Gx70zgQU4dcb18IwRi8Dm4sj4Hb9Xo+R9JkG8B09Z0gtfW4TuWtFU8bK19KeL
    5FZ8M1FYbhT6DIsNxW+6qtl/qsAp9pQ75fwYmw+4uIdwfVoXDKuzzxO/DkxHHjSvo9o8dc
    1nfUiLUmIMzvUzBxydcGNbOgpMAPx1TsAvz5ElEBKQHNRcXKrtlm8Jt+P3yZ2H38o8QGu2
    3AXZV2S4Et+DqMW5tuoUR4zFvKDz+QpEZMqCwkBZEjDoBdgnv6+yJvGho+5z4r8LrvGLbq
    c/5j1KkQ94O5D+gFcJM48zaQ6zCyjhtP/fr3yFbA8VwJ7HoDGBF8Mplc00Hg
X-ME-Proxy: <xmx:yfz9at3TYObTwcYsOstkXxM1QTa_Z5j-sAeu8ZapffX_MsRUERR4kg>
    <xmx:yfz9ahOAZEAdpZ3YOSuuXdp_fgNy-uC3hbydwq8jS5TZ6jIE_p6DnA>
    <xmx:yfz9as7zW0Xoas-4rmr8PtVUts088qh8hcgE6gJ8FD3zIEVsr_OibQ>
    <xmx:yfz9ar0qU-GH3-O543rpKatusBCygy6RPvUhORAfvhZpa2-Mo0peeg>
    <xmx:yfz9alHMXjs_7aRn6m9oPdFfNDX41RFgHn8u6fbJ9VFzi5AwOzQy_05C>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 14:30:16 -0500 (EST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 14:30:16 -0500
Message-Id: <DMYL3TCBEMAJ.2MW8J9PLG9ZD@fastmail.com>
Cc: <git@vger.kernel.org>, <jltobler@gmail.com>, <ps@pks.im>
Subject: Re: [PATCH v7 1/1] repo: add filtering options to "repo structure"
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>
X-Mailer: aerc 0.21.0
References: <20261015144559.3652143-3-markchucarroll@fastmail.com>
 <20261015170342.39967-1-markchucarroll@fastmail.com>
 <20261015170342.39967-2-markchucarroll@fastmail.com>
 <xmqq33u5c6z6.fsf@gitster.g>
In-Reply-To: <xmqq33u5c6z6.fsf@gitster.g>

On Fri Oct 16, 2026 at 11:59 PM EDT, Junio C Hamano wrote:
> "Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:
>
>>  t/t1901-repo-structure.sh   | 197 ++++++++++++++++++++++++++++++++++++
>
> This test is broken with SHA-256 and in Git 3.0.
>
>> +test_expect_success 'filter by object type' '
>
> This hardcodes many 40 hexdigits constants, like ...
>
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> ...
>> +		objects.blobs.max_size=3D13
>> +		objects.blobs.max_size_oid=3D97d808e45116bf02103490294d3d46dad7a2ac62
>
> ... this one, which is very specific to SHA-1.  Existing tests in
> this file (like the one immediately after this one) protects such a
> test with SHA1 prerequisite to avoid breaking in SHA-256
> environment, which is far from ideal but better than leaving it
> broken.  In the longer term, we should strive to get rid of use of
> SHA1 prerequisites, as SHA-256 will be becoming the default in not
> so distant future versions of Git.
>
>>  test_expect_success SHA1 'lines and nul format' '
>>  	test_when_finished "rm -rf repo" &&
>>  	git init repo &&
>
> If you choose to fix them, see recent effort by others for
> inspiration to make sure you can share and reuse most of this test
> between two supported hash functions, e.g. the discussion that lead
> to
>
>   https://lore.kernel.org/git/pull.2252.v4.git.1792012956734.gitgitgadget=
@gmail.com/
>
> but you may choose to punt and just put your broken test under SHA1
> prerequisite to sweep the breakage under the rug just like other
> existing tests in this file.

Sorry for the delay in responding to this; I missed this message.

I think that the best approach for now is to put this under SHA1,
then I'll take on updating all of the tests in this file to get rid=20
ofthe SHA1 prerequisite.

      -Mark

--=20
Mark Craig Chu-Carroll (@MarkChuCarroll at gitlab)
*** Software Tools/Math Geek - Software Engineer at Gitlab
*** Work Email: mcarroll@gitlab.com / markchucarroll@fastmail.com
*** Personal Blog: http://goodmath.org/blog / Personal email: markcc@gmail.=
com

