Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501A2112
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 04:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pNgcAgMQ"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E905196
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 20:06:21 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B2B9F1B833;
	Tue,  7 Nov 2023 23:06:20 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SYrKbJsLpKcsvLCo5lLCx+CS6USB9g3VQ1AMWY
	xcgRg=; b=pNgcAgMQA3DCVSY/7Ig/Mi/X7ZofPFKjuquTBeEuhSDOiKWbTX2QNr
	nb+4assI9kjKuw9fHx1ITK7aGuunMlUhtO0pZ8nyR8zlHr722EmlacHYfW19mvU6
	1OwpWl5Le/pKDC/zfm22xfjGS34v3DE23ICt6RhpDS1Q2+sFW07sk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A31A31B832;
	Tue,  7 Nov 2023 23:06:20 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3F35C1B829;
	Tue,  7 Nov 2023 23:06:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Sam James via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Sam James <sam@gentoo.org>
Subject: Re: [PATCH] diff: implement config.diff.renames=copies-harder
In-Reply-To: <CABPp-BEgxKn3QvJQ+6L3Z1RN1im=c3dfApLRCrQqum_Yim44Gw@mail.gmail.com>
	(Elijah Newren's message of "Tue, 7 Nov 2023 19:30:09 -0800")
References: <pull.1606.git.1699010701704.gitgitgadget@gmail.com>
	<CABPp-BEuvjduS4JiORJybKtoPWvJd+BbbR_JAvZdj4Px_v8H4A@mail.gmail.com>
	<xmqq7cmu9s29.fsf@gitster.g>
	<CABPp-BF9iUkF+g_w7wLATFTmjfJ3f1hsBr+zXxNZEcq-XiNOWg@mail.gmail.com>
	<xmqqttpx828i.fsf@gitster.g>
	<CABPp-BEgxKn3QvJQ+6L3Z1RN1im=c3dfApLRCrQqum_Yim44Gw@mail.gmail.com>
Date: Wed, 08 Nov 2023 13:06:15 +0900
Message-ID: <xmqqv8ac7utk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2A6F2FC8-7DEC-11EE-872C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Elijah Newren <newren@gmail.com> writes:

>> > We probably don't want to copy all three of those sentences here, but
>> > I think we need to make sure users can find them, thus my suggestion
>> > to reference the `--find-copies-harder` option to git-diff so that
>> > affected users can get the info they need to choose.
>>
>> "in addition to paths that are different, will look for more copies
>> even in unmodified paths" then?
>
> That's much better.  I still slightly prefer referencing
> `--find-copies-harder` so that there's a link between "copies-harder"
> and `--find-copies-harder`; but this version would also be fine.

Oh, I didn't mean "use this rewrite and do not make any external
reference".  More like "external reference is a good idea and
necessary to help motivated readers, but we should give enough
information inline, and I think this level of details would be
sufficient".

Thanks.
