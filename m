Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793836923;
	b=wrGEWZaorRRLdB8jA04XrsKr014Dn2N8jupSeBKPdm4WysIIgK73DrOLi+lkh+6V5AbY
	 ePTSzUkPRWrWq1xsTpP8E5Du1fw21UMOdAQWJ51ilC/qO1tTHg6Helk9f8HA3zi1e7V55
	 TDbnhj2gRV54bVdq9VKfWRUD8ajBhK/00y9ljHCKEZT+pwDxjdZyQIWc0f4hnNFq1VLBl
	 LdYOhypirY7V2L6O9Mle0zTRiUntWNeJdyZ9w68PJjiGcfSbdTOorlVXooRG904krfFuQ
	 eeYWUlvUA3A80XDtCS8QcnoD0+fV7407W19v9Fj5wpWvJsdhekz8HLHFGhshLSOTrGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=jIxdThB5LFMW2DntcliBg8sKdpKTA9eKno6LIhgQbiY=;
	b=tuWNMIZr8HKD4DgsrSIBFdgxyZn/7Sxb325R+E9QdDpRpF4asPqPrKKwp7XiPYYl/mRq
	 XWQz/YzBUB8UNsh3xIy/htVbXv6qkYEl6xNNL8tIZ8AsnJNxhMlBZYvwv0kI3qf2BINjh
	 XObmFv0FoSmsGkAjDsOGd1WxEFJKb8HH0OptT4H06Llx800MaRyzxFo2RUVsDclZNjfqw
	 r8R4eA9pX5GcmVO2+eyQt/4Ew3MKuvB+oax2oGvqRzGzVC9wtLJthsXVy/xxrRWOYduBm
	 F+yphTDrUitdR2v5SPf6HJEf5dpsMxWIV6euHX1rQMg2GGbXB1efB09UsIbEHcWU8Xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNksXTrt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5B7606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 00:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C5B7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNksXTrt
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso1936927a12.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 16:02:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793836922; cv=none;
        d=google.com; s=arc-20260327;
        b=f7KzBBj0QhRGGXz/lQeeew8gX/zJ2y+oaxMP3VyEtME4Xe+YyRz5XZuWjOcPfhfBZ1
         kq4JW6KIB5KrD41AqEpUR0d6wyx6hK5I0PeU0NznrWWW8eWV4HIB75H+onOI5Xpn5kbv
         34t8IxY72K6ju8n5iQmSMj5lk2Yrkioiojmpe1LXmRcW1BVPXUu9V9SyjvnKiXP3GOA+
         TcwQ/Z1oVCrqy54U1aotPlPKQ6RGvxx6mlMN6bIa5+YPqc3/t2jvlFh6xQuMkiSJovew
         CWh0SuxRkOIL7faFr2S/iG9dF/A/452PsvSOm/uDPium67+ZduqemUrQVu9lUv36/cvF
         mOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jIxdThB5LFMW2DntcliBg8sKdpKTA9eKno6LIhgQbiY=;
        fh=4xHInuIHhiExv13uXAb+4+l83DouZ84q+4Cj8kHCS3M=;
        b=JRbwwIAdhNFRzh01ibUEYpI0d3HmtkLQD1YtfOfBKGY0BFG5UZyZsPcFr3qPdGU6t8
         rCaPOF54jCBdJHHh5ADqMGoqMxcDyzJPJkRNA5f+deOlO8eCju9cN9GnioQiXB5CGVKt
         NKukb6DG1CACPekeDkXmi0TLSe2dcLPUwJ9hC4fag60iwonVo02Ee46Fz/wfFl/euldL
         PYI0Jr5yChdT/fWddGi2fQkm/l+5fGn1iWaeW1s764RydU2aIiPm+2LXgh5+6w83SzJD
         4D/r3aCGlL+InctNetM6/HCDRJRmRZCpkVNGKPyvCJPxqlSEl7JCTvKCG541MfWubT4Z
         bzxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793836922; x=1794441722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jIxdThB5LFMW2DntcliBg8sKdpKTA9eKno6LIhgQbiY=;
        b=nNksXTrtC72iYBjEy7ZIx4EuQYK36lSjzGhSTMD0PxWUZeAUXp60YbNEbKWJ1td+Sc
         zAMWyQhVKHlWC1oBC6fFNySmPJCkUld0jkbe18XOuCJUOcvkLy7kwZwaDGjj0e3DQsoo
         8Uj0mVKuK4WwtAHfsAgXc9sHGA9Fv8I0IIUxnFYwKF32yEYoT85xl594sK0vCy6W1xKB
         k9agjPj6Ob0+4AvhWhY4TcUtReaC7XIQBCcQ6E5aI+2X72bDm+WpMuleHy8Qe3DZ+Ps6
         pHnZpNE+NDsenUZ1zKlf1lVG5HHGThogOoh4HZGabhsmP6Itw4Ucv+y2EDUxiBUL4sbh
         tuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836922; x=1794441722;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIxdThB5LFMW2DntcliBg8sKdpKTA9eKno6LIhgQbiY=;
        b=N+YRA2om0qfg3PxzaO0pJykuBoVHao741AYsLsDDu6VrW5phkZuyJA58O2nhygPrMy
         jxr6L1L71w4ejKKL2zm1Bc5hQmH2rQADnTlv9Nk4/FHo3NMMghiQ0F0xJVZC1J8dPNXc
         KV83dzEng8xevlxNlRdGjzC9xS5EQnqMtHTl6nAIuRW3lVmE6KQKxg8agU5YbASGf8Eb
         BnbdO/ccbxhpEg76q0VV6SIHP8Z6AQnSeKxUG45k/xZssmdpNiwEF0HHFk1Pi2McXvDK
         st/rfMD97NsYb4yQYhqfjJ2ei2ELoHjkiZZbN9de57x5DDF4XtQQkJieMYR9/Q8wAhzG
         S39g==
