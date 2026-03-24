Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D01D6BB
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 00:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310981; cv=pass; b=YAxhaosWRGk32B9asdLhGCJRZJpgZXQwLx1VdvVizrDTrKo4kCOtHXtN13SqrrBiPxfIMEDWZbcb1HrI8mvKzkpqLhb8+Qc8H+IHDi818StpKoXOYPPykpoIBHo+lLzwmy7jZo44tI/SATcQfZU0Dq0R1ggLfHLZeJyPJEl3kOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310981; c=relaxed/simple;
	bh=XLHr9aUSRoYGzifvBVRGE9//yvH+vnW5UJB4+j/A6DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=E6b4fwjwA6X3lNnNIkWMJXDl1uyIM7BtCV9WE2jXZfD25M4Tn01F7Grb2g9SR3VIwoISr4ffYtZt0kdkD7W4tsX+Wb96Ijinjt91MVuXZv9QUZ3mps2LhlmnqH8AMilY0Iqnv5FcrOmiG6fzqv+CKY301zA2EhmDSxlYtdBbREs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nth3rXYu; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nth3rXYu"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ca6595c8aso2704161d50.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 17:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774310978; cv=none;
        d=google.com; s=arc-20240605;
        b=ZMTTqqUqOglDMBJMAhWnIOykYIhcmBIXJhjY2o2H2+vw7Ujm7I6Ip5AxP2P7F/+1H+
         45pspeHGjjBZvaZyHv3tSXvzVBtMTveNrVxeK7bKjr5dJCzk0DcQjNIuXdo/6ahsv/ii
         8dFOcSebyGRG+S/BVqvaWnuJhBV9KIUt+zVfLP7eIA2R/Kp/6+u3heaZbaYl0F6NB2jY
         wY6HzQf/wT9Obgg/5zWJuXjab608v9IaTR98LaysF+aqplUA44Dbblq7nwM2R//ii0w0
         LbH97j0OzMNbYasXHdHAaVJmXVWHWqbF04krdh6LnDzo2q0a9wAgjSclnklNnsOcUmGI
         DQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLHr9aUSRoYGzifvBVRGE9//yvH+vnW5UJB4+j/A6DI=;
        fh=3vrNMW5gSLzoCwgW88K2VdAS6dDO0/RCWkho8ZAKbrA=;
        b=I1HWXRfuPKeb6t0osDe9HEutnAbrG6QAKpyf0FkLs8hpn5VQzXeBubsODX+5tbeUOT
         PPdaciVWZ0PWV8XoIckSEW27acEdsD/t3Ko5nt3V56dpfGBQm1HSjI9JW4d6fWM59m6V
         l6vu4bFsMCnFRbgChz+ILiMtdFw0aM3nruJtPGUYG8NYXzk1iDnTv2RC0wo3jTljcDFb
         bXzDGkhBufpOnsi0fJz4NX4PTw37RGMEclLM5IKJf88GpX62tUKLw8gMq2WkugPxtmgu
         7JNJuaqYkabZq4cKnwFD7vTH3pguf/JM5IPrpmAaiI01k3i3Q7DapeuzuPMToQwb3cj3
         NQwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774310978; x=1774915778; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLHr9aUSRoYGzifvBVRGE9//yvH+vnW5UJB4+j/A6DI=;
        b=Nth3rXYuw8ZWADYyB3mLQDEW0ZqEHpVSt5BHgWfBemxXausz8niJhStv3kAr0cWxKa
         LCXNU8wW+waWQZVuHGGTTs0/+F3Z9LuFhioR+Bt9Ov7ksrd+mE7DRDEX6Wf0URY0fzIA
         +hSf5oY0LM2ZbiAzZlwqzHqQIi0jbbBFdMw9jaXkDU5EGuAC2it+7C5o0ZKpnI6at66V
         W+M0QlZyFH3+Bc4vVEwusBXimRUuIr/snlUwFqsRlFgzw/fHdqC+mMTzYOgzNZdl0UV2
         97e9JgqqtQa3AQU9NvdZJQnPjQWdEtMxnIO7ME2lJJWi5RGMsszAahg2dZPnWj0vJusF
         rLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310978; x=1774915778;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XLHr9aUSRoYGzifvBVRGE9//yvH+vnW5UJB4+j/A6DI=;
        b=qw4xffE5XA2sqwO4/dY30jAXk+KxtSlmMsDIO9FCUAUM92ERPi84Ys4JKQXa98hblc
         oN5J296W2PIoH8YyY5e46NtUz2u0xgulL28WAwNX0O/1sfiy2s0BB065pqHaxhhloNVF
         IDU6GOY7V+3Vtvv/dXIWvg0ZQtVp5ewZjmTw6qjYRGe6tvdZZGCGTLnH1CHjPEEO00B0
         CQp4QFRMERYGsEsI2JveTPhkhPu2KpanFOKNAN62hlF192pVVS1KBRoJK6XnPILRoxIc
         BBYDMurt2pIEUhjIx7qMYwIoJtnVdeK31g7Gx23U8hPyA9cO3q9l+BNd90/1lnKogNwu
         JULg==
