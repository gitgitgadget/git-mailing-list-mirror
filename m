Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E41F2370
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120144; cv=none; b=iaRj6c/UT523VST9Vo6HuAPLARMw/B9FyY7sGsoibNeL57rPzW9lkvzhea1vrbrHK52ta4Ps79YfidLgcojxHgHx8vUljIWGnIpVcwfzDd7erqNZ3KHXarx6e+DiVS4eAG+KzQtLKbinF3Gu5tymSlZvgcVqZ7ER6iga8ClVmgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120144; c=relaxed/simple;
	bh=FIDoYkuR+pBxX5ytIoky3RCfE/T36i0q71hBuU8+Qb0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mcrqc2qhIW6nLWKbdsnajGFIxwMzh5CZqpuaI3ALgJOB5dybFn+l2D4XftGpy/l+g7AwFZid8+wRxhTSFyE90XP3uDbxiyqH7ayn2wsbFREHiQmLZx7QXRBVy+uDEQ2Gp8QTXqGX1Va99bGePWFf01jRx8Pl5tD50KEJw65xPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSl71yTE; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSl71yTE"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-518ae5060d4so560367e0c.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 12:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734120142; x=1734724942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVpIo1w3dwUiIcTAQZaw/mLTsxu9Yc6ZZPckxuEuKv4=;
        b=BSl71yTEGvjMypyBjv6L3JFHqkNNqbiofkf1S2GQ9Sgav2Cw4bTOtkyWpJhlBR71kb
         0KFxzbBiGAfYSmn9Xk/GEQaqE+/wOu9ssK8WhrOvO26UUwTAzPIiRL0DPGZ+rh3/P32b
         CtqU2dL7dWhXodVB2/8yO0uWJ7AbuLBzXSyfHl6kUvEOmyMZVg/6tDUFQ11PgxhS0m1l
         U6qL9R12Uh9GQgSfiXfRARLY6Jg+o/R2KhR8VAMynR7TGokZgPg661r2EMvSECnGUHP1
         8cfaQcooU/8ITgIKWseXfm+d9r8ngCvggIcwKjHZPrO5UyRJKtTcYCR18qVvlF5q7H1X
         nNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120142; x=1734724942;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVpIo1w3dwUiIcTAQZaw/mLTsxu9Yc6ZZPckxuEuKv4=;
        b=wwN17t2k/k3Iu59STZXmbVu5/MajI1R3ENmXYey3U6po+aHSdnBuKq8ojyU3Y3a1FO
         rpqqOL4jkpPyIEe+RVtYiwrdGOs+7dUXMEoTnF9GRIYv3n/BF8nCxmeEulTo5moc80Co
         DxKzOtllCtwA3NgP2CUv4DDaUUxC0U/FzOfUtRFD6gZ/A5tq2eGcnlZvTldaJqgv9BNO
         x8XYypl+hQ5FXGf77hOdOY7/btlzhXwlm730t9RGYsV2DNDk3aaa5lreX/2VKUx92Vbd
         U1dbqtLgkib3Bs8IaFKWQoteUq1FV01a0ox39/AE1YA3g2oTi0wFob5WJmq95WSeKZmN
         j1Gg==
X-Gm-Message-State: AOJu0YwF5q2pktmz9GCp27r2QncE2RdUp4H6twUceAndFnbCW7wbrHOk
	yrUEsAuLOZ25oGdIBZF9LXha/qND/rw0ikKDMSU/Sjis7Q+eEylO+Tx33wyvdkELlG6T0tRiV2K
	5GzqKybcX1d7z7exBAYKrYSsxkZY=
X-Gm-Gg: ASbGnctZCfJO3RsA2wnUbXtBLhOEGeXNy8RC8MAU5NTd1Ll6ldLPg0UpR4/yWTx8tPZ
	03WYbGI2YFYl8mJBs6xhQYIrpc00ImdbHQUjioIUW/5sRsqkaazyV04FQsDCDCzSumag9zGW4
X-Google-Smtp-Source: AGHT+IHVHtwP8ru6raZYek3Vauwq8TIlgn557e2SvqlF+NIZDWR5iIn/gZ/e0C+GyJEoEtLO7FRXchOwPSaFWcRd5bI=
X-Received: by 2002:a05:6122:2228:b0:518:9dca:f0fb with SMTP id
 71dfb90a1353d-518ca47e2e8mr4237390e0c.11.1734120141669; Fri, 13 Dec 2024
 12:02:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Dec 2024 15:02:21 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Z1wnf54rEq0POCb3@pks.im>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
 <20241213-320-git-refs-migrate-reflogs-v2-7-f28312cdb6c0@gmail.com> <Z1wnf54rEq0POCb3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Dec 2024 15:02:21 -0500
