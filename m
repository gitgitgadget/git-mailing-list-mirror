Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7571DA62E
	for <git@vger.kernel.org>; Sat, 16 May 2026 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778935946; cv=pass; b=dYcjnJtiM7A/mM8ryc51Z6mL/TnrZyorlyb5Ft0hPNmtT9tr9xJSv2+L4HPkKsRwUnueDyOPfGj++duMIkhqnCgBykKNF1Opxw6+jdwcMIUDniC9pgKPTqqP72SVxtX/ZlNYT1sY6hW9xxv/nzJVLzqJTE9b48vVVLnZ7WCnVGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778935946; c=relaxed/simple;
	bh=oVFX8OnnZSJBZW5vF9q8zXST57e6fBYliRKh/jjGVX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMDVTolArU/OLqYVnNMkr8GS9L7J6HwCTmnnDQqg14H94v4gxfc49meo2arL2zQ7w0KMPjoPrOtCphnST9UAq1ax0LA7gMR4ahGOtYSyeFuvte1R7isTnXiDaCYZvBO9ubBbx6IbGsgGwFS+BWevbgZYCtywRE9ji0iRDxlI8fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht56c8RE; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht56c8RE"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bcb5370bb0dso193089166b.1
        for <git@vger.kernel.org>; Sat, 16 May 2026 05:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778935943; cv=none;
        d=google.com; s=arc-20240605;
        b=kdq0u1j/8lGYoy3FpP4FvpMYGnmXarRWr5If+SQDhYbD8cezy6jbOVBiMnzwVTiFnK
         WIHNDhD4/CSPh3y8JXWpsdEVgHYEgEEl0JcfFFnXGama7O7SIhlZKh0WuWu67xqlH4MN
         AHWeOiOtW6eR/+52lcTwmvgl4bDRV624kfUf9XZwndOLZLAb5/Ti+EXvphv0s089qTSj
         /XFgi845R2sxxwbCXYtMtoHBnOF2cExTC4wpSkCz3cxbuV+rf8yOaiSZYiyOcAWMz/iN
         kPbBH27C3dpQBAHX3jV1frkEggtqosVE/b6D24+bJzFQa8KGElk1r5589d5/uC5KPdaa
         DsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+fpr5Rs/1qCZ3VXVnX6jWN/smc93YcxPhVVxsCOgkl4=;
        fh=MFOqSeyKRFksBHMBcfXNrl7TVMYaTwbxCIkUG3d5OAo=;
        b=Pz+v/stASnRcJwA9N617BNhbUcg6vOZu0Kvd74eJq1k5UyZgGmwAbC9DP4NAigHJNN
         X9LaGrgUdbooJbGu9q+6VIoARq4o40EQmFsOCN3PB0/AMqzNLN1w3D0L3fX9W9blfg6V
         Ty63C/VwNmUVTg91P+CGsEdZn6o5AzeeDMp908KweJfs8kesUWH1PUidZtKGsvOXHoH9
         kbRDQ1md/of2DfPhcOOIAJxc7OKlqaEP63DSi8ERBNDAiOAmSCulZnwz6pHCm3+K2NIE
         PWusY41JF2kBqGGFHjiaBGM2+5cfJQDJPAbUbcNqRX08u0RBDKAeZNKB0/kCBTK4LIB+
         YHaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778935943; x=1779540743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+fpr5Rs/1qCZ3VXVnX6jWN/smc93YcxPhVVxsCOgkl4=;
        b=Ht56c8RE6Ap0S/AwnWLcqdCLrikhDdL4+E8eN84wThU3HnI9DeEoiS+GV7B2cLtdsi
         ywm/D6H2en3KlMGEJ6Zw73rshVI7/Mf7q4x3y8XbaEi1CfMFK70hpgg+SDu4a8eaF7IN
         HkvL3i9F0bQoZrJCbHkgIRRiqmm/C3yF3ROO5wKf8nsnq0zX6H4TfTI3+zzUMhGpivJD
         qwD7GHHmOx4ovYzUW/mvb7BUVoDp2X1y/zVLwQN7OoJ3gs1+uJg6sgS+aMY7f1/3udnb
         ZOoD1WSbP9bdzdUJ+GaUufIvjm0Sh8Sif8NJySEf0ZJ2VnkOeNGY50c4axJ7oEKxdTiz
         xa5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778935943; x=1779540743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fpr5Rs/1qCZ3VXVnX6jWN/smc93YcxPhVVxsCOgkl4=;
        b=iNPqV934NmXmwXEQmtlFgEza7CECMeeunyIaKUi8/00QPmi39bz4Ly+jdmxPRvYYiY
         cUtrAOnIg/MlpdcM4l3BmZDBz2c6IgIs9sxmwWEP/F3pw3/PLQvAK36PN4S/bnnqyNfk
         ZHYNtKlfsCSUQ/1/YEFQmT6v5iPWfGuTHvc4wxFn09gt4qa5QfQw4+YhFa2qpsVmSnMA
         6kS6ORAiDEqiBp0lrErIfFikdUZe9VMRjjFAwvCCYjssQHeDPNh5Py2we1rwxtBtEviF
         vylxYGNxl2g/YD4nInCG5QFp7cRK+CCkCVj02KKfvae7MHYkzTUG3YlTESiQmj7DNFUw
         UG0w==
