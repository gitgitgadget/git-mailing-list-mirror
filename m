Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E43446C5
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802973; cv=pass; b=riOA9ETheX5Gd7oe5B12fN6hotCAHF+xXFovEyx1fsaXEO+hrIaIsbI2sihkNC1knCRaaZyHTozZVlPD6HXAIekM0i83btvcgBOG0rG/kCscWGFHUeOg7RR5jy86EJRqQSJZZbhxKvBMMur+mFGxX5whKaAs/hoAOdpWKsqdINY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802973; c=relaxed/simple;
	bh=NWb4urnrHy6zCdIrHUOc0Nav5UeHsG3yZ6q3lSXp+Sk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LMJAHIjiavEZMru0jPP+32tq3UMFNf2y3Femb/giq7rHHXQiSV05KUbx5VseSbpyLhE0uqyT0h0isJZa7ek1KotMBjCm9EQbG5P3EhfpclsukczoN/EcD3pMqVAPesgBvQz43+NO0Wxdx5lpnNVIqaME+Vi4ONJafddxNoXBs0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=UKyYCacX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="UKyYCacX"
ARC-Seal: i=1; a=rsa-sha256; t=1762802960; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BWNIX8A0Hx9TC5z1IEf0ZCWBuSWV5XCO0KsKw2a+8WID2paMq1TfbScimDLauTGUt2S4fmbR2EV2l+tqrGVvmDQ67oFh4h8ll3TnpC56dTCEnVjDE/VGrlFj9xvfellnMVa0LW1s1rqdaITk6hJxQzkpo4bAxJwNg51QyxfPURE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762802960; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=plrOywCythsLbmW8Egx5kdY4AdYwSwDiQMXHmfSWTSA=; 
	b=itLYJNKhohVfXeiFJGmhooEodlKwxOmrbeKKlAfhJx2DGNa3QZDahzQxkv6kyrz84UQr/z8CztWr4/4IhL58Ivi1o7eFONoYBVMqmy8wXyuzfZCkjssxO9jOzuWQdnugvZEIZojX1jKwqg2E/3BHTdp9OhMCKOUzyLr4v9v+O1M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762802960;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=plrOywCythsLbmW8Egx5kdY4AdYwSwDiQMXHmfSWTSA=;
	b=UKyYCacXrYb4Ii1L2h7TQQVru9kz/n7EKqfAdAw69Rl5hHQSa77P23xOHf/gOo5s
	1iwdFRzBR6hiH+zTt8UhrlOTR0dyQP5AwEnjp3v8EvrMbBiq9Aqy0ZpNg4j8sPfL+YK
	+I/H1M8hC5uRcofn1Agl2Xd7jjYISl9T3CauA3p8=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1762802959168826.9111192134051; Mon, 10 Nov 2025 11:29:19 -0800 (PST)
Date: Tue, 11 Nov 2025 03:29:19 +0800
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>
Cc: "Junio C Hamano" <gitster@pobox.com>, "git" <git@vger.kernel.org>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-ID: <19a6f3e8332.46772ad5543363.4456434926857828677@linux.beauty>
In-Reply-To: <f5152523-f7ff-4dee-a685-fb0b74cd6a56@gmail.com>
References: <20251105142944.73061-1-me@linux.beauty>
 <20251105142944.73061-2-me@linux.beauty> <xmqq1pmcmn7s.fsf@gitster.g> <f5152523-f7ff-4dee-a685-fb0b74cd6a56@gmail.com>
Subject: Re: [PATCH v6 1/4] interpret-trailers: factor out buffer-based
 processing to process_trailers()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Phillip,


 ---- On Tue, 11 Nov 2025 00:27:38 +0800  Phillip Wood <phillip.wood123@gma=
il.com> wrote ---=20
 > On 05/11/2025 16:57, Junio C Hamano wrote:
 > > Li Chen <me@linux.beauty> writes:
 > >=20
 > >> From: Li Chen <chenl311@chinatelecom.cn>
 > >>
 > >> Extracted trailer processing into a helper that accumulates output in
 > >> a strbuf before writing.
 > >>
 > >> Updated interpret_trailers() to reuse the helper, buffer output, and
 > >> clean up both input and output buffers after writing.
 > >=20
 > > Imperative?
 > >=20
 > >>
 > >> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 > >> ---
 > >>   builtin/interpret-trailers.c | 51 ++++++++++++++++++++-------------=
---
 > >>   1 file changed, 29 insertions(+), 22 deletions(-)
 > >>
 > >> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailer=
s.c
 > >> index 41b0750e5a..4c90580fff 100644
 > >> --- a/builtin/interpret-trailers.c
 > >> +++ b/builtin/interpret-trailers.c
 > >> @@ -136,32 +136,21 @@ static void read_input_file(struct strbuf *sb, =
const char *file)
 > >>       strbuf_complete_line(sb);
 > >>   }
 > >>  =20
 > >> -static void interpret_trailers(const struct process_trailer_options =
*opts,
 > >> -                   struct list_head *new_trailer_head,
 > >> -                   const char *file)
 > >> +static void process_trailers(const struct process_trailer_options *o=
pts,
 > >> +                 struct list_head *new_trailer_head,
 > >> +                 struct strbuf *sb, struct strbuf *out)
 > >=20
 > > So we gained *out strbuf; in the preimage below I see fwrite(),
 > > fprintf(), etc. to outfile that is either stdout or tempfile, but
 > > presumably the output all will be captured in the strbuf instead,
 > > which makes sense.  It is a bit curious what the new paramater sb
 > > is, but this is a file-scope static helper, so it does not strictly
 > > require documenting.  Having a comment would still be nicer, though,
 > > unlike "struct process_trailer_options" that is very limited
 > > purpose, "strbuf" can be used for any string processing, so a good
 > > variable name like "out" that conveys what it is used for by
 > > implication is good, but "sb", which is obvious abbreviation for
 > > "Str Buf", conveys no useful information.
 >=20
 > This patch is based on my suggestion[1]. I had intended to rename "sb"=
=20
 > to "in" but forgot to do so before posting that diff. Here's my signoff=
=20
 > which Li should add before their own
 >=20
 > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

I'm sorry that your signoff is missing; I will add it in the next version.

Regards,

Li=E2=80=8B

