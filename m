Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870F10785
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776212097; cv=pass; b=PS4gjST27afWvpKwZEl5seOs1/Mii0tnSKEIEmWi0fkM9PyzB6YtjXM2BzZVUssk1uEuGdr86lNHKz4E0IJnXoQHi9wrH4g9cvBU2SLjrw5KmA5JaW8/srd7JVXxs6ChhSdFwVFnh31KXs6yotIVE2jtr/hf7tFslgwLybb5hPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776212097; c=relaxed/simple;
	bh=Q/we6USFeOrL23SJ+A1bXbmp345nZIIhbgIh8i4MHPY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LvS6prlRPjN/jyESRTuU0lcmqRuxmXnZYUL4pez78OeYRZcHdUB21HW//BBA8AxPqH0hedcE8JBJrcspF53QjZu0pwoHSW3AzLmpq89lFJYcnoKpG6zjSxTpa1R+IKsaXiKtkD3ei3zMHygSrQxE55G8h+B9+bvEs1S4qv4og54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVSszDTZ; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVSszDTZ"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a7109f568so73086777b3.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 17:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776212095; cv=none;
        d=google.com; s=arc-20240605;
        b=UPSfdNbmT7JJ5FPMFp4VIhQIJXFWXsoL7y0in3lHKLZatgIvOfJcpmYK0hML6f0W8v
         RtosXvrXpaWFlNZWfLMeRRZpA6hptXd9PiEpeeVUU9okaRy6biInf9k8tFgHs6+GX4z2
         tbVcY44aXyPk+MWqR/a+YYEoZhtkKsh4bVVh7BI7pjKll9463KeZc0mHOG82fHq6i/sT
         9jTdufhisS/p13AjbXJ63N7Y58LT8PyPt/QV07wwlL+LIhHgR6CBVPjIhh+6b1dT+gd3
         0JDhvR3SoKpFn86+vqc4YwnZE+N9iW5c9ZTd4HbI0mmWHOnKyfE1twmVxLSdBsErY+iZ
         IM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Q/we6USFeOrL23SJ+A1bXbmp345nZIIhbgIh8i4MHPY=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=DcfFH1iK+639GbL2Rjb8u1yKVoIJEEj5SiGrIQPjqZkPXxCEoQL4F61/DNVZYLGKJd
         LYFPFlOP2x/+ZUezsMjEWGQTyvcqC4RMfunaZfaKGoSWAEKamrJqqpJ/Hf8g52QALtDF
         mv9+hBP/69vXO2oo4tZ9BsaKgOQgTTRleA45n3EZ8+EDP+djG4R8MFJl1FCK21pIv4pc
         v4pJeifeRNy9t7WKzUfGH3xNnLhAX0810JpFZ7w4kN4s5w6Jmz70qBXQ7qdMTg6WY+v5
         7lN/67+m2+ICg8Zpnh8+58wUdIy+bQclzp5E+JMhzMvoWSptCxA+LGXps2p0H9Cc0iT6
         6+MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776212095; x=1776816895; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q/we6USFeOrL23SJ+A1bXbmp345nZIIhbgIh8i4MHPY=;
        b=qVSszDTZGKOKGjv06w8pC48j0j1qraVMR+TTx8x6ReUmqj7RjJSksObDFtrxNHB4OH
         +WxWpYjyiujYQ1tEbn2w1C6ELZaCi7uKX+P6r6Dfrth9AtDQfvK7OkXSbmFvzSP+CpGc
         jnhlwBHK4Y5xx2Z8zOg+zXedJ1iQRS0KFLLPoBXSIcY8aCb5QxNzTW2uqBItJpOIpoq/
         H/7RTMbF5BVVsnaGiWLQ6wo4Fw+e7I33Pd5HP6A3gnHHFbcJ/P9gHf/ZxkUw7oNUFUJQ
         MD4nFDuqQoToaPBJUsWZ1NTfMOPGL5R+NtDGZrcsDXUVSFSDKNQJ3qoDC4AB2gExGWUY
         sgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776212095; x=1776816895;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/we6USFeOrL23SJ+A1bXbmp345nZIIhbgIh8i4MHPY=;
        b=rQv6kBczSFelM/mhAo+oy+mEqelv7BC3a8j/+2k81jF4HESTIt1uqypG89cycDQi6p
         n7FsmktapzMumF/nPQbibiryQpal6VHAB0GZeZigEYwdT0//ZcJTD1+j6pbqVX/lBfZc
         mAAexA5z39pjUlJrLf7tNO7xmquSL5HGHhxl0bGv6EYCrMhBsV1VH4AdahF7CEJ1izDt
         dT6LM1tYi9z2xWiZBZCp9mvwhWCJFr+iIYAIUw6aXmsyluMRBuA6sPNHHZ6JOJFroQL/
         fE3vWfniAoUT7VY0WnSfrzzDf11U4H44XTTYCniYk3s7HAkHX1GoB4gRghlZ/DnE7hCn
         h23w==
