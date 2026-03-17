Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209043CCA00
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754154; cv=pass; b=LJXIATRpBx4NDp2E0rCUFtGGWVeWfpa9HIHtr6xrlUpQ/VcPTb4wUvIeNhFC4WPQ1FhTyFDermhddEAQG9Bs/u3Xw2GBGbU9/vAbvrCxQ7dW228uiS9Ig/6TiCGFwmdrIayvZ4VwVTWEKCDZTSXouFdjJBOEk99nIM/aL14nOis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754154; c=relaxed/simple;
	bh=SH8nCpuz3U3kIX/X461JmoZoMQGIWrOr+wNEJgqv/ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEzNaagnHATvoI2OSELOp9dba+fEuCFyJ6n2d+Lnk8pNR1p0VTD+MzPr4VuMVp+VmVjDNov23e/zBBba4SPIbpTVnrI+uEWFDuvZ0A5v2GfbUkArALt1rxRV+sJwEBbt5tjr5wTWgWjGX82kVIjPPnm1ZHfhh/YaljtBtFFKpc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RC5+8X/O; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC5+8X/O"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c648bc907ebso3985438a12.3
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 06:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773754152; cv=none;
        d=google.com; s=arc-20240605;
        b=jnnvWWFtIOTSo9e4vpk1trnCMomVFAXgPSkCXsdx/rVuaxoC9Asg5EFbyW/UTMlr9M
         9fLvHp6X9mRbm9nzHgJln1oUXojvg1l/hDMnC9QIr3owgpuQLu7rObF7T047K8K+xGHu
         x06NckdYTPuOhyU2z4qfWnz19nlzKs/3ZoCdJivKU4pMlTCgI85nEHCvfdUDmPDOByX2
         1B7kOSSii1bdyNC1jddzEArYwNMfTfRdGR9/qPMxV3A9C+G/bGMWtUeMEEmTPHiWN/Ht
         9920vaxZz89Tl8A6pkLaV0YqLtTBWe2QERRVhmSMUUMU9OjyjXfHTKqho1O9s/A7T2yK
         OpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8BmCXxWb+RrOEngC5Cg5BL6JUVI6JCB544Q66s1X0y0=;
        fh=1257yDTh098c2BEtV0Oxwdc3EQkwSxfmEbAaN88ZqcM=;
        b=Gu4cE2zn5rHIVvCAXlbuhqfdTX07WNPX76wbrzuYuzhHCdKcgZrKW6HesExYaZsITS
         uYy5p9NnB+05sB/7+aHkB0x149ZiiiOxdJCN3X/hg70fKMWRtOLIy6t4oOfAqy2T0KEp
         hqpsdt2bDQxG1VBN/CTJI5Wnj1R33C/dNT7wufMwIdk52h5wwMiWnYwZjJzphHF9nsKy
         I0cpS92s3CCLfJQzDQj4waSUNg8gk/EU5yxEBL4j5G00ET8Yswk09M7Q1FWD9nMJlWev
         gPt3wEgJYbJMcPapdYiCjlw6RemUuQ44C/cLwen19YtWVsbR7x7HIG1hxYw/WUwiLUGp
         gkcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773754152; x=1774358952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8BmCXxWb+RrOEngC5Cg5BL6JUVI6JCB544Q66s1X0y0=;
        b=RC5+8X/OQorH0uLPX36zTB6D2JQKofXlaLOe8e8Nkbn7UVRgO0yqEKwjQ+fnk4HRZE
         pE278iLrpwa+XcSjjT8Var7+7//00+rbRfcuw2CPmjAxuOLfjGWqJ35h6O1NTJUVnrW4
         OK4vHERvYTbelUBi2Ff+qLy/PBUDIvwULtK0w3kpMCKEfbFImekbzpsNdmJorJ7Pbb9p
         KziPXakrPS7mosf0Ar/CnGM3DX3/EO04/T5q5urazbG4+pIJCXTqP1pAmoMiqzP2JcUu
         YiSx7X1vTjkEUubv6QVCXiSqUxGxQQL5L8hfSRoITaBT7Iy/+v7Q3dOj+x+RGwBZNbPz
         kT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754152; x=1774358952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BmCXxWb+RrOEngC5Cg5BL6JUVI6JCB544Q66s1X0y0=;
        b=WztTEnAKiaVVhmcrACMYZ0a9YUewPZIEwqP7dGcL0066rIB+wXJMBzqA/pF4p4NY5a
         /ueXIblVc9kifPnTo1iqNtRtzoFR1RGSITPU5aREf4iKfts8zNrj5y5zUwMs4l8UJK6X
         KDQ4zulhICxkpUy2yCBxme/dabXP7pFfraLA0ZLeU0WD9FHUGgMYZu6ST1AnuWE9H5uD
         9j/kFA9WUfaXxRM1ddY4ntctrTCXJ5Sa80/3mPgzqWl99VRjnKmwF7gwUO0kcBsFJoDo
         DaubDJ2zWTGItohYY/1aTTI5yQ4TCx3IIbo0gPY+lvRMBGt/Jnm0D+mL1Ciivn725LeX
         iz7Q==
X-Gm-Message-State: AOJu0Yze7hVZn5VHrI7Uk4tqsZUfO8nD5VMZUHmBR0EFyjz0A49s/pcW
	oyY69kWSxm7MvhlVPlAyorqApIeE+MS05StbSphcn5XbXXXCW55jchsve2EJUx0SR8/u/s0ZGqb
	v4W07fZjJeooEwAvNEERBxyLpeEyLxwk=
