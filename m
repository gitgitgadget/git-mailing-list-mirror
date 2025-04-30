Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C7A1BE251
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026291; cv=none; b=sb//fe47RiwDdsMJwLDfD1h0OaxX2QVD1ja3l9Osv9/MV4NGS9I/2JhCR5UAXWvyFZm1RdEhOdyp6lvAzpK+ltzleWfDiUs5opT+Ka580b1lI5tgmOun2dWi4rhRE9wIE1EMesFmzl1dpXwTyWsP3OVq43bNhYCVbNlxN+rIAbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026291; c=relaxed/simple;
	bh=1HR+FvvRYjdjoMHDfXvtgzHoNxVXr2l1L4YJ5s/GaP8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CCQXWhnfG6frll59DrVazjfdEdUkIMnfAxiD5BmNWLPNGUwFLG++QI6hAJ/wfJU5RvzR2Zs5z92XBAxEQcbj5Sj7IU50FhIU8xrXFJHvSfqsUgNHG6+iAyK0FIIjPmyagQ7KgLPUfwJSkTn+kaTRAyImUTIDZiTM+W9XWc6gLbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=bD4L0YU3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BI//q+T1; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="bD4L0YU3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BI//q+T1"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 56C0C25401A0;
	Wed, 30 Apr 2025 11:18:07 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Wed, 30 Apr 2025 11:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1746026287; x=1746112687; bh=ln3x2oUvtFTjkd5OcVxC2hInr9Ab+sE+
	gKpwOejRxKs=; b=bD4L0YU37q0MxqzIndBo3EwQsJyjKM4+AyErfOGk4hbPVRSg
	vkemA6cbuJ8NlhOrw14K2FZbXNhMzZkXnD+OekjETsr86t+/IsM0OoESTiHUym6w
	R0GtqF4KcwPYpbYQEpYqYR5bHmFal+75V1D1tfJwcVKHy6Mqxtb7tN1XQA3lPHC2
	Hq9d5Xv//T3HpO259vnvOtplXaa4POj6577CBvk5gUlAZWj34vpeKV4hTbkYpxAy
	hJ29AcNR+F8iAyGH3JTLFuon/4BOTrsNiyVUdn78v0WfU108Tnseqv8VPnUmqbcx
	2MJsu7e5gixILrDvt06rsdvDVI3rD8jlXOU5Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746026287; x=
	1746112687; bh=ln3x2oUvtFTjkd5OcVxC2hInr9Ab+sE+gKpwOejRxKs=; b=B
	I//q+T1TqkM6ru0B0g2lgX1Oa8wCTnw+q5hS/0/EhiFUZOWalp6BXxjyf3Zk4BeK
	haJOBj6jcr59N4PL2OcFN42PwORZmevt698dT835xp6MTwjCQin+kLhCyrjCEf45
	qaDJrg0tqIC5tS4X4w3OTo/NPtVt22DVwj4bXyAh6lUkY03OnwqHYyYbXyaXywNQ
	m0Oh/DoNowoBpzbvscbNL9z10QXFdxelIWInpVcjyj6FuRnPjDxz+Z0neUV5+AF8
	WfTGR/u7OcSGqTdi5UITkaHS80792OQqJU3BNrNPFca8HdQMyYJOLOFwVkdRGNA2
	YpUZGrijGYJUnLEFyqJpA==
X-ME-Sender: <xms:Lj8SaKI31Ydxpy74gBWc8oXSWzZHFMXqT59FaAxTv21TB1T-KZ3L6QM>
    <xme:Lj8SaCJYEnNpUE2hbmwrFsRydE-IgtzGH-NEl5B_Vsj56cU_OKgC_1HTamgzvvPK6
    AL_KyBJwpwJlyKkNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtoh
    guvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefh
    geefveelgeduvdekteehieevffdujeelgfduffffjeelffffledukeejnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhg
    shgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Lj8SaKtqtixstYYyzLzPHdY-SukTonW4WImeNdxaxtYVn0RmUJgKfg>
    <xmx:Lj8SaPZ4CNJR7Q4n5ThKzRmOWxoNEJVDEvERlV3RUqe91ITbObx5YQ>
    <xmx:Lj8SaBZJVB1FXNlXliup7pWszVhxVswC-QJ_NXLIu9P8W5OODD4AEA>
    <xmx:Lj8SaLB-uyu4OUQxQmI_pVXlHBaioHcmebNfKp1iQJDSMCLphWzPlg>
    <xmx:Lz8SaKh33Tmw5sr3QnrTOdCBWA2ELeqbd0AE2DVCVDWGGEGcxHt_XjX4>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 730B478006A; Wed, 30 Apr 2025 11:18:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9ccdcf6233d5601f
Date: Wed, 30 Apr 2025 17:17:38 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Message-Id: <6743a9fc-11ca-45ac-bc40-4148f5d85d27@app.fastmail.com>
In-Reply-To: <20250429215155.GA36727@coredump.intra.peff.net>
References: <20250428194048.149348-1-code@khaugsbakk.name>
 <ce0f41e4-7d90-4398-a0e9-e8ba69791e57@gmail.com>
 <fbc97d6a-2022-4a64-a2ba-5a7255cd81a6@app.fastmail.com>
 <20250429215155.GA36727@coredump.intra.peff.net>
