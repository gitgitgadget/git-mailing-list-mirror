Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4FB20A5D0
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509722; cv=none; b=LV0o5XuzmRG/rnzkT/OwsLZwmvfDNbhxfl3uDOmY/vFJbYTf6Ba7if2xTRIsLIabwP4WcMcOhlDnAvLBJBKi2kKk6etR7pCwILbBrmhSQucFxwC7u6ZQfGIKLSx+xBB8WUFS/2K773tvWQ4p8wJYERfHzqaGqII2APn/ARA4XyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509722; c=relaxed/simple;
	bh=565ZdZR1x9heOOAOVTDTRpG/e5RLzhIhGIkrSfv5VR8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=JM70/to4YYljyraEqQQ+nKz/tfZ7MsqatbZczsyzqIjMk0iaBAnmbsDgrgOcPuVUWqX9asjQJw45ckjkX7cU45CuyqIIeIY/i4yjQZweuHIo1FUAOmsXhwO5kPLS3p7gCDgWnAJUJeQszEDrcD7dbrX/vjBDs8RjHoHIFh7BFL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/6Nc0Ay; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/6Nc0Ay"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361f664af5so22824425e9.1
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 03:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736509719; x=1737114519; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edajGr2NvW41lj07QSpnZ7vKpPHBErjn6/MSHF0iXRc=;
        b=O/6Nc0AyXxeFjZVs32Sb7aKlBjc6hrY+5hu5TxwTarke9xQZUyqemjWFbTdAuVaF5R
         uN5oFPiveAaLXds89MDdvG/HlCZem87xpShg7aWmESySOSPR0VDKKPsZ2WIJ1J2M/rOf
         w9I9k3ImnrnDc2XqEeB6zTVV618Rv4DRvbSu4pnjui3otC/+nXXlH5R8r2KcMC4rpl/u
         anwoKi2K/jHgTF5tKivWVlP9F4emEhBVNWX85RuipykpNvlaQ+dKVS+my3XEZ2o+hDK/
         hUis36U98FyWWFf9cbfKpXDVLX+swrHQCn3xplDQZUdATSTmD/kXagNt8GbbvWmmdSWj
         oQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736509719; x=1737114519;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edajGr2NvW41lj07QSpnZ7vKpPHBErjn6/MSHF0iXRc=;
        b=s5/72H5BXBKwWx7Mks4F/3VuUf0T2UIJeV6ZvWWgxGMR26AWn7c/EOcVfRFQCfIyIF
         44gSzRuXqWdawhDY8hry/fsoeOLtHdWnPqNvHhL5hkCwgIqJPkGYMXqxAeO+D9p/zT9H
         2tfSN35xRiJR1+u+I1AWprRlR/s1sBbFiXprKw1jUdBbgf+bnJ9YkJd6o2sniWPbbwSH
         Sa/Q2Y8negtSblpl+N2C1GZ5v2nmoLYKi/hLw1uSP276XnLwT+Brhmo2EhVe4TAIK5Uj
         8UdrFfBkajD0eP5kd/aud+w3Nj4LgbK+zj+g+s6no5F6nihppOTTltp32JPx+d7Z1F9w
         eCLA==
X-Gm-Message-State: AOJu0YwGlhQOj5rV+IpegChdC0ISX29qaAlr+KBFPjX3x7+OU0nq1moa
	lngTgX5j7UfXN9seF7KhNVP1+sFgLsbj0UiOBwZ7zlY+Tcqn+iWSGdxkYA==
X-Gm-Gg: ASbGncvVK5GLywr7VnoTyKiRyllhm8WlPwhAPew525d3iU7pLcZH94MwE07S0zt/BBW
	Zhq4SAc6vKBDx2tIKP6eYuCWLapC0lxB/WdikkniK4s1QWTAwAf6IZfp/zNzKwPbhZw5r9QnKdI
	GrMhWjboNCoC+MfTC92N3Ev4RrsLbnbwAbhoAWQlcpumOyi6ihd/tlKCQdLc2k2JcWt0qjpB5bx
	ff/vVlhn8YSZiGIWtleF1PCZCkglvYm/5Fy1usoev5SwNQJaS2xer8tPA==
