Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA884A33
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773240990; cv=none; b=rMYyrZQtIFjGdHiRsgaAecr6OV/MdP1mooP2DMUEqEK/7G0cxDfaVLZ7pcENU4I0jOle5x8foQa8RQ+W2TA6tzKcfk/tPM3it1+iOGsHBYfFZagqKfsANlg5T01AVahFmS9NbmTnhFGGGoGLGVKydRye1m4j0e9DOmwKH8HdPiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773240990; c=relaxed/simple;
	bh=ZzFGS3sHPuNwWZDpY+AhST8L7wMgHpZdEjTBA6wEx4k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=HSbbqwmqR9NqlqpUJ0/HHewJs0MyMEJFOr68MI8YJ3LEIu01xT5+Vrw6sA40SvJnVs2+VAVWsJkpxrOq6gS+l0a6ejo0aIDuY/dwo4APoLzGOmYBe4Ih0mbigWvS7xhsLNKfit5/vH8yWyx+E/lZoKoYej/NgOmxLLEhYoMoTYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsBzMPGE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsBzMPGE"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439ac15f35fso10657731f8f.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773240987; x=1773845787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rkd7fuEJIJ0cnPecaG+7lAGmvHWDKV25/kdZV45swxU=;
        b=KsBzMPGESBT40kE2oQE1R+5S6Cy7IJdgBQBfXIIfO9YY/0EY/7tUypA9VlrJATXNpr
         04p82ICWjrDoRwUjHaUinbEFoOuxmy7BHHjZx5donxNC2ws7u73POnsHFUASQtf8tyPe
         6SG9OshWsNQ7lQFOCYCD8tZldIjGIRbI3rI+axUoJuEnNiHXMrs5hP5ikHeo1aRiAIhf
         F4wH4tgDWlL20GsOI3vBNVAjytpyS4tsztCJlybEO+IMzfyrTuwuXm60VpmLPG2VvWln
         rDmVZkRWvYFfxkMJb9f0nauhnCI2K+pbI+rmQBmIMsIQj9eOX4resACwvk7W0XpeJNQs
         lKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773240987; x=1773845787;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rkd7fuEJIJ0cnPecaG+7lAGmvHWDKV25/kdZV45swxU=;
        b=sTBGdPk2eLbgt7hPPrRDqV+d/kNleJe772QgIQgYbUy0ECpgkEGJvj45R9u5elzd2d
         o/auM/VmZjmg+Ca8/wqSAQ2CKEI14RLscUkqDitJx7GZfG6L9FpSczx2++xXICpB+7C5
         AaOc1NITnG8maFIrfRpy/lWiFbLBgmKiLqJGcen02nzluBjRDQeyPhWLW/wcvtVh6o+C
         mcFBdgs19aOxIbrxu2D94au62etiS7ZrXVo5EOSYDFO0hkDkgCbtITg6Fk6MbkmypOu4
         QUlrRSVEhrSVDkM3wnB49kbliWCRgqA7A89QAURox23mrATQh1JoLe5xqE6Xc2eBByY+
         1BMg==
X-Forwarded-Encrypted: i=1; AJvYcCXt6nGlWIeqkI4OvuJM0ZeolmLPjaNvEM+Yzq1MqFAhDc65YuXBjGInovJQrsxAIrrJ5Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYfwyYKGqwssCK8i2kU/SGW9KAlqox2zo1SaFUirvytpaqUwav
	9hwLCDb3R/s2YVJbNUwyCxO3DACW/Jd2G6lV8z2hhdf1/2rvvsYJ3+MOGQWlUQ==
X-Gm-Gg: ATEYQzwbWgMH+lfOcVgmY/x/DRhPQyhAcXXgGVbGEWhv3gFy9Ay/jNEUK2z8m2yipNF
	KkxBwh468ESkNlDYKguziy9cVnq5xjnsilYQVzoPGduWEJnv9Sbf9hYRyLDFuOpL2Rf5VRclmik
	bzuXobjOJ/y0hHubG4pqdTrnuW5s0MsHFnHfbP50ScJrRTnRnMIIyXsZqMALTjSIq/bYgHTooQy
	Y7gO9WbZvHiGkaEWWACpoWsvyVBFcsMvYOuzcVOX0GKDF4nQmo1dBzNECfefqQ0gFG9QD3k54ln
	F7mqzjP0rDSHhh+4WYj9ifIKlJBCKcJkZquI7yzewABl6GACKkakkwRob3HzJOOFMNfobsggbFm
	t6LuJMfnAXSHNvK7U7gYIind54T0plsNj7T+gteFJk3/+/eJYgqvHgyvie5VIYrgx45NCSyzXEc
	sfT7qC8g8evI12S/JbNIZR8N+meX91w82pSSMP4JHeM0vR4uybYoIbJvdgUxqSRaRXN69SL89IC
	XVLUA==