X-Gm-Message-State: AOJu0YyCTN2s0JNOXnc3j0epBC+683ywOqFigodr738bMCWRW//0OpLW
	v7TZTiyx5k8yX8tcQ+q+YbKXT7BwIyLs+oI954BU3/BUA4flkBpakzomSS8UKZ/ThyUxI0j7qnf
	xSQn4guoZkq0l7v5q5WrzS/zLkpNlxuArz1X4qStnVw==
X-Gm-Gg: ATEYQzxraVhHtHaKC9PDvv/fU2AhWewtDJjkYcOS/PPO95+TiVi2RNlqSMVNEH/PB9j
	eaYo6RqcJ1qWwbmpTwG7ZyWM2EliwFHqvri88SAQLQHg0FVbdbdPBVnELWh2qEvnQAz0+jzY/8A
	Z52LXZB7+qVciOrXKVAg6wacBNlxuqC2TS1Ax0NcmD1/UJpqV8MA0HzPGYVBnOSKY9eLQRbyHI3
	syUU7G92ZKJUk0ktdk6uWKhEldILsWFfYPqHaCi3xo3JO+pvOvh9XCYhrRRmFggGnLC+jZzpSoG
	BTQ1RhnqSVbh6aqK0Od9o+MeS5XF9mlA0fYq5KQ=
X-Received: by 2002:a05:690e:2557:b0:64c:a761:7f90 with SMTP id
 956f58d0204a3-64eaa71db74mr11498296d50.36.1774310978213; Mon, 23 Mar 2026
 17:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPvEtreC_kRh7NW3JNfNkH+E-T1iK5XQ6aS81dtAVujGD=CzLg@mail.gmail.com>
In-Reply-To: <CAPvEtreC_kRh7NW3JNfNkH+E-T1iK5XQ6aS81dtAVujGD=CzLg@mail.gmail.com>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Tue, 24 Mar 2026 05:39:26 +0530
X-Gm-Features: AaiRm51hxJIayuYBQlL1Jb8Gp793KYQmn20mvlL6OPaO30qJpBXSC_NGt0JObGU
Message-ID: <CAPvEtrdpJ5AHw+461ffkMmSXrtsi1vpQHKUQAW+9GZwoaifF4w@mail.gmail.com>
Subject: Re: [GSOC Proposal v2][RFC] Improve disk space recovery for partial clones
To: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>, jltobler@gmail.com, 
	christian.couder@gmail.com, karthik nayak <karthik.188@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

PDF Version: https://docs.google.com/document/d/10H_FybR9Er7iDVwkisIRvjIZT_=
tEldwSu9jOZo7DRps/edit?usp=3Dsharing

