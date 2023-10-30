Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7944C61
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XcclVUFu"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0767AB
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 23:56:02 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B3FC1ADD0;
	Mon, 30 Oct 2023 02:56:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kXEYcbGRYk2A
	yIRXVDnyQkfXl+luY8c004V0E2K+70E=; b=XcclVUFukRxpX5gyl3IS3gCS7WSH
	QsF7C6WijVcaKYlbZANywK+uCsRXSKPSSjuox6kpmiInFTkg9dynzCzlkBm+l3ai
	SHnWUJ5c37XoADQzXD2N9x1+Ufrf5ZX6oMzEsGhQtZ5NiVGY6A1kl8Fm3ijmLEHd
	imjHGSL6Lz+lYK8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3547B1ADCF;
	Mon, 30 Oct 2023 02:56:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DAD381ADCC;
	Mon, 30 Oct 2023 02:55:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Alexander Mills <alexander.d.mills@gmail.com>,  git@vger.kernel.org
Subject: Re: please add link / url to remote - when - git push
In-Reply-To: <20231030063633.GA7451@tb-raspi4> ("Torsten =?utf-8?Q?B=C3=B6?=
 =?utf-8?Q?gershausen=22's?=
	message of "Mon, 30 Oct 2023 07:36:33 +0100")
References: <CA+KyZp5mwGJ6YOvjKtfnDMDb9ci3vSq5KNUep6-8EfkHNaxREg@mail.gmail.com>
	<20231030063633.GA7451@tb-raspi4>
Date: Mon, 30 Oct 2023 15:55:56 +0900
Message-ID: <xmqqa5s0egzn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 60D95F40-76F1-11EE-8D88-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On Sun, Oct 29, 2023 at 06:15:35PM -0500, Alexander Mills wrote:
>> When a feature branch is pushed, we get a link in the console to go to
>> remote, however when I push directly to main/master, no such link, eg:
>>
>> ```
>> alex.mills@alex node-be % git push
>> Enumerating objects: 20, done.
>> Counting objects: 100% (20/20), done.
>> Delta compression using up to 12 threads
>> Compressing objects: 100% (10/10), done.
>> Writing objects: 100% (11/11), 1.56 KiB | 799.00 KiB/s, done.
>> Total 11 (delta 7), reused 0 (delta 0), pack-reused 0
>> remote: Resolving deltas: 100% (7/7), completed with 7 local objects.
>> remote: Bypassed rule violations for refs/heads/main:
>> remote:
>> remote: - Changes must be made through a pull request.
>> remote:
>> To github.com:elx-onlinx/beautychat-chatcards.git
>>    ffe1e05..bb7b0ef  main -> main
>> ```
>>
>> Having the link in the console saves me tremendous time and is
>> extremely effective/efficient. Can we get links in the console plz?
>>
>
> If we look very carfully at the log, we see that all the messages prefi=
xed
> with "remote:" come from the remote (git server).
> In your case github. Other "Git repo servers" like gitlab or bitbucket =
have
> the same feature.
>
> Git itself, running on your local computer, does not produce this links=
.
> If you really want to push directly to the main branch and want to see =
the
> a link, then you better talk to the gihub folks.

Thanks for a good suggestion.

Another piece of advice we may want to give is that a good bugreport
should illustrate both good and bad case.  With only the above one,
I couldn't guess that the complaint was about lack of information
that comes over the wire from remote, *exactly* because the report
failed to show the good case that shows the information and made the
readers guess what thing that does not exist in the output is being
complained about.  A good bugreport should not force readers guess.

If the report had both good and bad cases, it would have helped
readers help the reporter much easier.

Thanks.
