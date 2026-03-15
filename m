Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6542F2914
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773603512; cv=pass; b=AMzydB1AopFq9dpAKGWUsp65KAMa4A0ynDqceFfqPw1q5RvCLYIP0sQ50fjkksv8M8w+gjUgGztSkcahbvAepxDp+kDzOr4CDnZbzs9rhShtCf/tXOet2mjSlPLPgGialTAU2b1SnmyWZkLQHL0f7M83FW9VjS/tpOYiZDBJ4Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773603512; c=relaxed/simple;
	bh=jjBJln9/rgQ6em5Un8kvu4wijvElCerznQVXCSBeN8A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=F8jgTnIIjy7wlmapEXxTwWbu6kqRIqEBUADoCawW+7PyX8vFn4UMiFaehVH6foaXyJXvFIYrCVql1FCOyBw2jfAEWo3wPwo1KvuVeGKgL2QJaZ423aqq9YKqjqhEwngaiaqEEfNj3dx8xx212a7J3sJfc0dsNsDK76HS0RKNduk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em7v831P; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em7v831P"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ad019bbd4so3861518d50.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 12:38:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773603510; cv=none;
        d=google.com; s=arc-20240605;
        b=ctcCNbfraB1Dakibnit6NlglxMsa1Spx1p/S0AGA/O9n+VHAd7HsAEEja1IR8P8/ME
         kH5CjRyFY+DKFhrQp4ScjmTu+RaYnWOr6xtkZxCm7SR1UR/pSby9RNyxnMvIM1R+AaK6
         hI58QXIRGL7mYKo+74AfWIMue+4ldjdHyZqrnQQBc0OCsvYy0L8JixxSBY1WpgCkmtka
         wN37RgVjCPD3GCoXXGAnNm/9CIsFaBpjvHtBWWS6Ks5gloukfQLf6nCaKw+FPJ/XF17n
         mv0RFkFBJ+ayYqMSbX8uu2Nk0oOXdlmGFCAuRtX+9hTnpQkhx5o0ExVSVg6PNggn34kY
         7+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=jjBJln9/rgQ6em5Un8kvu4wijvElCerznQVXCSBeN8A=;
        fh=O95VWmcvN7lmJ1fphDQaJGIm9k/xU9fw/wC4b2wurCc=;
        b=HyzoTeDp1wLqGfAXGl9Xe6LwCljAlmDoBLkSVtljjSCHzE5+MQeHj2h66q13a3F5p0
         oPS4aHZg+Cq8/QxYL67EtNaQ1+5yByP59rVdmplDyALxmB91Jud0WusR+cG25hYTuDbF
         ohu674ZZC3PLV94TKHzA+CaNActS8+PncJl6QzVMzvSnB/iaecqgktHJIJ5iFcZp4HR0
         9c1Nh9WB5ADqV/2ixo24vwwNWYgtTAZjPVH/vAdxhsGdY4Ebzzf0cOOS7BHJ/I275nja
         auWtlsEWkYQKu+cR+uKrsPG3dJdUXu2IZX2GRSAhBIqh+G5/vW/swFSdTqcTQYfzoVsj
         l3lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773603510; x=1774208310; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jjBJln9/rgQ6em5Un8kvu4wijvElCerznQVXCSBeN8A=;
        b=em7v831PAVhreCjyxZK3/4SCnriVTurmKCQnewwQ3GjJcLJBJJost4WV+6kRzS/HIK
         x9WBlNdFoq86ew8JcYPcl8jmctgDDrJ1GAm7SnN3qA06d0aZ/bJRygjutxUYzpNcXnjw
         2lSDeAw2fECKoCekyr4ITny7h8qpRkPE0vg5jmjPI89Xgkzc0yJezSinAsgtK7neLnZr
         Lc0tJuegnNdZMVD1EARGEQsYUKO9lnQWo/XX8XFOJ2pBOuT+/fOUdw9yBk9RYWptTwCL
         Kuf0bzUU9mkoTdUoJIQWB2zG35MmXugVlLK+ZtI0NZjECcLirgvNJ+1IAwCLnh0yP1jx
         JxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773603510; x=1774208310;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjBJln9/rgQ6em5Un8kvu4wijvElCerznQVXCSBeN8A=;
        b=p2i56R0whcH9iYChr9vtZt8YUPAHwajgJjD1QLUmY5D2Wc/BME78NOswW/BFFww7B8
         AruYX6C1mcxCNhIzB2OMLT+HORTEPs8oCcxDLli36St1a7ut2OnUy0CnJUmWEul8KyUh
         iVTx8dCbqdPGRluZ+Jly9S9BLRG62nJp162xgw5TK5DwU5LQg0tlf25gxb6RJBewPXrb
         EqE9eLXKvXzLhQoAERL39QxC3/hagfdDa2eBS9dA7WgKsw5iHuqvXlZALpTFp5NGvMIv
         pslD/mxRiyRzJeNIGSKqbbIpKsVLm9b01ynxDRa55mTuf/4nzrmksBZOBm1Xx/HYrSis
         xA6g==
