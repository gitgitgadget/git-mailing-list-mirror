Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA7E81ACA
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508354; cv=pass; b=k75iFw4gG8PbUaXe1BwOVKLtW3BxwtL1KRgF9zZ49DGZY2/Ckkfm16TlGAwIU+zfF9iQoqJfooe9KqX62cccxX4X/QgT1CoiqmhmIzPDnRVaBRraMYcqrhsXww8X0HtEBXl/13tt2bgDBi1LBYK+m13moBYM2pI9+kl738r1J14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508354; c=relaxed/simple;
	bh=U6x/PCBSi88x2sFjs+/ore9+uFddShho/tI/Zm0M4a4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SL/kaqOjsZiWNXzbJjhb6c7p/Nf7Me681Ttp/XMTHH5jEIX+xCvytSMiceP0p7tMeZiExK3GZ+qjQ0v9cXyKn/FVhXlm4VfeTg8+dtO9FLOgpONEyAz7ixtGPZay8LHFdoIDPPdpqAK37YL2utFx702nPPsF8jrmosvUa1CctkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+ABBhLy; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+ABBhLy"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12732e6a123so1733710c88.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 10:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773508352; cv=none;
        d=google.com; s=arc-20240605;
        b=AdNzynYwECaAkfsuYJJk826fMpzwk9gBuLVEPDbBF1Ip2BeDLrC29j0ua8WZrBkZ0Z
         NjxCVGUuAxEYUBuFvf6iHjvmavkuWlWdd+eiJENCeopz+whzCIieWEqtb/tPG/IFcjum
         NarrIdShvoMCkv2v7BkFrJXsramY7yjXWns9sPg4y1Cr9hlR7nFOdbN9p8sj+k8unQCT
         5Mu45xpmevic19aITOFR8GPzf8AnyL/psqz5lvY2jfbdwgjhjgCJjcdigaAqva/JOfBl
         SmEaU77QoxzOBBB0+g3NR40Zj7Og+1OnlvEu3W5MRPs7UA6IA5Lml77RKdAJ78jrOKPl
         8OBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5d2sN7h1eGsZbSrlxe3LnOkBu1PlPGYFLx7mzWmd0YA=;
        fh=vKrLYJZqUZCCFWO1cmKU8Lg565EWHFJiQOSoBPPWIqY=;
        b=hltyGgEwdGw/FvJDBDeE4TcroZTojmOcmtyxmJdyNJIMVKz9UeiIre9UBpYiiW3APX
         sf6oHSQfjE0w6WLmdiK8aCQ7Um3vbIR1hyqoJpk50rPbEaKVKkoJfIRJhFJzXb7TPcgo
         wLB1DTad5cn7Tw5eYfTih+sJAEY+UruGUyjMGB/aKRhMh9C7LN9N7vvFlcEMJLM7q/8F
         if28AdKryItj83ZC3CkTusUUdLKZYerl7TzwhDdjyk5af2ZQP0j5WucrNdSEKcpQ2KOb
         7keIAv8IztoMnUw6fvEUxRYHlv24NqGP9M3J5S3/NAOiKS7WcVu9nujwxtITtF+JEOI4
         VbMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773508352; x=1774113152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5d2sN7h1eGsZbSrlxe3LnOkBu1PlPGYFLx7mzWmd0YA=;
        b=b+ABBhLyDLJZr44J/BhAwVUoS1P0lTn4VnjTgI6YwVeRdzqR9JI+4OXPYi9+r4f8h7
         QZev7gLbhiGWGm7sOqj0JhDXwrDqMhpxLNKnvob9ZLGUMokgJTt+92teDVrBOONbZv2b
         bPR4VkyK2Pj9Shh8jAGLy4z1zRLV6OQUDef+exE106OcrGS8BaQQJvQwk7lLNF6RHr4P
         PxESlZfMMuOy3C+bbE0qPGsPqeH2IpAKQM4R7M5GV9z6v3qPLTLbD3KqYCUk1i3y4JWh
         xnXSp8KBt/ozqJ5/0b0v4yqwLkPchYCXPoE0rTz5AsTWd6YMlfI413XGA3z/PehixTYt
         30MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773508352; x=1774113152;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5d2sN7h1eGsZbSrlxe3LnOkBu1PlPGYFLx7mzWmd0YA=;
        b=W+eBSfUYeD4DJWi/E6zpoVM6RG4djMwQYpMUEimYZWUsmLLFIgYXFF9/mkvWr5E/66
         VD21tF4fmZ64mDc/VG0xwThkLDCg+fjfAepiPdtr9LEwDXWpWSiF6EWCspbg28TKpISD
         bYGxYosMRHje5XSpmTnDUKblADitIm4Ics46DKCea/4mGfvIR0AZ6Q+OQcL474ERvUyG
         MLNJKKpAY4ONob2UlgAiCFxwaBMWhb3yFzyY8oXRrElWCUxc2/POitKpy6pipGM5qA8y
         7Ic6KCqYUd44+I+onJyh1aNlqGDAVDhhwJFuBvGr1v9X3CsA7ltw8C/HBiNvogCW1o0k
         uydw==
