Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97FBEEC0
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310900; cv=pass; b=GYOhtr/HnSeyodG4DBa+YRnvKUAulSPd4qt1sn6hFhziwHTrRV0i7wmIArEyp62TNAgXWlWFRrmJYUAtpAYlTvO7NgzXoiJzr07nF9+rdne5CmoImN9cbuG+g7rnuEplIoPL4HM1g1AOncVYxaTCcA9CZLZCCHhC/j00vXkCbdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310900; c=relaxed/simple;
	bh=P0lxKb5TexWnTmmSolZz1aG8rrjKhRyh9ZSgWtZfkHI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZScwcO13WX8tCmL3xjqB9fp7RvZWzB/Wj6AVhewZB001fDuxdETuIFr2XsgfVZTlJBMM9tfNjGeJ5pTVCDuMHCcr+m7V4tFTZYe8gkv2V2LWcxqy/5TceCWTuOP4U5a/TRYn2VDfZqIgH/Aa8PvdeVi7N7T6RjWHBRXqPAXW51s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQFUj2Ee; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQFUj2Ee"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso1238976d50.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 17:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774310897; cv=none;
        d=google.com; s=arc-20240605;
        b=gfxmR8mWBAfoPppa7mi8VEOT0RH6RwnbsBzw5KdQNAR5pLGdcbSmULVf3f9mKr5S8S
         WC+a5TVS53xj1JTxa5cwVjOeT0YcRJ2B86UiA0tLrqtsR0SUvbCzfy4QSGghzVlIxpwI
         sluMeYEUs/0gwZnbDZUMPEtDuh1qat9EjwHICaZTMLRXuC+OuSxWaa6BbPJBYw/BcbmJ
         yLIJU4ak90F626Q/Dmf6DYyOjX0hdlK4lQNNnK02ZqeHYIdtzSXdLfeKdC2/VruX0CK3
         t+cMhOGd0xtA1N7JjxN0ADlIEyMT1Wr+loBVLpoDZS0XksqznocRH5DianLKuetTYUjk
         4SbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=P0lxKb5TexWnTmmSolZz1aG8rrjKhRyh9ZSgWtZfkHI=;
        fh=3vrNMW5gSLzoCwgW88K2VdAS6dDO0/RCWkho8ZAKbrA=;
        b=ghPslZvCauu2G3iw64K6aAPE6JNpNtu3BeT6EUyzWAy9Slzh0XOzrhip5yfSMD57Tk
         c4GIHlfUMN9VKo/GoaeY2pT54Q5vpyCNUu0/hdttSUPGcKBcDM4Fgr2NIm7uf2N4BjbF
         PENm0l+wq7o5Nejdb4jB54s0+YA7XpKEwY1Z7DCpx3khDNXYkydWINhMXce6ggtxezWZ
         oSEaVy4bz1F1kRAu8rfuxK1Hl1u1rEmGPbD1la+btn92cwwbs+Z2IV+N7VwU3mk+mbH+
         G6ihxQlV9S+n9z3yslJJlLIxDMPP+yd/TLdVqYIUtDkN7EZmR1dwTepIeju/tg8Ej0Vk
         KFKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774310897; x=1774915697; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P0lxKb5TexWnTmmSolZz1aG8rrjKhRyh9ZSgWtZfkHI=;
        b=dQFUj2EeyXKCoXwzebbMWvF+GoIdfJSyXylLIdVeiZJexPPj1dsS7jbNzyZg8OcCf8
         MqD9xcSE5fwUk361iDxwSkY1IMUmc12JDLhx31ib9gDo/XVksijFUyl0tTDgGyLyLPen
         nPIskvaq5zrcZq25hGx8+RpLvDEOJMF18y97NKA6s4pQM2eyGZ6QuQPT4WNH+aJ8IMqL
         O25tl8lmWDTOnoHUZ8N6Z8tfSCU6fIFHtBcp59tXZIuIktCDMoQitdXgpA1h94wOjDX+
         y7TTwmrXx3XX5D0MW/PJ2eujNFCHt0ZLQupz8Qi+ZxRIec8UR8QsmSf74+jekGTf3koR
         B5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310897; x=1774915697;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0lxKb5TexWnTmmSolZz1aG8rrjKhRyh9ZSgWtZfkHI=;
        b=r/dsiwHJpn18Ta3E3UbIhT56CJ1da/03Y0hGP2c3pvn5O+KHrr7bxBG/cWKmmiv0PW
         /5j9gq9gkCKUOcEDjvFWSav+dFdp9s6zKDW/UI8m2tRJRTfcSzWJ0uqAEloNudORCw4h
         HbrtHkhltGU9dBNFEUhISTTDUEEzwAYWDyrAcLHm97+g6SbqHnA7obsiuagJ3mJLDFap
         +u7gIE94Lcdir/PI1Ht8FsYW5nEoxQbnnZ7ST6cYcIbC5lR/mjHhBqxXf2tR8WdPH5o4
         lwXAsCvdITpY5Sf4UzQNlBY+IBcKWGVkqIQ+lknLCxszVJbu6jN1FRvnMGAtOGzbRU7A
         qg7w==
