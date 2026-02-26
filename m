Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FB3A0E94
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098045; cv=pass; b=oBUu1w6s08J9jbJgb+2nin2/J2iPHEGp9GD4TmWxxMA2LX3pCR/OKIUla6bA94aV9DE886Yom4F1hEBTwOkSN5LdvflAKSfcHCslTrxQTanUMFBkQ6hmPk06bzwNRMsePxHd7LEBNtnvTQPv4bzvcq/muIuYVXiLCKU2Ii+RpRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098045; c=relaxed/simple;
	bh=jAN+3WRdwHw+e7E3oN5i7qw+Bq5ioTezG73YGJiXpJ8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7jkseO1b6PTifZBmrKsYaHOwZQtCpsuoERvIHDv3tHeayBT4WiNrwF0FUg5t9DPP3fmcaf6DJx8WpGiqPpCoB+g2eLXDIIN9PxpBlvRAx+wq/EhX3O+76gTsiIp6Sh3ZgEkxLnzqVCxZGkkzlfLtRXSZgixfFukwbfzstF49xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIfrmE/C; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIfrmE/C"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56a8d7bb872so794721e0c.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 01:27:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772098041; cv=none;
        d=google.com; s=arc-20240605;
        b=hQejGvuWzqqQpZqS7I3mCVJQMXO8rJpzAlbSiKWcueNEMznGFbwMQoIDQnD9WJQhhL
         tpByJODemj3gbalmOp8YiDJkrULcOU1K4nMidkdJTjPre46xogr03U4I3Pu7lBbc2W2R
         XT04MzaKnvT4vyR4AXTHwmYokMn594klL0Q7OLPtdNYDJoI4kmSdNCIaDAPjthNh4WGU
         e4xgp/QWKD/o5Omal52jEtq3F7dV8ipWruwh0aU3EUesW9WwqZYCyNhmKYq2jDgyA484
         DxcEfkn4KsO4A3KrZGd8WQa/PvIg6+uN66Dt30UdwFX/lF1SxhGduilYhARVvFEjKwLD
         YpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=QHMSDq18FEb3jkxj/8CDuwQmacIl+g2zrT+fNE+W9ag=;
        fh=NHcSxoEZmGAQKwxj0VK7htoH9aWGrHTbW87oIzTL0Yw=;
        b=L/UpTRSowSPqOZs3rcb7FzQe0ssBjRmjSPP69cBrqRdSazjEyuGMtNmL+wpO7hB2Mh
         EGuURZneWIhwQbSrL0IBWNj2sVkZ0POTdvKY61wgQPI8u/AvmRhyKOHy8ezpJgY67Qca
         C3RaH22QjKSEtTVGtGSK0CE0FGQ2omLwNSzmvC1/ocbrCj+UqV6g/Et0iX6sicdoPVUu
         DPLOMpkFdYPeU5BMKhPBZ8yxmbd3P4Bo3PbQmV2Y7ne0c/EB7diomM5gFmIr6gM48YMN
         HM4amxSgSBiKRJhLyNFVjSjBfABUUIoIrReojLgnd/QJoKyfO9uoBxsQI8gnFOPj0+FD
         S+Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772098041; x=1772702841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QHMSDq18FEb3jkxj/8CDuwQmacIl+g2zrT+fNE+W9ag=;
        b=cIfrmE/CpI4SW6kWlnTdeQ/azXE21Se9HS/+YTE0y2ITk5BA4wGl0pERW+DchYFJ2x
         fhXIuo+CxfO7wLiGwovP0iuF4P7TnYpUIvP/ry6iTPeAWfgKcDHN7aDn1dui2Bu3u2r9
         OnEL4j87dMASioxuztPllzCpML+LzfQPiQr+sJdc1xcfmZzYTMUtRnLhcqPLBwyeK2qC
         3rSn/NEwsGX4EKpqm+tVExryOVs6l1rTV/6hVvXQwv6GrGAKhdXwENhIbGkbLtQ3aBiH
         8r2r6sAn0XFQXSONfJzedRl7k6CCEp4tyxzVjnhAU72R4yeKOlZQMpATCQ2uLAGLqFlz
         fXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098041; x=1772702841;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHMSDq18FEb3jkxj/8CDuwQmacIl+g2zrT+fNE+W9ag=;
        b=kcMsq5shSUegT1c1T22Rhz2YphRh5f+LV+xaxD7XOUnn+JBh3JXrT5yIp9MmUa0qSB
         Jb1L8pAMHw/vINx1noBGW6LsneqeJBHLij+8vScgpQfYJ7dwhdPSJuM6n9sL90rpV6Cl
         sFw81ABF7E55aRjWi/FA9NbKiYh+2VaL+KHggSBxBreat6q0SuqWmZa/G2n1MdmgxRir
         F7OQQO3hZ3m/BXZNLMb8MlfJL6w5IPFOAZQch06IeFFOrVDrqlCmAx3Le2VBcDucZMQx
         F5VO/xNojisHkM0k+5eHT3bmizhg/kku0SVBvzVBy2ovomwFlXaB40duoVAj5c1VfQBE
         HnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsZtw3DuFcGO0zJgqWn4RcWP4CHOpPkYEsBAzFDcoW8/YdRXMA+PkPFRkFf+UDSsBikHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CWXbkE3s8lEfxhBrtqELg1Jv8gzMT9cqsPZDdBEo7fmAlJiI
	10ZDBEpeaQ7olSRBtV73iABVGN7RblhO2wCxfcpZtx1YrCdZ7cwkRRR1hFYmM3yPXAf7mwP1PMX
	9SWDreOcKJ+bz4vjCb6kS3O8y4/DhLgU=