X-Gm-Message-State: AOJu0YzsKW+qhL7ZRqYX0jt81e/6DDHOJXC3efZj+joAQsJStuT2x0Y/
	q0i8M2VO35GO5SJDSCa1gci3iz2ZR/qxWRhfimxMK/tcEcO3tlmtolXtGKGTWDGxR/7QYH9cj2U
	03OOCgw2GQcmV6hsmYEbREq1V57nqKBMw0AMp
X-Gm-Gg: ATEYQzw0RqTPUTM92pUbIkh/vaTKKyNE/e0P9dTm6HFwvU9ibZ2KFOdtrJWlyaGZee9
	GyCvIKXRKiiamtg/v+p7QeV+w80ezu16PsFpjW+nCIzvwYQE8ivDrfZBf1e+PFGfGY91QOSVu3E
	QB6b0ddq9bjox/9H01jmSuZYEfUxqNf4u9ZyTxSWw8vfJQpOLiSo4mLKbgKuxJrhX1I/4vqKzhI
	gjYiXgRzH8NTzsQMl6gBJdf6Ww/HWl9bP+cL2xJs6QJaDvTo29QTmGuHtxQWWKMWGMDHASsiWOE
	AO1fBkVrOi4CTdzkelgQlMD+f++hMYFZ+qFTMVJw6w==
X-Received: by 2002:a05:7300:5383:b0:2be:3f:307c with SMTP id
 5a478bee46e88-2bea55ef0c8mr3401564eec.29.1773508351982; Sat, 14 Mar 2026
 10:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Sat, 14 Mar 2026 22:42:19 +0530
X-Gm-Features: AaiRm53axgPIJyxak1272h_43anmlcxJLbA756YcQc48a9rILav-8dxdEmP1wzA
Message-ID: <CAG7UgESKLMnO_4+PSJUt-TXJxFQyxEEfpCmJfMmTw2+rhT-HWw@mail.gmail.com>
Subject: [RFC] coccinelle: detect struct strbuf passed by value
To: git@vger.kernel.org
Cc: peff@peff.net, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

While reviewing the write_worktree_linking_files() fix [1], Jeff King
suggested adding a coccinelle rule to catch functions that take
struct strbuf by value.  He noted that a reporting rule using
coccinelle's Python scripting extensions could emit a descriptive
warning.

A transformation rule achieves the same detection without the
dependency.  It rewrites a by-value strbuf parameter to a pointer.
The resulting diff will not produce compilable code on its own
(callers and the function body still need updating), but the spatch
output alerts the developer that the signature needs attention.
This is consistent with the other rules in strbuf.cocci, which also
rewrite to the preferred form.

The rule itself:

    @@
    identifier fn, param;
    @@
      fn(...,
    - struct strbuf param
    + struct strbuf *param
      ,...)
      {
      ...
      }

Running 'make coccicheck COCCI=contrib/coccinelle/strbuf.cocci' on
master catches two instances:

  - write_worktree_linking_files() in worktree.c, which is already
    fixed by the series in [1].

  - save_untracked_files() in builtin/stash.c, which takes
    'struct strbuf files' by value.  This is the same class of bug.

Sending this as an RFC to get feedback on whether this rule would be
a reasonable addition before preparing a patch.

[1] https://lore.kernel.org/git/20260309192600.GC309867@coredump.intra.peff.net/

Deveshi Dwivedi
