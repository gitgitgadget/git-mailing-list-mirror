Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D7321D5AF
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853722; cv=pass; b=X2gKmtMKMlssxZ0q0fBg6VqdYrTliFgfcNpG8ynvnF87d41+/5Abt7kPrUk81nAua/EpVf25dYkc60njQBEiyaAbuIOsoA0v1FATDFa6HlY1ehdpygy3qdpxOl/hRewRuf/0wUFiRp+Iet+r40b9c/tbWEZmrC+FUbF6z2ycSlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853722; c=relaxed/simple;
	bh=WzJ2yVDsX5ZKW6lbuV1YufhhG19ZqJ0XnUkSDDkjM/M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/Vg4iJz0doL2JuUPDh+aEviEmu6qMdkt9UGsMtsWzy3pwrqQ6YOOaWqRxYJ1pC8iGY3DMEk8fWEZieDJKBvGnqusMUw0xeomU00+qeMUAzrkXugZM1HtxSkt50Biuors1K1JU/fhn27QlrAb/qyXfILG2ybTB9AA0H4y/UFL2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUiyFrEh; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUiyFrEh"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5665171836cso5192758e0c.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 05:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771853720; cv=none;
        d=google.com; s=arc-20240605;
        b=e+EtVr3nBSHKOOCPCzE0kO3NORXKWN7Nf9CtY0nQn6L5DscktEZe3tYH0UQ8FGya+Z
         zqJRD5kKfzmWW7QoFXQMcYRCfK6hoFBhoAIuQj6D9S3bPXg6khGEP5KclcDkNDnt4H5J
         eOHQ8++2SJlvyntHbBtZtlNhcVdGmFG5k6ULVBbWklEyzV5Oq2BnxwP40qYjzTmXBCP4
         ocJClZOUQwsdpHifIq1BPwp/CV6ZPCPRnrE60JeO06mLOrAXY20+/xayeKD+oLYzJVsd
         E5UaD+e5ZinP8dR16q1bw89ifsc9EEzz9IKo32XtDozNm+9POhrdWDgHec3za+Ysia9z
         cjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=kFBKaBQNvLXoFj60SQo8pWklmVSu4lxlsSrpFDZGmz8=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=HA7NuG8RwPAhD/g5VQa/ZdCYy+bi3bQO8YGlac3jYC10SgBcdPXaqLg2lt5v2nw92b
         rV7CsjofbXjDfBXos6/uzUF0RhEvdQH2OGbiG630VxrDQogx2eLh86HKSPVF+TrgpPic
         OBZwU3+cN1KTRNfmnAWQV3cWnsx18B3dYKCAc8VJ7gc0izvNsKk12dr8aQIU3qglEhLw
         mIGe9L93oWyy2Flv7CExgh+ivPsS1w+ZBisuDf87EB01b4P/EQE5EGnVTVPf1Ar50KD4
         vwrQm2gJS8+KvOwM6a3ATw9myBrEuy77LuM62Px9b0W0q6KNFVUC2q5o/jSewwExhqgt
         dfAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771853720; x=1772458520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kFBKaBQNvLXoFj60SQo8pWklmVSu4lxlsSrpFDZGmz8=;
        b=GUiyFrEhp07SLETYHmq0QOtryywiOxAlzEFck+ymVah5TkaO9LMizHToXS+bUI/MTS
         eshrg3eIfikZ++y/nsKfkCLdAj/7p1el/f6j5ruKwCeRKjZX3JPM2PiWEquYzC378QvU
         KSIW4MIuA0GIJDyK5JSjtMzzRnQ1xCtU/2e7ixONWNJ97BtJgPXHlY/oUTwSdqkiuay4
         ji6Anvld5OskyZESGYP/T8h55KhtcLr3wlxHe2FS2ZpOp1BoAAcMejWpi1rYvvyiDNBq
         ZxFo6ceeot+fi0Xr2KjxQPbuy0K16IeEDGTBlq4pVtwPSefbs/3Oz7fYd+AM1Ql+QILo
         lL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771853720; x=1772458520;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFBKaBQNvLXoFj60SQo8pWklmVSu4lxlsSrpFDZGmz8=;
        b=i/pjM76mrDCSf7VMh6pgpAjHxLKLhhlbNcaNe+qh+N866gp8f2H15exhxdTVQivgjh
         4Ca5T1UnGb/61Lq+Uvi5LP0/WsmNsPjHUc2riU4j8jmrUeAU9wbLQ4sHScMrzEAhIm/6
         BR5FP04M/0A7d9OgpKdUIW+nyUOxpzbJlthBp99WtBHgKxEPuY/IwP0tp9e1M0Wi02LJ
         nKP/qdaxKhhQh8RNTco2h63istgzD712sOlRfQZySUD8CvxWV9mY/dXZLZXWRsJd6qN9
         zOohO9BcDZ0LiSQDc1z5t1n+X2tO08+3jeJ7cu4zW7ogC7HPjt28M22nSV5JixJXYzRc
         6zWA==
X-Gm-Message-State: AOJu0YzGZDgkLOe7xS/s/SLvNICPmw0MGb0TUXeKI52IkaBrbcg0lgSh
	8Y6WqGjkj4vuvv5YXQm6nDvEpQURTLmiEfhY+lZq/mf7k5rpJysMqje/DFHos5Di1rqRhZBJBD/
	WWSywv9QO9uACk8xGkhWi2rAzp3yRJW9Q8qYT
