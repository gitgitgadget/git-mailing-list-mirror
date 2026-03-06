Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D600248176
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759173; cv=pass; b=uknYW71VFRaXoF7y6C/fBocRf75bFSuxEuOJT1qZ01hiwhI6S0d5DbrTUuybk+I7DUCK+mziDuetGtmYCgfmepnAoFZQCs5UjhcArctbwZCdd7dDhRXrnQ7csWgJHON+zgFR2Acy14nO+87u6WeRx0axFnD/QPYh+5GuI9Op90M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759173; c=relaxed/simple;
	bh=DOMZbbcfaTd3wRjfQNAi4KrIJbGN83vq/wRR31KmKCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FOX4DqgGsIXwBxosB+IzJHRpwXKZuxXSvkv9tBNtamFEKLq1CziX6VOQzy8vYV1MJ78Cm77m1B0L00phbNcddczGtKbdkNnd+MD/EAJwCrkimbjyze8m57/L2W826iOjaqejErKKwDCxmcqwgueTC4CI1cHWf6/gfZL3vchOEZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWh7bDaB; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWh7bDaB"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-660dcafc85aso4763415a12.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 17:06:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772759170; cv=none;
        d=google.com; s=arc-20240605;
        b=AIN8hNGMX7cDpFm63aMJyza643QUKQuM6k5E3J0XY0uOe6BM8HbIcZA4MYOHdyj9RH
         oPiQ04SQEi1gjqdLHUPMLhoz/rwfsZgb3Ai7MhSSdppncTOL8jBDTCwmFwBAj5JM8Wo3
         d8MFC9mfZetcmNqcDksB92h9xqVG1HGhEj4z9rcMMTyxaMpqW5z6Ajqenei2O7up2LTn
         m6lSjXOFAPuMD82MN+Pxoj/gUYK11cu4crNPZjkeJYFlfgZWB5/T33qKNTcT2q/VwwJr
         24jOr2PxOjTpjxujpo+ipmN5Enw/9qTVlXGVnZRKe2mYIOFAS7RpmICpV00aW9t71GsG
         TwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dcx7HjK5g80yG3JRhl5Xd0D+d8An/iYJ1T4JNynZQZU=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=KKGXRLkdu+q5YFDmsZmz8kac6jtBvchlCfWdzbCiLM40GZ9jZgpTRYjP1fL11OMlQF
         kQQ9ZaDrsRT5W3ncCAnkdK6/F4n95ZhEWaDfEDE6eG+0EToJVnDaWxY80BSuMoIYat3k
         arZ54nR5KsnjOBXpzYb456ivThCeIE/W1OIWY7lEpWNCdxrLQHavepdEMg0Zk8M+J9WE
         K6kHLhDHSq3CBo7Zt/t1yiYRtFJUkahXy1fFf5TVqhrObcZcAfpiwL/ileuri0tXbAjG
         sYd6E547ydY6gZbZPAvn1RUN1Ds/QNI2g8+BqDsx74HwuuQS0RQ4uAvYTiF7/xFNPoLZ
         MsLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772759170; x=1773363970; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcx7HjK5g80yG3JRhl5Xd0D+d8An/iYJ1T4JNynZQZU=;
        b=UWh7bDaB2wbh84LIHzeXZ6rtvBgJrq1Lj29I/vGGD+0AM6mXtJUe3tWMhKp5PWqe9T
         bozOEKpmIiuFBgOUBPJ/rVShcef1qFI9jgxcGd8ZbrRIpG6r4+YgdgbHWGCSEP0T/0QC
         Lt7F3uFWWcF+pEjQTVRzcTuHVjumvg4gxA0X9gn8VR5jEE8HbuLONN8tnkMhOGOSNtYq
         nQp5BeFqIfX7FQRRD4RiHGP/ZNPzdrQbCsu/Q3KyayVYd9MhIfghy+8CfBA9SLbCMXQO
         k01HWiCeSK+vmb27GFKpL5nR6KUkmdKWy2qOlnQ90hqps9IpJ/FaF3WxiBpUBygUvV1A
         rv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772759170; x=1773363970;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dcx7HjK5g80yG3JRhl5Xd0D+d8An/iYJ1T4JNynZQZU=;
        b=mA3nxkYeC/Tx5EuM/cl/l2zYOImTYy3EtyN4KHTPuUywM6JanjTI25o0LvNOHxSb+k
         NsB39mZ3PwNH23V6gYwPUNbUF6sbW9CHXtjiK2pol7oZtKE02gfkUSWvpKL2nq/nKkNu
         aG+dCNaaQG1nhzrElfdiNBUsA6XRrfnSrbO0fsqGRMmuDV3i/kMWiedJx4+jRUaDUUkE
         wdESGiPRpaG8pj7L+hEA5ombbs3iXN1Ql6f2YmM1rW5sP8gIK99H7D3NJNjYrEpymTKY
         8BszDe99H+8mLQ59bOJLcgEgUzQkvHnl2MM7CA1tO0xs+7uGLUfQ4sLQodVie/IbI2PC
         zblg==
