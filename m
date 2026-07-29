Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC348382E
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328469; cv=none; b=McNw3Y6AboCf/6fqILsXCKJ2Fghq9iM2bAVwUBv28xlydotlti97jF9uEeQ6kOrX606ZciGNpzDEMHj5aB9SXbZf0PvUipaScFuOwjqJZNA9GWmkqvEAHHFqMjLcz5zNUjfvwLvBzVFHbWRZ5xOwazh2fqtlUkr1JBJFr9BH2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328469; c=relaxed/simple;
	bh=gBIqRfyzZsC08kN12mRJu+uA+RtkJieGlesPQ+FQ7HY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=qEJBph/BLVVOjbTcXj0zl9XQCbQ+5ygV6V4yZV6NxgQSwrOM80S/Cw8QG5U5gDkbDKVNde5/8v9HfQS4nohBwr+D5rzI2j/suJRSjg81i1y2xK/pUy1/WqoXKd/hvqBEqTuO2Yd6rDHa+hr4Nqpn/DmplqyOKxr9Kp29QjlNtkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7/q85/5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7/q85/5"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4720f3bf164so1344464f8f.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785328459; x=1785933259; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EWaYs7fqKNp7qyM5suhBODB2GblFEIM3DCOGubSAwYo=;
        b=P7/q85/57KzVHxTsNOjqlZpn3FaxBsPaq4LK0ZkQpn+BzI+AwCbCHbltogmxHgpEdy
         0rXNax4v/xRFBHaKDxCxXSEwd7SnGPynVASbP+schRF5EWNIWjiv6J81vi+mbjwSwd+1
         psLrKohKWg4dJKRAy8/Vge/fZJbY6dUIeipp9FpoEZu+/4teKbN3yw575q4WfT+7ARr/
         pk0rKHLXy2FlE20Y3lDMI/M2hs5z9w07SBC3ErnzuIC/rsHxW9y4qtNqylVgbs8eOcS+
         2u7zQhpyQcOV0lvvnUCwU7r4e1f6oGSbN7++agDjVXW1u3D+nPjXxImYIcHDTvHYJLWX
         7I8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785328459; x=1785933259;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EWaYs7fqKNp7qyM5suhBODB2GblFEIM3DCOGubSAwYo=;
        b=BLe/4Ktc/hvPvkY0UgRgKLG/yBXRwjyqgNOO57CiDCUeHXOv45u1P3wzaE9gPFwzdH
         VWfRXBRXhEePFtEGL16KTVJ/prYr3qsWdao2DFJU9sEOV0zWnnFaCYe1U67H54PxIXbS
         Qg9Rws2tqkBFkD8eXEfxnwGRBOyQM/zlljCctUDSWSHjOVXomQ2ikrrQRCzioIVlRGAV
         qXH5losQKMKs+JXUcvls4cWcvdt+m2C0q8VCikwqCJIW29HdOnXmINvsHUy9lBkJllhB
         jRrR6B0yhVOMGeA00uS19tViiI0VW6mcM0HtRx3IiskLygyiV+tX4FS+Y9wtURRzx4pW
         3RnQ==
X-Gm-Message-State: AOJu0Yy85F1xe6QFg/ymLOF3MMiqdor2UMXyBkEAHG40bdHpgJwEkDam
	b05aWCDoFn26XzHBRDSwFRYOJ/TD8RqcnmP3fDrSAmVW93R+D+kIwji2
X-Gm-Gg: AR+sD12rpgazOidlsNaG7y+531iNqfN8tQMNdLHekwxKcA1UVbMg6ou8ZySMZ9PP/Ar
	Zc4aodWsIRtbJsOCxPufzHaj4Xu7mnK2FE8q6uEfJOhDmGkMzfRZl9ChQsmGndeRMYYN4DZ9kaT
	fT9/zMYuQ+Vb38qJqekr3qhB9Mo9I/6QWF/R3PYRZaeHyj95vaUDUHrLMz36UhwyMmF0lX2yFyt
	tzAek83E6CdKXOzwD+iYcNacScnKD/vKfvQVQt5due0SlMjgI8fe39ug4GvjfkDMC2j9qJD83Dd
	zLvBV3E83C1Ut9XdJ+yFGfjqvSM8DIJVLPhiZNUsbCJjMDUYCHpCKhiVKy3KKvacyivGxHbL9a/
	KwiGSzJtWPVUEvR9eBuX+Fd7uKMc784iLzPRMtUaUcfUfLQo/sVSkKMmA60TC0N5O8pu3/jiZNS
	lKQ189XSYTyWEX1sDvgBuPMdpsKHWtM+su1TxUkbnBaoFf2PZcF/e20r1BrBgBrV8FynDen4xLK
	yJ8hPtZKopGehXvg+xOO15K5pCQYn7ES6f3y19KeHVYofnTBza8N185p2gTrhbCPI6qH3QQ7KJP
	zvakaQLtmmw/ibDkHZoQU036JCIHaI9LI3bYgml/x5d/6MOMs0gskcWwCm35OPEPh+bXG5jwme7
	9EYjlniJ0O20=
