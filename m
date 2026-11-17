Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794876266;
	b=pPItiIi0paOxuRUp1+znYlBBg2mFJGCLnLtbvbs4Onxg9bhfhMbqXyBXdJSM9zrKHNya
	 xXoIuuj5KUbRB+ZYrPgDPKdfZF84VcE63IxUf4ia4lGJkRHScFX2SFO9J0H80be15IUY5
	 4s31tAhs+5Q1YchE8dtANzqjgV59Evlk5rMLN3MHmYrt7z7xVKB+SYo2013Z8z0sF/Ftz
	 qJTyaWg9+bhQaISeUS/AT0mt2MDHZkFf3xGA2liN2cRaZvxLWP9sv6fg1oc8aKgL9uC6r
	 oPpWrXyntorcldfeswBquU/qTtKsrqBqGM5Or5LM+RMYcJ5D/x7EQ9HYdnCgjZDvJGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794876266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gyjBiekkPv6DWq0OyFEwHtb+7MBgqKby8gnjtjgWc8g=;
	b=BNU5+ieRWp73RvAOVpeYRKQFfPdieeVXMmQQImZ0QX06frBbzI0o5G3vEaWb2SfDZ2VT
	 g9T9xjGQK8PlpWy+gxvZWTf9UFUY+mBFXup03ZiJm1tzDJcdzngRb9vNWYhBZQWZSvzt+
	 nUMuo9sHFirU3fgDSECJJHlgDOqmxc6VRvSVZVeG8tl+flJP/mhVTHJpf6oYLf5xYHSlJ
	 +u98b5FgB4AQlG512vG+MC/1fNwGI9whlGd3dT+F2FO341YsJVac5yVNl93otbo4kiX29
	 P5N0uZfb73crUrWGsswwxx7jeLZQ4j6avNvziyeQrOdaQddmC5JvyxcDnsZ7rdq8eSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bLq9D3PJ;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028D606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 00:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6028D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bLq9D3PJ
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a33359c1b3so348691f8f.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 16:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794876265; x=1795481065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gyjBiekkPv6DWq0OyFEwHtb+7MBgqKby8gnjtjgWc8g=;
        b=bLq9D3PJahG76rDD/m3RCw8tP5LQIBAb/kl4n9YP5ie5bcVfmDiwnTJBjXIuvdvxYl
         ST1uhf3Dk34MD7J27tjsK8+/pKRI+5J8fYICY22et2+z0+YhwP9FI56sMG/TSngI/APP
         HjSxXl3uQI0kq1Jlssi68z02AakZP+22s2nCFKXQQlToA0A3UeKy2zFx2GIS0IazLLxi
         x2hsHQTxH/XQs8OJGZ4tNqVejlXgeDjYGtZTCOegZoF8YInX82Hvpy3SmTsCCSLYZV2V
         Dqhsyc05VrUKadfooVD36+VCF5caBzsnN+mAB07ZtTR8MvyoKJaw+WTi+GSCMvZERLZG
         ssrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794876265; x=1795481065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gyjBiekkPv6DWq0OyFEwHtb+7MBgqKby8gnjtjgWc8g=;
        b=AqhJ7fjhFqfd63zeIggyjx865L9iF5Aauvk4ye6tPVm+Txr8X5fqpjOyhuy91CkSqE
         4vMlQvLDxv1gMnyhHdE4kP3UQno9TTUR8ssljFF3csD0VZz0hsU+GCtgTV8Ro9fSB4+F
         0L0e7oNtP+WZdCpQri3ukLyCk/29bPoDjVRVoXWJ9qgC20NK2sWJu3sEx7nEGLPkvqSn
         Hw4U/hB18HN4Dbqyw/C5cUDvH6orvoGRWfVRHkFGl4NWyzbRVVw7ZpNiOpzMCXDpQ1R9
         l+tucFg7oSaCEbByFj/6ZTQvmYfzQqdp57cMkEamGTDBbE8vcHUt9UqlMVTyGpXBBP0l
         cFUg==
X-Gm-Message-State: APuU4Z8Y9YD1Bi0WrDsBNhC1MSUBq8okUfQuAANz3bi+AVPDpmy7HHkm
	JVClWvlqPRLris/bvvcjeyjsAPsIwaRWmFcMCIVXJO8TDvyDlPgHN9mEtIPwCPM05Yw=
