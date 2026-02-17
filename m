Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73D120296E
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771290587; cv=pass; b=EXZek/fIL9ot0dsrOjdRRN07Ti2PIueOtT9P2OKrsTV20TzOBxRie+3UjVq/+eDBeSFPokzVxycV1DZjxvWx6RJvQuhlqbgx8kBqEbBxv/VgqsSbu9mstdAlFeGu02Q2rJJN1LM7F+WA/gZuFSFYRFEGQ3sXmKFBZwhwXzgUVzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771290587; c=relaxed/simple;
	bh=DX/hT8PgBbn5hksVsR8dGOVTYEW2rizOIMcSiFPUZu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCg+QCzBXmT33aBhMWCJvMZR+X/Ufivxueju16kE8Lmo158NL9kwjgHbLP18SX4+10/dG9PEmGMn4SRv5ybjgqkN3N97lMFeg13uZ8EOzqWp8RZ1AfOmup/c+KPx8wjWLJ1hNF6LLTfL4vY2Up2zt00eYLm8hWO5l/P/RBAlayU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=mE2SphUV; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="mE2SphUV"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1270ac5d3efso3386235c88.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 17:09:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771290585; cv=none;
        d=google.com; s=arc-20240605;
        b=dJIdebkoDl7OdkuXGRcfMMbC4rbAwxFIvrde9Jj5Bf7K2Wonu8PbWuJrfcbuSA7rW6
         vS0T17nyQbT7IGCIW87UITkynsX/A/DnIL+Frqk44FrLCuM4EZNcTMDP3rFiPMD6APVk
         wa+8WkfSa0wRuEAJUdxSs5wv4h0MruYFhwdErDlNqLE1Cxo4ozcVGwfg6N9MN01nQCRh
         9LmQcAm14tOVoqLG/QCV1v8edQlm0fnkJdzEGmm+bjnPExxd4tD29JF1UIwWRtVne0vB
         7bILCU7pcQRR7E0akr4R37Cu9/043u1zubYKRkfHWeJ/B8E/CoC7DOJCWtZCA31tg52+
         j0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VhTbyuGVsHOOJTGQ4R5dZlOIQtj820rgggl5IomRONs=;
        fh=lFo9VNeAkXsfE3hnlvA0u1CYRlOBQufFg5Oh8d8xMNo=;
        b=CTcAfYygPRMGrX3HYYzkh4bELI861hKhfTbjw/Kr5AvmKDAsbeYeABd8Ki9+EYMcS2
         jouf5oGymTlr40FmPZhQ8xiWrWCUzLBz+nIlSyIKituSXU0c/Ahuc3huhJrgzCM7R4MB
         ytqq0E1EIshxWL1hVu76XAoQ5pt0a3d0J1+Hf+gIW2Rz/GLPGVEQZEsg+suUazCNE3wu
         nYpY/crt6ybCLB278U8bZe0pylzCLNRMdIKEbau6zkYGNTmfnCVvWYmZRexoTK5n8L5w
         XDFcm2kw7Ip2CPU+URAQHbyF+BO+kqbK1vpfVr046/J0HqcLwHVawN9zAwsGJ5qPMCTA
         9PlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1771290585; x=1771895385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhTbyuGVsHOOJTGQ4R5dZlOIQtj820rgggl5IomRONs=;
        b=mE2SphUVYmy8DxIioX4DXvcTJ3yXpMPSBLARfs9DzSjSSZWQ2YdInYXHA98irxdWgM
         Hr9gX5tW/O/6GClNKF0c7AqkS7VTRaoKMPRgK83cPNX045iowai47KrcBk1pr/HDK/To
         KvRNz1jZILVxmYHEImuwkcV6ADsXCTlT/0NYQh6Xk5t2wEWX9Fl8usEZscJwTWWxLwRS
         XuJHJsJl+o+sYL1Iq9kYAVQ3xon8G+QFtDALAl5Xh44/FC/tZluHruCRL3KggVvzQj/k
         xHQJ8+B+0dyKx3YnOyir2fsg9nEilZIyjYxXMTgmM+yDSbp0MNgNPccFrypLhCAbp7+D
         XyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771290585; x=1771895385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhTbyuGVsHOOJTGQ4R5dZlOIQtj820rgggl5IomRONs=;
        b=OrvNkxDNRJBJArakCq+g/Ilpw4+7ONbi2HJkQnrkRzaJtQaAEED74rerSYBsuZLMPj
         92ZYZe6UbRnp243/+qKfJj6c+zB4sfybKnbrSTXsGBkNnMDL5yZtyPRTxye4cM920YbE
         OfcEsV8qD0QiY4DznypC6lK1oiXc2rnjQT3oc91Sp47COnVqg4h1InagSHOdmXlI52yO
         iznKkVIHkmxX06SuI+E2lsGOHiUPstB0oVf7wHeOfkjcd7Yv6xsywjYshxohVw4pxRvw
         tZj3RxOG9XI/VU15rH9UiN49V8tfBvE47KpyKLhLwR8IY3vBaUA9HdrCLJPBM7jboGn9
         J2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXSvYf5sWabhLz53KmH5lYj9tJozRYYBX6/mAPFztYPbchh9zizQ1uyJvkl8aSX6E5kt3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxKVSCPT+ogNHYnLkAXkUyydYt0ROsZDliy5rVZH8BFVSrVjB3
	U1hoNwHs31SkhEWQN3NsHviCLWQFFocIa0boq+QVrhuE1e3zmjHVJpNCNgtx9EtbJXoLHVQCSal
	XkV6IOXGj894qsRTeG6pLNObRK5Uky8xScWrVDKfkbJkrUuE6JDWydwPz0QUnaL1Xz+nWEU3Hfe
	KxLXT3uQdj4SoWswdJ8u9432Pvya0SNqkPFTXo3cul0ptQpugk+HW3bIqwqHJj/fdf3+GfUFeAr
	J5p6QCst1K4x/+01Hm04G9AkiHAVOMEDNX5gvLB78N5txRDqP6UheJqppv6YhAN6KzqqlFhWia+
	PzC6gV7kiIYsi5I=
