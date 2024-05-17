Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644E3D541
	for <git@vger.kernel.org>; Fri, 17 May 2024 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945626; cv=none; b=WwgAZ3ZmjS/H//PMVme4BwUrkmW86jwFvKmZpNBpqhuorHff7v8MjotCN64z9yDnc3O0K/9qNleHcLKFbs6BmHZZnb77ZTT54oCpzV5WExoy7L7Vp0vde8bgekeN7LKTh4/wia2vbNJbbJIgR87mZQbLsE41Od1RoqrrrF+aXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945626; c=relaxed/simple;
	bh=hwzQmgSqys7ma2uc4n7QebK1ZeGsI8MLxAjJHGJCpQc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Znkvg5lwPtobS1+6wa3z0NOrCzNwi9JwHMClouhqDC7MFD/He3Xp7b0GN3tUw+if5ogJwQUytjPLT5i4Mxq5eph8BU3If60DC8gZQ+HO+v0CU/NrMi8pks+BhuNrNB/JwPvbNQppUO0fAfbDf4fLGhqhtiCAx+RM3Y9FNo0iMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEs0WqeN; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEs0WqeN"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b278131fe3so23055eaf.0
        for <git@vger.kernel.org>; Fri, 17 May 2024 04:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715945623; x=1716550423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u/NtIqKgYWrN8BIazyNHPW+Es9ifBrGD6kKV3cPuTeY=;
        b=OEs0WqeNt+LQZvzfAeqzT6FYuWCR2cgPCS3iVZb7ZfrxQnJu55jjfHtRb0TbLgO+uK
         0btgGouBCgXkdJYvuzpItKzBM5gdJY63+BJxE8gQewIYirxBDDsjCQ0dNGQrcBuso1+2
         ebW/Jr47dC6YEfxhxv3Ro2tIO2jrNh6BiNC5qsAvL0FHB8xcrFrKsLhQIhXEOioKkYXv
         1wk9mAH7RK33WNhuAPWx9p+NphXC2M5fHbxZ9r14GEK146OBdYWAOAutNPQHshwe86I4
         piA+2qARsJifiiIjwk01HiV1Wm6HxCeNOVrbdlhQJb+pgAw8jx470aNMRtwx9eeFYP6R
         TfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715945623; x=1716550423;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/NtIqKgYWrN8BIazyNHPW+Es9ifBrGD6kKV3cPuTeY=;
        b=LgAcy1IDN9oqS8ZPEtDdx3g8c7TeAMUo3UYkoJOi8HnhoI1KKGDj8j9IxTEKqbWWa7
         9Fx+8xmdTbeFvkDeC8IZ54K/hZoXO6qwrpZ/j5zbiyfuWCIf7TqAfEYrPDdusNM0jVrg
         zJ5Nhge+rMHQYlkogxoScfRwSAp3avRhFUUnT6SW/u0TkZiycO6nyO1RfpTiXJIFI5aN
         hXPdvMS2tx24/FGj0LnVnIsip5Z9zlrmcMmB8ZAZj397QpzhYG3cxdTjlNcvw2CR6OG5
         0xdRa7BN2b7l4Svq+AQJve0BYnLJUGLTtARlyTXlU3jagPyT7cB6kxtBKOUzp8arcbfJ
         JpEg==
X-Gm-Message-State: AOJu0Yyk+re8zCpMc+fdfTt12xdZ5rfH9EZqNtJabzvO7DuoHg1xsW8D
	hjxEL5ylcq887Y+F0zSttZu9gGodD8nR3eVx6IkhJB2pwd6O/CodwdUkwP7S5oALybOsIKWf7C4
	QVVTEbNSYkSex5obGyPvYp7aS8ic=
X-Google-Smtp-Source: AGHT+IHhj75t5i3KMA9vc8FkpoEg5hkhdSQUIQX9kpGkO5UVlg5uAt70JtxMgrsIuLvzxzPewQHbO0XTBFgAu0WxdyI=
X-Received: by 2002:a05:6871:a913:b0:23d:b3b9:de0 with SMTP id
 586e51a60fabf-2417198c4e9mr10167845fac.10.1715945623446; Fri, 17 May 2024
 04:33:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 May 2024 11:33:42 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Zkbn9_-cOiapWSSb@tanuki>
References: <20240514123039.1029081-1-knayak@gitlab.com> <Zkbn9_-cOiapWSSb@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 May 2024 11:33:42 +0000
Message-ID: <CAOLa=ZS1bhHAtz59z71sMxOT63jwF0pHYO5YKtY7Lx_V8ubV4A@mail.gmail.com>
Subject: Re: [PATCH] SubmittingPatches: add section for iterating patches
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000005708e90618a4b996"

--0000000000005708e90618a4b996
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, May 14, 2024 at 02:30:39PM +0200, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Add a section to explain how to work around other in-flight patches and
>> how to navigate conflicts which arise as a series is being iterated.
>> This will provide the necessary steps that users can follow to reduce
>
> s/This will/This provides/
>

Thanks, will change!

