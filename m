Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2B4C10E0
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607036; cv=pass; b=Clwx8pVoCNchluqZi0O8UybuyaOTPhM+yGw/IUpjabDKpzaTPWS/QE0cFC4LDGh8WSl1xcB8g8wrftRChqjZ1vB5SPu/ZXeQkJtYbygMvm4iXxrbjrVOlN2XkSUnEqNqzZn9XT62/Kk3JH5AOEQIQ3eImkg9+jerapBJxqWABBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607036; c=relaxed/simple;
	bh=xT3nCXt6UJiF09hGS9GN7RmBlf8HuXyfvFcIZfi3YRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1BcCoKzLSKyioQxCtfOgkgl6Mowu8WCtSxstcP/7zpfsNlzXBzHtTF3PcMl8uE64Rm9tGPX9+7047k5rRA39ZBwGqIK30ab4gdMdJ9/qlEHIWn+my/U5JKut0vM+r1JL6e3zV/Bi4+pSXJ7jjNMwtHYaK9XF2Rr+eJZIKgVmkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=m4pc5kBi; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="m4pc5kBi"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a87be3ca16so22699817b3.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 07:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790607032; cv=none;
        d=google.com; s=arc-20260327;
        b=bgxr6gSs3T3cRkBNQS9p3D+yfncQQK7zFPuxBkvMO6ajy0h/sDQgelRIM15Sug/x4V
         Sf9nbReuIqAzLrboBv343+t4TaXBTL7PBeHXRNRW0wZHGMH9oOQeeCVTsgWCihcWPL1e
         kao9Rzef/iOdtqMdvE9OrRCzhCQVJRxor+g7F0WCNhDigs7PWLXYoX2pwXjD+Yq0KpHv
         fiEDAH5fi3guY0KPLHohfe4of9BceAZ3j6BLqPyZePn5j7CzuAbl7ExMyZuoCJU5vGDm
         PmX8Wsj9siIXQIwNqT82M55GXA7GtqWtNgCUXozaDpJTSrA+1v4q+awM8EqMRJr0NZpQ
         U2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xT3nCXt6UJiF09hGS9GN7RmBlf8HuXyfvFcIZfi3YRc=;
        fh=bmhwXmV7+tR+ULASlDflnntqP33w/5PdkbcNmStABKM=;
        b=kfkKK/Rdl9AG/E7FmgeWGH03CfXIJSBtC2FWZQEj5Qr/riuNdzRq+eCIzla0+Zylk+
         L1yqs4jBDJwy4HC4Kl5q+0bvywETuQ0XYsl1DdOrY8zweOYOowkMs3130j2jJQV/2UHK
         KKb5L0NJHSt0t+a+QS941U4PHzwVa06Sn32N634yIXlkzmKG75fiU318nX7uGECWCgR1
         Jfk7AerJbthzboAF0O+4/+AuvzGiyd0pr3fgwtpCZ+fqpws7tPXQ+kdmh5N0hs00J9HK
         Qf92By9E9SexI4CIiebWVUg03Qb2I/2EhmFGP68v8vPtsEq59+Xw5jQN4BfEljQ0P0TP
         cBPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1790607032; x=1791211832; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xT3nCXt6UJiF09hGS9GN7RmBlf8HuXyfvFcIZfi3YRc=;
        b=m4pc5kBizL0qZjYmlAv6Bz4+QCDnrOnskJDlaiF0gXdjA1HdRo6HllsLeMAK3pPjEb
         dz1kRj5zf/xllhgSMv1l4kstNxgYmOgcrph0HRsmbCaDrKNDrZuHiIaKy+UT+xApMe05
         fGzGPSoL6/NLJlWN4yOJPq3XzxHqJcw/5gAp94Y8Oan7G165Oi0rxuLteM8LrGJDzRBJ
         EPrLeBkW/Maa1534o3k5LIjVb/uXrdzb5fLSkm1jO2Apj6p/Y0/tecTj03rGzxe+AUNR
         j8aqYpCibxyGC914MB+Vyj++DiE+ihAUqQ28Tftd6Rbm2kz5QIuDOBGdjghZ18irMGJn
         5UuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790607032; x=1791211832;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xT3nCXt6UJiF09hGS9GN7RmBlf8HuXyfvFcIZfi3YRc=;
        b=IvSgydedI1AlvJxVqfE3RoZDJiQpcJmVqw8kC9ebA/WYL+LWxxSWkmzneYyr/CxTrk
         VSCVG1GDcRkcxLzYr2e/LgQe9vxUpCloG94GYAl+ssOpgsCs2L3CUxZvPLUNcpaCKHGf
         csNoTD0CItsPgRkY18A2WErqNDHHvfVul5NIeY8+AH9aXoeC9tTYMJVxM6qS4SxwSvMj
         xOlsLygm+t/PT2mK+vQxBy32nMk3GoI7QBDdnwV28v+MHA1/oI6ut1rZ5oyb9xDi3cDd
         8xIjmqkUhZ7/VCEve6mymtX74ANsOP3Rx8N3yer72K34dor18q+MY+BnJjIWNXjl7z4D
         zm8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzfEqYA3cWLayg3QU0+pYMfo029Mp+YZVvHiXIl29b0+KCXgS0kdMRMR77Nc/vUgjjrskU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjQ+bbJoTU7vET25HuYpAElxDDapODmTx0J3ZbrA0Std3LWiDM
	inumJ83+nLvBk+CspOPJH9WgZ+G8RWmPMmgrnuGRhUiRo1yqIQQixW/g+BaGt2oCRSXd1K8wXwE
	yY3LLqiWdOJdv21JzPyb06oG7DYgCEmxC0DDdefGaxg==