X-Gm-Gg: AZuq6aJYzY5Hmb1JO3Zw+++hJ//iufHKwTOM5heBB+J7adl5RCS5swGZsWYK2onxAi2
	mLajtKhSryxvL+zOUVtrR4mmaPNo4k85YOsImJk64qYY892aBTyrnqvG5O6hY2/067ezYxoRU27
	F7oyWdmEh/iJhMiUByxFG1wE197DQwhgYwzrbkzJ09IlXari0Qd1HQ6PDL5FYbgltc3NtH6vIJv
	TwQQwKX/IeREpZ9+oZC0EgJKHCnOa0bjC4OqsCtdj4/J5W1DWnBr1fy4pBSoFj4Vc6krZQ3twwk
	sU/4qR4ZGAsB9GP+6l4=
X-Received: by 2002:a05:7022:698d:b0:123:2d00:1668 with SMTP id
 a92af1059eb24-12741be513bmr4403374c88.49.1771290584800; Mon, 16 Feb 2026
 17:09:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2046.git.1770746461307.gitgitgadget@gmail.com>
 <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com> <xmqqms1fwasx.fsf@gitster.g>
 <CAOTNsDz0ZtdsM8Z2NW0WBMGs8xyWz5ROS6pf8DKQAx26LU4xRA@mail.gmail.com> <CALnO6CARu8HSYh9=z6FAF=84q1qA4Oan7_DLMbcK+1rth8B7cA@mail.gmail.com>
In-Reply-To: <CALnO6CARu8HSYh9=z6FAF=84q1qA4Oan7_DLMbcK+1rth8B7cA@mail.gmail.com>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Tue, 17 Feb 2026 10:09:33 +0900
X-Gm-Features: AaiRm52Eg3swzx2t1oP8w9mJh35I4fZ9-Al3PteUR2urYpdsTVZ9_E15Zk7RpLg
Message-ID: <CAOTNsDwMeszCC6wunkkx_vhKYx9OvRWXB4VxedypOTQJ6Qs2sA@mail.gmail.com>
Subject: Re: [PATCH v2] osxkeychain: define build targets in the top-level Makefile.
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 8:45=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
> ...
>
> Homebrew picked this patch on top of 2.53.0, and on a recent build on
> older macOS I needed to
>
>     mkdir contrib/credential/osxkeychain/.depend
>
> in order to make their build work, since otherwise:
>
>     error: error opening
> 'contrib/credential/osxkeychain/.depend/git-credential-osxkeychain.o.d':
> No such file or directory
>     1 error generated.
>     make[1]: ***
> [contrib/credential/osxkeychain/git-credential-osxkeychain.o] Error 1

I tried to reproduce this using the current Homebrew formula for git [1]
on macOS 15.7.4 and 14.8.4 (both relatively newer) with the following
steps:

  brew tap --force homebrew/core
  cd "$(brew --repository homebrew/core)"
  git checkout -B main origin/main
  git pull
  HOMEBREW_NO_INSTALL_FROM_API=3D1 brew reinstall --build-from-source git

In my environment, the build finished successfully. The patch doesn't
seem to trigger any issues during a local "make" either. How exactly are
you performing your build?

[1] https://github.com/Homebrew/homebrew-core/blob/9ec3da0dcd3ccd1cd4d892a7=
1377b251770212d7/Formula/g/git.rb
