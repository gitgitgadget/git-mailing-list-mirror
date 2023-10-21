Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04912362
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 00:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tuFYKkMk"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E3BD6E
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 17:22:22 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DE2529A52;
	Fri, 20 Oct 2023 20:22:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZA+PAAd6sCpJH09HykzKE4g9I5x+5oM9mDf+90
	GT/XU=; b=tuFYKkMkDv3pPTPx8SNW/dEusxJW6689jVlPQf4r5rEG0q7Xn/RPX3
	13RkQVyF96bQaiXb3HxxXVk5wH4e6YcIimftkemFcUr8N0TDZOGgLMH+xvBP1NqE
	xuWrBF1Yn7yOSK5WuCmdwtpWQbNdJN14lbSqRnaEYCaxvMAHGYlbY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 252D629A51;
	Fri, 20 Oct 2023 20:22:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B8F8429A4E;
	Fri, 20 Oct 2023 20:22:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood123@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Charvi Mendiratta <charvi077@gmail.com>
Subject: Re: [RESEND] git-rebase.txt: rewrite docu for fixup/squash (again)
In-Reply-To: <b5bc179d-46b6-4c48-bfe5-769dac38489b@xiplink.com> (Marc
	Branchaud's message of "Fri, 20 Oct 2023 19:56:09 -0400")
References: <20231020092707.917514-1-oswald.buddenhagen@gmx.de>
	<841c3b59-9e7c-4492-9d66-8af42c3222ea@xiplink.com>
	<xmqq1qdoq3tt.fsf@gitster.g>
	<b5bc179d-46b6-4c48-bfe5-769dac38489b@xiplink.com>
Date: Fri, 20 Oct 2023 17:22:17 -0700
Message-ID: <xmqqsf64omdi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E50794CC-6FA7-11EE-8A64-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Marc Branchaud <marcnarc@xiplink.com> writes:

> I should have added "as a convenience".  Squash and fixup are similar
> enough that it seems reasonable for them to both support -c.  Saves
> people from having to remember that only fixup allows -c.

Yeah, "fixup" could have been a plain "squash" with some option.  It
could have been two options, "-i" ("ignore message of this one") and
"-o" ("use message of this one alone"), and then today's "fixup"
would have been "squash -i", and today's "fixup -c" would have been
"squash -o".

But I agree that "squash -c" is something one may find tempting to
type, after learning "fixup -c".

I forgot to comment on the real contents of your review, by the way.
Everything you said was reasonable.

