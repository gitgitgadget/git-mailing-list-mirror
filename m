Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795736702;
	b=3auzTYaz+vMJpPdoWbGJMy7H5lgQbWbiCsugyRsHhgGP3sAeevZU3AuDBPifSmiK9T9y
	 trPr2GHW9wafhzJFS9hCueZ8c4ZFBIQgj1Kz+OvILTKdUzi26iQJ8NdnJowLiq3yWqf+F
	 puLHQtB9zf1J84eBhpED5oPLgbFFAgXagK8gKZbp0o3voTHM+nhjWt6lg7+Yen01Ob7YJ
	 FhSuI8sFma9B9pIkJ3A9U2kY2Ldvhw+1k/hIvo4cHejzEuEpOAUkTMho98Lke2IQukZgx
	 HUbF3rupmeAbqZywLCbnvAJW9oHgIxnPZzppqtNSDq0CsMypRUKOCl8zDry4SVFkxLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795736702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Content-Type:
	 Content-Transfer-Encoding:Mime-Version:Subject:Message-Id:Date:To:
	 X-Mailer;
	bh=oMileMMJ1mlQnYPneaILxfJhRflM0z/3GdDLl2ipYX4=;
	b=AiKgDKvoJkjnpMfLer5PSaToSCVGfZq7bACRHb+QxbJLl6Tp1CDLEaR1kU0VHzL6eGHb
	 78+NLIHHqw3y+a5vDWSD3Qjm3Al/zvxUgVdaWhpEfefsxWH2NG1gntnARXQ7lnUaWgXLP
	 NBOko5I1EJR9/XnwJrR6y96BeU/qMWO0GrPqLNQT08ZE/VfWPcaBu0E/DPCoVx8E5MxPO
	 GGsOo+5UwLiGB3EFokmLSlCiZkBMh94kDzKhZV+QC5DSTJRP6wN4UW55fnfZfL3m5e6tb
	 G9TYtzyvdAo7nukHuEQKToyxfXS4lJC5ny93LWsMtJ540SEVsD6CBrTNTMAwwH6/mPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uINkduwD;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56545606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 23:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56545606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uINkduwD
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cde0daf3a2aso3243301a12.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 15:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795736702; x=1796341502; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :content-type:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oMileMMJ1mlQnYPneaILxfJhRflM0z/3GdDLl2ipYX4=;
        b=uINkduwDDFkbj19jCn6rp5/btTk8Q9SZaYxSZSGNbGImxX+N1rpwkMXRbll0XIiIUQ
         9hDKetEm7i9APpO4KXmHWnICAfvvw1218wzz9Xog/J2Ld0vy2trWp0TU19szub4dR1DH
         WJ5+T6hKu99EUcQwTRZNcdAK7Ia1H8ZW+8pKibgHebiiSb2InfjX1r2iEkGXBY4t6pB6
         1NwcWGDvVBqLSJztYURqsJDrAHO5WdtkMI3pPoUYAhbi1NVrwwDsTaMbikgJB+X+1/sr
         g60k6D03Ee2OL9psnphm7P7quEfgLid2Cm8roHx+ZOiQUOkk/rgzqXeEQoBuCHW4jUGK
         sYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795736702; x=1796341502;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :content-type:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oMileMMJ1mlQnYPneaILxfJhRflM0z/3GdDLl2ipYX4=;
        b=2k1xFJHbon8y02xE7c70PJoGtiQ/mNcMwwoRQbUxJJVB5DARlIi55aeS7AcsyOoaKy
         zoaVKGuZ3KV8B9ziXRZXYbDXLpeeHVLjG8ELTk1h8K40jkPX/DHeGZMG69MQjvmuBA7u
         wY3rnT+rYzpumhR/JCiCV+0uwptUZ6lG/cerOzHz03/0Sh1f63F1HNIoxbIN37p2buFS
         6ZBNZLGXNbupZZhzctCjBjmAXABakxGZQry1DxgubltxC+UoxywjTxzoIzgwypWAsKKd
         wKJM0XzAQ+T1TAdrE3kaO03CpzwRf1U+ndwKOlwJE8MKBFMwzrRLK4TT2RvTuQODpUYY
         D24w==
X-Gm-Message-State: APuU4Z/5hdjx8tMNPr3phvJg1IlDSeYoq31qmkZREHFTiJmu53IfszN1
	GiRgchq+1HIZQf81c2YPZuJdETku0hOwbcopm0HGwNipIgfaetC+f/DRJvptK1agTQQ=