X-Gm-Message-State: AOJu0YwGXfQImVEkldf7H+9L64q2Ykk6m8U1lyNFSpRkLshOYCYa2LAJ
	4NHsf5+v5CV+j28YkPpkK6FdrMj4vTxWe8S+XTkCK+R+HtijV5P/cXUJJec5FhVu3go6xBfE8WN
	1+769RVI1GKe+6/jXKTrv919q5+O0Le7JDkUd
X-Gm-Gg: AeBDieuHSJKmZCuiuHSDWdjkcWoEgZg+Yn3kEm0eWh4blzAvz7uN2U5Jc0hxTmRN1Ji
	nSI0XcdimwO994sYftOKUPYbAkJVW3UJqfca1EYv8NwwbHpuEdz75s3rU/53RBIkCe4lcRwfq1q
	8UtEn0cvp5bsX035QBG7caBS2yLNISgmJq0eLy41Q7DvaqFfEONC20z9QGMfcTq/HUW7SNVPaag
	rR72ZqzpzCYyBZso4AONmvePrm7ngw1NbSK5ldi+17MeZy4MNn7mbmBmhFWe5G/AfSgZTE8GuWK
	W7uoOmSfkcC2HEjR6EkNHIMYjd6nB8w3+8Zqo+ff4dnlHqq01uIrIyO6eOT881TwMIoAaobADTU
	pTAU=
X-Received: by 2002:a05:690c:6983:b0:7b4:378c:f732 with SMTP id
 00721157ae682-7b4378cf950mr75629797b3.46.1776212095002; Tue, 14 Apr 2026
 17:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: JAM <kratsbinovish@gmail.com>
Date: Wed, 15 Apr 2026 02:14:43 +0200
X-Gm-Features: AQROBzCboavZFuVquz90573UuzXpKbjptCzXXUtIFM-V71BcHKduoUKS3SfUuFA
Message-ID: <CAPSFGa8uu9CEEPH3XVjfN5VEOfcnb2p8YgXVuansjKc0S2S_tA@mail.gmail.com>
Subject: [RFC] worktree: add --recurse-submodules support to git worktree add
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f8589b064f749a0c"

--000000000000f8589b064f749a0c
Content-Type: multipart/alternative; boundary="000000000000f8589b064f749a0a"

--000000000000f8589b064f749a0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Back in 2022, Glen Choo noted [1] that git worktree add leaves submodules
unhandled and suggested a --recurse-submodules flag to fix that. The thread
went quiet. The 2015=E2=80=932016 discussions by Duy and Beller [2][3] had =
flagged a
deeper design concern: submodule existence (which worktrees have which
submodules checked out) is tangled up with submodule configuration (URL,
path),
making per-worktree submodule support tricky to reason about.

This proposal sidesteps that concern entirely. Rather than touching
submodule
configuration at all, the idea is to reuse the git object data that's
already
present in the main repository =E2=80=94 the same thing git worktree add al=
ready
does
for the top-level object store, extended down to the submodule layer.

The use case has also grown more pressing: multi-agent development workflow=
s
(where several autonomous coding agents work concurrently on different
branches
of the same repository) rely heavily on worktrees for isolation, and fall
apart
on projects with submodules.

Concretely, git worktree add --recurse-submodules would:

1. Hardlink $GIT_COMMON_DIR/modules/ into the new worktree's entry.
Independent directory trees, shared inodes =E2=80=94 no extra disk, no netw=
ork.
2. Rewrite core.worktree in the hardlinked config and config.worktree
files to point at the new worktree's working directory instead of the main
repo's.
3. Run git submodule update inside the new worktree to write the .git
pointer files into each submodule directory. Entirely local since the
modules directory is already there.
4. Populate working trees with git read-tree HEAD && git checkout -- . per
submodule, since the hardlinked index files start empty.