X-Gm-Message-State: AOJu0Yzz1VK+7W0q7c/kd1P0xFZ/X/hDQwjwD7fPjA9EYYcE8H3nVOqT
	2ZszLpj19L3iqfPxx16mlx68867a0lmZMN1O3WzZD7cHpxQr5MNb+JqMQC1SGW/qL5y9GrdT1RI
	jliwe9ORe1ooW0X9F7X87VGVJDS6cmqZWCJc61gI=
X-Gm-Gg: ATEYQzza7fi5LBW2Vy7LneWZkpvs8m7DVEOXciB056hrDWpDypJCqdNlq6nMQiYBEhm
	oj1mlgW6ZfL38ntJFqcmnyQ6YO/FMVICZUKLwCZRqTj4t0CFs5HayOJ8HID+1P/uGO0uannkBwB
	v25MdE2Ca9pbjXhafhxlZ+ERKJ+buLqOZgSXTaBvNogVvIrbRdQVNNWO2s2iCoU1urcRWu5zC59
	zGzpUuzJmOp5MLrt/T+0Y24kleLoLUWAhs5jDMMrRrLhI3+sR+0viS+bRxrXcX/CZVuw42WdbyH
	WZTAXNrgmsi83GboAMPt19UBb989p16tD+zpYU5UF9NFkEUTg1NNxmUWKKsk2X8cwaNbtjSenis
	h8UpPjS+d/JJfU4JdHuXP5JEq
X-Received: by 2002:a05:6402:2750:b0:661:2922:be03 with SMTP id
 4fb4d7f45d1cf-6619d536177mr124525a12.24.1772759169638; Thu, 05 Mar 2026
 17:06:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAaskFBp+A9pOhd8O6owd6k0cDj66ipXrqH2Hj_c7j3d=HM10Q@mail.gmail.com>
In-Reply-To: <CAAaskFBp+A9pOhd8O6owd6k0cDj66ipXrqH2Hj_c7j3d=HM10Q@mail.gmail.com>
From: Ivan Ivanov <qmastery16@gmail.com>
Date: Fri, 6 Mar 2026 04:05:58 +0300
X-Gm-Features: AaiRm52FzPVLzKmGz4lpXgCcbTEAWbiK_C2sSDXbEl7zhtCZHp2G3Vcq49ynEls
Message-ID: <CAAaskFANnrqTAjQOHhAgzES9=S+y7w9u-LMWbRbi8FayVdvzFw@mail.gmail.com>
Subject: Re: Test "t0300-credentials" is failing on Arch/Artix: asks to enter
 the Username/Password in an infinite loop
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To clarify, in addition to t0300-credentials.out ,
t0301-credential-cache.out and t0302-credential-store.out are also
failing, however a similar-by-nature t0303-credential-external.out
succeeds fine. Very strange. Seeing how it's leaking to the primary
console, I suspect something may be wrong with shell handling: i.e.
for t0302-credential-store test I am seeing these prompts that are
waiting input for a user (could write any message here or just press
Enter to get a new prompt) :

Username for 'https://example.com':
Password for 'https://%20@example.com':
Username for 'http://example.com':
Password for 'http://example.com':
Username for 'https://other.tld':
Password for 'https://other.tld':
Password for 'https://other@example.com':
Username for 'http://path.tld/bar.git':
Password for 'http://path.tld/bar.git':
Password for 'https://user-overwrite@example.com':
Username for 'https://example.com':
Password for 'https://example.com':
Password for 'https://user1@example.com':
Username for 'https://example.com':
...

