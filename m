Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E62F6925
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768118036; cv=none; b=mYewRrs7Q/aog/j2tY5BHELGO7LuX003ceKnlLmfa9KUvqWL3EouurWsjoZ4vxKiaK/Ixjxl0IOZE+mMKzHkjwfhb8siPGK3BXtiJkoYnoj/B9Pu9A7z+FB49zQj7SLwW/O+tnn2AuXbbfpEP18yChtuyFj2qS4lUEookI6wCsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768118036; c=relaxed/simple;
	bh=0aclpqZdm/r8tSp8AoKeOhcbPs0UFMzlcGgeBIoZOAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBQ7rFNjKcrQumewdD7G2DpXxSunuoRzZBjgASYVZ/lNBDRGtGircUYjgOCkogS5umkwG6pCTFdag25VWn/5eoshkHz6Jfz4gjDZTFDeLpF3VMBVvF8aOYjB3wQOZpH5XCeChzjBZG7+qp9x2wudHLWvSSbZYVoZ1hHvSonahWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b05daf2e4eso76084eec.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 23:53:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768118034; x=1768722834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKQU5SxMinWGt8okB/CznOf0KY47wNiHzv0yOZrzGDI=;
        b=rU7IDO5gBLoobsJBihI5l7l0PJtIhDG5qe+v8XZPKQZ/JeTV2OQJoCzBxxmqH2RDaa
         9IrqwgThgF+nKIAaO7bkSAnyeGVfmZuDExkkgSmwHMxuMWHjlcMz9bJMEloBki2+ICdI
         cie+b8itxYKxF18XzbpolUAsVG9wokVLy5LMaM3Lr5hVr2sPQpJophPh90FMF/IgWn/w
         WGJ2kKD0WTD3NZ2e4fa20Fl1Hh3DA4dP5ezK35Zbip8xd7rSvSFmbDi4DVdDUFfZLx45
         jJTQ0PGY9YF5ygPL4P3oY/o1JH7xU207y5qgu5uk3Ikpi5PYAbkUUwHW11xoTZetNEbS
         ZuQw==
X-Gm-Message-State: AOJu0YzPWrxD2mYB1jw+yOVYZXGNJminST44vWt+ItIN8D/VYO7a2vcp
	IKiVLGl5Ke+zAjATcL+CSGpYSX15BJp7UdX4hMthU1ydjK278UscDPNa1bNouv6hFDx9qmFszEa
	UJ4TM+ZzM33WbUZ9qTBKNow0vmrWwzwCoPA==
X-Gm-Gg: AY/fxX6A+LR5HLfXG/1WxDPQFK6nuOLG+urZ5iNI4jvWWjHY/GXWTtWWUS+fR80sgbo
	45UaCP9m3PHhZ9DXYsttJGG8AX2jvRtyVEtXK5nC0WiCPQV/A0IPaLozHZwfxHhRVRgB9/ilZxM
	HhgCMV5/Yl+ZvKfo+SNeRBmPr2AdECX5xLGZykshtFkCeOa0nIZw/xnKR+eon1iIxt2szmnzeJg
	FZw4r2dI6QYQzPXV5mtYruBqoVWh3HU6wBIO3QQ/gh2ZERGciLZvMCCoqXOFEyZgeqk0wYnLBVD
	ZB9ypWGt
X-Google-Smtp-Source: AGHT+IGjAFL0RbfIMxw6a6Ha6YeKu1Bi8f0Aez7C4Y+ZdlfoqAQ7JKX3zIjlFygzc5ikFCgyYWH2VR8mgtYufA5fF3A=
X-Received: by 2002:a05:7300:5505:b0:2ae:5d59:3ef6 with SMTP id
 5a478bee46e88-2b17d350045mr5688831eec.9.1768118033854; Sat, 10 Jan 2026
 23:53:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111072950.9463-1-deveshigurgaon@gmail.com> <20260111072950.9463-2-deveshigurgaon@gmail.com>
In-Reply-To: <20260111072950.9463-2-deveshigurgaon@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 11 Jan 2026 02:53:37 -0500
X-Gm-Features: AZwV_QgehDhX2B8k2dpRcuTj-JLkBeANoe75VRqVga-WWEphFdnLgS7FqsLYZvk
Message-ID: <CAPig+cQgF2yHL40OnOB=SWMHCv+z0hLTAwTD8q18-DGPHO48cg@mail.gmail.com>
Subject: Re: [PATCH 1/2] t5403:introduce check_post_checkout helper function
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 2:30=E2=80=AFAM Deveshi Dwivedi
<deveshigurgaon@gmail.com> wrote:
> The test file repeatedly uses the same four-line pattern to validate
> post-checkout hook arguments: read the args file, then test each of
> the three values individually.
>
> Introduce a check_post_checkout helper function that encapsulates this
> pattern. This patch does not change test behavior; it prepares the
> code for improvement in the next step.
>
> Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
> ---
> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.s=
h
> @@ -9,6 +9,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +# Helper function to check post-checkout hook arguments
> +check_post_checkout () {
> +       test "$#" =3D 4 || BUG "check_post_checkout takes 4 args"
> +       read old new flag <"$1" &&
> +       test "$old" =3D "$2" && test "$new" =3D "$3" && test "$flag" =3D =
"$4"
> +}

Rather than forcing people to read the function body to divine the
purpose of the four arguments, the function comment should spell out
their meaning. See the many "Usage:" comments in
t/test-lib-functions.sh for examples of how to write more useful
function documentation.