On Tue, 24 Mar 2026 at 05:38, Amisha Chhajed <amishhhaaaa@gmail.com> wrote:
>
> Hello! I am Amisha, I am interested in the project Improve disk space
> recovery for partial clones, I would appreciate it if I can get
> suggestions and improvement comments for my proposal. Thank you so
> much.
>
> Improve disk space recovery for partial clones
>
> Mentors: Christian Couder, Karthik Nayak, Justin Tobler, Siddharth
> Asthana, Ayush Chandekar.
>
> Project Size: 350 hours
>
> Difficulty: Medium to Hard.
>
> Personal Information:
>
> =E2=80=94----------------------------------------------------------------=
------------------------------------------------------------
>
> Name: Amisha Chhajed
>
> Email: amishhhaaaa@gmail.com
>
> github: https://github.com/amishhaa
>
> Time Zone: UTC +5:30 (IST)
>
> Education: SVKM's Dwarkadas J. Sanghvi College of Engineering
>
> Year: 3rd year, 6th semester
>
> Degree: Bachelor of Technology in Artificial Intelligence and Data Scienc=
e
>
> About me and past experience:
>
> =E2=80=94----------------------------------------------------------------=
------------------------------------------------------------
>
> Hello, I am Amisha, currently in my penultimate year of engineering.I
> am deeply passionate about contributing to open source and find great
> fulfillment when I see my code helping people. Given this motivation,
> I have contributed to various open source projects and the experience
> has been extremly rewarding and ethereal.
>
> Apart from open source, I make art and I like building games.
>
>
> I am currently doing my LFX at OpenTelemetry, my project is about
> building a GO CLI tool that runs tests of the dependents of a GO
> library to record any regresisons caused by new changes in the library
> (more about my project:
> https://mentorship.lfx.linuxfoundation.org/project/5f537fc2-548b-487a-99e=
d-c61f7e8bcd47)
> (list of PRs created until now:
> https://github.com/open-telemetry/opentelemetry-go-build-tools/issues?q=
=3Dis%3Apr+author%3Aamishhaa)
> inspired by Rust's Crater(https://github.com/rust-lang/crater), this
> is a project/tool that I really love as it is the first time i have
> made something E2E with a huge impact. I interned at Google for summer
> of 2025 under team workspace serving infrastructure. Some open source
> contributions that i am most proud of are in bitcoin core(refer
> credits: https://bitcoincore.org/en/releases/29.2/ my PR:
> https://github.com/bitcoin/bitcoin/pull/33482) and git :)
>
> My contributions in git:
>
> * cat-file: exit code of 'git cat-file' is suppressed by piping it
> directly into grep.
>
> Status: Awaiting review
>
> Mailing List: https://lore.kernel.org/git/20260113180409.36683-1-amishhha=
aaa@gmail.com/
>
> Log: This was the first patch i ever created for git as a
> microproject, made me familiar with the mailing list workflow.
>
>
> * sparse-checkout: optimize string_list construction and add tests to
> verify deduplication.
>
> Status: merged in 'master'
>
> Mailing List: https://lore.kernel.org/git/20260121130005.72375-1-amishhha=
aaa@gmail.com/
>
> Log: This is a really important patch for me, improves O(n^2)
> complexity to O(n log n) of sparse-checkout by building a sorted
> 'string_list' by constructing it unsorted then sorting it followed by
> removing duplicates, this triggered a series of patches and uncovered
> various bugs when i worked on replacing calls of string_list_sort()
> and string_list_remove_duplicates() with string_list_sort_u().
>
>
> *u-string-list: add unit tests for string-list methods.
>
> Status: merged in 'master'
>
> Mailing List: https://lore.kernel.org/git/20260129121220.69267-1-amishhha=
aaa@gmail.com/
>
> Log: Adding unit tests for string-list methods which i saw were not
> present when i was creating a new API string_list_sort_u.
>
>
> * string-list: add string_list_sort_u() that mimics "sort -u"
>
> Status: merged in 'master'
>
> Mailing List: https://lore.kernel.org/git/20260129121220.69267-2-amishhha=
aaa@gmail.com/
>
> Log: Adding a new API string_list_sort_u and cleaning up the callsites
> that can directly adopt this new replacement, string_list_sort_u
> mimics sort -u.
>
>
> *sparse-checkout: use string_list_sort_u
>
> Status: merged in 'master'
>
> Mailing List: https://lore.kernel.org/git/20260212041017.91370-2-amishhha=
aaa@gmail.com/
>
> Log: Small fix to replace a callsite of string_list_sort and
> string_list_remove_duplicates with string_list_sort_u.
>
>
> *help: cleanup the contruction of keys_uniq
>
> Status: Will merge to 'next'.
>
> Mailing List: https://lore.kernel.org/git/20260311192453.62213-1-amishhha=
aaa@gmail.com/
>
> Log: Cleaning up complex callsites of string_list_sort and
> string_list_remove_duplicates, this one involved finding a test case
> that demonstarted a breakage,
> https://lore.kernel.org/git/CAPvEtrenMBMFaMxcCR4VwoyMFU-_Z+bqq5nJaWv5eyn3=
HRutEA@mail.gmail.com/,
> then replacing them with string_list_sort_u, another bug found as an
> effort is https://lore.kernel.org/git/CAPvEtrfEZXHxcDf=3Dz60ODfUA8cS81rhF=
1y7KEZApEBby7aCa1A@mail.gmail.com/,
> this is still a pending bug which is good to work around in future, I
> have provided a test to demonstrate an existing breakage.
>
>
> History/Background, Overview and Project Theory
>
> =E2=80=94----------------------------------------------------------------=
------------------------------------------------------------
>
> The "Partial Clone" feature is a performance optimization for Git that
> allows Git to function without having a complete copy of the
> repository, building partial clone was a community effort, with
> contributions referenced here,
> https://git-scm.com/docs/partial-clone#_related_links. Most of my
> knowledge of this project came from researching and reading blogs like
> https://github.blog/open-source/git/get-up-to-speed-with-partial-clone-an=
d-shallow-clone/.
> The talk https://www.youtube.com/watch?v=3DYdstUWcg5j4 by Derrick Stolee
> are good sources to learn about how git currently handles objects.
>
>
> There are 4 types of clones that we support, full clone, blobless
> clone, treeless clone and shallow clone, each of them have their own
> set of configurations that tells rest of git what objects are OK to be
> missing from repository as they are promised, git stores objects in
> .git/ folder under objects/, these objects can be of 4 types, tag,
> tree, commits and blobs. When we partial clone, git writes the partial
> clone type in config file inside .git/, for example,
>
> (base) amishachhajed@Amishas-MacBook-Pro .git % cat config
>
> [core]
>
> repositoryformatversion =3D 1
>
> filemode =3D true
>
> bare =3D false
>
> logallrefupdates =3D true
>
> ignorecase =3D true
>
> precomposeunicode =3D true
>
> [remote "origin"]
>
> url =3D https://github.com/python/cpython.git
>
> fetch =3D +refs/heads/*:refs/remotes/origin/*
>
> promisor =3D true
>
> partialclonefilter =3D tree:0
>
> [branch "main"]
>
> remote =3D origin
>
> merge =3D refs/heads/main
>
>
> Each promised object has to be on some of the remote otherwise our
> partial clone is broken and we do not account for broken remotes.
>
> However overtime a lot of objects might be fetched and currently there
> is no functionality that, first checks if an object is present on a
> promisor and then we can remove it safely to free up our disk space,
> fundamentally users who make a partial clone want to save up space so
> being able to remove the aquired objects on demand would be a great
> addition.
>
>
> This project aims to implement a command 'git evict' that can carry
> out safe removal of promised objects from our disk space such that it
> can be fetched later on from any of the remotes if needed,
> dynamically.
>
> Proposed Plan:
>
> =E2=80=94----------------------------------------------------------------=
------------------------------------------------------------
>
> Whenever we are evicting something we are unsure of its usefullness to
> users, unless obvious, which git gc already handles. To overcome this,
> we can make a new command 'git evict', essentially this command gives
> users options and freedom to evict objects that they no longer
> require, either it is out of cone or not on a checkout and a lot of
> other situations, instead of predicting what users may or may not need
> we can give them the choice of removal. In a case where users have a
> cone and have set up a maintance task of evicting objects outside of
> cone, in that case we can make it automatic.
>
>
> As git currently treats remotes as source of thruth, we also trust
> those remotes when evicting blobs because if all the remotes break the
> principal of not strictly presenting the promised objects then the
> partial clone is inherently broken, we can display a warning that
> remote might not be able to fetch your file again if it gets
> unavailable on the remote while evicting, however by making a partial
> clone we have already placed our trust on the remotes.
>
>
> Locally i attempted implementing 'git evict OID_TO_EVICT' which is
> available here https://github.com/git/git/compare/master...amishhaa:git:p=
ar-c.
> Steps to test it out:
>
> Partial clone a repository blobless,
>
> (base) amishachhajed@Amishas-MacBook-Pro % git clone
> --filter=3Dblob:none https://github.com/python/cpython.git
>
>
> Get OID for a blob, here i am getting it for README,
>
> (base) amishachhajed@Amishas-MacBook-Pro cpython % git rev-parse
> HEAD:README.rst
>
> 1d2874e9ca4fdcbfc5ef14b0202dd73d707bc9ec
>
>
> cat-file the blob to make sure it is present on disk
>
> (base) amishachhajed@Amishas-MacBook-Pro cpython % git cat-file -t
> 1d2874e9ca4fdcbfc5ef14b0202dd73d707bc9ec
>
> remote: Enumerating objects: 1, done.
>
> remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 1 (from 1)
>
> Receiving objects: 100% (1/1), 3.50 KiB | 3.50 MiB/s, done.
>
> blob
>
> Run the git evict command with the object oid we recieved from the
> previous step.
>
> (base) amishachhajed@Amishas-MacBook-Pro cpython % git evict
> 1d2874e9ca4fdcbfc5ef14b0202dd73d707bc9ec
>
> DEBUG: Evicted 1d2874e9ca4fdcbfc5ef14b0202dd73d707bc9ec from pack entry s=
earch
>
> Enumerating objects: 810655, done.
>
> Counting objects: 100% (810654/810654), done.
>
> Delta compression using up to 12 threads
>
> Compressing objects: 100% (199618/199618), done.
>
> Writing objects: 100% (810654/810654), done.
>
> Total 810654 (delta 608469), reused 810654 (delta 608469), pack-reused
> 0 (from 0)
>
>
> Attempt to cat-file again.
>
> (Without network it should fail at fetching)
>
> (base) amishachhajed@Amishas-MacBook-Pro cpython % git cat-file -t
> 1d2874e9ca4fdcbfc5ef14b0202dd73d707bc9ec
>
> fatal: unable to access 'https://github.com/python/cpython.git/':
> Could not resolve host: github.com
>
> fatal: could not fetch 1d2874e9ca4fdcbfc5ef14b0202dd73d707bc9ec from
> promisor remote
>
>
> (With network it would re-fetch)
>
> (base) amishachhajed@Amishas-MacBook-Pro cpython % git cat-file -t
> 1d2874e9ca4fdcbfc5ef14b0202dd73d707bc9ec
>
> remote: Enumerating objects: 1, done.
>
> remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 1 (from 1)
>
> Receiving objects: 100% (1/1), 3.50 KiB | 3.50 MiB/s, done.
>
> blob
>
>
> However the current implementation I have locally has no validation on
> an OID, to make sure it is a promisr object before attempting to evict
> it, hence it fails when i try to evict a commit object, that is not
> promised in a partial clone.
>
> (base) amishachhajed@Amishas-MacBook-Pro cpython % git rev-parse HEAD^{co=
mmit}
>
> 306c556fdbe7034c9a6d87516534eecdb911ad11
>
> (base) amishachhajed@Amishas-MacBook-Pro cpython % git evict
> 306c556fdbe7034c9a6d87516534eecdb911ad11
>
>
> (base) amishachhajed@Amishas-MacBook-Pro cpython % git evict
> 306c556fdbe7034c9a6d87516534eecdb911ad11
>
> Enumerating objects: 810831, done.
>
> Counting objects: 100% (810831/810831), done.
>
> Delta compression using up to 12 threads
>
> Compressing objects: 100% (200113/200113), done.
>
> Writing objects: 100% (810831/810831), done.
>
> Total 810831 (delta 608149), reused 810831 (delta 608149), pack-reused
> 0 (from 0)
>
> fatal: bad object refs/heads/main
>
>
> So, when user calls git evict, it internally finds an oidset with
> objects to evict based on the flag the user has set, and then skips
> those objects in want_object_in_pack() method, so we would be able to
> evict everything in a single repack operation.
>
>
> Currently on the user interface i am planning to implement these
> flags, inspired heavily from reversing how we partial clone, for say
> when partial cloning i set blob:limit=3D<size> then i might want to
> evict blobs greater than that size in future.
>
> * --outside-cone: Evict blobs that are not part of the current
> sparse-checkout cone.
>
> https://lore.kernel.org/git/735eb76e-44a9-4f79-b769-23a3a07437ae@gmail.co=
m/)
>
> * --large-only=3D<size>: Evict blobs that are bigger than a certain size.
>
> * --tree-depth=3D<n>: Evict blobs with depth > n
>
> * --outside-checkout: Evict blobs that are not part of the current checko=
ut.
>
>
> This project can essentially be split into two parts:
>
> * Given an object, we can use method is_promisor_object() to check if
> it is promised, if yes we can repack our packfiles without that
> object, we would skip those OIDs in want_object_in_pack().
>
> These OIDs that we have to skip will be passed from evict to
> want_object_in_pack() method.
>
>
> * Now comes gathering the list of objects for oidset, for each command
> written above we would need a different method to find and append the
> object to evict, in oidset. For example, for objects
> --large-only=3D<size>, we need to find objects that are larger than the
> size specified and mark it for eviction, similar methods to handle
> such filters have been written in our codebase and can be used as
> reference.
>
>
> * Optionally also add git evict methods to git maintainence.
>
> Project Timeline:
>
> =E2=80=94----------------------------------------------------------------=
------------------------------------------------------------
>
> Community Bonding (Until May 24th)
>
> * Discuss project ideas and design implementation details with
> mentors, possible subcommands to keep and the overall architecture of
> command, any optimizations we can make when repacking objects.
>
> * Study different types of partial clones and how refs work, and which
> OIDs i can evict in different types of partial clones.
>
> * All stages would be accompained by necessary documentation and tests.
>
>
> Coding Period
>
> (May 25 - June 30)
>
> * Implement a basic git evict command.
>
> * Implement evict_object method, this evict object method would need
> to handle different cases when we created a partial clone, that is, if
> we created a treeless clone or a blobless clone, for example if we
> have a blobless clone we cannot evict a OID referencing a commit
> object or a tag object because then refs would complain. It would need
> to handle most of the cases that partial clone handles.
>
> * evict_object method would only be responsible to evict an OID initially=
.
>
> (July 1st - August 16)
>
> * Implement different ways to gather OIDs for the flag that we are refere=
ncing.
>
> * Pass on those OIDs to evict_objects method which would internally
> call evict_object method, that handles all the different object cases.
>
>
> Final Week (August 17 - August 24)
>
> *This is a buffer period for any unforseen delays and prepare final
> report of everything we have accomplished over the summer :)
>
> Availibility:
>
> =E2=80=94----------------------------------------------------------------=
------------------------------------------------------------
>
> I would be dedicating 45-50 hours per week of my time to this project
> weekly. I dont have any other commitments apart from LFX in month of
> May which would be easy to manage given my summer break, so during the
> month of May my time commitment would be 25 hours to this project,
> incase of extensions i have my internship break next semester so this
> would be considered as that hence i do not have any university work
> which would be interfering with the timeline even after my summer
> break.
>
> Post-GSOC and Appreciation:
>
> =E2=80=94----------------------------------------------------------------=
------------------------------------------------------------
>
> I want my journey with git to be a long one, it is very fulfilling for
> me to see my code running on many devices, it is like a dream come
> true for me, so even post GSOC I intend to keep contributing to git.
>
>
> Contirbuting to git uptill now has been insanely rewarding, i learned
> about commands that i did not even know existed, it feels magical to
> know the internals of a tool i have been using since years and be a
> part of the making as well.
>
>
> I would like to thank the reviewers and maintainers, without them my
> journey would'nt have been so easy, i learned some of my best software
> development lessons on this very list which i am insanely grateful
> for. Thank you.
>
>
>
> --
> Thanks,
> Amisha



--=20
Thanks,
Amisha
