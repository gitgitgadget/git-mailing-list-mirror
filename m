Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EC550EC08
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650933; cv=pass; b=YR/pAfzLA5lpW0zSeKYSGM5//a2mPvgqWj/kMgGdkQDKjfIgvij+qQI9U/T2ttACTqGbJpr3ceg1cOvnpFUgd1IUYAKyhUzfqXu3ZIOsYCwQy3JVKBpYjvXPZPILXfa8/pbTIzNGdKAIzB3ujmy8IaUy3xJb6jOnyFs4QqUoW1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650933; c=relaxed/simple;
	bh=oiLNZu2pEzbW4fX1SqOsHdLUvMde/f0smy5y/lNSW5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXTTMOBmbnAiqqNiQkSSc9eQJX7vofKVQDnV9Kfz+KiP9bU+nepqoedfhDJW0trOrf/l8mYJMOqCXd4BHB6fu25OCAu0ZGzLTOI94Qcvx0kcIsI7WIylowblJQEpz3iTFbQ4i707nV0UEELyDAfpc94lkp60kZWcm/MJA8+5b8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hltM8x9E; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hltM8x9E"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115c1so8664295ad.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 06:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789650922; cv=none;
        d=google.com; s=arc-20260327;
        b=hlLpIv5UUNanNIDcjHzG5U/9mXltz2PNV0A7uiapOAn1GeQ43hORsDEnmDe0VZ4aWL
         j3oyWFpa9BszJ3D7Of1oGoAF7dUo5wOLsqfn8wOK+MhyFHkAWZ93Y7wvbIqljOYGMWrv
         kJ84lr/5TW/kAacs8dtiXBIeErAvO+6Oi6zt4vR0QhxyNTh2EjM9vereNCjfaslKyxvq
         Ffrt1YhiFxIObHICVoJ0DztEPrPTXnChhnrI7MACM/AHB50OabHqWf+KYrqqNlsSBYzF
         oD/K7Icl4zyPHkLv8+CYNDnh55FwYxl31U2SGWJ9CEiHw7jNxdmoyAGfPNarrXo+hIuu
         31tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=liySuRCB1TqIHYcWR2vixdC5vMAE14melIGaquShWww=;
        fh=dQ4wza+o1wy4iZvxYddTSg/QyJnvbl2A1bjzVj59KCM=;
        b=a9bc0YHVKQ91qmltV5NNPu9oHktl8p+aAyYQ/Fglvsq9zUprNiOCRIP68cgcrdD1ee
         pP7iSNfZzxJ6rE4T0BGVifci4R6n1a/hH7bMNl9r2UVbO43BVsUR27nWxpx1MLqHYRhd
         SLrnJ09Wd1538LRy+rtpx3bfWU78bJGAAwx+ggntv/JMpokk5SGAW+JafV/ovZ7i7Cxf
         UQ9XjSu+98btkkSdHb5gs0uxLOZJl3xkmJyB3D3dSMhyMqrnEa5uHmzxxtvKjm+neGi4
         teeDKqRs2ilp6flXzqNj9TAMfi6NrS1UubnFyqP/yFPYgX/4fZhj+nEGK0hcM0IbeojD
         xH9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789650922; x=1790255722; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=liySuRCB1TqIHYcWR2vixdC5vMAE14melIGaquShWww=;
        b=hltM8x9E/e5QuSD3C4FIO8hS327wKYomvgJl7Wdp8jryeVgutMz1FBWRbMJ4292X5r
         RFSK0bgZyCeTucyW5/FiMxkbtXirHn7OpLUy4UMzFc3ZLqsCIGbWQqGelQhDE8LUPYxz
         oUnoHK9/FPFI57ZMVVIykm/azAywrUqYNh9TGy4ELBVF9sxw5Bp+Dly5xZKvXoWHmc4l
         9b7u3i+ZYonRYy7d24xGjxHp6gpAfVyzw1pFsCpQCuBb+2h80PYMGLlmPLg5SF6mHJUS
         ZHueFB1uPMq3mmr6+L0I5903Q6veKnBXna4uAMPFELudQzKRq4ssCn011wdrfN5hcrnp
         R0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789650922; x=1790255722;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=liySuRCB1TqIHYcWR2vixdC5vMAE14melIGaquShWww=;
        b=Wqsr75uHq7ov8s8Iqim34pP8Unj4/SR2/xD8Lis4nUJ1m4ZKJHQWEdLdTf48iVPYoQ
         PozIzFP5+mFxv3zs33i56WEGKAaV59U/5bYxXzFcLcGwyuUgYKVXgXbdZ/qFIOl6pfLL
         dYgnytsFZy9aw3unvTGE7ejorGPxuqXLYfhawzw/YcoHxBSnZuiQzFyE99xR/ir/DXhh
         VwBUYqPObJoqYYHqsN3bmrmx5WixuW1nAbV2D6lhpmTk5U3rMAqLwfXhlZ2j7MABGQRq
         tqPYA+aKjJL2xwzHuuPpXzKC68xxK3nUoZrE5lzL+qQ6nEXvD/lcf6YkDntrb6m4+o/E
         bNVg==