X-Gm-Message-State: APuU4Z/olz2N1ruHJzCXMqubIfK8c97QSeFxuw7jNEqZdmjIm3esyfOW
	XAOJey0dkNkpNEPg17+sV4OrkNbwkep3B0N4k9A5i/fmiXvbJHJ4tYZB/ml7wQUD6ZKi0oZuSC+
	ccOLujycI2PATaIMAXKauO+hfWqeU0Ng=
X-Gm-Gg: AYBFou0wLsnPASWVVyEYHpZCUq44RCtmpbD641W26cczMVoVW+PDMR7+hzX+zpJTFuJ
	NUclSVnNGwS2jUUZLDnb8an5s5eIuyo6y6IoaFN8uTBB5yMGtGMFLo3sp4eI9AUgFu+pgrjcNYZ
	Wyq0phxkGCW3OZoLPzPxBdb4F+3li1K4KiplXCAyO0M+xzQQVE/WYfohfdD1hW551N0tyJOesWd
	bTVtNHln/9GneJmrQMtMSyFHSKJ667o5xT/7TPob/xpZjIfmc5kJ91hIzHMFN93vj96IxfLlCh2
	ehinZhnMUzqAx7WmE9ajF2tkTk013D3Ib5fuXjrVZH6z63eJ7BaMwkAHlpEO3KInLIQg55Fkr+7
	wS0vYw3lBSTX0gWyUfYKOGQYzmdSXW51RxxwEhImC932FlIq2WNg3Q4UQ7fI1OLd2mt1Y1d4=
X-Received: by 2002:a17:907:969e:b0:c40:f89f:d91d with SMTP id
 a640c23a62f3a-c4ca7a6aff0mr1556975866b.28.1793836921624; Wed, 04 Nov 2026
 16:02:01 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CABh_KWjfH6iXNwFkzskpM_sijj5rgDiFEnqs57HJ7jmumcYTfg@mail.gmail.com>
In-Reply-To: <CABh_KWjfH6iXNwFkzskpM_sijj5rgDiFEnqs57HJ7jmumcYTfg@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 5 Nov 2026 01:01:49 +0100
X-Gm-Features: AclHuK-kp8lMEuMqn4b-20tYraZhu6hC4xj0ye4hWaT8uuyAZnpJGziCN2d0N3o
Message-ID: <CAPSxiM_dPOWkRTWrVQcgqZELUET19ymokecj_T4VenM9EfHNSw@mail.gmail.com>
Subject: Re: [Outreachy][Proposal]: Reduce Git's global state to enable Git's
 libification[Outreachy][Proposal]: Reduce Git's global state to enable Git's libification
