Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71443E6DC2
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253208; cv=pass; b=oyQ2Xumjm1m5t5zvEzy3i97JWM1sE376s8cx4QUSi8YKNe+ef7G9xo2gC7/rDLlS/pqjBdnVDsplUBR4//ZDHdepyd74Ey0+Cl/dTfXjsERSVeRJIfCwcme/nwhCaZE34vIKHRnfUmNeQ/rFMaSyfBGa3DYnh0WlRT9s8+Ljm4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253208; c=relaxed/simple;
	bh=o6BwG8xmL8uy19Asdpnm+onFI4l1Aw5Kv8UIn9yjRvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2QeYvuBKIezAwOTYXXfqXfy1SMvz6BV+sfRLKGX5iQh72BslH74ptCo9HpdTfPzUyJAhNaNIWt1XlnaNNBZAQ+BFsxpWwexOKZapjFJzz2EBAhsFCh8yQc5CqUDfPLT1vVa2Wrgde/Ze7SbNgRpQLfmxkNNjEViZP7Fi2I+XFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsNd2wqF; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsNd2wqF"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89a06bc2f1bso2567476d6.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 11:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773253206; cv=none;
        d=google.com; s=arc-20240605;
        b=W4ygLwksKtu0nnJbdxmr09lmrlBvEil6ORtZ4K2Zs1dRRtk9psE1LyNurpj3nvi81S
         mBzm3hfL5dAxS6koC6/tZJTgOXQI877pTBufFjl72i2vhxKm+CoM+JS3U/WiTnG7AUeD
         4Mev/MEWr2rQThhtoTp5YqMb6nlw5ImviD+PVb8OP6JpO8p0Aq8KXpd9H9Ph6wkQ5Al8
         iQfjQ4RqVF/vvU1cJ8bFb11Osp39z2u5kYZw9/cA2NHSwKHQgAeOqhhs9V+Bxr58Bosf
         eVnZK2gDgmKB3BWpVwTBroKEMMY3rMyl9iD+VWIJtciW03jSdsbJZQkAIvphLPgYm3iU
         WcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EL8K1/ahtOYEYct42dzihfyvgdu5268oVrBgARhAHxQ=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=abHY1aBdDx+zlQsDbKjNd0jTfwAiXlPUv/K2TNhqJRgJweulajudc34QRQmuuWWixc
         rWXfdIxrFkwtgb2YavhEtuVSA6SMzGuiwCIis+54t+rm6WTfYl14k4Umd4S9fgLY/L9I
         bbTbm2qTH3fQ4szwsNBsJMNwage4/kzvseG5nwx94psgqJKGRlrrZ/QPjPIWGQA4+jOk
         eu01kGUp4YX0sQ9HeQCZuOKsIb5xf+1Ob1gOnPfQm3vOPHU3TdSlwqr05yc5/gXIIHUt
         BhdG2bFORGOebcT7/GqbraWJgVCbJwp7OOq2bSwHyvFiM3t+35q3q74YGKLakPRL7s5d
         cRPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773253206; x=1773858006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL8K1/ahtOYEYct42dzihfyvgdu5268oVrBgARhAHxQ=;
        b=ZsNd2wqFSW0U2HPxZYsUPGq93ZjCUp+Hh2FBSHU8milrPTGR/93YMoe50Io19KRD6j
         tTwiV0HrRcCsZspmtESPxpuFBobp53239OoAQCLBChjHGbPb98Bq3NrFESzLecdSbGMq
         NTQh7E26C2L8N4Pil+Metns304fbTByWoLYAhn+RP2jkF0MNKOMmbKz8BTjo//oHf3Hg
         fvtGFBBZZD1P8Qzn4vZtSqzA2Xspcz9cDUHu9Jn0v9+cEJVrmwIRsFXCHtvzparXsDXK
         +jdRvKxeZJhCVqGORhRkMJRVILicIR/UVk/xtbQMXDmrUxPmocLYOHk+rViPdzpsQ3nN
         9bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253206; x=1773858006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EL8K1/ahtOYEYct42dzihfyvgdu5268oVrBgARhAHxQ=;
        b=bU2fPPPrVisIw1rO48G0M3WlRBSqyMJYIBmeS+mtXl6nJjFtfVWW+hx7DyWOb5IrA8
         H99bkWWYSCZjWUYsTD2fEmJvyJvEdX6FhsvgvLE18++RtRhp3fb4ia1wGDCskSPiETZ2
         r2BsDRmLpJlYdS87H3mxw78LNmGCdX+gOSkef0ds54hscaPKd8uGCtU9rODYz4yJ8ZG4
         /lGcwa0VaxCqx59X+mXDFiLyqQE9JkBZUne2tnHlDNHuusLozFolSorTjmUHdheeM/IG
         VBypE/37U+XGWMKTo6HEuEqZsUZo+IwSmDE3UqoYqpx7FRA/RM0nALPReKQYAmcjiMEu
         IYIA==
