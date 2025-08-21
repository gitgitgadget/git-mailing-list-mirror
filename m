Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076815853B
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778711; cv=pass; b=HOg9IB3QmwIHf+GHaFnqOM8fRbvst53E5c+rRvDE7t4V0mxSwp3XUEHgfzXAh/CiNHxnil7CEx6L0voxTcGoQIBGpnP89UFLZTinH8JioZJdqDqKfKN6KI+ehmPH840FDTryZihIR0TLrSUJMhsJNDPFBBN0zGlq5830iGNAMQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778711; c=relaxed/simple;
	bh=zhnTJH0vfcNzfe2gye43SrM7fKqjAKd/vBhNQ+kL40Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JC3pnPrLcUYRIgyjd/IaUSECD2uK71k/pXB/yIlLh2SJxj3sy6Ez0tHHsbvT4/S2hSe7POeBuRAevVCDmP22PmUZMcf9horpBNvBOxSaxWsbXH2acTMlKwolU5RYvCFun1NUVWx39xv41WZoCX1OSD4Vbl6zT2crv4q5TTABf9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=W2h0vymH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="W2h0vymH"
ARC-Seal: i=1; a=rsa-sha256; t=1755778688; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hbVgpnrc/u8a2lGqsQYDuDzuzL6Chs3hcro9VbVjZyMwjTlZTeLqnQKo4s3wTPQJ8KsvsiJnAc/j/qwXaZNuxYYe+aLZ0dmbMOiQ2eDKYEYVyY99S34nitQw5VVwTMxZRgOkmVJdhRuQHVeT9VMLYn0gKHNN5HUufPesPqkdSGk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755778688; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4B+YLuT8S2QBKKUJanoBI+QMcRstHSonhWdhKpS0MrA=; 
	b=VceBWmlF1jLQB2DW9OErVp7CpSX8BRXIufU8w0EfAgCuJB1zyYEs4NV4jSYT18kHkEiuUTRY6s1cOK7ot6/MyTDFUX5K+EXXRql6VSITSumgU/ssgLDIdUxz5pdhKaTbJU3o5VlC4BtRwIYWtC5BlccNWcBE0184hmmWmBQOahM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755778688;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=4B+YLuT8S2QBKKUJanoBI+QMcRstHSonhWdhKpS0MrA=;
	b=W2h0vymHTQDDLSJdUIwqmwzPH4RLYy6NVYjih5ESRvwMjHOC+47n/WL1ciidtdWQ
	vMHzZrdMuk7V48meVLDo+63eIA1DgpNB2NDNiYmUUyOC8IaOuuFBHU8fB3jAOSNS+nU
	XrzrEaxq623tQFC1gyQ2tBimw30iLZt2btKPvV/o=
Received: by mx.zohomail.com with SMTPS id 1755778685117831.266318639367;
	Thu, 21 Aug 2025 05:18:05 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>, Brandon
 Williams <bmwill@google.com>
Subject: Re: [PATCH 3/9] submodule: add gitdir path config override
In-Reply-To: <l4bmyst4qtew7kv7sdgzw5hibwor34zrh3c4jib7i6vlsniey6@jtku24uffrmo>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-4-adrian.ratiu@collabora.com>
 <l4bmyst4qtew7kv7sdgzw5hibwor34zrh3c4jib7i6vlsniey6@jtku24uffrmo>
Date: Thu, 21 Aug 2025 15:18:00 +0300
Message-ID: <874iu098cn.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Wed, 20 Aug 2025, Josh Steadmon <steadmon@google.com> wrote:
> On 2025.08.17 00:36, Adrian Ratiu wrote: [snip] 
>> diff --git a/t/lib-verify-submodule-gitdir-path.sh 
>> b/t/lib-verify-submodule-gitdir-path.sh new file mode 100644 
>> index 0000000000..fb5cb8eea4 --- /dev/null +++ 
>> b/t/lib-verify-submodule-gitdir-path.sh @@ -0,0 +1,15 @@ +# 
>> Helper to verify if repo $1 contains a submodule named $2 with 
>> gitdir in path $3 
> 
> This comment is a bit inaccurate, right? If I'm reading 
> correctly, we only verify that the submodule's gitdir actually 
> exists in the "legacy" .git/modules/$path case. If we don't see 
> anything there, we fall through to 
> .git/submodules/$encoded_path, but we never verify it actually 
> exists. 
> 
 
It was not my intention to imply gitdir existence is verified 
here. :)

We just verify where the gitdirs are expected vs configured, 
regardless of existence (eg when adding a new submodule it won't 
exist beforehand).

The behavior you describe is correct: we only verify existence in 
the legacy case, yes, in submodule_name_to_gitdir(), because only 
those must exist beforehand and that's how we know we're in the 
legacy (backwards compatibility) case, otherwise we default to the 
newly encoded paths.

Hope this makes sense. I'll expand the description to clarify in v2.
