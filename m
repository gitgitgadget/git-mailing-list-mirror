Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89012D0C97
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 04:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775709295; cv=none; b=U47P1tSwebtY7E9i4h0D8Up1nJ8G8McvEuLSs/w56GHoQ+IopZBMlS41HTLKM2pJD2R8upBXmvYvMlwZjhWA+qcu0nxEukzBnb8D6IP9tJkmqM6JX0VfOo3+r/I6GdIB2b6kupRdOqoFKnJVeJD5yxXFcXS9iplopQCCX4MWe50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775709295; c=relaxed/simple;
	bh=iR3ZDLl1hcTnP9EHgTs715OJoJTCq6oGlNpauPUovHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8MYhdQSdxr+L+ZxKHp404xdSSErgsfG6BcvX7V/1M8Oww6kXv7X+nWZ1dnSL0yzTc/rjqr5I36LXqV4S9sJLKYYONHPGGjuB7dCnfI5qtsqKIacAf/sIu1V7qRjsmLQeWv53yXwe4mdVa07B+QGSgOFURCBcC8f5TDzBJ8htBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=QlHwPvjm; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=YJ4fRIdl; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="QlHwPvjm";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="YJ4fRIdl"
DKIM-Signature: a=rsa-sha256; b=QlHwPvjmgh6eyd7+G+2p/iBg+wrpBkePrq+v1jarZt4iTPmzSEn2aenCGWZRy5VdsF82GDqi8x3eDzwkZX6ecJqStcgnPzKJ/2YbXl4No2pP2VkHJVj8XrlZXyuxbqJq0ajq5mhQN4KxQXT/YzfybKD1aZhqiFMO/oXxZgzzO7rdhMsmYYYAXn0OHOgr1Zn674gppDOq0XZrHerIR70AA0SpnKSylC8ajN2CbWAujwvmStFBJe36zk8EqV8Am6KjOWM8c4I2K8xPhwkY5Yahx6BUKSoDhLJh1uBKXQTQjxYiX0Dapp6XenXGZbnYRUHoKcIGI33EliALnq4e0uD29A==; s=purelymail3; d=malon.dev; v=1; bh=iR3ZDLl1hcTnP9EHgTs715OJoJTCq6oGlNpauPUovHI=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=YJ4fRIdlx/lUrr83nEpmobV1wkEahTR9WyT6ZZdNXPI0+YHnCH+wZZUEJvlvsZuH7hrpUkxJ5CSC4UZSTb6L2cbNoFVp10E/0ttSLZlbhSgQwe0aAiPkvpbVTLN+9ojZFzoZB1/SHB0ryL9Iogl+M0N5aGNj5dzMHXiEaR7HbBvGCcP/NUcahu87vyT7hPFIcMJqXZZLwW4IFz0b36jcDL6uFwmIcFc40eY8TCNrAKo76AavtwiVKttQIyn+nj7gh51G68WpTlnkgqk1+ZwQHJ73Xeylf9mzzU/iRqC5qyR1Wt0ePAzBrNibkv8Btcz+E1GMZlB++Sw+o79m5RaDkA==; s=purelymail3; d=purelymail.com; v=1; bh=iR3ZDLl1hcTnP9EHgTs715OJoJTCq6oGlNpauPUovHI=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1701569816;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 09 Apr 2026 04:34:50 +0000 (UTC)
Message-ID: <a6382ad3-6ce4-4e85-bdff-8e90068f25dd@malon.dev>
Date: Thu, 9 Apr 2026 12:34:47 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH] promisor-remote: fix promisor.quiet to use the
 correct repository
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Trieu Huynh <vikingtc4@gmail.com>, git@vger.kernel.org
References: <20260406183041.783800-1-vikingtc4@gmail.com>
 <fbe81fee-ef1a-499e-bf53-d6f1761bb30e@malon.dev> <xmqqzf3dxqdy.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqzf3dxqdy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 4/9/26 02:23, Junio C Hamano wrote:

> FWIW, I didn't see it fail in my local environment (both in 'seen'
> and also standalone) or at GitHub CI (in 'seen'), so it is a bit
> hasty to conclude that the patch was sent without proper testing.

You=E2=80=99re right, I was a bit hasty.

> I wonder what is different in _your_ environment (note, I am not
> saying your environment is _wrong_.  It is just different, perhaps
> the compiler I use and your build environment may align things
> differently, or perhaps on-stack "uninitialied" pieces of memory
> happen to have different values that the code is reading that causes
> different behaviours---in which case it is the code that is wrong.
> Asking for environment differences is the first step to figure out
> what incorrect environment dependencies the code has).  =20
>

---

git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8

Using built-in specs.
COLLECT_GCC=3Dgcc
COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-linux-gnu/13/lto-wrapper
OFFLOAD_TARGET_NAMES=3Dnvptx-none:amdgcn-amdhsa
OFFLOAD_TARGET_DEFAULT=3D1
Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion=3D'Ubuntu=20
13.3.0-6ubuntu2~24.04.1'=20
--with-bugurl=3Dfile:///usr/share/doc/gcc-13/README.Bugs=20
--enable-languages=3Dc,ada,c++,go,d,fortran,objc,obj-c++,m2 --prefix=3D/usr=
=20
--with-gcc-major-version-only --program-suffix=3D-13=20
--program-prefix=3Dx86_64-linux-gnu- --enable-shared=20
--enable-linker-build-id --libexecdir=3D/usr/libexec=20
--without-included-gettext --enable-threads=3Dposix --libdir=3D/usr/lib=20
--enable-nls --enable-bootstrap --enable-clocale=3Dgnu=20
--enable-libstdcxx-debug --enable-libstdcxx-time=3Dyes=20
--with-default-libstdcxx-abi=3Dnew --enable-libstdcxx-backtrace=20
--enable-gnu-unique-object --disable-vtable-verify --enable-plugin=20
--enable-default-pie --with-system-zlib=20
--enable-libphobos-checking=3Drelease --with-target-system-zlib=3Dauto=20
--enable-objc-gc=3Dauto --enable-multiarch --disable-werror --enable-cet=20
--with-arch-32=3Di686 --with-abi=3Dm64 --with-multilib-list=3Dm32,m64,mx32=
=20
--enable-multilib --with-tune=3Dgeneric=20
--enable-offload-targets=3Dnvptx-none=3D/build/gcc-13-EldibY/gcc-13-13.3.0/=
debian/tmp-nvptx/usr,amdgcn-amdhsa=3D/build/gcc-13-EldibY/gcc-13-13.3.0/deb=
ian/tmp-gcn/usr=20
--enable-offload-defaulted --without-cuda-driver=20
--enable-checking=3Drelease --build=3Dx86_64-linux-gnu=20
--host=3Dx86_64-linux-gnu --target=3Dx86_64-linux-gnu=20
--with-build-config=3Dbootstrap-lto-lean --enable-link-serialization=3D2
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04.1)

Linux malon-Yoga-14sARE-2020 6.14.0-37-generic #37~24.04.1-Ubuntu SMP=20
PREEMPT_DYNAMIC Thu Nov 20 10:25:38 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

---

By the way, I find this bit of code rather confusing to me:

> +=09GIT_TRACE2_EVENT=3D"$(pwd)/pc-quiet-trace" \
> +=09=09git -C super-work grep --cached --recurse-submodules "world" \
> +=09=092>/dev/null &&
> +=09grep negotiationAlgorithm pc-quiet-trace | grep -e --quiet

Is this grep pattern correct?

Thanks, Yuchen
