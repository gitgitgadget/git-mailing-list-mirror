Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A587247A4C
	for <git@vger.kernel.org>; Sun, 12 May 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715534240; cv=none; b=jLOFHVZLym30+cH7Jf2WWklD8BomknuPMAQ699iKsPA9Golu6rQ/nP+16En/h8kQv9m6facGuanR2WWnm0dtiPY0OAaWQl/7PzcXbfvjzw9E/ao6FoWj4OCjoRQQ+zpInv1EeHyQG9sdLCsCkDdYLefcFgtEfiSr5hroImapPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715534240; c=relaxed/simple;
	bh=rbqnzwUOKcSfuCVozwvlkYynvAFR4ivTcYhflDw30y0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNGu2kLKE815qucr9L2H0BSTIJVPZNOvb1o6ujDs7BC2TIoeBPeuouJ259g7VVIRlnl6dFJbhKRaK5Z/GFLv8anemZaE8i1FXXR1XIuDHDHSbr0ZZz/MoLQ4wZHobxSO5tSXt7HoHXZW3aVYowpMCGfSIgO841uOAVIryz3TuUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpBGS/R/; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpBGS/R/"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6eb86b69e65so2214971a34.3
        for <git@vger.kernel.org>; Sun, 12 May 2024 10:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715534238; x=1716139038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IeL5QP7Cbirb2dfbFUfb9qXyvr65sQTKQ7DXs2uIP7I=;
        b=mpBGS/R/EQD+velSPYODoer9oYvfrtGetmZy413XkUzCH6EwIQRXE3YHTdAmxG35Ae
         9/03jGvuI93q5a3fXAa9VnaX5Ymy4vNffd9o0Jc+QZYSR1Un8KCfnN1AJ1jqqYjzvdxz
         vChJs9Upw/5CEP1PRvi1XqTYPKcnskGGF9dtP1OF7oJzR2fm23rvep+cUyimlhKU9v1G
         w1kZh5iurnz8vs3jXsgPZEQLER9NRWgDx6ZzUF1VduANq5ULsMUgbPjpqT5sDUKqAqJD
         axA7iqdK2aCxN/s5xX+Gq3EPPwYMmKLN8yOs/FcHoR2seKlLRgHWvayW45Y91GSrwPIB
         BkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715534238; x=1716139038;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeL5QP7Cbirb2dfbFUfb9qXyvr65sQTKQ7DXs2uIP7I=;
        b=Ski4osRydSAGkDKthTNSea+/Y5nFpNURh6x4S97IfiwKSMxbP/L7s68qF71tulPJXL
         vsUZ77zHtfQepfSpIl4ZYvn3bW/KGHYU8itnGYtmu3A374EahQgMbmNGnIkglq3BBW+k
         kn/waL/d/33XQesV3zlhM+TsIGT4urRRoko1bbUwWC0W36fbb7emXj/3OPga+wyWLzoa
         7RuP2ny7amWYqWbAxfQbIKfZNegGw85fWLdjoGJvYLON2QmK43Y+4UCbd7XIdP1X8RIk
         DCgwc8KmW2SuZsU82+qiTrdgzAn8UNgTjDWDhYsBFuor/rBEEArdAstjoAcmMsMQI/PD
         tZJg==
X-Gm-Message-State: AOJu0YzpwGxtOsFA6JhnOJ8Fp50wRuA+3EakP32HWmRmEAhlFf5Xf+A5
	10NxxgYDCtP6Qd9nNNO4RWILFVLVaytfF23yHZPxVz5nde0UAZYwLWWNmSgNDNq8IarmIS8MMo+
	n+3wtSENgDSZmnYORs8AhqqtjS+I=
X-Google-Smtp-Source: AGHT+IG4TQrCgoJWkLS9f9X0Kee5EWf+tShK8SIwzrRQD77Mj1h0kedI0OMRaNEKmn740yLgec3MfxE816W/aCUfBXs=
X-Received: by 2002:a05:6870:d627:b0:23f:6c3d:c789 with SMTP id
 586e51a60fabf-24172bf81eamr11538385fac.30.1715534236149; Sun, 12 May 2024
 10:17:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 12 May 2024 10:17:14 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqy18lpoqg.fsf@gitster.g>
References: <20240507060035.28602-1-knayak@gitlab.com> <20240507125859.132116-1-knayak@gitlab.com>
 <xmqqy18lpoqg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 12 May 2024 10:17:14 -0700
Message-ID: <CAOLa=ZRERwUEbj3nc+SUuiLvwJ+JK7qswxX4P6hbstX4+5vXHw@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] refs: add support for transactional symref updates
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000bf05b0061844f062"

--000000000000bf05b0061844f062
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Changes since v7:
>> * I had rebased v7 on next. I've rebased v8 on master. That's the only difference
>> between the two versions.
>
> I've applied them to the same base as used to queue the previous
> round, which I think is "436d4e5b14 The seventeenth batch".  It went
> without conflicts, and tests fine in isolation.  I'll see if it plays
> well with other topics in 'seen' later in the day but not now.
>
> Thanks.
>
>> Junio, this might cause conflicts when merging, I think you resolved them for
>> v6 and hope its the same now. Let me know if I can help otherwise somehow.
>
> The easiest for both of us would be to do this:
>
>  (1) Build on whatever base you want, and format-patch the series.
>      If you are doing "rebase -i" in-place to update from the
>      previous round, this will reuse the previous base so (2) and
>      (3) may become trivial.
>
>  (2) Find the base of where the last round was queued, something like
>
>      $ mine='kn/ref-transaction-symref'
>      $ git checkout "origin/seen^{/^Merge branch '$mine'}...master"
>

