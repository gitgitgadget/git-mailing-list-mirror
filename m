Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733562BE10F
	for <git@vger.kernel.org>; Wed, 21 May 2025 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747861727; cv=none; b=chGofPmpPnsexIi/hooIWlBkx9bEJK23KHEB/I0zeL8UaDElE7KdsR6fsXLI5N2U9KDxVBXFaVfLa8lBdthNNSSrhCPjM9eTDSI/ToQj8dhCMOFewSVqnw9pYAlrUdyuuP0h0RqaBYZVL4lhGwYk9iW8jOz1pgu1BVXuO1wqOf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747861727; c=relaxed/simple;
	bh=0mHJThcCjfgMjqb/IwItH0gWyZZH5gwRKBND0I+cMYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EkvTqW3AQ3LllNvA+D13HPdzxB33Co8/0SgYnI+ckQafOPR4lJ8EEq5Oq9P0qc/9NhY4OrRe+4co8DNKH6qDKdHHme17LqYQ1TPNMpa47wCDDP2+W2BWtuAU44qYmLFxWTEXduOUA4vZBK6NqH5gT5v+jvYMrJBB7siks2+fd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EKRd5rWn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NofBNKj8; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EKRd5rWn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NofBNKj8"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F22211400FE;
	Wed, 21 May 2025 17:08:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 21 May 2025 17:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747861723; x=1747948123; bh=BLe6OYAPqf
	BWLTgb+rkBtdq3WBs3Qex0pTzLqUrrCYs=; b=EKRd5rWnnyiCA9M87Vhd4RfYMV
	tMtQIXrkl2tHJ5b10kRO/J1I97Zudqr0UW//QTHSmrLv6YKtc8UUk2am4AMDBfaY
	ST4jimy0fQMFlgezG2amHc49wrXAEQJM19uDe5L7Gz2+bdiPDtNUhGj6ZGVc86Xo
	1C5iaCP8KjMzsMctcM2ZlPi+yJNZdQbgedS7/fw+vXq3pDVqQ7sb+WHtQJ7vJ/cJ
	YznhWsPy3NsP7hJ1oW36/aiLmVroeC261vwKiyU6jYBeEJ4qbzfUXml+klgAC65T
	ZQ7xLbJIZ76l+Vj5SL79LlWCLQ8La4C6kmLyhtRjy7SnpmOVEE0JGl3pdBDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747861723; x=1747948123; bh=BLe6OYAPqfBWLTgb+rkBtdq3WBs3Qex0pTz
	LqUrrCYs=; b=NofBNKj8vLD3kFwaB1CwfXNnjKW889vKRpJfd7b60tE91ubNAyN
	sp/i7tGE+T/sj2dXspoXoPCyZAQTTrnMx867VZW9xI7xoreU3bHeERo4fa3Xj6UZ
	sDpuZH5aOKB8b7l5Zlslq8GRRXo+7LKqNjH6MjaTzSl0QVKfZ+Hs+B5JIbb0+I3F
	arv7+IjWY8aPfStZf0fHLH3Aup8O5eWzsazUZx7IPJxAUuFgG28JJI9mTWKe6UPq
	q6eB76RjVqOVL8OM4XroeVSjr3xovORgcviguSfhGNvyFDNI7B0KabR+nOoQSR8V
	+7YFaHbyKtxxBeJ2XXajoRqOUNDcUzXqBRw==
X-ME-Sender: <xms:2kAuaL9B8D-f_JpRxyUW6wWuM8A4KxAxUGEtPGTt3V2uYyPpZBKd_Q>
    <xme:2kAuaHu0Z5ovPBuZQ7lMDPy-dwvyn7H0aOcP4fGk7apiTS3b5y2EbNJJflF8DOsJP
    tBFF5MIhdFjffVHxA>
X-ME-Received: <xmr:2kAuaJCyEu3JebIbLZf3hgV5Z3A3TJxR9h-VMqppcOUrbU0nh9Dbr0CdOc_O5x8s0umA4HiFV9pUKe9uy6so882OPWAajy66K4SbOPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeguddvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghi
    nhculdegledmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrh
    homheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtgho
    mheqnecuggftrfgrthhtvghrnhepieeuieffleehudelleeffeehudefveetuefhiedtff
    egudeigeeigfefgeefgefgnecuffhomhgrihhnpehmrghkrdguvghvpdifohhrughprhgv
    shhsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgvrhhnrghnugholhhimhgrsghushhinh
    gvshhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhish
    gtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehsthholhgvvgesghhm
    rghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2kAuaHfTBn9AXA0wAOjpyteBQ2lnS-8pNArOZ7XB9HHTK1E3AcXcvQ>
    <xmx:2kAuaAO43JeYsr3UyEkOk5Kb5Hg8oXaGXAblKF3FsWfZ2fT0QsA45Q>
    <xmx:2kAuaJmn97Ox15mn22rdkDEsrPbgcgkesMceXvfZ2XBZo5lNBka63g>
    <xmx:2kAuaKtjr8JOJSPE1MVlilgSeE7bdBr68Hd4eacNwi8CEFSKPJYApA>
    <xmx:20AuaBSygk4cvK0qeIgyPKZAvzdh888f-cLZ861ieVKuAaxN0LK8ywA3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 17:08:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Fernando Gouveia Lima <fernandolimabusiness@gmail.com>
