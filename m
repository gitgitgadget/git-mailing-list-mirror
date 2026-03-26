Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1FA3FF1
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542853; cv=pass; b=pG4BcfszjB3cegrdByTWqNmBkK+/xE8Sn5wJb7TLRzlFXuimsDHWDzDwg3jfXrVg+ihE7R0vifcwsXKa+OTK4cAFVBkiCaA1OtBCg97O6Nm//T9KP8MytTnu+Q5u0BpXcBqXquSToVnJAJbO0XgQQccLTG5iKN6hpDiV+3A6bvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542853; c=relaxed/simple;
	bh=eVa9ND+1AXiKmayAOQLMn6fVcVisNvLTv6EMokIx8nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rElvSWzZXY3bxfP//amQCLuFsNu/BVtNwzOQqVNx7HHf/2SQPDJNMRl++EPsCCKTR+/80fyrkN6gLUcHKAGcYk6tsZ7tIc3r9KNg300HIC8HpIVsMiTFUgDVR7aFIbrbwGPhPJK2eto3Tpyp+9s8I/T8bVqPHJ//Ff2lxJRFei4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJuOjnnv; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJuOjnnv"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad9f316d68so6116745ad.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 09:34:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542852; cv=none;
        d=google.com; s=arc-20240605;
        b=cuemULoh6YZYzrFLEgyLbOgdqd7d+A3XwQfAq1GLl+QvmusNhIJumHODBoqpLmyCrL
         JkgWy1TOOaUPLss+r1dox7JFgFG6OC/tGIHiK7ycUsdRY4KPN+MB3mzyY1QN/VOvbBkL
         RbeFo39byvy+qEQIGMbdbvA18ftccvfkND8Ph8Kdo7I5oeKdgtCE9myj7o8a9MFGyWmV
         KK3RBDtTLXTOpXq+UycVtrkis9wqVOsRpM1GX2whLAWE6rFYjdgt/zZULGqHqCPRCgbA
         cMZc4Rduky27oiiyK6UbIpnlznszmkqH28AWSm5rpvQX2bDrC9pUdl8jJKhvz/hTcMoG
         lF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVa9ND+1AXiKmayAOQLMn6fVcVisNvLTv6EMokIx8nw=;
        fh=hUeKWjom7y5/dqu9MvGPHZLDwfmsGOVrGHKhClXbqeA=;
        b=chlgNTYHxQhv9kpARafYHGy8M7mObu0fAA5SMH/pjk7VVGkKJASayksjtqekT9M8Qu
         c4zOFKizkY4BdpLMK/07AuREK0WFZ7h5RW0bitE8nHspcI5aGgwKw9Cf5r9tSxRXBMkB
         OfhD1ylKkF9+PeWcKMSzYlgiFinaTa6saRyfEKcfTJnwVL3+zCcrGHtMFSX8ZtwtGcyu
         2QozhilxoqZ2lN0LUc0RaFP+K1QjDWzpAxwpbYnlvhG0Dp0QdFz6tlvMhh/ZKSgd2GRa
         Lvosu/dVvT6cW2UmwLaAME12pAMjMXcMlt0XyXM5EjtjphzAQwqgbKhzHsHH9xmCqbSD
         YhdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774542852; x=1775147652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVa9ND+1AXiKmayAOQLMn6fVcVisNvLTv6EMokIx8nw=;
        b=SJuOjnnv9WOnOxb8QKpir9ub38YmPJ0uvN1Of0vTz3p2vSzEPIl3WcfeDbMn4L4/4X
         IjEKzvnGV7gNithbOn14sh+IMJjNGUIv72ik0F/jGRu7ZHg89Ry4ZoKzUX1UYicdqf9+
         vusCBvNYFBl5ZgbjCNT8Zyal1AaEIqS3PCcp/fGtCS9BvCFkBcBft+Jy1Lbk/4Kc/JMj
         GscczIp1VLO3D/vtpIzw4RoIgVjbsvvWPcQ+BcBcmwJlrPlRJKpwVwIdR936FxxzDZ8L
         8Vt6blS+BM5e3FjhWdvmh+Fif7t5Q8iuMxwoWqRdFU8z2XiLbxXplaH1AsO+Jsv+9VJD
         xOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542852; x=1775147652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eVa9ND+1AXiKmayAOQLMn6fVcVisNvLTv6EMokIx8nw=;
        b=Bt50lDgOSf4ge408Dk+zw7BGaB9mNzGb5cEycuQkzIusj5FVxOC8FKUXJWN9cUyNlz
         mc107La+1AeBqpq3sN3IOprvPXIgSuRdI8Xc8wcOUy+Xo+SdL37fzivGtmISz+OQQY2i
         1EVOMueF4Gvo/vxn+jySsdW7YGOVSqp27TgZhhwaGotlJIW33Bj10upyIxx3tCy+V2PS
         l90dBpwdwxgXc6szIRgqtXLkpMs2IlwvJVxi+phKkQ6xHcAsqul5vkDz3QJXiKxSV7x5
         aHpqvHzP6TALdDJxj+f45fJsUjBk1lzo3bvIlQ5/B8GSF68e97K9QInTvcSLlCNn67Bq
         9odw==