X-Gm-Message-State: AOJu0Yy24xUfjXas4n3acs/ciOguK0jB8BXX60ba2Bp2MKvkQlroRLFr
	Lx/BBL4j2l4g4DJUlYNNDJo2kzpa1XZP7juj0WVEibyI1uhUYUSwSScqeB2VD0QvDWhT3HzkM7Y
	J8kbEDkq1Bekodluv65Ty5BphPdsNWLBS/EwoyJY=
X-Gm-Gg: ATEYQzzRDtvRlW+40qrpX6zeAuss6bemWpSG4JFJrVgohACVwqfR2VcA0VR/KdYy1bD
	zQmYKvKczIxkafFn3K3kqOnza/kU6Fnq8wM8RX+jlp0XOGoiDe/miY9ygtHxsVy7AJ4J7gDzEAe
	zVXUqCWcTkhgUKQ+k6g5l9BwBGd2lX5BKvHxhMYKY/GW8XKgDvQ3y8/MO5w3w68qjr3lkPuvE5Y
	CNSrbFcvIOhESfisFDc46lX8ibbGyZdab1+5wlhI9w1Oju9mPIq40APtBoVzE0JfC7mer1xvt0H
	3490XYS9BCmC6T4FAdR3cUn56xSC+CEtYYj9x9mLpuETj7cF5w==
X-Received: by 2002:a05:690e:1911:b0:64e:dbac:da42 with SMTP id
 956f58d0204a3-64edbacf707mr185508d50.7.1774310897173; Mon, 23 Mar 2026
 17:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Tue, 24 Mar 2026 05:38:06 +0530
X-Gm-Features: AaiRm51WxVW3ni0dgtyyO0cD8SWodmmdcClaaeB7afEPbYTVNrGxVdTXf-63fxM
Message-ID: <CAPvEtreC_kRh7NW3JNfNkH+E-T1iK5XQ6aS81dtAVujGD=CzLg@mail.gmail.com>
Subject: [GSOC Proposal v2][RFC] Improve disk space recovery for partial clones
To: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>, jltobler@gmail.com, 
	christian.couder@gmail.com, karthik nayak <karthik.188@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello! I am Amisha, I am interested in the project Improve disk space
recovery for partial clones, I would appreciate it if I can get
suggestions and improvement comments for my proposal. Thank you so
much.

Improve disk space recovery for partial clones

Mentors: Christian Couder, Karthik Nayak, Justin Tobler, Siddharth
Asthana, Ayush Chandekar.

Project Size: 350 hours

Difficulty: Medium to Hard.

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

Hello, I am Amisha, currently in my penultimate year of engineering.I
am deeply passionate about contributing to open source and find great
fulfillment when I see my code helping people. Given this motivation,
I have contributed to various open source projects and the experience
has been extremly rewarding and ethereal.

Apart from open source, I make art and I like building games.


