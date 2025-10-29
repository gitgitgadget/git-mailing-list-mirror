Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491A22127A
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768071; cv=none; b=cD0eTfORmsYYci4+zg2oaIkSPc7JZvI2GZFT/LXSQH2fsiAJrIuy6hDj57NP27ahLMBzIcRtz2J5osLJgQdN/bJU5fTr+mE/q5D/in7ZQ8JiPh8RYAVhp62jlvcnjgMBzJi0e5LU9zsGvc8zh8MvseObKDeytOU7z2bE48oVcUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768071; c=relaxed/simple;
	bh=8aNctZyrXdUUMoVcBWkcvmhz1K0S5NA2ftRif3NqyDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fse11wcOA48ZUnZ9FCutv8eY/Q8muhLWM/lU50JhuYEYd7FQw44CuMBaxmSZlI2XTEXaDU/2lIhFonzhcrJoPq4FYcmJzExw/m15bdmgGv/E7OY2fspZPobMk9q07HdlywGyz/d1nFVO5NdnrkNl4bkpjy9OV15jcu9WDY9i000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiF/U0bh; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiF/U0bh"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-591c9934e0cso425628e87.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761768067; x=1762372867; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8aNctZyrXdUUMoVcBWkcvmhz1K0S5NA2ftRif3NqyDE=;
        b=TiF/U0bhV3Nm7L7XACS1mpmg06NCCbriPrkjoPKZjO+qq4V2oo1D+N+kcILe13zP2y
         Yq276/4t1W9Yft09/wdQsZ8vyG/Y+dSVtpWqsOTveED/nw9Bco+s+MDP2mYLLmNde2eW
         jRzM1mlEUFTpcGLGO4eYzxrMONGttDQklY3fSdsQIUOB4a9aO8C6CAyyu02Cr/cXHFTS
         c+9WHgqqPcB+SwFEuiKGEt42UqwagXVIYyST64PGrIg+dXoArgrOZIRiSizvF5XN5Zey
         e6vg/9yUgnZlgUYShyxLIudJzDDRe1ZLSsE4JPck5ZVmCmI94o9+USzBzz+orfIywkOg
         SJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761768067; x=1762372867;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aNctZyrXdUUMoVcBWkcvmhz1K0S5NA2ftRif3NqyDE=;
        b=FwPBHM5o7eIEMm3rPoh6ifgdQArtMyxx8JCNeLBQgxXsQRADdWDdY0UMP8svNjLcgy
         lpzZhEU4Xho5y/bsg5uNkOdiP3OWSLjUbyVeVkUnnTvhYPhhfn+nQuFXdAePUTAZfLoX
         lQp8EoFqCJLArwk6pA5zuZY9NhEx4Ls2NP2eXcxdXIFbTfkmTxHRW4YYt+VbhrcGP/SV
         Tx43dVvPrsYq5VSFc5m8d272g3Xjw3eArG33d0/RSVi0UNLZULNFcvK6iQ4J9azfm46k
         bLm4WGAjaXdAj1AM1tfxBl5jIUAOQnrYK+8dJ5UmRzpJLtO+Yyw77hFCG6uhfis7qUce
         tNxw==
X-Gm-Message-State: AOJu0Yxetptb1FCanF7ZEcxnO7CaIHWCq8/UvP+eHELEw0qi1SjnOuvr
	QcLS6YAi0RI8+aYDUHanpo6wJAA3sbE31Ed6xOt7kdfdM2XJGpp8cdkJDnE7LJiAudXdIrjv2F5
	PvvU/VwZiUCest/a2arTWDViw2I8T1V+c7miH
X-Gm-Gg: ASbGncuAjvTC6vW8ANe98sdd7Tp/ELVk9rdcYLopbalTv+gIDyjGxzLivl1e0ngOFIw
	fmFXfgQcEa5XVvhm62qcwZBNTlrSzXcPDZu4GpaUhpKdRejRxxls8WYn59Myo6MfeIJl27OvGiK
	7pwoD4c/PrcezsI3X53pbUfX8tWmlrOQCL8B2MFnzXJxVCqVmkh2zFyeS0pqZJcOtOFVngS5/BW
	UUNo3P0QP/HRI81oGZnURZIRlHdCK7aRaN8F32btjWjilu8mWDY9NvCpg==
X-Google-Smtp-Source: AGHT+IEIaKD/ofKU54lA0tcbNVECwOsv1G47dd/QPfyZpsZxlYbPL8dEAePUz8HO8Zqkm6u1Darwb0McsFqCKxmL3ic=
X-Received: by 2002:a05:6512:3ba6:b0:591:eccc:6903 with SMTP id
 2adb3069b0e04-594128e7d3cmr1348367e87.54.1761768066903; Wed, 29 Oct 2025
 13:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANM0SV0R7OYJKeBAs5-WY2Wqp7VxhKv5=LQ4cuDd6MaQwNqGNw@mail.gmail.com>
 <CANM0SV3iRF=jVAFj=+rrgOC_nXEJ=_v1bUG88n3T9+PQD=a2-A@mail.gmail.com>
In-Reply-To: <CANM0SV3iRF=jVAFj=+rrgOC_nXEJ=_v1bUG88n3T9+PQD=a2-A@mail.gmail.com>
From: Devste Devste <devstemail@gmail.com>
Date: Wed, 29 Oct 2025 21:00:54 +0100
X-Gm-Features: AWmQ_bkyLW5Tu5vcQ6Im32Vrh7poZEmujQ7hV_YMSTyaNPKelROXzBBTzDyXkyg
Message-ID: <CANM0SV3qgqjWeAu+NvfPxeDLgo6-eRWKmi9xkpUtN6w7LJh7oQ@mail.gmail.com>
Subject: Re: git clean deletes negated pathspec if directory causing data loss
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Anyone?

On Sun, 5 Oct 2025 at 13:33, Devste Devste <devstemail@gmail.com> wrote:
>
> Just to clarify: it's not about the negation not working, but clean
> ignores the pathspec for ignored directories completely. I only want
> to delete .rej and .log files, but it will also delete gitignored
> directories (that may or may not contain any .rej or .log files)
>
> On Sun, 5 Oct 2025 at 13:27, Devste Devste <devstemail@gmail.com> wrote:
> >
> > I am using:
> > git version 2.51.0.windows.1
> >
> > Run:
> > echo .idea/dictionaries >> .gitignore
> > mkdir -p .idea/dictionaries
> > touch .idea/dictionaries/foo.xml
> > git clean -f -f -d -X --dry-run -- ':!/.idea/dictionaries' ':*.rej' ':/*/*.log'
> >
> > Outputs:
> > Would remove .idea/dictionaries/
> >
> > No matter how you specify the pathspec (':!.idea',...) it always wants
> > to delete the .idea/dictionaries directory, even though it does not
> > contain any .rej or .log files and is explicitly set to excluded
