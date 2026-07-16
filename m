Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F4934751B
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 22:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784239741; cv=pass; b=txIa2RQdaYeb8oJJlmkp5lunmoosWrfMCnP23fNqNxLKMUYZyzPupHaAnWpeS85nvNeYEzJ95a8qygTx6ZLrOKiDxN6l9ChsDAtqpcWf2eG4h3W2AM3QUP1OwZE5taMwbS5uy5eRNlok13sENNmyLpkdl4Kh9dbj79E9MYKphEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784239741; c=relaxed/simple;
	bh=g2eZ0wJuzOQLL3MRhmg30Fo+oTGxWbGtiS7QUDVgReA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaSaY/IXYzBG5Yc4QVRDGeEd5SNwDt6ESpIRAQo1bjyBibXKtDoROc3tpepXYk66DDEALbthKDGuYxgQoKI4yb+ChZVU3yTFOCaaurX5W+RUsnAKTgd/ANRmxffFX3QlyryyYxhhH4NLFlXfzcTpEmz7Qc1W8rhVZk3P+id4PTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efBhB88G; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efBhB88G"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so5229172a12.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 15:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784239739; cv=none;
        d=google.com; s=arc-20260327;
        b=YeYPEXaYe7DbbtXREosL3p4n7UR743EeC5h0rlgsRdZ2W2h1Q9LI5/qygPe388pnCL
         OCixIrgXrUbC8y5iwuTGViDqDPW2IZVRx3Qj4YMAKB01fFwR+/xVu6GNbCFYCt9z3wrK
         XeAguuukNn0or6AddVhjaU3pOG0gGoz9gPX4dspTxDqRJEUItojpOUSKesDBUdMQpKSO
         Tnf7DOPP+DROLP72Dpzf5LX5bIjLmEC2DkCVtVpOuMx9XEqNHV60f4NrUnG7xFK1T7/r
         pai3nh30Xnesg1/AnhDUVyWlx3UbknhoZNfr4qSQ0Q95sWiYGpjm3x2heDJFLwW5I4gj
         qG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wBCjL+yWuJDxacVYwt1FoHkb31v3yNJMBrxfQEtjX+E=;
        fh=mbYdZHTebbYaBBYQkZIVh8VihZ6hUyQ1gvkc0araN6w=;
        b=eZRY2f3BuLoIxruYVBgaUT40xU+306p6VZZ+NBg9S6CVkdINBuGJ67FQ9MdZsxO/qb
         WmAi0BcPfdyhr4hPxjurYiSytj0U2YYQa8FyrgAswLcND+AEP1uxpJdSqYpX1qOm3nmw
         bfmBKCIO3+M6X34JDqhbxa7AALg3jc178zTJUJSzHZmBaHu5dU/Opp2PMyM7nSiXgamW
         W73XUFtxrNbHUWnljj/RBQ/qJjr9XFNFfEVK+4iQ/0uuBePozHBeM9Kb4ONxixWqILCv
         mQt9Ms2DpdaFwuHmOAzlj4C2mSwRNghq99pH6Xi3w37IavDO57uT9EWRWI+/E4pBv3WL
         zZ8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784239739; x=1784844539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wBCjL+yWuJDxacVYwt1FoHkb31v3yNJMBrxfQEtjX+E=;
        b=efBhB88GeuXwv0FPyTWATvMjvkPqt8cpEs33bd0a2GJUc3edAkWy1vdDnfWGCUCt5B
         DpVVcrqbrOlknaqxxosCdeJWE2prIqbLPSxGctTdQKH3xU2sHY+3PHxSrvEcA55m5Q4o
         yhUPY3jVkdEKOB6h8W2D7X7I9yJX0JDqBiwBJHEE+m/t2hjkhnDUQTKHZa+zI2YqGsHM
         s0OOGGMKGk9GcmdFeoYKAPN5Tv7sVmeJaRlW9B5kGRaG3En9cqu9qfbNg9FtHKkvbSX2
         YGGTkua9t2iEghAgwnq2aGnky6FC2EBG0QDVk8g5GUTdtqrcjkI4u00PjhJriixKUWEI
         KypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784239739; x=1784844539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wBCjL+yWuJDxacVYwt1FoHkb31v3yNJMBrxfQEtjX+E=;
        b=IUQ8nfMuicwrmgKV/sGFjcINeb56SmO28zkkIr3BeGfXVBcook8UTW7JlboR7Ryvip
         DFYL1wt0WTeP8agd4jxi67ioiy3A8IJdfCbDTUTJRxAEfzxprznDruK8CB3BFR92HjJI
         xNupY6r1YnICCZY37AiT3O33RXijUy5wvwh0aOXHtGaNp9S5S3YrTnOtQiYAn53ZP+kj
         zEnLXBuTEitEgyum2AzOzTwoIKGv1auToMwQae7EHJe+e1FvvFdfJ/IBY0ahn7iV795c
         fs8+L+LonGXn7cJd1I6a51gzW59mOKU93zqbgqeJtcdoBsOBeGDHa+CYfw7xLyhiwCAb
         pI8Q==