X-Forwarded-Encrypted: i=1; AKwUvBwbqc+d8Jl+A/42rTzAMBJiP94yCCSOP9UxLHhYAgkHfNAE2lve3QqeG5C7ddHnW9bSNXw=@vger.kernel.org
X-Gm-Message-State: AFuF++masuyGVVEjjcC+iVUvNn+6cFhfRsX5e/VoELaDT9RhaN3N6kZ9
	15o8YnLV+pJ/mFWbYYNtScbeEoa1OV6rCsNn6xrbPLyD0fUSCofcfwc8y5rZ9qltc5Af9ae4Fc8
	X7tq3qxIbiTxCk0jjdJcaOg8uPmAxEs5SzZvS
X-Gm-Gg: AYBFou2vpxyePjTYIqRYDVsbc3thdmA1a5KNoIOJ/kfTgrcUvp/YOqRHkukJa7v+1gI
	9bNUkAN0uBDZmzQ5Z+djhChFDVNPypCvblfCdCEQbjt+WhxURJxc1cmb5vzqkFNzi0BQeDnde64
	xiRDZiDcbDl8bmIsCC5NrUsIs3Kiat0VWHfDSAtYX9cqRkcyhG0PxT3vhM42CXeuTsJV88UT+CN
	ZTxJmZUKwAzdVCL39vfKmAcRV37PXoSBF8Ju2uyUGqbiLrMUxa/FvUIcGux3hwxzhfMO37RqMlW
	sy4S2q5oXlaOIWtSTlZKFTZ4IEO7QxdXu7NCAIcHAFsNz4A1IpcsOOe29yEVisXY1T+eZHt7fUu
	sPbd9h9NNtZlQaZ5r4okajLr3xl98ipf2+aYYANX2hkmGCktmV6VJrM3lccFnksWP9rvfa1dfXw
	lN2oZMdy51ZgK6EIyFnQ==
X-Received: by 2002:a17:903:3885:b0:2dd:ad73:c97f with SMTP id
 d9443c01a7336-2ddad73cbdfmr3718865ad.23.1789650921768; Thu, 17 Sep 2026
 06:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <56991232-5d16-41d1-9c7d-ca7ebdd9fce7@gmail.com>
 <0BCA251B-9536-46E3-A6C5-7F917366F92D@gmail.com> <fd4c2cc3-d457-49b0-bf3c-96063e40700d@gmail.com>
In-Reply-To: <fd4c2cc3-d457-49b0-bf3c-96063e40700d@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 17 Sep 2026 09:15:09 -0400
X-Gm-Features: AcwNN1VyIg5MiWeMOKe3PFC_zlqYRAJ1nMs59RLZFpk6b1H17zgOgW-66wfpiFw
Message-ID: <CALnO6CDfwscMWZktBu3FtXOQVbcBRo76nqK07kMnrzC5cPyZiQ@mail.gmail.com>
Subject: Re: [BUG] stash.index=true leaves a redundant stash entry after an
 autostash fast-forward
To: phillip.wood@dunelm.org.uk
Cc: Eli Barzilay <eli@barzilay.org>, git <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000076ed52065bad93cb"

--00000000000076ed52065bad93cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, here we go.