X-Google-Smtp-Source: AGHT+IGltAi/S1gyC0wIv/JWbxikPAyNnmLMlv071CiBgw8r++fVYU1G4Q4hlNa43wHt+eRl9QU5uQ==
X-Received: by 2002:a05:600c:1ca5:b0:436:1971:2a4 with SMTP id 5b1f17b1804b1-436e26c3efamr103105685e9.17.1736509718710;
        Fri, 10 Jan 2025 03:48:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e37d74sm49782045e9.29.2025.01.10.03.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 03:48:38 -0800 (PST)
Message-Id: <pull.1850.v2.git.1736509717426.gitgitgadget@gmail.com>
In-Reply-To: <pull.1850.git.1736432663587.gitgitgadget@gmail.com>
References: <pull.1850.git.1736432663587.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jan 2025 11:48:37 +0000
Subject: [PATCH v2] GIT-VERSION-GEN: allow it to be run in parallel
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

"Why would one want to run it in parallel?" I hear you ask. I am glad
you are curious, because a curious story is what it is, indeed.

The `GIT-VERSION-GEN` script is quite a pillar of Git's source code,
with most lines being unchanged for the past 15 years. Until the v2.48.0
release candidate cycle.

Its original purpose was to generate the version string and store it in
the `GIT-VERSION-FILE`.

This paradigm changed quite dramatically when support for building with
Meson was introduced. Most crucially, a38edab7c88b (Makefile: generate
doc versions via GIT-VERSION-GEN, 2024-12-06) changed the way the
documentation is built by using the `GIT-VERSION-GEN` file to write out
the `asciidocor-extensions.rb` and `asciidoc.conf` files with now
hard-coded version strings.

Crucially, the Makefile rule to generate those files needs to be run in
every build because `GIT_VERSION` could have been specified in the
`make` command-line, which would require these files to be modified.

This introduced a surprising race condition!