X-Gm-Gg: AZFdTZesaxfo8Z8LLMiuaf8hpOVKjNmZnh1hD4uueKsB8A+j7egFQyAc6ek+fqw3yoh
	WEsMd6yx4kI/xduK/KPIG0knodlu7keOgB7xFT1cxUMUXDMqdSKcOyS90AIAWFLlzcRzivDL0cS
	RZnxZCCRrvrpjPwpm9080wGjyigln66S+qHZFXFET1aSzr+iah7tTFZ3NCreMI2I3+kl3WWZfg0
	cQ5+1w1V8jL53l6M/V+hPSLLwy7wMlWfeU0YVy6cwaJV08SsSqWI20IzW3aRF4tTrHxISwGEfXz
	HB1gHxceSDzmZ9gRRxgjWYDYoZTfjnp8oK+65uM7TtR8YikiAPsSSNDtkg7r0LW9kJsp/qxMpFa
	Pg/aJ4rvMMmzfvU6uC+9O5t0dNQTyJ5Gtw1tYYd3CyCNXBW1PeKuQ4u2BsPA3T6jlV4Wt9BCuPh
	sRtS0oAAZTPWq2ppOK407wdFl7V8ho9xP4vInCEKVPFzXWJS4SdC35ULOWLneFTmYtvyBmpMhhd
	UNGYR8WEdlEzq6n1RllmSwSkPsvKhjMeHxVp6WEcj6UdKBSoEhmRS1r/XeBRn2LjU87xyQuwyWo
	q/MUZt6R8/SPvYm5PnDz04zcHZzIsRC2F9pdAEABDpaX1DJUi9wWm87JYA8=
X-Received: by 2002:a17:90b:224e:b0:3a0:d265:3647 with SMTP id 98e67ed59e1d1-3b41c7d6084mr20176356a91.8.1795736701501;
        Thu, 26 Nov 2026 15:45:01 -0800 (PST)
Received: from smtpclient.apple ([110.235.218.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm25071530a91.9.2026.11.26.15.45.00
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Nov 2026 15:45:01 -0800 (PST)
From: Hamdan <hamdankhubaib959@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: [RFC] git task: grouping commits into named units of work
Message-Id: <0AB3AB52-1F14-4C72-ABE8-46B635F463CE@gmail.com>
Date: Fri, 27 Nov 2026 05:14:44 +0530
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3901.100.1.1.12)

Hi all,

I'd like to share an early idea and hear whether it makes sense for Git.

The idea

Most of the time, developers (and now AI coding agents) work in discrete =
tasks: adding a payment gateway to an existing app, building a versioned =
update system, and so on. While doing a task, we commit periodically as =
we hit milestones, so the work stays saved and traceable.

Today, if you want those commits to read as one unit later, you usually =
create a branch or worktree, commit there, then bring it back into main =
with a rebase, a merge, or a pull request. In a commit graph it looks =
like this: the branch splits off at commit 187, runs through to 247, and =
merges back into main at 248.

What I'm proposing is a native Task primitive that gives you the =
grouping without the branching:

    git task start "add payment gateway"
    git commit ...
    git commit ...
    git task done

A task is a box around a unit of work. You can stay on main the whole =
time. When you look at history later, commits 187 to 247 show up as one =
task that you can collapse or expand, like a collapsible list, so it's =
clear what was built there.

Why it matters

- Readability: on large codebases, history reads as a list of tasks =
instead of a flat stream of commits.

- Lower friction: for beginners, small tasks, small teams, and =
early-stage startups, "start a task, commit, finish the task" is simpler =
than creating branches, switching context, rebasing, merging, and =
managing merge commits or PR overhead.

- Agents: an AI agent can open a task, checkpoint freely inside it, and =
the whole task can be reviewed or reverted as one unit.

Single-branch and multi-branch tasks

A task doesn't have to be tied to one branch. It can live:

- on a single branch, e.g. a feature built directly on main, even if =
unrelated commits land in between;

- across several branches, e.g. a fix on main that is also cherry-picked =
to two release branches, or a feature with a backend part and a frontend =
part on different branches. Four commits on four branches, one task.

To support both, a task would be identified by an ID stored in each =
commit (a trailer such as "Task: payment-gateway"), not by a commit =
range. That ID survives rebase and cherry-pick, so Git could answer =
"which commits belong to this task?" and "which branches has it landed =
on?"

What this isn't

This doesn't replace branches. Branches give isolation: your unfinished =
work doesn't affect anyone until you merge it. Tasks only give grouping. =
Larger teams that need review before code lands would still use branches =
and PRs, and tasks could work alongside them.

I know related things exist: --no-ff merges read back with =
--first-parent, commit trailers, GitButler's virtual branches, and =
Jujutsu's change IDs. My feeling is that none of them make "this is one =
task" a simple, first-class concept.

This is an early concept, and I'm not sure it beats branches in every =
case, but I think keeping the mental model this simple is worth =
exploring. I'm happy to build a prototype first if that's the preferred =
path.

Thanks,
Hamdan Khubaib (GitCoder052023)=