X-Gm-Gg: AZFdTZdAJWcPzs5iE61vG5yf/HOnFSDowuXNAPiAcgDdbsUyYZPu+pufSfBWrlvcLsW
	sJIx0IN/4TD36ypI3H/idyOFSql3OCKOQA5QV0lA5n3ayoSv5j60b4fpoalywegpkg/KamHcx7D
	t6681n3/afR572tvivVlTb7YcR5l572Ol7TZt3Ybn47rQQ0tWhlFWmvGr9A4pNRg7jdM/7EpURT
	5LQPtyFQZobBJhyNGmzAudA3UAHo3x01GbxGpbTjPS4fKj8uUjqUJFEM9ugkDEVuQZH1cRWIzAz
	y0IhW7Jm9Mq5ONJoe7h/I/uMNVq6Nkxfq58e3RD33rVmgGpfUc2QArKBn+2H/uTpQtw/nkPGiE9
	Qtl0C6Q5aWsxx0HY9dxaoiezhAX2w9F13a5dadnPG0LDa6NkSgvolJ9E9Yba0DUKIMUVOy4mEmL
	qz8V/qfzX90Tsqd/PrMcLpN6JojptIbnsAzZLM8DD4aqPktt8tLNLEN/IcWKsYM/X3UubAn4mwa
	KkBAkO0uHgAjorD23wN6P3fTNH/CwKGFyAIpfFCNesin4I7gMGc2tH1S55wlVw2CNTtDwvye9GJ
	DX8zg2ziXaBQgKdnuB5nc7HCIfWtFIYbrTznVniltzjUfriFjxDSiNwBLJyrDDpviwkcxk46ZJz
	zhGfQlI6A5pB7DpPCxY3IkzE3FmUtVI1KTw==
X-Received: by 2002:a05:6000:46ca:b0:493:bd29:a6e3 with SMTP id ffacd0b85a97d-49c70ed913cmr17779520f8f.15.1794876264411;
        Mon, 16 Nov 2026 16:44:24 -0800 (PST)
Received: from HP ([102.0.122.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a3d39b8a37sm953876f8f.46.2026.11.16.16.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 16:44:23 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: siddharthasthana31@gmail.com,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	jackrawlings2011@gmail.com,
	christian.couder@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v3 0/3] apply: reject corrupt "diff --git" headers
Date: Tue, 17 Nov 2026 03:43:45 +0300
Message-ID: <20261117004348.806694-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261114012055.127905-1-tangajoris@gmail.com>
References: <20261114012055.127905-1-tangajoris@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git apply --check" dies on an assertion in check_preimage() for some
patches with a broken "diff --git" header. This series reports these
patches as errors instead.

1/3 fixes a leak in parse_git_diff_header().
2/3 rejects a patch that is read under an empty "diff --git" line,
like a "diff --git" line with a blank line after it.
3/3 rejects a new file with a "---" line before "new file mode", and
a deleted file with a "+++" line before "deleted file mode".

Changes since v2:
 - Added 1/3, which frees patch->def_name before setting it, as
   Siddharth suggested. It brings back the test for an empty
   "diff --git" line followed by another one, which v2 dropped.
 - 2/3 is unchanged, apart from where its tests sit in the file.
 - 3/3 names the "---" or "+++" line in the error, instead of the
   file name, which was "dev/null" for "/dev/null", as Siddharth
   suggested.
 - Fixed a broken line in the 3/3 commit message.

Tanga Joris (3):
  apply: free the old def_name in parse_git_diff_header()
  apply: reject a patch after an empty "diff --git" line
  apply: reject new and deleted files that have both names

 apply.c                    |  32 ++++++++-
 t/t4133-apply-filenames.sh | 135 +++++++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+), 1 deletion(-)

Range-diff against v2:
-:  ---------- > 1:  8136f837a9 apply: free the old def_name in parse_git_diff_header()
1:  3b802e3053 ! 2:  048574a48f apply: reject a patch after an empty "diff --git" line
    @@ t/t4133-apply-filenames.sh: test_expect_success 'apply diff with old filename mi
     +	reject_empty_git_header later_line.diff 3
     +'
     +
    - test_done
    + test_expect_success 'ignore an empty "diff --git" line before a git patch' '
    + 	test_when_finished "rm -f g" &&
    + 	echo 1 >g &&