X-Gm-Gg: ATEYQzwqOmaQhAzjwMNfTb/r+9arBt+knityp1gpw1yk3OJ8jwpBh7vUd7RCllXTfcf
	taL+2LFMlT+3BKT8vAz5tvzOk/Ha/Fo+DIjsTdb3I9ewcfu6yMXgSFX7UpKjhbtV7dWdY7HKZjH
	OhKZCClKqZNdRY8UjW6p8TtM4pEVi8wIB6mZ/HRjV7q3EYFNaPJwIZZ43ce0ePPPeQCGckgO1n2
	O+Jl8dej0llD+a7wnZ4aXOJfXD7qJK4SOoZXahE/YE/KJoy9BvdyLXYhl8/N3dyNL4aWODdR/yX
	V+3pJRurXhOAVtqJEiP30dLCEVsmRmcWqv0C2ytEOA==
X-Received: by 2002:a05:6102:dd3:b0:5ef:ac78:3c77 with SMTP id
 ada2fe7eead31-5ff20a672f9mr734915137.18.1772098041071; Thu, 26 Feb 2026
 01:27:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Feb 2026 01:27:20 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Feb 2026 01:27:20 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <b98780d7-3aa9-4838-9234-290b1d72ffd7@gmail.com>
References: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com> <b98780d7-3aa9-4838-9234-290b1d72ffd7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Feb 2026 01:27:20 -0800
X-Gm-Features: AaiRm50EejZ8in2C50NybO40ao6AZXYt95N7q5c63p__WM64ZHiB2_3zvwL6CfY
Message-ID: <CAOLa=ZSyeNg7kSGV4=5wg02FYomGe0CbJ7GzCzT6okC64UWHMA@mail.gmail.com>
Subject: Re: [GSoC][Draft Proposal v3] Refactoring in order to reduce Git's
 global state
To: Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000003eeb78064bb6bae3"

--0000000000003eeb78064bb6bae3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tian Yuchen <a3205153416@gmail.com> writes:

Hello Tian,

> Hi mentors and the git community,
>
> Here is the proposal V3.
>

[snip]

>
> -- Approach
>
> The task at hand goes beyond simply repackaging the global variables
> into the struct repository structure. Based on my recent experience
> refactoring setup.c, I realized that libification requires careful
> management of variable lifecycles and api boundaries:
>
>      [ Current ]
>      Core functions --------reads-------> Global variables (via getenv)
>                                           [Thread unsafe]
>
>      [ Target ]
>      Core functions ----passes context--> struct repository
>                                                  | owns
>                                                  v
>                                           struct git_env
>
> Although the principle is simple, the scope of changes is extensive. The
> following three-step approach can serve as a guiding principle for it:
>
>    1. Identify isolated environment variables currently residing in the
>       global scope. Introduce a dedicated structure to hold these states,
>       e.g. `struct git_env` within the `struct repository`.

Well it depends, we already have `struct repo_settings`, and individual
settings within the `struct repository` struct. It would be a very case
by case basis, to understand which variables fit where.

>    2. Instead of blindly passing struct repository *repo down into every
>       single low-level library function, bubbling the dependency up is
>       the true goal. External callers of the functions must be carefully
>       audited to prevent regressions.
>    3. Safely remove the old global variables and macro definitions. Tools
>       such as AddressSanitizer can be helpful to ensure that the new
>       struct-based lifecycle introduces zero memory leaks.

Yes, we also have CI jobs for GitLab and GitHub which do this already,
you can run them locally too, meson makes it very easy to do this too:

  $ meson setup address --fatal-meson-warnings --warnlevel 3 --werror \
  --wrap-mode nofallback -Dfuzzers=3Dtrue -Db_sanitize=3Daddress \
  -Db_lundef=3Dfalse
  $ cd address
  $ meson test

>    4. Many globals like are parsed once and remain available globally.

I think you're missing a reference in this sentence.

