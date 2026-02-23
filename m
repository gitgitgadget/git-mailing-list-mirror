Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499BC17B425
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771829745; cv=none; b=sv0C+P58waqXYsSxpYCqyI0dV+POIvKpUPm2R2FY/nzm17pnQ/Shb7kM9ueBrWJ+XUKx9kAPdbl2J5q6sQpJ0ifWxPYzawU0PrBwm+OKEoyDx+pzdhzhcVXBKCyHFXi18zcV+wzuSI8A9WTX1wfItC57IRZOwL5XBCrEhChdAWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771829745; c=relaxed/simple;
	bh=ZMwqY7EEm7u2aZmSObE6+IgWBo4dHp6Nz+JVIY7DjJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibbj6HuQWAYjbUkZWqIRmmg0p4uDe1WfIHzTZlIE6wl7OufqOQrCj4kYZnw3hZSDymEoQGZ6DIEXkNZR6vv6nPCBgz+YhDB9esXRox2Xvqi9yVzVKIDFPDyQ77ykkVrsFxRv5zeYJACqul1SeaNEgQisf03d4FHxRsGUnFj3F/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KolhgNsk; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KolhgNsk"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4359228b7c6so3018751f8f.2
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 22:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771829742; x=1772434542; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=88UWfkgdV7SMs6w8Uy33/vU+K4CtJR8ba697MlsD4CU=;
        b=KolhgNskEdRXHOlBYsNebg9BSqwKtRo5cMY9mRFFuJLmu2UmhXbISsU06c8HgGvIpW
         CwW8uR5k9e1kXpqEv8+sozAmKwEMwxm7Cy1J0qv7MKBHgRpqf/PmO8E6lRl+UL5yVMAP
         dJOZhFW5jYT6KbfhoTP2QJSJs4YF5SekBYnWLCLCp3IIhJ5mqmOTuVyDc0Jn7VRjIKeb
         VKISJOdRscOXql/hHKjKHP1aa9gOYyM66/B7HR7fV/aaOr/z4tHnKCjohvuk52A+jmF1
         X3QUXYhTino0o/lNoFAmzzhUay8MfQNpw5M0Xb31KQkae95S3arCnZaSH/suxiKXuz7g
         8wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771829742; x=1772434542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88UWfkgdV7SMs6w8Uy33/vU+K4CtJR8ba697MlsD4CU=;
        b=EpmcpuWem730ZLi7bm4DdslNF5MhYmRuC2FdP5zSSfla2KTotnUlBmEEUYbt6Fg29a
         T5VOK7152GAcJxIZGDYuC5K5ImwFzC1g9brLNRhNsTpbfvsb24pYLBEScCXEoFTuun3j
         QINXLbRJ/2qKUDLhK97H74tQRoaeIPqge1AgCnbdzR+mdL3h01mLYvGdKBIGFAfgSQnJ
         Lal+rCIQ3J+cJNC8Z96iD8zOWROndWVjDfP+rNvVpxqPE93GFS9ddHSNpOi6XwjEMs0m
         1WH0KAKN2R72RG/MICsCM8C7QvqsWTBQrcnI1/b3STxfl/DZd2X0dN1gIfljVSWq/3x1
         VVaA==
X-Gm-Message-State: AOJu0YzZ6SW1oFPPVejyekGJOKCy60cpG75QPFgRm/OIyhhkc1O7oj3h
	kAUbAw0U/HaYxix5N9EO527H3eqLmicCEZFqu58iupYBelLcdyMPrcQy
X-Gm-Gg: AZuq6aL+hMguQCLLUBbvBWUiJmUqmCT3cRxwU4mmjCpbwPQ+0VoOH4Q8Bin+I7weWqq
	mVl4NfQ6LS4L5VlBaucsifjsVgWk66QIJgsP2jbLkCHFk157kcywB4CkxexOLPWaFPxlXYLHAD0
	QW1Ujv+LBUT05Iu3m7bJ4olAeRM0KTa51udlwJKq4jCl4g7EeHb82kYspZQcRR5BmnQIPtoVhHo
	9Yv0l0l+yhMT4dqQYT7h/nPpQvFbyRdDmJTQOSqLkgkDQn5MvMqUJ/wr2biE7DMQQoIEMtl64fw
	LBWh4LAzOGOdaG+GJiNv3eDET/mPBR8rfQEKolbHtVNdCGe8JgWPgQUb3ItM+yqbvqXPJfnsj4e
	DcXXjzvsZ2b95nTcJ5InX+ZejtNXUsKfK8pmiy1MgA7c8fAPD8lkCmwAqlll244Px2PSSYDK8ln
	kmvqkcOpTWWoT3wa5rofSDv8XljhXeCt62cFfrG2n0xRQOxak7fzhoFV+XUJp2XQQqRzJWJKz/L
	+F/kRMlxc0W
