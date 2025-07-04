Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A52E36F1
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751665228; cv=none; b=TdjMdWY6yuHITahjxjdKsWWaaiKrrUm9WwTkzaj3ViFHzlVUny48rT2KDHpxMnQMv/By/y+qylEn1jjM2M+3qhZWq1oGtZbHyB/KBIKxOJZ2NbR67at2H2MLKDUXmDph7/ztm10DEQbeuvU4nBYC4ULMEUtL9uOeJVPR+mO2Nbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751665228; c=relaxed/simple;
	bh=sj6sa7BjqOLiP2iBMlk7al70LGO0nOL8PeF/dPRZYSg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=t8qKWk46xS7bPUdUOBkL+4ylsD1BvSlKAl5fLbBmmG6/wQTe5q6uId0Ym/mNsuxvy/qu8sM3F2GjqIA08JyhQZRbLnkD2iuOLSIYnfD9g1WVSJRgq6f6ljvwTLxFy0bYAvdnvqd+55qpTRFNTX2lLe74D2Eyrcr+UoKiHocw8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxfIq+CI; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxfIq+CI"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d45f5fde50so122278485a.2
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751665226; x=1752270026; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSSUtPXuzTGWVofaNMCogpfiRm6LCk4OYu+7JdtUYxM=;
        b=UxfIq+CIJRsae/m950AhESZtGqQH6kAZAi4nN9+ywbKmYLoPiMNvMlmOWDrhR0VHTv
         eKyEqv85+Be0py0iIqojY1puD7K4Wf9/9ak6nhiyqgpZYaSdiSht88oThOVQGjP/cqZr
         K3IWd25MWzfX6wl/yIvY8QsQvPx7uTfi39KoDivbCucmPjYWCc3a45UzXK6ZfPlubHfR
         9wBUi3H4Rau/TiPP2WGFzi3P66I5E0/PP0YSwP7ZMpmTHqObpEaAAiEoD8ZrZFHlEf1j
         Isxo9u9LRMnkZN9H7oYSmfVPkDHXwfx4HYHXJ4MScF6/PJdYeDczU0aG1Vp/M42SUJ2u
         kWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751665226; x=1752270026;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSSUtPXuzTGWVofaNMCogpfiRm6LCk4OYu+7JdtUYxM=;
        b=wwH2rLNGfCiNfKQAbLE3JIiWBdDuZVPF4I7FHeN/eZEZGMgfum0xqoll3cAg/Dvure
         77UTIqD66gbw/zkrbeJRG2XRu9DBi+kvyW72D6JVssem+rTbcnHe9dYzTpV1oWkGAEcF
         be6QJS/vIEsutEjk5JM4q30aiqnqavcO9JcaVN3G8T6EI5Ej7ZbjLLDzYUMIL7VNfInR
         LT7Kec7MYTZUToSWuweAkATWag9do3MyfHl0Hn5GDu/hYFq0gYl148L0G9BVyu+HXIAb
         rEq6XZEq/Va8YRJR/UAWetpoolam1HGxjretYVb9+LnoiY8gblZbLvZndbvIAOs4rM1S
         CeNg==
X-Gm-Message-State: AOJu0YyfPNTsTu22VtFQ/84G8ZtuGdl2/7yrQB78WXDJ321KabFlyqPB
	qtBgmWaO/JG78fazU9nakbjyr0RC0NFPurRHjS57PcOH8I9vyCUbiItW
X-Gm-Gg: ASbGncsurW9ubumiMFlPgBdPhAKTh8NDpJyvVUkWDlerU4bDP7RN1AZXO3YAoVq2FDk
	eN0z7FwhwA0H7AVURtI+DrLZm5ilxSMBhWIj/zyjlk0WU8s01geFb7ScHto7IGXaKQ0GsHnN0Po
	bWQ2BhjClIbsQqxDllaCrsn7SpSAA0O1GMz0orqpCH7OW4/aBzPp5hMGpbhTkFFYmJ/iChMY/Mx
	5yCNaAdti2/yRdRZ0uOrbkRrsjWtP0sb+4jpavstFeu5FneNlaEbVWjmyMfnEOH1nUFZkYlDeJV
	2vRCy+kz+MFgQ7OhDcAXsmHoIjnTbqDYHdmzo+zZBR50I+OrYyUUF1H1pKBww4DgLj9M5ej23Ri
	IeAyZnXAmbgrSo/s0fKiZg6+AacypSQ==
X-Google-Smtp-Source: AGHT+IGl2RMUchKFaSfrNbYX/j6J8qR49LhKjDegZXCNVzZ8AH2F2sLSWteCDK4cFB4ijSsEwaBdCA==
X-Received: by 2002:a05:620a:45a8:b0:7d2:11a:5d07 with SMTP id af79cd13be357-7d5f20b77b8mr58919285a.51.1751665225636;
        Fri, 04 Jul 2025 14:40:25 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:934a:f0e9:50b4:12da:e6ee])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbec037dsm209811985a.113.2025.07.04.14.40.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jul 2025 14:40:25 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH v2 1/7] repo-info: declare the repo-info command
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aGZqK5eBA18vHAa_@pks.im>
Date: Fri, 4 Jul 2025 18:40:11 -0300
Cc: git@vger.kernel.org,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 Justin Tobler <jltobler@gmail.com>,
 Derrick Stolee <stolee@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <AD2EE71A-1395-4665-BB9C-38DD4B941574@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-2-lucasseikioshiro@gmail.com> <aGZqK5eBA18vHAa_@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> One thing I wondered: Justin is currently iterating on git-survey(1),
> which is the command Stolee proposed a while ago to gather repository
> metrics.

I didn't find it in the mailing list, but I remember seeing it in the
the GitLab's fork. Is it this unmerged MR? 
https://gitlab.com/gitlab-org/git/-/merge_requests/369

> Would it make sense to maybe have such whole-repo commands
> grouped together in a `git repo` top-level command? E.g. `git repo info`
> for your command, `git repo size` to gather information about the repo
> size.

It seems to be very nice for me! In fact, this being a home also for
statistics is something I considered while writing the first versions of
my GSoC proposal.

And what about merging the two codes into a single API? Something like:

```
git repo-info layout.bare references.format survey.commit-count
{
  "layout": {
    "bare": true
  },
  "references": {
    "format": "files"
  },
  "survey": {
    "commit-count": 42
  }
}

?

During our meetings, Karthik suggested (I'm planning to it later) to also
allow to request an entire category instead of only the fields. Then, this
would also be possible:

```
$ git repo-info survey
{
  "survey": {
    "commit-count": 42,
    "blob-count": 1234
}
```

But I don't know what are Justin's plans for git-survey, if it would be a
porcelain command for showing those stats to the user of if it is targeted
for being parsed like this `repo-info`.

I'm just brainstorming because I liked the idea :-)

> Nit: missing colon. It's also present in subsequent patches.

Oops

> Patrick

