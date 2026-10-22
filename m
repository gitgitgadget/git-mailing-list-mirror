Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792676653;
	b=AbzWqd7TBFlMNzlCwa8nn4mDreWkPW3KVUMDc+xHBvdEHxyVt4yN66pLNEkN3a9LAwXZ
	 gUXO/B8dyGQWnul5G+eLGjxvefwJU2DcLplE7mjf5HiYOn0ek1fyPke+kvH4oSZXuKglm
	 PeQpbvae15NTdnrLv1vSySpYb45ul75qZ0uJMxvX4XQ6JaT9D9TRrxfYfOArZk3qWy+/4
	 HVC8VFqGQqOb4ckHeKmwUDVu/M6xSqUCSWCPHqIQgG6moCrzYgXCsIcreS6x94U9aEuME
	 S93CTypOMIIB5cdCYWmYd59PDBIEpct2n2Xbw/7KP4Zij9k4T81yA4g0mhVnZKDcFlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=wR54twEgXToWS93jAQ/MyUkhfuXjX38TM7h9Wx1TF/g=;
	b=GAEP3LMYs4V04eyMsOL4WjCpt6t+LvIBr+4pxegtvBMm4HNHIECQEs7eyUNgcJZnE4Bf
	 ceQJ35XKY7lHt6bwddMBWmjXTQ1mSdTN4TJs77zMEeqW2cPg/SnvNhTzYcNQgVWDeIHJj
	 oFEUhwqaljwqvvf8X+YJCBY6PcXnQOwunAGJBRoc0SVvYzm0Pssqnjh3Qf0mFML2+PW2+
	 Fsq8Ihp/dA+H8ZsiAHLmMG4cRGJaTcRO3ZMuuRiHfQAvAiCcvP6UHQm58c+2mJwyf3xy1
	 6dXlT/K56X+OP8Hl15KCExnxACxATE6EhipGCm5u91Icy2hsbc0zyWtXbdM+RG5/ZWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aYKUbmGE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5787660A4AC5
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 13:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5787660A4AC5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aYKUbmGE
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso2906548a12.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 06:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792676652; cv=none;
        d=google.com; s=arc-20260327;
        b=nTAE4vn86MONi//6qNGkg1Tzl4tOoSrHHI3RQ3Pgo/mP9DPRzXIsHC9xa21KliLN0n
         WzHc62I0fVdqVMnDBdj/IaUCcS+xa4moZSt4ZWuI9yFaeVTpFf8TVpKY1L//VAaqXZh+
         8fSNuAD7nY8NdocK+Ah+DdgQiOUg0YUQKx92vvIQFFv5DPbpO5VHLk1Lugqa0NQ9lsS8
         mPkYTgtibQftq4glPDLbMZvO2cuxpDDON28I7+rpCYw3MuRQAby+tR7nx/BEIT+eFtG/
         7+mgOZ2bjVHfbNaunmL5kB5YT5vF8CME5OgbkB5g2Z2LKlVdr3ZHy2NnLR1Ip/znhbwN
         3REA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wR54twEgXToWS93jAQ/MyUkhfuXjX38TM7h9Wx1TF/g=;
        fh=QcmfM2CiA8aRiiQ23/JY0KmpQABZ2hZBR2bMmuErFT4=;
        b=jy1OTh61G712E7S756jHOOnTAzwL3fD8LnroVIdlp30LQzU+O4JkvD2jrtqJzC55BC
         FImNRjSMRmCxIGfc0gUc+fixQMw/Qp9Ni02T5yejsUryJ3SG1xWkWy7mjwolx1DGMyb5
         rEjrUIkuE6TQg9ojO7y91xMFCbe365w7l9Eu546EFTvibqisMBd659xXZAoCy3btEVFP
         H7zBu9LN4O8CFhM407OWbrE3JUlPTDsedVSkr7JsNJNRgsuslT2lmbDmEzuoXghnKrr6
         gpNNEuaC2ruwt+m+QZTC0IkMomwdgkWclhAqXxZ+BehzPypVscInm1GKIwq7rHDprzW+
         O/Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792676652; x=1793281452; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wR54twEgXToWS93jAQ/MyUkhfuXjX38TM7h9Wx1TF/g=;
        b=aYKUbmGEJ5IYAZNd3gsqOBpqe7IkrYIK7DIlP4kawpCtIAPl6SNTSBhVv6xToMq+RV
         P1aoKVVJM9Mwz49EBJIXPkeiT6tb1iEP9vyWJ9ZSPSXztlIv+pfBveCsA+UeQ5yf2O5s
         mekrVgRatvesdjxOiJOw9ok1xjI93chnnxdjQbG9BZwfad4HUvlDnBi72VvW1E4hU6mp
         EiOvKJMC+JBQUVlV69u44bbmwvmJGaro6XuoukEvlkFFboKe+QYox6wWWYjGtYkKAx6e
         ZMzPH7qOQXbEYP98loBhkyF+qR773BTtn0dKD801onTrbcfSpNHfMhSC5N6TYiM4IiG7
         122g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676652; x=1793281452;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wR54twEgXToWS93jAQ/MyUkhfuXjX38TM7h9Wx1TF/g=;
        b=OzNM0Lo1GHOnHjCDEDRbxLzOT3AbzxGCeIJJgvmo29E01OI7ZNzbqixYl3LwZYmsBs
         NhkQJNcxXatgjsW35r0iSdSaiBXAsWMTTr1TL7j1DbdB3tGQYk/G5E58tuItjJ6LBZhm
         accSE0ikp2WgHVMELmjfZVnzQodTuSqXHqH0YyMRC6DDT6oTamUSMjNZZfsFd0C1gcXg
         I9ickZko9+6YqWE0eGsC/wHsc7cguXoTFVNIyv/oisJI24MdB1RSalqkAZkF9nZVdbN/
         AE0ZorakTL9PunOndkXcIlj9uPB4ZhF2qrOyOPYsj1Y7AA7g2Gc/XxYJmz/413I/gUyR
         uL6A==
