Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632174EA367
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452267; cv=none; b=jCfxh5hzTnQ5pUY2gUmAsbetqR89Xx7DOVzGH69G7QlC45slBc/8GSnLqtZWwzkeTB39+4n14oNYpluRsKcXjf1if2EqefO12EnkmwANhPyEQjt6PP95YTOmDQ82dF96y1Avkx3+QRAugLdajiRVch/Qfd/4lJD8WqWZt4WSCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452267; c=relaxed/simple;
	bh=O5XKP1vaRz242GMsU7lfAYdPBQgrEgI3Wiixcs2zYc0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=HKcXQLL47Z942YIcUEvowqeych4dGrBgih8O57rxfpd30uN8gxkX6a0xlVpI7pAwGBDwNF02PHGShMU9NUqhgMoI8E2Z0Fqpj+c4b1LBPoeI+oK+MmUNFTtGybPAyNEmkEoPjFI6e6FxAD6Q9UPHSPOeBMScdSlActmZBmUW9D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9qYOXHW; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9qYOXHW"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f4f3683fbcso8503a34.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788452264; x=1789057064; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UGB2i/QkJoVav5uW3gzNrm4HOPShbrm4foTt9mu789o=;
        b=j9qYOXHWKWD28oiGceFJnD2Sg8hQDNdso/4h4SYuRI+IEabPB0+BP/ZwFQuiyeey70
         xsTbX39P31vdjvJL9V1ECP0wRtpgy/jGEDWh8AqgBJtI98lB1dBHuXp7MrcPOhgU6HEg
         kB8If4TFyh1tYIjUSpi98BhIrnkTQeXnKxZ0M7EMGNoPWyxrM+3M72N8J1BT4FcVAPPf
         XaT4zUwTmLSMebjiywob3MVgljvwuhN2mVwp1qkQ1sGwUwe5hl7SMPQ9cANDqiwYhYOf
         2IsBm2+3WBeTLGCiMwJDdptHAb0CaIpe/RE5mK4cVehw0YXy5dH7/KVFBahcNR21wKq/
         T0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788452264; x=1789057064;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UGB2i/QkJoVav5uW3gzNrm4HOPShbrm4foTt9mu789o=;
        b=fe0gi9jMdDkGunzGu4dXqsCZMPVgTzPpk9k3P8RPmBLxJoOZsBceq9Pqm+iAXFgSE2
         N7x6+ZR/04f9buYb7SfrWUtfoi0St01I/EXkP+R3IdL6SeHeM98QnnvAtg3pfd5NIgMI
         gvhxY5dQ43e/2G60UwTxngswhyUn9sPKiYMXHnBUdNmLH4IuWcMRZ5LxuJBp1FLg5ery
         FGovUYwPn57MdQga3D8lUE83yWGsxuSPKAA7igKea9UNrN/tSkkxLS7suy7h5f9lN4to
         H6/ZbRcZznUwFDeXi5kFcfjsaljLvoYWqYhgsPumLJVgxdR7gtf+lFD6/Y9iCC+rsL32
         5zvA==
X-Gm-Message-State: AFuF++nReoNLrWuEb/JoP1hk13leWbeUE0ypNm5rpya4iSv9tT1YK0fg
	McpeGH+SEzAYdbecldibQEvl1EH7m7HYZMU2JZ+xfExtXz9Wj9M3hoYq4WHkEg==
X-Gm-Gg: AYBFou14peIxPoI4lz4wjyg6NYTwI9uKftWe4tNPcvhEqnULgfS8TMb8wcOIbhBDZ7b
	NEQn6s/sSEWrwbPvmlo91nzCPWbCSexlorSKbx0AZGlWg6Rh+qL0w6SFnhBBeANrWsTIiTpiV6d
	qybBethOsmEHe7y+RyOox9Lzs0Qxeffje6qRSuCcpmqYuc1vNvqoYDPxZ9jhoU6H7sbLkowRzVR
	cWBUZxfej6EUdOKXvSoG6QXXP5Z/hukAuYuKzDWbtjvurjuc+uHGKTjFyzQ1iVHzOlZCoD84K/H
	93ljv97uVzlWKRPXiJkO2dhv8YLqJJm+LTpzlzYLgTC0kCMeKV/r2wtAlhpahLxAw5umypp666W
	9zq53gmHJKjoHRGd2F63vOo9RsToptnKb1VrMyDe6A+QqxNLjoLkNhleGc9k1E2WpEs1av4qMCt
	ydfpylDYihz3c3djBiYtRhre/ti0LkwJDGytutTlbOTdZ7fY1n1DiEPkRJK5Tfbpo3
