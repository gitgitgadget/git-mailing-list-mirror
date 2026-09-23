Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20141F7D8
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185807; cv=pass; b=ShrvDOsmEMZ6oWdL5Dq3edC73u/1zkCWp5UZm20yEe1cKwpmsfbscbl98QqvekUk/+gUdf6wBkCS9qCctShqYQk4JEAOpc0cQoxw7q1B+k641vJeT+avPUdJaMgX6nKtdAUztKMEUQJRC/09XeWubga3zC+g29lCo+CQJlMHDeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185807; c=relaxed/simple;
	bh=Qw9bXsDz8JiyrLTFa70Ls2eSAghCLCdjihPupkOY+Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCFN3Nf5163DSwF2g0cwnmxwZ5cpiqOllKYywBi5di4ZX2pc4n16N9y/LZlc8OLEe4cLSimV6Lx6e4v+9egQjvJ8iDTK7BjlJEDsgIkKky8egdW4kCqV1MbMh0n0pMmY/y86OOEOiVJOkiq7SKBChoeHrPQtPPe/ZY4SdeszXSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcWnqZw8; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcWnqZw8"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b5c61966d0so743801b6e.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 10:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790185804; cv=none;
        d=google.com; s=arc-20260327;
        b=pFCAHCPtSdKug2Kxd9nrBSjs7E4WRcqinCd85FAQfHvPIgRcdweQQjZz3JHDGdz1jy
         Imh9qkuArMnbt1Lt1npYpP3zjGJhrbWmVUNXWaVFYJn4NwIVVfkBACZn5SjQIlLRsBvn
         lejGH5WWJBbsxYi6iza9YdxPAJcToM11PzUCjR7a13rPsNvsHvno3bwjJ51pQCEfIufX
         VfB3Q8mNH5vyjSiKH7f/oQ09tNT0G28j/INWCyYN6BQ2O8/c5SYESa/cLJF9WurcSdrO
         Md6np/BGg1T6fA0fVLmn/5WKwgUfgZJFOMSRIfGB5QBRsTUn5R7hUBqhnG+5vrxvD/jn
         GRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qw9bXsDz8JiyrLTFa70Ls2eSAghCLCdjihPupkOY+Cc=;
        fh=YTR1GV98EZYOoG4PzwGTRCYwLB8ARtidX8iE1XRW8Fc=;
        b=PT6P4nizQDQpHdh+aUZLpZcPD9Pczmytc7hOmWcZG4+YzceNbxUkiiAwSa6I6b3gNm
         t0HKrQzrnLs7TE3Mg3QMHDMoFfXO8T7zgIMgr1cgI4Hv/0qUXnxF8HYU+MVagtAUkOy/
         wT3U8Tp9VG2m/za1LFH2KzmrhAMKcmg4gtvTZUzYoYAwAAak9EKHp387c4s5HY2niPLw
         /flZ+vmmHwpVcmINSqIbAirsgQOaOhJzjPoHPWsZBoL3QYdfLyVxEAScRko7Q5BFXoLZ
         f9zQYmnlPFdx2pXQyqG6+C5NaklLHIawgkJSWE52UC0oVDd44yqOWu4aOQYONV3hhR0B
         Oukw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790185804; x=1790790604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qw9bXsDz8JiyrLTFa70Ls2eSAghCLCdjihPupkOY+Cc=;
        b=jcWnqZw8EFzvtIL0PYdHrH9f9DDWwKtTGRG7OSpMNaPw/4BXnpKaI1pWrmewuJY0B9
         PHgzlXBqsL7oJe8d8CICaukgURUumN0n7qtU/94F7cn3ZCS/c01O0bimzzcWqizXWugU
         ScirEOF6e5EA1gcQlbwlM7kYEpKEQN7JzEROZZGWR121bjZJW+FlsMgvwH8lojNJCn5H
         FNJQkzTAWb2bKDF1/xBRfNkYcnDNeBUl5WYQpCcbVLPuI6EqsVi9QAMXohf7E4gco88l
         +GWgxwBg0FAfsKkOhH9wUTPZc0V4MfEtb7HFqvfL2h064wbihQP7RmzLS3MG9ZCuxcok
         jKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185804; x=1790790604;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qw9bXsDz8JiyrLTFa70Ls2eSAghCLCdjihPupkOY+Cc=;
        b=WxuLdNK9eRJTW/pXVa9dtOyx5f3ck2+K5oo8OX+8946fYKGZjmBsNJ+bnOgHAyRolv
         A6Zoql85Q/ptkQxRFnlcW7ISSmuhvdoWBjBga4Ddp9rdb5shW/i+inHKN978o4b7hNbQ
         t01mUdmVhY9YFIfKRxEDh50/DA6UGm7ChZO4YloBTckvYjrYA0rWTqxSk7fd0jKKAzk4
         rIeQ5dGbHEpLKuk6wWFPG7ikl2RY0qOdVgz15MdMiUYwqNH7rerxTty+vMGR7P81VqLU
         PjNgrsthDLHp2HteeXtQJOBhXop4RTxDW+sIJeh/XLqBeuatfhAxj4c7OwMcwHxRFIqt
         vLqw==
