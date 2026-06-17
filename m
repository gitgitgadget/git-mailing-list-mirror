Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A745F3A0EA5
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689952; cv=none; b=cw61xa6u30HXvyO7qq1UhT7PyNzlYWLC//nFpxZPE666b0tKzD7hFONtPAY+aRzAPZqSsyC8n94P6SM6e4mvhldY8rA7rjttohWQ6HVziSBPtShSzIdmqKKxMOpRaoj/azuvaB/CKJgIxD7+cgfUx7Bry78Mje8GphYH3sphI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689952; c=relaxed/simple;
	bh=kZemDfp7xLGGy/ZfaLyKVxAAy+g3NbrAum/vc0BRLW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZ4HEIl+vKuZbBViYsxT+R5J2F49q6+WPcqyds1HHuqsXp0eFbOuOrDe+EShkCOl56Qwk5/0m+eqQM5TRMfhaqA39nLXB5E8WDlYPEFmoAuoOM2g9+sWJ5ev6cPwreoPOsky+l66nH/OObcjNx6KKAkp/MQL8fNZjSOWMs3SP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/BbZfh5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/BbZfh5"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bec354815b9so522132566b.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781689949; x=1782294749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lf2TgrHkFZ172yvZil4Mz/tuFNXf2m6z6sreUU/EpvU=;
        b=C/BbZfh5kZKpxxtiTsnuQpSq03pTbePHF66rEoSfTTdy3jjm7VD5w+IA6iLXocUUhM
         Daz2oqqQbpg4JItDJhdJToLdSWJKoCkJb03EOdNaos6Uu9jtZt+OODNcAg1uh3naXIU0
         9nBUN6+upjDf+gz3M7wTDVoS9KmT92OuJbZ1MAzW4hfSJXsAWPqhbPXK1pJw3oSJWNTg
         uDbTw9Jf6UwMzLlYpuXCUixit3O16x47U3sqQVDSbRaRqOQU0OGe4m+7XxLmBBlacIFX
         c4hTNQYrJntXfl6HM92yKkodOfStC5dbo3PD7ynQqbZlSqiqVw/SKs9Q2PIVv9Jqk88X
         dhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781689949; x=1782294749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lf2TgrHkFZ172yvZil4Mz/tuFNXf2m6z6sreUU/EpvU=;
        b=Dve+hDEE2T9XmwlygtjKYjvJU5eDXS0UMaSdLf1Flq1q0bc4EmQLqudqsdw0bYJLPD
         HJYnyWoHdmM6HXXFyJgjrMdxl5LW3MKBU5xD8w4+mQp5wJxCwyy/RPYunjzJUuhkuPRF
         LOa2xmCkVwGFXvSEbh3yzI9/oXcuf5N0UrlWd1JqbD5S7vsUDfwEOSnN32x/T2v1WF+h
         KRtYR0rROgbvB/bxo+udBd39dkvaQqY9F4JModF5IvwXrVAKpRLrCb6/mr/U6qs83QAw
         VqV6m5ci+4PGHA0thD7stjg+kIg+hCmjuYxCI7mxHNJMFPrF883aatkP6UrfKJt/0EOH
         zv5A==
X-Forwarded-Encrypted: i=1; AFNElJ9kW1Su4OVqNsz2RhHbfyp2QMD0HN2ThAE+cvtu0Uo5r3MV/N32m9Oz+4+U/yWWpQfMSMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJ8da9+xg1N/EJkDTJ6L++mIqioINpDXiXQ9ZWJjxKCggPjmS
	ymjCHDM2mbfIUP6I2DGclCl14sbBl3kku4nPxT58FiW5rw6QhoY9rrAi
X-Gm-Gg: Acq92OHgVr/hinp7I/0weBDxRwSZtPwrK9/Y2cr0FkqiCTAEgzzY5fjfXGPGjqT/uPX
	Bu1d2NihVCJ5ygiuZI2vt5mk/IllgepM+91rpv2+fl+HQtzOxooe3HfCaFYR9XIQ95+apxz1i+q
	WJTYw9GC1pekwr5bnqxICkMG8SddJ72jj1VfH/FPbbElKJcxXs6nPt51CokJqlRZdOgwBGvFlHB
	q9kDoaE4ZMDuK2LaejLGePtYLJrWfNcYlmgXG0ISOBO6xm4HxBqclBDTGKgP5hEJ4kNa7tu+d3j
	W1LtN4MLuUPzFpH1H+MVogHe4jcXDBgiC8YILcDlLLLjBbPQOQ2pyYm9eCGEJXp+nkNKyRqvHnC
	CJ3GhkWw+6d4M0BlI1la3H5IaPu8zmj0ai3d3BP/bboQffevUAHXB2m8AB9FDepAOpn2DuRcgqK
	NMrOl+6RrxgHIgpas4nWa0rrn5YvKMrY9mJTNz9a/quyWYGCd8WJA69l0s4KmEwtN2CKKdqqGvV
	GuGWyTwv1c=
X-Received: by 2002:a17:906:cc5a:b0:bd3:6ec5:f141 with SMTP id a640c23a62f3a-c05d2a7b1f7mr90101066b.30.1781689948842;
        Wed, 17 Jun 2026 02:52:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6? ([2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb83420e9sm751220766b.45.2026.06.17.02.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 02:52:28 -0700 (PDT)
Message-ID: <bd7dc183-6597-4fd0-ae64-682d46480cd4@gmail.com>
Date: Wed, 17 Jun 2026 10:52:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rebase: mention --abort alongside --continue
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
 <89d72342-5aa1-4dcf-951b-d0c791f91738@gmail.com> <xmqqpl1q2xw5.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqpl1q2xw5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/06/2026 18:33, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Hi Harald
>>
>> On 15/06/2026 20:19, Harald Nordgren via GitGitGadget wrote:
>>> From: Harald Nordgren <haraldnordgren@gmail.com>
>>>
>>> The warning shown when an "exec" step fails and the "git status"
>>> advice while splitting or editing a commit pointed users at "git
>>> rebase --continue" but not "--abort". Mention it in both, matching
>>> the conflict case.
>>
>> I'm not sure that the "failed exec" and "conflicts" cases are equivalent
>> though. If you have some nasty conflict that you don't want to resolve
>> then aborting and trying another approach such is incrementally rebasing
>> is the only option. If an exec command fails then it likely means that a
>> test has failed or some something similar which is minor inconvenience
>> which needs fixing before continuing - it seems very unlikely that the
>> user would want to abort the rebase.
> 
> It is very true that users who know what they are doing and got into
> such conflicts are opted to go into such a situation tnat it is
> unlikely that they would appreciate a choice to abort.

That's not quite what I was trying to say which was that aborting in the 
case of conflicts is more likely than in the case of a failed exec.

> But given that for any system, everybody starts as a newbie, it may
> be assuring to always give "here is a way out" option when they get
> in a nasty confusing situation.  Discouraging the way to use the
> tool that can lead to confusing situation by guiding them with BCP
> workflows would help, but they always get into pitfall.
> 
> The patch adds new message into the existing message to suggest how
> to move forward, but as a training wheel option, it may not be a bad
> thing to offer "--abort" as an extra hint, separate from the
> existing warning() message.

So if I've understood we'd print a message explaining what's happened 
and how to continue followed by a hint about aborting. The message would 
depend on what problem caused the rebase to stop, but the hint would be 
the same in each case. That sounds fine to me.

Thanks

Phillip

