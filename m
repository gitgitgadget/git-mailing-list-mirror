Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41172378818
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 05:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783401008; cv=none; b=GiLqoy4Xs16QOm/WM13j6oYFxd3hXTssFEpZnjKEdePd1N2MGDoy5xTYG1JLBDL5hn/Da0BwZW3ed/Z1TbeH7nJH3BNBbyfR1NXK3ZAwB7LhD8S86FXWdhs8dMctlB2HXs9gC7sWOCm5bbgS1Gz79MY/nB7cB6450ao66t8QEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783401008; c=relaxed/simple;
	bh=xk9TVh19tJ8j7j5PVJs5ZrUhZdkKcH1pXZZl7yKR4HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhBtAGy13pMXTpFcqf9+HZnFmtll6eTYQnyQ+BYBJQcT8r1P/ZUnK5eATKAVBhg745dS/ZY+JO34jhKHEbQmwLPTCnQn2sh97RcxnyCBEcVYbaz8yYrYcY8aSy0w3OqFK7WJrKtQXJstFDT4/3ZQjfE7zb8VJhnwrl0heXjhe4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=pd/DeMtc; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="pd/DeMtc"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6EA3814C2D6;
	Tue,  7 Jul 2026 07:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1783400993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nV/PIaD9cd3YCSjAVH6QdCWp7nPm7moMLoJaw1OFSvs=;
	b=pd/DeMtc1UmzNIO3rXaNkesuTMSZUgl7fJfyAg6hEEK9zJl+TPrKRxUb2FgsJFVH64vyCA
	gKfwnGELuc20FTM1wFhBSe2Yvz3+TFQGD5wq6/VkzpBxeE6GY9LzD5lvjXCI21KvDzlPP+
	L1OC8eMOovwW/CnkBYEpBWrC9cLA5gMn4dvDr/VmwZUlgrzLLgKA1P2OVRXiu4/nqn+xjW
	fzt/iWc6FZ5MNY4weBsj9fwsZiRosuDdUGn/9VIECognPq/ThtP3VYZHefvHcxjL3lk0ld
	wA4L4MxmzsfavZ2AGt8VoJoZhygy7nSF/GUekTrOTUN1ix9pBAAHVniqg1FQ2A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1d0e413b;
	Tue, 7 Jul 2026 05:09:49 +0000 (UTC)
Date: Tue, 7 Jul 2026 14:09:34 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH RFC 2/2] builtin/history: print feedback after successful
 reword
Message-ID: <akyKDtuHTHZGEpFx@codewreck.org>
References: <CAN5EUNQNj86Q+hi6PouOZNWo1T4QTQ6sE5Hs9USZXWpkTedTcw@mail.gmail.com>
 <9C91B027-C24A-4D7B-A3BC-5CF3B04D990C@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9C91B027-C24A-4D7B-A3BC-5CF3B04D990C@gmail.com>

[context: I just played with git history reword/fixup and dug through
archives for anything like this, so chiming in.
First, thanks for the new git history commands, they all look promising!]

Ben Knoble wrote on Mon, Jun 08, 2026 at 12:47:41PM -0400:
>>> Do other commands in "git history" (split is in 'master', drop and
>>> fixup are cooking) behave with similar verbosity?  Consistency within
>>> the same "history" umbrella matters more than being similar with
>>> other commands that can be used for similar purposes.

I agree with the sentiment of needing consistency, but rather than say
"the other commands are not verbose" (as they are) I'd say they're new
enough we can afford to "make them all verbose" instead.

In particular, for git history reword there is an editor opening up, so
I didn't have much trouble assuming silence was success, but I was
disturbed by `git history fixup` which just returns immediately (much
faster than rebase) with no feedback at all.

>> They do not, they are thought with the rule of silence in mind.
>> However I think that this output is valuable information I might have
>> explained myself better at [1] but my thought is:
>> 
>> git history reword aabb
>> 
>> Now that I have my commit aabb rewritten I want to check it again just
>> to make sure I did what I wanted correctly,
>
> Some thoughts:
> 
> - If the rewritten commit is an ancestor of HEAD, look at the log of HEAD@{1} or the log between HEAD and the aforementioned reflog entry. (git-range-diff may also be helpful there.)
> - Similarly, if the rewritten commit is reachable from some ref R, check R@{1} etc. 

During my quick tests I was surprised with how git history reword/fixup
behave with commits that aren't ancestors of HEAD/any branch (that can
happen for example if you print `git log --oneline` once and refer to it
after editing.

This transcript is a bit ugly but should illustrate the issue:
```
$ git init
Initialized empty Git repository in ...test/.git/
$ echo a > aa
$ git add aa
$ git commit -m init
[master (root-commit) 62884dc4d43c] init
 1 file changed, 1 insertion(+)
 create mode 100644 aa
$ echo b > b
$ git add b
$ git commit -m b
[master 058294f87a36] b
 1 file changed, 1 insertion(+)
 create mode 100644 b
$ echo c > c
$ git add c
$ git commit -m c
[master 0c4ad0c9337c] c
 1 file changed, 1 insertion(+)
 create mode 100644 c
$ git log --oneline --graph
* 0c4ad0c9337c (HEAD -> master) c
* 058294f87a36 b
* 62884dc4d43c init
$ echo d > d
$ git add d
$ git history fixup HEAD^
$ echo e > e
$ git add e
$ git history fixup 058294f87a36
$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	new file:   e
$ git history reword 058294f87a36
(editor showed up, commit message modified and saved)
$ git log --oneline --graph
* 5cc5551381a3 (HEAD -> master) c
* 0b7ab36bf167 b
* 62884dc4d43c init
```
-> fixup didn't show any message (and exited with 0), but didn't unstage
the hunk either and didn't do anything, so one cannot differentiate with
the fixup actually happening
-> reword showed up editor but didn't actually do anything visible
(probably did create a new commit somewhere that's unreachable?)

So I agree with Pablo's suggestion: printing old/new short hash on
success would help visualy confirming something worked.

... But it might be worth to ensure that the commit has any ref we can
handle (if --update-refs is set then the commit we edit is ancestor to
some branch, if not set then it must be an ancestor of HEAD)

What do you think?
-- 
Dominique Martinet | Asmadeus