X-Gm-Message-State: AOJu0YzjUTrqBWnQC7i55Ke4zFbBARulRggOKvbrF3InOA8ZaXsp5nTi
	pIDWRBoZq/OF36oYlY3M6y2E5t4JX1jZ5wRx5wNYHwChNrGz4Z8ldFjyseJHUYRoC6+bXV3G3+I
	zHyqUroeGu1HJ9ZmXshyddNaPR4B/k8QxSuftzyY=
X-Gm-Gg: ATEYQzyRvKUcOS8cxgPE6qObpdZv6erT78ALWZvS6eMZfl+5D/WprO4G90O5vUNG/FX
	HR4gjvXE42UJEbrgUgdYSWa6t7FXEm7jryQ/PDm/BFZsoaztzA3bQ6/AdzSxWT8RBbMs7ZYPuLw
	Ay7OWfYANTBVYVSWOpRP2frAqSoCWh7IuOf+Nr2xxs8S+Nfi4BAsQWxsU4dsaqf0lgCr0JnAKsI
	Sz04EfnfzP2hVYYlj4+nJQ3RnhSv+ZLwVpfPDqH90jt0qPBsDGRqj/N44VNGgQO/EkOmotZ6rA5
	IUPI
X-Received: by 2002:a05:6214:2269:b0:899:fab4:7301 with SMTP id
 6a1803df08f44-89a66a66462mr48608686d6.35.1773253206304; Wed, 11 Mar 2026
 11:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223165147.3294516-1-cshung@gmail.com> <20260311142021.3464789-1-cshung@gmail.com>
 <xmqqsea6p7st.fsf@gitster.g>
In-Reply-To: <xmqqsea6p7st.fsf@gitster.g>
From: Andrew Au <cshung@gmail.com>
Date: Wed, 11 Mar 2026 11:19:54 -0700
X-Gm-Features: AaiRm51IgiKiQuklNl787KcWFQyUzhkc-1BdPJPLf88x2FlkoPhNlQIZMpEkCao
Message-ID: <CAGVkMb6M2buc5zS+SFfYa6LLs7fN369MrVagETVg0U_PN7njOg@mail.gmail.com>
Subject: Re: [PATCH v2] transport-helper, connect: add atexit handler to reap
 children on abnormal exit
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the feedback.

The use case is a long-running service running as PID 1 inside a
container. The service continuously spawns git to detect repository
changes =E2=80=94 it is not a one-shot container where git itself is the
primary process. Because the service is meant to stay alive
indefinitely, any zombies git leaves behind accumulate over time
rather than being cleaned up when the container exits.

In my specific case, I observed over 6,500 zombie processes before
identifying this as the root cause. The blog post linked in the cover
letter documents the investigation in detail.

The fix ensures git cleans up its own children on abnormal exit paths,
which is the right behavior regardless of whether the parent is PID 1
or not.

On Wed, Mar 11, 2026 at 10:58=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Andrew Au <cshung@gmail.com> writes:
>
> > When git exits via exit(128) on transport errors, child processes
> > (git-remote-https, ssh, proxy) are never waited on because the normal
> > cleanup paths (disconnect_helper, finish_connect) are bypassed. When
> > git is PID 1 in a container, these un-reaped children become zombies.
>
> Could you tell me more about the real use case behind such a set-up.
>
> These children become zombies, and then what will be done to the
> container that lost the "git" process, running of which presumably
> was the primary reason why the container was brought up in the first
> place?  Wouldn't these zombies go away when the container that
> finished its sole purpose of running "git" gets dismantled?
>
> Thanks.