Subject: Re: [BUG] rebase: can write reflog with uninit. `action` string
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025, at 23:51, Jeff King wrote:
> On Tue, Apr 29, 2025 at 09:40:13PM +0200, Kristoffer Haugsbakk wrote:
>
>> On Tue, Apr 29, 2025, at 11:22, Phillip Wood wrote:
>> >> #0  run_git_commit (defmsg=3D0x555555babe70 "<repo path>/MERGE_MSG=
", opts=3D0x7fffffffc070, flags=3D0) at sequencer.c:1158
>> >
>> > Thanks for the backtrace. It would be useful to know what's stored =
in
>> > opts->ctx->reflog_message at this point if it's not too much trouble
>> > please can you run "print *opts" and "print *opts->ctx" here.
>>
>> Today I ran on f65182a99e5 (The ninth batch, 2025-04-24) at
>> sequencer.c:1148.  I was never able to reproduce this
>> `opts->ctx->reflog_message` having a weird value with GDB today.  The
>> reflog was also fine.
>>
>> Then I ran without GDB and I got the weird reflog that I expected.
>
> Have you tried building with "make SANITIZE=3Daddress,undefined"?

No I haven=E2=80=99t.  Thank you.  The following is with that `make`.

Still on f65182a99e5 (The ninth batch, 2025-04-24).  I eventually[1]
got this:

[1] I run through 19 merge conflicts which I `--continue` (using rerere)
    until the rebase is done