>> friction with other ongoing topics and also provides guidelines on how
>> the users can also communicate this to the list efficiently.
>>
>> Co-authored-by: Junio C Hamano <gitster@pobox.com>
>> Suggested-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>
>> This came off a discussion wherein I sent a series based on `next`
>> instead of merging in conflicts [1]. This is mostly worded by Junio and
>> I've just put it together into a patch.
>>
>> This is based off master, with 'jc/patch-flow-updates' merged in.
>
> :)
>
>>
>> [1]: https://lore.kernel.org/git/xmqqy18lpoqg.fsf@gitster.g/
>>
>>  Documentation/SubmittingPatches | 79 +++++++++++++++++++++++++++++++++
>>  1 file changed, 79 insertions(+)
>>
>> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
>> index 8332073e27..2fd94dc8de 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -608,6 +608,85 @@ patch, format it as "multipart/signed", not a text/plain message
>>  that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
>>  not a text/plain, it's something else.
>>
>> +=== Handling Conflicts and Iterating Patches
>> +
>> +When revising changes made to your patches, it's important to
>> +acknowledge the possibility of conflicts with other ongoing topics. To
>> +navigate these potential conflicts effectively, follow the recommended
>> +steps outlined below:
>
> Okay. I was first wondering why we only mention conflicts when revising
> changes. But I see there are other parts in the document where we
> already mention the potential for conflicts, so this is fine.
>
>> +. Build on a suitable base branch, see the <<choose-starting-point, section above>>,
>> +and format-patch the series. If you are doing "rebase -i" in-place to
>> +update from the previous round, this will reuse the previous base so
>> +(2) and (3) may become trivial.
>> +
>> +. Find the base of where the last round was queued
>
> It's somewhat unusual for bulleted lists to start with a dot, but this
> is consistent with the remainder of this document.
>

Yeah, that's mostly why I added dots instead of asterisks here.

>
> [snip]
>> +Do not forget to write in the cover letter you did this, including the
>> +topics you have in your base on top of 'master'.  Then go to (4).
>> +
>> +. Make a trial merge of your topic into 'next' and 'seen', e.g.
>> ++
>> +    $ git checkout --detach 'origin/seen' &&
>> +    $ git revert -m 1 <the merge of the previous iteration into seen> &&
>> +    $ git merge kn/ref-transaction-symref
>
> Let's remove the trailing '&&' lines. The leading dollar indicates that
> this is interactive, so you wouldn't concatenate the commands like this.
> Also, preceding code didn't have it.
>

Yeah, agreed, I will remove here and below

>> +The "revert" is needed if the previous iteration of your topic is
>> +already in 'seen' (like in this case).  You could choose to rebuild
>> +master..origin/seen from scratch while excluding your previous
>> +iteration, which may emulate what happens on the maintainers end more
>> +closely.
>> ++
>> +This trial merge may conflict.  It is primarily to see what conflicts
>> +_other_ topics may have with your topic.  In other words, you do not
>> +have to depend on to make your topic work on 'master'.  It may become
>
> I think there's either a word too many or missing  -- depend on what?
>

's/depend on/depend on it/' should do I think.

>> +the job of the other topic owners to resolve conflicts if your topic
>> +goes to 'next' before theirs.
>> ++
>> +Make a note on what conflict you saw in the cover letter.  You do not
>> +necessarily have to resolve them, but it would be a good opportunity to
>> +learn what others are doing in an related area.
>
> s/an/a
>

I think it makes sense to make it 's/an related area/related areas/'.

>> ++
>> +    $ git checkout --detach 'origin/next' &&
>> +    $ git merge kn/ref-transaction-symref
>
> Same comment here regarding the ampersands.
>
> Other than that the additions look good to me, thanks!
>
> Patrick

Thanks for the review. Will send a follow up version!

--0000000000005708e90618a4b996
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d202888e4639fb90_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aSFFKVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLy9RQy9zSHJqVUNlcUp4eXVDb1VDSEpMbFRwaGRwdAp6VzI3SWpqV1V0
M3BkQnpkYXpvSkhLUStnSjluYm1RdFd5UjF6WGpoRU5nRWt5dmI0TzhrUm0rMm1TQURkVFQ2CnF6
NThhQXYvbVNvS3I3eWUxMDZGa0d1QTZPbnRBVHY2T3dBZTkwVVcyZmU2ek5VZWdTU09XTm03cmFV
K1k2Y2wKYStnREVoWDY2S1Y1b2l6K0E0ZzFLV2MzTVNvQUN3ZWJRN1N4R0pxOVROTXRSOUEyMzNS
bW44aGl1RFMraWgybApGaWdjMTQzamM3RU1idnBIT1VDajhTSjBMWHdjL2NNYVJvNjJNRm1Dc1lh
b1hjdk5mZ3VZeUhwaFA3a25ZUmUyCnV2NHp2eEJhdXhpQjkzTFdVKzM1TlhDZHdVeTd3UGF4Yk12
R0pYOHpNaTBjL0VtU2pzVlQycStqS09PaG8xaW8KUlR6Q053eUhTSkJNNmk0aytxdG8wT2RIeGZ6
bXJuVVQ4SDlxdHV4NXAydzVZVFE2dExySEh6QkYvWldaalVlYwpiZVdWd2RmK0owQkNqQzN6SVRL
czR4bzNxK1V6bmxvOGNQeGpqUVMxTHQ0aFB0cHlPamw4UkNuRitiQmFvVzA4Cm4rY3h0QjVGSlpa
aXFsdEVBQnRGVWNyVXFaQ3J5TFZRUlBrMXhSTT0KPWZhU1gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005708e90618a4b996--
