Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255771D698
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz8gEt/t"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d3352b525so6069015e9.1
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 00:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703062421; x=1703667221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vtv06wccbYG6FgiYAiCii8cfKyOpqCvmcgj7FaWycUI=;
        b=Lz8gEt/tik4mqPu7N4xjkuuwJc9XBLSP031Wm6QNDrpBBWxD4/mY0sdrMR6QHNmwPQ
         IWfF3DzIUGwCSLd0uuYrIhLWiBSlg14F3nSO8Lj8ENkOlGt0fX0Jwo8iMrwBe3reQXk4
         QWQsWqRPfvsycs0lFJzojt4OZp9Ig3luYP2t2Nq8WEik3+FzHQ2ZMjKY5QvmCieTQjfM
         jQN73lrpvJY9gOg1RqSx9cPP63GKy7X7/vHIjDblv454i6Y1c5dIv7st//3uw+spGP/l
         HHhevgueFGoHtlsHe6UcloD7LDxjlJzph8k1n6/GEYcVinV5n43aeOHBl/14NjqYGRvX
         oSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703062421; x=1703667221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vtv06wccbYG6FgiYAiCii8cfKyOpqCvmcgj7FaWycUI=;
        b=TPTJXNWQ/1bg64DvLyzMpyVTcb3Pte3eSXtf3tK4DcGk+d31cyXNtPsTFIXEncOykm
         RTBeTUQbx5ANEK3dXX4CGyryPED5jm7VpZYH9TbFSjfasynPZ+4f0OeD9FwmkV6VO4HA
         X0WO8KPrhi5KWk+Qaoif1WAOb5eQiRRSwr6SSlQlIzu4HnycG6iiPMfe6l23xvwacRK7
         QIiMVSqjsMqP/g5SRyN1nK17O90nnXUSU/tWb6xBYNEg8pKhtLzThCEcM96Nku1zSm29
         gpKVvLbi3nrmC2cQP3oH9l6hggWE7XhvlIB3ldYAP4WXjZXEjeQ1ZN2lI8+/gDHGAQ1I
         0IHQ==
X-Gm-Message-State: AOJu0YyKalI2GUHesN/JfaD/Stod7SAv2K/wEQvTbXVMRlOw9OWECeTx
	5aYMRTeXyNRcxBw0W5Vwp7Q=
X-Google-Smtp-Source: AGHT+IEzi1dLkK9/bqR9/0FKYhvVjl90RJZyVTc2zAmBTDB4MWSBmuVQAgp0hkgRSH/W3aId2Y0A3A==
X-Received: by 2002:a05:600c:b86:b0:40d:2fa9:4abd with SMTP id fl6-20020a05600c0b8600b0040d2fa94abdmr698280wmb.132.1703062421130;
        Wed, 20 Dec 2023 00:53:41 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd7-e0bf-0-e5b0-3039-5d18-ec57.ipv6dyn.netcologne.de. [2001:4dd7:e0bf:0:e5b0:3039:5d18:ec57])
        by smtp.gmail.com with ESMTPSA id r2-20020a056000014200b003366224319csm9777650wrx.53.2023.12.20.00.53.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Dec 2023 00:53:40 -0800 (PST)
From: Michael Lohmann <mial.lohmann@gmail.com>
X-Google-Original-From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: gitster@pobox.com
Cc: Johannes.Schindelin@gmx.de,
	git@vger.kernel.org,
	mi.al.lohmann@gmail.com,
	mial.lohmann@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase-interactive: show revert option and add single letter shortcut
Date: Wed, 20 Dec 2023 09:53:34 +0100
Message-Id: <20231220085334.13234-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <xmqqmsu7e4hp.fsf@gitster.g>
References: <xmqqmsu7e4hp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

On 18. Dec 2023, at 19:43, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Lohmann <mial.lohmann@gmail.com> writes:
>
>> A `revert` in an interactive rebase can be useful, e.g. if a faulty
>> commit was pushed to the main branch already, so you can't just drop it.
> 
> But wouldn't that be typically done simply by running "git revert",
> totally outside the context of "git rebase -i"?
> 
> Interactive rebase is more geared toward rearranging an already
> built history *after* such a "git revert" is made and possibly other
> commits are made either before or after that commit that was created
> by "git revert".


Right - I recently found myself in a situation where a coworker merged a
faulty commit leading to a build failure and (given that only the two of
us actively worked on that project) we coordinated that he would prepare
a proper fix, while I wanted to rebase my current feature branch on
master, but with that commit reverted. For the sake of a clean history I
preferred to have the revert commit right at the merge-base, instead of
somewhere in the middle of all of my commits.

But you are right - if there are more than two people working on a
project, the typical way of properly doing this would be to revert the
offending commit in the master branch until a fix is available.

You can also do the revert you want to create in your feature branch and
directly update the master:
- `git rebase -i origin/master`
- add the following two lines to the top of the todo list:
    revert B
    exec git push origin @:refs/heads/revert-commit

Instead of
- `git switch origin/master -c revert-commit`
- `git revert B`
- `git push origin HEAD`
- `git switch -`
- `git rebase revert-commit`

So with the interactive revert you can create the "revert-commit” branch
"directly from within your own branch”. But indeed - it really is not
needed...

> A much cleaner way to structure your branch is not to muck with such
> tentative changes *on* the branch you eventually want to store the
> final result on.  Fork another branch and rebase B away:

I really like that workflow! I’ll adapt it :)

So in total: I don’t think documenting this is necessary (that is also
why my first message was not directly the patch, but the question why
this is undocumented) and it might even lead to the unclean workflow
that I ended up having, so even from that perspective it might not be a
good thing.

Thank you very much for this very detailed explanation of the workflow!
Michael

P.S. I am sorry - the first reply only went directly to Junio and not the
mailing list
