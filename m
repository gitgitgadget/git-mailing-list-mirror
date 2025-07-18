Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D191F4E57
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752877595; cv=none; b=d/WBU70JlQJu7pJUPde3PbgVAJfB6M9rTNvapV3AV9nbXtKFPhfyYRUrdA1idclA9Xmk4cvaRRDahdocZBoxE0r7amkOWyIkIa3qxLrdqsjhgd+xn6OT26tbgg4C9Xoh3MI9JBo61PEIEIPtPift58qrb1quCjVjN3ZpS9iRsPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752877595; c=relaxed/simple;
	bh=YraHHEKqVtUhUNlW5MCSCyV1HiWnHXPKTicWabWg8Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g84XEzFnaVv/zfleLnwYh1dj0k2k55Jy0DXg9yfNNOMyMiB4PkrU8A43B/VsG+3ct1sC87UpWJJrYqgrB903vq6v0sPxZCq8L9v4KuoMMblAFTU+ToYXhPW/8+Bu96CKWN8sHU9wKA5h3NBWDY/QYoJ9j5116kVfrtlDKiRSwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zz/KIPDy; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zz/KIPDy"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70e77831d68so25394347b3.2
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 15:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752877592; x=1753482392; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kHuHywzeTB5qi0/Z0VJ6BgsNpd4suEKMxoQNN7U+c9s=;
        b=Zz/KIPDyXIBLnB0zltf1gaS0iYMgQfwFAnpqbz4K4hX0OXml/vuKyxrBjnGR5ycbmq
         AUQKOTELYsefGCn5A0u8bs0muNSMfXYBcd83mVdgFWA/Ydey0AXPW6rzmadR2xpS16wA
         2PGXqxiWpGSnUsRKQYloNBLMopZuXuq0/ikYZgWRyYZVUCF0hOLdNmHYn4MjwYFNZVwi
         R0o/RYtafsnXN83j4aFFQgrf3AclQcrRk4PTLxC8+pwaZra3g2eAJjJ/4gLZjQ8WTSQJ
         93taLobuX5IY0ahaLbdEllG98VdM7OzFrffJNGF/R1hk4V8VOnxTEctwks6PkzaY5NgP
         5G7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752877592; x=1753482392;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kHuHywzeTB5qi0/Z0VJ6BgsNpd4suEKMxoQNN7U+c9s=;
        b=ceD592P+eqq15R733wdjNVChPHTxTKXjOP8SHa8I6xsDE4YM1YXOEbkHvZi8pkUhR4
         e01dO1+50uq3NJh9Ks24fgO5W5WRLpRNRVYOl6dnJrLDpkqMxAiM7mN3fZWqYHTxKlfq
         FVwPf1WUWSpADZUwx2OOi2A5s05/YSAWuJ4eiJkQrN3/EXLkfRMQK1iElQhvm1qMR5IX
         1T2jrzqVCSBUHevqMOJrMjFodml+//VIIlfnrQR/395GMa6SwSGwYYS2CJSfrRAGx/Tn
         yanqojKk/Z48yLvV9hBn6fTH1Vf21ih4eimmvvqHeelzf4d/OREuO4PGxd+pR0FzDOll
         yRpA==
X-Gm-Message-State: AOJu0YzJtTRlg1lVD5CSMEw1TErZfdG0uIY+pK1DlZu5jjbuMrTZTlUr
	UlT2P4ooOXT+V0qF5D+Advf3PqLiawJbNxx/WVHFwm6L5W6bgqw3NxJpkjiqTw==
X-Gm-Gg: ASbGncvMZ8an90OdGSVnQZ3ID1ORfmvGtEWgJqYt8aFk+sicFi8U+Vwc3dEiIkBKVBI
	tOfyflOuu1t8nFE52rvY8gnZWIfaRLoH9RhlV8o0g16mYZOkvVp+2ah5cMtr8BUbHepOG1AqKA2
	WKhW8ypg4vCXT4wRlmrSvyur8SvceraF0dnAglm/s04Vb8A4RfaWntteyLf05z1F8LMYbfbM177
	oyuUUXFohOqPzf+xT+/qvT5adHEp+XyvGHLqZv13p6QeecTIpd7gFPBrD+gRI/LHeipveqpkaFZ
	Xi8UQk6z7yL/tVwzR2fTmTmoQo3migAVs+69gCs26E4fQdPOxlIvgq2nQcDDE3R4XEuawSoUVPl
	cul38Z5+vyPH2raTq4H+zhqND
X-Google-Smtp-Source: AGHT+IGKcr2fupcPGYx2kE9shTRl60Fk71XnhUJPQzEcKVisPk/4WhqcVDg3Nf3x7/E/UPCy0bu5zw==
X-Received: by 2002:a05:690c:740a:b0:714:55a:da9c with SMTP id 00721157ae682-718373385a9mr211128087b3.28.1752877592159;
        Fri, 18 Jul 2025 15:26:32 -0700 (PDT)
Received: from localhost ([2600:1702:5e40:2a30::27])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7195314805esm5418527b3.41.2025.07.18.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 15:26:31 -0700 (PDT)
From: Eric Frederickson <ericfrederickson68@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: A Question from a Hopeful Future Contributor
Date: Fri, 18 Jul 2025 18:26:31 -0400
Message-ID: <87y0slp23s.fsf@arch.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello everyone,

I hope that this message finds you well! I'm a software developer and passionate
git user, and I'd like to try my hand at contributing to the project. I'm
sending this message in order to ask Junio and the team if there's anything that
would be particularly useful / appropriate for me to start looking into on that
front. (Reading through the last few "What's cooking" messages, I didn't see
anything that jumped out at me as needing a new contributor, which is why I'm
asking in a separate message instead of replying to one of those.)

(Some notes on my skills: working on docs or tests is always a favorite for me,
so things in those areas would be a great time. Also comfortable with low-level
code, and any kind of scripting. Note too that academic background centers
around programming language design and parsing related stuff, so I've got some
fluency in those areas that I could hopefully apply well to the project if ever
needed.)

Looking through the repo for a place to find todo items, I naturally stumbled
upon the TODO file in the origin/todo branch, and saw an item in there which
seemed like it could be a good place to start:

> * "git status" on intent-to-add index entries (say "I" in the first
>   column instead of "A" for short status, add "(needs 'git add')" at the
>   end of "new file: $path " in long status).

I am interpreting this todo message as meaning that the following behavior
should be implemented:

Given the initial conditions created by the following setup commands:

---
mkdir EXAMPLE
cd EXAMPLE

git init

touch a.txt b.txt c.txt

git add a.txt
git add --intent-to-add b.txt

# Leave c.txt untracked so that it shows up for reference in the git-status
# outputs below.
---

The goal of the todo item is to have the short git-status message change from
this:

---
A  a.txt
 A b.txt
?? c.txt
---

to this:

---
A  a.txt
 I b.txt
?? c.txt
---

and to have the long git-status message change from this:

---
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   a.txt

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	new file:   b.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	c.txt
---

to this:

---
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   a.txt

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	new file:   b.txt (needs 'git add')

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	c.txt
---

Let me know if this would be a good change to pursue. Also open to trying
anything else that's needed!

Thank you for your time,
--
Eric Frederickson
ericfrederickson68@gmail.com
https://emfred.com