>       New data flow might need to be designed to maintain the lazy-
>       loading efficiency.
>
> Additionally, given the anticipated high volume of commits, we must
> ensure each patch is independent and atomic, preventing any
> user-untraceable or unexplainable bugs from occurring in the codebase at
> any state.
>
>
> AVAILABILITY
> ------------
> Fortunately, my summer vacation coincides with the GSoC work period.
> I will treat this project as my primary focus, dedicating a minimum of
> 35 hours per week. If needed, I can work a 9-to-5 schedule.
>
> I will have a significant head start to draft RFC patches before the
> official coding period even begins. Having this buffer period allows me
> to go through the rigorous code review process within the Git community
> with greater ease.
>
>
> TIMELINE & MILESTONES
> ---------------------
> Considering the differences between this project and other projects on
> the idea list, rather than hoarding massive changes, I will submit
> 3-to-5-patch series frequently to respect reviewers' time and maintain a
> steady velocity.
>
> Below is the tentative schedule I have prepared for myself:
>
> * Community Bonding (May 1 - May 25): Planning & RFC
>    - May 1 - May 7: Wrap up university finals. Discuss and finalize the
>      prioritized list of subsystems with my mentor.
>    - May 8 - May 25: Define the core context container. Draft and submit
>      the initial RFC patch series for this new data structure.
>

What is the 'core context container' here?

> * Phase 1 (May 26 - July 10): Foundation
>    - Weeks 1-2: Plumb the context pointer (`struct repository *repo`)
> through call chains for simple variables (e.g., boolean flags or integer
> configs).
>    - Weeks 3-4: Audit and update external callers to use the new API.
>    - Weeks 5-6: Submit the first major refactoring patch series. Address
>      mailing list feedback and resolve merge conflicts. (Midterm Evaluati=
on)
>
> * Phase 2 (July 11 - August 18): Complex Migration & Cleanup
>    - Weeks 7-8: Refactor higher-complexity variables (e.g., path-related
> globals).
>    - Weeks 9-10: Compile the codebase with AddressSanitizer and run the
> full test suite to execute strict memory leak checks.
>    - Weeks 11-12: Remove unused global macro definitions and static
> variables. Update internal documentation and write the final GSoC report.
>
> (The above is for reference only. Personally, I always finish tasks
> faster than planned =F0=9F=98=89)
>
>
> ~$ git checkout HEAD@{postGSoC}
> -------------------------------
> This past month since joining the Git community has been the most
> enjoyable month of my programming journey. To quote a close friend of
> mine (who is applying for the Neovim GSoC project):
>
>    "Only fools chase trends; open source is the game for the brave."
>
> The words may be blunt, but the logic holds true. This statement surely
> resonates with me (and maybe many other GSoC contributors): our passion
> for code and open-source drives us forward.
>
> Even if I didn't make the cut, so what? ~$ git reset --hard...
> Just kidding. The Git codebase is far too interesting to abandon now.
>
> -------------------------------------------------------------------------
> Changes since V3:
>
>   - Based on reviewing last year's contributors' changes and recent
> experience modifying setup.c, additional descriptions have been added to
> the synopsis & approach section.

Thanks for the proposal :)

--0000000000003eeb78064bb6bae3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 10dcfd1bd44768ca_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tZ0VmUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMmZHQy8wUjVFeWs0UitnYnEzZTlidUtsdm9LUFgvYQo3cFZPVnJSeWJ6
bHFNSUV1RFFXQkJEbHdubndiaG5vVXUvbHBzSHRzS2xNaXJiU3VFY3l2ZERNR05iVG94VGtECi8z
dTRzN1dqYWViMzROWGUydkl2R2hheElsWFc4MXg0bUU3UVdOWW5UTjN4YlRMTzRsNmkyNmd6Rk5T
eWxKc2wKbjl3RnpiNDVWMWJRTVU0a3dtaUVCTEg1WEREYXBBMVpyT1JlQlY1eWFwL2Mza1dGalJu
REE0Vi9hUkh6WUdBRwppemt1M0JXSG5QRkpxcmtDMzdJRjljNWxKN1dXdjFwTWJVOW9yOXExRHVF
SnliemoyWUNUcDFRQWlwb0trNVVIClJUTmZ6dXFmRnF2a0NudDVyWG41Mm5FN21RVmZSaVllR1J3
VHZGbDNmSlhUNm5Ha2lFUkkwbXg1SEE4VHovRVgKNURFS2ZyUmlYcy9JY3g3aWRPYkNYQ2lXVE1T
S3ZIVUJNT0N6akoxYkRCZUNrTzNuMURPekxnZFVQWTVpa1ZWUApMdmFMdUZuZVN1SFEwVXdSOU9q
K0V2bDBPOWNDRlFTNXIzbU5iQ3JNalg2bS94Z3M1djFseWZscGxscm1rRUdYCm5xNkovVm5EVUtF
OGd5c0k5UVphLytCdHBPRER1VEtERnJGVUREQT0KPUY5QmoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003eeb78064bb6bae3--
