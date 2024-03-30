Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D461DFC5
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711821596; cv=none; b=fKm86KHuP4Wi1Dpm7KOvYT3njoF5HGWUPA20go8XhJ1sAfJC5bjJPmp0UGmnyGBwbVoyet6Jvoi6Qf2x6caqzFTxGL9ErhCN9vm/W8/y8Dvb2f2ubJXbnJsUlWf5H2bxPPF4SpO6n9dZvlU8OIliQYdZI0IauQco7/00vR5rexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711821596; c=relaxed/simple;
	bh=FxMcTj83rxvnUTuJl02ZEYwqfOh1SI6s+l6ncAGzOeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OdsDdyc6nwqT1gJzLEzyRUVR9t7QDRzC6sWRu/lwV1EqCQTfbPBHBGpm2u+enrBOO0lZ++RuMIh5AkOcIBrdkMvvDpRxGjO9ZPGCj3wdg2rhllE0qhSOuyTiqvAdp2Mcf9wumEHtfpwHsTcw0c7Dfonhtm1NgfrHhozy1WCq2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w5BeG6wR; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w5BeG6wR"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ea92b9b61eso2755535b3a.3
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 10:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711821595; x=1712426395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FxMcTj83rxvnUTuJl02ZEYwqfOh1SI6s+l6ncAGzOeY=;
        b=w5BeG6wRIW8I0NRRV+8Ao87s8G8XlfqwSikyLpyOe1HUl4F+vtY1vIAMFOaDiR7ZD3
         T3ZUMngk3jBi4yjPRh2RrV4NepuaBP6R6Pewtc2jPHwxU0cDQ7dNBfSTLg2KU0MrYiuu
         RmO/AGXAcjNJ7rWVvKSs11784ewEpx8jpZqqp32lFUIm3yAbd+hwPlEQE7dfKUVBLAar
         ItPnnw1jAl/DioZOPBmeH04y+SBlHTpXHOiv3IHiT7D73+CJUFDpJDmi8xVPVQdhdvOR
         HiK4/980DfYlWkQSMpb/9QsaQa75QpusjkZQj9ZB89MEDHsJBQgea5JVb8baPrqDJKnn
         ntKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711821595; x=1712426395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxMcTj83rxvnUTuJl02ZEYwqfOh1SI6s+l6ncAGzOeY=;
        b=qqK+JufKLSLeGlK1XGwDfa71Kgs8wBMum3XINoUq+TETYOdQ+bvQ+nPyK39Cbju4Ib
         iVnGeaU3T/LgGhwQbO6Y9NsvC8Q4+0LXvdDfQhp05wcMH81bjPzdf7RIMvvKMStq8jLm
         nMs9jkNw7A64jtgH+hH5HDd/qGWjeNvEOlhVAcZojIOsSgQ02nsE380UZeif4fk5cf/R
         uWqakOKlpYb+zT9aAcygBGnR6WLX2g1EI+t/1JmN+4N2VmbVOIgHv6f7s4x8OrlygjRQ
         s43HSNUIQLfjk23hmAV5bYoADS2ci99I6SScorLyPVq2R3SYbXvt5yEA0bVxpq7/do7u
         n3bg==
X-Forwarded-Encrypted: i=1; AJvYcCXf6YJyrr6TRWB2WbTArdtFDisBPoQd+sL0p1Ym3IsaKlQ3YGLjowPoPB4jVeb52MjpmFyIrKLZrnZ6rMN87MReFDSA
X-Gm-Message-State: AOJu0YzEQT+AC4Lqd5VWiuekHHq+/GobJIXwPqWE5T9XGLcSFsVnLXRs
	kIa9VccoJwmJZIgd3ss9OTEgdl32YjVYhCkj3YhZuyPj7I0j3e/rENVDaJERfw1lneZv6bWDaEx
	yVA==
X-Google-Smtp-Source: AGHT+IElUJo3zs4n5gEAt1eSGb+ZeTmF6dNF7ccgiDBTc463ttFF+3OJi9jFiUsqa0zY++JZZ+Tnny5vuvs=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:2d20:b0:6ea:c428:935c with SMTP id
 fa32-20020a056a002d2000b006eac428935cmr70170pfb.2.1711821594788; Sat, 30 Mar
 2024 10:59:54 -0700 (PDT)
Date: Sat, 30 Mar 2024 10:59:53 -0700
In-Reply-To: <xmqq4jcr6bx2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
 <xmqqsf0gvjrg.fsf@gitster.g> <owly7cho1eh4.fsf@fine.c.googlers.com> <xmqq4jcr6bx2.fsf@gitster.g>
Message-ID: <owlyttkn61nq.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>> I realize that such an idea is beyond the scope of a simple MAINTAINERS
>> (or similar) file that's checked into the Git code repo, but I think
>> it's worth stating as a thought experiment.
>
> As we already have agreed that neither of us care the exact format
> of the file (yet), regardless of how a contributor, who is about to
> send a patch, will find an area "maintainer" to help the patch along
> the process, it is far more important to discuss and decide what
> responsibilities and authorities are expected of these maintainers.

I'm starting to think that the new responsibility should be as small as
possible, and build from there. So the smallest bit of (initial?)
responsibility expected of the new roster of maintainers could be
"maintainer must respond to CC pings on the list within 7 days".

For those who have more time to spend on the project, the next rung of
responsibility could be "maintainer is available to review patches
outside of their domain of expertise if no one else has reviewed the
series in 7 days".

I haven't thought too much about the "authority" part yet.

> The development community has been fairly loosely organized so far,
> but I'd like to see responsibility and authority spread a bit more
> widely yet still not too thinly to compromise the project integrity.

Agreed.
