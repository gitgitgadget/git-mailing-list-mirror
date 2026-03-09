Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3163D5227
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067649; cv=pass; b=lM9wC6eztcoJlVgvd3CqYe7/fef37+CUMUWQ/jtk/8AWHQPg/eObWalnoRNkRqQXoq3bkA5UEmjRm62EHQooZ27OPacIWoIPWvE/bzNfI0p7irKFCp2pVX8rLTdZJWoJb9FlW4cEClj9SF6g88jek0Mr8nIq8LR2xxv0DgBFazw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067649; c=relaxed/simple;
	bh=0rIQlvlLMnkGvtAL+D7TUio16QWLx6dVYmfuBRSwNeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoKMw4c+GbSH5nzRbmZFUMQeKfJvj3s9GZyGNdK4Awg7ZRdQdIcwiU81cKbKVN+N/aLDpo/JjyynpTrvYNqQyDlWe5z+tK7ZvuKcxMX94XPgufiQjqfQXeTIUOH6q4MNyC/cRpZSkBDbKaVChHYSmCnGDl/R7bD2smwkIZpzeTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAIdZJEp; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAIdZJEp"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d756f2a06dso253953a34.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 07:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773067647; cv=none;
        d=google.com; s=arc-20240605;
        b=cKRKrzKTKTbWbN9OfrN7igb9n7OG16ooHMar4AA+PN0EC5eSBUVrYsVLDG9r5cmo1S
         J6buONs/uoBg+w2JHfVkXr30IToH/B5B4W5EiHbmNP7/9Wisk/hIGdRtaLHeFrWc1Xdh
         Oc/EcDu/rmb8Fjfjqsjy8moUSnAaazhr2VekTYZtvZGyIO2Tw6B7sehVPv8Mq1q6A4yX
         9naAEQH4at8bDs1c7Cp/1NFghhL4J97flHU/3vzlOPQ61YdE30pVcvOAA88TvW+6HSS8
         6ZOkEyKzC1pfAkx3WJTh8nSw9uFztc++aixg9iTGiKTqR125Cj8wn/dwkn2PmnOBiwvi
         wRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0rIQlvlLMnkGvtAL+D7TUio16QWLx6dVYmfuBRSwNeQ=;
        fh=/plLnf0iYB2jUKmKx5zzdFfzrLcMAzuIidbw4Nsw5bM=;
        b=B46JQO6uiVvjkz+rv7S5CN+2hRpAsdFWAESXb+63gp2XKvcm9J2ZwBtr3ZIo/zN7ZA
         BcRWWMrKERqhqsHsebdmNJ2q5UrUFree2RxcTfJ66XVRj+Fq7lbb0hy6P/8WIID8RW0k
         P5caTyiT2/WaIaAFDf4jwmxmOoHnWsjMMBqAmz3CDcBe252nwipAcCeLItFNJXuEnM5A
         GiymhrQwNOQjB23/vqjz0hrQvdKrfuJT3W7alR0TOa+o1UxcF9T5waTIJDfmYbh8zfp6
         eHgFpnr8FwpZbNl6i8xvmYxAHnDcjsjO4WtFnJWNU052kAJ5W1AQNaXjJkbjAsD2DQQb
         s6Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773067647; x=1773672447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rIQlvlLMnkGvtAL+D7TUio16QWLx6dVYmfuBRSwNeQ=;
        b=WAIdZJEpwcCq3yXydkUMM2SpijkmOmRuK3cdVWhbl96UGApjHu9qpWoHO2SEUrQ/7k
         tan+jrU5VXQcrxBBOSJ3eYPCXWdO4NtDuoC2pAXnfjV+vCqa/wAtVxTxKROL9RFTnnFm
         ZYb4XRw+BmqKha1aq/o4g+N3nVjF0yE49cbXisVGkKElawsbMLkYvIGoNs/fkpgAJIA+
         nphPOZpcDvA7DddaksucqqdBUV0KDeWzpDh6FDXpXbvdCOE65wnCQpMgao2spMejVOoe
         4PPAZ4gJhriTC9fcBHE0PTZRZ4CLMcWSabNvzYV4DQEz6lIH3ELwym9SuW5OExfScfH9
         sVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067647; x=1773672447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0rIQlvlLMnkGvtAL+D7TUio16QWLx6dVYmfuBRSwNeQ=;
        b=ciOvQwqzfYgQVOQCm/HVZkJwyMQYDklyZmo1UfhHj6Ojwk3TT0CS9Dpg74gapXdvEQ
         IGnfo1XXTbtz7qshjEcz7AoEVqyJGwdYHkcAnfSsJKLSXK8QgilTnJVin7lJ+WUY975x
         5CyIc3U4T5hNStgC/i+5q83DWlqHhxGTvSOxo5Ak9TojKxS5IlUcK8CUoD/NzqGiZELq
         IjZ4CsvgKglKE9dExefASidvTZPy4ezd1Q9BMiFC5f/j8Ldc+Wc13CK2aE65f5m9Gj5o
         MSNbUUUW+PMWaVVT+7xrIRa++Sw1Cg/nYLtji0j13SHQ7HV3SsFEMRvueRrv253uL67m
         2Qgw==
