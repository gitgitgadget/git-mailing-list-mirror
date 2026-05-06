Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3353DB646
	for <git@vger.kernel.org>; Wed,  6 May 2026 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778066882; cv=none; b=rggpz24yLgex8xtCC990PpGY02T411yUIkAayrp+y1kc0ShGp8/m3oZkYgrdmCBDnXVoJrsOr2bY2xiRv2vVEIU8yYma5T39vZJE3ZqehrtF5zd/1/+sXyy47e3zl9NUad2GePOYbjvZ4tPNZ0/QT+FCi2139IhKjRAKVu5e1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778066882; c=relaxed/simple;
	bh=30mJxBc10U3RxcKtJ5VLtUVcjLTMPVMv53gZ3ZqC9U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NF/Wn/5KixQVh/b9iRboGhSLd5p2uTZb1XcZWD0MqRGN2/z9pmEV0Cs98GQdcDHjebYRvrzvUyrbfnPZycL9dpDRkMabnQulrIkOcwrPi6IrNtFfjApu9LAKaPAJzsjtJ45VZqKgokwp6w7slYB4nJ+YlZ/TvfFe188+IPEW9U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGwZmkVw; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGwZmkVw"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d4f78fc9f6so680126585a.3
        for <git@vger.kernel.org>; Wed, 06 May 2026 04:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778066880; x=1778671680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=30mJxBc10U3RxcKtJ5VLtUVcjLTMPVMv53gZ3ZqC9U0=;
        b=dGwZmkVwno/01z2ov5joF0MUamShkVkA9SrzheHKlIG9rvQclanPgrfX2TxyGSoStB
         2XEPLoEtCiI/6+/a0Y/V6a8EGbhpjRvauGvH5VMyWjTVhOBj6t8TQhyfWt2weQrMstjh
         pMxoXJJJzdUXWIUPmGxXMIyWAppFyrED+wioT7JvxF5BYn9JfBRsP6WdwJ7wED0wcbWw
         VFrHuVVucniOmyvtIIwyKk+Z6tlIazHBsR5dfL3GdYZf1c9env245qyq4nWzx6LwOGXy
         fbZ0fez/OlGtTTCxl5XfkHR6GOiY5on8t+SVT724cV/d+7KXeKNwfcUxTmFRkpREIaoW
         YeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778066880; x=1778671680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30mJxBc10U3RxcKtJ5VLtUVcjLTMPVMv53gZ3ZqC9U0=;
        b=sccW2KDWFRTXXA98ZZneReYLKF75bTLYMn90B5zRSHkeaK1IqQ3dW1msHr9e1woPFo
         yWZZ5J6Ygn2aANzjPAM3cqd+qSySH+BVc9izTHXKD+meAmrJwtlyVPDfj5yHFw6dp8xW
         atnRSsCQvIGKKswMrSNZmr2Tqb+nU5W0sdQlKhAYp0tDeYeQ1HNPGKu+ffiREwHoAJ7V
         vov7fZd+lWyA58STQ9Ef6rv9EVzvHevATb+uBJruUlSjHyFOKb88d0ft38dR3eQh0AXY
         w5q914MBpqLFTVXwbRfj1I93Qhh2ID2nUlT8m9uSasBkn4QHVLXJq+61TCMGxywQ5zxH
         2gbA==
X-Gm-Message-State: AOJu0YxCcr/4WWI7vI6AMvHYuGnzg+R6gVvAYXOAs3UBWek2cmTbSpPz
	NtnfQLpw1QIZpZYS49miTGTj6KaVRrXxymM1fn/8gZRPoqnH/G46iThs
X-Gm-Gg: AeBDietqS0NcL22Nrf3MHt5AXJYDTK8LFAaNGbELt/lQVLIXSu/cOO651PnduKxog2J
	EgqbXy48tJdmPH+KqMViWU6+wa0Dfw6Fko7ADFnE+gi6+PSSL/rG8KZbCsCt71RudrUUcfLkuG4
	9SNv2YEDtdawQuUf0Yjn4SCPZtuqwIoSu55El0TjToEwR+s6wKbVmA7+WjJHA/EGIzvO0G+MOI8
	zUL+FNp1T60Gb2dpAukgcxgWwFhiCc48zgrVddSq84OQ5jIZjbLOssLuV1sMQ6KYILOF+AChmoW
	v47w4QFY65eGozRD9+Llx2AgeGa/K02awQYIcTw7pRXxmJlIqJPuHLtfAhzIcNg9GLA6j+g9d96
	l0KLeajoabdCyY+ujVWn7dl2XHPTGUJIwsuXYeltPF5iX7RbOu17WFt6H/97xR/7Hl2A0j16+g+
	sL1Lh47+b2nYngXOYN3xwjNwl07T3/aDy8O6+RYnuDGt63