X-Gm-Gg: AZuq6aImBYQtb9TfLf8JsKdnA6/P9G1oKn7rgmDe6FXQv6M7pJoZuklyxx8mdPpcbWK
	AWfSeyPAyXcvCh/0kZG4hQywKpY3+mbHS1nFH/+pinz004CyrRVvKfQN3/3tmITw6mNXQv6kJh+
	kSYENKGwndWiUkx3dynWqOHq/QmmQhPiaozKyD8lzyw71qzWKAvquk7r1P/dHcmJZNOY/53yO9Z
	FsUFaf2ajR1PreaVSbfsZCwVjLYXzUrLF0tExpLstuzkrb9dqwt3m0IQWeljzatsBvU21BSPe51
	3pNGmLEicmHYCIjxUKLyCbL7mzL+FwhhDl7iGkNajw==
X-Received: by 2002:a05:6122:1d53:b0:563:83b2:ef2d with SMTP id
 71dfb90a1353d-568e4907d0amr4332485e0c.16.1771853720157; Mon, 23 Feb 2026
 05:35:20 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 05:35:19 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 05:35:19 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aZwwchZjnSMTiN0m@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
 <20260220-pks-refs-for-each-unification-v1-11-17170bd99de1@pks.im>
 <CAOLa=ZRXbQEyw5-RvZrXTYMnRQr47=JuiUP3Ps4LGQPspo8gPQ@mail.gmail.com> <aZwwchZjnSMTiN0m@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 05:35:19 -0800
X-Gm-Features: AaiRm53032CstKb8_rjVGAWSBPrKihcbKF4VdFqnXPUp-BBCGF13hGOqfqLTYRE
Message-ID: <CAOLa=ZTduJUmcBeViAg43DL6LcpaSLf6eNHTpriaZ9swo7PoAA@mail.gmail.com>
Subject: Re: [PATCH 11/17] refs: replace `refs_for_each_ref_in()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000095a1b3064b7dd748"

--00000000000095a1b3064b7dd748
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 23, 2026 at 04:11:52AM -0500, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
>> > index 9032cc6327..02703f2fb8 100644
>> > --- a/builtin/rev-parse.c
>> > +++ b/builtin/rev-parse.c
>> > @@ -613,13 +613,18 @@ static int opt_with_value(const char *arg, const char *opt, const char **value)
>> >
>> >  static void handle_ref_opt(const char *pattern, const char *prefix)
>> >  {
>> > -	if (pattern)
>> > +	if (pattern) {
>> >  		refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
>> >  					  show_reference, pattern, prefix,
>> >  					  NULL);
>> > -	else
>> > -		refs_for_each_ref_in(get_main_ref_store(the_repository),
>> > -				     prefix, show_reference, NULL);
>> > +	} else {
>> > +		struct refs_for_each_ref_options opts = {
>> > +			.prefix = prefix,
>> > +			.trim_prefix = strlen(prefix),
>>
>> Tangent: I wonder if it makes sense to make `trim_prefix` a bool and
>> then internally trim strlen(prefix). Is there a usecase where
>> `.trim_prefix != strlen(prefix)`?
>
> I don't think there is right now, and I cannot think about any myself.
> How about we leave this as a #leftoverbit though?
>
> Patrick

Sure!

--00000000000095a1b3064b7dd748
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 78dac1ca8eafdfdf_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tY1Y1VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdy94Qy85c0VJcmNxbEFaTFRVYnJXVThFWXlxaU1HVwp2WXFqbUc2R1JD
NmkrOUkxNzJJS0J4MDdocTFGREFsNXhtOHJlUjJiejdBN0RZMU1PbUlHWGVTRWUzK0xPUksrCmZs
MHdLd3h4blloRkRZMkJvZXNWVldjZ1c0Ny9yZFNzbDM3SzNzbFFiakxkQmxLTElab3dVc08vUUJ0
azBrYjYKVktPa3U5ZGJOVUhLcmhWRCtHdUNnSjBuY3hYZGR4eDk2Y2hKQXZGNXFwVjZ4ekVGWXY4
enN0anRFbUdNczJNSwpnMGI0RnQweThhTVZ0YXdHczY2eEIvd3pTOThXenpXaG9wWExHMC81R1Fs
UEhFYXl6UU1xOUtmbG8vTnhFQWRKCmpZYXl1dVFtSlpSSWVFL3BHWjRJQmVmYit0ZjRuYjdpcWc0
Zm5SN0lXWE5IRDhicFBPRlJrL0RxWG41QVk2d04KL1Q5YXhwWGtKbHdUakkvVnVxZjM1TzJJdC84
V0pudmk2d3laaE1GNmNCQ3JxZWc1Tm9EcnVka2xKWlloSWU0dwo1WHp1bHNZcDNKMjQ3MDVCQXVG
bGtZLzh5c21JemRXV0hPUEpwUDdwWGhsZzA2eXU2TXk4MUdVNW9GaTlDNk5FClBiYUd2ZnhQVmFT
Y2VQR1U5T1BibmR3a01LSkR5QXBrakI3NmNDYz0KPTdhR3MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000095a1b3064b7dd748--
