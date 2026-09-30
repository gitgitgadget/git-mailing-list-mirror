Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8114E01FA
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774383; cv=none; b=OGLS+tqkrRHWpmnNN/GopbG1H9GVZMwIdK2PUjdJf3VmJAaUt9c0ClcAkjyFGKQM/jESKhNrdsc+CsPbCvML8bEp2CoYMW8EzPVK67V2vIPOHbqbHASuG71yuRBfdKybACeNhEUUVQG6pBbwxGrlERLhCeDipyTEJ48TcnV0ltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774383; c=relaxed/simple;
	bh=kan8+/iaNHQgjfScgBHWHoDCyJJlh0ksZd9qfpn52Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqyTo1GZ4EtuiMkEqNJmvcpeDUyjqTE0c3SyM7ps3FvciBMqqZWM/xhC/WowtXttjbIJnpdAdbfChbIZ06XW4CqIGgc8gYDJrv2BZ/c2uROsGnmnfzu0G4dvkrkR8k28mIQZckhxoUHblFZu8TioPk91NDXl1cFf956H4aG6Kso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZSIpkEoZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rrYcEezD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZSIpkEoZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rrYcEezD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 62C97140020E;
	Wed, 30 Sep 2026 09:19:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 30 Sep 2026 09:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790774367; x=1790860767; bh=6dm8PPC0/C
	FZEJZQzOd483EWP3/VnRKFWDRDoaWiwDw=; b=ZSIpkEoZvRrGiUX96upJHJ6DTZ
	jPj2Ot0T5vGA1AtdAKdmtOp/N3D4syx2YB4l7O066N2bFKEjyQiae2UV9RYCsx7T
	l8HFBcBYT7gP1WgYoTKMfc9GZkVmgWC5LEXOMNvnI5CxMTjkpqz76ksv6xiRQDKG
	JFwYJUZjRkGVuwKbCNnh2b4asZ1ip1owMN6kw+Ncs+6vYwRzR4i4L7inMZn0movz
	vZA8Jaj1/lLUnqpPlChbKX515Y+SVSTLIaUWxTbTHCoXuAlWx7+9/YQhgboLesKu
	DPOp5V23KHUMa3v7EXPpxM8ca6ds7uLAD1WXcVjxvPcKo0O2e0K2N8gulPow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790774367; x=1790860767; bh=6dm8PPC0/CFZEJZQzOd483EWP3/VnRKFWDR
	DoaWiwDw=; b=rrYcEezDzgs97d7TaonfgYW4srIBPPW8/ELOQozTAXNtgHF8Nkp
	Wg/GdQgdClNKZ1qO1CEWVP8i2CQeVUJQpBiSJRgEww1MR7AqNEskF45bRRfuE5Oq
	4UY840fG/xVsIhH+Gezr7XGiXwcvyaqek7rLdral6NvR7I4Sa2tPXl+eSwM0Oa3o
	3eh1rrf5HniMSIaKVstjA419HJ9PxTuHcO0GtFE/HRMtXSvq6Yhe/Z6mP8zkGCPl
	U5+ydDk4vDe+KjQ5XklhFF5OECYu/dy/vVIYVdHYSjJOC4dfIQIJ/CxJhQ2TIbDl
	c+b3ho5qoGvtOR5un5sqPIuBfXGY5aM3A4g==
X-ME-Sender: <xms:Xwy9agVZcynuHqmmkt9mq02Qeg8C4tFXZ-ZVu_tNkvBrP7o_nui_4A>
    <xme:Xwy9asBchWAo9uJapqqb0ZGfaw-QuLpX2dW0dyDhDvFgZzBeGWdMtUHM-EGF9faSC
    HXaKAHWN0XYpvIU-niN17sI_0EWb1wVTVMuapMRCL3X4b6LIEG6QVY>
X-ME-Received: <xmr:Xwy9ahwGmx_ZXhzUnJH9gBRGDGnVjqaO48qg7cj9kOgqtC-A0ADOtQ>
X-ME-Proxy-Cause: dmFkZTGRxoNI5OfYmt6BV/YJPt3V5oLRCrmyYHFkdowNsPwOCRukWmwR61Vi2ze3cWZkFE
    K6HLy4XOWPl8eGYuHxvLdyxzfKfMN8CTFDHljg3raeOj5uRalslhmXdm8ilbKF0kJaVuRH
    1drPBBEp7MkrzusLSUJhlRCJiYXzcqmIE1ssfl4jrBlvbAJMvtvXR54D6v+ACHPH9CuRsJ
    CcFYJ8ONL6+g7bpH2qxUnm7+Sw2k9xFTr9wBdozKRtO9EQQwfV4ddVhb43WTEQHMk979kD
    sVgYoZNUXN0bshF/QJ7PpF3rXZ5FAvpJfEJv47n41z4eJmwX0FJciUDrxCLPjwwdShp7VU
    dFs8g16tfm7EODuqWkhT18dcCzof4fWnyDWzGEKQ17wIs6//Ovn1fkCv5z9KJFrgZFoCSl
    ZOU4Zb1MvEnhSOLFHrI0aOKf/pFM5pfdkjPrkkXXH1YHxtk+cV1+/984XDeDrZlAlu2Ol3
    dMrGQHZHj1NQetzzjngJI3QtgcUijxFKcx9yCX6Xkk2oQmiPUP8Xw3tCK4dT7rnHRx4byS
    YWWz4xW+KzahxIypNvmZ7sb7yHq5wlhtpP+DdSlIMKbUV54fUuCJ/K7lZLLxHrDcCo9SO2
    lyBAghr/+Ptk0Fn3292nULPvNaj5wA+9yzu/81Sv4GclkCBX9Y2VneaiM9jw
