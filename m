Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52712EEC8
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267870; cv=none; b=QbUCNfvE/s8jIYFtBUvcA74GL7z8ouokheSRvEtixGdsFPsTj4Yo3Saw2BGbIdckui+FAXTUwrU2jSefSOBoxVXwAKfNXDXqqzEZncbTqucA5JLMfs3DwruHmxQeN/lR5B27eonG78oWCZM4cgfgMAqm2kIH0sm1xfYFq5BMOBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267870; c=relaxed/simple;
	bh=qnDxG00WjT3xfgGr10jqMofYzYMN4ThUEZsFMnHXKB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQVEjnEvdgwc3dr2YDx3MJbVmQmPPbOuFSJ5Y5RyJlCZUg4VozRD8JWcaEKtxuvrtaMRMtSevi+S64NlONzAkdpa0cTa6c/2dX1274JkgLyAu99WEtLXihHlJA4VhQeJ0LLrJQmNMf4E1b4j8XevG70cx+S7td1QC/LllDXizEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dnu9Q8Ef; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnu9Q8Ef"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a868d7f92feso442187566b.2
        for <git@vger.kernel.org>; Mon, 02 Sep 2024 02:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725267867; x=1725872667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YW1lbUo140DAdEKqWt2EBbeikRYULLRn6sFh5G0pqnU=;
        b=Dnu9Q8Efb1wap+gymXdVwWyrGlmaIM4HOGp8Z+TTEKLzNBDyMB6qZtH3pnXxtQYNcr
         OATb6QhcXArsCGp0xVC4KDz+hcHqHJi/A82XGKki7PnbJMkH006sSKeT1kSoljS9IG1+
         0El4m1nHFd7vlDC6+IY2QFo3nN2dskeUbzWZ02YWXh8FfjZGuT598yLnIpz290WeY+9h
         ulbJ2xNiv92/6Y/twP4acc0dmCg7JZKWwJnHLmfDOKR78qPt3FP/nM5sVgmNVfZUpEF9
         LQuETmH5eDtnQBBp6DncLY62cnIc1QDWRm4NThCywf9720ozqSQhvXOa1Qr242d5RT7a
         u75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725267867; x=1725872667;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YW1lbUo140DAdEKqWt2EBbeikRYULLRn6sFh5G0pqnU=;
        b=L7yJBvGffCcOpFVok5f1fwXuUA6ki1dTj9tgdK0EzawsaqTQOJG6fwa0isMRDcVXIB
         lBZ3DOPW6886wuLBLNdfnKmd0TTJLWCm4KnW3+Bd2SkJKyythDa2PxQbSno+R8ToLU1Q
         p+EtAaeVpoqAdq3aGu/rjG8EHoJJMbCB6JSu73VoaXxlSE3YNrWgxf+AVFYzQy+J2oKm
         bWWzsyDM4ach5Xg8M9/kGwxVGNgGlt2OBcYt9Aub0BfsgQCEJ6TwG+sdQlMKolImaCCR
         VK/0w+UbMuMWbDBnGB2+yRzWMAy9E/ErdkBpXaO9tIYy+RxmWAW5yLiG4d/PqXkbNTPD
         UAfg==
X-Forwarded-Encrypted: i=1; AJvYcCWScZXxKETuCs8eVfzU6q/Atek174akjIBdJ/c4y8uGWJaBoC070T3EEbEW3az+BRwVYzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6dvsszoNVPIksgcj4ygTn4WUEROGvg8F5Jty7WL+34FV9sVoN
	n4kfkuHtjoflsotRmA4X7S2vz4mbOk6rkLimtQ94fEUg4Hu3Udz5
X-Google-Smtp-Source: AGHT+IEdlQzgqaKEHNai6q0uO/asVdcNFxyWAyUhXxtsWRpJUoZr12wb3wC+SBMCZUcLNwI642gyfw==
X-Received: by 2002:a17:906:6a09:b0:a86:43c0:4270 with SMTP id a640c23a62f3a-a897f77fc2amr1005145766b.13.1725267866852;
        Mon, 02 Sep 2024 02:04:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891db42fsm526221266b.184.2024.09.02.02.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 02:04:26 -0700 (PDT)
Message-ID: <981c8e52-e51d-4aab-a970-bb41315e02cb@gmail.com>
Date: Mon, 2 Sep 2024 10:04:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: `git rebase (--no-fork-point) --onto=<newbase> [<upstream>
 [<branch>]]` leaves HEAD detached and *HEAD not moved when <branch> is
 exactly `HEAD`
To: Junio C Hamano <gitster@pobox.com>
Cc: Han Jiang <jhcarl0814@gmail.com>, git@vger.kernel.org
References: <CANrWfmSY1F4UB2QSjN8XKY7Kwx6FL8SOrz_OadZ4u8XYDpZfBg@mail.gmail.com>
 <61a4fcc1-1dd8-48a4-a1d4-0201232c9b26@gmail.com> <xmqq1q23pegz.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq1q23pegz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 01/09/2024 16:42, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> "<branch>" is expected to be a
>> branch name, not a symbolic ref to the branch like "HEAD".
> 
> I question the correctness of this, though.

Yes as you explain below, it is a bit of an over simplification

> The "what to rebase"
> argument can be any arbitrary commit-ish, and if it is a name of a
> local branch, that branch is rebased.  If it is not, the HEAD is
> detached and that detached HEAD state is rebased.  The latter is
> handy when you are unsure if you want to really touch the branch.
> i.e. "git rebase master topic^0"---this way you'd end up on a
> detached HEAD that shows what would happen if you really rebased
> "topic" branch, but if you do not like the result, you can just
> discard the state by e.g., checking out some branch, and you do not
> even contaminate the reflog of the "topic" branch with the record of
> this failed exeriment.
 >
> I have a mild suspicion that the "rebase" command might have changed
> its behaviour since the days back when it was implemented as a shell
> script, when the "what to rebase" argument is HEAD, as the most
> natural implementation to do this "optionally first switch to it
> when the argument is given" in the scripted Porcelain is to actually
> run "git checkout HEAD", which should be a somewhat noisy no-op.j

It appears to have changed in 0cb06644a5 (rebase [--onto O] A B: omit 
needless checkout, 2008-03-15). That also changed the reflog messages 
written by "git rebase <upstream> <branch>" so that "git checkout @{n}" 
does not see the new branch being checked out.

Best Wishes

Phillip