X-Forwarded-Encrypted: i=1; AFNElJ/ciwUqaJ+zYorkeYdHvukWyoWK5YOHIohDpcqjuHwWz5KuPK4Pt/MdlKH3vyKOSkWHnDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YznjAaWgtwkf0gkqLWl1i55OTweByw0rNYsQoIyG6ZWYzKFq4XP
	WfTCsh9yZhzkLlvr5QvF3lbVFBZzwHKsS0zBkqMqQrYrsRXtWqosZK5rRJRIbqZ7o3ddq3mTTt9
	ERJmQa8ixvX8p8GjWlvvbne2iWPyDo+E=
X-Gm-Gg: Acq92OHIpZrS+d5tVJv0miSKyGIzmIF7MqmmUSv20yyPHK39VoKNglwNz1D+ytxsIIT
	wEkIBsyaZloOiiXPNHkZwsfNK1wqNEJj3YhGpGFwMRpOvzMskL9q8VMmhvB0Y84tej9pd9zZ6cL
	qtQAY68dTOg8B4hhD5RCmjNFNXql/2ZIPXxu+0jidAdsgqTeRP9n8JwPda1pK/OuxEvHDxhrh2V
	oa/5ns5zgNBmP2Jo5P9x7Wge7zx0EG6vC12p42x1b4ioEkdQUAxnQ81tvaqZyee0Dw8xGnhLG6o
	nmHowhT7vV5TBILsVA==
X-Received: by 2002:a17:907:c291:b0:bcd:be80:63b8 with SMTP id
 a640c23a62f3a-bd517ad60b0mr465788366b.44.1778935943315; Sat, 16 May 2026
 05:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2302.git.git.1778680725459.gitgitgadget@gmail.com> <xmqqqzndel8c.fsf@gitster.g>
In-Reply-To: <xmqqqzndel8c.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 16 May 2026 14:51:46 +0200
X-Gm-Features: AVHnY4JagSB8uFTT8oqndtqANnClIVPbZI9iJA-smhkzeoTUTA3ZzRlT5sIGsGI
Message-ID: <CAHwyqnWC5z5ioxOFew-kV_8tA-eO_o7KvmM4XzNBu8VCtpx+uQ@mail.gmail.com>
Subject: Re: [PATCH] config: suggest the correct form when key contains "="
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> And I think git_config_parse_key() is at a way too low level to tell
> in what context we are seeing this faulty key to guess end-user's
> intention to limit our "did you mean?"
>
> I also wonder if, given that "=" in anywhere other than three-level
> names, is invalid, we should just start accept
>
>         git config foo.bar=baz
>         git config set foo.bar=baz
>
> and interpret them as
>
>         git config set foo.bar baz

I tried implementing a version to be more liberal in what to accept, but
the implementation became very complex.

Moving in the other direction: show the warning, but try to make it more
correct.

(Also switching over to replying to emails with Gmail with 'plain text
mode'), hopefully there will be less miss-sends that end up on the wrong
topic from now on.)


Harald