X-Forwarded-Encrypted: i=1; AJvYcCXyW3m6vEqlEZYIYlWzQh/mK62Mu7hBe48kmq42ABwKRUFqGP1sQrKdDVgSIhjZi8GuNYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXuqsOiDCMFZoK6kFdkjXC7/FxrBEcO3WLmmKpkvmkKnT8Ov/r
	3s/G2Vjb53J+k9aqhcXHdacRzxU0kaH+xjv5fViYlutkYYVeE5Jh98bKOEuGyltEsOWQtrUW84r
	RUsA1cDrrv9wqtcjKm3+9dVFSGqN/bAw=
X-Gm-Gg: ATEYQzw1xmrmtlQ2J+mClZWYkCXxQh0i2T3qFzeI2WRbJUAuUnys0ex2liMjELmB4Y4
	8/rvtSyOhyCySLmYCrV8NxDTx+uqGFm8/tcQREInePFknkYIBiq9srJ2Ih+v07XBZIquTqpZADt
	7rUnJvBdLV6ETN2fSM2Xq1LSUzyTr+ozeBEg7ih3S3VcpuyBwdukDGQBUJ7ocnaS3qvCSL023Sc
	y4knrh/9XXFSPs04eHZT+V73/BFMs7tFX9aJTu89334ozd4/r+tnvZDWtgQPtEl1TgtbQgU+gIH
	tohKKBnO0jARA7UtlyVJea1sypeGu1rZ+n7waDk=
X-Received: by 2002:a05:690c:e3e5:b0:796:357a:9ae7 with SMTP id
 00721157ae682-79a1c1d827fmr107332787b3.51.1773603509459; Sun, 15 Mar 2026
 12:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Mon, 16 Mar 2026 01:08:18 +0530
X-Gm-Features: AaiRm50NrMWq4Z5bVrrsubtLiM5ot6LnG95HO5AnzjJL5E13Wv6F8OEjXB27LLQ
Message-ID: <CAPvEtrdRPj6+Z3k=cqaC4a=iMC0ZAhT1NS0DRq3h2S-9F_gD6g@mail.gmail.com>
Subject: [GSOC Proposal] Improve disk space recovery for partial clones
To: christian.couder@gmail.com, karthik nayak <karthik.188@gmail.com>, 
	ayu.chandekar@gmail.com, jltobler@gmail.com, git@vger.kernel.org, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Improve disk space recovery for partial clones

Personal Information:
=E2=80=94------------------------------------------------------------------=
----------------------------------------------------------
Name: Amisha Chhajed
Email: amishhhaaaa@gmail.com
github: https://github.com/amishhaa
Time Zone: UTC +5:30 (IST)
Education: SVKM's Dwarkadas J. Sanghvi College of Engineering
Year: 3rd year, 6th semester
Degree: Bachelor of Technology in Artificial Intelligence and Data Science

About me and past experience:
=E2=80=94------------------------------------------------------------------=
----------------------------------------------------------
Hello, I am Amisha, currently in my penultimate year of engineering.
I am deeply passionate about contributing to open source and find great
fulfillment when I see my code helping people. Given this motivation, I hav=
e
contributed to various open source projects and the experience has been
extremely rewarding and ethereal.
Apart from open source, I make art and I like building games.