X-Forwarded-Encrypted: i=1; AKwUvBy3O4BSxmZgEcx5tQa/XjyB35iHrsRvWYXxST15J0BdZdjK8iTI/KAVRwSOXSkaTrgo4FI=@vger.kernel.org
X-Gm-Message-State: AFuF++mosI6c/2NSWHnB4VKFcW3a1kd4M+ZFe5VNV5rukWlg3oK83E4c
	6Z5nVhNz/5Ez2DpfcZni7/tPGbrFoNm9XyrWYCkhtIlr1LgJiJBxZAoPZd5XYsbxks09FQmYvyk
	POy7CF9TY+awckiIcU8Kof4cMzyodg3A=
X-Gm-Gg: AYBFou0xxCuocPqYZIgpwh1jwVJbJ3XROismifA0fC3TnRzw1YLkpRtQsJbfh2evFzO
	ruGS/UZeKebppEGyhv/MG4/NgeaNjNSVljGJOx+aIctCKHCRGHlQrN5QxULc6T2ZHHzkIH6Um5S
	/+BdDOOXntbtRLTdrGI6Tq/oWUl5/tZJDN+yVIL2QW7a+zm15R6PYdII+UyL6qTIy1sljnI6Cuu
	+w7BfUhNxngYgASPNxOrUDyAK9SpJNHIj76i6anq4/mO7OQOLg4R0+WTQ2fiIMk9prkFi3Fh1zB
	ot6J1g1F/rgTHvLcsT8mh1S0gQmRFLdyaU4tZjuawLx1BENSjfiWpEwNHkRey3dylAsc9bTT0MM
	cKmRlw73xOr2Ll+3d+bAV9Jb8h17FcjXz/G1kvBNjtDygBCSC0biqmQKe/7q3V0zjIu7MKjbC
X-Received: by 2002:a05:6808:3a0f:b0:4d5:27da:a496 with SMTP id
 5614622812f47-4d5b90f12d9mr2713442b6e.48.1790185804538; Wed, 23 Sep 2026
 10:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
 <c12d2ac3-5263-4301-aa64-a311a343dd40@gmail.com> <24cc4bcc-1d26-46f5-a502-ba673713f4f0@gmail.com>
 <xmqqik3vc1pc.fsf@gitster.g>
In-Reply-To: <xmqqik3vc1pc.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 23 Sep 2026 10:49:53 -0700
X-Gm-Features: AclHuK8EmzjFfJ_43Cvp5WieVWAJcYTRT33DY-zuFp2KR3chgKKGqtOXT8JOWak
Message-ID: <CABPp-BENMwiHh=y_RtfY3Y+uyjRvbpPSTRE9sCGvOtpeeMgapw@mail.gmail.com>
Subject: Re: [PATCH REGRESSION] builtin/rebase: allow user to amend committed
 conflicts again
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 10:33=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > On 23/09/2026 15:02, Phillip Wood wrote:
> >> On 23/09/2026 14:16, Patrick Steinhardt wrote:
> >>> Instead, use the existence of "MERGE_MSG" to figure out whether the u=
ser
> >>> has already resolved and committed the conflict. It feels somewhat fi=
shy
> >>> to base our decisions on the existence of that particular file, as it
> >>> really is only a proxy for what we are actually after.
> >>
> >> I think that's probably the best we can do. If, after committing a
> >> conflict resolution from "git rebase", the user runs a merge/cherry-
> >> pick/revert that has conflicts, then "MERGE_MSG" will also exist, but =
we
> >> don't want them to amend that case either so it should be fine.
> >>
> >> The code changes look good,
> >
> > Let me rephrase that. The code changes look good for "git rebase", but
> > do we have a similar problem with "cherry-pick", "merge" and "revert"?
> >
> > Thanks
>
> Now, would it be a -rc2 material to just revert the regressing
> change out of the release and restart the effort post release?

Yeah, reverting and retrying after the release probably makes sense
given how close we are to 2.56.
