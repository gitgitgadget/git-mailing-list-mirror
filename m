Received: from qs51p00im-qukt01071701.me.com (qs51p00im-qukt01071701.me.com [17.57.155.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87325F484
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707689289; cv=none; b=BDATC6fvAoE/FgMyRAk1zUag4RRYQClx4RRDmW4qAx7RKvFqzSDGt15l9EsJA7Pgnq9O5SAZJIOjxCPjlPl5wB0APMCWulhb0E0NHbmAyJIR5CeafOHJj6YcfptnPPsuwzUVlTl5RghOXFJcJDEnSZxVUzK86tbma8PSo/SlnZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707689289; c=relaxed/simple;
	bh=ng/zDIQaC4OBIq2ubJSOjoE6+X4QiaL+aLE8BOZsHU0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCS0ySJWTR4AnBBQcQmTgZkcEI8BpoqCx4o0BI1+GdI3ltHBX3FovlPzNrE6wfOs0RkTtkeGIYmaIqfhDSOfigPGjyJlbKibMNzgfozZ2ILn2xLdV6LZ0RhOvRXCBOR8bgguR0Z/GgjFUKAO4Ma3EK1pEucJPKrwvmMQllG5X9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=iA7MDL6p; arc=none smtp.client-ip=17.57.155.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="iA7MDL6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1707689286;
	bh=uN0zO+LtuIXjxbmg/x1DO74P1r/sfbS2tWlqdQgvPUc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=iA7MDL6phsvAGNcn71uu1JbVuLGmMElLYbVYqKOQNztWLV4S4dAU7Fqay1tcWssV7
	 zM95XzGnk+zHvqxX/d0/hWRV3RSx6aGPCIfrwlZjr2klrpCFgtZfFSs4Wa1ZGVD0Hg
	 tTf/CpFdnPYR+S8Q8LH1ioMoagbzBd3LyF/y/EUVx1JauHAIcfRTVZzxPgFI+qTRVP
	 018rFdM4DtsLunqobBl37nfAH9nfalgiSTszY2ErrB9qpjr2vxki/7nW8oTBX4nAIH
	 rY63mHtXT/HGrsswcIGFCgOcEdG1THc5UgGetgTtvG6hmAFWzThNOGtW769h2hdWvx
	 H0RXUc8gMUU0A==
Received: from [169.254.251.8] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071701.me.com (Postfix) with ESMTPSA id 5B6964D00272;
	Sun, 11 Feb 2024 22:08:05 +0000 (UTC)
From: Sebastian Thiel <sebastian.thiel@icloud.com>
To: Junio C Hamano <gitster@pobox.com>,
 Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Josh Triplett <josh@joshtriplett.org>, Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] precious-files.txt: new document proposing new precious
 file type
Date: Sun, 11 Feb 2024 23:08:02 +0100
X-Mailer: MailMate (1.14r5937)
Message-ID: <2A762405-1A2B-472E-9A2F-D068A25F65C1@icloud.com>
In-Reply-To: <xmqq8r5gfc3j.fsf@gitster.g>
References: <pull.1627.git.1703643931314.gitgitgadget@gmail.com>
 <xmqq8r5gfc3j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: CGwjw6q6U4MdonatNGvuy51jUme-xHWz
X-Proofpoint-ORIG-GUID: CGwjw6q6U4MdonatNGvuy51jUme-xHWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-11_20,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2402110177

I didn't know where I would best reply to give an update on my work
on precious file support, but here I go.

On my journey to daring implementing precious files in Git, I decided
to implement it in Gitoxide first to ease myself into it.

After what felt like months of work on the Gitoxide-equivalent of
dir.c, it just took 2 days to cobble together a 'gix clean' with
precious files support.

You might say that something as destructive as a 'clean' subcommand
would better not be rushed, but it was surprisingly straightforward
to implement. It was so inviting even that I could spend the second
day, today, entirely on polishing, yielding a 'gix clean' which is
fun to use, with some extras I never knew I wanted until I had full
control over it and could play around easily.

What I found myself do immediately by the way is adjust `.gitignore`
files of the project to have precious declarations right after
their non-precious counterparts for backwards compatibility.

It works perfectly, from what I can tell, and it is truly wonderful
to be able to wipe a repo clean without fear of destroying anything
valuable. And I am aware that we all know that, but wanted to write
it to underline how psychologically valuable this feature is.

Without further ado, I invite you all to give it a go yourself
for first experiences with precious files maybe.

    git clone https://github.com/Byron/gitoxide
    cd gitoxide
    cargo build --release --bin gix --no-default-features --features max-=
pure
	target/release/gix clean

This should do the trick - from there the program should guide the
user.

If you want to see some more interesting features besides precious
files, you can run 'cargo test -p gix' and follow the 'gix clean -xd'
instructions along with the `--debug` flag.

A word about performance: It is slower.
It started out to be only about 1% slower even on the biggest repositorie=
s
and under optimal conditions (i.e. precomposeUnicode and ignoreCase off
and skipHash true). But as I improved correctness and added features,
that was lost and it's now about 15% slower on bigger repositories.

I appended a benchmark run on the Linux kernel at the end, and it shows
that Gitoxide definitely spends more time in userland. I can only
assume that some performance was lost when I started to deviate from
the 'only do the work you need' recipe that I learned from Git to
'always provide a consistent set of information about directory entries'.=


On top of that, there is multiple major shortcomings in this realm:

- Gitoxide doesn't actually get faster when reading indices with multiple=

  threads for some reason.
- the icase-hashtable is created only with a single thread.
- the precompose-unicode conversion is very slow and easily costs 25%
  performance.

But that's details, some of which you can see yourself when running
'gix --trace -v clean'.

Now I hope you will have fun trying 'gix clean' with precious files in yo=
ur
repositories. Also, I am particularly interested in learning how it fares=

in situations where you know 'git clean' might have difficulties.
I tried very hard to achieve correctness, and any problem you find
will be fixed ASAP.

With this experience, I think I am in a good position to get precious
files support for 'git clean' implemented, once I get to make the start.

Cheers,
Sebastian

----

Here is the benchmark result (and before I forget, Gitoxide also uses abo=
ut 25% more memory
for some reason, so really has some catchup to do, eventually)

linux (ffc2532) +369 -819 [!] took 2s
=E2=9D=AF hyperfine -N -w1 -r4  'gix clean -xd --skip-hidden-repositories=
=3Dnon-bare' 'gix -c index.skipHash=3D1 -c core.ignoreCase=3D0 -c core.pr=
ecomposeUnicode=3D0 clean -xd --skip-hidden-repositories=3Dnon-bare' 'git=
 clean -nxd'
Benchmark 1: gix clean -xd --skip-hidden-repositories=3Dnon-bare
  Time (mean =C2=B1 =CF=83):     171.7 ms =C2=B1   3.0 ms    [User: 70.4 =
ms, System: 101.4 ms]
  Range (min =E2=80=A6 max):   167.4 ms =E2=80=A6 174.2 ms    4 runs

Benchmark 2: gix -c index.skipHash=3D1 -c core.ignoreCase=3D0 -c core.pre=
composeUnicode=3D0 clean -xd --skip-hidden-repositories=3Dnon-bare
  Time (mean =C2=B1 =CF=83):     156.3 ms =C2=B1   3.1 ms    [User: 56.9 =
ms, System: 99.3 ms]
  Range (min =E2=80=A6 max):   154.1 ms =E2=80=A6 160.8 ms    4 runs

Benchmark 3: git clean -nxd
  Time (mean =C2=B1 =CF=83):     138.4 ms =C2=B1   2.7 ms    [User: 40.5 =
ms, System: 103.7 ms]
  Range (min =E2=80=A6 max):   136.1 ms =E2=80=A6 142.0 ms    4 runs

Summary
  git clean -nxd ran
    1.13 =C2=B1 0.03 times faster than gix -c index.skipHash=3D1 -c core.=
ignoreCase=3D0 -c core.precomposeUnicode=3D0 clean -xd --skip-hidden-repo=
sitories=3Dnon-bare
    1.24 =C2=B1 0.03 times faster than gix clean -xd --skip-hidden-reposi=
tories=3Dnon-bare


On 27 Dec 2023, at 6:28, Junio C Hamano wrote:

> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Elijah Newren <newren@gmail.com>
>>
>> We have traditionally considered all ignored files to be expendable, b=
ut
>> users occasionally want ignored files that are not considered
>> expendable.  Add a design document covering how to split ignored files=

>> into two types: 'trashable' (what all ignored files are currently
>> considered) and 'precious' (the new type of ignored file).
>
> The proposed syntax is a bit different from what I personally prefer
> (which is Phillip's [P14] or something like it), but I consider that
> the more valuable parts of this document is about how various
> commands ought to interact with precious paths, which shouldn't
> change regardless of the syntax.
>
> Thanks for putting this together.