X-Gm-Gg: AYBFou1BIVKNrLwXhtigiHsT4y+/+i/XVOZK7fYvIUMCiuccXaIp4x8CLVnfGeXlmXc
	zkasQocOL010xCWzXvrjJbMCon3lyoMuvSdC2PxjJxQ+U12vaUYAx0gaDrYBjIQJCJArYFFKxf+
	lb63OXBlCXo1GyIyAV9uGur1lUb2y/OTtdnx2N6AHHABuSwXNLVgHCZNmSEn4vmgHkEGU2LoUu1
	OQNQ987uvyObyoBSIetsPchntdqP8/Dk11SWPyAq2AtoO7MwwqrN66n8q0rB4tluVj1vqbXfs4s
	UnbRyQ2miZR17S2eqfbUu07WZ2slckC5EvnGsVCDwCaLiHbgZixP3D2vBhXoGxifVhcpMvwjzBJ
	0OhQiPNBVtp4W
X-Received: by 2002:a05:690c:39b:b0:8a1:1af3:7e98 with SMTP id
 00721157ae682-8a649d6e915mr57475087b3.102.1790607031703; Mon, 28 Sep 2026
 07:50:31 -0700 (PDT)
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
 <CALnO6CAf491aNhqcb7K7YcNTSTNLAESmqeLwzEGk_S=ZsOjG9Q@mail.gmail.com> <a59c4225-f093-4001-b77a-2083dfecce6e@gmail.com>
In-Reply-To: <a59c4225-f093-4001-b77a-2083dfecce6e@gmail.com>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Mon, 28 Sep 2026 16:50:17 +0200
X-Gm-Features: AclHuK8V9hX_D6f5cNdgOdeeathCyBPKkXHxWD6G7WOhpVg2JLh8fdbZngxvUBo
Message-ID: <CAA0xjtpzaWH10pHOQ5j-5Hp1yHEKTDFbsicG6E4w=5nxb_irWw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] stash: clean up index-mode test merge
To: phillip.wood@dunelm.org.uk
Cc: ben.knoble@gmail.com, gitster@pobox.com, git@vger.kernel.org, 
	eli@barzilay.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 28, 2026 at 3:45 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> Oh, when I was thinking about this over lunch I did wonder if that might
> be the culprit. Previously we didn't run "git maintenance --auto" after
> a rebase with the 'merge' backend but with that topic we do, and because
> we set GIT_COMMITTER_DATE to sometime in 2005, if 'git reflog expire'
> gets triggered it will expire the reflog entries that 'git pull
> --rebase' relies on. As you suggested in another mail, I assume this

That is it. I ran t5520 on 'seen' with and without Ben's series under
GIT_TRACE2_EVENT, and the two runs differ in one place: which command's
auto maintenance runs "git reflog expire --all".

"git pull --rebase" computes the fork point before it fetches, from
the reflog of refs/remotes/me/copy, and test 69 needs the entry that
test 68's fetch wrote there, copy-orig (f29aa66) to ae98574. With the
reflog empty, "merge-base --fork-point" falls back to the ref itself,
ae98574 is no ancestor of to-rebase, and pull hands the merge head to
rebase as the upstream. That is your "--onto ae98... ae98...", and the
four commits from copy-orig up come back, the first of them
conflicting with "conflict".

> topic has changed something in one of the '--autostash' tests that come
> before the failing test triggers which the new behavior. What that
> something is I'm not sure; off the top of my head I'd expect the number
> of reflog entries in HEAD to be the same but maybe I'm missing
> something. Adding

It is eight entries fewer, and they come from the failed merges, not
from the autostash tests. "git merge" restores a dirty tree with
"stash apply --index --quiet", and until Ben's series that spawned
"git reset --quiet --refresh", which writes "reset: moving to HEAD"
to the reflog. That happens eight times in t5520 before test 68.

Auto maintenance expires reflogs once HEAD's reflog holds a hundred
entries that the policy would remove, the default of
maintenance.reflog-expire.auto, and after the first test_tick that is
every entry. Which run crosses the hundred depends on how many entries
and maintenance runs came before it. On 'seen' the expiry lands on
"git commit -m conflict" in test 68, before the fetch writes the entry.
Eight entries fewer move the crossing past that commit, and the
maintenance run my topic adds at the end of the rebase in test 68 is
the next one: after the fetch, before test 69 reads the reflog. Either
change alone leaves it somewhere harmless, and nothing else is going
on. The expiry is the usual 90 days applied to entries dated 2005, and
the only new thing is one more maintenance run per rebase, the same
one "git commit" and "git fetch" run.

> git config maintenance.reflog-expire.auto 0
>
> to the 'setup' test fixes the test failure, but it would be good to try
> and understand why this topic triggers the reflog to be expired in case
> there is something nasty happening that we've not thought of.

I'd pin the expiry itself instead, as ea7d894f44 (t34xx: don't expire
reflogs where it matters, 2026-02-24) did for the rebase tests:

git config set gc.reflogExpire never &&
git config set gc.reflogExpireUnreachable never &&

That covers a "git gc" as well, which expires reflogs on its own. With
it, 'seen' plus Ben's series passes t5520 here and no expiry runs
during the script at all. I sent it as a patch on master:
<pull.2243.git.1790606282769.gitgitgadget@gmail.com>

FWIW, any script that reads a reflog after a hundred HEAD updates can
fall into the same hole. I have not looked further than t5520.

Thomas
