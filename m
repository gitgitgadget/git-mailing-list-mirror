Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7C530C15A
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784600374; cv=pass; b=CuggU/2N5/EgyM0tq8lUNBiNblKKEu/fFP07tMystbljwg54UDlQpLmcra+0l0ysyJZYXXQdArWURot9rWfiwPNOeGCNzmc3lH9CyD/bjR9HY+8fEQVswnHzJCLebDZEwqEhsKYopRtvEmWy8/naahExmo5pOWU0CpTkJxOPats=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784600374; c=relaxed/simple;
	bh=NQn/LSWYIg/Rb1OLqQc4Q6zUnbsr8qG2SWNRyPpALX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acNWvQCS5kCzO+RXejKj1lLf2IUe98jOqTD4S/KtTlPVqNraaMfAD5qOtb/cMlb6MnYYRh7po9CT/6oc0ISvO8jYwbw8qS0umPvJJkzRBE6voPIqzrBD50Le+VVtYoY3F5teVQfHM6qdHUIG+15nQrb10/ltWT8BOOUmtDdDVKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPo8TdLD; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPo8TdLD"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c9452243cso71091661fa.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 19:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784600370; cv=none;
        d=google.com; s=arc-20260327;
        b=RY9cjgvyjh4lV7+aw+p9qgMrCdsRE1C212ugIWgpDMyRu7RR3ljYEmq/t1PQ6vcAUL
         8F++/J0Y1ZbSYVA0AmYo6t76rc8jYV3aBZnhvA4NhgqOO/BZOjkhHhDik4syubszRyq1
         coGGsRWeG8O/OOVsiaXt7TH5IMG0CmBSxPapXhySi69CLrOHTVsOX4yrEWxidBbIbndb
         lkwQTuSJ2dvLp+fb63csE9MSBUHgtaB6czcakmQuBhTsccb7WusGGgkMGMzo+LMEe0VG
         lnBjnHAdChSvuo15jfRYfVUSqx9TXzJZulEwGX+bZOHhKCACqqI9w/4zyFCwSPX+PJ/V
         H5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=emObhUyMZjtDkln5P58Y2YSqhyBv4sHSkDGYv9Ibc0g=;
        fh=3xltZch4r0vsVLa+zRspsRPLPWfD7sWLPuS9Gry3Rp4=;
        b=UHeXUiPazmTAPSm2plGNvF+S9euoydUJEAm7MuSwQ7vgXXDpfFpKWFY7saWjisKlHk
         6CX/cjoQwnCV5udH3vP8wDnWiCoPMNtXnOATovQCvc72q7ApkUbHGVPx2lmGTB39OLlN
         5lnQSAlL3evRAeR8UCqo6TsecFZ2PTgJwzBlWYTlHsI1EXyn0jcVvP0df0qcjBKBgsTx
         LLAQS/oOx/qiuYJSJ/ofS+h9uaJPItN6c4aN6u92x04VyYkDG+zhk0Ogjjg90hW9Xm2H
         S4EAu0ooRiD2xW8jDXL9VCIiNcISz+067xXohIl/1aEZOv9WLdtuCn06sO2A5JJqe6MS
         jJjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784600370; x=1785205170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=emObhUyMZjtDkln5P58Y2YSqhyBv4sHSkDGYv9Ibc0g=;
        b=ZPo8TdLDsk4+xO8GRIBi1766fwgFkOix9JHsyvDReNC+07MOOT9K4sUxx0j68XQ2+b
         oLFNZbLhQhcAmbQk5OiN94tOwzBQcmaXreTmooH189HnrxfJ9E/Yc2SBPec/7eqVWBdH
         5A38HeuibQuXvrEiap+2Q4QF9L0PWbSvclNcEOg7ddlicjzydr8BgsJasK13/8jlsQ/7
         OmqHR0u/YsLLDAb1NyRvRRB7YPIZcdyf6DUo4VU1X5CfV5mqOGEzp12ttVm0Eh9zDrGW
         iRYDOjhYqirYVCzaIJzZ7ER8YadyJ2LeGTT8922x4rMCJWDIM15k1rjh1JN1bnqi01vU
         CVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784600370; x=1785205170;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=emObhUyMZjtDkln5P58Y2YSqhyBv4sHSkDGYv9Ibc0g=;
        b=lLS2sGEWzzMy19WW4OD1xdEnpp2R1FeMOmojq6AXoeYQczV6JmISryMkHi4MkISk1X
         CwcpjAp1vJ7r8iy3waRCKreSWKZjvuwTmq6aHCOLCs33EUbqcK2X8tMrK8pSBPeDlTqQ
         p7a2Nqg4MZQI8+yunzdFmu3dSPxmH5GycDd2FF87L64ekvwbsDhm4vpPw5PaRyoyo++L
         4btZbp1qyjFYpthHY4Ea/6iH+TqL62f+2R0ulumaBcInCIGt3fsuB+j0ayCcEs/17yaq
         vurhQ1pslANFEBWYsNOo0F3lDGz+5y4E2dtM0JBqgA1Emg3UD7SB/Y6BFJkChSA3xTOk
         ikbg==