I am currently doing my LFX at OpenTelemetry, my project is about
building a GO CLI tool that runs tests of the dependents of a GO
library to record any regresisons caused by new changes in the library
(more about my project:
https://mentorship.lfx.linuxfoundation.org/project/5f537fc2-548b-487a-99ed-=
c61f7e8bcd47)
(list of PRs created until now:
https://github.com/open-telemetry/opentelemetry-go-build-tools/issues?q=3Di=
s%3Apr+author%3Aamishhaa)
inspired by Rust's Crater(https://github.com/rust-lang/crater), this
is a project/tool that I really love as it is the first time i have
made something E2E with a huge impact. I interned at Google for summer
of 2025 under team workspace serving infrastructure. Some open source
contributions that i am most proud of are in bitcoin core(refer
credits: https://bitcoincore.org/en/releases/29.2/ my PR:
https://github.com/bitcoin/bitcoin/pull/33482) and git :)

My contributions in git:

* cat-file: exit code of 'git cat-file' is suppressed by piping it
directly into grep.

Status: Awaiting review

Mailing List: https://lore.kernel.org/git/20260113180409.36683-1-amishhhaaa=
a@gmail.com/

Log: This was the first patch i ever created for git as a
microproject, made me familiar with the mailing list workflow.


* sparse-checkout: optimize string_list construction and add tests to
verify deduplication.

Status: merged in 'master'

Mailing List: https://lore.kernel.org/git/20260121130005.72375-1-amishhhaaa=
a@gmail.com/

Log: This is a really important patch for me, improves O(n^2)
complexity to O(n log n) of sparse-checkout by building a sorted
'string_list' by constructing it unsorted then sorting it followed by
removing duplicates, this triggered a series of patches and uncovered
various bugs when i worked on replacing calls of string_list_sort()
and string_list_remove_duplicates() with string_list_sort_u().


*u-string-list: add unit tests for string-list methods.

Status: merged in 'master'

Mailing List: https://lore.kernel.org/git/20260129121220.69267-1-amishhhaaa=
a@gmail.com/

Log: Adding unit tests for string-list methods which i saw were not
present when i was creating a new API string_list_sort_u.


* string-list: add string_list_sort_u() that mimics "sort -u"

Status: merged in 'master'

Mailing List: https://lore.kernel.org/git/20260129121220.69267-2-amishhhaaa=
a@gmail.com/

Log: Adding a new API string_list_sort_u and cleaning up the callsites
that can directly adopt this new replacement, string_list_sort_u
mimics sort -u.


*sparse-checkout: use string_list_sort_u

Status: merged in 'master'

Mailing List: https://lore.kernel.org/git/20260212041017.91370-2-amishhhaaa=
a@gmail.com/

Log: Small fix to replace a callsite of string_list_sort and
string_list_remove_duplicates with string_list_sort_u.


*help: cleanup the contruction of keys_uniq

Status: Will merge to 'next'.

Mailing List: https://lore.kernel.org/git/20260311192453.62213-1-amishhhaaa=
a@gmail.com/

Log: Cleaning up complex callsites of string_list_sort and
string_list_remove_duplicates, this one involved finding a test case
that demonstarted a breakage,
https://lore.kernel.org/git/CAPvEtrenMBMFaMxcCR4VwoyMFU-_Z+bqq5nJaWv5eyn3HR=
utEA@mail.gmail.com/,
then replacing them with string_list_sort_u, another bug found as an
effort is https://lore.kernel.org/git/CAPvEtrfEZXHxcDf=3Dz60ODfUA8cS81rhF1y=
7KEZApEBby7aCa1A@mail.gmail.com/,
this is still a pending bug which is good to work around in future, I
have provided a test to demonstrate an existing breakage.


History/Background, Overview and Project Theory

=E2=80=94------------------------------------------------------------------=
----------------------------------------------------------

The "Partial Clone" feature is a performance optimization for Git that
allows Git to function without having a complete copy of the
repository, building partial clone was a community effort, with
contributions referenced here,
https://git-scm.com/docs/partial-clone#_related_links. Most of my
knowledge of this project came from researching and reading blogs like
https://github.blog/open-source/git/get-up-to-speed-with-partial-clone-and-=
shallow-clone/.
The talk https://www.youtube.com/watch?v=3DYdstUWcg5j4 by Derrick Stolee
are good sources to learn about how git currently handles objects.


There are 4 types of clones that we support, full clone, blobless
clone, treeless clone and shallow clone, each of them have their own
set of configurations that tells rest of git what objects are OK to be
missing from repository as they are promised, git stores objects in
.git/ folder under objects/, these objects can be of 4 types, tag,
tree, commits and blobs. When we partial clone, git writes the partial
clone type in config file inside .git/, for example,

(base) amishachhajed@Amishas-MacBook-Pro .git % cat config

[core]

repositoryformatversion =3D 1

filemode =3D true

bare =3D false

logallrefupdates =3D true

ignorecase =3D true

precomposeunicode =3D true

[remote "origin"]

url =3D https://github.com/python/cpython.git

fetch =3D +refs/heads/*:refs/remotes/origin/*

promisor =3D true

partialclonefilter =3D tree:0

[branch "main"]

remote =3D origin

merge =3D refs/heads/main


Each promised object has to be on some of the remote otherwise our
partial clone is broken and we do not account for broken remotes.

However overtime a lot of objects might be fetched and currently there
is no functionality that, first checks if an object is present on a
promisor and then we can remove it safely to free up our disk space,
fundamentally users who make a partial clone want to save up space so
being able to remove the aquired objects on demand would be a great
addition.


This project aims to implement a command 'git evict' that can carry
out safe removal of promised objects from our disk space such that it
can be fetched later on from any of the remotes if needed,
dynamically.

Proposed Plan:

=E2=80=94------------------------------------------------------------------=
----------------------------------------------------------

Whenever we are evicting something we are unsure of its usefullness to
users, unless obvious, which git gc already handles. To overcome this,
we can make a new command 'git evict', essentially this command gives
users options and freedom to evict objects that they no longer
require, either it is out of cone or not on a checkout and a lot of
other situations, instead of predicting what users may or may not need
we can give them the choice of removal. In a case where users have a
cone and have set up a maintance task of evicting objects outside of
cone, in that case we can make it automatic.


As git currently treats remotes as source of thruth, we also trust
those remotes when evicting blobs because if all the remotes break the
principal of not strictly presenting the promised objects then the
partial clone is inherently broken, we can display a warning that
remote might not be able to fetch your file again if it gets
unavailable on the remote while evicting, however by making a partial
clone we have already placed our trust on the remotes.


Locally i attempted implementing 'git evict OID_TO_EVICT' which is
available here https://github.com/git/git/compare/master...amishhaa:git:par=
-c.
Steps to test it out:

Partial clone a repository blobless,

(base) amishachhajed@Amishas-MacBook-Pro % git clone
--filter=3Dblob:none https://github.com/python/cpython.git


Get OID for a blob, here i am getting it for README,

(base) amishachhajed@Amishas-MacBook-Pro cpython % git rev-parse
HEAD:README.rst

1d2874e9ca4fdcbfc5ef14b0202dd73d707bc9ec


cat-file the blob to make sure it is present on disk

(base) amishachhajed@Amishas-MacBook-Pro cpython % git cat-file -t
1d2874e9ca4fdcbfc5ef14b0202dd73d707bc9ec

remote: Enumerating objects: 1, done.

remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 1 (from 1)

Receiving objects: 100% (1/1), 3.50 KiB | 3.50 MiB/s, done.

blob

Run the git evict command with the object oid we recieved from the
previous step.

(base) amishachhajed@Amishas-MacBook-Pro cpython % git evict
1d2874e9ca4fdcbfc5ef14b0202dd73d707bc9ec

DEBUG: Evicted 1d2874e9ca4fdcbfc5ef14b0202dd73d707bc9ec from pack entry sea=
rch

Enumerating objects: 810655, done.

Counting objects: 100% (810654/810654), done.

Delta compression using up to 12 threads

Compressing objects: 100% (199618/199618), done.

Writing objects: 100% (810654/810654), done.

Total 810654 (delta 608469), reused 810654 (delta 608469), pack-reused
0 (from 0)


Attempt to cat-file again.

(Without network it should fail at fetching)

(base) amishachhajed@Amishas-MacBook-Pro cpython % git cat-file -t
1d2874e9ca4fdcbfc5ef14b0202dd73d707bc9ec

fatal: unable to access 'https://github.com/python/cpython.git/':
Could not resolve host: github.com

fatal: could not fetch 1d2874e9ca4fdcbfc5ef14b0202dd73d707bc9ec from
promisor remote


(With network it would re-fetch)

(base) amishachhajed@Amishas-MacBook-Pro cpython % git cat-file -t
1d2874e9ca4fdcbfc5ef14b0202dd73d707bc9ec

remote: Enumerating objects: 1, done.

remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 1 (from 1)

Receiving objects: 100% (1/1), 3.50 KiB | 3.50 MiB/s, done.

blob


However the current implementation I have locally has no validation on
an OID, to make sure it is a promisr object before attempting to evict
it, hence it fails when i try to evict a commit object, that is not
promised in a partial clone.

(base) amishachhajed@Amishas-MacBook-Pro cpython % git rev-parse HEAD^{comm=
it}

306c556fdbe7034c9a6d87516534eecdb911ad11

(base) amishachhajed@Amishas-MacBook-Pro cpython % git evict
306c556fdbe7034c9a6d87516534eecdb911ad11


(base) amishachhajed@Amishas-MacBook-Pro cpython % git evict
306c556fdbe7034c9a6d87516534eecdb911ad11

Enumerating objects: 810831, done.

Counting objects: 100% (810831/810831), done.

Delta compression using up to 12 threads

Compressing objects: 100% (200113/200113), done.

Writing objects: 100% (810831/810831), done.

Total 810831 (delta 608149), reused 810831 (delta 608149), pack-reused
0 (from 0)

fatal: bad object refs/heads/main


So, when user calls git evict, it internally finds an oidset with
objects to evict based on the flag the user has set, and then skips
those objects in want_object_in_pack() method, so we would be able to
evict everything in a single repack operation.


Currently on the user interface i am planning to implement these
flags, inspired heavily from reversing how we partial clone, for say
when partial cloning i set blob:limit=3D<size> then i might want to
evict blobs greater than that size in future.

* --outside-cone: Evict blobs that are not part of the current
sparse-checkout cone.

https://lore.kernel.org/git/735eb76e-44a9-4f79-b769-23a3a07437ae@gmail.com/=
)

* --large-only=3D<size>: Evict blobs that are bigger than a certain size.

* --tree-depth=3D<n>: Evict blobs with depth > n

* --outside-checkout: Evict blobs that are not part of the current checkout=
.


This project can essentially be split into two parts:

* Given an object, we can use method is_promisor_object() to check if
it is promised, if yes we can repack our packfiles without that
object, we would skip those OIDs in want_object_in_pack().

These OIDs that we have to skip will be passed from evict to
want_object_in_pack() method.


* Now comes gathering the list of objects for oidset, for each command
written above we would need a different method to find and append the
object to evict, in oidset. For example, for objects
--large-only=3D<size>, we need to find objects that are larger than the
size specified and mark it for eviction, similar methods to handle
such filters have been written in our codebase and can be used as
reference.


* Optionally also add git evict methods to git maintainence.

Project Timeline:

=E2=80=94------------------------------------------------------------------=
----------------------------------------------------------

Community Bonding (Until May 24th)

* Discuss project ideas and design implementation details with
mentors, possible subcommands to keep and the overall architecture of
command, any optimizations we can make when repacking objects.

* Study different types of partial clones and how refs work, and which
OIDs i can evict in different types of partial clones.

* All stages would be accompained by necessary documentation and tests.


Coding Period

(May 25 - June 30)

* Implement a basic git evict command.

* Implement evict_object method, this evict object method would need
to handle different cases when we created a partial clone, that is, if
we created a treeless clone or a blobless clone, for example if we
have a blobless clone we cannot evict a OID referencing a commit
object or a tag object because then refs would complain. It would need
to handle most of the cases that partial clone handles.

* evict_object method would only be responsible to evict an OID initially.

(July 1st - August 16)

* Implement different ways to gather OIDs for the flag that we are referenc=
ing.

* Pass on those OIDs to evict_objects method which would internally
call evict_object method, that handles all the different object cases.


Final Week (August 17 - August 24)

*This is a buffer period for any unforseen delays and prepare final
report of everything we have accomplished over the summer :)

Availibility:

=E2=80=94------------------------------------------------------------------=
----------------------------------------------------------

I would be dedicating 45-50 hours per week of my time to this project
weekly. I dont have any other commitments apart from LFX in month of
May which would be easy to manage given my summer break, so during the
month of May my time commitment would be 25 hours to this project,
incase of extensions i have my internship break next semester so this
would be considered as that hence i do not have any university work
which would be interfering with the timeline even after my summer
break.

Post-GSOC and Appreciation:

=E2=80=94------------------------------------------------------------------=
----------------------------------------------------------

I want my journey with git to be a long one, it is very fulfilling for
me to see my code running on many devices, it is like a dream come
true for me, so even post GSOC I intend to keep contributing to git.


Contirbuting to git uptill now has been insanely rewarding, i learned
about commands that i did not even know existed, it feels magical to
know the internals of a tool i have been using since years and be a
part of the making as well.


I would like to thank the reviewers and maintainers, without them my
journey would'nt have been so easy, i learned some of my best software
development lessons on this very list which i am insanely grateful
for. Thank you.



--=20
Thanks,
Amisha
