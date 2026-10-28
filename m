Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193822;
	b=wNy+nwcemXcCSKCU/BQgtPaw0vHgQPbGtbAV6A2ig5Kj3gM1fmCpqHnzfrA1GNkBHj5N
	 IiHqIvob3tqWX3YNyCdarPOAU4MW2WkgTpdzVTiiSx2cBLjqXIqFn8YfHhXdzlDGTCk6H
	 OOAeaBFwTVhD+IYmBme4WyNlbqrXupNpIso8hcNvB4/Zh4PszWJ3CNwUpS7jxi6uhWbo8
	 /rUDbhqYPh9ZIY72N8JNeSRYKXnjqpwcUog8AHFFreq74WYj1vQYdUT5GqpJH3J7oTRZq
	 Zf04hMrDf0loBFlV8DdVkgkqDfbvYNaf01qIEPH1+VBKOxQyASwrmbuVgPpSeoMaqzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193822;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:Message-ID:Cc:To:References:Subject:From:In-Reply-To:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mPGwXCADI5inWLjsYC1ZO3wCxQAcCH6784loBUuDf+c=;
	b=XKpmo8WW2ZzGhrY92bIwhIWogQf8PeqmuDLK2sRWHbLisUYWh76upL8h6VNUsJQ+duiB
	 g4DBIRJwOIBguEuVxfUJXEptoxA+BVG3SrabiGbyHlOaOhsHvIrd5eAEDV3WZycVDzxfW
	 1Ab0lOgsC9o0O86PWQy0vRNEBQ3VqeK+WYzfmjHW006fL7/suBmpf3ynQ2+aN/M+fknjY
	 KqsZNwLKL8Izs4u7k97UFXobQjAaqJZr9R2BO2SPujEO+8BVSBrj+R8NAONbX/Y8+v/zE
	 A7CpIIYckoqaApreXHGWCG8wmPBFw9Yfoi8fdct5nmgpw5m+w8STnpP2PAIaMIQDQ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=m4gFs6yy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fdITai0k;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3145606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 13:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3145606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=m4gFs6yy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fdITai0k
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 599B37A00DE
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 09:23:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 28 Oct 2026 09:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793193821;
	 x=1793280221; bh=mPGwXCADI5inWLjsYC1ZO3wCxQAcCH6784loBUuDf+c=; b=
	m4gFs6yyjIFdfiktJf+6SN24H6Z13cR+bAn8eN53fGgtKTtz/BBB4BDPVlfKCk57
	8iJqF+IGfb++1QN2Rm70jm3iuBJCfY6iskfSuUnCNuOFvWRBuwD6CZFDrbpVgGZD
	DNiCNHNPivwb3NYqkgz12bLVeByIuva47Sps5L7hTHhRgeC0+TvYroWeswV5azG/
	356XrmW0h7AQkmxLvzJYJkVTERJx/uFhqR+bcmCq7n/EagHO4aqf44SscblM0liX
	NKn6hELKNuoGoC8h3Tk+0C0sG2iw/0NZe+t39tbrwQxGYuSFMCFpQbRlK44+SqFc
	zffW0L+LuYsNRg6ZtBY2+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793193821; x=
	1793280221; bh=mPGwXCADI5inWLjsYC1ZO3wCxQAcCH6784loBUuDf+c=; b=f
	dITai0keCQCMvTu5L49PVBJn+byBG6W5M/1ei2+GQ2zy3Kds5UCXyAUxkgrQEYol
	yMQmatxIMKZI1qOBi0ShEgt6dpqqsQknktAPfmXOZ4aZVNMn/9DZfiWCaKVnTxHU
	yxhKgK63CIQ7Zhte0pgOoVTD5Fhht7h5dYcCHgfYqsA06jH1Dx03GITbMbE0qpty
	aci18drfXAVduX5a2JfzfUug4ITqhhuEggorRGW+Ei8ydM7Jui06XkpsAXTtKPSQ
	C9QvLMgGetVTtssswU/1/ei5UxqF73mCHfmpFt48y7P6eYaAZzIFXg6cpVD2BK+k
	IutCpy1lojjvfsAytGWEQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793193821; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KXZimRhjrHaLCsSPYMWzSF7J28ujHfeWcDDUvw3GoJkrwnt
	9vSCBQWTXvsoe+aB9FkI5BDvL9WW8a0KqST9mBBpAl7xv7PsrikDrSJM1AfjpSR2
	yxxK0LBxEjLz1FvOCsgkx21i1IGETCQ5jDBX84yhnPeoScRMgowj6p5GYjl0AaXd
	Z+VEbcHgcvUIUW95ziuvrvf10AH37oe6HaqkXpktX5CUXAJpvFdq8cUZwE9oND4O
	F2CyP442Cdpy9v7V2cIJ5UbQ2qJ7pJg8/gRzUokvju3v16TfWE+i+ak1kw9wh4ql
	n02cE/rReZTeXVDN8G3NDBjfHGpynrrEggIJScA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XVP/WDhPx4aSuFmAMnLiIgnZU1jDmUR8fUW/WZ/cH/E=:S746xpekDW7tzbwLuTiokAjPG4XxrURF/p0e4e1HDI8=;