X-ME-Proxy: <xmx:Xwy9apBFGY810ktGeOomyDOhWgtk301f7RDnO7EE7Kb9XVD1sKrfZw>
    <xmx:Xwy9auZ5Yw3VD0iLk8XOaf0EQ2J7dCsy2DtobAHGAw4h0XrntjV8cA>
    <xmx:Xwy9ahgMefFWjgdLypvKLricwz3av5iA-Jit2jwIk55vev3DlNc76A>
    <xmx:Xwy9ag7AWvVRoM_FbsbLhcN_iUAIOzW2-0DR59p3009oAauOn373LA>
    <xmx:Xwy9agB3fjceRAG8r1xedhb2xHllsfnSCiFM9pE-pH27Iy6ILE1DV3KQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:19:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d43eadb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 13:19:24 +0000 (UTC)
Date: Wed, 30 Sep 2026 15:19:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/7] [doc] Add new gitmergeconflicts man page
Message-ID: <ar0MVRV5X8zgZfLy@pks.im>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <ad4853dc36cdb883c9a8dc6bda747a5ea318e7a8.1790261062.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4853dc36cdb883c9a8dc6bda747a5ea318e7a8.1790261062.git.gitgitgadget@gmail.com>

On Thu, Sep 24, 2026 at 02:44:16PM +0000, Julia Evans via GitGitGadget wrote:
> diff --git a/Documentation/gitmergeconflicts.adoc b/Documentation/gitmergeconflicts.adoc
> new file mode 100644
> index 0000000000..612b683e40
> --- /dev/null
> +++ b/Documentation/gitmergeconflicts.adoc
> @@ -0,0 +1,294 @@
> +gitmergeconflicts(7)
> +====================
> +
> +NAME
> +----
> +gitmergeconflicts - Guide to handling merge conflicts
> +
> +
> +SYNOPSIS
> +--------
> +Guide to handling merge conflicts
> +
> +
> +DESCRIPTION
> +-----------
> +
> +Merge conflicts can happen during a `git merge`, `git rebase`, `git
> +cherry-pick`, `git pull`, or `git revert`. All of those commands use

Should all of these be using linkgit:, like for example in
linkgit:git-merge[1]?

> +the same merge algorithm, and the process for resolving a merge conflict
> +is always very similar.

There's also git-am(1), but only when adding the "--3way" flag. So maybe
it's best to ignore that command indeed.

> +The most common ways to handle a merge conflict are:
> +
> +* Resolve the conflict. (see <<resolve,HOW TO RESOLVE A MERGE CONFLICT>>
> +  below for details)
> +* Or stop the operation and return your branch to its original state
> +  with the appropriate `--abort` command, for example `git merge --abort`
> +  or `git rebase --abort`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>> below
> +  for how to find the command to run.

I wonder whether the explanation should be expanded a bit to briefly
explain how Git performs a 3-way merge in the first place. I feel like
it's quite important to understand what the three different sides of the
merge are to make sense of it.

But I may be too far detached from the "normal" user, so this may only
cause more confusion for our users.

> +[[markers]]
> +MERGE CONFLICT MARKERS
> +----------------------
> +
> +Merge conflicts happen when both of the sides being merged edit the same
> +area of a file. When this happens, Git will update the conflicted file

I wonder whether we want to use "hunk" instead of "area". It's jargon
again, but I have never heard anybody speak about an "area" before
myself.