And this is how that race surfaces: When calling `make -j2 html man`
from the top-level directory (a variant of which is invoked in Git for
Windows' release process), two sub-processes are spawned, a `make -C
Documentation html` one and a `make -C Documentation man` one. Both run
the rule to (re-)generate `asciidoctor-extensions.rb` or
`asciidoc.conf`, invoking `GIT-VERSION-GEN` to do so. That script first
generates a temporary file (appending the `+` character to the
filename), then looks whether it contains something different than the
already existing file (if it exists, that is), and either replaces it if
needed, or removes the temporary file. If one of the two parallel
invocations removes that temporary file before the other can compare it,
or even worse: if one tries to replace the target file just after the
other _started_ writing the temporary file (but did not finish writing
it yet), that race condition now causes bad builds.

This may sound highly theoretical, but due to the design of Git's build
process, Git for Windows is forced to use a (slow) POSIX emulation layer
to run that script and in the blink of an eye it becomes very much not
theoretical at all. See Exhibit A: These GitHub workflow runs failed
because one of the two competing `make` processes tried to remove the
temporary file when the other process had already done so:

https://github.com/git-for-windows/git-sdk-32/actions/runs/12663456654
https://github.com/git-for-windows/git-sdk-32/actions/runs/12683174970
https://github.com/git-for-windows/git-sdk-64/actions/runs/12649348496

While it is undesirable to run this script over and over again,
certainly when this involves above-mentioned slow POSIX emulation layer,
the stage of the release cycle in which we are presently finding
ourselves does not lend itself to a re-design where this script could be
run once, and once only, but instead dictates that a quick and reliable
work-around be implemented that prevents the race condition without
changing the overall architecture of the build process.

This patch does that: By using a filename suffix for the temporary file
which is based on the currently-executing script's process ID, We
guarantee that the two competing invocations cannot overwrite or remove
each others' temporary files.

The filename suffix still ends in `+` to ensure that the temporary
artifacts are matched by the `*+` pattern in `.gitignore` that was added
in f9bbaa384ef (Add intermediate build products to .gitignore,
2009-11-08).

Helped-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    GIT-VERSION-GEN: allow it to be run in parallel
    
    Changes since v1:
    
     * Appended + again, to get the benefit of the .gitignore pattern that
       prevents the temporary files from being committed.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1850%2Fdscho%2Fasciidoctor-extensions-gen-race-work-around-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1850/dscho/asciidoctor-extensions-gen-race-work-around-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1850

Range-diff vs v1:

 1:  7a1c39b9075 ! 1:  4057596dc16 GIT-VERSION-GEN: allow it to be run in parallel
     @@ Commit message
          guarantee that the two competing invocations cannot overwrite or remove
          each others' temporary files.
      
     -    Incidentally, this also fixes something else: The `+` character is
     -    not even a valid filename character on Windows. The only reason why Git
     -    for Windows did not need this is that above-mentioned POSIX emulation
     -    layer also plays a couple of tricks with filenames (tricks that are not
     -    interoperable with regular Windows programs, though), and previous
     -    attempts to remedy this in git/git were unsuccessful, see e.g.
     -    https://lore.kernel.org/git/pull.216.git.gitgitgadget@gmail.com/
     -
     -    This commit fixes one of the issues that are currently delaying Git for
     -    Windows v2.48.0-rc2.
     +    The filename suffix still ends in `+` to ensure that the temporary
     +    artifacts are matched by the `*+` pattern in `.gitignore` that was added
     +    in f9bbaa384ef (Add intermediate build products to .gitignore,
     +    2009-11-08).
      
     +    Helped-by: Martin Ågren <martin.agren@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## GIT-VERSION-GEN ##
     @@ GIT-VERSION-GEN: sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
       	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
       	-e "s|@GIT_DATE@|$GIT_DATE|" \
      -	"$INPUT" >"$OUTPUT"+
     -+	"$INPUT" >"$OUTPUT".$$
     ++	"$INPUT" >"$OUTPUT".$$+
       
      -if ! test -f "$OUTPUT" || ! cmp "$OUTPUT"+ "$OUTPUT" >/dev/null
     -+if ! test -f "$OUTPUT" || ! cmp "$OUTPUT".$$ "$OUTPUT" >/dev/null
     ++if ! test -f "$OUTPUT" || ! cmp "$OUTPUT".$$+ "$OUTPUT" >/dev/null
       then
      -	mv "$OUTPUT"+ "$OUTPUT"
     -+	mv "$OUTPUT".$$ "$OUTPUT"
     ++	mv "$OUTPUT".$$+ "$OUTPUT"
       else
      -	rm "$OUTPUT"+
     -+	rm "$OUTPUT".$$
     ++	rm "$OUTPUT".$$+
       fi


 GIT-VERSION-GEN | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 6d1cb66d69a..2e2d0811581 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -86,11 +86,11 @@ sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
 	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
 	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
 	-e "s|@GIT_DATE@|$GIT_DATE|" \
-	"$INPUT" >"$OUTPUT"+
+	"$INPUT" >"$OUTPUT".$$+
 
-if ! test -f "$OUTPUT" || ! cmp "$OUTPUT"+ "$OUTPUT" >/dev/null
+if ! test -f "$OUTPUT" || ! cmp "$OUTPUT".$$+ "$OUTPUT" >/dev/null
 then
-	mv "$OUTPUT"+ "$OUTPUT"
+	mv "$OUTPUT".$$+ "$OUTPUT"
 else
-	rm "$OUTPUT"+
+	rm "$OUTPUT".$$+
 fi

base-commit: a60673e9252b08d4eca90543b3729f4798b9aafd
-- 
gitgitgadget