X-Received: by 2002:a05:6830:6ea5:b0:7f9:5a3:c241 with SMTP id 46e09a7af769-7f905a3c462mr1593706a34.24.1788452264246;
        Thu, 03 Sep 2026 09:17:44 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.176.148])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6793f53sm299788a34.6.2026.09.03.09.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:17:43 -0700 (PDT)
Message-Id: <pull.2216.git.1788452262806.gitgitgadget@gmail.com>
From: "chib via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 16:17:42 +0000
Subject: [PATCH] git-gui: drain the cat-file pipe before closing it
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
Cc: chib <chib@foxmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    chib <chib@foxmail.com>

From: chib <chib@foxmail.com>

commit_committree opens "git cat-file commit <parent>" to read the tree
line for the empty-commit check, reads only the first line, and then
closes the pipe while the rest of the commit object (often several
kilobytes of commit message) is still unread.

On Linux this is harmless: the child process dies of SIGPIPE when it
keeps writing, and that is not reported as an error when the pipe is
closed. On Windows there is no SIGPIPE: the native git.exe gets a
broken-pipe error when writing and exits with a non-zero status. Tcl's
[close] then surfaces that as "child process exited abnormally", the
commit is aborted, and the index lock is released with nothing
committed. The failure only shows up once the parent commit's object is
larger than the pipe buffer: in testing with Git for Windows 2.52,
objects up to ~6.5 KiB always succeed while objects of ~9 KiB and up
fail 10 out of 10 times (the threshold is around the 8 KiB pipe
buffer). Amending a commit with a long message therefore triggers it
reliably while short commits slip through. Reading the pipe to EOF
before closing fixes it 10 out of 10 times, and is harmless on POSIX
platforms where the same test succeeds either way.

Read the rest of the pipe before closing it, mirroring what the amend
path already does when loading the parent commit's message.

Signed-off-by: chib <chib@foxmail.com>
---
    git-gui: drain the cat-file pipe before closing it
    
    commit_committree opens "git cat-file commit " to read the tree line for
    the empty-commit check, reads only the first line, and then closes the
    pipe while the rest of the commit object (often several kilobytes of
    commit message) is still unread.
    
    On Linux this is harmless: the child process dies of SIGPIPE when it
    keeps writing, and that is not reported as an error when the pipe is
    closed. On Windows there is no SIGPIPE: the native git.exe gets a
    broken-pipe error when writing and exits with a non-zero status. Tcl's
    [close] then surfaces that as "child process exited abnormally", the
    commit is aborted, and the index lock is released with nothing
    committed. The failure only shows up once the parent commit's object is
    larger than the pipe buffer: in testing with Git for Windows 2.52,
    objects up to ~6.5 KiB always succeed while objects of ~9 KiB and up
    fail 10 out of 10 times (the threshold is around the 8 KiB pipe buffer).
    Amending a commit with a long message therefore triggers it reliably
    while short commits slip through. Reading the pipe to EOF before closing
    fixes it 10 out of 10 times, and is harmless on POSIX platforms where
    the same test succeeds either way.
    
    Read the rest of the pipe before closing it, mirroring what the amend
    path already does when loading the parent commit's message.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2216%2F1dao%2Fgui-drain-catfile-pipe-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2216/1dao/gui-drain-catfile-pipe-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2216

 lib/commit.tcl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/commit.tcl b/lib/commit.tcl
index 89eb8c7b73..5e5f879f0e 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -386,6 +386,10 @@ proc commit_committree {fd_wt curHEAD msg_p} {
 		set fd_ot [git_read [list cat-file commit $PARENT]]
 		fconfigure $fd_ot -encoding iso8859-1
 		set old_tree [gets $fd_ot]
+		# Drain the pipe before closing it: on Windows, closing it
+		# while git cat-file still has output to write makes the
+		# child process exit with a failure status.
+		read $fd_ot
 		close $fd_ot
 
 		if {[string equal -length 5 {tree } $old_tree]

base-commit: 5dcb97869546d600a114ef422a135e2e909c923c
-- 
gitgitgadget