> +to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
> +For example, here's a merge conflict where both sides edited a list of
> +fruits in different ways:
> +
> +----
> +FRUITS = [
> +    "apple",
> +<<<<<<< HEAD
> +    "cherry",
> +=======
> +    "banana",
> +>>>>>>> add-fruit

A bit of a tangent, but sometimes I wonder whether we should make the
respective commits a bit easier to access. For example, we could put the
equivalent of `git rev-parse --reference <commit>` here for each of the
sides.

> +    "mango",
> +    "orange",
> +]
> +----
> +
> +The code from one side of the merge conflict is between `<<<<<<<` and
> +`=======`, and the code for the other side is between `=======` and
> +`>>>>>>>`. See <<ours,"OURS" AND "THEIRS">> below for a full explanation
> +of which side is which.
> +
> +
> +[[resolve]]
> +HOW TO RESOLVE A MERGE CONFLICT
> +-------------------------------
> +
> +The process for resolving a merge conflict is:
> +
> +1. Run `git status` to get a list of files with merge conflicts
> +2. For each one, find the conflict markers
> +   (the `<<<<<<<`, `=======`, `>>>>>>>`) and edit the code to
> +   fix the conflict
> +3. Run `git add FILENAME` for each file to mark the conflict as resolved
> +4. Run the appropriate `--continue` command to continue the operation
> +   that was interrupted by the conflict, for example `git merge --continue`
> +   or `git rebase --continue`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>>
> +   below for how to find the command to run.
> ++
> +Note: During a `git merge`, `git commit` and `git merge --continue` do
> +the the same thing.

s/the the/the/

Maybe we should also say "During a conflicted `git merge`.", but maybe
that's redundant.

> +[[example]]
> +EXAMPLE OF RESOLVING A MERGE CONFLICT
> +-------------------------------------
> +
> +If you see this in your code during a merge conflict:
> +
> +----
> +FRUITS = [
> +    "apple",
> +<<<<<<< HEAD
> +    "cherry",
> +    "mango",
> +=======
> +    "banana",
> +    "mango",
> +>>>>>>> add-fruit
> +    "orange",
> +]
> +----
> +
> +Then you might edit that part of the code like this,
> +which includes the fruits from both sides of the conflict:

I tend to forget that by default, we only render ours/theirs in the
conflict. I always feel like that makes it way harder to resolve
conflicts as you don't have the context of what the code looked like
originally. So I have diff3 configured locally for ages.

> +----
> +FRUITS = [
> +    "apple",
> +    "banana",
> +    "cherry",
> +    "mango",
> +    "orange",
> +]
> +----
> +
> +
> +[[tools]]
> +TOOLS FOR HANDLING MERGE CONFLICTS
> +----------------------------------
> +
> +Here are some ways to get extra context while handling a merge conflict:
> +
> +* There are many graphical "merge tools" for Git, which will normally
> +  show you the different versions of the code side by side.
> +  If you have a mergetool configured, `git mergetool` will launch it.
> +  See also `merge.tool` in linkgit:git-config[1] for a list of
> +  the mergetools Git supports.

There's also `git merge-tool --tool-help` to list all available drivers.

[snip]
> +[[diff3]]
> +DIFF3 AND ZDIFF3
> +----------------
> +
> +By default, Git doesn't include the original code when formatting
> +a merge conflict. To include the original code, you can set the
> +configuration option `merge.conflictstyle` to `diff3` or `zdiff3`.
> +This extra context can make it much easier to understand what's
> +happening in a merge conflict.

Indeed.

[snip]
> +[[ours]]
> +"OURS" AND "THEIRS"
> +-------------------
> +
> +Git refers to the first part of a merge conflict (between `<<<<<<<`
> +and `=======`) as "ours" and the second part (between `=======` and
> +`>>>>>>>`) as "theirs".
> +
> +Normally, "ours" is the commit that was checked out before you started
> +the merge, and "theirs" is the other commit.
> +
> +But when the merge conflict was caused by a `git rebase`, it's the
> +opposite: "theirs" is the commit that was checked out before you started
> +the merge. This is because under the hood, `git rebase main` checks out
> +the `main` commit first before doing the merge operation.

Hmm. This part is a bit confusing to me. "ours" is always the commit
that's currently checked out, and "theirs" is always the one that is
getting merged into the checked-out commit.

How about a variant of the following instead?

  In a conflict, the side between `<<<<<<<` and `=======` is "ours"
  and the side between `=======` and `>>>>>>>` is "theirs". "Ours" is
  always the side that `HEAD` points to while the merge happens; "theirs"
  is the commit being merged into it.

  For `git merge <other>`, `HEAD` is your current branch, so "ours" is
  your branch and "theirs" is `<other>`.

  For `git rebase <upstream>`, `HEAD` is first moved to `<upstream>` and
  your commits are then replayed on top one at a time. So "ours" is the
  already-rebased history starting at `<upstream>`, and "theirs" is the
  commit from your original branch that is currently being replayed.

> +These terms in Git all mean the same thing when dealing with a merge
> +conflict:
> +
> +* "common ancestor", "base", and "stage 1"
> +* "ours", "us", "stage 2", and `HEAD`
> +* "theirs", "them", and "stage 3"

I wouldn't say that "stage N" is equivalent to the respective other
terms. These stages rather refer to the different versions of a specific
file as recorded in the index, they do not indicate a specific commit.
In contrast to that, all the other terms may also indicate a specific
version of a file, but may also refer to the commits.

Patrick