X-Received: by 2002:a05:6000:1846:b0:437:6625:d0d7 with SMTP id ffacd0b85a97d-439f8438f5dmr5494937f8f.42.1773240986370;
        Wed, 11 Mar 2026 07:56:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm6996107f8f.16.2026.03.11.07.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:56:25 -0700 (PDT)
Message-ID: <debb89c9-2fab-4922-af1a-6048094baf9f@gmail.com>
Date: Wed, 11 Mar 2026 14:56:24 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/8] meson: compile compatibility sources separately
From: Phillip Wood <phillip.wood123@gmail.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
 <a5d1ea70-12dd-461d-b5c5-a1127e017d01@gmail.com>
Content-Language: en-US
In-Reply-To: <a5d1ea70-12dd-461d-b5c5-a1127e017d01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/03/2026 14:32, Phillip Wood wrote:
> On 10/03/2026 17:52, Patrick Steinhardt wrote:
>> In the next commit we're about to introduce a precompiled header for
>> "git-compat-util.h". The consequence of this change is that we'll
>> implicitly include that header for every compilation unit that uses the
>> precompiled headers.
> 
> Is that a meson thing? I know it defines precompiled headers on a per- 
> target basis but does it somehow force each source file to include the 
> precompiled header? Looking at the gcc documentation it seems like the 
> precompiled header is only included where the original header is 
> included.

Answering my own question the precompiled header is included via 
"-include" on the commandline. This is necessary in the general case 
because a precompiled header cannot be used once the first C token is seen.

As an aside in git we could probably get away without using "-include" 
because if we include "git-compat-util.h" it is always the first thing 
we do, or we inculde another file like "builtin.h" which immediately 
includes "git-compat-util.h" and so it is included before the first C 
token is seen. However meson cannot rely on that.

I notice the reftable sources don't seem to include "git-compat-util.h", 
do they need special handling here as well?

Thanks

Phillip

