Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89383161304
	for <git@vger.kernel.org>; Thu,  2 May 2024 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714676478; cv=none; b=jDsbAqTl2dPV4zUBeS2yRXf5VYDDpjCUFV40GTrPYriwUZg7eOkoqAaGU/sofrq/kz3HlBKS9caZ0HPPKJ3jGpxhqAieyrkXegOp2xEI/UylTXT67Msm2r6XuoAF+3H9bUoR/6SuNq5xjqOUmPUm8O9+3kbsLD+1VgGnmLAJUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714676478; c=relaxed/simple;
	bh=0xvpzPgxFLV9KerRl33nPacTWJc7dgbmS29+NzKjwRM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tr42kHLrOtr7uuhz0LqiDCbm8ABFRP4JnpvTPNtiIB0J6fQ47bYHkXRa29QHlsLr7MXBjhFYaOUlQEppXZGutj9Xgj0yn+RP5SLPmfnRmS86uetuPQiB5FyI7bhHTuBlM8vc/2uVw2F9a0WZveZW27mWeZ0+JP03LjwyeokmNPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiN9/KHh; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiN9/KHh"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-23df05526a5so467780fac.3
        for <git@vger.kernel.org>; Thu, 02 May 2024 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714676476; x=1715281276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BadlGReeA9/m7G5mlanAY7BlLA3LPBGICU8MQyZYqf8=;
        b=KiN9/KHh5OBHj/rTUMYwteu6Vuxu8iqLLZ+2A+EWqzgrnCpWOth/ig9ytKrVFmL1hb
         FPAuHPizmaobbxXWDi9P7+b7sAZLDHTiKbMQ2uqURcTwb80WO9hmqrb7NijCb53r5gBD
         b5X75PMpefBRQJd0rRMPnM6FZmBslah0fTEobRoOtFfG3GS1LNgLdF7nT42+0RUYZw+W
         OBLEZKQAoUcD3g9OeZZt3siJQUtDB1zcbQbYmX9LdMDO2wFoXshAt5fwPkEtd7d4uDz8
         Ig8v/g+AowI/CUsc0dRmbVBlNfXkN7nGEQ7OK8/1kNh4eG+ud/rbGfCbAeGN2g4CJRAl
         BFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714676476; x=1715281276;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BadlGReeA9/m7G5mlanAY7BlLA3LPBGICU8MQyZYqf8=;
        b=UtMNYkz01EihjNjWBACy19kmBBapZlXvWk95EYpF5m8xELc5ImWQC2wzd0FQETXFQF
         YEBpAeCWxD6LIMViVdeoDBW4yi/0e7z/2BHQOEdv8KJPzNIl0s/9eOA8S3zO74jwqFQF
         APARdKCm2fR4Hl1u72yz8PyAfypJRoEfJKbWyKY1jeXKyjAhZs7+q3CrsJZL2cFY+7gA
         eaeuyRG2FrL0WFQy7JcDebVQC2Udqp5SkMXufGjIv5VoEk9faEBjC2BXoPJLDBq+nCA8
         vqcglmZf1oGFuXUMtCWp5ffL7Z2+8Ak7TJOUphe6S7KKnaAz6X7k0bu1qi3E+oHgug0n
         gMYw==
X-Forwarded-Encrypted: i=1; AJvYcCWiZhdU4C0kuKnPxQqLo/B6u1S7FGae9J+Hi2HT4eUl4hg+vIZ5sdfqNNu/m6E1piqSX3oD1K2f0Km2+PYNq/HqkFgF
X-Gm-Message-State: AOJu0YwS+dqwfB7+QVCoOHmj9p9ANve+Juqc6V5xEdI75TuEa/XqljVw
	31Q6dDg+unyGMksRC3TbzG2ARvpQvfEn5o9P6YzSIDvf7A3ei2ztoDoDju3WmhN2QYoLTiQmMS+
	C+SuEtFCg7TTWLk4ssXeaftJHKHs=
