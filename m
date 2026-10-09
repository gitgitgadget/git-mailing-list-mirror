Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900484E532E
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559668; cv=pass; b=Z6lN7s475k+8RTzoiy0KRj0VxahFj8xopDr7sbjTEckR1WgR/oBvtEFURua9rZt9fuoUYigRpmGaR5j/nWQVU8y5QLeGGPRF1jx0N6V2tHUrBUjaFdhBS6vQ3a9SvIc2OzD3/H0bhMmcusGzMUquh5GiLxEV/3w/byODfCC2Hhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559668; c=relaxed/simple;
	bh=rxzE6SRUMhLWr3uN/WXfMImBHutSlZU07rKx4qhjVeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJFUix62A420HaH32bIbWbvDgqKIdn5dMwk1LejE7L9w7AI1E5UDI5rp6IRzmrzVlduiUA0+9Dam4q8zSl27DCbqr1s8WR4/f9NirMF6FgXZrRsZiVwhlPfCDdkfZWQsNlUYcsc3cxqrSa/oxpMJqtYAkG5hgBYe6uQeX56bAUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3Vz7O6p; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3Vz7O6p"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso7721455a12.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 08:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791559666; cv=none;
        d=google.com; s=arc-20260327;
        b=SJ90zVM1qdA1loBp7JEoOzfsyIyB+Tobb6S+IvdvlFqMAnCXzkDeJ/ezN5tGuKD+OW
         o6Tvi+Uy6yys0a5kN5QftSuM1MAdGwDOBa6z07qGvRv/nvkoErT22TMrI3bstezlNhUn
         614dkUDDflUK9BYzoz3s6W33WDr9K4RaNnBilgHBFy2zMw5nPj/ed46aHW5anR68nFGR
         zWbpLrO5TfRCLS+ZwK+4aMO34y/Ts3Fu431qBDmnpNbnl7+Fz9AUHG67X2MNIOJDU/j5
         NrQSm6v/shBInWtzOIS6sWgqfxB7PGeMIo8M4Mn697M0XXwI5n1I8/0MRnaWpuyM6aZP
         7UFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rxzE6SRUMhLWr3uN/WXfMImBHutSlZU07rKx4qhjVeA=;
        fh=qSGrFopHrnCfN9BF2nFMtMz5TNy4r0ggqQoBU6VV0hA=;
        b=XXDvFxY17PPg6Adh+EGXX3SRAEoAIZAQsrUSPd30X38aZ3Qc4Y1CvP4uAH7mTdIM9P
         KzPGH+w3iDUR8NFXhCuD15Uml+CaW2A/tEMZHjKR8lrcXHIrw4Bix9JYAt6D60KGIEQf
         w7azic3vQTukb5SvsW8rWh0g9dFIykxo6LwYec6llH1dWLVG1yURZp2JcOl8YEpXSD3Y
         3geIsvXfCOd+kzFEFwTqOPmF6mVBUVSPKiUTaa8Zno++Y0I0D+W9/DgEel3lMqrGpuj/
         7yIVwrfwPdGLGMfLkQfShCfWrPA5QuZrEjxvH9mKkeSdIS/QkSYXAgvnYUQBGp0G9gJX
         QiKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791559666; x=1792164466; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rxzE6SRUMhLWr3uN/WXfMImBHutSlZU07rKx4qhjVeA=;
        b=r3Vz7O6p0YAaRRlwEeMA6nZYnb3z0lUbNA3n/DdfrlGMufAicRJdta2b0xu1gxN6V9
         c46N/pfrnNodjcZB1QB0yc+dtGBCULH4/wUohe+VlzhIpZpNl12FQx5GhyNYC9ixishF
         zeJPTMfsubM36d1zXA72cmrZO1bJAZKHTnIF6OsDFmRr1Wdn3lFvcZGvh4/0xqsW2J9l
         6aXibw8u3UMK5MLETK1erNZcmYFnlINEEKjwoCvJ1WoCZsMjsKh5hhov1wGSIRx3LctW
         EaIIspyFaeGu4lKWUfCoE5mHmDozo/S8MNEdfXO1mtoYEKJL0P7PLlLeNubFBfqwWLBu
         6k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791559666; x=1792164466;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rxzE6SRUMhLWr3uN/WXfMImBHutSlZU07rKx4qhjVeA=;
        b=l7P6MkF/KzSi85myPTGcaIbSifhstEf3zgqln2K+NJoUi5vjIFMSJMu9cM0vktcX0b
         PDL1uFPMcWC1JcwTlBMORNb7Y2zYx94d1csnhMhtbb/gREV/dkwGrvgAXW3wX4bFe5Hv
         7ELozsYtdGweDc87AKLEtvwugmpCAqlzzYX5BuHwV/aSB3Ypf9DV35br44qdfWPcoSD2
         3dSTIGNnXjsXuZ6RSIp+PJbgCsb59mNN+quc466oraaWTpZyiQ0rvpukdRXLHoJb6oJ3
         JxBKKAp//HPoZtDDpljqjQwNdoufPEVxS6U/f3eJFR6Qt/6EBl/bPnrTmz07YYHx48Ld
         pG8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxfioroE+yRtmIW2cfzXTU/dUQ26HUVIKXmycGYju4fHqclMxjDlSc2jf/nWWqiwiRg5Vk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDUhOzOJWH1sQOTXEH1uPkop5VHlzkF0Mw1KdlUgc7yMVfvLeR
	vqHx9gStE20nSzQR0MmyTHLIDSJm9qtoWmNg9oyaQqtWn04ZtU5bktyCMxaJB8ufh1ycx0ULyuT
	lJLVgEUWJtHb7PMh3yg2cAXRpVCBP9PY=
