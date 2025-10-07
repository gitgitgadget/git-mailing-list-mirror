Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1A5146585
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856314; cv=pass; b=gWGh1/gydv35Asj25qg/ZPqAj2rl0X7qqP8O4esMysHXQq/CoAUUqyun4R5qYJ/DM1i035Qqec+8jTPoxaYJvNORyfqD2DDDEkpUpEavzzr2+wkvZNBTz2m5XUO6sXK0B04w1Oa9Q0wjybkqRVvow9elinnUPB7Lgm61dhR9rv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856314; c=relaxed/simple;
	bh=0ZhBGitvGwGw5hNCD4qGBt7KeJ2OTQLC6vABxbgGNzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rVQ28DoMr0+uYpVZ7LGMZh2K9i4fvkTljBp8MJ557GNdtgoeF6gmSuH7fL15mQvKP2opmw4RcQdg0pTKUnmujtWAxCiBn27ctCChBOLWAr2H+pKXPVKAvT0VR612Gge0lLyXbpWYyIX3NkywDlLv9CFXbEU0Xae8zmpNnW6SqwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=G8yZcgYR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="G8yZcgYR"
ARC-Seal: i=1; a=rsa-sha256; t=1759856296; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L0WgFOAPxd/oLQjua2dcn0A+npzE/2BObJURbLwudH27Oild14wtTUIU5ROre7VhzHSs5tfuapQmSaAumDz/zARjaS2BCe24DFCpoGjYMHQ+nHLRdBwFUf+EWPdxe8sYyYDb6M1zyKYaAJvCSHntHWp2Hz7PCDSPOtvMUn74TKM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759856296; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TlrdaMaufhj53cc9zo1z4hIEIgD2gHo3xngplbuBSR0=; 
	b=jNMKsTRR77F8TdtMvlbc2r7znIr+76wSIIe+4BidKbJ8iRKOWYWlY90QGaNZsTser4AFSsjew9Q8BxgkZeCY8HWbn+q0iYqliEfAtosCZpXveOVSnmYYbm72gZYQQavrO2r3JRY4qKk2qqcmkFjaKJwd/nzf9SUOIvqPD8MZ+8k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759856296;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=TlrdaMaufhj53cc9zo1z4hIEIgD2gHo3xngplbuBSR0=;
	b=G8yZcgYRdV2S12o/BA4qaLdjvI6xO2o9TmnBtcOI/oPtqKwJsKMxFwlVw7Hl2+ih
	5LOo/5Cg1z0dM0zeuH+6OqKpXWZIJFpGD+X14lrAHOOxukHCDFhRW3GUQE18u8cGZxt
	Ro3PksSsDQNNrrH6nlTahbT1LKiTtbMeVR2PQi4E=
Received: by mx.zohomail.com with SMTPS id 1759856292374573.6229358055896;
	Tue, 7 Oct 2025 09:58:12 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron
 Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Patrick
 Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/5] Encode submodule gitdir names to avoid conflicts
In-Reply-To: <xmqq5xcqn2pe.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <xmqqo6qkq9vm.fsf@gitster.g> <87frbv3qyr.fsf@collabora.com>
 <xmqq5xcqn2pe.fsf@gitster.g>
Date: Tue, 07 Oct 2025 19:58:05 +0300
Message-ID: <878qhm4pk2.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Tue, 07 Oct 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
> 
>> Currently any existing submodule gitdir names are left 
>> untouched  and are used as-is (unencoded) after the extension 
>> is enabled. 
> 
> And in order to make sure that a funny names and paths in 
> existing submodules that can be misinterpreted as encoded would 
> be registered with the new submodule.<name>.gitdirpath variable? 
> 
> That would be a robust way to transition.  It also means that 
> you have a mapping from submodule name to path, and you will 
> have to make an effort to maintain that mapping and the reality 
> on the filesystem in sync. 
> 
> So why not take advantage of the fact that you are making that 
> effort anyway?  It can simplify things quite a bit.  Imagine 
> what would happen if we did this: 
> 
>  - You officially declare that submodule.<name>.gitdirpath is 
>  _the_ 
>    mapping mechanism, not a mere "override". 
> 
>  - When enabling the extension, you register all submodules that 
>    already has their gitdirs on the filesystem to the mapping 
>    mechanism under their "historical and natural" names. 
> 
>  - When you add a new submodule, you "munge" its name to be used 
>  as 
>    a subdirectory name under .git/modules/.  You only specify 
>    for the end users the purpose and nature of this munging, 
>    perhaps like 
> 
>    - (purpose) We give each submodule a place in .git/modules 
>      directory of the superproject to store its repository data, 
>      but the names of submodules we find in .gitmodules may not 
>      necessarily be friendly to the filesystem (e.g., "CON:", or 
>      longer than the filesystem allows for a single path 
>      component), or may introduce a subdirectory (e.g., slashes 
>      and backslashes), or two directories whose names only 
>      differ in case may not coexist on your filesystem.  That is 
>      why we do not use the name found in .gitmodules as-is. 
> 
>    - (nature) This "munging" would remove problematic bytes or 
>      replace them with safe ones in the name, or truncate overly 
>      long string, or insert sequence numbers to make the result 
>      unique and representable on the filesystem.  Hopefully the 
>      result of the munging may still be recognisable as derived 
>      from the original name, but it is *not* designed to be 
>      reversible by itself.  The submodule.<name>.gitdirpath is 
>      the only and authoritative place to learn how <name> got 
>      munged to produce a path. 
> 
>    without having to go into the details to avoid tempting users 
>    to write scripts that guess and decode bypassing the mapping. 
> 
> Hmm? 

Yes, I think that can work. Will do in v4. Thanks!