X-Received: by 2002:a05:6000:2c05:b0:47f:9763:9864 with SMTP id ffacd0b85a97d-47fbabee850mr2690513f8f.19.1785328459221;
        Wed, 29 Jul 2026 05:34:19 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3a88sm6984066f8f.6.2026.07.29.05.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 05:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 14:34:17 +0200
Message-Id: <DKB24AZJXEMW.1X3CA3AGA1GAE@gmail.com>
Subject: Re: [PATCH GSoC 0/5] cat-file: extend remote-object-info to support
 %(objecttype)
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Chandra Pratap" <chandrapratap3519@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>, <karthik.188@gmail.com>, <gitster@pobox.com>
X-Mailer: aerc 0.21.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
 <CA+J6zkSvwqy4QdL16oQ_W=Noi81i-dLtAdAQqU3u9A1mQV3izQ@mail.gmail.com>
In-Reply-To: <CA+J6zkSvwqy4QdL16oQ_W=Noi81i-dLtAdAQqU3u9A1mQV3izQ@mail.gmail.com>

On Wed Jul 29, 2026 at 11:52 AM CEST, Chandra Pratap wrote:
> On Sat, 25 Jul 2026 at 17:25, Pablo Sabater <pabloosabaterr@gmail.com> wr=
ote:
>>
>> "%(objecttype)" is already known by the client's allow-list, but neither
>> the client nor the server knows how to handle type. This series continue=
s
>> the work for git cat-file --batch-command extending remote-object-info
>> to support "%(objecttype)" end to end. It is based on its predecessor
>> series "cat-file: add remote-object-info to batch-command" [1].
>>
>> Type is the last property that is identical on the server and on the
>> client once fetched.
>>
>> Whether to support more metadata such as:
>>
>> - objectsize:disk
>> - deltabase
>> - objectmode (needs context)
>>
>> should be discussed, unlike size and type, the rest depend on how things
>> are packed on the server and on what the client already has, so they
>> cannot reliably match local once fetched. IMO they are not worth
>> supporting, I can't find a use case for them.
>
> Makes sense to me. The metadata you listed depends on the local packfile
> storage where the repository lives.
>
> `objectmode` depends on the tree pointing to the blob, so it wouldn't be
> accessible using the current infrastructure anyway.

Yup, sounds like this will be it (for now) for remote-object-info placehold=
ers.

>
>> Adding new placeholders has become trivial.
>> To add a new placeholder, follow the steps in this series and add it to
>> the client's allow-list at 'builtin/cat-file.c'.
>>
>> Based-on: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
>>
>> Github CI: https://github.com/pabloosabaterr/git/actions/runs/3015558627=
9
>>
>> [1]: https://lore.kernel.org/git/20260724-ps-eric-work-rebase-v21-0-ba67=
f024fdff@gmail.com/
>>
>> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>> ---
>> Pablo Sabater (5):
>>       protocol-caps: add type support to object-info
>>       fetch-object-info: parse type from server response
>>       fetch-object-info: request all supported options dynamically
>>       serve: advertise type capability
>>       cat-file: unify default format
>
> The current incremental approach is safe and ensures every commit
> compiles and passes tests. However, from a storytelling perspective for
> the reviewers, I believe it's better to do any 'preparatory refactoring' =
before
> starting the new feature.
>
> Patch 3 (dynamically requesting supported options) doesn't actually depen=
d
> on type existing yet. I suggest bumping Patch 3 to be Patch 1 in V2.
> That way, the client is already dynamic and ready, and the feature patche=
s
> can strictly focus on adding type:

True, I'll move patch 3 to be the first, thanks for noticing.

>
> - fetch-object-info: request all supported options dynamically (Current P=
atch 3)
> - protocol-caps: add type support to object-info (Current Patch 1)
> - fetch-object-info: parse type from server response (Current Patch 2)
> - serve: advertise type capability (Current Patch 4)
> - cat-file: unify default format (Current Patch 5)
>
>>  Documentation/git-cat-file.adoc        | 17 +++-----
>>  Documentation/gitprotocol-v2.adoc      | 15 +++++--
>>  builtin/cat-file.c                     |  7 ---
>>  fetch-object-info.c                    | 23 +++++++---
>>  protocol-caps.c                        | 21 +++++++--
>>  serve.c                                |  4 +-
>>  t/t1017-cat-file-remote-object-info.sh | 80 +++++++++++++--------------=
-------
>>  t/t5701-git-serve.sh                   | 27 ++++++++++++
>>  8 files changed, 113 insertions(+), 81 deletions(-)
>
> This series is definitely a lot smaller than I thought it would be. Looks=
 like
> most of the heavy lifting was already done with the previous series.

Yes I also got surprised by how little I had to do in order to make this
series happen (I expected a lot more) but it turned out to be very brief.

>
> Good for us!

Yay! :)

