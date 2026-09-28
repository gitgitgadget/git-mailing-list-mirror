Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DC64E66A9
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609792; cv=pass; b=nJUREaoRPTKMLryQa4mZBKcaBjqxSdaIZQPOsNF6zR+gYnuCexqyTsJjxzrj6sheGLU7whH2C5sXmgcST50GdDfeJ/QBoSLfPopdWkwhD5RnCl3UnyB/vy2Ru4g77QbKKM2jSNWCRpB3FZ06ibD0+koOe1Hap+eJcYCYTqQMr0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609792; c=relaxed/simple;
	bh=tLwoHnG/mxkXBCCUTdhd7iOqZyPcNhv719SFWqmeiMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDaccUlRWNci/emx/NNkwWcuID499C2shg2csSjRyLKAqf5ozTJI/8pt+PY0koEQieyKCKXPgOMfAuGG+Y+hq6Rb4MsYTfLSTW+DBVs5sVGh0bH+IiW4LDDdAGvdB34TShPte5L7dC65ZXGDd/s3Qe5ZOm9qYRN6ebH3+lRF/Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkXI5XGF; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkXI5XGF"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc750a1482fso1737805a12.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 08:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790609791; cv=none;
        d=google.com; s=arc-20260327;
        b=om6fTb6OeekePTk3qV0iuzGpqLS6cQKjEU05guDc2xJHVE1nsE+YibYyRZcvTLu4jR
         eKHA8TEhkpYwjCG4e4C4oepkidOE5D5R+BOmZBGxV6wuAur7rm7XkV7QXMT5dpmOqPQ3
         sIYltV2LdCsgjJaqpFvrAv1+QoGRZf83bn5e2ytvdPyiv4co22uFvRru7cym9nKq1x/Q
         tytZ8TQFn1EtJG6wEwsyUHhwtEObzSb+ebDNzaZgioFxWJCRTNM4qhq5OzDGXSUgxvRr
         /E7P7LKG9tagsBVpB3HgAQstlKwGKIIHJdMPlmm6Jc/8SZjVGgNTRXX+8mjU7arkTE86
         hEvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tLwoHnG/mxkXBCCUTdhd7iOqZyPcNhv719SFWqmeiMw=;
        fh=YnA6kTP7eA8SCMH+sPWO248C5ddIxPSEqU78ZRjRFRY=;
        b=WUZs29T+poTEk+MewjFMJnOVjbNuTdr3jZeOyZNYgDLiGnKv8NaXR8nwdvDzm+Gtgl
         LNj1al/yRsenVaAEQnb9UicE2qTF6xMosx/y7btQMU8orswCYD7+irLt2oyELG/NOJ/N
         HKP7Zlai90HVwXhIaz9IPm9vgFvkfB6oFMUaixrO/QT6yh3D3tr37SpIvHXpu/Lo47sU
         gDg2zI/KxGykSpA0yY76K1ZLAE3rnaI9rWO+LadogF0d7YOFQNSJ4uVK8VpayrWscfJ/
         sxaquNr01npZnQfl/bL8LKHiCEy1IZxQYbwPGoheFR5hYQUoV4X8lN7scJqJ4wq+lVY4
         FiNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790609791; x=1791214591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tLwoHnG/mxkXBCCUTdhd7iOqZyPcNhv719SFWqmeiMw=;
        b=bkXI5XGFQtDRxGqN8DN16lIh/sKTd/FZU0wC0OcZ1j7A6h0ZO+IXoWrT+2tbXsui3s
         /gw4DIQCCUp6g/SsszCS/uHwTpjfL1F36MpC+h1F1XNRQJbmYgGBJX5h+lEfLZRTbHQT
         rVGPEWLalmAfJjH32vSjVrq1tTGvtC20/K7JGUKUDgIjMR4MZ039qXaCTTCRPezj18Zs
         AjlDw17yiPuj/Lfw7dAvjwtBZxL0ntPbIvHRlymFx6BEL506K9bWZ1qZoCE9eo5sz2NA
         rr/jGO3CwsH3lfRfnx8uBw58OeCQl8u0BA7O9pZGba12qWsECvVZLZXwNxNl/65PaIyw
         bb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790609791; x=1791214591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tLwoHnG/mxkXBCCUTdhd7iOqZyPcNhv719SFWqmeiMw=;
        b=HzfsbasnA+6B25tI/RU66u+aFtEr+eGPLCGl6BtInFluDCrHSmYIpB7epdr6lYL8vS
         ZJZN+5VrJ22geaLE+RGzCw06Eaytr53oo4ChgTb4XpP67TbdZf6xHyZx2+woAqr5rTmC
         OzxMJERJcwRxIf6o8S71+tTbDHc2skw6lhx+GkuVA63E0TUGtEBWLn7OfREu47Km3myv
         2D0mh+9QWtvBhUH3HoLwx4ec6X1FfvfBukiQXcIglUehoeJj12kb1lVOsmvo3eNF1kAA
         nLDFUxsSFkjfPcJTa5LSYe+TErAc1pXu2vkH4GbYJhoAdgRxL8lLsWlhAj5oOnrw8wh7
         kxWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwm38m2lzGiYE/Et86dQspKR8mDeTDOG92oLxNgfxBfEeaLFs7kWWUzuLgPrAesZrKjt0k=@vger.kernel.org