X-Received: by 2002:a05:620a:7017:b0:8f8:cdd0:df80 with SMTP id af79cd13be357-904d70c2e1amr397136285a.59.1778066880205;
        Wed, 06 May 2026 04:28:00 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100::59a? ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2938d20fsm1649657085a.1.2026.05.06.04.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 04:27:59 -0700 (PDT)
Message-ID: <f6c7c3d5-1d68-45b5-87a7-ae19b59270f4@gmail.com>
Date: Wed, 6 May 2026 07:27:59 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] git-gui: handle missing worktree and separated
 gitdir
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Shroom Moo <egg_mushroomcow@foxmail.com>
References: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
 <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
 <3b0b37ed-1a5d-4fe1-b2b4-7db67a62a06d@gmail.com>
 <77219c75-7968-413f-a642-0446145c8023@kdbg.org>
 <a1a7237c-ffed-4a7a-ae58-55769aaa4453@gmail.com>
 <93e1c61f-e58b-4a0c-8ece-7a8d945fa900@gmail.com>
 <73b99b54-1d39-45c1-bd06-26ac1008fddb@kdbg.org>
 <7d5cf952-badb-4071-a0eb-af9443fa8b5b@gmail.com>
 <ac115a8f-5dbc-4988-b8a5-c1647af1bb74@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <ac115a8f-5dbc-4988-b8a5-c1647af1bb74@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/6/26 3:32 AM, Johannes Sixt wrote:
>> Whether being in a gitdir is ok, or a worktree required, is of fundamental importance and
>> is not explicitly checked now. This is my issue. (Whether the repo is bare, or embedded in
>> a worktree, is relevant only when automatically fixing a user error.)
> I don't quite follow what you a trying to say here.
I played a bit more:

A git repository (gitdir) can have config.bare true | false | not set
git rev-parse --is-bare-repository tells you that whatever gitdir is discovered from the
current directory has core.bare==true. This happens whether the call is from inside the
gitdir, or in the parent dir of a gitdir named '.git', or in a directory containing a
symlink or a gitfile link to the gitdir. This call never tells you what directory you are
actually in.

git rev-parse --is-inside-work-tree gives:
    true - the call is made from a directory that is suported/supportable as a worktree of
a gitdir.
    false - the call is made from inside a gitdir, or from a directory linked to a to a
gitdir with core.bare == true.
    and error is thrown if no gitdir is discovered.

I find --is-inside-work-tree a much better call to make early in setup. 
    true - full git-gui is ok, 
    false - blame/browser is ok (gitdir might have core.bare true)
    error - no gitdir found, the repository picker should be called.

So, the only need to test if the repo is marked bare is when looking for a possible
worktree when git-gui was started inside the gitdir, or started in a directory linked to
said gitdir, or GIT_DIR in the environment points to said gitdir: I consider all of this a
user (or configuration) error, and there are many possible causes to explore to give
useful feedback to the user.

But, there are many ways to code this. I started down a path of using
--is-inside-worktree, but in the end there are still a lot of corner cases to find.

>>> But perhaps there is a simpler solution: Let's present an error if
>>> --show-toplevel fails except in the case where the startup directory is
>>> named '.git' (and is a valid Git repository) and is not bare (then the
>>> worktree is the parent). I insist in this exception, because this
>>> use-case was considered important in the past (87cd09f43e56 "git-gui:
>>> work from the .git dir", 2010-01-23).
>>>
>>> -- Hannes
>>>
>> This would not fix gitk's blame / browse from a gitdir, and I don't really see a one or
>> two line fix as being adequate.

As you mentioned elsewhere, the problem on browser/blame is that _gitworktree is empty
when no worktree is found, so GIT_WORK_TREE is exported to the environment as an empty
variable. This cause is in a commit from 12 years ago:

    3decb8e0ac ("git-gui: tolerate major version changes when comparing the git version",
2014-05-17)

Prior to that commit and if not using git v1.7.x, an alternate branch of code not using
git rev-parse was used for worktree discovery, and that code set _gitworktree = _gitdir
when in a gitdir. The alternate code was removed more recently as it was unreachable from
non-ancient git versions.

The fix is to set _gitworktree to _gitdir before exporting GIT_WORK_TREE, or to just not
export an empty GIT_WORK_TREE. Obviously, having GIT_WORK_TREE = GIT_DIR is asking for
trouble, but perhaps is ok as git-gui is running in a read-only mode for browse/blame. My
limited testing shows this works.


Mark

