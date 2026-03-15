Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895616A956
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773578785; cv=pass; b=OIL9eNuDQc0Efteht3YkC3imA4pUCMBpIgz8ED2CUCl+tfRenwmWBRBLeZJyYWRpIuRbDP6iO89rVtdIWEljyVXBdkBpCR8CZGCIWRkWHV5RzpEzLL+bxNC+CeK0cGkrJaxEtbZlu8GFZUFnVkgTfr4zUcI8JYXiZ659SOluyfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773578785; c=relaxed/simple;
	bh=jEjgHlOoGLLd+oxrvx4ruBt5MIH3ehuM+YXcFKF4i2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KH05VmcjAp8o8TpqRzzw2cr3ElKabwGc0p4765tHR7UYfZ8DtYIqToQ4mXd3C9vzbiJq65FfuoZphPZy+HQ0BpuJlqFGkUeFq9aph3UyFKkX8eHlwWYv6fAXfZy9waxqNR00DeJ3agA+MRPBOBaW2r6HhD6GVBRbprGwwxsKIMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4O5R/mI; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4O5R/mI"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-950cc286d86so39655241.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 05:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773578783; cv=none;
        d=google.com; s=arc-20240605;
        b=cqyhQNaV1F4WuDzlR41vCjP3PbHhUzfOYH/nanTCzoQhA1yoSPCaJhXew3liIpfVbX
         +eiRRj4yAeHfpiM02nUum5jRqgOJ3MGzSn0vsIx1zQaIXBGZSez57DEI8xTnoIVUr21z
         tiSFnGpgJNmengzyhVAgt1DQutMn+Pro65r+LRXji6uhavvPltRL77m8T+kY0m15boFp
         HkFzmPYZ8kWUfjdQT6HFDx2hZ+fquVNWPt8UpvjxWoDyErEQc4+h1yccuP+XvJ2Pozj/
         2XhQM5mkq/LMqEY9i0vGj246vF3kCkvOaMpWeO/LW/QqeYQSlY6Zcx+VjZ7I4dMnCFvL
         oX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jEjgHlOoGLLd+oxrvx4ruBt5MIH3ehuM+YXcFKF4i2M=;
        fh=zMdzpXACyCg5d4FjsiAnBALTe74J+PxnUmcB8GPZ0IY=;
        b=Tgdf9/5QK2CtwG33Zc5QEDEP78/EYfE6ZpsbCfcp2csLBcancLB2HRoh55bH2e8+/0
         geLJZxkmjpMZr6yyagQP4NUjIwSdBcFYlmudBnLUJ6dRJxdmrWIEUlc2pa3To8Y90f/w
         s1k9qI3FESNOV6ovzE4a6nQlVFRL7o/PznG4CsrcEQAD2deXQU4PiSz91aXP/g6oMWM1
         UoDdWrJDYNF8bR3DsFVR/IHiFFEMsoJdC0wficD9xrYB/MUJUV5BR3xCYGjK7F3XUS8F
         OipS5L+2MHylI0WjtOzwd19K4mXyWc4E6Ws2qYAsfZgxlPMBvq2sf5XtLsOfwwF+MOzd
         9dzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773578783; x=1774183583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEjgHlOoGLLd+oxrvx4ruBt5MIH3ehuM+YXcFKF4i2M=;
        b=F4O5R/mIrfDrmor8aUBnNrQ5hcwfd2AFGOTKHmESG4o0jWmEpqKyBEagp1F28Id1UX
         EZHZrIlntKIGgGxs7K65GdarwGKQvE0351ePc1rDg8GMMo1SrzN+He7G8Oa5an3wBUB2
         inwHzcdVMmBkZUJYUovnWxqVwb0Yjd1t55ct+du0/d7Hp8OUDW7ysbut1t8yUqhPQzbr
         7MbNOSztXWPAKdXajjpM1q5qNLc6+CyGMP1tRzbfOSRrvta6HVKzZSIhuMuVPkya0F2f
         DS2SJ/O4JQN12t2k5wJsJtrBFVrwds6HaBQzEtqNAZ86VVn84Ptync3u70RyScqOCN9/
         5cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773578783; x=1774183583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jEjgHlOoGLLd+oxrvx4ruBt5MIH3ehuM+YXcFKF4i2M=;
        b=S8WJo/1L2qapMbfyW4jEd6IcGZWMSeWYRWEUI39UhAE5wLI7JPTEn4FgGVOyihWlZI
         NoolH/ynmNwmkfSfNi1bia/645eGHWfXNZK8T70wNXFJ4bucaRGFJ+4suts8khEu71qZ
         baTBF4luWoONp7nSYGX+OiSRY49tFrm1V/F0gsC8Y9HHikKSEqjQWcT/mwSGElcGLjFh
         YYz+yyi8u0jPjlsfvNeDQJgyq2wFeqYgtS2E7MIfpNWOHurN+k4FOddMcUxz7OV/cnvU
         eAFz7z+20lQhc8fDrPUquFYqIDnrYKymA7U96Q7vcavpxfj5Dla6+7aJIPB03Vmmx/Vj
         ep7A==
X-Gm-Message-State: AOJu0YxRVb/LjjGxsMmc7X/pchNp4wHxoB3VBlwS8IAwg0ey4rKO/hgT
	F5Ok81tTvhQIpsPh3KI9ZwgYIR1gQDVzFfYu8D3REcvIupGlfqcz8wTz0+kHbPqQgLFUontShtO
	10dPE8Tgh8kUgBhHwujSWG/tBrxvWfaEmBjxE1to=