X-Gm-Message-State: AFuF++kwOGeN9LV2w8oxCO2rE2+3FEQaes/spik401NLuEcPnxrH9pc4
	dXtel+53gRtMCuA3nMcJcJPdhJt59PFGPAgMlcT7JoK43lCT0eenHqtSDU5ZUpRHDYRjD6Q3My8
	Q62LBMSH3j1LiEaT2RdNKYg4AUy4ic5U=
X-Gm-Gg: AYBFou0umGMMvpIlvLuuclrfX0/apX6vm02Tyh4P68S6MEdbRtMN4/TvlHlFCs4luQr
	b58mxUaFM4MIFsPjcqZC+p00mjT0JS45i4vPL9AUkx4rbbecrdhrsW/7OFZVjV1aygCP61kFeRc
	d/hOt1xTXMl8LGYCFNzUgJaL1JXmCb+LkJTccFUqg8cJwJGYXVpDqMvALfngnosN7xe+kHjYQ5F
	Yo2rV6qJaaTAO7Seoln/0z9yi+DXpk6C6gNEePaMOT2hLlHzVTGNltHSzheLNAdSO3UC6A0cVsk
	ENxE3pZ6vq4vVmH0NSEs6er+IkoR2Onof4NKcxiN2CogYl7c2ASkERT4xdbLvblFPLh/CObif0E
	Ls6HuqB0mSuCGh1dLu+/RiA/Rk/DTcjebN7Fg6yxzEh01/qPAO7cfiHMRcnqBUSw5Mwv+Vkq/Wy
	PdYLleQBYpGno0PGKIQHMoDXCN/SdSIg==
X-Received: by 2002:a05:6a20:144d:b0:3db:4e0a:df51 with SMTP id
 adf61e73a8af0-3de26c609a9mr10061618637.22.1790609790588; Mon, 28 Sep 2026
 08:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790168285.git.ben.knoble@gmail.com> <cover.1790425008.git.ben.knoble@gmail.com>
 <xmqqjyo6qz3z.fsf@gitster.g> <346c4209-9600-4302-817f-e8f6b364ce6a@gmail.com>
 <CALnO6CCXT1HHUwL8+eYGVL443nO0eoC7vhpoLvC3RXjp39XQYA@mail.gmail.com>
 <CALnO6CDOo35HAfqn_h2CUUdux9LeOkjM8OdFLkkS1nVexijUvw@mail.gmail.com>
 <CALnO6CAf491aNhqcb7K7YcNTSTNLAESmqeLwzEGk_S=ZsOjG9Q@mail.gmail.com>
 <a59c4225-f093-4001-b77a-2083dfecce6e@gmail.com> <CAA0xjtpzaWH10pHOQ5j-5Hp1yHEKTDFbsicG6E4w=5nxb_irWw@mail.gmail.com>