X-Gm-Message-State: AOJu0YxYdsrr5pWOZ5t+q0dxYUbSdfH/b/lo/h1ShlYlfj1gJJA8kXg5
	6Jw2MtTFOx5nkUW4Z9YBxqSR9VPcoAmQP8nSfRJRdKnpbWZxOqUrRALgx7+2iUE9rC+y70OUYto
	Ar/HOAsnMkR2w+16CjOXjcNPlblql7J+924I1
X-Gm-Gg: AfdE7cm6GGs8LRtVMLXCPtWQNjTTH+1ToeO40abL4HseolOdXF+/CmWpr9chaJZt1xz
	ydgRMfXn28fxDMcKWcApWm84YVEBkKiflQmxWU8Op+chAGMmNjwI6rYR0KWHefL9FCQU+h+t1+D
	v20HeluCaaMevirozYYXZfbM4vzFmVjfhkh62DD8FwlEXoQnqndVw7+484j7XC9T1/tn/ccm5c3
	3QJisG8Xa/6E9aAAOBQ/BWza+V89l60A2SEf1KKtOifHiR6wxKcBe/sp0tv5c/2VHyha55TueBQ
	I7Ci9yCWaXrH/9G0EsFVLqRdjxtIizcY4TrVWIVia70xjmCosbQqTdJFv8/HM3eQ02pNzkO7KUo
	fglHsCFR3mAW6CH6v/HdB4zgzq8qBIXukYx57HgfnkjEs
X-Received: by 2002:a05:6a21:489:b0:3bf:9c93:ac44 with SMTP id
 adf61e73a8af0-3c36c1923d0mr9931930637.19.1784239739119; Thu, 16 Jul 2026
 15:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BY5PR06MB6548F18EA532E3EF021AA93DBAC72@BY5PR06MB6548.namprd06.prod.outlook.com>
In-Reply-To: <BY5PR06MB6548F18EA532E3EF021AA93DBAC72@BY5PR06MB6548.namprd06.prod.outlook.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 16 Jul 2026 18:08:47 -0400
X-Gm-Features: AUfX_mw03V-DLm2McliPRnbBsGIzyoyFCY1Cd3ctY8Dnst3emGTsEXwouB4RHrQ
Message-ID: <CALnO6CDGkAzu4Xz2o=VaCfwsF1WEcBw2k3-JqmkGqj1+ZpRQyA@mail.gmail.com>
Subject: Re: Please provide help with how to fix
To: Randy Kroeger <kroegerr@cseasy.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 4:52=E2=80=AFPM Randy Kroeger <kroegerr@cseasy.com>=
 wrote:
>
>
> I am having a bit of an issue trying to figure out the best route in fixi=
ng the following.

The advice I give my colleagues:

1. Don't panic
2. Figure out where you are
3. Figure out where you want to go
4. Decide how to get there

> What happened is on my second machine, in which was out dated (source cod=
e), I upgraded to VS 2026 (from 2022), then tried to do  a pull.  What happ=
ened was that I received a bunch of modifications, which was confusing. All=
 I want is to pull all changes since I did last on this machine.  I then ha=
d a bit of a problem with the gitignore file, so I decided to just commit i=
t (my train of thought is it is a file being committed to source control - =
that is it).  However, what happened is this file took on a life and decide=
d to make itself the head and bypass all changes to the head in which it kn=
ew about last.  Please see image below where the history shows a line from =
this commit to the parent below.  This by passes a bunch of chances.

A suite of helpful "where am I" commands:

- git status: is the repo clean? before we go further, let's not lose work
- git log --graph [--oneline]: what's the shape of commits? (this
would be useful to copy/paste, optionally with annotations, in place
of your diagram below)
- git reflog HEAD: what operations brought me here, and what are some
interesting recent checkouts?

Then (repeating a line from a previous quote):

>  All I want is to pull all changes since I did last on this machine.

Once we know where you are, we can talk about where you want to go.
When you say "pull all changes," do you mean a "fetch" (update my
local repository's notions of where remote branches are) or a "pull"
(merge or rebase local branches with/on their upstreams)?

> Question: How can I fix this issue?  I would like to restore all my chang=
es again and remove this bypass.   I have been reviewing your documentation=
, but am very hesitant as my understanding, once again, may not match how G=
IT actually functions.

Only when you know where you are and where you want to go can you find
appropriate fixes ;)

> I greatly appreciate the help!
>
> In this example, Commit 3 was done on July 12 and since it was on a machi=
ne that had done its last pull on 6/09/2026, the commit created a new paren=
t below Commit 5.  Now when I pull, the changes for Commit4, Commit5 are no=
t included in the pull.    I am assuming I need to do a rebase, but am not =
100% confident and in reading the documentation, I am still not confident.
>
> --Commit6 7/14/2026
> --Commit5  7/13/2026
> |<-Commit4  7/12/2026  -child
> |  --Commit2  6/11/2026
> |  --Commit1  6/10/2026
> |>-Commit4   7/12/2026  -parent
>
> Randy

I'm not sure how to interpret this diagram; perhaps you could use "git
log --graph --oneline" to show your current and desired states?

--=20
D. Ben Knoble