On Fri, Mar 6, 2026 at 3:42=E2=80=AFAM Ivan Ivanov <qmastery16@gmail.com> w=
rote:
>
> Good day! While trying to rebuild git for Arch/Artix, I run into the
> following problem: shortly after "*** prove (shell & unit tests) ***"
> I get asked the Username/Password in an endless loop. Below are the
> full logs, as well as the contents of
> ./test-results/t0300-credentials.out file, hope this is helpful for
> debugging. Please note that I have all the dependencies installed,
> even the optional ones like Apache HTTPD (some online manuals
> suggested doing that, but didn't help to pass this test)
>
> =3D=3D> Starting check()...
>     GEN git-difftool--helper
>     GEN git-filter-branch
>     GEN git-merge-octopus
>     GEN git-merge-one-file
>     GEN git-merge-resolve
>     GEN git-mergetool
>     GEN git-quiltimport
>     GEN git-request-pull
>     GEN git-submodule
>     GEN git-web--browse
>     GEN git-archimport
>     GEN git-cvsexportcommit
>     GEN git-cvsimport
>     GEN git-cvsserver
>     GEN git-send-email
>     GEN git-svn
>     GEN git-p4
>     GEN git-instaweb
>     GEN git-mergetool--lib
>     GEN git-sh-i18n
>     GEN git-sh-setup
>     SUBDIR git-gui
>     SUBDIR gitk-git
>     SUBDIR templates
>     GEN perl/build/lib/Git.pm
>     GEN perl/build/lib/Git/I18N.pm
>     GEN perl/build/lib/Git/IndexInfo.pm
>     GEN perl/build/lib/Git/LoadCPAN.pm
>     GEN perl/build/lib/Git/Packet.pm
>     GEN perl/build/lib/Git/SVN.pm
>     GEN perl/build/lib/Git/LoadCPAN/Error.pm
>     GEN perl/build/lib/Git/SVN/Editor.pm
>     GEN perl/build/lib/Git/SVN/Fetcher.pm
>     GEN perl/build/lib/Git/SVN/GlobSpec.pm
>     GEN perl/build/lib/Git/SVN/Log.pm
>     GEN perl/build/lib/Git/SVN/Migration.pm
>     GEN perl/build/lib/Git/SVN/Prompt.pm
>     GEN perl/build/lib/Git/SVN/Ra.pm
>     GEN perl/build/lib/Git/SVN/Utils.pm
>     GEN perl/build/lib/Git/LoadCPAN/Mail/Address.pm
>     GEN perl/build/lib/Git/SVN/Memoize/YAML.pm
> make -C t/ all
> make[1]: Entering directory '/home/username/artix_git/src/git/t'
> rm -f -r 'test-results'
> *** prove (shell & unit tests) ***
> Username for 'http://example.com':
> Password for 'http://example.com':
> Username for 'http://example.com':
> Password for 'http://example.com':
>
> /src/git/t$ cat ./test-results/t0300-credentials.out
> Initialized empty Git repository in /dev/shm/git-test/trash
> directory.t0300-credentials/.git/
> expecting success of 0300.1 'setup helper scripts':
>     cat >dump <<-\EOF &&
>     whoami=3D$(echo $0 | sed s/.*git-credential-//)
>     echo >&2 "$whoami: $*"
>     OIFS=3D$IFS
>     IFS=3D=3D
>     while read key value; do
>         echo >&2 "$whoami: $key=3D$value"
>         if test -z "${key%%*\[\]}"
>         then
>             key=3D${key%%\[\]}
>             eval "$key=3D\"\$$key $value\""
>         else
>             eval "$key=3D$value"
>         fi
>     done
>     IFS=3D$OIFS
>     EOF
>
>     write_script git-credential-useless <<-\EOF &&
>     . ./dump
>     exit 0
>     EOF
>
>     write_script git-credential-quit <<-\EOF &&
>     . ./dump
>     echo quit=3D1
>     EOF
>
>     write_script git-credential-verbatim <<-\EOF &&
>     user=3D$1; shift
>     pass=3D$1; shift
>     . ./dump
>     test -z "$user" || echo username=3D$user
>     test -z "$pass" || echo password=3D$pass
>     EOF
>
>     write_script git-credential-verbatim-cred <<-\EOF &&
>     authtype=3D$1; shift
>     credential=3D$1; shift
>     . ./dump
>     echo capability[]=3Dauthtype
>     echo capability[]=3Dstate
>     test -z "${capability##*authtype*}" || exit 0
>     test -z "$authtype" || echo authtype=3D$authtype
>     test -z "$credential" || echo credential=3D$credential
>     test -z "${capability##*state*}" || exit 0
>     echo state[]=3Dverbatim-cred:foo
>     EOF
>
>     write_script git-credential-verbatim-ephemeral <<-\EOF &&
>     authtype=3D$1; shift
>     credential=3D$1; shift
>     . ./dump
>     echo capability[]=3Dauthtype
>     test -z "${capability##*authtype*}" || exit 0
>     test -z "$authtype" || echo authtype=3D$authtype
>     test -z "$credential" || echo credential=3D$credential
>     echo "ephemeral=3D1"
>     EOF
>
>     write_script git-credential-verbatim-with-expiry <<-\EOF &&
>     user=3D$1; shift
>     pass=3D$1; shift
>     pexpiry=3D$1; shift
>     . ./dump
>     test -z "$user" || echo username=3D$user
>     test -z "$pass" || echo password=3D$pass
>     test -z "$pexpiry" || echo password_expiry_utc=3D$pexpiry
>     EOF
>
>     write_script git-credential-cntrl-in-username <<-\EOF &&
>     printf "username=3D\\007latrix Lestrange\\n"
>     EOF
>
>     PATH=3D"$PWD:$PATH"
>
> ok 1 - setup helper scripts
>
> expecting success of 0300.2 'credential_fill invokes helper':
>     check fill "verbatim foo bar" <<-\EOF
>     protocol=3Dhttp
>     host=3Dexample.com
>     --
>     protocol=3Dhttp
>     host=3Dexample.com
>     username=3Dfoo
>     password=3Dbar
>     --
>     verbatim: get
>     verbatim: protocol=3Dhttp
>     verbatim: host=3Dexample.com
>     EOF
>
> --- expect-stdout    2026-03-06 00:33:02.009338195 +0000
> +++ stdout    2026-03-06 00:33:07.569338321 +0000
> @@ -1,4 +1,4 @@
>  protocol=3Dhttp
>  host=3Dexample.com
> -username=3Dfoo
> -password=3Dbar
> +username=3D
> +password=3D
> not ok 2 - credential_fill invokes helper
> #
> #        check fill "verbatim foo bar" <<-\EOF
> #        protocol=3Dhttp
> #        host=3Dexample.com
> #        --
> #        protocol=3Dhttp
> #        host=3Dexample.com
> #        username=3Dfoo
> #        password=3Dbar
> #        --
> #        verbatim: get
> #        verbatim: protocol=3Dhttp
> #        verbatim: host=3Dexample.com
> #        EOF
> #
>
> expecting success of 0300.3 'credential_fill invokes helper with credenti=
al':
>     check fill "verbatim-cred Bearer token" <<-\EOF
>     capability[]=3Dauthtype
>     protocol=3Dhttp
>     host=3Dexample.com
>     --
>     capability[]=3Dauthtype
>     authtype=3DBearer
>     credential=3Dtoken
>     protocol=3Dhttp
>     host=3Dexample.com
>     --
>     verbatim-cred: get
>     verbatim-cred: capability[]=3Dauthtype
>     verbatim-cred: protocol=3Dhttp
>     verbatim-cred: host=3Dexample.com
>     EOF
>
> --- expect-stdout    2026-03-06 00:33:07.581338322 +0000
> +++ stdout    2026-03-06 00:33:08.191338336 +0000
> @@ -1,5 +1,4 @@
> -capability[]=3Dauthtype
> -authtype=3DBearer
> -credential=3Dtoken
>  protocol=3Dhttp
>  host=3Dexample.com
> +username=3D
> +password=3D
> not ok 3 - credential_fill invokes helper with credential
> #
> #        check fill "verbatim-cred Bearer token" <<-\EOF
> #        capability[]=3Dauthtype
> #        protocol=3Dhttp
> #        host=3Dexample.com
> #        --
> #        capability[]=3Dauthtype
> #        authtype=3DBearer
> #        credential=3Dtoken
> #        protocol=3Dhttp
> #        host=3Dexample.com
> #        --
> #        verbatim-cred: get
> #        verbatim-cred: capability[]=3Dauthtype
> #        verbatim-cred: protocol=3Dhttp
> #        verbatim-cred: host=3Dexample.com
> #        EOF
> #
>
> expecting success of 0300.4 'credential_fill invokes helper with
> ephemeral credential':
>     check fill "verbatim-ephemeral Bearer token" <<-\EOF
>     capability[]=3Dauthtype
>     protocol=3Dhttp
>     host=3Dexample.com
>     --
>     capability[]=3Dauthtype
>     authtype=3DBearer
>     credential=3Dtoken
>     ephemeral=3D1
>     protocol=3Dhttp
>     host=3Dexample.com
>     --
>     verbatim-ephemeral: get
>     verbatim-ephemeral: capability[]=3Dauthtype
>     verbatim-ephemeral: protocol=3Dhttp
>     verbatim-ephemeral: host=3Dexample.com
>     EOF
