Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F111A36A
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 00:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sJH2JZE8"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2467AB
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 17:03:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E2F51F906;
	Mon, 30 Oct 2023 20:03:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gDySbFupfaQr
	p+BC0rckvPYyOinlFgxkLtlF7hbhhG0=; b=sJH2JZE8zqXmb0gpMtIqfeTxJk4g
	0LbREDqOK6D7Yb/7NwugrNyqBJZ/tCIYnGunlYQTDipPuoyHF8UUXvXbLVvpGFsK
	ZTQQlwAi8B4oVk+O6jf3r1PCt5MVdoIrC5s9sSYowrxxFJYuaDx71gz8F/tPZlcB
	PJpZbimvTVKZnxY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5727C1F905;
	Mon, 30 Oct 2023 20:03:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA6AC1F8FE;
	Mon, 30 Oct 2023 20:03:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood123@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/1] Object ID support for git merge-file
In-Reply-To: <CABPp-BF6vxU5x5VLGbRhtcTBqDu3x31=vMOd2bimZNg2mkkvuA@mail.gmail.com>
	(Elijah Newren's message of "Mon, 30 Oct 2023 10:15:10 -0700")
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
	<20231030162658.567523-1-sandals@crustytoothpaste.net>
	<CABPp-BF6vxU5x5VLGbRhtcTBqDu3x31=vMOd2bimZNg2mkkvuA@mail.gmail.com>
Date: Tue, 31 Oct 2023 09:03:28 +0900
Message-ID: <xmqqttq78xpr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 EC581FEA-7780-11EE-AAEF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Elijah Newren <newren@gmail.com> writes:

> On Mon, Oct 30, 2023 at 9:27=E2=80=AFAM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>
>> This series introduces an --object-id option to git merge-file such
>> that, instead of reading and writing from files on the system, it read=
s
>> from and writes to the object store using blobs.
>>
>> Changes from v1:
>> * Improve error handling
>> * Re-add `-p` argument for documentation
>>
>> brian m. carlson (1):
>>   merge-file: add an option to process object IDs
>>
>>  Documentation/git-merge-file.txt | 20 +++++++++++
>>  builtin/merge-file.c             | 62 +++++++++++++++++++++++--------=
-
>>  t/t6403-merge-file.sh            | 58 ++++++++++++++++++++++++++++++
>>  3 files changed, 124 insertions(+), 16 deletions(-)
>
> Thanks, this version looks good to me.

Thanks, both.  Will queue.
