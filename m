Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28706347D3
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rEB6sgx6"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF851A6
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 16:34:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 822671C21EF;
	Fri, 27 Oct 2023 19:34:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JWjD3vYy+CwpeJOhPhWWc1WvrA4XZ+Bhllq2d1
	5U1fw=; b=rEB6sgx65JpHguvTdf1gidhWKYYPebxvwa5Km3ciJ8i9grNWcCMBox
	a26WfqCxEudBm0sp3hTEVmBvdtibi+dqKt22rFaXtyU9Hyp1oQ3f9bLcpzCNHqnM
	CaKilLqzbkWZpU7Ao89GqxCyGW9XnLFtk5LlfDtLkidfDY7Bceiv0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 76DAA1C21EE;
	Fri, 27 Oct 2023 19:34:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB3651C21ED;
	Fri, 27 Oct 2023 19:34:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood123@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Christian Couder <christian.couder@gmail.com>,  Charvi Mendiratta
 <charvi077@gmail.com>
Subject: Re: [PATCH v3] git-rebase.txt: rewrite docu for fixup/squash (again)
In-Reply-To: <56e3e974-a027-439f-871d-c7fbae65a04e@xiplink.com> (Marc
	Branchaud's message of "Fri, 27 Oct 2023 09:14:42 -0400")
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
	<20231025102932.1202299-1-oswald.buddenhagen@gmx.de>
	<56e3e974-a027-439f-871d-c7fbae65a04e@xiplink.com>
Date: Sat, 28 Oct 2023 08:34:24 +0900
Message-ID: <xmqqh6mbod1b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5D90086A-7521-11EE-ACB5-25B3960A682E-77302942!pb-smtp2.pobox.com

Marc Branchaud <marcnarc@xiplink.com> writes:

> I do not think this kind of editorializing belongs in the commit's
> message, but this likely isn't the first commit message that expresses
> an opinion.

Thanks for saying this.

> I like the overall phrasing here.
>
> But I think you should remove the "but this should not be relied upon"
> phrase.  This reads as if Git's current behaviour is undefined, which
> most definitely is not true.
>
> Even changing this to something like "but this might change in the
> future" is unhelpful.  Everything in Git is subject to change over a
> long-enough time span, so the same could be said about every aspect of
> Git.
>
> Until the behaviour actually changes, it's perfectly fine for people
> to use multiple "fixup -c" commands.  There's no reason to scare them
> off of it.

And that would simplify the description to make it easier to follow
by readers who are *not* involved in the development process.

>
>> +If the resulting commit message is a concatenation of multiple messages,
>> +an editor is opened allowing you to edit it. This is also the case for a
>> +message obtained via "fixup -c", while using "fixup -C" instead skips
>> +the editor; this is analogous to the behavior of `git commit`.
>> +The author information (including date/timestamp) always comes from
>> +the first commit; this is the case even if "fixup -c/-C" is used,
>> +contrary to what `git commit` does.
>
> This phrasing is much better.
>
> Thanks for putting up with my pedantry!

Thanks for a good review.  I guess the patch is very near the finish
line?

