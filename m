Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IDfKxzKj"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F55D83
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 19:42:13 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CBB941E836;
	Wed, 15 Nov 2023 22:42:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OIJMJvTS/AfswLIQ0LTgZZimAnGLI363xUp1kI
	PQq5w=; b=IDfKxzKjJrn6Bq7Vy0Le4dr0Rz/p5n5WEfrsUZ04r23vRasz7eemqC
	DSoUSlbHH1V6HIvTty7e2WgPNSoxSQx8Hij4SQiIfY80JWdgFaQo5rBB9RX6vc3U
	Y9/k+tphwyYHP3gPiinyMhksksWn5FuyXHBhXvwe3/QpjRWnI11Ak=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C4DEB1E835;
	Wed, 15 Nov 2023 22:42:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 674E21E834;
	Wed, 15 Nov 2023 22:42:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Alan Dove <alan.dove@gmail.com>
Subject: Re: Bug: "Received" misspelled in remote message
In-Reply-To: <xmqqmsvetmu3.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	16 Nov 2023 12:10:28 +0900")
References: <4e76dda1009a8365a1d66d9594865a4af31ab418.camel@gmail.com>
	<xmqqmsvetmu3.fsf@gitster.g>
Date: Thu, 16 Nov 2023 12:42:07 +0900
Message-ID: <xmqqil62tldc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1EC30522-8432-11EE-A209-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> "remote: Recieved update on checked-out branch, queueing deployment."
>>
>> "Received" is misspelled. 
>
> I think it is coming from the "push-to-checkout" hook that is
> installed on your "private server", and not from what we ship as
> part of our software offering.

Googling for the misspelled message seems to indicate that it is
coming from cpanel (whatever it is).  A randomly picked example is
https://essgeelabs.com/posts/cpanel-git-1/ which is a recipe that
does not involve typing the typoed message by the end-user, so
somebody (most likely cPanel) must be shipping with a hook with
typo.

Another user of cPanel reports this

https://forums.cpanel.net/threads/git-automatic-deployment-not-working-but-manual-deployment-is.679837/

where they observe post-receive hook with the typo.

Anybody with contact there at cpanel.net may want to report the bug.

Thanks.
