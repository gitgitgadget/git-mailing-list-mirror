Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AEA1EA87
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726953741; cv=none; b=LpS3OIWRcdK4NNH0vxGIPaR+zrKQXHyiLD0tRxJqPQ31exlj6AeeyHWvkumD5VJwLkW+sDZBlmBgv+gXxwgENSJL2tvLLKHop1IVJlxfEUcMNcKGRQz/HdM0ldkl5dUKEmPXztalLBFFiTVv19uI6zrnE27FlieoSuAOcl+m9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726953741; c=relaxed/simple;
	bh=l+c0bxrQG0XKY9JPgXn9Auatsr9nY4lfiMud7LQuU7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csOuRQPBMVLgBsEOqPr/TzVrgRihCH6usScYxX2z+QKlo2N6rfNeB1PYv0UHplRtrGQo1Vmx0CfH5yhGYtcnAt074ik+s1U0WaMKyVyvUNnoZXiMxf3hgqyVJFe6yqiqVIX7y4uQfzzpffKr875s67SpMSg9fKxsdGmlSYPKgNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=nZTCP7u1; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="nZTCP7u1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726953725; x=1727558525; i=l.s.r@web.de;
	bh=CHKLUoXaiL95nQgLMJldSyKnUwng9soSxJZQieHXYnc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nZTCP7u1r6rYE8Jj3raSC1c139DA3ZlthsHWCiiHbIel66i3rcsLIJHVy16eWuNi
	 zhr8wLiK23eG1chPwseRIhzlY4dDDiP7TB7Sq/L36ZMFwCROB6HEmG6UCMChajElO
	 pEoIq+u6PXEuP1FnUv7TmxanDHXhSz8BOqKnfLhz7cu7+1/9IhyzuAP5CoBjMiYWa
	 O1QRVHVMgwZoDhCJO18asf4IVOUs8oGNQhRQnSXVjgcEd08KD4e42neJj+m2KqTXj
	 9dM+m1FHrhVDuDaMhQYYiITEnC/HzZ91zB56GqEUaPXwSff/ynh3GgcOoY2kCNh66
	 NThEExY9s40UnFzi0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.77]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mv3UY-1s1Wtp2knw-00sXtF; Sat, 21
 Sep 2024 23:22:05 +0200
Message-ID: <9bf5c254-4d87-4f6f-b278-d9df4d7897b5@web.de>
Date: Sat, 21 Sep 2024 23:22:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: refs.c:1933: reference backend is unknown
To: Ronan Pigott <ronan@rjp.ie>, shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>
 <Zu7vpPs8fcqlMlNK@ArchLinux>
 <9fdb9561bb0ad85e55ca3253cc4db9b098641e30@rjp.ie>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <9fdb9561bb0ad85e55ca3253cc4db9b098641e30@rjp.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YAzdTj463JjYiku0tEHS7kHR2lQ0w46rlXGafahcDj7j/sKFOqh
 6LhSOG9PafKrt3wMwkcCzAAwi24hPsMntWb+kzF76tblLlE6pTQOQK74qtwG0DMGn18x9FQ
 S8Je25BPyZy5P6n7rOGr9eZz1usnWFPEAmy7wKw0vq7NQx21TiYJvI1HnA55LDBQmbyiNPn
 oTOM3lbf2o+KDkW6XqS/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OGSPRpqp7Ng=;hw003Oxm06T9R7+I5iyJ8KiPURC
 YmSTJPS0OHLWRprZjLtZe5X8GwBjmr2HvWx/hzphfcoNsqO06nHObGHV9TWiq2BgiHYAKKyNC
 zrPd8eEAtzulBxIIkWqb4bYMnGYfFpqJu1U4rKwYFvSoOBVBcIEDeNE1lWoqYbzhPr97PVJaN
 j+0HIS6TiJsIqPJ+t+vma58tcpXC+aHh60686/PKCsSDjjts/+HVxlI3OtXHb+iIuayx2hH+7
 cD1JWqHrAIEXQXNEwwEdqrzddVBiTt7YDBs4UmsJYazmOFgwUjbf1S2Lw/Aju227ImdU3v1u/
 70EWkwfp5cdnxwlOVGxz6MgqbDbEP6xUO3wFL7W02A3+R2eAtfuf9DjFViuywn6uxJML8l9BR
 gcdraUdEF1Qfl+MRE6/va9u2Ab4bdv/4nDrR7UoN0jTPQ4IBpuXVQRmuKURBFhHAbvOFSRyaH
 HpMifvfLOsWu6A7AQC09mIaqwsyKH2RRXnScFtDf+mIXEb8hkdaW8nf2UHachxWW4Y76QpBqK
 ejcOGYqg41aWoft2Xrk2UQ22CpAnRU5fZg7tK9PpXS+OZZyoFXx4SABH+TqkYIl0Yj1zTgjir
 /7q6F8UX7/7Iw3Kxiypq+7iZZnur9V1Igj89FDrQd51C7nOXCAwK5+Si1gEQ6oesAgORKiitN
 g03HNh9SMtcK1UmwxPhOTGnQE5M3oAIZ6/N/m4PrBeS4jrSkFELmV8F1JZUte+yq9bv2UIVwi
 SwPG0i7meGB49TiBxfxcc5hI0mQsn1UZUxeffrt6FOOtOdB/pk+YdFUdGaViZCl++l9YIcAGK
 25pJ9V1+8xTxmvlFbB4LGXSw==

