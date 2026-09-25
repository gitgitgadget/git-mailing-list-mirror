Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3525B3749EE
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354566; cv=pass; b=rProeEUR2YYnzyUw9kYprLKzBx5rz+VfA27I8GLcSGEVd/BlBmXBcK/6+cJjaGFK8Em4CAQKynKEYwxqa2dqMr0/S6vIqUharKN0I5JRDdxITE8c4+CRYlwaHD0Epf2QavkbeZseSEGgJFx8ryvab8f81y67sji03RwWQocKgjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354566; c=relaxed/simple;
	bh=ce6F86cRKTz67Ajkee2zf4s1y26Bicd0jY3/sPdb74o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmszmKH+lXtPDaopmq++hARiyT9iwLTWn+u7317i4zEOFT6G6Oj7fnzxuHMFtktR+/M0HXhJaSLjn6wSpFUpu5OzDB12V3e1cgpUiWccsh7D755iSAVUatmtZ9Lzn+l3h3G1TdPSpR0J73Yo0EmiodLXPn3wf0Y+MXSMAjbL7yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEVnH4p6; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEVnH4p6"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e211a0so663001b3a.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 09:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790354547; cv=none;
        d=google.com; s=arc-20260327;
        b=R2lQZDU+ODbxABzyLfzemnf42J4hxCSyYvjN9egZxKAFOU8eceUG4rRrhmLSXNmu9z
         xm9feJxj9CmhXq0yM/bP3MDACXuumDg1ZorwGC9Qhr+aKxd2PkqYVgskxYWYrlEkjyvc
         qjZbM6eT4r/nzdDpjnbHt1n6c8mdm/8sb2s6Hk4sAAUtVEVRxnwrXxbm9OEKlavocnX0
         ZlA53feD4shUOfP7dKZ7nzUPt0jCpx7UTZTwoGHBmYF9nR2+WmjWEDj61kmC+fCUMSXf
         r2aQ9/7EP9Aw5RYyuGSgJfLJqtUFLsG2aEah/y8jiCY6kvEM/EsCbtBI7nj2aCedbau2
         cVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ce6F86cRKTz67Ajkee2zf4s1y26Bicd0jY3/sPdb74o=;
        fh=C3IK/uP+rYY9CTb03y02xgBO/WGk5MIhiqPKpUyPme0=;
        b=nI6OwTTAqyj3UfqUJ9wY6lPfB4hrOOdPsZ2cQ3PhAeN71CpMxJeavAo5DSfGVoIzxU
         cit+675EP1V0VQS9RwQkAgpPVjRXWfRADlD0szpvnbFWyQpi+xyY1JgxZ8uesObH9AbY
         KqkivyrO40x+KywS/QsPJfttVdoCJp6D2T3EaIP1c5jkyI+IRQYLQEVWs++/0wmuGgA9
         QnMZiQB071+w9NYQxS7w0nNPUHk17VOwsZkO71KUvku1lUZuIFUluGQuFW7WEquO15zJ
         0GTXj0awMLBIbk2R1DS9bKFBcfqsx0KysA1b9WXR9uUg5sXuQv6zGpgTpTmHVtXPfd8e
         2hmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790354547; x=1790959347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ce6F86cRKTz67Ajkee2zf4s1y26Bicd0jY3/sPdb74o=;
        b=OEVnH4p6Msb7FcjB6T9kPn0aVmGCpGNQnxjved/ywLMaA6AoHJJA8w6hkDW1yyk1Np
         YpDoUYADoAp9oIXwsXM3YrZYFekG/hR69f2eqObUbvZtjysa1DO02LwTI47p0w5MS5Oh
         Lr6HpiZFDSnT91Mt1623C3v89TjJ9Z+NlyxJ1f+LnGm8sye1z8Fg7eXRhUtaeUHn1b2a
         fAA4YOblIrjAsTT/RvBPxGxPhRWU6ivlshS4/8nUpiXxtbMzfHrBTWVBVSuPeMPtcLhZ
         /VmAEoNvffucZFgkRpi7hYlHCo5JCqww8fUnIKl/n/bnxnHusvcOnL4+zoqlCeY+vZyM
         hYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790354547; x=1790959347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ce6F86cRKTz67Ajkee2zf4s1y26Bicd0jY3/sPdb74o=;
        b=iSgtg2hI1bW0WD83s7KVbtFbciyPxir5rgzw/8i/vgK4qADIoV6lAxdzqR7o5MgRR7
         QuR+6Bw8aAdyLtBQ62lJTNXBOciPx0GSnlyuRT7cyY3DjcT7srx4IDXr4p/3PJG2XQfP
         Y85qzA4IStMqVUkmkqSsL8GAIXapTJPe9IYDFzMZVgYPZZAOEXT2OxLSkXMiTua9HZwg
         LNwXB8RmNpNk6X9LzK1eqyAjPrQYwgX+q9alFSWqXlbIUN/A5Vzbh8BDaBuDs7LbvJcJ
         +c71rL7ZLsC2o3Dfr9TMeAvaL65Tc/HJmnyNDW3t0RJ3miSrCmnHB4NSdD+oxBTy9cZy
         Vfsw==
