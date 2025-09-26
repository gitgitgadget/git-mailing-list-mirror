Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B134BA4D
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758908479; cv=none; b=ELKBnFGEMXZbuxrbxliMXaKzF5EskkY0QJf19ElqrCeZCs+C5wT7FfuebQsF29txMR6hIucKErLsP9D2QXCH+yPIINVCj1vt393i5O2kCR+4rwPk+/fwCJyZQrX+C9mWpnxiRDZptSQ1zFMEw5xClYCyY+24mch97RzuYDs2NDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758908479; c=relaxed/simple;
	bh=lFOp5gRGDkVkpuuX3bp5/BTJJ2frNO54LFjElH90FlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5+sgso4zBYyOLO4T1u1G+0qAwKOQjGRD2zGyO5gcWbj+Z1kjzewvUN3RdC5ZZpr4yisVLbW/J8M0zJqchje/7fqwwG/bNyRZhIIP7OiUM6SIDGizNO8xp344gnN1Axah+xQGb+fiyrh2HpI2j1u9CaBvsmdkjJsi8F7IurqZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-79523f3f925so3434796d6.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 10:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758908476; x=1759513276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MXMGF/sqy1hL8B0CVPsnJ+VJJ/5tsYNzkGtQqYPz2w=;
        b=wMaz4AhS+cF9XBZ6j7BrByxE21HF+acSLx8DfjcORCl/lJOj/FhKTse6Tls8x6aKXs
         Z8KPK2TAKx8pzMYDZxKmIHxLBL5Rc4pykfeN+7pFIe410pja1P+2+vyEbjElabEMpc4g
         59z/jE83iUTQU2FB04dZMH6O8H3WEKLa4V5f0B2+VRaCQZEUosh2ZK4hkYrYCMzKRRDM
         2i+BtrYWNpa+hWdoksvexJg2iQQTOBnxLfgX5sWjRZR+EmQakbB5avRBx6Cpp4QZ//3J
         wpHwRBKLN4dyeRll++pk0XiuYfRj6zwj9ARCx7Zl8J99cNGGdNsITl53gMfGVzYfFOSF
         HXwg==
X-Forwarded-Encrypted: i=1; AJvYcCXnkcjGiyOrQFJvMypWFGhcEJgD37mWxJ4gY1aJ7as0oqTACBMPHi/jEWWKCdKh5kaHEAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+GnXNwJNcCfWmyjtAiADDJfQLV/Oco1vz4wn5x38sxkS4T7hr
	8uT3rdseVO6tr+t0ZNsqeubzBDTdLBTZLo3i/iN/wsDQEayDF5JGcDr03z+oI9nqIuUPPMpCX+c
	LLhGjintQoZdeLTpw/NhgiNBItVv9crw=
X-Gm-Gg: ASbGncvv2sCozFJPY+uT21JHaXwI8cx5NYFIacLNfTgwXJ0kPSPcO6x4yBIrfzZxEo8
	+NUKsj+ngzcsnvEpWJvpdGzi/izdP9PKDqGlDriXY94oJwA9cBo5GcHUKhCInJQe2h0TGVfHFbi
	gKmsZDWaeJ/MAOo4dy5BwJpy20h1U0sbCvhnzhGzPNf3ik2TYTw5De4CAcPspYzPL+dIOs8SIus
	IGt/g==
X-Google-Smtp-Source: AGHT+IHTlXUKcBOmhX3XRjlmX4qwnHwzqSjfNdgHOdsrse8RUwvhvcNfWIaazeli6ZKutzsmamcHpkXsjt9GvNJ56CI=
X-Received: by 2002:a05:6214:2a4e:b0:794:3dd3:a98f with SMTP id
 6a1803df08f44-7fc2678d689mr78457526d6.1.1758908476109; Fri, 26 Sep 2025
 10:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5cbb5c0a-4c51-4d15-816d-6d7d4fdf4fe1@gmail.com>
 <1f78a660-3c1b-7aea-5b3e-945ec2b1ad80@gmx.de> <f3a051ef-328c-4778-9c78-33d52d273479@gmail.com>
In-Reply-To: <f3a051ef-328c-4778-9c78-33d52d273479@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 26 Sep 2025 13:41:05 -0400
X-Gm-Features: AS18NWCZHWSL3UB0Ru3B5PosFF2UeYzOD8GgesI7y1ApRxL3NE029XttGyfi9R8
Message-ID: <CAPig+cTOeCWGeNHvnBK8v2UyAV2DRs8QW7DMHGkfRHW3vSTgQA@mail.gmail.com>
Subject: Re: git merge --no-ff failure
To: Nikolay.Shustov@gmail.com
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 10:03=E2=80=AFAM Nikolay Shustov
<nikolay.shustov@gmail.com> wrote:
> Now thinking about it, the only quirk I that I did not mention was:
> Our p4 depot, unfortunately, has some files which names end with dot
> (.). E.g. "/somehing/blah."
> Naturally, (a known thing) git p4 on Windows created "/somehing/blah"
> for it and then showed  "/something/blah." removed and "/somehing/blah"
> as untracked. I renamed "/somehing/blah" to "/somehing/blah." manually
> to calm down its double personality :-)
> (BTW, I think git on Windows could be doing a better job about such files=
)
>
> But the other git p4 repo I created from another p4 depot, where merge
> --no-ff works fine, does not have such files.
> This is the only thing I could think about may be a bit... unusual.
>
> I can try to experiment with that if you think this could be relevant.

That's almost certainly the issue. Microsoft documentation[*] does state:

    Do not end a file or directory name with a space or a period.
    Although the underlying file system may support such names, the
    Windows shell and user interface does not.

And, indeed, functions such as open(), fopen(), etc. which Git calls
return an error on Windows when presented with a filename which ends
in a period.

[*]: https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file
