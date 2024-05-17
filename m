Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4E3FB99
	for <git@vger.kernel.org>; Fri, 17 May 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953953; cv=none; b=D8vz6L5whkyeii9Bx3cjY71G+amXJbpapvkiqB2vYPxRUS2UnF/QRN04wCQLGQ13yihnkTbFkqVIbfl2UJ4jj9FzK55g/9v+2P6Nhu/t6Pe7JC0SH3NxdXrOHjaIMJZtHhrLIbkIYywC/2kPBHj24pS8IqyzE5EFWffA3NOT7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953953; c=relaxed/simple;
	bh=MXIp0xNLhgFBRJLL6UHYAxRmJMM1wp3mE9+O60H1KQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=auGRJfIgaT3F+86zAlWCp9bJfFxOmnINn3sW2o6M2SmBxBBqB5W1C/35ck2GQ/JKXhlmoqTdjtk1589YVmrtOhQHRPHY+/A89eQMMu7cNtuazsIXQLQDfrF+3LskBPjD/jjnp+Sk4xc619xqPxrovvFWxwCY8+a7xOX/we46M30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCF3p2Os; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCF3p2Os"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b281f0d06dso21041eaf.0
        for <git@vger.kernel.org>; Fri, 17 May 2024 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715953950; x=1716558750; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dnsx/j0JFzsQbzqI7EEKV7/RcmSEsHdZT2JmHK94ns=;
        b=CCF3p2OsBjplrsulYkm/h686wr+1RDjfdZ2fuay8Id9VBKpCpW+fWfar/2fXua2Q/q
         4mXpv87N9PmMKDxEVsUwmIB33+Bvc2/hNLdVK7VM+1vO3vjdW+QxQz8YoYeYXl/SaBvM
         Hgf1CIkJ0ZHyWiN/BI8qEOtaU5zZ6QxYEV6lEBik9Li+i2Th+2D37F7RdmGajqD0IcQP
         EsRqYYvEMr0oUC55lii37TxxWTJjS76pnI0kUdPOvO2oZHpzcp+Uo9ycho+qH3lAoVzS
         G0lbmoh/TOkO5cK1aqnFC5FGcwUzJwWkdx1E0ZcvcgOUZIeHFqHRsrnHAOxNcgjdc3Ky
         jiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715953950; x=1716558750;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dnsx/j0JFzsQbzqI7EEKV7/RcmSEsHdZT2JmHK94ns=;
        b=XX/3I/JB7Q39qJ2NVDPmJb3lUPsoDyK2BuMXBos3ZNHuRMjZc5LU4TqMe9rwt2w9DI
         0rJmnvLJKXsOfMwV0qZjoJYRz5dt+4TMtLQBY9fGmVfIPzW+oxZAFXzNRznCtZTdQskP
         IRUAKGzocpes08Hm8zfyfBQyRWRlgZ3CcmPsOm8zMtjyTQCmol6Sqhd2XrUAt3d8PK6y
         qgjKuc2ZfRBAM3H2BViD8wTg79Cmy7joXWTMaM9yEezgY7HShvPwu9akgtwP32vRxc/r
         BeaoycTOajwVuSx0Wh6mG6+M57AxkUv2Ducrg7YC6+HL6PtWiEr3ysCbzKZdAyK4LQuF
         wwWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7e4ypX0iGjRf/VZL8pBy88gKodsYnRfty5yG8nR0FwsN86dWQuN13XDNeX1kgL4TcIPbKxx5FMMJYPgIPQ32S4sLo
X-Gm-Message-State: AOJu0Yxh5hG5EoKV60T42xD2heJZ0V0Bz8XRyWmlk17J/pWtnVZ/NzAW
	GHp7kXvKvR/AG9JMdPu/aoNBTzi5Mz4I58X8NJMJHIkgomFa+L5BYriH6A==
