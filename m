Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EDD32AAD1
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663610; cv=pass; b=nBbmcqhdZGg4Ee9oPA5FF0GVmky8783c3bZTboAI/486413iiaGjC1ohjNNqV0W41OW6Erij/xqyIZNqXXET3KT/ST+LXWlBLkDJqcMAuLqLR1EDJsNdDW8ujlNRrT7zp52aDIiHL63blfXJhwm0gOtccY64PwfSSl34khWQg6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663610; c=relaxed/simple;
	bh=0HI8J3Tstf1U8Xx2RywqemuXaE7nLTiT6fICBQrtQa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S20WpeGzeKCOpK/KGQauVWYhc/jdMfDWJv43KE/agYPkoKq1wuJJL+dhPK8fF3VPVIqxevv4J45SBK6KoFdm1bqU5RvVc+9ykjouzdmNew1iYCdLtw/HeXUWPEYU3Lb4XA26spw3GR7OFbLTvy5Sxk22J151IRQyYYlw+2l5cjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqcpetQg; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqcpetQg"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d19d3c7208so5614784a34.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 14:33:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772663608; cv=none;
        d=google.com; s=arc-20240605;
        b=H9A01oS37LUVM0e1zto84pcUPHAPvrJJDt6NyVwodKevryIHAkE7PfmaElW3cza+cs
         F3rzWz88u8VKzjpD20mGno9Z8c14LDWGZn6ZaxHda19gz7okoFZV0Ft4aGJPSBGas7d+
         vmlrQm1Twa0trXRcTTPHFDe7DNKEy7cRzf8X58GODlztb1ZRN2UnmgXKwBREBF2es3Z7
         /eR+w5eDLV+aFdq0aglGeuBsivrDNEbrXkhv+p9h1QIhw4my55XVlyUNWAg99TRxxNQj
         j2/dycYkVlGSsgaz9ZWgodCK2iUFP7g94opXcGJo8Pjz9T4vENm+tMvYETateymHDaBh
         q7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7K3EqitUmCLZM39SQyM5aG5LVrKeWRLt1opA7V8DjCM=;
        fh=AHs5cLYEAPP7Y0+AgekVHS/Kr37aZi4o0czZyPEFgYw=;
        b=QjzlDolUS3sj/QU76IacjnG6Vp5OYnv8H9pRhNJ9JbvgzNl12MhsMs1OH2yODR8LcJ
         MlHeJopUoXUEfow/8mWtI2xLceHpNXFJF9f4IXt3ya3RZNd0PTYVjv1SO6Fj2m9Rm6ga
         7/Whx5EQD85+VJozOq3xXdyj0iqg7oylIDLy/qNGcmJHeJYVCEXHKza6QYTvMQ4jqh6S
         50kgyWpALwO3kvlpW11DZgv5vd012et5Iv+KYCbqAttDljy8fB8uCh55/RhAuVGj7hzc
         cullBnKf2dCsBDUXc8LO4Fjk7e1UeTLoWdgAkutopMkkx6BUPytNDQHjzf2aRETq+ko0
         6kyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772663608; x=1773268408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7K3EqitUmCLZM39SQyM5aG5LVrKeWRLt1opA7V8DjCM=;
        b=jqcpetQgkKOlrTIpmELAm37kz7TQN+a3bJrXzC+oxR8V2Vlt9LZGQHzETUQF1j9178
         3NGCehadMEyLAEtpopjt9XaYISwEbim48+YzKrcWE1pBjA+k66t4fzAPI3M11KlmEhru
         7a9MgdO04aRNkZqsfOyYd7DrpiBiFm1ELWMq8AnnnkspBiQwII1Oe5aD1pS6R6232gvQ
         ucLWd4WVErQEgqbvvgk1D20fz3AIStcrvVoUvzD2jBBhbbd6HDB6PdTi0vWUlDsZcm5V
         JCcFp9hyfmmBv998Xc7O9isjKKz6s7cBeG9SlFv9gjhkIRUF9z4n4UUHqjJEhFPCKOBq
         QPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772663608; x=1773268408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7K3EqitUmCLZM39SQyM5aG5LVrKeWRLt1opA7V8DjCM=;
        b=NtuvYQaUf8U8G4JPPdG1JlA0uqvw53eUeVRKnI49ALZbQNjLBdkL5v/mByNei3numf
         zeqspGF7FyVGxYALAy+BImbEZIQO2UOyfZs/E51cPoUMZh0I4PZijFcICDCYh3196hxy
         qnIrEjFK3+8FeMoMRU6t5NBICYDGHP7GQiyNwoGJLFCKi68cTXZ1hfdr2NzMrJ3yvBh1
         xZWPYvR81P5j1Z3eShc1nwSVJcORKHnoEPJEtWJNkSvOoQQuJVe9UC+OuUYjCzGNeLu0
         6kz1IXkZqv7sDkWOqxmt9KNOupdYxdbq0lPnr3e3c3jwOXcXEkV9JE5oB1w82HZSx63Q
         xtSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOcPpnOzK71a0wDSuBfa/GHrvbSGrWbcgU5qE2ZgjKn6acYGZFSIxCniJKTlL0+0IJkH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzody0UlfFHSAgAIELC8qBEVgW7c/KoHII38ago8OC7xwOWbzFA
	IpHY8VWRzqCo+BucCmyZa7phXcC/puU/1rp/VhTQ88GMM0eZR4h7IyHQUWoit7gbP4gDXoHs/5q
	X2Qr4LLvjn2PHArRbTcl2816s3rlHx+o=