X-ME-Sender: <xms:Xffhasgc6PpzpVD9TEwLCarQw4BX6LGUF9baR5Mms_bjdY8eTzApOQ>
    <xme:XffharCQoy89XOsiILSrbmTBeGVpgVkd01JtlEFjjMxn_o_u5oJUZfM3yZO6311Qe
    Fk-D55ByaB_uxTed-x0Pue_h-zh-TJhcvZwlpsGZoIkruFgWwsN2F1o>
X-ME-Received: <xmr:XffhahuxK3Piw9eWVR6mOcUfItpj8AjE-O3JjtTkxJB0UsNOTabBhyFTKFs>
X-ME-Proxy-Cause: dmFkZTFtUtIJ6LSe6fOyfe0q1R8CkgPwK1QvXOz3f5W2VEi9YtF4Q/4BWj4udAkwxEClwS
    kTDo9RH7UiqgiLNZ/7UGAvH/FjK368m73LzQAazMb4ug/H93nOmqAif/z5VE4q5kLkykqF
    h6Nq0/IvStP8QgswzGNARmASr0//j0GmA9vOrCEkcx32c89xRI7sAwHB4IHBAzYCkusAfh
    PlqDUujdFVUhsGMf6vyQBLTRsFrom2GhTpA1O9rAD5cUjWaNIiEzY3mbOs/7Hj6lHli0d2
    ik1RZg/opdZtMk2khUOOYdKGLeF7wChs1XdLK0UF973SpBFMb5Iexwu+suqr8FRu8YmUgx
    uptSYQGtOBk8QSRCltVGUfV7O4HAgmno/05MkTyFJ1mE+VEfrrTB01R0hPCcb3r4jN5Ac4
    WWgDK5F2NjZ/BDYhJtWMkMr4vL8pJjMRPB9J6vy7ZMjNXJQqVdBwkYPMWYqvkJzmf6cuYo
    l2xHD+AlXRSRRNOVNY4FtYRWOZeMkMxgLygHzLJe8VOLnQ5ATBcOjyH6Y2gK5k01Cgn+zV
    VDr6IoDaSc5cy/ZYZGDApAfcw0nWjjsq5XzrDKd2cLkxOpna/aVZ6kOowNHDMBSz8hO2R8
    P+yHssw1SSFtfbO/8q9JqpO7hOPqUTasn4etwWn1C9D711lxwt4jKaPcvmEA
X-ME-Proxy: <xmx:XffhaobzdiEmcXoLvaSBj9iuXCY6AFDp4zeH9cJ53xdS-flHmjaLCg>
    <xmx:XffhasWRvrs01e69mqzBmTqyeMRlOrAUD8uUoGZCTqM_PEvQVFzJJw>
    <xmx:Xffhak76Tvyb3WaIjQyuP-qWYQTvrwNrVMOWrgGoosXXNfl32cW2EQ>
    <xmx:XffhavhZ_6HijBX5316CWKn-VY_VPlSOGDr2J2XuUiPXBjg8nVCuqg>
    <xmx:Xffhav4us6zjpOTxUifspyYYNBbydXLwnoeWvipxAcX-foQ8TXlX4-yO>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 09:23:40 -0400 (EDT)
Date: Wed, 28 Oct 2026 09:23:38 -0400
Message-ID: <637732be5efcc579fa737004ca4132bc@fastmail.com>
Cc: git@vger.kernel.org
To: Patrick Steinhardt <ps@pks.im>
References: <20261026-b4-repo-structure-concern-v2-0-e0df34228dc8@fastmail.com> <20261026-b4-repo-structure-concern-v2-3-e0df34228dc8@fastmail.com> <auC7YzhTbn3q7GPt@pks.im>
Subject: Re: [PATCH v2 3/3] repo: add documentation for level-of-concern.
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
In-Reply-To: <auC7YzhTbn3q7GPt@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


On Tue, 27 Oct 2026 15:55:31 +0100, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Oct 26, 2026 at 01:43:56PM -0400, Mark C. Chu-Carroll wrote:
> > ---
> >  Documentation/config/repo.adoc | 59 ++++++++++++++++++++++++++++++++++++++++++
> >  Documentation/git-repo.adoc    | 27 +++++++++++++++++--
> >  2 files changed, 84 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/config/repo.adoc b/Documentation/config/repo.adoc
> > new file mode 100644
> > index 0000000000..811b099d72
> > --- /dev/null
> > +++ b/Documentation/config/repo.adoc
> > @@ -0,0 +1,59 @@
> > +`repo.concern.commit-count`::
> > +	Sets the value of the concern threshold for commit count.
> > +
> > +`repo.concern.tree-count`::
> > +	Sets the value of the concern threshold for tree count.
> 
> I think this commit can be split and squashed into the other two
> commits:
> 
>   - The change to synopsis and documentation of "--concern" should be
>     squashed into the first commit.
> 
>   - These config values here should be squashed into the second commit.


Yeah, that makes sense. 
(Note, this will appear out of order; original send failed yesterday.)

       -Mark