Cc: git@vger.kernel.org,
    Patrick Steinhardt <ps@pks.im>,
    Christian Couder <chriscool@tuxfamily.org>,
    fernandolimabusiness@gmail.com,  stolee@gmail.com,  peff@peff.net
Subject: Re: [Newcomer PATCH] log-tree.c: Supress Wsign-compare-warning
In-Reply-To: <20250521202409.26879-1-fernandolimabusiness@gmail.com> (Fernando
	Gouveia Lima's message of "Wed, 21 May 2025 17:24:09 -0300")
References: <20250521202409.26879-1-fernandolimabusiness@gmail.com>
Date: Wed, 21 May 2025 14:08:40 -0700
Message-ID: <xmqqsekx8yef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Fernando Gouveia Lima fernandolimabusiness@gmail.com writes:

> @@ -151,7 +151,7 @@ static int add_ref_decoration(const char *refname, const char *referent UNUSED,
>  			      int flags UNUSED,
>  			      void *cb_data)
>  {
> -	int i;
> +	long unsigned int i;
>  	struct object *obj;
>  	enum object_type objtype;
>  	enum decoration_type deco_type = DECORATION_NONE;

The complaint is about this line of code:

	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++) {

where ref_namespace array is of NAMESPACE__COUNT size, which is the
last enum in "enum ref_namespace".  Anybody can tell it is a small
integer (like 9) that would fit comfotably well within the platform
natural "int" on anybody that can run Git.

ARRAY_SIZE() is defined in turns of sizeof(), so its type is "size_t";
it cannot be narrower than "int", but that is immaterial.  Comparing
'i' that counts up from 0 will never cause a problem.

And the compiler ought to know all of the above, or should stay
silent.

The compiler is wrong in this case.  As I already have said on this
list a few times, -Wsign-compare is often garbage and we should not
bend over backwards to butcher perfectly good code only to silence
its false positives.

> @@ -458,7 +458,7 @@ void fmt_output_subject(struct strbuf *filename,
>  	}
>  	strbuf_addf(filename, "%04d-%s", nr, subject);
>  
> -	if (max_len < filename->len)
> +	if (max_len < (int) filename->len)
>  		strbuf_setlen(filename, max_len);

This conversion is wrong, even if your compiler is made silent with
this change.  The function begins like this:

        void fmt_output_subject(struct strbuf *filename,
                                const char *subject,
                                struct rev_info *info)
        {
                const char *suffix = info->patch_suffix;
                int nr = info->nr;
                int start_len = filename->len;
                int max_len = start_len + info->patch_name_max - (strlen(suffix) + 1);

The filename variable is a pointer to a strbuf, whose .len member is
of type size_t, which can be wider than a platform natural "int".
Assigning it to "int start_len" risks overflowing and wrapping
around, and "int max_len" is also wrong.

So casting a large filename->len that would not fit within platform
natural "int" may make your compiler silent when you compare it with
max_len that is also platform natural "int".  But at that point,
what are you comparing with what?  Imagine on a platform with 32-bit
int and when the actual value of filename->len is very very long and
longer than say 3 billion bytes.

In this function, I think a more reasonable thing to do is to
express various length invoved in size_t, and make sure computations
among them does not over/underflow.

	Side note: Those who are maintaining GSoC microproject ideas
	page.  This is the second time in a few days that I had to
	look at a patch that makes the code worse by blindly trying
	to squelch the -Wsign-compare warnings.  Can you please take
	that out of the list of suggested tasks?  Thanks.

Fernando, please do not get discouraged by _our_ code being sloppy
and GSoC microproject ideas page being under-specified.  Neither is
your fault.

And welcome to Git development community.


[Footnote]

Quite honestly, -Wsign-compare is mostly garbage [*] and I wish we
did not add it to the developer settings.  A more effective way to
squelch them is not by sprinkling the casts like this, but to remove
it from config.mak.dev ;-)

https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/