X-Gm-Message-State: AOJu0YwQ1f7X49uksej26S34tAB4tjVQ7yKaMv1X/nNeN4O4LTqL0APr
	RdlSp9SsVtpZQIQgz7J6TB63lml5li8CvzscDpeflRWOX87Uqnenbnj+gJaNqZpNbRaegSx/c5u
	bZ5wQLnKt3VIqSCdhvc5zeIqEepFifAhIBA==
X-Gm-Gg: ATEYQzxg9vo+FVnEFj6ZM1lqPMIi1u29rr3bTOEpuexhDo6jgNN3Pd0RpnXMDfuiAca
	Zc5DCCI1SVWgH8iFoFHInXx/fCIgMW7q6JVqFzfo/JbzngD5KaVLJI2Ep/+1WvD6TpOzyKBkZO0
	7k9uH70VCVP22PP7t2Fa/STkJfnfZBVbkX1dt+l3TOKbUdt97Dnl0Wl2Qk7Lsc7tRvesaTcWC8h
	8ctJ4F18tFb/lzhBkye7AfDcIQYUWHI4cYxmbWi4Tq0aogNIiPHxVztcKyINVCIDJVwYHhsvRAL
	Q7alSJeHQA9BV+NGsLhJARcsFzbVNVeFsmLDdwyhJtu3mwrxJPMTrXXzyMHvb8/emwsR
X-Received: by 2002:a05:6830:60ca:20b0:7d7:4eaa:8b82 with SMTP id
 46e09a7af769-7d74eaa8dbamr1125789a34.17.1773067647234; Mon, 09 Mar 2026
 07:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa65h6Z_TrpJbmkj@ThinkPad-E14-Gen-6> <CAP8UFD3sicsPd903FU8bsj2B_4Q1DE1xB+--OxryY_jhL=sHdw@mail.gmail.com>
 <aa7XkqhcG6Kb6IhN@ThinkPad-E14-Gen-6>
In-Reply-To: <aa7XkqhcG6Kb6IhN@ThinkPad-E14-Gen-6>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 9 Mar 2026 15:47:13 +0100
X-Gm-Features: AaiRm52U4ZWwHqRqS2zuJE6NAZciTpgwKaIZ5j8U1m7ZZr9NeMcqZmYnZFtxISU
Message-ID: <CAP8UFD2iM-z7F_FeDkP5v=1OAJhS2AcFsgPnicvHNFMUcmxbpQ@mail.gmail.com>
Subject: Re: [QUESTION] Improving disk space recovery for partial clones (GSoC 2026)
To: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 3:22=E2=80=AFPM Yuvraj Singh Chauhan <ysinghcin@gmai=
l.com> wrote:

> So should I understand the all the different ways and create a document f=
or the command
> I think would be a good fit and why. And then the community can give thei=
r opinion on it?

Yes, I think that in your proposal you can start discussing how it
could be introduced into the different commands. You can describe the
pros and cons of the different possibilities. Then maybe some
discussion will happen when we will review your proposal and perhaps
that will lead to a consensus.
