Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EEA14262C
	for <git@vger.kernel.org>; Mon,  6 May 2024 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994397; cv=none; b=UvNaS0zSgCurlD3rhALqcMC8LmcPdnuW+xm+ufn+ZGswprpeau+4y/Ecr4aGtBqRGtTIIepVbP+Ou5zwbQppmm2xx9oNvBl7mWux4cvLsE5wdMshaMvSDNO6OREGSDfzoHF+9HIBtYX0Ei40jBH85k4o86BtKxWz5zNMfte+Kd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994397; c=relaxed/simple;
	bh=mvPsE6ai8r2PBV8TuFd17XGxhlhxsdUY15nq8gTe/WM=;
	h=From:MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4PxN0jTTjLVgRxhh+2KKwdjRguHPMcn3tDY7tDv7nEosCCqDVZB4PibA0n6oJlMBCVcyYJ9o5+Euzt1qrRIxzKJujvCThfTfRccKb/tDIqBmqd5KAVgrf4ScNfzJpPtN+d/Lg86TKU01KnDHl45FdyW58tuRJYNXnsi+ajEQT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWu98PR/; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWu98PR/"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f0277767fbso506302a34.3
        for <git@vger.kernel.org>; Mon, 06 May 2024 04:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714994395; x=1715599195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=68UrVKcYsvhrWG6VbYAXlNdjGwJEYlCYSpCiMNs940M=;
        b=RWu98PR/fZcvvguzp+QKrkZdSo9UbR40MWwh+wh0a3jwaY9MlyuAK2Y/B5AKFpNOsa
         Bt1BMFtCqgE972iVCU5C//gdOIgaJwH1MkV4eBFLlBO4zZ2ub/gxrT1JxUg9LsOC7KKb
         m9/Poo8zd6zkO7PzsTmYqTUux58Ywxi2onkn2L8UAz2uMRNi2HZgofMaPy7dlVzwerkI
         vqhDIO9Sqr+rFol3DeSog5xoWm8yhQV4As95uEL5R1P4WP/puyOJaTPG4XRiwSj243n1
         aRxvFBBSzejg8jFpq3AN7kMelrvoZ67eSzbEEaH7l2XjCj5LYZSl7aJBOahfqax43mYQ
         cfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714994395; x=1715599195;
        h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68UrVKcYsvhrWG6VbYAXlNdjGwJEYlCYSpCiMNs940M=;
        b=UC8RmKYGsoNFxlVodHPwbWpN+eyUMhUvQ8U7gFFcMmeHBGrH6+ioIG4kZRy3pDtpLV
         2hY8q0REDMGA6RB7666RepzK7/sYRTpvFv97RBo7R15m+Gke7Xj/DktFwgZb8VYWRfmv
         Lf/3FygcCYlbpwwAdM6RFNXP+RC5pzuIwrvqjqy1/jN/OtyF9q0drafU6ag1Phprn9Hz
         oXt9st6vQM1XQhRXMVHhFxzKyRHCdxRudGi2lSMzCGZfSVRHLczXg2abum9YPtLjNja0
         W5iZss/gWP1czN+oh/zQGMUKa+eEBDQryeJgpTDAIupZSpVmDdUarPIofsyQwiFzaoVE
         IqkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqfzaiYY8Sz6kVWqwU+A0kCPUr/n+/TzLKoLCcKWSrPx9MOFiaoyAx5nWD9Eh4RwxfC2NALTNvPJQsa+wAiBRotFra
X-Gm-Message-State: AOJu0YyKcuLX3WOvmKBBR/RRglqw7NmhLPuxMxI6jW0diVraI/mNrd/M
	y0ZzV2M9sJ0HPFlReN/DZ4CWH+7IrATsC1ko1EWuJ5jjM4Bs0O9STmvpXMruA3uaXmSx3OR3DjB
	Rjss3Y2MCl13yzn7CeJHIQu0w9Xs=
X-Google-Smtp-Source: AGHT+IE8toc25/NdMrUFN98DT15VfDd46jOnn4bZpkTyDVLPiyOqxHa+4QCJWvKF8yjjHQ/lAbZvbNIE3Ygp0swryh0=
X-Received: by 2002:a05:6870:1647:b0:23f:3c45:e7f8 with SMTP id
 c7-20020a056870164700b0023f3c45e7f8mr4738228oae.4.1714994395235; Mon, 06 May
 2024 04:19:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 May 2024 14:19:54 +0300
From: Karthik Nayak <karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6e1f09fc-747c-4704-87b5-a7b2ba18d78e@gmail.com>
References: <20240501202229.2695774-1-knayak@gitlab.com> <20240503124115.252413-1-knayak@gitlab.com>
 <20240503124115.252413-5-knayak@gitlab.com> <17c71b18-20b4-4bbd-b52c-c29ef8d3860e@gmail.com>
 <CAOLa=ZR5a0Tj1abM4z4SAVm5cw5+EA0qyoOMs8QH8MoS6eJGiQ@mail.gmail.com>
 <6e1f09fc-747c-4704-87b5-a7b2ba18d78e@gmail.com> Hello Phillip,