> Splitting out the sources that do not depend on "git-compat- 
> util.h" does mean we get some additional parallelism while we're 
> precompiling the header which is probably a good thing.
> 
> Thanks
> 
> Phillip
> 
>> This is okay for our "normal" library sources and our builtins. But some
>> of our compatibility sources do not include the header on purpose, and
>> doing so would cause compileir errors.
>>
>> Prepare for this change by splitting out compatibility sources into
>> their static library. Like this we can selectively enable precompiled
>> headers for the library sources.
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>   meson.build | 79 ++++++++++++++++++++++++++++++++++ 
>> +--------------------------
>>   1 file changed, 45 insertions(+), 34 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 604fe89d2d..cd00be1c23 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -271,6 +271,13 @@ version_gen_environment.set('GIT_VERSION', 
>> get_option('version'))
>>   compiler = meson.get_compiler('c')
>> +compat_sources = [
>> +  'compat/nonblock.c',
>> +  'compat/obstack.c',
>> +  'compat/open.c',
>> +  'compat/terminal.c',
>> +]
>> +
>>   libgit_sources = [
>>     'abspath.c',
>>     'add-interactive.c',
>> @@ -304,10 +311,6 @@ libgit_sources = [
>>     'commit.c',
>>     'common-exit.c',
>>     'common-init.c',
>> -  'compat/nonblock.c',
>> -  'compat/obstack.c',
>> -  'compat/open.c',
>> -  'compat/terminal.c',
>>     'compiler-tricks/not-constant.c',
>>     'config.c',
>>     'connect.c',
>> @@ -1163,7 +1166,7 @@ endif
>>   if not has_poll_h and not has_sys_poll_h
>>     libgit_c_args += '-DNO_POLL'
>> -  libgit_sources += 'compat/poll/poll.c'
>> +  compat_sources += 'compat/poll/poll.c'
>>     libgit_include_directories += 'compat/poll'
>>   endif
>> @@ -1179,7 +1182,7 @@ endif
>>   # implementation to threat things like drive prefixes specially.
>>   if host_machine.system() == 'windows' or not 
>> compiler.has_header('libgen.h')
>>     libgit_c_args += '-DNO_LIBGEN_H'
>> -  libgit_sources += 'compat/basename.c'
>> +  compat_sources += 'compat/basename.c'
>>   endif
>>   if compiler.has_header('paths.h')
>> @@ -1209,7 +1212,7 @@ if host_machine.system() != 'windows'
>>     foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
>>       if not compiler.has_function(symbol, dependencies: 
>> networking_dependencies)
>>         libgit_c_args += '-DNO_' + symbol.to_upper()
>> -      libgit_sources += 'compat/' + symbol + '.c'
>> +      compat_sources += 'compat/' + symbol + '.c'
>>       endif
>>     endforeach
>>   endif
>> @@ -1251,18 +1254,18 @@ else
>>   endif
>>   if host_machine.system() == 'darwin'
>> -  libgit_sources += 'compat/precompose_utf8.c'
>> +  compat_sources += 'compat/precompose_utf8.c'
>>     libgit_c_args += '-DPRECOMPOSE_UNICODE'
>>     libgit_c_args += '-DPROTECT_HFS_DEFAULT'
>>   endif
>>   # Configure general compatibility wrappers.
>>   if host_machine.system() == 'cygwin'
>> -  libgit_sources += [
>> +  compat_sources += [
>>       'compat/win32/path-utils.c',
>>     ]
>>   elif host_machine.system() == 'windows'
>> -  libgit_sources += [
>> +  compat_sources += [
>>       'compat/winansi.c',
>>       'compat/win32/dirent.c',
>>       'compat/win32/flush.c',
>> @@ -1289,20 +1292,20 @@ elif host_machine.system() == 'windows'
>>     libgit_include_directories += 'compat/win32'
>>     if compiler.get_id() == 'msvc'
>>       libgit_include_directories += 'compat/vcbuild/include'
>> -    libgit_sources += 'compat/msvc.c'
>> +    compat_sources += 'compat/msvc.c'
>>     else
>> -    libgit_sources += 'compat/mingw.c'
>> +    compat_sources += 'compat/mingw.c'
>>     endif
>>   endif
>>   if host_machine.system() == 'linux'
>> -  libgit_sources += 'compat/linux/procinfo.c'
>> +  compat_sources += 'compat/linux/procinfo.c'
>>   elif host_machine.system() == 'windows'
>> -  libgit_sources += 'compat/win32/trace2_win32_process_info.c'
>> +  compat_sources += 'compat/win32/trace2_win32_process_info.c'
>>   elif host_machine.system() == 'darwin'
>> -  libgit_sources += 'compat/darwin/procinfo.c'
>> +  compat_sources += 'compat/darwin/procinfo.c'
>>   else
>> -  libgit_sources += 'compat/stub/procinfo.c'
>> +  compat_sources += 'compat/stub/procinfo.c'
>>   endif
>>   if host_machine.system() == 'cygwin' or host_machine.system() == 
>> 'windows'
>> @@ -1315,13 +1318,13 @@ endif
>>   # Configure the simple-ipc subsystem required fro the fsmonitor.
>>   if host_machine.system() == 'windows'
>> -  libgit_sources += [
>> +  compat_sources += [
>>       'compat/simple-ipc/ipc-shared.c',
>>       'compat/simple-ipc/ipc-win32.c',
>>     ]
>>     libgit_c_args += '-DSUPPORTS_SIMPLE_IPC'
>>   else
>> -  libgit_sources += [
>> +  compat_sources += [
>>       'compat/simple-ipc/ipc-shared.c',
>>       'compat/simple-ipc/ipc-unix-socket.c',
>>     ]
>> @@ -1339,7 +1342,7 @@ if fsmonitor_backend != ''
>>     libgit_c_args += '-DHAVE_FSMONITOR_DAEMON_BACKEND'
>>     libgit_c_args += '-DHAVE_FSMONITOR_OS_SETTINGS'
>> -  libgit_sources += [
>> +  compat_sources += [
>>       'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
>>       'compat/fsmonitor/fsm-ipc-' + fsmonitor_backend + '.c',
>>       'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
>> @@ -1355,7 +1358,7 @@ if not 
>> get_option('b_sanitize').contains('address') and get_option('regex').allo
>>     if compiler.get_define('REG_ENHANCED', prefix: '#include 
>> <regex.h>') != ''
>>       libgit_c_args += '-DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS'
>> -    libgit_sources += 'compat/regcomp_enhanced.c'
>> +    compat_sources += 'compat/regcomp_enhanced.c'
>>     endif
>>   elif not get_option('regex').enabled()
>>     libgit_c_args += [
>> @@ -1364,7 +1367,7 @@ elif not get_option('regex').enabled()
>>       '-DNO_MBSUPPORT',
>>     ]
>>     build_options_config.set('NO_REGEX', '1')
>> -  libgit_sources += 'compat/regex/regex.c'
>> +  compat_sources += 'compat/regex/regex.c'
>>     libgit_include_directories += 'compat/regex'
>>   else
>>       error('Native regex support requested but not found')
>> @@ -1428,7 +1431,7 @@ else
>>     if get_option('b_sanitize').contains('address')
>>       libgit_c_args += '-DNO_MMAP'
>> -    libgit_sources += 'compat/mmap.c'
>> +    compat_sources += 'compat/mmap.c'
>>     else
>>       checkfuncs += { 'mmap': ['mmap.c'] }
>>     endif
>> @@ -1438,7 +1441,7 @@ foreach func, impls : checkfuncs
>>     if not compiler.has_function(func)
>>       libgit_c_args += '-DNO_' + func.to_upper()
>>       foreach impl : impls
>> -      libgit_sources += 'compat/' + impl
>> +      compat_sources += 'compat/' + impl
>>       endforeach
>>     endif
>>   endforeach
>> @@ -1449,13 +1452,13 @@ endif
>>   if not compiler.has_function('strdup')
>>     libgit_c_args += '-DOVERRIDE_STRDUP'
>> -  libgit_sources += 'compat/strdup.c'
>> +  compat_sources += 'compat/strdup.c'
>>   endif
>>   if not compiler.has_function('qsort')
>>     libgit_c_args += '-DINTERNAL_QSORT'
>>   endif
>> -libgit_sources += 'compat/qsort_s.c'
>> +compat_sources += 'compat/qsort_s.c'
>>   if compiler.has_function('getdelim')
>>     libgit_c_args += '-DHAVE_GETDELIM'
>> @@ -1511,7 +1514,7 @@ if meson.can_run_host_binaries() and 
>> compiler.run('''
>>     }
>>   ''', name: 'fread reads directories').returncode() == 0
>>     libgit_c_args += '-DFREAD_READS_DIRECTORIES'
>> -  libgit_sources += 'compat/fopen.c'
>> +  compat_sources += 'compat/fopen.c'
>>   endif
>>   if not meson.is_cross_build() and fs.exists('/dev/tty')
>> @@ -1745,14 +1748,22 @@ else
>>   endif
>>   libgit = declare_dependency(
>> -  link_with: static_library('git',
>> -    sources: libgit_sources,
>> -    c_args: libgit_c_args + [
>> -      '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
>> -    ],
>> -    dependencies: libgit_dependencies,
>> -    include_directories: libgit_include_directories,
>> -  ),
>> +  link_with: [
>> +    static_library('compat',
>> +      sources: compat_sources,
>> +      c_args: libgit_c_args,
>> +      dependencies: libgit_dependencies,
>> +      include_directories: libgit_include_directories,
>> +    ),
>> +    static_library('git',
>> +      sources: libgit_sources,
>> +      c_args: libgit_c_args + [
>> +        '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
>> +      ],
>> +      dependencies: libgit_dependencies,
>> +      include_directories: libgit_include_directories,
>> +    ),
>> +  ],
>>     compile_args: libgit_c_args,
>>     dependencies: libgit_dependencies,
>>     include_directories: libgit_include_directories,
>>
> 
> 