To: Srujith Poojary <poojarysrujith@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	kaartic.sivaraam@gmail.com, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:28=E2=80=AFPM Srujith Poojary <poojarysrujith@gmai=
l.com> wrote:
>
> Hello Git community,
>
> Thank you for the guidance on sharing the proposal.
>
> I am resending my proposal inline so that reviewers can quote specific
> sections and provide feedback more easily.
>
> I would appreciate feedback on the technical scope, implementation
> approach, regression-testing strategy and feasibility of the proposed
> work.
>
> Proposal: Reduce Git's global state to enable Git's libification
>
> 1. Introduction
>
> As a BCA graduate, I have a good foundation of programming and have
> worked with some programming languages. I have practical experience
> developing software projects and contributing to open source projects.
> While learning how to use Git and GitHub for version control and
> managing changes in my projects I became interested in using different
> publicly available open source repositories. This led me to become
> curious about how Git works internally, How its source code is
> structured, and how its developers keep such a huge project going.
>
> This pushed me to look into the source code of Git. I learned about
> the C concepts that are needed to understand the code such as
> pointers, structures, functions and looking at how the different parts
> code communicates with itself. I looked into the Git code related to
> repositories and learned about concepts such as the_repository, struct
> repository *repo, global state and explicit dependencies. This taught
> me that when contributing to a well established open source project
> there is more to it than just writing code. You need to understand the
> existing functionality, look at past changes and ensure that the code
> is tested properly.
>
> I made some contributions while preparing for this project. I made
> changes to test scripts, test-path and safe integer arithmetic in
> diff-delta. I worked on a submodule-related change involving
> repository-specific commit abbreviations and made an updated patch
> series for review. I gained practical experience of looking at
> existing code, creating patches, testing and getting my code reviewed.
>
> When i got to know about this project is while watching videos on
> YouTube about Git and contributing to open source projects I
> discovered Outreachy. I submitted my initial application and looked
> through the list of projects available. I found the Git project,
> 'Reduce Git's global state to enable Git's libification'. As I was
> already interested in Git and GitHub and had begun learning about C
> programming, I decided to choose this project as it fit my interests.
> I began preparing for this project by completing the microproject,
> looking at Git's source code, looking into past changes and
> researching potential areas to contribute to for my main project.
>
> I am interested to involved with this Outreachy internship project for

You might want to change this line to something like:

""I am interested in contributing to this Outreachy internship project"

> December 2026 as it will give me the opportunity to understand and
> contribute to a key part of Git's internal design. I am interested in
> understanding how to replace implicit dependencies on global state by
> passing the required repository or index information explicitly. I
> would like to learn how this can help make the code more testable,
> maintainable and reusable.
>
> I hope to boost my C programming and problem solving skills during
> this internship. I hope to make useful and thoroughly tested changes
> to Git. I am happy to look into the existing implementation, talk to
> maintainers, learn from code reviews and improve my work using
> technical feedback and collaboration with community.
>
> 2. Understanding the Project
>
> 2.1 What is Git's global state?
>
> Global state is information stored in variables that can be accessed
> by different parts of a program. A global variable is declared outside
> a function, so more than one function can access it. In Git, global
> variables are used to store and access information such as repository
> details and environment settings.
>
> One important example in Git is the_repository. It is a global pointer
> that gives access to repository information through a struct
> repository object. Different parts of Git can use this pointer to
> retrieve information about the repository currently in use. For
> example, the_repository->index accesses that repository's index.
>
> The problem is that a function can access a global variable directly
> instead of receiving the information it needs through its arguments.
> This creates a hidden dependency because the function relies on
> information that is not clear from its parameters. It can make the
> function harder to understand and test with different repository
> contexts, and harder to reuse independently. Reducing these hidden
> dependencies is one reason Git is working to reduce its reliance on
> global state.
>
> 2.2 What does libification mean?
>
> A software library refers to a set of code that can be used by other
> programs to complete specific tasks. This means that we don=E2=80=99t nee=
d to
> fully implement something from scratch in our application.
>
> Git was originally designed as a command line tool. This means that
> different sections of code can access the same information using
> global variables. Libification makes Git=E2=80=99s internal code more sui=
table
> to be used as a library by other applications. This can be an issue
> when trying to use Git=E2=80=99s internal code in other applications as i=
t can
> cause issues due to relying on global variables.
>
> To fix this we can pass the necessary information into the function
> arguments. An example would be passing a struct repository pointer,
> such as struct repository *repo, as an argument so that the function

Passing a struct repository *repo as arguments to a function, while this
is true, I believe passing the repo as an argument to the function is just
a means to an end which you already mentioned, as you said the main
goal is to remove the reliance of the codebase on the global "the_repositor=
y"
and use the local "repo" instead.

> can access a specific repository. Or passing a struct index_state
> pointer, such as struct index_state *istate so that the function can
> work with a specific index. This makes it clear what the function

> **Output:** A technically justified follow-up contribution, or an
> improved initial contribution.
>
> Week 11: Review and refine the implementation
>
I think you missed the blogging section.

Thanks for your interest in the Git project and do not forget to
submit your application on the Outreachy website. I believe you can
edit until the final deadline hour.

Usman.