X-Google-Smtp-Source: AGHT+IEKt4oI1TRZeCssSf/oAp14bRZwoJyTX36adwT0QgPzoWXt2DOHgq9XS3ZTC8nawcgXOflzt4Ym1Sl/7RogOWE=
X-Received: by 2002:a05:6871:5b06:b0:23c:5f20:83a2 with SMTP id
 op6-20020a0568715b0600b0023c5f2083a2mr929392oac.14.1714676476519; Thu, 02 May
 2024 12:01:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 May 2024 12:01:15 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZjPTlrMdpI+jXxyW@nand.local>
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
 <20240501220030.GA1442509@coredump.intra.peff.net> <ZjLfcCxjLq4o7hpw@nand.local>
 <ZjPOd83r+tkmsv3o@nand.local> <xmqqfrv0ds7f.fsf@gitster.g> <ZjPTlrMdpI+jXxyW@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 2 May 2024 12:01:15 -0700
Message-ID: <CAOLa=ZRe6eWJ_ZyH+HRq=6Lh0-xZ=1X2Z2f3HW4+EVXNquaDTQ@mail.gmail.com>
Subject: Re: using tree as attribute source is slow, was Re: Help troubleshoot
 performance regression cloning with depth: git 2.44 vs git 2.42
To: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Dhruva Krishnamurthy <dhruvakm@gmail.com>, John Cai <johncai86@gmail.com>, 
	git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000049cde606177d3a48"

--00000000000049cde606177d3a48
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, May 02, 2024 at 10:44:20AM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > Instead, this patch changes the behavior to only fallback to "HEAD" in
>> > bare repositories from check-attr, but leaves pack-objects, archive, and
>> > all other builtins alone.
>>
>> I thought the whole point of the exercise was to allow server-side
>> (which typically is bare and cannot use anything from the working
>> tree) to pay attention to the attributes.  This patch rips that out
>> and piles even more new and unproven code on top?  I am not sure.
>
> I thought the point of John's patch was to allow just check-attr to read
> from HEAD^{tree} in bare repositories, and not to touch other commands.
>
> I could be misunderstanding the original intent of John's patch (the
> commit message there isn't clear whether the change was intended to
> target just check-attr or all of Git). But my hope is that it was the
> former, which this patch preserves.
>

From the series [1] it becomes more clear that the intention was to
target all commands.

[1]: https://lore.kernel.org/git/pull.1577.v5.git.git.1697218770.gitgitgadget@gmail.com/

> I do not know whether servers should in general be trusting
> user-provided attributes for things like "delta".
>
> Thanks,
> Taylor

--00000000000049cde606177d3a48
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bf33340a378afb27_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZejR2a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMXphREFDVzRzdEsvV2hoRG04NVNHQTFGUnIwRDBYTAo3Ty9MT21pNFMz
T2FDSzcxdTlrZk9hWE1scXVaRUVpNjAzRXhJeUkyRUs3R3pKbkkxOXV0TFVoSmozNm03NFVoCmcw
bjltWnJOdDNPSzNyOUt6TWk5T29DRlp0akVOWTNkWXpWMUFOcXNOSVNFQjZJSzZLL3Q0ZGZ3K2hS
dkJ4UTQKY0NMMWxPNVJTTTZja1N0S1JBbFFzN0p6b1hhZ1BZdjRKWEI5RXNhVi85cDNicXdqSkty
WnlDOVgzS2s0ZGc2TgpCMU9vdHZLZFdMSis2TXZvKzZxdHpVRGVKdWV6a1ZuR3dVTCtJaWlYaDdr
UEt5WERDMDlENStjNHcyQnovS1pRCjFQNG9JTC9oWUdZZ2NaTHdNWE9RLzNlVGJvZlZCcXp3QzJI
VGo4M1ZRbG9wQ2FIU250d3R2SlZWREJyeXc0akEKTmhvb1FnVXRTeGtYR1RpTVo4a1FDNnlnMVpF
dDRDcGkydjE2WjY0ZE5yaXYzaHVOSkZZTlFycUViNXUwaE9sbgprWWQ4YlExdDlZUGRYb3I0NnVJ
RVZxT3N6MHBkZENEemJVd0lnT0ZCN3F3dXVPRkUxczJSVVRESDBtbllhV1dsCmk1UG9CUGNXU3l0
NFVPUldTaTJ6bi84RFF2dll1eDhVR0ZiWmROMD0KPVhMenUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000049cde606177d3a48--