I am currently doing my LFX at OpenTelemetry, my project is about building =
a
GO CLI tool that runs tests of the dependents of a library to record
any regresisons caused by new changes in the library (more about my project=
:
https://mentorship.lfx.linuxfoundation.org/project/5f537fc2-548b-487a-99ed-=
c61f7e8bcd47)
(list of PRs created until now:
https://github.com/open-telemetry/opentelemetry-go-build-tools/issues?q=3Di=
s%3Apr+author%3Aamishhaa).
I interned at Google for summer of 2025 under team workspace serving
infrastructure.
(Completion certificate:
https://drive.google.com/file/d/10Nze1RzAehyN_BogP4Qlc0fHFYYuJ5Rw/view?usp=
=3Dsharing)
Some open source contributions that I am most proud of are in bitcoin core
(refer credits: https://bitcoincore.org/en/releases/29.2/
my PR: https://github.com/bitcoin/bitcoin/pull/33482) and git :)

My contributions in git:
* cat-file: exit code of 'git cat-file' is suppressed by piping it
directly into grep.
*Status: Awaiting review
*Mailing List: https://lore.kernel.org/git/20260113180409.36683-1-amishhhaa=
aa@gmail.com/
*Log: This was the first patch i ever created for git as amicroproject,
made me familiar with the mailing list workflow.

* sparse-checkout: optimize string_list construction and add tests to
verify deduplication.
*Status: merged in 'master'
*Mailing List: https://lore.kernel.org/git/20260121130005.72375-1-amishhhaa=
aa@gmail.com/
*Log: This is a really important patch for me, improves O(n^2)
complexity to O(n log n) of sparse-checkout by building a
sorted 'string_list' by constructing it unsorted then sorting it
followed by removing duplicates, this triggered a series of patches
and uncovered various bugs when i worked on replacing
calls of string_list_sort() and string_list_remove_duplicates()
with string_list_sort_u().

*u-string-list: add unit tests for string-list methods.
*Status: merged in 'master'
*Mailing List: https://lore.kernel.org/git/20260129121220.69267-1-amishhhaa=
aa@gmail.com/
Log: Adding unit tests for string-list methods which i saw were not
present when i was creating a new API string_list_sort_u.

* string-list: add string_list_sort_u() that mimics "sort -u"
*Status: merged in 'master'
*Mailing List: https://lore.kernel.org/git/20260129121220.69267-2-amishhhaa=
aa@gmail.com/
Log: Adding a new API string_list_sort_u and cleaning up the call
sites that can directly adopt this new replacement,
string_list_sort_u mimics sort -u.

*sparse-checkout: use string_list_sort_u
*Status: merged in 'master'
*Mailing List: https://lore.kernel.org/git/20260212041017.91370-2-amishhhaa=
aa@gmail.com/
*Log: Small fix to replace a callsite of string_list_sort and
string_list_remove_duplicates with string_list_sort_u.

*help: cleanup the construction of keys_uniq
*Status: Will merge to 'next'.
*Mailing List: https://lore.kernel.org/git/20260311192453.62213-1-amishhhaa=
aa@gmail.com/
*Log: Cleaning up complex callsites of string_list_sort and
string_list_remove_duplicates, this
one involved finding a test case that demonstrated a breakage,
https://lore.kernel.org/git/CAPvEtrenMBMFaMxcCR4VwoyMFU-_Z+bqq5nJaWv5eyn3HR=
utEA@mail.gmail.com/,
then replacing them with string_list_sort_u, another bug found as an effort=
 is
https://lore.kernel.org/git/CAPvEtrfEZXHxcDf=3Dz60ODfUA8cS81rhF1y7KEZApEBby=
7aCa1A@mail.gmail.com/,
This is still a pending bug which is good to work around in future, I
have provided a test to demonstrate an existing breakage.

History/Background and Overview:
=E2=80=94------------------------------------------------------------------=
----------------------------------------------------------
Building partial clone was a community effort, with contributions
referenced here,
https://git-scm.com/docs/partial-clone#_related_links,
even though partial clone is working, there is currently no direct way
to evict the acquired blobs and reduce the disk space that
we bloated by constant use.

The "Partial Clone" feature is a performance optimization for Git that
allows Git to function without having a complete copy of the
repository, however overtime a lot of blobs might be fetched and
currently there is no functionality that, first checks if a blob
is present on a promisor and then we can remove it safely to free up
our disk space, fundamentally users who make a partial clone want
to save up space so being able to remove the acquired blobs on
demand would be a great addition.

This project aims to implement a command 'git evict' that can carry
out safe removal of the blobs from our disk space such that it can
be fetched later on from any of the remotes if needed, dynamically.

Proposed Plan:
=E2=80=94------------------------------------------------------------------=
----------------------------------------------------------
Whenever we are evicting something we are unsure of its usefullness to
users, unless obvious, which git gc already handles. To overcome this,
we can make a new command 'git evict', essentially this command gives
users options and freedom to evict blobs that they no longer require,
whether it is out of cone or not on a checkout and a lot of other
situations, instead of predicting what users may or may not need we can
give them the choice of removal. In a case where users have a
cone and have set up a maintenance task of evicting blobs outside of
cone, in that case we can make it automatic.

This command would check for presence of promisor remotes for blobs
that user has set to remove, if a promisor is promising that object we can
evict it, otherwise we keep it. This would also require users
to be online, as we cannot and should not evict something that is not promi=
sed.

As git currently treats remotes as source of truth(.promisor), we also
trust those remotes when evicting blobs because if all the remotes break
the principal of not strictly presenting the promised objects then
the partial clone is inherently broken, we can display a warning that
remote might not be able to fetch your file again if it gets deleted there
while evicting based on .promisor file.

Currently on the user interface I am planning to implement these
flags, inspired heavily from reversing how we partial clone, for say
when partial cloning i set blob:limit=3D<size> then i might want to evict b=
lobs
greater than that size in future.
* --outside-cone: Evict blobs that are not part of the current
sparse-checkout cone.
* --older-than=3D<time>: Evict blobs that haven't been referenced by a
commit in the last N days.
(Suggested :- https://lore.kernel.org/git/735eb76e-44a9-4f79-b769-23a3a0743=
7ae@gmail.com/)
* --large-only=3D<size>: Evict blobs that are bigger than a certain size.
* --tree-depth=3D<n>: Evict blobs with depth > n

This project can essentially be split into two parts:
* Given an object, we can use method is_promisor_object() to check if
it is promised, if yes we can repack our packfiles without that object,
however we cannot repack for every object hence first we need to gather
a list of objects and after running is_promisor_object() for each of
them, we can repack without the objects we are evicting.
* Now comes gathering the list of objects, for each command written
above we would need a different method to find and append the object
to evict, in the object list. For example, for objects --large-only=3D<size=
>,
we need to find objects that are larger than the size specified and mark it=
 for
eviction, similar methods to handle such filters have been written in our
codebase and can be used as reference.

Project Timeline:
=E2=80=94------------------------------------------------------------------=
----------------------------------------------------------
* Community Bonding (Until May 24)
Discuss project ideas and design implementation details with mentors,
possible subcommands to keep and the overall architecture of command,
any optimizations we can make when repacking objects.

* Coding Period (May 25 - August 16)
The implementation flow can be divided as,
* Implement evict_objects method and is_safe_to_evict method.
* Implement different ways to gather and pass the objects to the
evict_objects method.
* implement git evict command.
* All stages would be accompanied by necessary documentation and unit tests=
.

* Final Week (August 17 - August 24)
This is a buffer period for any unforeseen delays and to prepare a
final report of everything we have accomplished over the summer :)

Availability:
=E2=80=94------------------------------------------------------------------=
----------------------------------------------------------
I would be dedicating 45 hours per week of my time to this project
weekly. I don't have any other commitments apart from LFX in the month
of May which would be easy to manage given my summer break.

Post-GSOC and Appreciation:
=E2=80=94------------------------------------------------------------------=
----------------------------------------------------------
I want my journey with git to be a long one, it is very fulfilling for
me to see my code running on many devices, It is like a dream come
true for me, so even post GSOC I intend to keep contributing to git.

--=20
Thanks,
Amisha