On Thu, Sep 17, 2026 at 5:24=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ben
>
> On 16/09/2026 15:30, Ben Knoble wrote:
> >> Le 16 sept. 2026 =C3=A0 09:35, Phillip Wood <phillip.wood123@gmail.com=
> a =C3=A9crit :
> >> Taking a step back, this code applies the stashed index changes
> >> into the current index, writes the result to a tree and then resets
> >> the index to HEAD.

I noted that we save the current index (?) into c_tree with
write_index_as_tree(), then feed diff_tree_binary() into git apply
--cache, aka applying the stashed index changes.

[from my notes]
    - that is, diff H..I in the diagram from the manual:

       A stash entry is represented as a commit whose tree records the stat=
e
       of the working directory, and its first parent is the commit at HEAD
       when the entry was created. The tree of the second parent records th=
e
       state of the index when the entry is made, and it is made a child of
       the HEAD commit. The ancestry graph looks like this:

                  .----W
                 /    /
           -----H----I

       where H is the HEAD commit, I is a commit that records the state of =
the
       index, and W is a commit that records the state of the working tree.

We then have a discard_index()/repo_read_index() pair, which I assume
is refreshing the in-memory index? Followed by
write_index_as_tree(&index_tree)=E2=80=A6 so that must be the "save the
results of applying the stashed changes" part.

What I totally misunderstood was "reset the index to HEAD"---of course
that's what "git reset" does! But I didn't understand why until=E2=80=A6

> It is a bit confusing the way it updates the index, then resets it only
> to update it again at the end. I don't think we can avoid that though if
> we want to error out when there are conflicts merging the index.

=E2=80=A6which now makes (some) sense. That also explains why my attempts t=
o
use reset_working_tree() in various forms could never work :) I had
the wrong idea entirely. But it seemed in my debugging like something
was touching the working tree, so I wish I had kept better notes.

Just finishing up the flow:

- we then refresh the in-memory index again (we just reset the on-disk
index to HEAD)
- we continue on with a "normal" stash apply merge of c_tree (old
index), w_tree (W), and b_tree (which I assume is H?); this applies
the stashed working tree changes on the current state?
- [skipping ahead] in the index case, we reset_tree(&index_tree, 0,
0), restoring the stashed index changes. Sans doc comments for
unpack_trees() beyond "N-way merge len trees [=E2=80=A6] resulting index [=
=E2=80=A6]",
I haven't puzzled out what's going on, but it _looks_ like we merge a
single tree, possibly with the original index (opts.src_index) and
write to a destination which is the repository's index.

It's extra unclear what the reset bit is applied to in

> It looks like stash has its own unpack_trees() wrapper, so I think the
> simplest fix is to replace reset_head() with
>
>         reset_tree(&c_tree, 0, 1);

I'm not sure if that is a pre-merge reset, post-merge reset, or
something in between.
Unfortunately, a whole bunch of tests fail (6 files) with this suggestion :=
/

Summary of Failures:

 339/1062 git:t3904-stash-patch                              ERROR
      0.45s   exit status 1
 503/1062 git:t3903-stash                                    ERROR
      4.40s   exit status 1
 763/1062 git:t6424-merge-unrelated-index-changes            ERROR
      0.90s   exit status 1
 778/1062 git:t6402-merge-rename                             ERROR
      2.06s   exit status 1
 864/1062 git:t1092-sparse-checkout-compatibility            ERROR
     26.19s   exit status 1
 868/1062 git:t7611-merge-abort                              ERROR
      0.45s   exit status 1

It _also_ doesn't make the bug go away, hm.

> >> We could avoid touching the index at all if we
> >> used merge_incore_nonrecursive() to cherry pick the index changes
> >> instead. That way we'd get a proper three-way merge and avoid
> >> spawning subprocesses for "git diff-tree", "git apply --cached",
> >> and "git reset". We're already using merge_ort_nonrecursive() to
> >> merge the working tree changes in that function so we have nearly
> >> everything we need already set up to merge the index changes as
> >> well. Essentially, when merging the index, we just need to call
> >> merge_incore_nonrecursive() instead of merge_ort_nonrecursive()
> >> and use info->i_tree instead of info->w_tree.