In-Reply-To: <CAA0xjtpzaWH10pHOQ5j-5Hp1yHEKTDFbsicG6E4w=5nxb_irWw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 28 Sep 2026 11:36:18 -0400
X-Gm-Features: AclHuK9z7TbTrRP6JMoClhoXJHmAszVIIZbLuKE7OouhjPtljqnmhb11TkoAZEY
Message-ID: <CALnO6CC-eop86W3VREwGz0seG1pmtd0qS968TyP=mo_G+ZMrSA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] stash: clean up index-mode test merge
To: Thomas Bachem <mail@thomasbachem.com>
Cc: phillip.wood@dunelm.org.uk, gitster@pobox.com, git@vger.kernel.org, 
	eli@barzilay.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Let me see if I understand correctly=E2=80=A6

On Mon, Sep 28, 2026 at 10:50=E2=80=AFAM Thomas Bachem <mail@thomasbachem.c=
om> wrote:
>
> On Mon, Sep 28, 2026 at 3:45 PM Phillip Wood <phillip.wood123@gmail.com> =
wrote:
> > Oh, when I was thinking about this over lunch I did wonder if that migh=
t
> > be the culprit. Previously we didn't run "git maintenance --auto" after
> > a rebase with the 'merge' backend but with that topic we do, and becaus=
e
> > we set GIT_COMMITTER_DATE to sometime in 2005, if 'git reflog expire'
> > gets triggered it will expire the reflog entries that 'git pull
> > --rebase' relies on. As you suggested in another mail, I assume this

> "git pull --rebase" computes the fork point before it fetches, from
> the reflog of refs/remotes/me/copy,

This is described by the manual for git-rebase under --fork-point,
which is on unless we have an <upstream> or --keep-base (modulo
config). Put a pin in this.

> and test 69 needs the entry that
> test 68's fetch wrote there, copy-orig (f29aa66) to ae98574. With the
> reflog empty, "merge-base --fork-point" falls back to the ref itself,
> ae98574 is no ancestor of to-rebase, and pull hands the merge head to
> rebase as the upstream. That is your "--onto ae98... ae98...", and the
> four commits from copy-orig up come back, the first of them
> conflicting with "conflict".
>
> > topic has changed something in one of the '--autostash' tests that come
> > before the failing test triggers which the new behavior. What that
> > something is I'm not sure; off the top of my head I'd expect the number
> > of reflog entries in HEAD to be the same but maybe I'm missing
> > something. Adding
>
> It is eight entries fewer, and they come from the failed merges, not
> from the autostash tests. "git merge" restores a dirty tree with
> "stash apply --index --quiet", and until Ben's series that spawned
> "git reset --quiet --refresh", which writes "reset: moving to HEAD"
> to the reflog. That happens eight times in t5520 before test 68.
>
> Auto maintenance expires reflogs once HEAD's reflog holds a hundred
> entries that the policy would remove, the default of
> maintenance.reflog-expire.auto, and after the first test_tick that is
> every entry. Which run crosses the hundred depends on how many entries
> and maintenance runs came before it. On 'seen' the expiry lands on
> "git commit -m conflict" in test 68, before the fetch writes the entry.
> Eight entries fewer move the crossing past that commit, and the
> maintenance run my topic adds at the end of the rebase in test 68 is
> the next one: after the fetch, before test 69 reads the reflog. Either
> change alone leaves it somewhere harmless, and nothing else is going
> on. The expiry is the usual 90 days applied to entries dated 2005, and
> the only new thing is one more maintenance run per rebase, the same
> one "git commit" and "git fetch" run.

In short, expiry used to happen prior to .68, so the reflog entry
created in that test which is used by "pull --rebase" in .69 is picked
up. With fewer reflog entries, expiry happens later, and it just so
happens to drop the important entry. Darn!

But here's what I can't figure out, returning to that pin from
earlier: I was a bit surprised to see mention of rebase reading
reflogs! When I remembered --fork-point, I was even more curious (but
at least it's obvious that rebase will read the reflogs in some
scenarios).

What confuses me is that builtin/pull.c:run_rebase() sure looks like
it provides an <upstream> to the command invocation, so shouldn't
--fork-point and reflog use be disabled????

I'll try tracing that test myself later, I suppose. It's nice to know
we have a fix available (thanks for the patch), but it sure feels like
a hack :) oh well?

--=20
D. Ben Knoble
