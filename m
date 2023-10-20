Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4877FC1C
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t2NDk2r8"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933DACA
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:07:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2005E26F78;
	Fri, 20 Oct 2023 13:07:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M79y7uus8le9
	5U2gH76rCgJg90Meb+vrSG7wRKcMtsQ=; b=t2NDk2r81m/pvew9Vd1fD9aNMejd
	Xx69B/FD2tnPf8y1YnJDTrhsrlX6oFOKnXWYhCXsZH5/QKQ3SGoTh9D9bQS4jV7U
	wurzKQIQSTbLwFceqCZC2iJoFkLkDzXoDo2dqqrKv5HedRKF6JdIg7tIV68cFIgm
	abvHiweb998kI9M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 19EBB26F77;
	Fri, 20 Oct 2023 13:07:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 53BFF26F69;
	Fri, 20 Oct 2023 13:06:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: =?utf-8?B?546L5bi45paw?= <wchangxin824@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] typo: fix the typo 'neeed' into 'needed' in the comment
 under merge-ort.c
In-Reply-To: <facb06e0-9ad7-40eb-83e3-0a951931496d@gmail.com> (Bagas Sanjaya's
	message of "Fri, 20 Oct 2023 14:41:17 +0700")
References: <2DB9ED79-FE58-4072-91E0-B4C51A3F6C5B@gmail.com>
	<xmqq5y32zgnk.fsf@gitster.g>
	<42D0A6FD-1314-4977-92E6-BF6535D82E8A@gmail.com>
	<facb06e0-9ad7-40eb-83e3-0a951931496d@gmail.com>
Date: Fri, 20 Oct 2023 10:06:54 -0700
Message-ID: <xmqqfs25rzo1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 12DB0EE8-6F6B-11EE-866C-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 20/10/2023 09:14, =E7=8E=8B=E5=B8=B8=E6=96=B0 wrote:
>> It is my official name. But the email address is not a valid one. Shou=
ld I rewrite the commit message?
>>=20
>
> Please don't top-post, reply inline with appropriate context instead.
>
> Did you mean that you can't receive ML traffic on your @qq.com address?
> If so, resend with your @gmail.com address as patch author (you need
> to set user.name and user.email accordingly).=20

Isn't that opposite from what we would normally recommend, though?

If the true authorship e-mail is in an environment where sending
patches are inconvenient, you would still want to do your commits
under the identity you want to appear in the final history of the
project, so you do not futz with user.name and user.email; you'd
send a message with in-body header that shows an extra From: line
(followed by a blank line) that records the true authorship from an
environment whose sender e-mail address may differ.

E.g.  You would see these fields in the e-mail heeader:

	From: =E7=8E=8B=E5=B8=B8=E6=96=B0 <wchangxin824@gmail.com>
	Subject: [PATCH] merge-ort.c: comment typofix

and your message would begin like so (indented only for illustration
purposes---the real one should be flushed to the left edge of the
page):

	From: =E7=8E=8B=E5=B8=B8=E6=96=B0 <real-email-address-of-mr-wang@do.ma.i=
n>

	There is 'needed' misspelt as 'neeed' in the source file;
	fix it.

	Signed-off-by: =E7=8E=8B=E5=B8=B8=E6=96=B0 <real-email-address-of-mr-wan=
g@do.ma.in>

This feature is designed so that other people, different from the
author of the patch, can relay it to the recipient(s) while
preserving the authorship information.

Although it is not needed in this case, you can override "Subject:"
the same way with an in-body header, like so:

	From: =E7=8E=8B=E5=B8=B8=E6=96=B0 <real-email-address-of-mr-wang@do.ma.i=
n>
	Subject: real title of the patch to be used

	There is 'needed' misspelt as 'neeed' in the source file;
	fix it.

	Signed-off-by: =E7=8E=8B=E5=B8=B8=E6=96=B0 <real-email-address-of-mr-wan=
g@do.ma.in>

and it would replace what we read from the Subject: e-mail header.
