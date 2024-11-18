Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B6147C71
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731972065; cv=none; b=KcVmfw5MplWWnKCW0QDDc6l5RSv1C3oZys2g2A/1RjASVDZYE3lDDCB8EMWucYJSRZS1TNoKR2hMBPB0GTUUCaAD6oTJ1ZYxm3zZWREK0SxfMT0GaGA3Ozgi8NIknrXjzF26K5ws+ovg5vGoFy32isvG/4Alrg1DMl/0uLvzO/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731972065; c=relaxed/simple;
	bh=5doZ9YH+u3ZMn8kbQhwfvqTQcQwQ9Yq4RSUllW4/5QQ=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NOOAPeI8ZbFD4F+m6wfy1rP9qbbjkCwNZTd2bpyGlrKU+Gszvfon36TS+hULuq9/+rfoqkCdO7UJl4w6U83U2PTko4l8b5eOFOGyoSuCz0O3+LIdicelk31uMKw+PoaY2WUtYKzVftKvIQs4NAWx64EJuYj1wYYzp6JuiRwnb0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4AINKk2C154210
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 23:20:46 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'A bughunter'" <A_bughunter@proton.me>, <git@vger.kernel.org>
References: <4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlSI5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=@proton.me> <MBCJkxhVnx5AhlKkq15aTn5FYI6cG-wdqqwQ84mVH9zjf-YehSrRWPgd-UwdTMrYhS2Sgofbyn2bS7iMlANyyYf_Z6b6_e3FH0hRm5VYciU=@proton.me>
In-Reply-To: <MBCJkxhVnx5AhlKkq15aTn5FYI6cG-wdqqwQ84mVH9zjf-YehSrRWPgd-UwdTMrYhS2Sgofbyn2bS7iMlANyyYf_Z6b6_e3FH0hRm5VYciU=@proton.me>
Subject: RE: How do you undo an add
Date: Mon, 18 Nov 2024 18:20:41 -0500
Organization: Nexbridge Inc.
Message-ID: <022f01db3a10$7fe28140$7fa783c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIujZMfl62xzE/fsxvvZCpEhSyanwNPSAY4sfyKt8A=

On November 18, 2024 5:10 PM, A bughunter wrote:
>BROAD OVERVIEW
>
>bugreport[A], question[B] and use-case[C]. These are all related but =
separate
>threads for the purposes as labled. Please do not cross-post or =
cross-quote. Focus
>on productivity and solving these. You are welcomed to view and =
participate in all of
>these as I contribute more.
>
>use-case[C] - git question (short) rephrase with use-case added.
>
>ADD, ADD, ADD why cant they get that: ADD. ADD tracks files for commit. =
It's
>already been commit : push failed. Failed pushes piled up. I need them =
untracked.
>How do you undo an add ( many adds): simple question. Without deleting =
any files,
>to repush 1 by 1.

Once you have pushed an added file, your only option is filter-branch to =
prune out the
invalid content.

Prior to push, before commit, you can use reset HEAD.

Following a commit, you can use reset --HARD to move the branch head =
back to a
Commit where the add did not happen.

If I did not understand your situation, I apologize.

>I suspect the answer is: "you can't - git provides no means to do so" - =
a defect, bug
>as we call it. The answer to this use-case question likely will confirm =
my bugreport
>and I get the feeling this is why they will not answer the question =
they do not want
>to accept my bugreport and have a bad spirit to argue. The excuses they =
give for this
>will be that it is not typical: This can normally be solved by =
repushing. However it is
>still a defect and in my use-case there is a slow or intermittent =
connection and no
>sha-backups yet because this is the initial creation of a repo.
>
>The above question is a use-case[C] seeking how to undo without =
deleting files.
>There shouldn't be any need to know a use-case in order to answer a =
technical
>question. I am open to discuss my use-case on this thread. The use-case =
if of this
>repo github.com/freedom-foundation/kjbible
>
>My original bug report is that the user " may be cornered into delete =
files"
>bugreport[A] Summary as of 20241117 brian does not believe it's a bug =
and begins
>chattering to Peff about how to fix the bug "There are Git-level =
keepalives during the
>similar compression operation".
>
>The full question[B] which is a child of the bugreport[A] is here. =
Summary as of
>20241117 my question was mostly sidestepped and spammed whilst the =
thread
>devolved into a political drama about code_of_conduct. I am not open to =
discuss
>my use-case on this thread.


