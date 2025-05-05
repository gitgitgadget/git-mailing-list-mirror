Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D023F14D283
	for <git@vger.kernel.org>; Mon,  5 May 2025 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746439915; cv=none; b=Ww1l5pP3vLFbGz8vniCcBJSd8hfZ4bxsPO39cDVHxg+cHRWwqGOLcum8HOw2hJq4BftBmsTXRGhoMvnIEsB33DN8Yf0db3Lka5jQLdaLwND5dIL8sIcrB4pQJedf7/Ymijjv3sxGOLAjuib+Sx1W5L+7bdtpecznJ2Tf8Wz19c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746439915; c=relaxed/simple;
	bh=Ks9rrLHD1bv7y6t57YpWq+sqkkDnSQDsnEn6JpUQcNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9gMtPTQbn1DzTgvTHuFY46oJMTu1TRwRIVbmuEzsVwtC9KTyh1C0q0lb2niEadFWj2TiiY96C4doiI0I8cD90hNgZhSlW2SWhkO1bJ3cDMGmfiwwtDACee8i9jg5yo7M2c8IFNufrvCNphSrSUMi8J2Q5tWN/wZmkMvjrmFWQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wbq+hyzx; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wbq+hyzx"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54e9021d2b5so6640557e87.1
        for <git@vger.kernel.org>; Mon, 05 May 2025 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746439911; x=1747044711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnsSKblk4KEdWrM4D7+xzPAlJTqjoM455K9LpOdEhfo=;
        b=Wbq+hyzx4WMj2OZxDZHoOX32z+HIDnHCrpBT0gI3T7PakjcUzVTjnRB8JG/iyLPTBL
         AFfzZ1hf9j7CdZI/gUBQDe+r/Ot4v+nnh/SV/Yhi9Gp+CIbkw5Vi3GVJzVEEClqd2nys
         h6rLhC45i2NmXfIJcGWcsQDvN1PGdBzCj3Nh1FyofWfFpVIuGGo6QsulEDOPExO2V9Gg
         ZRa+zj4sdQ2/SYiAzNOqggRHbwYKzMU1b6K1e5Wal+w1y1APaeWwFqksszeLgevbscJp
         2rrDHr8GI4MujRZLVWaJNdgZYbCgLV4nCm5xAppLED9akqaG4MXHBVzsdXfUypEfe3Yg
         hUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746439911; x=1747044711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnsSKblk4KEdWrM4D7+xzPAlJTqjoM455K9LpOdEhfo=;
        b=Rz5PPdFhagZjr+vhwx5noQ2Tio6RFvCpdeLHVmtKKQhyZBE8pGhpwVPrXXvjgbzhlz
         PKCIrm7arxbRX0Gj7z8/UIVmR3FNmB+PtK+J4bN4Zz7jkzGZ7l4uzqehtgMO+vmn0NKU
         qoJwel6h7wbrMX7FHByXBUV94HGpkyHAhnxKGfnP+mX87Tv/bsDLSYalhruDzOC8pWBG
         apESfMPSJXLiRNdrXIi6a6KeVn/axjRR/YSHAtAQJpvfu4YJ06tYjRZhfNlzjEhEjbJA
         RqpYow6t8OuTvJ8KG3AlP1XevrY2VX3LnKpfqgoqKBMV7p2S7AnutzB3gIQfI7dC/8Yx
         tE2A==
X-Forwarded-Encrypted: i=1; AJvYcCV65eTLGDfWLHe0/sjiqGe9zq6UmUfYWnGpYC7QqNmJEtiXMPUR06B4aIRsil2y5pB9Z+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4SThrT0dHRxO9+Ic6YeHU5v4gkweT5NkQ8WRKuZzQN1xJv2AH
	qjpdEPTzZZ+c/wE4TZ5kZYhwvLCQofa5ctm0kxasjWfHPiBOhKKO3Ln0PJk8xMp+TIh0vAIKTMj
	aIz+v7bRXV68GJDGUaCYeMmlRYDE=