X-Gm-Gg: ATEYQzzNZQBXMQGi0sUiZcNGhEHVbS9FF4r3RLXFFhRXAsOHmFcUQIiWVkDzrfpn72F
	E852e+oQWEPQpPgp+1wK/nq66hKLanRkZeE6VC5ZsrbmAZELn+EuMgNpGgtnL3822w4SJUgUqeV
	Dy1dkHypjwgQjaiD9DSpzKDnq3RSf+8+yakCKv+dc7VVqe54iWyhQ5/GDZZyITerqE5cJya8Rwn
	I7CBcC4wg3U6ykYFGP6fMiK4lk4qzbwCCQbxgrcZizeMh1SkRR06+dZ5D9aQtXwrbUyfErxFerY
	vE3a1jKLYFai1Ttmud+A5ka5ElnK83uK4GTRPDNKHE1I+vLurGitE7buD+2HIhu8RXmKiAXvg0u
	VRNBRgKNjTHfxySSsedcZeJ4FtXOkpp4tgWt8cZsoLzOzMPHuAISDTHAJhFvNgDIqXfiIcRdDok
	fOdO4m/Q==
X-Received: by 2002:a05:6102:a54:b0:5ff:ed38:188c with SMTP id
 ada2fe7eead31-6020e5078f7mr3387985137.21.1773578782663; Sun, 15 Mar 2026
 05:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOAgETOX815iJcsZOjVSYXr+o-uSkkAkEJ3FE2xkt1ODBaOUmg@mail.gmail.com>
 <CALE2CrTWMcMOPoWH8HEN_Z8_H1tdhdN2a6hN9BkJ4xs=0DN3Xw@mail.gmail.com>
In-Reply-To: <CALE2CrTWMcMOPoWH8HEN_Z8_H1tdhdN2a6hN9BkJ4xs=0DN3Xw@mail.gmail.com>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Sun, 15 Mar 2026 18:16:11 +0530
X-Gm-Features: AaiRm53RCxCpriI-DCLSFh0voP_3xI3AfoeHun0aE4MrV54I2a3O0XpR3yTvWQk
Message-ID: <CAOAgETPzGiYem3Z3rV5duhs07g=0A+-MO6bCi9MFARwrQPR7Aw@mail.gmail.com>
Subject: Re: [GSOC 2026] Proposal Draft: Improving Git Advice Messages
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> It would be better to share the proposal in plain text
> That makes it easier for reviewers to read inline and give feedback
> directly on specific parts.

Thank you so much for the quick reply. The draft is as follows:-

Name and Contact Information:-
Preferred Name: Arsh
Full Name: Arsh Srivastava
Email: arshsrivastava00@gmail.com
GitHub: https://github.com/arshsrivastava00
Micro-Project Contribution: https://github.com/git/git/pull/2233

Title:-
Refining Git Advice Messages for Common Error Scenarios

Synopsis :-
Git provides guidance through optional advice messages when
operations fail or when repository states require user attention.
While these hints are
technically accurate, some messages assume familiarity with Git concepts an=
d
may leave users unsure about the safest next step. This project
proposes refining advice messages
across common Git commands such as checkout, push, merge, and rebase.
The goal is to improve clarity while preserving Git=E2=80=99s philosophy of
concise, script-friendly terminal output.

Benefits to the Community:-
- Improve Git=E2=80=99s usability by making advice messages easier to under=
stand.
- Help beginners recover from common errors more confidently and efficientl=
y.
- Maintain concise and safe workflows aligned with Git=E2=80=99s philosophy=
.
- Improve consistency across Git commands so that they don=E2=80=99t look v=
ery long.
- Contribute incremental improvements that can be easily reviewed and
merged upstream

Deliverables:-
- Audit existing advice messages across key Git commands.
- Identify 12=E2=80=9315 scenarios where wording improvements could improve=
 clarity.
- Refine message wording without increasing verbosity.
- Submit a patch series for each improvement.
- Update related tests in the Git test suite.
- Provide documentation updates where needed

Proposed Timeline:-
Weeks 1=E2=80=932: Review advice paths and finalize scenarios.
Weeks 3=E2=80=934: Improve checkout-related advice messages.
Weeks 5=E2=80=936: Improve push-related advice messages.
Weeks 7=E2=80=938: Refine merge and rebase advice.
Weeks 9=E2=80=9310: Address remaining scenarios and ensure consistency.
Week 11: Documentation and cleanup.
Week 12: Address review feedback and finalize patch series.
(if the timeline looks longer I considered Hofstadter's law and gave more s=
pace
so that work is complete on time)

Related Work:-
Git already includes an advice system implemented primarily in advice.c and
controlled through configuration options such as advice.*.
Previous work in the Git project has focused on improving command
consistency and repository integrity checks. This project builds on the
existing advice infrastructure and focuses on refining message wording
rather than introducing new mechanisms which would have complicated the
current git advice system even more.

Biographical Information:-
I am Arsh Srivastava. I am a developer interested in open-source systems an=
d
developer tools. I have also mentored in SWoC and worked on many more open
source projects such as google-deepmind and opencv. I am currently in my 3 =
year
of college where I am studying B.Tech CSE with minors in AI/ML and I
have always been
curious and am known for good communication skills and for a creative mind.

On Sun, 15 Mar 2026 at 18:01, Pushkar Singh
<pushkarkumarsingh1970@gmail.com> wrote:
>
> Hi Arsh,
>
> > A rough draft of the proposal is attached below.
> >
> > I would greatly appreciate any feedback on whether this direction
> > would be useful.
>
> It would be better to share the proposal in plain text on the mailing
> list instead of attaching a PDF.
> That makes it easier for reviewers to read inline and give feedback
> directly on specific parts.
>
> Best,
> Pushkar