A shell script implementing this as a prototype is attached.

The worktreeConfig extension case (step 2) is the one place that needs care=
,
since core.worktree may live in either config or config.worktree
depending on the submodule. The prototype handles both. The other open
question
is policy for submodules not yet initialized in the main repo =E2=80=94 ski=
p
silently,
warn, or error out.

Would there be interest in a proper patch series for this?

[1]
https://lore.kernel.org/git/kl6lwnimyxbq.fsf@chooglen-macbookpro.roam.corp.=
google.com/
[2]
https://lore.kernel.org/git/CACsJy8D8Ur4W348t-WFUPrb7SQxmff5MJ4aRp+w+ZiQ7VV=
vipg@mail.gmail.com/
[3]
https://lore.kernel.org/git/CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pn=
yv+w@mail.gmail.com/

Signed-off-by: Jimmy Aguilar kratsbinovish@gmail.com

--000000000000f8589b064f749a0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Back in 2022, Glen Choo noted [1] that git worktree add le=
aves submodules<br>unhandled and suggested a --recurse-submodules flag to f=
ix that. The thread<br>went quiet. The 2015=E2=80=932016 discussions by Duy=
 and Beller [2][3] had flagged a<br>deeper design concern: submodule existe=
nce (which worktrees have which<br>submodules checked out) is tangled up wi=
th submodule configuration (URL, path),<br>making per-worktree submodule su=
pport tricky to reason about.<br><br>This proposal sidesteps that concern e=
ntirely. Rather than touching submodule<br>configuration at all, the idea i=
s to reuse the git object data that&#39;s already<br>present in the main re=
pository =E2=80=94 the same thing git worktree add already does<br>for the =
top-level object store, extended down to the submodule layer.<br><br>The us=
e case has also grown more pressing: multi-agent development workflows<br>(=
where several autonomous coding agents work concurrently on different branc=
hes<br>of the same repository) rely heavily on worktrees for isolation, and=
 fall apart<br>on projects with submodules.<br><br>Concretely, git worktree=
 add --recurse-submodules would:<br><br>1. Hardlink $GIT_COMMON_DIR/modules=
/ into the new worktree&#39;s entry.<br>Independent directory trees, shared=
 inodes =E2=80=94 no extra disk, no network.<br>2. Rewrite core.worktree in=
 the hardlinked config and config.worktree<br>files to point at the new wor=
ktree&#39;s working directory instead of the main<br>repo&#39;s.<br>3. Run =
git submodule update inside the new worktree to write the .git<br>pointer f=
iles into each submodule directory. Entirely local since the<br>modules dir=
ectory is already there.<br>4. Populate working trees with git read-tree HE=
AD &amp;&amp; git checkout -- . per<br>submodule, since the hardlinked inde=
x files start empty.<br><br>A shell script implementing this as a prototype=
 is attached.<br><br>The worktreeConfig extension case (step 2) is the one =
place that needs care,<br>since core.worktree may live in either config or =
config.worktree<br>depending on the submodule. The prototype handles both. =
The other open question<br>is policy for submodules not yet initialized in =
the main repo =E2=80=94 skip silently,<br>warn, or error out.<br><br>Would =
there be interest in a proper patch series for this?<br><br>[1] <a href=3D"=
https://lore.kernel.org/git/kl6lwnimyxbq.fsf@chooglen-macbookpro.roam.corp.=
google.com/">https://lore.kernel.org/git/kl6lwnimyxbq.fsf@chooglen-macbookp=
ro.roam.corp.google.com/</a><br>[2] <a href=3D"https://lore.kernel.org/git/=
CACsJy8D8Ur4W348t-WFUPrb7SQxmff5MJ4aRp+w+ZiQ7VVvipg@mail.gmail.com/">https:=
//lore.kernel.org/git/CACsJy8D8Ur4W348t-WFUPrb7SQxmff5MJ4aRp+w+ZiQ7VVvipg@m=
ail.gmail.com/</a><br>[3] <a href=3D"https://lore.kernel.org/git/CAGZ79kZB8=
U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com/">https://lore.ker=
nel.org/git/CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.=
com/</a><br><br>Signed-off-by: Jimmy Aguilar <a href=3D"mailto:kratsbinovis=
h@gmail.com">kratsbinovish@gmail.com</a></div>