X-Gm-Message-State: AOJu0Yz/x0Xjwo/Iww0lDlaHEFHfeFBexrLw7/Vg9EBcapYGg0GTm29Z
	LQo//oXGE6DpCGqC6UdifAhEqRjMT8cp5vNF0nm5osbbT+k8fyLJ3+s0bKbMey5uf96TqQa3xRx
	HyE133Q32WcGZzct8ltgMUVemC37O1G4=
X-Gm-Gg: ATEYQzzUv6wspIiKye1/Sc216ApT8h3Fl/itDJdOsxco5QHoCF8VMKyxBXevBWP1lC5
	Xu7de+UCbwI+gh7HbjKawQKWbSJXvEZOTJ6MSgMn5Q30rob61oAVxsu1Z9Pgl59hhpyJ9N+TNPs
	U2XAeDEHgFWbZPWrTx29QzKtVI6ozcaAScy4gYK031Jy72d9QwEgqCNgp4eJA2JGfKVvHkHYzSt
	m4CruEFS7sG+XvsEfHsAIeU6lSjrTJpyAByQpHCtMYRPj+aCnnVh48ElOUnWAKzcim14zp57bDh
	+g7esFZgorXjd1904xV5MvmTCcurQerNMQXjW2CUv6aniKjTXKduOzp06na2MR1+n1LXR9R0BMz
	2UW9s
X-Received: by 2002:a17:902:d591:b0:2b0:6e60:9582 with SMTP id
 d9443c01a7336-2b0b09c8cfemr90224465ad.18.1774542851902; Thu, 26 Mar 2026
 09:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773959395.git.mroik@delayed.space> <cover.1774284699.git.mroik@delayed.space>
In-Reply-To: <cover.1774284699.git.mroik@delayed.space>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 26 Mar 2026 12:34:00 -0400
X-Gm-Features: AQROBzB2gKg5nEfvHm-XIufo-haKxpB7-k3H92KAZQNZR21AFp5PVmgU4s1yA1k
Message-ID: <CALnO6CAmXrYxYUCg6KRKNYmw7xTW6W5ZZ85BAYL5pOt0pvMR2w@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] improve "git format-patch --commit-list-format"
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 1:32=E2=80=AFPM Mirko Faina <mroik@delayed.space> w=
rote:
>
> Not much has changed, just applied the suggestions Kristoffer made.
> Thank you again for the review
>
> [1/8] pretty.c: better die message %(count) and %(total) (Mirko Faina)
> [2/8] format-patch: refactor generate_commit_list_cover (Mirko Faina)
> [3/8] format-patch: rename --cover-letter-format option (Mirko Faina)
> [4/8] docs/pretty-formats: add %(count) and %(total) (Mirko Faina)
> [5/8] format.commitListFormat: strip meaning from empty (Mirko Faina)
> [6/8] format-patch: wrap generate_commit_list_cover() (Mirko Faina)
> [7/8] format-patch: add preset for --commit-list-format (Mirko Faina)
> [8/8] format-patch: --commit-list-format without prefix (Mirko Faina)

I've just noticed:
- we don't specify the default value in git-format-patch(1), so I have
to jump from there to git-config(1) to look it up
- we don't specify what the "modern" format means

Maybe that was all hashed out already, in which case links appreciated :)


--=20
D. Ben Knoble