X-Forwarded-Encrypted: i=1; AKwUvBxlOjAgF0A8GLD7vp2Sjpe1MzrRygpDsYnA1x26VSTnBixBEQouaNVA06l9+BttW6i8zwE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtbDQ0ayimqw6+GUi21y7mUrbAlWYtrPJvHP6qAGKPSbSxfqat
	iIbq6rQ4vgXgS1kxzBpdYX9W13XwrgYrtHS7bsLMbiGdZPHDPV6GBoJVJoS5LMbqqottypoj34y
	SmdRkfxpKLxC9GKsRej65VxktTxLNtu8xxKA5
X-Gm-Gg: AYBFou3MsQx+R66Xj+F4SwALgOuieQVtjL+FwL8SrKa9xl+5Gr7Kea6LVOHVF/KZPUs
	8suQT97wm131mHk6RFUEK+B6uGFLVCxcCLfF1/E1DineOnUyT2lL0wDu9A1oaRfdDMhLDmkz3qE
	VZECxXaMpRjmGQT008UHeeEFL9f9080ce3PWlRznx38HvinwrTfWx1YzyfMG208g+DCOR2W3lBE
	nyos7R58qhDKe3mQO1ezYtzFbHqXkb+zCpwLhYc7nTXvDSjAkVXvj3G46dgo6jT1OoXzP3j1LO/
	cXo9p4msv3GYASodUJnP4QIUA/x4cysM8v29MPP30YH8IEHL1OUE2aT289Uv4YljS6lnfKTMcsw
	jYmgzwopNPtHA0HFqSxJdr4SNihabMgQQpBdj7PTg+ac3aZMz6PUEnxzpBg==
X-Received: by 2002:a05:6402:550b:b0:6b3:cbdb:bd93 with SMTP id
 4fb4d7f45d1cf-6b408ed1f2dmr4730629a12.29.1792676651469; Thu, 22 Oct 2026
 06:44:11 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <a8561fb7c2da446e7f7acc7e2a443991@donquinleone.com> <CALnO6CAsCvJRywkw0WpO1nEhL+yU2-r_4Z2AHdJch1m=NK8=TA@mail.gmail.com>
In-Reply-To: <CALnO6CAsCvJRywkw0WpO1nEhL+yU2-r_4Z2AHdJch1m=NK8=TA@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 22 Oct 2026 15:43:34 +0200
X-Gm-Features: AclHuK8EScUDRi1WgjYMbkTKkAH19G1PiNlOOxuH13Ghx8WaoccwnnI94YM4mK8
Message-ID: <CAHwyqnWi3MCvAw-sNrn6k3ht1tpUfmNg18BAvEThKthen5Dwmw@mail.gmail.com>
Subject: Re: [RFC] branch: delete gone-upstream branches only when proven
 merged into a named ref
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: DonQuinleone <don@donquinleone.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Ah, but the manual seems to contradict my (personal) "natural" reading
> of the command: "--delete-merged" actually deletes branches whose tip
> is reachable from their upstream (when that upstream matches the given
> pattern). So, phooey. In this case, if "topic@{upstream}" was
> "origin/master", though, "--delete-merged=origin/*" would work, no?
> Incidentally, I find it a shame that GitHub's documentation encourages
> a triangular workflow (whether or not there is a fork remote involved)
> without talking about how to configure Git to help you: fork or not,
> if you push to a topic branch but merge to another, it's extremely
> handy to use push.default=current or some variant so that
>
> - @{upstream} is the place you'll merge
> - @{push} is the place you push
>
> and suddenly "git pull [--rebase]" does the right thing, "git status"
> (esp. with the new "status.compareBranches") can tell you where you
> are relative to both places of interest, etc.
>
> IOW, "git push -u origin topic" makes upstream configuration very odd
> in the GitHub-ish workflow!

Fully agree!

I would say most workflows are triangular on the underlying level,
even if the developer is not aware of it. If you work with GitHub PRs
or GitLab's MR, then you are engaging in a triangular workflow.

I picked up some important tricks for visualizing the triangular on
this mailing list. But most of our users are not on the mailing list.
But what we can and should do is to make git itself clearer, so they
have a chance of intuiting it. I think for example that

    push.default=current

should likely be the default. And many people would have a better time with

    branch.autosetupmerge=inherit

which gives you upstream/master as @{u} from the beginning, and then
you likely never abandon that if you are a regular GitHub user.

This is also why I feel strongly about this as default
(https://lore.kernel.org/git/pull.2458.git.git.1792437798463.gitgitgadget@gmail.com/):

    status.comparebranches=@{upstream} @{push}

because it's confusing to switch tracking away from your "own branch"
to upstream/master, if that means losing the waypoint of how things
compare against @{push}.


Harald