X-Gm-Gg: ATEYQzwMjYgqW04r7RY0E29AouBgPOask+OBTSMfeC2D3Ex/r4yTQXCDDIS2spt78J1
	Ur+ZRZtQi6i7vHl47QiszpEpLf5hq7dhCScqgPl5jjEAgb9GnUHke1hRbwJjoaXKBvlPOj1ysc/
	hLDJlr61H1gRSAkKVFrJMkXbAS9+NeVvrf2AHuXSkmmaNRKN9Nu/Av7fLaM4h7uO9ZGOTn/F948
	Ukb+9Jqr3lli8eqLJofs8PAPZCvonglrNPSxAt1Li0vcFBN7NQt3JZ/N0IiT5kfb2r2KnQf9Az/
	sAcoVWMoc16LWrH43HQdCKNXbADIxz9u1ZiRFPEt4Wqp5urFfrh6q7tvFU0yX4bU7aya7sjq0y9
	py90qshM9Uu474/i3N+S1GyByUQ==
X-Received: by 2002:a05:6a21:48f:b0:398:7eb4:8aa4 with SMTP id
 adf61e73a8af0-398ecb06ee9mr13799234637.31.1773754152231; Tue, 17 Mar 2026
 06:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGWgyh-NASOa+6NPhQHCte2_A7OkNm1r2qAov3Kn1+r1d25hYw@mail.gmail.com>
 <CAOLa=ZSqQ=w8EVFMUwn5EUfMmNBgzGzG458Ex1ixiBSTiWnWYg@mail.gmail.com>
In-Reply-To: <CAOLa=ZSqQ=w8EVFMUwn5EUfMmNBgzGzG458Ex1ixiBSTiWnWYg@mail.gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Tue, 17 Mar 2026 18:58:35 +0530
X-Gm-Features: AaiRm52gqSmHJrv4AkYleW3gWe3RPsDDYEgpfhx7CujCwczmRecvqrFG4VMcpmw
Message-ID: <CAGWgyh_VmcNuay3AjsZ9zj9mP4g-c3Y9uDfuO5=kP9ix7Kdi3g@mail.gmail.com>
Subject: Re: [GSoC Proposal] Improve Disk Space Recovery for Partial Clones
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, jltobler@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Karthik, thank you for the review!

Karthik Nayak <karthik.188@gmail.com> wrote:

Let me address each point.

> > 5.1 Blob Enumeration
> >
> > Walk the object graph from all local refs using traverse_commit_list()
> > in list-objects.c, with a size-based filter consistent with the existing
> > blob:limit=N syntax from list-objects-filter.c. The goal is to collect
> > blob OIDs that exceed the threshold and are currently locally present,
> > meaning they resolve via find_pack_entry() or as a loose object, and are
> > not already in a promised/missing state.
>
> How does this work when used on a partial clone with 'blob:none'?
>

Right, an object walk using traverse_commit_list() would
hit missing trees and blobs and end up triggering a lazy-fetch storm,
which is the opposite of what we want.
The enumeration needs to stay strictly local. We can do this by
passing OBJECT_INFO_SKIP_FETCH_OBJECT to oid_object_info_extended(),
similar to how remove_fetched_oids() works. That way we only look at
blobs that are physically on disk and never touch the promisor
machinery.


> > For remotes that do not advertise object-info, a conservative fallback
> > applies: if a blob is reachable from a commit the remote has, and the
> > remote's advertised filter covers that object, its presence on the
> > remote is implied.
>
> How do we know a blob is reachable from a commit that the remote
> advertises?
>

Fair point,
I think the cleaner approach is to just drop the local fallback
entirely and make Protocol v2 object-info a hard requirement for v1.
It is stricter but much safer and we only drop what we can explicitly
confirm the remote has.

> > 5.5 Safety Guards
> >
> >   - No in-progress operation: refuse if MERGE_HEAD, CHERRY_PICK_HEAD,
> >     REVERT_HEAD, or rebase-merge/ is present under .git/. Removing
> >     objects mid-operation could corrupt an otherwise-recoverable state.
> >
>
> But couldn't one of these operations start after we start the process of
> cleanup?
>

Yes, you are right. A merge or rebase could still start halfway through
the cleanup and lead to a race condition.
So for that, write-before-delete already handles this case. If a merge
starts mid-cleanup and needs a blob we just deleted, it will not hit a
fatal "object missing" error, the OID is already in the .promisor file,
so the lazy-fetch mechanism is called and fetches it back transparently.
The repository stays in a consistent state regardless of when the
concurrent operation starts.
For packfile removal, we can rely on the existing .keep and lock mechanisms
natively present in the repack machinery to prevent GC collisions.

> >   - A new option on git backfill (e.g., --drop-blobs): backfill fills
> >     objects in; this flag drains them back out. The symmetry is clean
> >     and the command is already familiar to users working with partial
> >     clones.
> >
>
> I'm not sure if 'git backfill --drop-blobs' makes sense, since the
> command talks about filling in data and the flag talks about cleaning up
> data. But this seems to be the closest relative.
>
> >   - An opt-in git maintenance task for scheduled periodic space
> >     reclamation, wrapping the same core logic.
> >
>
> This would be my top pick, seems like data cleanup is definitely a
> maintenance task.
>

Agreed on both, a flag that does the opposite of what the command
name says is confusing, and git maintenance is a much more natural
home for something like this. I will focus the design discussion
around making it a maintenance task.


Thanks again for the thorough review.

Siddharth Shrimali
r.siddharth.shrimali@gmail.com