--000000000000f8589b064f749a0a--
--000000000000f8589b064f749a0c
Content-Type: application/x-shellscript; name="create-worktree.sh"
Content-Disposition: attachment; filename="create-worktree.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_mnzard4h0>
X-Attachment-Id: f_mnzard4h0

IyEvdXNyL2Jpbi9lbnYgYmFzaAojIGNyZWF0ZS13b3JrdHJlZS5zaCDigJQgQ3JlYXRlIGEgZ2l0
IHdvcmt0cmVlIHdpdGggc3VibW9kdWxlcyBoYXJkbGlua2VkCiMgZnJvbSB0aGUgbWFpbiByZXBv
IChubyBuZXR3b3JrLCBubyBleHRyYSBkaXNrIGZvciBnaXQgb2JqZWN0cykuCiMKIyBVc2FnZTog
Li9jcmVhdGUtd29ya3RyZWUuc2ggPGJyYW5jaC1uYW1lPiA8d29ya3RyZWUtcGF0aD4KCnNldCAt
ZXVvIHBpcGVmYWlsCgp1c2FnZSgpCnsKICAgIGVjaG8gIlVzYWdlOiAkMCA8YnJhbmNoLW5hbWU+
IDx3b3JrdHJlZS1wYXRoPiIgPiYyCiAgICBleGl0IDEKfQoKIyDilIDilIAgMS4gQXJndW1lbnRz
IOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgAoKaWYgW1sgJCMgLW5lIDIgXV07IHRoZW4KICAgIHVzYWdlCmZpCgpC
UkFOQ0g9IiQxIgpXT1JLVFJFRV9QQVRIPSIkKHJlYWxwYXRoIC1tICIkMiIpIgoKIyDilIDilIAg
Mi4gRGV0ZWN0IHNvdXJjZSByZXBvIOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgAoKTUFJTl9SRVBPPSIkKGdpdCByZXYtcGFyc2UgLS1zaG93LXRvcGxldmVsIDI+
L2Rldi9udWxsKSIgfHwgewogICAgZWNobyAiRXJyb3I6IG5vdCBpbnNpZGUgYSBnaXQgcmVwb3Np
dG9yeS4iID4mMgogICAgZXhpdCAxCn0KCmVjaG8gIlNvdXJjZSByZXBvIDogJE1BSU5fUkVQTyIK
ZWNobyAiQnJhbmNoICAgICAgOiAkQlJBTkNIIgplY2hvICJXb3JrdHJlZSAgICA6ICRXT1JLVFJF
RV9QQVRIIgoKIyDilIDilIAgMy4gUHJlLWZsaWdodCBjaGVja3Mg4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACgppZiBbWyAtZSAiJFdPUktUUkVFX1BBVEgi
IF1dOyB0aGVuCiAgICBlY2hvICJFcnJvcjogZGVzdGluYXRpb24gYWxyZWFkeSBleGlzdHM6ICRX
T1JLVFJFRV9QQVRIIiA+JjIKICAgIGV4aXQgMQpmaQoKIyDilIDilIAgNC4gQ3JlYXRlIHRoZSB3
b3JrdHJlZSDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIAKCkxPQ0FM
PSQoZ2l0IC1DICIkTUFJTl9SRVBPIiBicmFuY2ggLS1saXN0ICIkQlJBTkNIIikKCmlmIFtbIC1u
ICIkTE9DQUwiIF1dOyB0aGVuCiAgICBlY2hvICJCcmFuY2ggJyRCUkFOQ0gnIGZvdW5kIGxvY2Fs
bHkg4oCUIGNoZWNraW5nIGl0IG91dC4iCiAgICBnaXQgLUMgIiRNQUlOX1JFUE8iIHdvcmt0cmVl
IGFkZCAiJFdPUktUUkVFX1BBVEgiICIkQlJBTkNIIgplbHNlCiAgICAjIE9ubHkgc2VhcmNoIHJl
bW90ZXMgd2hlbiB0aGUgYnJhbmNoIGlzIG5vdCBmb3VuZCBsb2NhbGx5CiAgICBtYXBmaWxlIC10
IFJFTU9URV9SRUZTIDwgPChnaXQgLUMgIiRNQUlOX1JFUE8iIGJyYW5jaCAtciAtLWxpc3QgIiov
JEJSQU5DSCIgfCB0ciAtZCAnWzpzcGFjZTpdJykKCiAgICBpZiBbWyAkeyNSRU1PVEVfUkVGU1tA
XX0gLWVxIDAgXV07IHRoZW4KICAgICAgICBlY2hvICJCcmFuY2ggJyRCUkFOQ0gnIG5vdCBmb3Vu
ZCBsb2NhbGx5IG9yIG9uIGFueSByZW1vdGUg4oCUIGNyZWF0aW5nIG5ldyBicmFuY2ggZnJvbSBI
RUFELiIKICAgICAgICBnaXQgLUMgIiRNQUlOX1JFUE8iIHdvcmt0cmVlIGFkZCAtYiAiJEJSQU5D
SCIgIiRXT1JLVFJFRV9QQVRIIgogICAgZWxpZiBbWyAkeyNSRU1PVEVfUkVGU1tAXX0gLWVxIDEg
XV07IHRoZW4KICAgICAgICBSRU1PVEVfUkVGPSIke1JFTU9URV9SRUZTWzBdfSIKICAgICAgICBl
Y2hvICJCcmFuY2ggJyRCUkFOQ0gnIGZvdW5kIG9uIHJlbW90ZSBhcyAnJFJFTU9URV9SRUYnIOKA
lCBjcmVhdGluZyBsb2NhbCB0cmFja2luZyBicmFuY2guIgogICAgICAgIGdpdCAtQyAiJE1BSU5f
UkVQTyIgd29ya3RyZWUgYWRkICIkV09SS1RSRUVfUEFUSCIgLWIgIiRCUkFOQ0giICIkUkVNT1RF
X1JFRiIKICAgIGVsc2UKICAgICAgICBlY2hvICJCcmFuY2ggJyRCUkFOQ0gnIGZvdW5kIG9uIG11
bHRpcGxlIHJlbW90ZXM6IgogICAgICAgIGZvciBpIGluICIkeyFSRU1PVEVfUkVGU1tAXX0iOyBk
bwogICAgICAgICAgICBlY2hvICIgICQoKGkgKyAxKSkpICR7UkVNT1RFX1JFRlNbJGldfSIKICAg
ICAgICBkb25lCiAgICAgICAgd2hpbGUgdHJ1ZTsgZG8KICAgICAgICAgICAgcmVhZCAtcnAgIlBp
Y2sgYSByZW1vdGUgWzEtJHsjUkVNT1RFX1JFRlNbQF19XTogIiBQSUNLCiAgICAgICAgICAgIGlm
IFtbICIkUElDSyIgPX4gXlswLTldKyQgXV0gJiYgKCggUElDSyA+PSAxICYmIFBJQ0sgPD0gJHsj
UkVNT1RFX1JFRlNbQF19ICkpOyB0aGVuCiAgICAgICAgICAgICAgICBicmVhawogICAgICAgICAg
ICBmaQogICAgICAgICAgICBlY2hvICJJbnZhbGlkIGNob2ljZSwgdHJ5IGFnYWluLiIgPiYyCiAg
ICAgICAgZG9uZQogICAgICAgIFJFTU9URV9SRUY9IiR7UkVNT1RFX1JFRlNbJCgoUElDSyAtIDEp
KV19IgogICAgICAgIGVjaG8gIlVzaW5nICckUkVNT1RFX1JFRicg4oCUIGNyZWF0aW5nIGxvY2Fs
IHRyYWNraW5nIGJyYW5jaC4iCiAgICAgICAgZ2l0IC1DICIkTUFJTl9SRVBPIiB3b3JrdHJlZSBh
ZGQgIiRXT1JLVFJFRV9QQVRIIiAtYiAiJEJSQU5DSCIgIiRSRU1PVEVfUkVGIgogICAgZmkKZmkK
CiMg4pSA4pSAIDUuIFNldCB1cCBzdWJtb2R1bGVzIHZpYSBoYXJkbGlua3Mg4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACgpHSVRf
RElSPSIkKGdpdCAtQyAiJE1BSU5fUkVQTyIgcmV2LXBhcnNlIC0tZ2l0LWNvbW1vbi1kaXIpIgpX
T1JLVFJFRV9FTlRSWT0iJChiYXNlbmFtZSAiJFdPUktUUkVFX1BBVEgiKSIKCmVjaG8gIkhhcmRs
aW5raW5nIHN1Ym1vZHVsZSBnaXQgZGF0YSBmcm9tICRHSVRfRElSL21vZHVsZXMgLi4uIgpjcCAt
YWwgIiRHSVRfRElSL21vZHVsZXMiIFwKICAgICAgICIkR0lUX0RJUi93b3JrdHJlZXMvJFdPUktU
UkVFX0VOVFJZL21vZHVsZXMiCgplY2hvICJGaXhpbmcgd29ya3RyZWUgcGF0aHMgaW4gc3VibW9k
dWxlIGNvbmZpZ3MgLi4uIgpmaW5kICIkR0lUX0RJUi93b3JrdHJlZXMvJFdPUktUUkVFX0VOVFJZ
L21vZHVsZXMiIC1uYW1lIGNvbmZpZyAtZXhlYyBcCiAgICBzZWQgLWkgInN8d29ya3RyZWUgPSAu
Ki9jb250cmliL3x3b3JrdHJlZSA9ICRXT1JLVFJFRV9QQVRIL2NvbnRyaWIvfCIge30gKwoKZmlu
ZCAiJEdJVF9ESVIvd29ya3RyZWVzLyRXT1JLVFJFRV9FTlRSWS9tb2R1bGVzIiAtbmFtZSBjb25m
aWcud29ya3RyZWUgLWV4ZWMgXAogICAgc2VkIC1pICJzfHdvcmt0cmVlID0gLiovY29udHJpYi98
d29ya3RyZWUgPSAkV09SS1RSRUVfUEFUSC9jb250cmliL3wiIHt9ICsKCmVjaG8gIlJlZ2lzdGVy
aW5nIHN1Ym1vZHVsZXMgKGxvY2FsLCBubyBuZXR3b3JrKSAuLi4iCmlmICEgZ2l0IC1DICIkV09S
S1RSRUVfUEFUSCIgc3VibW9kdWxlIHVwZGF0ZSAyPi9kZXYvbnVsbDsgdGhlbgogICAgZWNobyAi
UmV0cnlpbmcgd2l0aCBzdWJtb2R1bGUgaW5pdCAuLi4iCiAgICBnaXQgLUMgIiRXT1JLVFJFRV9Q
QVRIIiBzdWJtb2R1bGUgaW5pdAogICAgZ2l0IC1DICIkV09SS1RSRUVfUEFUSCIgc3VibW9kdWxl
IHVwZGF0ZQpmaQoKZWNobyAiUG9wdWxhdGluZyBzdWJtb2R1bGUgd29ya2luZyB0cmVlcyAuLi4i
CmdpdCAtQyAiJFdPUktUUkVFX1BBVEgiIHN1Ym1vZHVsZSBmb3JlYWNoIFwKICAgICcoZ2l0IHJl
YWQtdHJlZSBIRUFEICYmIGdpdCBjaGVja291dCAtLSAuKSAyPi9kZXYvbnVsbCB8fCBlY2hvICJT
S0lQOiAkbmFtZSInCgojIOKUgOKUgCA2LiBEb25lIOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgAoKZWNobyAiIgplY2hvICJXb3JrdHJlZSByZWFkeS4iCmVjaG8gIiAgU291cmNlIHJlcG8g
OiAkTUFJTl9SRVBPIgplY2hvICIgIFdvcmt0cmVlICAgIDogJFdPUktUUkVFX1BBVEgiCmVjaG8g
IiAgQnJhbmNoICAgICAgOiAkQlJBTkNIIgplY2hvICIgIFN1Ym1vZHVsZXMgIDogaGFyZGxpbmtl
ZCBmcm9tIG1haW4gcmVwbyAoaW5kZXBlbmRlbnQsIG5vIG5ldHdvcmspIgplY2hvICIiCmVjaG8g
IiAgY2QgJFdPUktUUkVFX1BBVEgiCmVjaG8gIiIKZWNobyAiTm90ZTogYnVpbGQgZGlyZWN0b3Jp
ZXMgYXJlIG5vdCBzaGFyZWQg4oCUIGNvbmZpZ3VyZSBDTWFrZSBzZXBhcmF0ZWx5LiIKZWNobyAi
VG8gcmVtb3ZlIGxhdGVyOiIKZWNobyAiICBybSAtcmYgJFdPUktUUkVFX1BBVEgiCmVjaG8gIiAg
Z2l0IC1DICRNQUlOX1JFUE8gd29ya3RyZWUgcHJ1bmUiCg==
--000000000000f8589b064f749a0c--