Message-ID: <CAOLa=ZQO9NyuwVPP82wCf6BOGLL7U_aLNX=cxKd7H4=Qc2YX-A@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] refs: allow multiple reflog entries for the same refname
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000000ae91e06292c4f09"

--0000000000000ae91e06292c4f09
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Dec 13, 2024 at 11:36:52AM +0100, Karthik Nayak wrote:
>> The reference transaction only allows a single update for a given
>> reference to avoid conflicts. This, however, isn't an issue for reflogs.
>> There are no conflicts to be resolved in reflogs and when migrating
>> reflogs between backends we'd have multiple reflog entries for the same
>> refname.
>>
>> So allow multiple reflog updates within a single transaction. Also the
>> reflog creation logic isn't exposed to the end user. While this might
>> change in the future, currently, this reduces the scope of issues to
>> think about.
>>
>> In the reftable backend, the writer sorts all updates based on the
>> update_index before writing to the block. When there are multiple
>> reflogs for a given refname, it is essential that the order of the
>> reflogs is maintained. So add the `index` value to the `update_index`.
>> The `index` field is only be set when multiple reflog entries for a
>
> s/only be/only

Thanks.

>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index b2e3ba877de9e59fea5a4d066eb13e60ef22a32b..bec5962debea7b62572d08f6fa8fd38ab4cd8af6 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -1405,7 +1407,19 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
>>  				}
>>
>>  				fill_reftable_log_record(log, &c);
>> -				log->update_index = ts;
>> +
>> +				/*
>> +				 * Updates are sorted by the writer. So updates for the same
>> +				 * refname need to contain different update indices.
>> +				 */
>> +				log->update_index = ts + u->index;
>
> Okay. So instead of tracking things via a map, we now rely on the caller
> to provide the update index. And if they don't provide one then we
> cannot guarantee ordering.
>

Which works, because for reflog migration, the caller _has_ to specify
ordering.

> I guess that's a good solution. After all, there will only be a very
> limited amount of callers in the first place, so I think it's fine to
> shift the responsibility onto them to maintain reflog ordering. They're
> also the only ones who really know about the actual ordering.
>

Exactly. Currently this is entirely and only used in the migration code.
Perhaps we expose reflog addition to users, but that is not something
being pursued.

>> +				/*
>> +				 * Note the max update_index so the limit can be set later on.
>> +				 */
>> +				if (log->update_index > max_update_index)
>> +					max_update_index = log->update_index;
>
> Makes sense, as well.
>
> Patrick

Thanks

--0000000000000ae91e06292c4f09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e2e305559a63e40a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kY2tzc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWpmQy9zSFBoNTlHRXUzOWpqQmNzRm5JS0ZkMHJBdAp1NStTQkVpSjNm
T0ZBd0ZpQyswMjhTOUFlc09KMmVMTTVjVGZDZHNWRzRraUtkZ3RSeTMxVkxVWGVWcWdLZnJLCjJz
cFYxdFR4cDBMeExESS9LYmdGMW9rOWlzTEFud1ZMenY0cUduOGlLY2xobUgvUGpJNUZHMm9uNWgz
VTVEaE4Kd1hNRFB6Y3gwMGhWMHBwdUlZOWZ1MjAvMTV6WjhUeTRkSXZ0a2taNVNYMzk2Z2IzZFpO
SW5qZnlSaTI5S3Y0VQpYRkNxZHVjY3dPQnZJaGlFcjR6Q0k0cldzWVhaaDlLcndEbVZDcFJLNzMv
dmVDZWNLMzVtR3VjOGdKVC9MbFkyCjZUaTg1blZmSlVIRDdiTVNQdmFpQTd4a3FaYzlMclROVzgz
MEdaYzJtL1pML0FwZWZWd0VpeVBRWUJVZkRiNXIKMHhZMUZZRTZKdEcwVlZoYjFId3lrWGRBckVk
UTZKRFNvRGhJWk5HQnRpb3VwL0twYTFMRkVWOVE1eTNray9jeApqTUpKNFJ5REV0dTdLak9VWFln
bHc4aE9YdmRETms3ZDRZeStibUJXVzlSczlhcXZhNkRhM0c4TEV6cTdObFVkClpOSFhOazRMUkRW
eXBsY1ZIVTlzWmJ1NkxXNTMxVUVZS0tiZUNrQT0KPXNXbnIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000ae91e06292c4f09--