X-Gm-Gg: ASbGnct0peWnXp151OVp9e0ECk1pc/Z6qdn/orRX4wjKCVXOUH84wrTkwLY93sk0qhn
	o803uKTly4BiK2F1qNpzvtEp6GU6bL11d1UHTVUq5MijNnfeZbKQx8KPnQtqHz6rxbzeiPN5U5l
	Gq8WIiJN6cEEqeCorB+rexDMhL2ZKHuE2X257WSNCSdM4ddbq/iZEH
X-Google-Smtp-Source: AGHT+IFzCdzejD7hwQVP66bEfeYCH80ZL4r1i9BlLVq3+KglV4wlzwv1vehKKpk0ROjy4SGOvVpyYaONyHvH/BvIR6k=
X-Received: by 2002:a05:6512:1385:b0:54e:784e:541 with SMTP id
 2adb3069b0e04-54ea7a5178dmr4137092e87.14.1746439910742; Mon, 05 May 2025
 03:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <7700eb173e73bb240852dc1c7ce26f3d1f95d8ca.1746436719.git.gitgitgadget@gmail.com>
 <d2dedbd7-6797-4f1d-a0b2-243f9bef57f2@app.fastmail.com> <CAP9jKjHj7WP91aKA9SE94zYj+naBGLUs99mF3G4BhTGcGjFDUQ@mail.gmail.com>
In-Reply-To: <CAP9jKjHj7WP91aKA9SE94zYj+naBGLUs99mF3G4BhTGcGjFDUQ@mail.gmail.com>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Mon, 5 May 2025 11:11:39 +0100
X-Gm-Features: ATxdqUGW4y6pOvw37YokSVPJZIClcU8cSIiZMaQuWrMxrJsgFqDTCETmGwZozgo
Message-ID: <CAP9jKjHQtC1oCvGEeXVBX4Qfoot9s8YdC5hdufy+WnYT0xcj-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] add-patch: add diff.context command line overrides
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks! Part of me did wonder if the reference would be updated when
merging, but I can see now the correct way to approach this.

This being my first ever contribution, I hope I am at least a little
forgiven for any mistakes, which of course I'm more than happy to
correct and learn from.

On Mon, 5 May 2025 at 11:08, Leon Michalak <leonmichalak6@gmail.com> wrote:
>
> Thanks! Part of me did wonder if the reference would be updated when merg=
ing, but I can see now the correct way to approach this.
>
> This being my first ever contribution, I hope I am at least a little forg=
iven for any mistakes, which of course I can correct :)
>
>
> On Mon, 5 May 2025, 10:50 Kristoffer Haugsbakk, <kristofferhaugsbakk@fast=
mail.com> wrote:
>>
>> On Mon, May 5, 2025, at 11:18, Leon Michalak via GitGitGadget wrote:
>> > From: Leon Michalak <leonmichalak6@gmail.com>
>> >
>> > This patch compliments `8b91eef812`, where builtins that accept
>> > `--patch` options now respect `diff.context` and `diff.interHunkContex=
t`
>> > file configurations.
>>
>> 8b91eef812 is patch 1.  This hash will change once the patches have been
>> imported via git-am(1).  So it won=E2=80=99t make sense when these patch=
es land
>> as commits.
>>
>> I think the usual approach is to refer to a previous commit in the
>> series as =E2=80=9Cin a previous commit we...=E2=80=9D.  Or maybe =E2=80=
=9Cin the previous
>> commit=E2=80=9D for this patch and =E2=80=9Ctwo commits ago=E2=80=9D for=
 patch 3.
>>
>> For commits that are in the stable history (like `master`) the
>> convention is to use:
>>
>>     git show -s --pretty=3Dreference <commit>
>>
>> Without backticks (`).  See SubmittingPatches, commit-reference.
