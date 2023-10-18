Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7539450DC
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z38qzxQy"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DE3120
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:44:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4878A1C11BF;
	Wed, 18 Oct 2023 14:44:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=b1c7h5OV3MJV
	A4fYkMbR6CDZ1zTn7//Nror3E87hElw=; b=Z38qzxQyD79tHQigFbymPEtf+rTY
	vajUxYONL28YBOl1hITgGAjZg1rFBpxw1u3zW1dtkOEVYNAKLn/218xMSVa5xFVC
	bC1Q+UXkOA2KflsUcCEySobbYBvad1MjQGd9gApW9XIX1ijABWL/KDlXO9pjbrZQ
	aK/+tU9ZD2x+rC4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F2571C11BE;
	Wed, 18 Oct 2023 14:44:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAB561C11BD;
	Wed, 18 Oct 2023 14:44:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Isoken June Ibizugbe <isokenjune@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com
Subject: Re: [Outreachy][PATCH] branch.c: adjust error messages to coding
 guidelines
In-Reply-To: <e08b2ec4-786a-4c18-b7af-0a6a250ae0f0@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Wed, 18 Oct 2023 20:19:33 +0200")
References: <20231018051223.13955-1-isokenjune@gmail.com>
	<e08b2ec4-786a-4c18-b7af-0a6a250ae0f0@gmail.com>
Date: Wed, 18 Oct 2023 11:44:53 -0700
Message-ID: <xmqqv8b3srbu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 6DCD40CC-6DE6-11EE-9BB2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On 18-oct-2023 06:12:22, Isoken June Ibizugbe wrote:
>
>> Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>
>> ---
>>  builtin/branch.c | 66 ++++++++++++++++++++++++-----------------------=
-
>>  1 file changed, 33 insertions(+), 33 deletions(-)
>
> Only builtin/branch.c is touched.
>
> The changes in this patch break some tests, therefore this patch must
> also include the fixes for those tests.

Good point.  I also notice the lack of body in the proposed commit
message.  It should say which part(s) of "coding guidelines" this
change wants to make the code adhere to (maybe later we might change
the guideline, and those who find this commit via "git blame" needs
to understand what exact rule this change was aiming to follow,
before they are confident that the change they plan to make is good).

>> @@ -965,11 +965,11 @@ int cmd_branch(int argc, const char **argv, cons=
t char *prefix)
>>  		const char *start_name =3D argc =3D=3D 2 ? argv[1] : head;
>> =20
>>  		if (filter.kind !=3D FILTER_REFS_BRANCHES)
>> -			die(_("The -a, and -r, options to 'git branch' do not take a branc=
h name.\n"
>> +			die(_("the -a, and -r, options to 'git branch' do not take a branc=
h name\n"
>>  				  "Did you mean to use: -a|-r --list <pattern>?"));
>
> OK.  The initial 'T' is fixed, but as Junio explained [1], the full sto=
p
> must stay.

Thanks for pointing out that it will help mentorship applicants to
learn from reviews the other applicants are receiving, as they tend
to make similar mistakes.

>
> Thanks.
>
>  [1] https://lore.kernel.org/git/xmqqttqxkmaq.fsf@gitster.g/