X-Forwarded-Encrypted: i=1; AKwUvBzXst71H3/Ejmb+u2iS80lrc1BidAvn5dCCqGhGETF5ULeC/NVCihKBJr/RkuwAVZcGn/k=@vger.kernel.org
X-Gm-Message-State: AFuF++ley3VVF39ey5ZqtHRSc490uNneZ/QQhOsr9L+L/2y16S7VmC1P
	SR5+TaPjff5J682Y7C98tOJ9jzEE6vtf0ZExfBA+eEEmzMeXJqZZSdH5CJbKA/d5TuEaj+hjV3u
	ddBBApIs1S7q/h8I6FrjLFU9qfAd9aeA=
X-Gm-Gg: AYBFou0LvczDLma8JiEA8sfO9EjMnkREJlDyvAWgkmcwzAXXNAyTF9qugwn7NJiXpRV
	pWwtZ8W1/M1fw8T7P+qem2tY3v66Dhb75PUg2E1/nY9Gk2/0yCGOXj9/kl2ghonzgEJixZg9mXt
	haDKlQPqTFafbfxwRwjsiedLRRWp/fAiT0U3zt6we1hru9CDRDxFr4o/rvDOqtdH3h1rvUbjEBW
	yO1MCaOtCfhKy+OQdHYzvBRJIpAALZ51DEYjWW2a8tsoehrUKRGJuusJP2bUuKKtW0VPAuEvs1D
	iPPQF1+C77iT0hZcVeA9+56psw5ddUkbME7ZC8zd5szign3PkXHJm2VZkY4G5lney2/bQPNjTGN
	41tPpx5x9NThxZxnTrOrX8FUyzapAHDv9laqiL4iTvNg3WaaOolJOYBCFpDkmEHUUuWbIPT2uRe
	OI4C4NYMU3ESzQzHhLoahy0GlR999DcA==
X-Received: by 2002:a05:6a20:4324:b0:3dd:fb34:765c with SMTP id
 adf61e73a8af0-3de0e6f1193mr6042093637.13.1790354547315; Fri, 25 Sep 2026
 09:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ap50kgyenpRrsqln@pks.im> <20260924183523.53201-1-haraldnordgren@gmail.com>
 <0aaab5ec-d488-421f-b99a-330c1a851fb0@app.fastmail.com>
In-Reply-To: <0aaab5ec-d488-421f-b99a-330c1a851fb0@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 25 Sep 2026 12:42:13 -0400
X-Gm-Features: AclHuK-kuRVEOdx7r8f56B7D7tI1dlhNBFNoue-zPvVkji-NQU9cXsFPl-QD27M
Message-ID: <CALnO6CBhWKdHFhGCycCVWrc+3WH7TCNcqy8EzmYxxOhdHvz=Fw@mail.gmail.com>
Subject: Re: What will come after Git 2.56?
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 9:21=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Thu, Sep 24, 2026, at 20:35, Harald Nordgren wrote:

[snip]

> On the other hand, or on the opposite side of the spectrum, a tool that
> can read your configuration and recommend better settings would be more
> difficult to implement but could be easier to get buy-in for. This would
> be the next step up from hardcore Git users and folklore spreading
> through blogs and whatnot, thousands of users setting their version
> controlled (of course!?) global Git config one advice and word of mouth
> at a time. Just a plain old program that reads what you have, makes a
> report on the tiny little part that modern Git practice has an opinion
> on, and recommends the modern alternatives.

"git config upgrade" or something would be pretty nice :)

--=20
D. Ben Knoble
