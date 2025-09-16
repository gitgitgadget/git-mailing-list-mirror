Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C10932D5B6
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045587; cv=none; b=RXI2h2LJa2gA5xfp88qYBA0e6DUJGsAAXvsiHcRxTU4anfSNslkL4vItPlflU+kUGMa/jl06GQbzkShkAheZvsaWGQzu0oaehhwQxzv9sQBD43+HlpQpA6de2cI+nPgywa29/Mc28ipF3AYkfiKc/PXYcxKK2DJy5+/PHDntahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045587; c=relaxed/simple;
	bh=zcwC4Pnt44KjBi4fE5U8dF/02NlatJk2KRh5MzZcntg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHmexn2FIaX9ReRiBjB0NW4gYTZ9i+86FQD86L4QmBa6ZsscDwCzr0xv4vsPNEP/8pLBuFjZ46T1HoiMfyrnMYl3L3UCGcAArniqbZlwqqHg3QBPGpEli59ZFFCThgYb+1WfRtBJEnJyb1qEf1Eco1iGkEGLAQ7T347N1/DdDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=NPWeQWtE; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="NPWeQWtE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1758045580; bh=zcwC4Pnt44KjBi4fE5U8dF/02NlatJk2KRh5MzZcntg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPWeQWtEkcKnkQSTCFw1FdRdlbCcgck/iBqLHngdw4caWgjaRQfyC/akpnbIgLZMR
	 fyxBRcmrlio/1YuAlyVTf6DmU3iyJx8FuA/otu24MyxjUxn9QwVL72jY3dKhTKin27
	 Lydw03ADEsP7o9rVBnh7LWbVFat4+4PfKsZodZxE=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.53.4)
	(envelope-from <phahn-oss@avm.de>)
	id 68c9a58c-5361-7f0000032729-7f0000019d06-1
	for <multiple-recipients>; Tue, 16 Sep 2025 19:59:40 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 16 Sep 2025 19:59:40 +0200 (CEST)
From: Philipp Hahn <phahn-oss@avm.de>
To: ben.knoble@gmail.com
Cc: bolide2005@163.com,
	git@vger.kernel.org,
	newren@gmail.com
Subject: Re: --shallow-exclude=ref -> "ambiguous deepen-not" error
Date: Tue, 16 Sep 2025 19:57:39 +0200
Message-ID: <20250916175740.1044452-1-phahn-oss@avm.de>
In-Reply-To: <CALnO6CAbUNgp6n4kYg1ATCC1mHa7Z2m3d7FZwaYrgtkMLWR3-w@mail.gmail.com>
References: <CALnO6CAbUNgp6n4kYg1ATCC1mHa7Z2m3d7FZwaYrgtkMLWR3-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1758045580-9C6C3ED6-70B0CCC5/0/0
X-purgate-type: clean
X-purgate-size: 1778
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

Hello Ben,

Thank you for your reply.

On Tue, 16 Sep 2025 at 13:03:41 -0400 D. Ben Knoble <ben.knoble@gmail.com> wrote:
> On Tue, Sep 16, 2025 at 10:58 AM Philipp Hahn <phahn-oss@avm.de> wrote:
> >                      A---B---C topic
> >                     /
> >                D---E---F---G master

> I might have misunderstood, but aren't the commits you're interested
> in here the ones named by
> 
>     git rev-list master..topic
> 
> ?

Yes, which is I have described using `CI_MERGE_REQUEST_TARGET_BRANCH_NAME :=
master`.

But as also described this fails for those "merged regsult pipelines", where GitLab creates a temporary merge "X" and then runs its pipeline on "X":

>                      A---B---C topic
>                     /         \
>                     /        __X temp
>                     /       /
>                D---E---F---G master

Here `master..temp` becomes just "X", but not "A-B-C".

I have played with this some more and found another blocker: When using
`--shallow-exclude=E` "A" becomes the new _root_-commit, which is then a
_crafted_-commit containing *all* files up until "A".
What I would need here is to make "E" the _crafted_-commit, so that "A-B-C"
remain exactly the same to the not-shallow-clone.


> I see a mention of git-clone in the quoted reply, so perhaps you're
> trying to avoid cloning too much history.

Yes

> I wonder if a blobless clone would suffice, which you can then add to once
> you have the list of commits produced above? That would fetch more commits
> than necessary, but should still be significantly cheaper.

That also would be an option – I have not yet tried it out here, but
`--filter=tree:0` already worked wonders in one other case.

Philipp
