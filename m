Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEB5366DD6
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989123; cv=none; b=I0L5WHr4RtnvtzAEexN+KFpr0en9W3pwOCkvtqmJq1k/hAGxgBSvlreMV2VZkjkNVzU0jYrC3/laQYnKzzWIrE44YF69uluEhHIyPLuMf3/hoJP99ZCXuHoWmnW1tzSeNQIvWxBmZ/2aDQ8gCJzzvMQEffM6YtOiRZTMnLHao2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989123; c=relaxed/simple;
	bh=YSyPMHm9BzkiI0Qj0XS4lL9DeO4HK6ekieS/cNQdFVw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ixo5ItOcHpCvR202v4Z+AZaB6lMfVa7ZhScFm8nt5ol5gsPkvgREgJh2qcIIIZcohAdXMRlKoKNkCAclbFaW1liaUkC7YxanzZDpQt+TNSxYeccjoPRPc152fAB7ng3jh8TSBB59oUL+GIgJLQjDrofFX/PIWQaQaQqO+HDZly8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZZEzM0E; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZZEzM0E"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so1670393eec.0
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989121; x=1768593921; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1SuQqag5jbQMxvpDmjFXWJvd62WoWrddeEJjV88Skg=;
        b=mZZEzM0Eo3GwCNFldhA0bTOGDxjpl+9NVMZkS8MRRBIz0mNBt8OFsGWd4OWgJZ1Itn
         +lb87RbntFS+dhcb0DC/hsaKEnr6Vsf1oU6cuv5LXP7DJSlwZpfknIV7udXMsZ+0BK61
         BxEbjEoMmpGFMSHh+SLHwX3gweCAh/NY76PsCEWXIJuYI3lwwdaaHh5CnzY9QMLv88Jk
         VFgeznN+dOQYo16jw77QQloySf3G0Otm4Xzba5rJo6kelbw6KbH4esrHM6/eQXl/HgGR
         NwW6VZwFkq9fr66HOzxvESO7H+p8D2t9a+vAaLEAhyZDbfQOpkmUrwArlDD7VbU8lLou
         gd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989121; x=1768593921;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v1SuQqag5jbQMxvpDmjFXWJvd62WoWrddeEJjV88Skg=;
        b=c91VY9uEXE3SEWvNL8Xh9oqjX9uKO2thg+hokcxoEk1nUeLw+YvhUqyQLJwLMoJjfi
         5b3gV1nnKvRgiwOLuvGSQ1loT/GsJRczW/r83EZ0IFKvmvasF5j35dljSoF2m3Et7d+D
         Eo8EgZde86JSZCT8p7C4heM1HfhXf4koGU0te0qzG1sAeTEuRvP/IS0sRUURZAko1Iw9
         1xsSF+5m1TJ+dsHiB96hBPCR1O/PC5BT+4bNFjA3N7Nc5uXxGK08mfq/lUj3RGhhK8I4
         HU3bj27j8jQy2ouMoYU/VT6i69DPLU0j1KUwuo/tAo/W4J7D0En5/3wRdgonVuhD8ZeR
         ANwg==
X-Gm-Message-State: AOJu0YzbKI5qfNqfR2Bj6ykyoNa0ZVf2taQplUufu3WobeEqYWCAHeYo
	vfEJWwTFWZ3WInaVWcaqYmg6P6CHYMoTFoi3gcnAra4ZKheoPd7c6VJVWyauGA==
X-Gm-Gg: AY/fxX5QaqTQFI4R9WTltFjcOSfoA++iOC6cPtGkSJWConbVcuGvklNkxr0xnGmVnVY
	yzybUGwa/yEqekPb+DDi+mQGizskuRIDb9i/HFxVYiTEyYz3xgYZ5iDAxx5mwnpOV7mkIlezK+h
	tq9TuLmunA8Edlb0UDwCtktNb42C1lFqRVSSWZc2kG5eQUO4O8HtW1bp8bg+Bz60ypeqJDsfedu
	3wv3aKwGVb9bB0iccBtaXE+vC1y9yUndx96NxkGWw3ayVG2Bl6HEbhCoHxuOYNot+Lhr1qq6+/Z
	eCUBcH1650LQf3WW5jOUKYrYJhOy6Q6XGuBuORLQiwFPA0xIyKN0tQmdoOzztuXoWWGeHKWWmzh
	wzNGaNGBVpzW8X4ba80wwHdBNpW8BhQp15pKgdoNkuSSWIFWNWnC7cXvoblSeBHlFQQG/b8L3zY
	pgHrXEu+tPxAqnPcX3ZJFAKqvv4Q==
X-Google-Smtp-Source: AGHT+IHJ3wRcKNw7UpovBrKLXjYUTOJ1XrjzciXhsyqFYhwTws1VAYSiNXN4iIxPtBN44Ug+6QDlKw==
X-Received: by 2002:a05:7300:ff4c:b0:2ac:3c35:a6cc with SMTP id 5a478bee46e88-2b16fead510mr11376068eec.20.1767989120618;
        Fri, 09 Jan 2026 12:05:20 -0800 (PST)