X-Forwarded-Encrypted: i=1; AHgh+RqYOPIR4NU60ByciPNNm6oBcQ6wnDdxNUIvkY6+uWyWPtdMJUJ841UjvxshHBqZ4p6ISn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNGCKQEWqrqvVUW0XTyQEM/FHgqYrAt1PzPyIBkwG3Rt5tFT5
	2B6AViv0gCsok3musRSD7Z5rvjP3cY5n9CCiSvmtZk5CLOuPahqdkendnJnqGA+SveCnwFN1kn+
	j9Uww1Ffmq6Gp32ADlgOMwbAotYvBtro=
X-Gm-Gg: AR+sD11Pr/h7O0Kc06OggWrSxPmHFEXb3V/H2BX1lFXkK5SxbnXslb4+gC2F3I/ng+h
	EAwW5rW+H/hgzH4dglGcbMZ9hyxTrvi6qGjCf9g1NcrkUj9ZIWOA9+Dy1pYAd9PcUVz9Jzvuaxj
	/Xvfe8Pv05uAZP4Cq8Vwm4f6urzu6FuTU2L1zuetfd42XQ7o99JbTIMYzikr3VCjQ0MkXkpVBBq
	7/X004W+H2wPqNfzHywozgvK9hXMV+LJILG74v6nZoLACu5LjWHxgMuAkex0VrnjQBJge1fHf/P
	daLmMdcbQuTekrF06foSUEiBbwnNuRMWQefNPQyhcZlKppoTUarjK3BvrmkjEiJSPD2r9kJSZoE
	tcKmH
X-Received: by 2002:a05:651c:2111:b0:39d:93e8:7ffe with SMTP id
 38308e7fff4ca-39eb2715026mr29857171fa.4.1784600370185; Mon, 20 Jul 2026
 19:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
 <20260717133015.32040-7-jayatheerthkulkarni2005@gmail.com>
 <DB49CF15-4980-4213-8463-4C0FE2EC8438@gmail.com> <xmqq33xejomv.fsf@gitster.g>
In-Reply-To: <xmqq33xejomv.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 21 Jul 2026 07:49:18 +0530
X-Gm-Features: AUfX_mwlWBmStv1CpIIAXPYpRG7Dt3TIAzQQp5EuVwadjwZ722NiEHHYYuvrYr4
Message-ID: <CA+rGoLcr7KTu5S3GN=VsV8dFF0ww0cew+4TvXtiqjGCXtVpMsQ@mail.gmail.com>
Subject: Re: [GSoC Patch v2 6/7] repo: add path.grafts with absolute and
 relative suffix formatting
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Lucas and Junio,

On Mon, Jul 20, 2026 at 9:31=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
>
> >> Introduce `path.grafts.absolute` and `path.grafts.relative` keys to
> >> `git repo info`. This allows scripting layers to query the active graf=
ts
> >> context cleanly while scaling transparently with active `GIT_GRAFT_FIL=
E`
> >> environment variable overrides.
> >
> > I ran `git repo info path.grafts.relative` in a repository with no
> > `grafts` file, and it returned `.git/info/grafts`, which obviously
> > doesn't exist.
> >
> > Wouldn't it be better if we check if that file exists before
> > returning this value?
>
> That is an interesting question, but I think it depends on who is
> querying and for what purpose.
>
> If a script is asking where to write the file, then the author wants
> to know where the file is supposed to be, even if no such file
> exists yet.  Since the file format is public, they are free to write
> their own tools to manipulate it.
>
> Thanks.

That's tough.
I think I align with Junio here.

I just used rev-parse as my compass to work on this command.
Just to clarify
Should I send a v3 changing something?

Regards,
- K Jayatheerth
