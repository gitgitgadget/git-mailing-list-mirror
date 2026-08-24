Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C3043F4C2
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582786; cv=none; b=UcRA+I8lsEv97E6IEyOxHrSrMo6ry29QKwHNph5CCVjt32QLDjEgfZ6igaucnZ8izvg9xCV7CWREmzLtEzl0u24eRVpWhyXxFo688bh5J+ZF1iEa1pdjDimP4d5NU1hKKASXfWNmblinsYfYoJWBrXEhEbqRxVMbSM8pz339QCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582786; c=relaxed/simple;
	bh=udd9bs9jcSqW7r5amWlAxHwPryJaHZkj754UbRawhfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hB9okzJQvZEMs910LZxvC4u3DyFjkl5w4YsjwY/bCOTVfa+5HSvR0dfyHeMK58YDFMtV/NrQUDevtMOy2CIl4M7ZdI0OJGqtOY8RWlVE8eFHCe7OSR0sWfYHdFziHKKBFumm0hsOj1VA7oeS8dE8L2hpfrTEEkBl2a6uXQRHh70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpIDQtb6; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpIDQtb6"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52e1f9da948so7192621cf.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 07:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787582784; x=1788187584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=700uH5Cr3l/sC+EC7R+9NsGtFAxhWYobTCjcr1sJQ3s=;
        b=EpIDQtb6hpBNG8mgXlptLCYpCWeZBcigjUfY0B8lbp/ZN3Da/QUGX4TVZpx1QfBKAA
         OOvcJOcrlTztKxua5TnVKsxZ4P3t7x7liulRiPr4mNRrec7ZaPOMy5ABIj+lzSzGg5Sl
         IevozAwDlUQcpemmVRx1F9JrlzpObhk4MMCIyllIrRgZu5fLFau+c59PNrAyqFF4yQmP
         hLQOU2BpTkMbjGzaVIr8lYSuITxmDQ3vu4qj92p6aNRJkTkaXTi7zuV1E/IP+060q4qS
         Zh3Wu4r4EzqohHbTyQ0yMQJseCXxnE2/Ryyce85aGClKaMsQQOo/xYZ1n8SgmPqln/0T
         Fa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582784; x=1788187584;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=700uH5Cr3l/sC+EC7R+9NsGtFAxhWYobTCjcr1sJQ3s=;
        b=Ro9gvjknP16FsvMSgZhyciefPzsMAx61cCBiVRekDk3PngN61VfyiGe1JdBohZasB/
         FZWPT8GoovtFTBolA/J1wv6ohx7+Q7bTR4IZzDcRc63d+ivyRFv8PL3PPRljRQ6GLaf0
         YoDKxRpBucokw1/Lj9/wChRhAkdvljoblV3N/rtAhNfpIf9oOkyXP5TV6tGuv+FQUoky
         wcHpWm1qE+peXhg/n//rKARpkSrNeKBSPauKta2o+Qy6oIW8uMTPLa/xQa40EqXmzKVi
         472FiPZs51vWBsLzfDdmpxbeAIEwRzEUMqiXSf6timrb6AHV9TMBXtRX9zyniEnubjUg
         35PA==
X-Forwarded-Encrypted: i=1; AHgh+RpZYVYaQLfLOZaeY4dF7JVtSgRkMJx9onleYSNfuQ1KkYDOQx40twDosxbSXTKCahHcGXg=@vger.kernel.org
X-Gm-Message-State: AFuF++n93Jh0Qm4DkFjXUzugbVSr/rMS2pLANlDcdohxaEoWJhSCv50e
	BGEN4Kld/0zIvCcnDIKxJ4dWpDjL9G1VP/mkAC1C56B5xm0fK90pL+03
X-Gm-Gg: AR+sD10zSvRISR8H1XNaudHIzXtFY701A50B2kQbUe/llIf2fD/qaVZ9W0eOJZhamDP
	87O4Pl0ScKaceEvEQ0ehoSbFTytJWq80BrZOie5Vj4qLKfcqTSMW/64VOVGarWToU7Os/GnFWOG
	dq+3KWXwytwNaX8wKgI8as97y6EZX7vDjV7k4Jn4dGHirmhs3TKjOYdUROp0tes3hI5BR1LFOFs
	0dZ3tbO7Mf6kEldhfWBgYzAF16oyTcV8Iu2EXhXrfLVQGodSaclrThNIOJ0BTVZCJosXZHibxHo
	cmzttKAzXVS+iJuDYkSaSjgX79JoZ64O/k9TQzVg8kiytv8l2co3NWgazJmg/YFqSqK/Z5FBfml
	F5X0VxNvUoUghfmeiTXVYaM1sH1q+NElyyu5gF+5D6eBHKzFHqWCOdByXSKQRyC/P8rxQWc/Mum
	DOGYB/onoctXktb/FDyX9Gv68gK9WCrl/p02uVanEU9V5nDT6vt/WzS4MGFfdedKMMKo/nEc1zQ
	smbO/YtCyhPLl+ORusibtcLU26f2PiGoPR2MzsJG2+TI1vLk18M9fgrjwyQh1LGxUMGglSD/4py
	AAUBF1SOTn5NC78=
X-Received: by 2002:a05:622a:411b:b0:517:78c7:d93a with SMTP id d75a77b69052e-52df57324bamr263926081cf.16.1787582783609;
        Mon, 24 Aug 2026 07:46:23 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e099ad287sm48601471cf.10.2026.08.24.07.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 07:46:22 -0700 (PDT)
Message-ID: <8d1d0729-7c61-4bbf-9cb2-1c2cbd81f143@gmail.com>
Date: Mon, 24 Aug 2026 10:46:22 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/2026 6:34 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> When a geometric repack runs concurrently with other git processes, it
> can write a new pack and multi-pack-index and then delete older packs
> that the new one subsumes.  One or more of those older packs may have
> been indexed by the previous multi-pack-index.  A process that already
> had the previous multi-pack-index open keeps using it, and that stale
> index still records the removed pack(s) as owning some objects.

This kind of race is why 'git multi-pack-index expire' exists, to
delete packfiles whose objects are all referenced within other
packfiles. The inclusion of these "stale" packs in the multi-pack-index
helps halt reads of those packfiles by new processes while allowing
them to be read by existing processes.

This is currently used in the incremental repacks done by 'git
multi-pack-index repack' and maybe could be used again in this kind
of geometric repack.

(This dance is more important on Windows platforms where read handles
prevent deletions, so it's common to have a foreground operation
prevent a packfile deletion in background maintenance.)

I do think your attempts to be more robust to missing packs is good,
but the comment thread does show that it's a complicated situation
that we may want to avoid whenever possible. Leaving some redundant
data around for some time interval can reduce the number of times
that the fallback logic is triggered.

Thanks,
-Stolee