X-Google-Smtp-Source: AGHT+IG2vwsttRbqTlErOYc7CxpKw1OMHiIyJYH358UVzuw9mYHTNKpxPF4FPo9CBnfzxhBWpbQgPA==
X-Received: by 2002:a05:6830:14cd:b0:6f0:e2aa:ea49 with SMTP id 46e09a7af769-6f0e92ce674mr24891239a34.3.1715953950390;
        Fri, 17 May 2024 06:52:30 -0700 (PDT)
Received: from epic96565.epic.com (pat-verona-i.epic.com. [199.204.56.214])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e25735ceesm54004761cf.11.2024.05.17.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 06:52:29 -0700 (PDT)
From: Sean Allred <allred.sean@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Patrick Steinhardt <ps@pks.im>,  Junio C Hamano <gitster@pobox.com>,
  git@vger.kernel.org
Subject: Re: [Q] rebase -i: turn "pick" to "edit", make no change, what
 should happen?
In-Reply-To: <233aefd10fbe965c190541d353822fe5@manjaro.org> (Dragan Simic's
	message of "Fri, 17 May 2024 10:54:06 +0200")
References: <xmqqy189o94c.fsf@gitster.g> <m0seyhs8o2.fsf@epic96565.epic.com>
	<xmqqmsoonccd.fsf@gitster.g> <ZkcH-LAkLkf_wvfq@tanuki>
	<233aefd10fbe965c190541d353822fe5@manjaro.org>
Date: Fri, 17 May 2024 08:52:28 -0500
Message-ID: <m0eda0sfz7.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Dragan Simic <dsimic@manjaro.org> writes:
> On 2024-05-17 09:32, Patrick Steinhardt wrote:
>> I quite frequently use "edit" just to inspect commits, stop at
>> random
>> points in the history, run tests and whatnot. So this would be a UX
>> regression for me because I do not want to change commit messages and
>> don't want to be bothered.
>> With the introduction of the "break" command you can certainly argue
>> that "edit" is the wrong command to use in my case. Muscle memory is
>> hard to retrain though :)
>> One could potentially make the behaviour configurable so that you
>> get to
>> choose how "edit" behaves.
>
> I agree that it would be best to introduce a new configuration option
> for this purpose.  Making such a change in the behavior of interactive
> rebase permanently would probably result in more than a few raised
> eyebrows, while a new configuration option would be a safe choice.

I would strongly disagree that new configuration would be best here.
git-config isn't a silver bullet for finding a 'one size fits all'
solution -- on the contrary, it usually only serves to confuse the
community in situations where a decision should just have been made.

I've thought on this on and off and, were I asked the question 'what
would you do if there were no precedent', I'd agree that 'edit'
shouldn't simply be a shortcut for 'pick' then 'break'. Sequence editors
are where such shortcuts should be implemented, IMO.

I want to be clear that I'm not saying the behavior *should* change at
this point (at least not without the set of other breaking changes
discussed elsewhere in the so-called Git 3.0 thread), but I can see why
'edit' having the behavior of invoking the editor every time would be
desirable -- *because* each command should ideally have one clear job.

git-rebase(1) does briefly describe these commands, but perhaps not in a
way that makes the relationship between them as clear as it could be:

       By replacing the command "pick" with the command "edit", you can
       tell git rebase to stop after applying that commit, so that you
       can edit the files and/or the commit message, amend the commit,
       and continue rebasing.

       To interrupt the rebase (just like an "edit" command would do,
       but without cherry-picking any commit first), use the "break"
       command.

       If you just want to edit the commit message for a commit, replace
       the command "pick" with the command "reword".

       To drop a commit, replace the command "pick" with "drop", or just
       delete the matching line.

..

I don't disagree that the behavior of 'edit' could change in a Git 3.0
and that such would be a positive change, but:

- such would be a breaking change -- I know of several tools that use
  interactive rebase in a scripted/non-interactive fashion
- introducing configuration to avoid the breaking change would, IMO,
  cause more harm than good. In my mind, it would be no different than
  having opt-in configuration to automatically staged everything when
  running git-commit.

-- 
Sean Allred