X-Gm-Gg: AYBFou3KMewKH8z63kA/aFvEV/eU5G92I1iBgVSOHw/5yhQSNXfm1eu6zRxT2t1MQEK
	D6klXI03iOg+BCZ8UlkZDiO27R+a1LUXwl8IGakUlfgaBcH37bq6PlnQdoRjzesivQw80F9QIpS
	+hG5PpRyE5r/b6VewOXcfS0rhzD3CqJpB2j9Vf8foAj48Hj8q9UiXcw+RiF+Ax/fTQDRhy4KiX5
	vGjEhae1CTUkdEJANbf5BxENKtH3t+rwYJOJwkEldc7WacklgGwKAIPoyKImrDr3Fdzt5/eD8X4
	STNXa+lWVPfOA/t41rocssWgLRMT0oX4aqV8y3k3S+XBYTbwK2TCPWieoGdIT9QzcA==
X-Received: by 2002:a05:6402:1f44:b0:6a9:93c7:ca57 with SMTP id
 4fb4d7f45d1cf-6b17c29942emr2150052a12.22.1791559665687; Fri, 09 Oct 2026
 08:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
 <39a28064-1698-4971-a80f-4a4c4dcdd8d9@gmail.com> <CAHwyqnVoMnO_fYGJ0N29bQv=Lh5naZ0jc5uSpiS2urQMZVG5-Q@mail.gmail.com>
 <61ae371a-225c-4400-b878-8547547d1269@gmail.com> <CAHwyqnWkTvicU+U99j0MzzUUXeVnUj=FJJwUDR1F7DGk1hmtrA@mail.gmail.com>
 <500a1b40-b877-4970-b279-f0a6fb42f810@gmail.com>
In-Reply-To: <500a1b40-b877-4970-b279-f0a6fb42f810@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 9 Oct 2026 17:27:08 +0200
X-Gm-Features: AclHuK9e-h8X0t9w0GbEMC-DCQUtqyODiLEOQIJcDkB1G2QcVR4r_b2ZC1cvQSE
Message-ID: <CAHwyqnWEXd4e+wA_tVoQPmmY2ZoH+W7u65QQ2Y=PTMGUWuGvZQ@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: phillip.wood@dunelm.org.uk
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I've not really though much about shallow clones, but for partial clones
> I think it is perfectly reasonable to go and fetch the blobs we need to
> calculate the patch ids and warn in the documentation that it can be slow.

Would you say the blobless case should be handled now, or can be left
as a follow-up topic?


Harald