X-Gm-Gg: ATEYQzy2gyn5OvHc4CqWD0RBYs5UbqI3sQbyOHxmgGjDHlmzi/ABL9I0KYpUq32G42J
	Vq8hMHyUYeNZxARNoym0kJobeSVae267iJjF3Hq9rcxCD5i9w+1hmGWqhxfpBYvcRUtNl3u8uyx
	Z0cqXiV7fpyCsejxeS9b+SojDWw4RKB7jh1+ptdnMQeFD3d2kSaV7T8DqiR4Z7mzoMMKekhdJPY
	GUfHQQA1LK0D4mTvEJ6Fe5+SYaEJTSgNDgMsS8NZnmi1qFHK3sAEqvtYOndubxLbZ3aSvBKtEKw
	1HhZNZ8Xo+RmrKFdwqwN3J5vpkcUaY2zvNYYP8us5/6bL9SQbC7E
X-Received: by 2002:a05:6830:449e:b0:79c:f9ff:43e with SMTP id
 46e09a7af769-7d6da1fcdf0mr2576116a34.28.1772663607864; Wed, 04 Mar 2026
 14:33:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2061.git.1772651484.gitgitgadget@gmail.com>
 <6e97d88993dbab4070ac0aa999f70564368f47b1.1772651484.git.gitgitgadget@gmail.com>
 <xmqqh5qv74a9.fsf@gitster.g>
In-Reply-To: <xmqqh5qv74a9.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 4 Mar 2026 14:33:15 -0800
X-Gm-Features: AaiRm53hEJCyxmkiq5VKWZhQ9kda0BcbCvJ24vdvVzDVvWOfThSu9vLL_wiqDAQ
Message-ID: <CAC2QwmKh1DFXfDVKDv1xdj7-AqswgEPSDDXcgTn6dLLgQ9ALKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] line-log: fix crash when combined with pickaxe options
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Matthew Hughes <matthewhughes934@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 12:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Michael Montalbo <mmontalbo@gmail.com>
> >
> > queue_diffs() calls diffcore_std() to detect renames so that line-level
> > history can follow files across renames.  When pickaxe options are
> > present on the command line (-G and -S to filter by text pattern,
> > --find-object to filter by object identity), diffcore_std() also runs
> > diffcore_pickaxe(), which may discard diff pairs that are relevant for
> > rename detection.  Losing those pairs breaks rename following.
>
> Shouldn't that be solved not by omitting the necessary call to
> diffcore_std(), but by using the "--pickaxe-all" option?
>

I looked into --pickaxe-all but my understanding is that it
only preserves pairs when at least one pair matches the pattern.
For a pure rename commit with no content change, I believe
-G "pattern" would find zero matches, and even with --pickaxe-all
the entire queue would still get discarded, losing the rename
pair. Just in case I tested this to confirm and it still hits
the same assertion failure. I could be wrong about my
understanding of the intent though.

> > Note that this only fixes the crash.  The -G, -S, and --find-object
> > options still have no effect on -L output because line-log uses its
> > own commit-filtering logic that bypasses the normal pickaxe pipeline.
>
> I do not know exactly what -L really wants to do, but from the look
> at a patch like this, it smells like it is abusing the diffcore
> machinery.  If it wants to follow the rename history for individual
> paths, even if the end-user's top-level command line option included
> pickaxe or other fancy diffcore options, should it be *reusing* the
> diff_options struct, prepared from the end-user request?  Shouldn't
> it rather be using its own diffopt crafted for that rename tracking
> purpose, I have to wonder.
>

Yes I think that makes more sense. I can update v3 to follow the
pattern in blame.c::find_rename(), building a private diff_options
inside queue_diffs().

> Thanks.

Thank you for the review.