X-Received: by 2002:a05:6000:2382:b0:437:8f98:8c91 with SMTP id ffacd0b85a97d-4396f15628cmr15902921f8f.3.1771829741364;
        Sun, 22 Feb 2026 22:55:41 -0800 (PST)
Received: from localhost (20014C4D24E394006E164F6D91ED39D0.dsl.pool.telekom.hu. [2001:4c4d:24e3:9400:6e16:4f6d:91ed:39d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d54a68sm17996592f8f.39.2026.02.22.22.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:55:40 -0800 (PST)
Date: Mon, 23 Feb 2026 07:55:30 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Evan Martin <evan.martin@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] build: regenerate config-list.h when Documentation
 changes
Message-ID: <aZv54vN9DdGsvre/@szeder.dev>
References: <611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>
 <5dcd4e9308100a25603c50fecb36447c0ee4df62.1771682788.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dcd4e9308100a25603c50fecb36447c0ee4df62.1771682788.git.ben.knoble+github@gmail.com>

On Sat, Feb 21, 2026 at 09:07:17AM -0500, D. Ben Knoble wrote:
> The Meson-based build doesn't know when to rebuild config-list.h, so the
> header is sometimes stale.
> 
> For example, an old build directory might have config-list.h from before
> 4173df5187 (submodule: introduce extensions.submodulePathConfig,
> 2026-01-12), which added submodule.<name>.gitdir to the list. Without
> it, t9902-completion.sh fails. Regenerating the config-list.h artifact
> from sources fixes the artifact and the test.
> 
> Since Meson does not have (or want) builtin support for globbing like
> Make, teach generate-configlist.sh to also generate a list of
> Documentation files its output depends on, and incorporate that into the
> Meson build.
> 
> We assume that if a user adds a new file under
> Documentation/config then they will also edit one of the existing files
> to include that new file, and that will trigger a rebuild. Also mark the
> generator script as a dependency.
> 
> While we're at it, teach the Makefile to use the same "the script knows
> it's dependencies" logic.
> 
> For Meson, combining the following commands helps debug dependencies:
> 
>     ninja -C <builddir> -t deps config-list.h
>     ninja -C <builddir> -t browse config-list.h
> 
> The former lists all the dependencies discovered from our output ".d"
> file (the config documentation) and the latter shows the dependency on
> the script itself, among other useful edges in the dependency graph.
> 
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
> 
> Notes (benknoble/commits):
>     Changes from v5 (<611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>):
>     
>     • Reword a confusing sentence in the commit message
> 
>  Makefile               |  5 +++--
>  generate-configlist.sh | 11 ++++++++++-
>  meson.build            |  5 ++++-
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 7f37ad8f58..6f926ffb1f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2688,9 +2688,10 @@ $(BUILT_INS): git$X
>  	cp $< $@
>  
>  config-list.h: generate-configlist.sh
> +	@mkdir -p .depend
> +	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@ .depend/config-list.h.d
>  
> -config-list.h: Documentation/*config.adoc Documentation/config/*.adoc
> -	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
> +-include .depend/config-list.h.d

This breaks the build when something disappears from
Documentation/config/:

  $ git checkout origin/seen
  HEAD is now at 57edfa3ce8 Merge branch 'ty/setup-error-tightening' into seen
  $ ls -l Documentation/config/hook.adoc 
  -rw-rw-r-- 1 szeder szeder 3828 Feb 23 07:50 Documentation/config/hook.adoc
  $ git grep hook.adoc
  Documentation/git-hook.adoc:include::config/hook.adoc[]
  Documentation/howto/meson.build:  'rebuild-from-update-hook.adoc',
  Documentation/meson.build:  'git-hook.adoc' : 1,
  $ make V=1 config-list.h
  /bin/sh ./generate-configlist.sh . config-list.h .depend/config-list.h.d
  $ git checkout 0aabf70f60
  Previous HEAD position was 57edfa3ce8 Merge branch 'ty/setup-error-tightening' into seen
  HEAD is now at 0aabf70f60 build: regenerate config-list.h when Documentation changes
  $ ls -l Documentation/config/hook.adoc 
  ls: cannot access 'Documentation/config/hook.adoc': No such file or directory
  $ git grep hook.adoc
  Documentation/howto/meson.build:  'rebuild-from-update-hook.adoc',
  Documentation/meson.build:  'git-hook.adoc' : 1,
  $ make V=1 config-list.h
  GIT_VERSION=2.53.0.119.g0aabf70f60
  make: *** No rule to make target 'Documentation/config/hook.adoc', needed by 'config-list.h'.  Stop.
  $ grep hook.adoc .depend/config-list.h.d 
  config-list.h: ./Documentation/config/hook.adoc


>  command-list.h: generate-cmdlist.sh command-list.txt
>  
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index 75c39ade20..39ac8845ab 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -2,10 +2,11 @@
>  
>  SOURCE_DIR="$1"
>  OUTPUT="$2"
> +DEPFILE="$3"
>  
>  if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
>  then
> -	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
> +	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT> [<DEPFILE>]"
>  	exit 1
>  fi
>  
> @@ -36,3 +37,11 @@ print_config_list () {
>  	echo
>  	print_config_list
>  } >"$OUTPUT"
> +
> +if test -n "$DEPFILE"
> +then
> +	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
> +	printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
> +		"$SOURCE_DIR"/Documentation/config/*.adoc |
> +		sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFILE"
> +fi
> diff --git a/meson.build b/meson.build
> index 762e2d0fc0..74b459b004 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -720,11 +720,14 @@ endif
>  
>  builtin_sources += custom_target(
>    output: 'config-list.h',
> +  depfile: 'config-list.h.d',
> +  depend_files: [ 'generate-configlist.sh' ],
>    command: [
>      shell,
> -    meson.current_source_dir() + '/generate-configlist.sh',
> +    meson.current_source_dir() / 'generate-configlist.sh',
>      meson.current_source_dir(),
>      '@OUTPUT@',
> +    '@DEPFILE@',
>    ],
>    env: script_environment,
>  )
> 
> Diff-intervalle contre v5 :
> 1:  611a94cd98 ! 1:  5dcd4e9308 build: regenerate config-list.h when Documentation changes
>     @@ Commit message
>          it, t9902-completion.sh fails. Regenerating the config-list.h artifact
>          from sources fixes the artifact and the test.
>      
>     -    Teach the meson build to depend on the Documentation files that
>     -    generate-configlist.sh reads by having it an additional output as a list
>     -    of dependency files, since Meson does not have (or want) builtin support
>     -    for globbing like Make. We assume that if a user adds a new file under
>     +    Since Meson does not have (or want) builtin support for globbing like
>     +    Make, teach generate-configlist.sh to also generate a list of
>     +    Documentation files its output depends on, and incorporate that into the
>     +    Meson build.
>     +
>     +    We assume that if a user adds a new file under
>          Documentation/config then they will also edit one of the existing files
>          to include that new file, and that will trigger a rebuild. Also mark the
>          generator script as a dependency.
>     @@ Commit message
>      
>      
>       ## Notes (benknoble/commits) ##
>     -    Changes from v4 (<9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>):
>     +    Changes from v5 (<611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>):
>      
>     -    • Include Patrick's suggested Makefile changes. Note there's no quiet
>     -      equivalent for mdkir that isn't for the current target's containing
>     -      directory…
>     -    • Make depfile output efficient again, thanks to Phillip.
>     -
>     -    I've kept printf instead of echo (from Patrick/Junio) because I think it
>     -    is easier to reason about ("it works" vs. "did I use this in a way that
>     -    might cause problems").
>     -
>     -    Junio asked about other problematic bytes: the other one I could think
>     -    of (since all the inputs should be paths, anyway) is newlines. I gave
>     -    meson's depfile.py a glance [1], and it looks like they don't handle
>     -    newlines in paths. Other whitespace doesn't appear to be an issue (see
>     -    "elif c in {' ', '\n'}"); I think _most_ characters are just added to
>     -    the filename.
>     -
>     -    [1]: https://github.com/mesonbuild/meson/blob/master/mesonbuild/depfile.py
>     +    • Reword a confusing sentence in the commit message
>      
>       ## Makefile ##
>      @@ Makefile: $(BUILT_INS): git$X
> 
> base-commit: 4a7958ca1415077ce9b1d0a38223ede55da779d9
> -- 
> 2.53.0
> 
