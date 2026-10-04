Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04584190462
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791107656; cv=none; b=WJLB5Ir23MHVNhx/JhJt0aqNHKpZtg4/Om8wdc51ryxSS9NDVM+w7HccPLVJ8u3I0aKQI7Gcx4npp/ylWttSi/r6gtNOOoJGSypZ4/FysGhJx93q2vthbD73w+eXRmte2oCXKyE0BMnra02R9bentz1Y+7QQ/ebW5MmVuM8aiw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791107656; c=relaxed/simple;
	bh=sX9oPSxImsg5hzn0iHQ//FI/jCVsHeTiEOv7zf1view=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abqVtqcrqjBtv5OdRNNSD/+2KU5FRiErSeXamLoE/lZeQIJBehy2ecfNvSHEU7/ixXzSLLWLDQLgtU93B062GY/Hvzvi0VZLK9NDUz2f2uJyUN4QycAMw3PuzkmpQFidojxhr8iJR8hLvyAs0pteLLNDyzosxN5ujvTlZ+Xq2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIHc5XNf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIHc5XNf"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso457678f8f.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791107653; x=1791712453; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=35lSXvRkw6bk+JrFGOq57MCb89WYCsXsbeylBvMX6zY=;
        b=WIHc5XNfzeQwPsUU/BtK3DsaIXS5CIWb8zr1ZtMgMFCjawsl2f15tJnIGItU/SF4hk
         4m457IgHTs9OSl6xOUnXttWUbJu21sDRi0JAb8GjkfpS/A54Y1Akpt7piK1I1zkex91f
         S5e4YfieImjTkLtkqteB5KzB+fdPZ+8vtVd7/rGQrsWE0NAYHmswUK41cdalVDFWNZ1Z
         U2K8LUQo6bCOvYYdcnOakR3vqc3VQuJdw3ovEzrNcA4uvkeW1kDwcG0Uya2sTiOA/h0V
         wc/1LRCnhrVJLonElT2+dsG1jJ7/ferUqwiDAi2lTbY96nKFwngyJ7I2jzlSZV7rzqEJ
         4M5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791107653; x=1791712453;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=35lSXvRkw6bk+JrFGOq57MCb89WYCsXsbeylBvMX6zY=;
        b=aS3+wbTUxROuicv3Q8hmdmKgYPaAHIBj8iJZJuy0wYXkf4poIudfuvyr2gIMBNQmqR
         rquQGti70cTikIKDYrB/RleeJB0njslNRIHvkqJ4osEDyL7SUnSETpCqpwqpyK8puudc
         eWjebnENoiyVFY/kYW1BSuMoFeuWu8DAKB1lXbfCgFPErBCV9I0Uj4Pk/+Dcuw/u2D6p
         pGg0LeGwxAkMJfsYYz29OtLGZEEs+rpu7mXgVE+/x+2cjg0MsSIC+D142oLBkHYvl5rN
         VtXIGb0kHF2NV0VVgYzqb8Ro2fYECGkAB4/gZNlCRJLZYSWzBX6HIzXCWapslgPOaz6I
         7J9Q==
X-Gm-Message-State: AFuF++ksoESKN0sL8IGEDlDTkhX916m6o5lu8gfnT1gDCOiP0dwFMtQm
	ttiQhVuo9ixE9LM7EI9AqTeYg0NeOjHCRC2vpeiBchryDV8j15t5sMUs
X-Gm-Gg: AYBFou2AOgkh4aReU/pA62AqIhc8adLdnuhhlZrTjM/2bNKnk6oH7l0DDrjnti3cPzf
	TD+/Bl1ELl5VlCUFXfziHUEtii97/aG7kXUpxgjlAD7cf6jBvLWXcTdDJ7c2lxNcDeAPmUybQM7
	j8kIjHRPLCFB2nFbpgmhFc/onZrOcUbK7Q86e6uC0NuEPLBm9lYx2E9nTGyZ1pgfVvyaauJgrOr
	kvDzNPbRjKk6J37kLGeEGJoLjWIUx26xK+OA3YwedfuSODI1IVjbvb9Ijw39WGjvS/d8tMWK60m
	c2XgMkiE2bJou2MHP4YNrRv9aUc2rb8egt4iu9zt+weueJegMVxDcPrJeq9zF1kI78ONC5Q/FSL
	NSl2oSBBjshA7U2+5dAeNN65fMSrPaQ3BbwUH+F/R0+57HXonepKly8KRhYLIq8GrTaAOFrZ8bD
	rCFXiH1TDcVBLqJxCtX2GP3+0T9gmHOJUWhsEs1l3eHe1iogoN/RqX9rCdYlXIJ3/jBsEqhpcRZ
	bD6F1udvDHHZfk5Alq2iqYGxzQwZ55JCoPF1c9r9m8O4LXqnz1ehA==