```
detached HEAD 5d96584c836] Merge branch '<branch>' into <something else>
 Author: [author]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D87324=3D=3DERROR: AddressSanitizer: heap-use-after-free on address=
 0x60300001daa0 at pc 0x79371ca5df89 bp 0x7fff8e215a50 sp 0x7fff8e2151c8
READ of size 2 at 0x60300001daa0 thread T0
    #0 0x79371ca5df88 in printf_common ../../../../src/libsanitizer/sani=
tizer_common/sanitizer_common_interceptors_format.inc:553
    #1 0x79371ca5fbd5 in __interceptor_vsnprintf ../../../../src/libsani=
tizer/sanitizer_common/sanitizer_common_interceptors.inc:1668
    #2 0x5702aa6bd851 in strbuf_vaddf /home/kristoffer/programming/git/s=
trbuf.c:415
    #3 0x5702aa6d2384 in strvec_pushf /home/kristoffer/programming/git/s=
trvec.c:35
    #4 0x5702aa629087 in run_git_commit /home/kristoffer/programming/git=
/sequencer.c:1148
    #5 0x5702aa64c652 in do_merge /home/kristoffer/programming/git/seque=
ncer.c:4363
    #6 0x5702aa655714 in pick_commits /home/kristoffer/programming/git/s=
equencer.c:5029
    #7 0x5702aa659a68 in sequencer_continue /home/kristoffer/programming=
/git/sequencer.c:5461
    #8 0x5702a9d0f5ce in run_sequencer_rebase builtin/rebase.c:370
    #9 0x5702a9d14cd9 in run_specific_rebase builtin/rebase.c:747
    #10 0x5702a9d23798 in cmd_rebase builtin/rebase.c:1887
    #11 0x5702a9a3c26c in run_builtin /home/kristoffer/programming/git/g=
it.c:480
    #12 0x5702a9a3d3d5 in handle_builtin /home/kristoffer/programming/gi=
t/git.c:744
    #13 0x5702a9a3dc2c in run_argv /home/kristoffer/programming/git/git.=
c:811
    #14 0x5702a9a3f17c in cmd_main /home/kristoffer/programming/git/git.=
c:951
    #15 0x5702a9e77aa3 in main /home/kristoffer/programming/git/common-m=
ain.c:9
    #16 0x79371be29d8f in __libc_start_call_main ../sysdeps/nptl/libc_st=
art_call_main.h:58
    #17 0x79371be29e3f in __libc_start_main_impl ../csu/libc-start.c:392
    #18 0x5702a9a35384 in _start (/home/kristoffer/programming/git/git+0=
x12a0384)

0x60300001daa0 is located 0 bytes inside of 24-byte region [0x60300001da=
a0,0x60300001dab8)
freed by thread T0 here:
    #0 0x79371cab4c38 in __interceptor_realloc ../../../../src/libsaniti=
zer/asan/asan_malloc_linux.cpp:164
    #1 0x5702aa7ecdca in xrealloc /home/kristoffer/programming/git/wrapp=
er.c:140
    #2 0x5702aa6b83b7 in strbuf_grow /home/kristoffer/programming/git/st=
rbuf.c:114
    #3 0x5702aa6bd8ca in strbuf_vaddf /home/kristoffer/programming/git/s=
trbuf.c:420
    #4 0x5702aa6476dc in reflog_message /home/kristoffer/programming/git=
/sequencer.c:3948
    #5 0x5702aa648e42 in do_reset /home/kristoffer/programming/git/seque=
ncer.c:4059
    #6 0x5702aa65545e in pick_commits /home/kristoffer/programming/git/s=
equencer.c:5026
    #7 0x5702aa659a68 in sequencer_continue /home/kristoffer/programming=
/git/sequencer.c:5461
    #8 0x5702a9d0f5ce in run_sequencer_rebase builtin/rebase.c:370
    #9 0x5702a9d14cd9 in run_specific_rebase builtin/rebase.c:747
    #10 0x5702a9d23798 in cmd_rebase builtin/rebase.c:1887
    #11 0x5702a9a3c26c in run_builtin /home/kristoffer/programming/git/g=
it.c:480
    #12 0x5702a9a3d3d5 in handle_builtin /home/kristoffer/programming/gi=
t/git.c:744
    #13 0x5702a9a3dc2c in run_argv /home/kristoffer/programming/git/git.=
c:811
    #14 0x5702a9a3f17c in cmd_main /home/kristoffer/programming/git/git.=
c:951
    #15 0x5702a9e77aa3 in main /home/kristoffer/programming/git/common-m=
ain.c:9
    #16 0x79371be29d8f in __libc_start_call_main ../sysdeps/nptl/libc_st=
art_call_main.h:58

previously allocated by thread T0 here:
    #0 0x79371cab4c38 in __interceptor_realloc ../../../../src/libsaniti=
zer/asan/asan_malloc_linux.cpp:164
    #1 0x5702aa7ecdca in xrealloc /home/kristoffer/programming/git/wrapp=
er.c:140
    #2 0x5702aa6b83b7 in strbuf_grow /home/kristoffer/programming/git/st=
rbuf.c:114
    #3 0x5702aa6bbeae in strbuf_add /home/kristoffer/programming/git/str=
buf.c:313
    #4 0x5702aa61da33 in strbuf_addstr /home/kristoffer/programming/git/=
strbuf.h:310
    #5 0x5702aa64766a in reflog_message /home/kristoffer/programming/git=
/sequencer.c:3943
    #6 0x5702aa659637 in sequencer_continue /home/kristoffer/programming=
/git/sequencer.c:5426
    #7 0x5702a9d0f5ce in run_sequencer_rebase builtin/rebase.c:370
    #8 0x5702a9d14cd9 in run_specific_rebase builtin/rebase.c:747
    #9 0x5702a9d23798 in cmd_rebase builtin/rebase.c:1887
    #10 0x5702a9a3c26c in run_builtin /home/kristoffer/programming/git/g=
it.c:480
    #11 0x5702a9a3d3d5 in handle_builtin /home/kristoffer/programming/gi=
t/git.c:744
    #12 0x5702a9a3dc2c in run_argv /home/kristoffer/programming/git/git.=
c:811
    #13 0x5702a9a3f17c in cmd_main /home/kristoffer/programming/git/git.=
c:951
    #14 0x5702a9e77aa3 in main /home/kristoffer/programming/git/common-m=
ain.c:9
    #15 0x79371be29d8f in __libc_start_call_main ../sysdeps/nptl/libc_st=
art_call_main.h:58

SUMMARY: AddressSanitizer: heap-use-after-free ../../../../src/libsaniti=
zer/sanitizer_common/sanitizer_common_interceptors_format.inc:553 in pri=
ntf_common
Shadow bytes around the buggy address:
  0x0c067fffbb00: fd fd fd fd fa fa fd fd fd fd fa fa fd fd fd fa
  0x0c067fffbb10: fa fa fd fd fd fd fa fa fd fd fd fa fa fa fd fd
  0x0c067fffbb20: fd fd fa fa fd fd fd fd fa fa fd fd fd fd fa fa
  0x0c067fffbb30: fd fd fd fd fa fa fd fd fd fd fa fa fd fd fd fd
  0x0c067fffbb40: fa fa fd fd fd fd fa fa fd fd fd fd fa fa fd fd
=3D>0x0c067fffbb50: fd fa fa fa[fd]fd fd fa fa fa fd fd fd fa fa fa
  0x0c067fffbb60: fd fd fd fa fa fa fd fd fd fa fa fa fd fd fd fa
  0x0c067fffbb70: fa fa fd fd fd fa fa fa fd fd fd fa fa fa fd fd
  0x0c067fffbb80: fd fa fa fa fd fd fd fa fa fa fd fd fd fa fa fa
  0x0c067fffbb90: fd fd fd fd fa fa fd fd fd fa fa fa fd fd fd fd
  0x0c067fffbba0: fa fa fd fd fd fa fa fa fd fd fd fd fa fa fd fd
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
=3D=3D87324=3D=3DABORTING
```

> This is a wild guess, but since ctx->reflog_message is pointing to a
> static strbuf, it could be a use after free if the strbuf is reallocat=
ed
> due to another call to reflog_message(), but we are still holding the
> old pointer via ctx->reflog_message.