Date: Mon, 6 May 2024 14:19:54 +0300
Message-ID: <CAOLa=ZRo00Mty-RFw5sgsckGj=qbgkwaynyqGiEXR5YhuRCMLA@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] refs: add support for transactional symref updates
To: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com, 
	ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000b865b90617c73f12"

--000000000000b865b90617c73f12
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 05/05/2024 17:09, Karthik Nayak wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> On 03/05/2024 13:41, Karthik Nayak wrote:
>>>> --- a/refs/reftable-backend.c
>>>> +++ b/refs/reftable-backend.c
>>>> @@ -938,7 +940,22 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>>>>    		 * individual refs. But the error messages match what the files
>>>>    		 * backend returns, which keeps our tests happy.
>>>>    		 */
>>>> -		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
>>>> +		if (u->old_target) {
>>>> +			if (strcmp(referent.buf, u->old_target)) {
>>>> +				if (!strcmp(referent.buf, ""))
>>>> +					strbuf_addf(err, "verifying symref target: '%s': "
>>>> +						    "reference is missing but expected %s",
>>>> +						    original_update_refname(u),
>>>> +						    u->old_target);
>>>> +				else
>>>> +					strbuf_addf(err, "verifying symref target: '%s': "
>>>> +						    "is at %s but expected %s",
>>>> +						    original_update_refname(u),
>>>> +						    referent.buf, u->old_target);
>>>
>>> The messages in this function differ from the equivalent messages in
>>> check_old_target() from the files backend above. This is potentially
>>> confusing to users, creates more work for translators and makes it hard
>>> to write tests that are independent of the backend. Can we export
>>> check_old_target() so it can be reused here. If not we should reword
>>> these messages to match the other messages all of which talk about not
>>> being able to lock the ref.
>>>
>>
>> This is very intentional, the way the backends work at this point are
>> quite different and while in the files backend, we talk about locking a
>> particular ref.
>
> I agree that the existing messages could be improved - these messages
> are returned when checking the old value of the ref so talking about
> being unable to lock the ref is not helpful as the important information
> is that the old value does not match the expected value. However that is
> not dependent on the backend or on whether the expected value is a
> symref or an oid so it feels a bit random to make these two messages
> different.
>
>> In the reftable backend we do not lock single refs. We
>> lock tables. So keeping it consistent doesn't make sense here.
>
> Where an update is prevented by another process holding a lock I think
> that the granularity of the lock that prevents the ref from being
> updated is not particularly relevant as far as the user is concerned. As
> far as I can see the existing error messages in the reftable backend try
> to be consistent with the messages in the files backend.
>

Well, I agree. But we do have to note, that the files backend always had
`check_old_oid` which has messages along the lines of 'cannot lock ref
...' and now the new `check_old_target` will not be consistent with
those messages. Which is OK, since, like you mentioned, these messages
could be improved.

>> However, we could make the files backend similar to this one, I would be
>> okay doing that.
>
> I would be very happy to see the messages improved for both backends
> when the old value does not match the expected (oid or symref) value. I
> do think we should have consistent error messages in this case that are
> essentially independent of the backend and type of the expected value.
>
> Best Wishes
>
> Phillip

Overall, I think we're reaching the same consensus, i.e. to export this
functionality to a generic function and shared between the both
backends. I will make this change. I think the message used in the
reftable backend along the lines of 'verifying symref target ...' is
verbose yet generic enough, so I'll keep those messages.

Thanks
Karthik

--000000000000b865b90617c73f12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e74906ece9ba7cfb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZNHZOWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDBqQy85TDE2Y3BwdW95UnJienhaQ3BiZlkyanp4cQpKc1BZMHk2Tk9I
bnp2Qk5LcVFEa29pUHdiU1B0SGVMVHRndHRZL0Y5RGowODE1OFRwUjQwUnFOSStWNWxkS2dECjUy
WGNMdWxUM3d1M3dxMjRsOHljbFdHNFcxSnIzVzlpVkIyQUlSQ291Ty9YdkwvUC9ONnUzYk9USllN
SGtsQVkKK1BnM0Q0Q2VqNHVIK3RPNUtxU0lRK05BRE5JemRDTWpqbm0rZkcvcks4czVxNG5OZ0dl
UlptKzV5UkhYRUlGNAoySjVRRDh5VEpDSTdVZk02Wi9pSHE3MjhsZXVWMVA2SURZTytZUUJoaTkr
ZEgyRENNaktpdCtCZ2sydVdtLzk5CkpkdDBJMzI0ZjdRYUh3NVRWbWQyM2I4UnRZQ2RaREh3aUU0
ZkNNTGhnTG41azJHblgvbU11MUVaaDZOQnlFTkIKclZRQURrZzFZZ2t4aytRV2Vhb1BsWXVlMXdU
N1M5M3pFU2tqTXBPcVlQN1lYT1REK3NIWTVxY3prV2kvOC9ZTgpkanBzMVZWQmlyL0kwN2t4TklV
ei9pMm82Z2NkNmNwaFJTd1ZVNm0xcUZFVWprNHhzYm5PaTFNWnZjUHFWZE9hCjdjdzhvTnJ3M2d5
SXlXL3hQb05WeWM3L0ZXSXFYQ0lOZGQyOTlnUT0KPUVlOTMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b865b90617c73f12--