X-Received: by 2002:a05:600c:1913:b0:49f:fed0:fc47 with SMTP id 5b1f17b1804b1-4a1680b47famr67557995e9.1.1791107652975;
        Sun, 04 Oct 2026 02:54:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c57d920c3sm2561580f8f.5.2026.10.04.02.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 02:54:12 -0700 (PDT)
Message-ID: <39a28064-1698-4971-a80f-4a4c4dcdd8d9@gmail.com>
Date: Sun, 4 Oct 2026 10:54:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/09/2026 12:26, D. Ben Knoble wrote:
> On Tue, Sep 29, 2026 at 3:33 AM Harald Nordgren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> 
> …in the rebase case, I would expect something like git-log's
> --cherry-mark option (or really the algorithm behind it, git-cherry,
> and git-range-diff) 

That's what I was expecting as well. It would be worth carefully 
studying the implementation of git-cherry. "git cherry A...B" 
precalculates the patch-ids from the side of the merge base that has the 
fewest commits and then walks the other side to compare them. While it 
is walking the other side I think it also looks at which paths were 
changed to avoid calculating the patch-id for commits that cannot match. 
It also batches fetches the blobs it needs in partial clones.

As far as I can see the implementation here makes a separate upstream 
revision walk for each branch, and recalculates the upstream diffs each 
time which seems less efficient than it could be.
> to be useful for identifying rebased branches. But
> of course even rebase-merged branches can end up with minor
> differences (say, a commit was made upstream before that branch was
> rebased with an identical change; no conflict occurs, but the new
> commit differs from the old by not having that change).

Yes if a branch has been rebased before it is merged it may be altered 
such that we cannot detect it.
> In the squash case, I suppose the best we can do is check that all our
> changes were applied at some point between the merge-base and the tip.
> There probably won't be any tree-same commits, though maybe a
> (premature?) optimization can return early if the trees match exactly.

If we have

(topic)  D - C - B - A
                       \
  (main)    M - Q - P - O -
             \          /
               - - S - -

where M is a squashed merge of topic I think we have

     M^2^{tree} == topic^{tree}
     Merge-base(M^1, M^2) == Merge-base(topic, topic@{upstream})
     $(git rev-list --count --right-only M^1...M^2) == 1

If you know your repository only has squash merges that were not rebased 
it would be a lot more efficient to just look at the trees and 
merge-bases, especially in a blobless clone. Having an option to turn 
off the patch-id based detection would probably be useful in that case.

I think detecting branches that have been squashed and/or rebased is a 
useful improvement, but it needs careful implementation to be efficient 
enough that it is practical in large repositories and I'm unlikely to 
have time to closely review it.

Thanks

Phillip

> It looked like you don't distinguish the 2 cases in the code, and I
> think that's reasonable: we wouldn't know a priori whether to check
> for a rebased series or a squashed commit, so we'd have to run both
> checks, and the latter presumably subsumes the former.
> 
> Anyway, I can see how this would all be fairly expensive---on one repo
> I work in, git-range-diff can be somewhat slow depending on how many
> commits are in the range, I think. I don't know if it's worth trying
> to state that for folks, though? If we ever make improvements to
> performance, we'd have to remember to remove the "this may be slow"
> text.
> 
>> After the release of 2.56, I saw people liking the --delete-merged
>>     feature, but asking for this. A lot of people, me included prefer
>>     squash-merge and it currently doesn't work with --delete-merged.
> 
> Btw, I wonder if you can share where you saw this? 2.56 was released
> so recently I'm (pleasantly) surprised there's already feedback on
> this!
> 