I find the '...' always so confusing, I would say suggesting to use
'git-merge-base' would be much nicer here.

>  (3) Apply your format-patch result.  There are three cases
>
>      (3)-1. Things apply cleanly and tests fine.  Go to (4).
>
>      (3)-2. Things apply cleanly but does not build or test fails,
> 	    or things do not apply cleanly.
>
>      In the latter case, you have textual or semantic conflicts
>      coming from the difference between the old base and the base
>      you used to build in (1).  Identify what caused the breakages
>      (e.g., a topic or two may have merged since the base used by
>      (2) until the base used by (1)).
>
>      Check out the latest 'origin/master' (which may be newer than
>      the base used by (2)), "merge --no-ff" the topics you newly

For my own understanding, even if we use '--ff' the end result should be
the same, but using '--no-ff' would ensure that the changes and
conflicts are isolated to the merge commit, right?

>      depend on in there, and use the result of the merge(s) as the
>      base, rebuild the series and test again.  Run format-patch from
>      the last such merges to the tip of your topic.  If you did
>
>      $ git checkout origin/master
>      $ git merge --no-ff --into kn/ref-transaction-symref fo/obar
>      $ git merge --no-ff --into kn/ref-transaction-symref ba/zqux
>      ... rebuild the topic ...
>

I guess you mean '--into-name' here? I would skip mentioning this since
it doesn't have any real effect and is perhaps confusing.

>      Then you'd just format your topic above these "preparing the
>      ground" merges, e.g.
>
>      $ git format-patch "HEAD^{/^Merge branch 'ba/zqux'}"..HEAD
>
>      Do not forget to write in the cover letter you did this,
>      including the topics you have in your base on top of 'master'.
>      Then go to (4).
>
>  (4) Make a trial merge of your topic into 'next' and 'seen', e.g.
>
>      $ git checkout --detach 'origin/seen' &&
>        git revert -m 1 <the merge of the previous iteration into seen> &&
>        git merge kn/ref-transaction-symref
>
>      The "revert" is needed if the previous iteration of your topic
>      is already in 'seen' (like in this case).  You could choose to
>      rebuild master..origin/seen from scratch while excluding your
>      previous iteration, which may emulate what happens on my end
>      more closely.
>
>      This trial merge may conflict.  It is primarily to see what
>      conflicts _other_ topics may have with your topic.  In other
>      words, you do not have to depend on to make your topic work on
>      'master'.  It may become the job of the other topic owners to
>      resolve conflicts if your topic goes to 'next' before theirs.
>
>      Make a note on what conflict you saw in the cover letter.  You
>      do not necessarily have to resolve them, but it would be a good
>      opportunity to learn what others are doing in an related area.
>
>      $ git checkout --detach 'origin/next' &&
>        git merge kn/ref-transaction-symref
>
>      This is to see what conflicts your topic has with other topics
>      that are already cooking.  This should not conflict if (3)-2
>      prepared a base on top of updated master plus dependent topics
>      taken from 'next'.  Unless the context is severe (one way to
>      tell is try the same trial merge with your old iteration, which
>      may conflict in a similar way), expect that it will be handled
>      on my end (if it gets unmanageable, I'll ask to rebase when I
>      receive your patches).
>
> Something like the above should be added to the SubmittingPatches
> document (or its successor to cover more advanced topics, perhaps).
>
> Thanks.

The rest of this looks good, I'll cleanup add the appropriate syntax,
merge in your patches [1] and send something soon!

[1]: https://lore.kernel.org/all/20240510165526.1412338-1-gitster@pobox.com/#t

--000000000000bf05b0061844f062
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4d8d73d3c4cb09ca_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aQStaZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1pZQy85WGRZY053SUYvcDRLN21rOWRLRE9BYWcragp1Z0haTVFDWEE5
TnZDWGJqQ0hIZktRRkZIYWdXeWtNWjlOTUNldGJDRnh4QjVlZ1kxUzZRZTR0V043SGUxUWRSCnBP
NlFMcVEvbWh1MVBDTEhuUThDZ211MDdTWFltY2dsWWF5WG0xTUVNU1p3WkxrekloZGY2WTYwVDVT
MXc1bXUKa2ZkYzBhWVFGMWpoVitTcy9yT3BFdXFEK2JwMmc2bTg4cXdVNi9jcmN3VzVEaGdZUjA0
QjJDZTc3QXdZNVRWTgpSdTFWOEkzYnBPRy90SmlJUlQvN2lNUWNNeWVZMFlvbUI0cE5HQi9GTG1t
RHVxMmFvNHptVmxLMm51SmJHRmJYCmFKRnZsaFdWdEZzbG5DeWlBbExoUmVZVnA0WVhJVFc2eXdN
Z3hveWlzYlNtSCsrK1RsMEdxemd3TXFIWnlveTgKdThKVnBnY0NQNFV2dVFyRnBiTmh5QTFxSWpM
aVYwbXg5cjRJd3JjTEowRGZZdGNaTS80TVlycUJ6ZWJMNjZXTwoxbjBaUUJ0M3BnMVlsV0g4QS9i
RWNQaGlqVC94dVlCUUg2eDcyY1BCSlBKVDljTXY1eGVvanphN3Bjci8zM0ZSCm5wK2FTU2tSQ2tL
WHN0eC9GOGxnWnBQQlVEM0MvMDdwdWt2ZXR4MD0KPUc3Ny8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bf05b0061844f062--