If I'm following this, the suggestion is to replace (parts of) the
early "if (index)" block with a merge_incore_nonrecursive() to merge
index changes, reporting conflicts as we do today, and saving the tree
for later=E2=80=A6 and this would not touch the real index, so we wouldn't
have to reset at all? Interesting!

The attached patch [Gmail headaches, sorry], which needs some
polishing [*], passes tests and fixes the bug! Yahoo. I'll send a
series later, tomorrow probably.
(It won't apply directly, because it's on top of the experimental
reset_tree() version, but resolving conflicts should be easy.)

[*] namely, the log message, some tiny first cleanups, and removing
now-unused functions

--=20
D. Ben Knoble

--00000000000076ed52065bad93cb
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-wip-fix-stash-bug.patch"
Content-Disposition: attachment; filename="0001-wip-fix-stash-bug.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mu5jw6cd0>
X-Attachment-Id: f_mu5jw6cd0

RnJvbSBkNTNhMDQyMTdkZDJjOGI5NjdlNzE3MTdhMDIwY2ZmMWM4NjY4ZmExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlEOiA8ZDUzYTA0MjE3ZGQyYzhiOTY3ZTcxNzE3YTAyMGNm
ZjFjODY2OGZhMS4xNzg5NjUwNzgzLmdpdC5iZW4ua25vYmxlQGdtYWlsLmNvbT4KRnJvbTogIkQu
IEJlbiBLbm9ibGUiIDxiZW4ua25vYmxlQGdtYWlsLmNvbT4KRGF0ZTogVGh1LCAxNyBTZXAgMjAy
NiAwOToxMjo1MCAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIHdpcDogZml4IHN0YXNoIGJ1ZwoKU2ln
bmVkLW9mZi1ieTogRC4gQmVuIEtub2JsZSA8YmVuLmtub2JsZUBnbWFpbC5jb20+Ci0tLQogYnVp
bHRpbi9zdGFzaC5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2J1aWx0aW4vc3Rhc2guYyBiL2J1aWx0aW4vc3Rhc2guYwppbmRleCBiMDg5
NTY4N2Q5Li44N2Q3NjRlZTMyIDEwMDY0NAotLS0gYS9idWlsdGluL3N0YXNoLmMKKysrIGIvYnVp
bHRpbi9zdGFzaC5jCkBAIC02NTUsMjkgKzY1NSwzNiBAQCBzdGF0aWMgZW51bSBzdGFzaF9hcHBs
eV9yZXN1bHQgZG9fYXBwbHlfc3Rhc2goY29uc3QgY2hhciAqcHJlZml4LAogCQkgICAgb2lkZXEo
JmNfdHJlZSwgJmluZm8tPmlfdHJlZSkpIHsKIAkJCWhhc19pbmRleCA9IDA7CiAJCX0gZWxzZSB7
Ci0JCQlzdHJ1Y3Qgc3RyYnVmIG91dCA9IFNUUkJVRl9JTklUOworCQkJc3RydWN0IG1lcmdlX3Jl
c3VsdCByZXN1bHQgPSB7IDAgfTsKIAotCQkJaWYgKGRpZmZfdHJlZV9iaW5hcnkoJm91dCwgJmlu
Zm8tPndfY29tbWl0KSkgewotCQkJCXN0cmJ1Zl9yZWxlYXNlKCZvdXQpOwotCQkJCXJldHVybiBl
cnJvcihfKCJjb3VsZCBub3QgZ2VuZXJhdGUgZGlmZiAlc14hLiIpLAotCQkJCQkgICAgIG9pZF90
b19oZXgoJmluZm8tPndfY29tbWl0KSk7Ci0JCQl9CisJCQlpbml0X3VpX21lcmdlX29wdGlvbnMo
Jm8sIHRoZV9yZXBvc2l0b3J5KTsKIAotCQkJcmV0ID0gYXBwbHlfY2FjaGVkKCZvdXQpOwotCQkJ
c3RyYnVmX3JlbGVhc2UoJm91dCk7Ci0JCQlpZiAocmV0KQorCQkJby5icmFuY2gxID0gbGFiZWxf
b3VycyA/IGxhYmVsX291cnMgOiAiVXBkYXRlZCB1cHN0cmVhbSI7CisJCQlvLmJyYW5jaDIgPSAi
U3Rhc2hlZCBpbmRleCBjaGFuZ2VzIjsKKwkJCW8uYW5jZXN0b3IgPSBsYWJlbF9iYXNlID8gbGFi
ZWxfYmFzZSA6ICJTdGFzaCBiYXNlIjsKKworCQkJaWYgKG9pZGVxKCZpbmZvLT5iX3RyZWUsICZj
X3RyZWUpKQorCQkJCW8uYnJhbmNoMSA9ICJWZXJzaW9uIHN0YXNoIHdhcyBiYXNlZCBvbiI7CisK
KwkJCWlmIChxdWlldCkKKwkJCQlvLnZlcmJvc2l0eSA9IDA7CisKKwkJCWlmIChvLnZlcmJvc2l0
eSA+PSAzKQorCQkJCXByaW50Zl9sbihfKCJNZXJnaW5nICVzIHdpdGggJXMiKSwKKwkJCQkJCW8u
YnJhbmNoMSwgby5icmFuY2gyKTsKKworCQkJaGVhZCA9IGxvb2t1cF90cmVlKG8ucmVwbywgJmNf
dHJlZSk7CisJCQltZXJnZSA9IGxvb2t1cF90cmVlKG8ucmVwbywgJmluZm8tPmlfdHJlZSk7CisJ
CQltZXJnZV9iYXNlID0gbG9va3VwX3RyZWUoby5yZXBvLCAmaW5mby0+Yl90cmVlKTsKKworCQkJ
bWVyZ2VfaW5jb3JlX25vbnJlY3Vyc2l2ZSgmbywgaGVhZCwgbWVyZ2UsIG1lcmdlX2Jhc2UsCisJ
CQkJCQkgICZyZXN1bHQpOworCisJCQlpZiAoIXJlc3VsdC5jbGVhbikKIAkJCQlyZXR1cm4gZXJy
b3IoXygiY29uZmxpY3RzIGluIGluZGV4LiAiCiAJCQkJCSAgICAgICAiVHJ5IHdpdGhvdXQgLS1p
bmRleC4iKSk7CiAKLQkJCWRpc2NhcmRfaW5kZXgodGhlX3JlcG9zaXRvcnktPmluZGV4KTsKLQkJ
CXJlcG9fcmVhZF9pbmRleCh0aGVfcmVwb3NpdG9yeSk7Ci0JCQlpZiAod3JpdGVfaW5kZXhfYXNf
dHJlZSgmaW5kZXhfdHJlZSwgdGhlX3JlcG9zaXRvcnktPmluZGV4LAotCQkJCQkJcmVwb19nZXRf
aW5kZXhfZmlsZSh0aGVfcmVwb3NpdG9yeSksIDAsIE5VTEwpKQotCQkJCXJldHVybiBlcnJvcihf
KCJjb3VsZCBub3Qgc2F2ZSBpbmRleCB0cmVlIikpOwotCi0JCQlyZXNldF90cmVlKCZjX3RyZWUs
IDAsIDEpOwotCQkJZGlzY2FyZF9pbmRleCh0aGVfcmVwb3NpdG9yeS0+aW5kZXgpOwotCQkJcmVw
b19yZWFkX2luZGV4KHRoZV9yZXBvc2l0b3J5KTsKKwkJCWluZGV4X3RyZWUgPSByZXN1bHQudHJl
ZS0+b2JqZWN0Lm9pZDsKIAkJfQogCX0KIAoKYmFzZS1jb21taXQ6IDMzOWFiMmE4ZjE0YzBjMzA0
YWUyZjI4ZGYxYTg1OWYzZDJjZjYxMGMKcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiA3NGI2ODQ3ZTRk
YWFhODgxNGY1OTc1Y2UzZDA3N2JlZGUxOTk1MDRiCnByZXJlcXVpc2l0ZS1wYXRjaC1pZDogYTI0
NjVmNGQxMDhhZGE3MWI4NGM4YTg3ZTM1MDZkYzNlM2I1MjY4MwotLSAKMi41NS4wLjEwMDMuZzEw
NTM4ZmU2OTkuZGlydHkKCg==
--00000000000076ed52065bad93cb--
