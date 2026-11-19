Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795090778;
	b=mRxW/WhqCgdBoeJZJdnnNJN6U1czekkr+Ug/eomtd2an/WLFN1Ij7Ch9flJxJulDuWw5
	 P9LGh1MbfcXhvFL7aLE87G+ppDrOGGY1E1aA4W6W1584ZFCsXu3YY+un4WC+CttdYLfHX
	 advwnByRvuw1b0eujE68aAvRMyjIFDwaH8vfRJfLaAq33IB1updn6b97E4bScFYJotFL1
	 pdMgEtX29eCMzMQQb42C3XQZMqJoc741W9OEtdSN66mfFyz4z1P53Q7krt20lkqv1w7Gl
	 VsFoRjFrojUY239r9l0uzTliIi8+m4ld7X5Q/5mlqB160MY7BWFC0hSp7jHhbbgC2Gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090778;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=9lI+sXnNdiG+I1Lg2bK6OK4M1Y4rN5HBGA/El3cqc3U=;
	b=F0bWy1GfU/9vR8KVZWbVvYbUkC3CsAY5RHE3GJh2Zfd9obPp76+1jhgQDIVCYxlCjdPB
	 RnhCVmbr9+hPm7EuaCoy1A2rj9I8dl/g8+rnm8HhGEQgHgKFz+51d2u8p/+zSvHugvzqF
	 J6ESRZGb1fc8QH6p2ENLal3XJgH2YWREPMxxT6HAteymXe9dZw1a9cONMUvInNjdN/HHd
	 Gu2dZT5ad8tZgx4QRkv3+nEcU/Kegn2hyBopBfOJyLykK4Za3Z94bm7O1rxQrYWGkUWX4
	 2m8gIgwhnMKmhTKXNchI6VaNLnDHZvNUWLUWKExp6uycE1QsdM4MspR06J7P1KLKIdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b="dp/kLZBV";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED46606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 12:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ED46606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=dp/kLZBV
ARC-Seal: i=1; a=rsa-sha256; t=1795090763; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eOzyVuCjnXEeN0eRm8c76JLOO2PKnYFb7hUbftmddpl2nrW6aDmMTJH46cpG0za2abIdxDoyDkcE1+18fk7LJTcFJuymV8N9F2lEkGMKpbK+sMobLXSEMQVAN7k4gIMEPc8DtkKGZUzaGpbQQ2MmZGLjRmN56sOlOrPPSUTsDNI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795090763; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9lI+sXnNdiG+I1Lg2bK6OK4M1Y4rN5HBGA/El3cqc3U=; 
	b=ADVwnhU0T/gl4FMrNyrFJl62QnstZVYp9v+j4sB0GRRmbLiQQ6TIvXu4xcPpQ36pwJalPj/AG1WNtHsxbcqadxvSySqbQcuPZ2COUhe9VGk7vjBJ+n5hXQviqP4GQ+8NEZdjpciIph3YE43qUusRBQdH7ZNLju72VoSVI6Hed40=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=dp/kLZBVjJcoH8X+Rf3ZWJL3KiHpauZw1XcixE7tsyLhUZxG0mcX+mc+ix0gwImPSgJ9n6SqypSNGTFOkd99L2ReE/3ASngcn3nouGHT2VPkgDoozoLD29hSwZTfRiCz0dw63GZkLMtp4g7PzjvQDE0q/+ozAJODModksDet0/8=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=9lI+sXnNdiG+I1Lg2bK6OK4M1Y4rN5HBGA/El3cqc3U=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179509076145181.70465685333068;
	Thu, 19 Nov 2026 04:19:21 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Andreas Wendleder <gonsolo@gmail.com>, Phillip
 Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 3/3] submodule: accept a linked worktree as the
 submodule's git dir
In-Reply-To: <xmqqv75t534o.fsf@gitster.g>
References: <avuJBGlB3pRU3JU0@pampelmuse>
 <20261118163249.1693361-1-adrian.ratiu@collabora.com>
 <20261118163249.1693361-4-adrian.ratiu@collabora.com>
 <xmqqv75t534o.fsf@gitster.g>
Date: Thu, 19 Nov 2026 14:19:16 +0200
Message-ID: <87y0aphv3v.fsf@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 18 Nov 2026, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -2191,7 +2232,13 @@ int submodule_move_head(const char *path, const char *super_prefix,
>>  			submodule_reset_index(path, super_prefix);
>>  		}
>>  
>> -		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
>> +		/*
>> +		 * Do not reconnect a linked worktree to the submodule's
>> +		 * main git dir: that would take over the git dir of another
>> +		 * working tree.
>> +		 */
>> +		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE) &&
>> +		    !is_worktree) {
>
> If a linked-worktree submodule 'sub' contains a nested submodule
> 'inner' whose .git is a directory, submodule_uses_gitfile("sub")
> would have returned 0 (because the check is recursive), we ran
> absorb_git_dir_into_superproject() (which is also recursive so it
> would cause .git in 'inner' to be absorbed), and is_worktree is
> still 0 at this point, which means if() condition here is satisfied
> (if forced) and we will enter this block.  Would it cause an issue?

Yes, good catch. I reproduced it with a "sub" linked worktree and a
"sub/inner/.git" directory, a recursive checkout absorbs the "inner"
and then rewrites sub/.git to point to "$GIT_DIR/modules/sub" which
does not exist:

  fatal: gitfile does not point to a valid repository: .git
  error: Submodule 'sub' could not be updated.

It's basically the same breakage this patch is meant to fix, just
reached through the absorb path.

>
> I am wondering if the check for is_worktree should be moved outside
> the else clause, i.e. making the overall flow look more like
>
>         if (old_head) {
>                 if (!submodule_uses_gitfile(path))
>                         absorb_git_dir_into_superproject(path, super_prefix);
>
>                 /*
>                  * Now path/.git is guaranteed to be a gitfile; 
>                  * validate and detect worktrees.
>                  */
>                 ...
>                 is_worktree = validate_submodule_gitfile_dir(git_dir, sub->name);
>                 ...
>         }

Yes, that fixes it, the sub/.git is left alone and the submodule is
checked-out at the correct commit. The validation also runs after an
absorb, but absorb puts the gitdir where submodule_name_to_gitdir()
says it should be, so the check always passes.

> Or am I grossly misreading the code flow?

You understood it perfectly. :) I'll do this in v2 as well.

Many thanks!
