Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D61DE2A5
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622335; cv=none; b=gQvJYoRrYFrfi+NMFNHa4XhR0tIqapf0/7wYgVhZNp1V617cptISlbSax1CyCF19f+0/iJUFKr9TRUgveoemIMVbpD0+sUNOLFRBoi70zjpIxu/Y11DkuqjyhZa9s4j/8I4xJgsKlRW8+oXX2xq/xYenozZnrNLLjJ+UQgWkSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622335; c=relaxed/simple;
	bh=95/jfX5Bi2OApOLjpy8WydmnvNNJiUlvsfNmBr6X3jo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HMZlxBi4bOvk/GyAeupm1xJnneQUQm8dJCccWIXxEDYGtBScwJ3mQqPRN0GguvJAN2l5cMPFpPRV4j665WeBRoc/jCahud5dSfU2eelERWfvoQRBECRZvW1FMzDmWxqgyxcNCWQhilZKFtZ6sADp8N0aBO4uksiHr98fi94wGfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=A9CuYtGE; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="A9CuYtGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743622331; x=1744227131;
	i=johannes.schindelin@gmx.de;
	bh=aQAbYRKOpRyGOe3jkAaC6bFFauCDJs6/BiUDaLH3NpU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A9CuYtGEdM5aIhwbbn47YUdxtUlTAcrvgiyZ49yUQ7FodZ47SJHSUOmBNV8Li0Qk
	 DTRf3UUc4aZbPzJabell5fU8oJKfAhBxTQrHuEaKZSWXl0H+jjlP2XbtNITRV0w8W
	 eJDPSQlxzwaO1IzLXtvMr5IKsihyUZsBrNcMJi9xpDWRlNK6vBzw5n+/ES5Hh6n2h
	 V7i6vjpzdBuzgkN9FMLMDn9pqyU60rqFilutnOBOz/2knJZ5f75aPNd5LTvGN32iy
	 ZnkNnNIKyonPIQgyGHkDKtrewRgmfkAjKj7M5sdAvp69XJbDQBhIAJuA7T4GIMYsH
	 t92wyJEBd4kYImWe/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjS54-1tGJvd0jve-00klod; Wed, 02
 Apr 2025 21:32:11 +0200
Date: Wed, 2 Apr 2025 21:32:10 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
    Karthik Nayak <karthik.188@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 00/20] t: drop Perl as a mandatory prerequisite
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
Message-ID: <4d87ad16-3995-1dca-7440-6aa6b26063d8@gmx.de>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im> <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9YWvwlp0DYYBPToGrdfLIizvgSe6JwQ7s6umSwJvU2Xx7+qImxa
 3gRD19IjXbF7yTlN2vmcZUfl+5Ujsg2laLUU0vUcnbqJYwX+4799LfMJvrzz5Sxqgc6JE1R
 n//STEoFZxeNd0I9LS5PtxMxzyA3TJs5b4/nk6NuNTA9YVBfx7JEePTv2Py8NJNZitNLRev
 sosjTY6HlnBS/HTFsNtyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t8k40jLK99E=;h8Y2bHAr0UB4xogpOrGmTkLtE7G
 6TrVAGQwcbL1gUmJhO84BtpTNiF9T9SE0DnDnTCtIOe+WXJVedq5hUqFPkVMYgvFXOeJbN0+X
 ZWkndvVFmgZ1k5UHd5hcvM4ZdZuk0ivJvd79QaB5tvXAw4SQwjRJvA+BfC/uZCQ6amVMiSNjy
 N8kFRrSjCijW1NBDuziPLEIu+EkZC/Z/NM1cpnJ0iyEN5BObXSKHq23QftK/CZV0bB1d3pIXh
 G7YnxgzO1MCHxrEfSAhHowN8WcB7gVElm7LGuJtC84mT3ecFmpHKfqcW9z2jRWZG1HTH+Juhw
 yln9KUj+c8agarppKQc4FBzPIJ8yQpTuknhMkdZZ+11aZ/3w5HqII5jhAj6AvX3DuDwxUVdHY
 mnWGFM+t390CjqBZt8QMnzar7YceMk+05eboBbw5ziGQ1baT9o/nGtNiob7Jq2buvgztwKVDw
 fwZuPec0VBy+VOW7mj2wxLNKeLF2M8qDDMyhgt079XB7x6f14gjmfI69mYLeWDDVd2s4SG9jm
 m0003sUCqEPIJW6fg5wq9a2UQni7XMpxz5nKcQ2gy+CnO7UUwtb/7TNO1Lcs0X3WZm5Z3KTbr
 LbRUBjnOu1J7DbrCJ9hMSMpq1pmhyAVqHvDXaFqvCTl8lOBfAV1YthylitByuOrPKvw/cnR6S
 xDWCcdg83qTeYiEBszUJayUdMRUahGPnTCxbXpd9CJj/Y/EXogKG0QxGgqOh3gXhvHGpLBt9M
 6qrrVX0QYVK49Hexff1KZ+K8BImeWxH0zEBjyFQO9MIo122GSCQUdXaiRKwRYgrgAK/40hhta
 w7njRpXdaXN19gJuHHUVEtwUJ6kBvQfMZKPgENp+n19XoeseqWELv7XhSa8FVdrXmrQke3Iwn
 OuKwhL5rKcWZdy0oGww1vFEbYuMEwyBryNcmsU2jrW570lljKIb2J+c6KvBGd2pj1EZ5QVATe
 5uGGZ3oEWRQVqN90UzgRUBSkcFoZ6JjSS2WZEq0dVlSfG5oK4TJPmsB1cK8Ij8rDlPLsatmit
 Z5syk9IVZHbKUaH3RzQueIZhf5Nft3Sl4bkD02PM8Q6OM5aO5pvttmOAq5BvvlTS+yjtUNkVg
 hMv9ROGjg+eZTLA253LUiXnZwMtPDu46V3876/MHitPr2IqKv5rw4XQLyJFQ56QW/t5dyi5rM
 MMYjA6Mw0hI2wzkHpkqrQpHCiDL3D7uZovjMvISFFKJezqZsGoUApFpaEJ8QuhAnVGjKsZPM7
 zqlEVQNF11DuKpVuoAuTpVySFrmaJvqi45QWpRMrqgesK0Pu8uFzCeX8Jjf1Hz9I5nzv92llX
 B3N2CuxczwXsIIjVnRw1muE+WScuWjwSZ3VVRs6Gp8fqGa0L7ZLu3Aeq//UIrwCT1BHezse33
 Ip84Yxv7YDDrP7F0OZiIM2Lx9e/PB+qz4OmFaOTJjrx8NTlvfIzVurXF65XfwDlEXPALQYxLE
 cVkk9GxfOzOFGptb/Many+9R6EIkN+NUVeFvKm0X+dWczfH83iqq6Ii2T37/+R/PckAyHcWjQ
 0NiniKiu32+5ixtfzZU=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 27 Mar 2025, Patrick Steinhardt wrote:

> while Git was initially building on Perl quite a lot, the significance
> of Perl has been dwindling over the years as more and more functionality
> was converted into C builtins. Nowadays, an installation with Perl-based
> features disabled is almost fully functional, only a handful of features
> remain that require Perl:
>
>   - gitweb, a read-only web interface.
>
>   - A couple of scripts that allow importing repositories from GNU Arch,
>     CVS and Subversion.
>
>   - git-send-email(1), which can be used to send mails.
>
>   - Our Perl bindings for Git.
>
>   - The netrc Git credential helper.
>
> None of these features really are critical for day-to-day usage of Git,
> and most users probably wouldn't even notice if those features were not
> installed. Perl is thus very much optional nowadays.
>
> There is one big exception though: it is impossible to run our test
> suite without a Perl interpreter, so it is not easily possible to verify
> that a Perl-less installation actually works as expected. For most of
> the part though our test suite doesn't use all that much Perl, either.
> It is present in a couple of critical paths, but those are easy to adapt
> to not use Perl anymore.
>
> This is exactly what this patch series does: it refactors a couple of
> central parts in our test suite to not use Perl anymore so that it
> becomes possible to run most of our tests entirely without Perl. Tests
> that still depend on Perl are marked with a new PERL_TEST_HELPERS prereq
> so that they only execute when a Perl interpreter is available.
>
> With this patch series, 30342 out of 31358 tests pass, which is around
> 97% of our tests.

Thank you so much for working on this. I finally finished my review, I
simply ran out of time yesterday. The patches look good to me, and the
result even more so.

=46rom my perspective, it also sure looks like good timing, even so much a=
s
two years ago it would probably not have been realistically achievable to
drop Git's test suite's dependency on Perl.

On Git for Windows' side, I have opened a ticket [*1*] that even discusses
the idea of dropping Perl from Git for Windows' installer altogether. The
appeal of this is that Perl is quite a hefty dependency with all of those
Perl modules that are part of the set that Perl users simply expect to be
present. I did not investigate this fully yet, but would expect a
reduction of at least 10MB, and Git for Windows carries this essentially
for `git svn` and little else.

So yes, I am quite happy about this direction, and could also imagine that
at least the Windows test jobs (which use `prove` like the rest of the
tests in Git's CI builds) could potentially switch away from `prove` to
`test-tool run-command testsuite` and then drop Perl from the
`git-sdk-x86_64-minimal` artifact that needs to be downloaded and
installed for every single Windows job of Git's CI. (The `test-tool` may
need to learn a few more tricks, but I'd be surprised if any non-trivial
patches were needed there to essentially replace `prove` as far as Git's
needs are concerned.)

Ciao,
Johannes

Footnote *1*: https://github.com/git-for-windows/git/issues/5393
