Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B9639FDA
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611138; cv=none; b=LMORm3PTMkrkVcH8i9j53zrsRInA+5A2DJ6tEbO0jcoQwgNmQgG2ox+xsSjhpRa36NlotRyWxoGeeX6DealnivgPeHFPcNlroXHBK5pmOYS0G1a6XZ5J+6vQMpXU2TIjR0h8Yc1UlbVvsOEMFRRUKWwSAyfENzC8r5mFWmdYlOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611138; c=relaxed/simple;
	bh=qo4VXuPtM9SLHz7Xeeq6eH0fXQwcYGMYJ93dkUx7zD0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WBMAAZ3kdPZcHfJCSA3Fwawr61EcU2xaEBzQD51usE4DZ3UVY382+EtxQJzz4f8x++bAVBhNbYq0jmM5bF+ysTS26GRodmkdzwi+4yBEyXVhq9NQWhyPepia39/Y/qp6qmwEuAPvA1epWEaiSF0y5+yb2/RN3yajbCzSiUyte+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=bBPU6ScJ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="bBPU6ScJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708611130; x=1709215930; i=johannes.schindelin@gmx.de;
	bh=qo4VXuPtM9SLHz7Xeeq6eH0fXQwcYGMYJ93dkUx7zD0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=bBPU6ScJ9DXpWewYruNoH0uNp3fkLBEh4UfUz2o5CCsoVqf9QotvG8cqd5K98c9Y
	 8e/8GEwByS72oQzqTYAerurPmOHt36OjtSAbS9EVeyQl/VJV0B4O6AgL0YlXomgQx
	 KaddDofyN9z+G+lRMtDnRCPMhTVpulG14woL8LjNcfdEZKgfCycL2xKgw/y49Qq8E
	 0KL1DeYKNxjsCDmVsKxafjdhCTamrX2Ce4DGAbVtI51S/ZmhxY/nvnm8eaHgc9L6G
	 ANfi1JNEheWl/OkbC09Ol+FS//sRzkyUUOuSBt6ZeSyWYmEpcOkpTT6+HGMBYw9gl
	 Ng6SzKCUTPf0SkiBdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.133]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK4f-1qm9kJ1MED-00rEP3; Thu, 22
 Feb 2024 15:12:10 +0100
Date: Thu, 22 Feb 2024 15:12:08 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eric Sunshine <sunshine@sunshineco.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/5] t4301: verify that merge-tree fails on missing
 blob objects
In-Reply-To: <CAPig+cSJz3U+vT==NhX5hcrTjsCggnAzhzQOvZcSXbcEGuYaKQ@mail.gmail.com>
Message-ID: <80255493-701b-b4fc-5d0f-54e059d97f71@gmx.de>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com> <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com> <be1dadf28502fe3e9662fa61523e8c57ce3352f1.1707324462.git.gitgitgadget@gmail.com>
 <CAPig+cSJz3U+vT==NhX5hcrTjsCggnAzhzQOvZcSXbcEGuYaKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2033321639-1708611130=:518"
X-Provags-ID: V03:K1:EzEla5hgOOeWP1SGKdmSrzSJN9TtPb4o6RhTd8Z/2AbLBM6629J
 9VliTz0HNYbLpy3ssDDFjdjqsDcyQLc5b32/XgnUymjjbJmmxz8+Dae9LQpvKT8hXmyrYf9
 doIXJTtp56nRoQf/LgHAX1EtTmN/Xkpgq0SwhKQR+3JShYqUWUMT4XXq2Zn7hQDZkE0zFQo
 Qz6r/Px/sgJ/3cDwZSBrw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cVPm+hZOLgc=;aadZ/dEGYuecmnZwtuM99rt8XVf
 hEhIXCHoTIgt7US6z/S9QCWhCKZcLQaee7WEw7F1hJwKILSXYfgcUbkqFweU5/vvetPLbdcLx
 myel4X6opmvow3+/JJEZQGZKhZQ2DKkWihWI1ViWgK7a+ITFfwy0ESSkpt8W2ZgkmYTXMcRop
 mUBuumJvYwsO9nGUrO3+u4lio3Hh8deFgZI79PgdPaiM3WF6LlJQFKiq/EM6KbhEni18s8k6z
 CRqWKoh3QfTjDSAm8Ld0anKqgXRJberZHrfte/bG/YWmMng2VICnl3ZMK1+zbbqXzMoXtK3U/
 z5M/NoMmLKR8FaCkNdxjAh/DdvxWAHRIB+rl/pwCG7Mour2VjiI1y3LpjxaqEOfT8SFy6sQ9g
 qYC0LSQXPJnUpeYOcvXjY3ZwYhImyT6TMOSgcYN3bD94VCDPJeyEXW4KkKPORMBqnHxfOO7/S
 5cRgTtiEkKI0Vp535hsL7Z3pYnPMa6YBSEl8aQwj3iMHcnrybcjqj5Kq4MmRa2tq0MLwex2s+
 QMsm6L1XA9KLyLI1BRPkbWs1Bx5IDk16l59tKE/cOTQwmT8kgq2og4Mo7bMS6u6l1YClBgSND
 Yw3Bk9X62QgWczZVbDF9cgZ3OCp76JCzeZb2bpWyGXJAbmeoYbXdYEy9NOTrBNvIQP+3xZ+9i
 iArd9DKf9DdVUNGxNs6HD+QXvfDOewLnQv3FQcYQLTBA0W/6ZAVdOAz7Z6qcI4v4WrC/J9GEU
 bm6Q00SFyTiJCwza0X/ObEe01f4MHdGhCmPDrHIlOS8nRjbyCR14DdMX6WhTi4K8aM3kTmNyW
 G5ehSdwhtF9zHyblEGdXDkAQGC1B0tXLhvBKU+KCAorPc=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2033321639-1708611130=:518
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Wed, 7 Feb 2024, Eric Sunshine wrote:

> On Wed, Feb 7, 2024 at 11:48=E2=80=AFAM Johannes Schindelin via GitGitGa=
dget
> <gitgitgadget@gmail.com> wrote:
> > We just fixed a problem where `merge-tree` would not fail on missing
> > tree objects. Let's ensure that that problem does not occur with blob
> > objects (and won't, in the future, either).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-wri=
te-tree.sh
> > @@ -961,4 +961,18 @@ test_expect_success 'error out on missing tree ob=
jects' '
> > +test_expect_success 'error out on missing blob objects' '
> > +       seq1=3D$(test_seq 1 10 | git hash-object -w --stdin) &&
> > +       seq2=3D$(test_seq 1 11 | git hash-object -w --stdin) &&
> > +       seq3=3D$(test_seq 0 10 | git hash-object -w --stdin) &&
>
> Is there significance to the ranges passed to test_seq()?

Originally, there was, since I wanted the merge to succeed without
conflicts.

However, I simplified the test case similar to what you suggested and
now specifically verify that the expected error message is shown (as
opposed to, say, an error message indicating a merge conflict).

> Or, can the same be achieved by using arbitrary content for each blob?
>
>     blob1=3D$(echo "one" | git hash-object -w --stdin) &&
>     blob2=3D$(echo "two" | git hash-object -w --stdin) &&
>     blob3=3D$(echo "three" | git hash-object -w --stdin) &&
>
> > +       tree1=3D$(printf "100644 blob %s\tsequence" $seq1 | git mktree=
) &&
> > +       tree2=3D$(printf "100644 blob %s\tsequence" $seq2 | git mktree=
) &&
> > +       tree3=3D$(printf "100644 blob %s\tsequence" $seq3 | git mktree=
) &&
>
> I found the lack of terminating "\n" in the `printf` confusing,
> especially since the variable names (seq1, seq2, etc.) and the use of
> `printf` seem to imply, at first glance, that each git-mktree
> invocation is receiving multiple lines as input which, it turns out,
> is not the case. Adding the missing "\n" would help:
>
>    tree1=3D$(printf "100644 blob %s\tsequence\n" $seq1 | git mktree) &&
>    tree2=3D$(printf "100644 blob %s\tsequence\n" $seq2 | git mktree) &&
>    tree3=3D$(printf "100644 blob %s\tsequence\n" $seq3 | git mktree) &&

I added the `\n` and now avoid the `%s`.

Thank you for your review!
Johannes

>
> Interpolating the $seqN variable directly into the string rather than
> using %s would make it even clearer that only a single line is being
> generated as input to git-mktree:
>
>    tree1=3D$(printf "100644 blob $seq1\tsequence\n" | git mktree) &&
>    tree2=3D$(printf "100644 blob $seq2\tsequence\n" | git mktree) &&
>    tree3=3D$(printf "100644 blob $seq3\tsequence\n" | git mktree) &&
>
> Alternatively `echo` could be used, though it's not necessarily any nice=
r:
>
>     tree1=3D$(echo "100644 blob $seq1Qsequence" | q_to_tab | git mktree)=
 &&
>     tree2=3D$(echo "100644 blob $seq2Qsequence" | q_to_tab | git mktree)=
 &&
>     tree3=3D$(echo "100644 blob $seq3Qsequence" | q_to_tab | git mktree)=
 &&
>
> > +       git init --bare missing-blob.git &&
> > +       test_write_lines $seq1 $seq3 $tree1 $tree2 $tree3 |
> > +       git pack-objects missing-blob.git/objects/pack/side1-whatever-=
is-missing &&
> > +       test_must_fail git --git-dir=3Dmissing-blob.git merge-tree --m=
erge-base=3D$tree1 $tree2 $tree3 >actual &&
> > +       test_must_be_empty actual
> > +'
>

--8323328-2033321639-1708611130=:518--