Received: from [127.0.0.1] ([172.184.211.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17052dbc7sm11506054eec.0.2026.01.09.12.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:20 -0800 (PST)
Message-Id: <pull.2017.v2.git.1767989109.gitgitgadget@gmail.com>
In-Reply-To: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:04 +0000
Subject: [PATCH v2 0/5] Last preparations before upstreaming Git for Windows' symlink support
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

After preparing Git's test suite for the upcoming support for symlinks on
Windows, this patch series touches up a couple of code paths that might not
seem to be related at first, but need to be adjusted for the symlink support
to work as expected.

This is based on js/test-symlink-windows.

Changes since v1:

 * Fixed Karsten's email address
 * Instead of allowing unlimited symlink target lengths, it is now increased
   from 2*PATH_MAX to 32,767.

Johannes Schindelin (3):
  mingw: do resolve symlinks in `getcwd()`
  init: do parse _all_ core.* settings early
  strbuf_readlink(): support link targets that exceed 2*PATH_MAX

Karsten Blees (2):
  strbuf_readlink(): avoid calling `readlink()` twice in corner-cases
  trim_last_path_component(): avoid hard-coding the directory separator

 compat/mingw.c | 18 +++++++-----------
 environment.c  |  4 ++--
 environment.h  |  2 ++
 lockfile.c     |  4 ++--
 setup.c        |  2 +-
 strbuf.c       |  8 ++++----
 6 files changed, 18 insertions(+), 20 deletions(-)


base-commit: ef6dd000ad813fc34a05c4b9055578df13a2eaa6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2017%2Fdscho%2Flast-preparations-before-mingw-symlinks-support-next-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2017/dscho/last-preparations-before-mingw-symlinks-support-next-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2017

Range-diff vs v1:

 1:  1928738b464 = 1:  eb95a74d6eb mingw: do resolve symlinks in `getcwd()`
 2:  31497b01988 = 2:  9fee7bd16f5 init: do parse _all_ core.* settings early
 3:  dba281027a8 ! 3:  7fe463d68aa strbuf_readlink(): avoid calling `readlink()` twice in corner-cases
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          strbuf_readlink(): avoid calling `readlink()` twice in corner-cases
     @@ Commit message
      
          Use `hint + 1` as buffer size to prevent this.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## strbuf.c ##
 4:  db1feb2293d ! 4:  accb6d5f0ae strbuf_readlink(): support link targets that exceed PATH_MAX
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    strbuf_readlink(): support link targets that exceed PATH_MAX
     +    strbuf_readlink(): support link targets that exceed 2*PATH_MAX
      
          The `strbuf_readlink()` function refuses to read link targets that
     -    exceed PATH_MAX (even if a sufficient size was specified by the caller).
     +    exceed 2*PATH_MAX (even if a sufficient size was specified by the
     +    caller).
      
     -    As some platforms (*cough* Windows *cough*) support longer paths, remove
     -    this restriction (similar to `strbuf_getcwd()`).
     +    The reason that that limit is 2*PATH_MAX instead of PATH_MAX is that
     +    the symlink targets do not need to be normalized. After running
     +    `ln -s a/../a/../a/../a/../b c`, the target of the symlink `c` will not
     +    be normalized to `b` but instead be much longer. As such, symlink
     +    targets' lengths can far exceed PATH_MAX.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    They are frequently much longer than 2*PATH_MAX on Windows, which
     +    actually supports paths up to 32,767 characters, but sets PATH_MAX to
     +    260 for backwards compatibility. For full details, see
     +    https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation
     +
     +    Let's just hard-code the limit used by `strbuf_readlink()` to 32,767 and
     +    make it independent of the current platform's PATH_MAX.
     +
     +    Based-on-a-patch-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## strbuf.c ##
     @@ strbuf.c: ssize_t strbuf_write(struct strbuf *sb, FILE *f)
       }
       
      -#define STRBUF_MAXLINK (2*PATH_MAX)
     --
     ++#define STRBUF_MAXLINK (32767)
     + 
       int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
       {
     - 	size_t oldalloc = sb->alloc;
     -@@ strbuf.c: int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
     - 	if (hint < 32)
     - 		hint = 32;
     - 
     --	while (hint < STRBUF_MAXLINK) {
     -+	for (;;) {
     - 		ssize_t len;
     - 
     - 		strbuf_grow(sb, hint + 1);
 5:  3521180e0f7 ! 5:  9823cbb6df8 trim_last_path_component(): avoid hard-coding the directory separator
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          trim_last_path_component(): avoid hard-coding the directory separator
     @@ Commit message
      
          Prepare that function to be useful also in that context.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## lockfile.c ##

-- 
gitgitgadget
