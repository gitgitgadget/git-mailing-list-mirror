Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848D219A8E
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750300220; cv=none; b=TctwQ2qZJworadZ+2cgDLafD0Nfz/GRa7L0pzX7bjvBtPGYne+fEwRBGX8gXLdC45TbdrxwNQdLaLpGN1BZan6NTPEXqB8/hsnS+tT9z5Tx3ETZDTwLekEKl7SgbVzG8Vj7fhC2mn12SDZJFWxLhIQ5hXz/H2UNu92yOWF9NoF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750300220; c=relaxed/simple;
	bh=hvgaCju69S6sfvrT/GZob0gyMqgYGwGUWRjfFI2Avxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uddDVARl8RPZtZbkx6keQZMRWUCEc7c7gdIxa+1PQhWksFuU/SqnQmS/mXAbc9n/gW6DzAWeiFAa4Es0R6YLC5y8xzqWxSM9ksZLGLZeROYI9KmVORkYLQBBzaLNN0E2RWh9RSa14Mv3PR1OuZrc1BlZfKjotclMkumg6rkaGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=connamara.com; spf=none smtp.mailfrom=connamara.com; dkim=pass (2048-bit key) header.d=connamara-com.20230601.gappssmtp.com header.i=@connamara-com.20230601.gappssmtp.com header.b=npUesZ3H; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=connamara.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=connamara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=connamara-com.20230601.gappssmtp.com header.i=@connamara-com.20230601.gappssmtp.com header.b="npUesZ3H"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30f30200b51so3476781fa.3
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 19:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connamara-com.20230601.gappssmtp.com; s=20230601; t=1750300216; x=1750905016; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIOAI5Y5T3owdKU51FfoJ7l+A5/Bjbz3D5YXgjBM1M8=;
        b=npUesZ3HAjwMEA0BwbjohyL3j+PsAdEpMBmMx2YZDihe26Nipa4PTlbQImAzPzVOLB
         /G4ur5GXARIQn5Viu2JQjjew1hPx8Yq9IO7IN9PaFTPq99M8LjbneA15j+weonQlXHIx
         sO+wPA/6F8vHMHa+FN5ukbMemgjqg0hqaxGnS6qUVv5sWEr7OnavYhBpIfYJxt1KAn+5
         L9v+68Y0NhQATxrelRfwJVEoE8CYhfyhGgpblhxBG5Danqvo7wVDbmdN4q3Y0KC8h+eB
         ABWB0GYRSsBj6CsQ97TwSlLsxstEav1teWTOYAyKoqSe5rYiLy5evWB9V5u8i6ZHdKXd
         sKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750300216; x=1750905016;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIOAI5Y5T3owdKU51FfoJ7l+A5/Bjbz3D5YXgjBM1M8=;
        b=cfLkQx0f4KSa0G+vet42wHgfsU01oPbzKhOpcW2RJmCXYkwkSQwAdCexenBssRrqiV
         w/Igc3pIUegZtHj2It3hQZS9ab3/HaGJ3P+/ZsVVNep8WJyWMkU4uCDtCrqXIaWULO/T
         382IqD6DUKkB1O7zegQf4/Kekc4pt+BOcNPxZMZfunX+DGHoZQi9qjJ4aZI1DO5Assw/
         PR49Td5mGYw9cVfJEOlU6kqXfgTJychXM7AKVEYi4Q9znFkoak0zMMlrAphJjwcxC1w1
         t4HhsWDpcB/vvA/UZTJf1yq+j9/VQjrMvCmJTPs8SMG16iXyWEMzhgn44rBnI5EIX8A6
         UA7Q==
X-Gm-Message-State: AOJu0Yx7vDDQY3gMcgxYoo6MSmbFQ7w4dUJPLl0dKjP1iykm6NxMGHOe
	RSy1PiD0sH6gE/Q/CvHHTID05p6vZWYsb8ayqctaSNrzWgcQHFAWUkRTbzU0tSLXzckM+2CG730
	g4zwTyPK20U8HE6NHHu9WO+pGb4c/pEkEYiju8abEW9GruWkZu40y/7c/Cwq67Pz2VtY+PDEhnV
	ehymGdLuLs5Sfa+W6LIpEmARoIvjWGfCI=
X-Gm-Gg: ASbGncvAa4N9TrUPq3OkY06oS6rlZeuqm/LP13U1MSEH1dUJWBPGOi6+FnHxl55X7WU
	uFZVb6L7ITVYacSS9izLqTU+tMKkAogpzdV1GmVK72J4sxDdMC5qQokNklFRfUkLTFLJnO1XRAm
	DwzTl+Z+/rhLskm00/l9L0pijiSDrcAFGbuGPoIhmiiCg=
X-Google-Smtp-Source: AGHT+IGKMYit40R77myI3RmHiZn0FE1IzS3DkbHTIsgtb2m1Iyf0zsPB3FgtF4jXzajbJNsxa7+o3HB6SavJYS9+6XY=
X-Received: by 2002:a05:651c:2203:b0:32b:47be:e1bd with SMTP id
 38308e7fff4ca-32b4a2d7388mr62098321fa.6.1750300215891; Wed, 18 Jun 2025
 19:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMq4opPBGT0Rv25DnEMHPjA=W_Ut2BDsN0KmxD2_xGTJa9erJQ@mail.gmail.com>
 <CABURp0orQ-UCzDgJc=STPQZaaEEGwR0GM-GZq_Ty3BXBKYS2iQ@mail.gmail.com>
In-Reply-To: <CABURp0orQ-UCzDgJc=STPQZaaEEGwR0GM-GZq_Ty3BXBKYS2iQ@mail.gmail.com>
From: Grant Birchmeier <gbirchmeier@connamara.com>
Date: Wed, 18 Jun 2025 21:30:04 -0500
X-Gm-Features: AX0GCFuIGdP2asm6UjD1j8ulC0LbpR3SeKtIOZ_IOc6JGw79GPUHtKeLLT7NAiQ
Message-ID: <CAMq4opMBpg4315Q8awm5SQAQa1vms=3KB+SiQkGtCF7thBPjHw@mail.gmail.com>
Subject: Re: bug report: I was allowed to "git checkout -b" while mid-rebase
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(replying to both Jacob Keller and Phil Hord in here)

Jacob Keller wrote:
> One thing you could try is "git rebase --abort" to see if it can abort
> the rebase and undo things. If that resets the index properly, then use
> git reflog to make sure the ilogger branch is restored to the pre-rebase
> state, or possibly use it on HEAD to find any intermediate commits/edits
> you may have made while rebasing.

Yeah... except I am partway through the rebase.  I was through like 6
of 8 files that needed manual intervention.  Was hoping I wouldn't
lose that.

Though now that I think about it, I suppose I can copy the
already-rebased files into a temp dir, then abort, then copy them
back.  That would be an effective workaround.

Phil Hord wrote:
> You did pick up an extra branch "net5" which will follow your rebase.  Bu=
t you should find when the rebase completes that both "net5" and "ilogger" =
point to the tip of your rebased branch.

Oh, really, that's interesting.  I'll see what happens.  (Tomorrow.)

Thank for explaining the technical reason why "git checkout" w/wo "-b"
behaves differently in this regard.  But this can't be an intentional
design choice, or a behavior that even a moderately-experienced user
would expect.

-Grant


--=20
Grant Birchmeier
Director of Engineering, Connamara
gbirchmeier@connamara.com

--=20
This email, along with any attachments, is confidential. If you believe you=
=20
received this message in error, please contact the sender immediately and=
=20
delete all copies of the message.=C2=A0Thank you from Connamara Systems, LL=
C.