2:  f2d40ed931 ! 3:  b3da07db98 apply: reject new and deleted files that have both names
    @@ Commit message
         lines, 2017-06-27) made apply report other conflicting header lines,
         instead of leaving them to an assertion. Do the same here. After the
         header is read, reject a new file that has an old name. Reject a
    -    deleted file that has a new name too.
    +    deleted file that has a new name too. The error names the "---" or
    +    "+++" line that came before the mode line. It does not print the
    +    name, because for "/dev/null" that would be "dev/null".
     
         Git always writes the mode line first, so patches made by Git are not
    -    affected. A patch with
    -    "+++ /dev/null" before "deleted file mode" used to apply without -R.
    -    It is now rejected too.
    +    affected. A patch with "+++ /dev/null" before "deleted file mode" used
    +    to apply without -R. It is now rejected too.
     
    +    Helped-by: Siddharth Asthana <siddharthasthana31@gmail.com>
         Signed-off-by: Tanga Joris <tangajoris@gmail.com>
     
      ## apply.c ##
    @@ apply.c: int parse_git_diff_header(struct strbuf *root,
      	}
     +	if (patch->is_new > 0 && patch->old_name) {
     +		if (patch_input_file)
    -+			error(_("git diff header for new file %s names an old file %s at %s:%d"),
    -+			      patch->new_name, patch->old_name,
    -+			      patch_input_file, *linenr);
    ++			error(_("git diff header has \"---\" before \"new file mode\" at %s:%d"),
    ++			      patch_input_file, patch->extension_linenr);
     +		else
    -+			error(_("git diff header for new file %s names an old file %s (line %d)"),
    -+			      patch->new_name, patch->old_name, *linenr);
    ++			error(_("git diff header has \"---\" before \"new file mode\" (line %d)"),
    ++			      patch->extension_linenr);
     +		return -128;
     +	}
     +	if (patch->is_delete > 0 && patch->new_name) {
     +		if (patch_input_file)
    -+			error(_("git diff header for deleted file %s names a new file %s at %s:%d"),
    -+			      patch->old_name, patch->new_name,
    -+			      patch_input_file, *linenr);
    ++			error(_("git diff header has \"+++\" before \"deleted file mode\" at %s:%d"),
    ++			      patch_input_file, patch->extension_linenr);
     +		else
    -+			error(_("git diff header for deleted file %s names a new file %s (line %d)"),
    -+			      patch->old_name, patch->new_name, *linenr);
    ++			error(_("git diff header has \"+++\" before \"deleted file mode\" (line %d)"),
    ++			      patch->extension_linenr);
     +		return -128;
     +	}
      	patch->is_toplevel_relative = 1;
    @@ apply.c: int parse_git_diff_header(struct strbuf *root,
      }
     
      ## t/t4133-apply-filenames.sh ##
    -@@ t/t4133-apply-filenames.sh: test_expect_success 'name the empty "diff --git" line in the error' '
    - 	reject_empty_git_header later_line.diff 3
    +@@ t/t4133-apply-filenames.sh: test_expect_success 'ignore an empty "diff --git" line before a git patch' '
    + 	test_cmp expect g
      '
      
     +for old in /dev/null a/f
    @@ t/t4133-apply-filenames.sh: test_expect_success 'name the empty "diff --git" lin
     +		+1
     +		EOF
     +		test_must_fail git apply --check old_before_new.diff 2>err &&
    -+		test_grep "header for new file f names an old file" err
    ++		test_grep "has \"---\" before \"new file mode\" at old_before_new.diff:4" err
     +	'
     +done
     +
    @@ t/t4133-apply-filenames.sh: test_expect_success 'name the empty "diff --git" lin
     +	-1
     +	EOF
     +	test_must_fail git apply --check new_before_delete.diff 2>err &&
    -+	test_grep "header for deleted file f names a new file" err &&
    ++	test_grep "has \"+++\" before \"deleted file mode\" at new_before_delete.diff:4" err &&
     +	test_must_fail git apply --check -R new_before_delete.diff 2>err &&
    -+	test_grep "header for deleted file f names a new file" err
    ++	test_grep "has \"+++\" before \"deleted file mode\" at new_before_delete.diff:4" err
     +'
     +
      test_done

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.43.0