Am 21.09.24 um 20:06 schrieb Ronan Pigott:
>
> The abort is reproducible exactly as written for me, but upon further
> examination it may depend on my config. Here is a minimal reproducer:
>
>   $ GIT_CONFIG_NOSYSTEM=3D1 GIT_CONFIG_GLOBAL=3D/dev/null git --git-dir=
=3Dnotexist -c 'includeif.onbranch:test/**.path=3D/dev/null' archive
>
>> bt
> #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Ds=
igno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
> #1  0x00007ffff7d78463 in __pthread_kill_internal (threadid=3D<optimized=
 out>, signo=3D6) at pthread_kill.c:78
> #2  0x00007ffff7d1f120 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps=
/posix/raise.c:26
> #3  0x00007ffff7d064c3 in __GI_abort () at abort.c:79
> #4  0x000055555585385a in BUG_vfl (file=3D<optimized out>, line=3D<optim=
ized out>, fmt=3D0x555555905baf "reference backend is unknown", params=3D0=
x7fffffffd120) at /usr/src/debug/git/git-2.46.1/usage.c:317
> #5  BUG_fl (file=3D<optimized out>, line=3D<optimized out>, fmt=3D0x5555=
55905baf "reference backend is unknown") at /usr/src/debug/git/git-2.46.1/=
usage.c:334
> #6  0x00005555557ca9d2 in ref_store_init (repo=3D<optimized out>, format=
=3D<optimized out>, gitdir=3D<optimized out>, flags=3D<optimized out>) at =
/usr/src/debug/git/git-2.46.1/refs.c:1933
> #7  ref_store_init (repo=3D0x5555559759a0 <the_repo.lto_priv>, format=3D=
<optimized out>, gitdir=3D<optimized out>, flags=3D15) at /usr/src/debug/g=
it/git-2.46.1/refs.c:1923
> #8  get_main_ref_store (r=3D0x5555559759a0 <the_repo.lto_priv>) at /usr/=
src/debug/git/git-2.46.1/refs.c:1953
> #9  0x00005555556dcdf6 in include_by_branch (cond=3D0x55555599f503 "test=
/**.path", cond_len=3D7) at /usr/src/debug/git/git-2.46.1/config.c:309
> #10 include_condition_is_true (kvi=3D<optimized out>, inc=3D0x7fffffffd4=
60, cond=3D0x55555599f503 "test/**.path", cond_len=3D7) at /usr/src/debug/=
git/git-2.46.1/config.c:409
> #11 git_config_include (var=3Dvar@entry=3D0x55555599f4f0 "includeif.onbr=
anch:test/**.path", value=3Dvalue@entry=3D0x55555599fa62 "/dev/null", ctx=
=3Dctx@entry=3D0x7fffffffd368, data=3Ddata@entry=3D0x7fffffffd460) at /usr=
/src/debug/git/git-2.46.1/config.c:439
> #12 0x00005555556d8753 in config_parse_pair (key=3D<optimized out>, valu=
e=3D0x55555599fa62 "/dev/null", kvi=3Dkvi@entry=3D0x7fffffffd4a0, fn=3Dfn@=
entry=3D0x5555556dcad0 <git_config_include>, data=3Ddata@entry=3D0x7ffffff=
fd460) at /usr/src/debug/git/git-2.46.1/config.c:617
> #13 0x00005555556dc437 in parse_config_env_list (env=3D0x55555599fa40 "i=
ncludeif.onbranch:test/**.path", kvi=3D0x7fffffffd4a0, fn=3D0x5555556dcad0=
 <git_config_include>, data=3D0x7fffffffd460) at /usr/src/debug/git/git-2.=
46.1/config.c:700
> #14 git_config_from_parameters (fn=3D0x5555556dcad0 <git_config_include>=
, data=3D0x7fffffffd460) at /usr/src/debug/git/git-2.46.1/config.c:773
> #15 do_git_config_sequence (opts=3D0x7fffffffd4b0, repo=3D0x0, fn=3D0x55=
55556dcad0 <git_config_include>, data=3D0x7fffffffd460) at /usr/src/debug/=
git/git-2.46.1/config.c:2131
> #16 config_with_options (fn=3D0x5555556dcad0 <git_config_include>, fn@en=
try=3D0x555555790940 <pager_command_config>, data=3D0x7fffffffd460, data@e=
ntry=3D0x7fffffffd7a0, config_source=3Dconfig_source@entry=3D0x0, repo=3Dr=
epo@entry=3D0x0, opts=3Dopts@entry=3D0x7fffffffd660) at /usr/src/debug/git=
/git-2.46.1/config.c:2174
> #17 0x00005555556dd110 in read_early_config (cb=3D0x555555790940 <pager_=
command_config>, data=3D0x7fffffffd7a0) at /usr/src/debug/git/git-2.46.1/c=
onfig.c:2229
> #18 0x000055555555ea58 in check_pager_config (cmd=3D<optimized out>) at =
/usr/src/debug/git/git-2.46.1/pager.c:261
> #19 run_builtin (p=3D0x555555966a00 <commands.lto_priv+96>, argc=3D1, ar=
gv=3D0x7fffffffdd78) at /usr/src/debug/git/git-2.46.1/git.c:461
> #20 handle_builtin (argc=3D1, argv=3D0x7fffffffdd78) at /usr/src/debug/g=
it/git-2.46.1/git.c:732
> #21 0x000055555555eaf9 in run_argv (argcp=3D0x7fffffffdb0c, argv=3D0x7ff=
fffffdb30) at /usr/src/debug/git/git-2.46.1/git.c:796
> #22 0x00005555555597eb in cmd_main (argc=3D<optimized out>, argv=3D<opti=
mized out>) at /usr/src/debug/git/git-2.46.1/git.c:931
> #23 main (argc=3D<optimized out>, argv=3D<optimized out>) at /usr/src/de=
bug/git/git-2.46.1/common-main.c:64

Thanks, that helps.  The BUG occurs during setup, before any
command-specific code is executed.  Affects other commands with the
option RUN_SETUP_GENTLY as well, e.g. git grep.

Bisects to 173761e21b (setup: start tracking ref storage format,
2023-12-29, copying Patrick.

I wonder if the BUG at refs.c:1933 should just be turned into a die().
Or should ref_store_init() return NULL (or some other value indicating
an error) and all callers need to be changed to deal with that?

Simply checking whether --git-dir points to an actual repo earlier is
tempting, but would leave the case of it disappearing after the check
unhandled.

Ren=C3=A9

