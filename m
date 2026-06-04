Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE3A48A2BE
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590267; cv=none; b=Jj5ZoIs9N9J20WYf/5G5qG7zoVA1Y67WL6rJhkgPduhU/cWS0dCLfkLCN0yVSCZLRlrWKGobjoxEuPDJs0EuxMQVZLiFpywzI+VBpOsfFOFHJxS1AcggsvshUOQQLV9EVGmU0djLYeJlsEUxL+QiqRi4D+WkoOwMwXDtCmM3gZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590267; c=relaxed/simple;
	bh=pKEgDyRr+gA6fGFmP0ofXvMFe5T3r/aCPXUtKZwtAVo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=k31OQATz0oe0pEQUyBPVfK8uIB/0N70vYlYi4qmXBbxyfrvJsPNi/R4BIwyo9h5LJupjsCPC7mEXaVWv8dgjipnARpQscBRk3EgCzvl++iHRX78hrgDkVYrGabH693EMGcut5sFxh6TJe93VU7wegICtN/hbS8NcjgLsrnAtffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCoR7ZOT; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCoR7ZOT"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1363fe80fe8so1355981c88.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780590263; x=1781195063; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1VK7fFM8X6N/P7i6cTZweEgo6wgNOCjRZs1s1lip8aA=;
        b=dCoR7ZOT2rT/2tfhgNTu+SkFPc47jD4M2gJ81QXLSiafkYSzxv4k56AFpopEyFYFT9
         xZeVLOv2uC+AAF97G1NmjnQ/BxirPLzDlq1PJhyMgHVn43yalRDD/oFeUmocJ2Ooz4IV
         ITK4XHDRcy8owCLbdilyZw0ZzqOTE06LQbR94Ru/3SmWn/7tRJ2GRBYbOQ5KZPSMkNv5
         sK+9bVqfkeGxbBrIxsk4/bRqoVcqBLqnBJAnvdgMHi+JBhULG636gw6pUsnph9V6KK5i
         gNYnpDGw4sRFCSLV+/N8ZzmuCdNDlNeWVw0MDnqahtXoTUmvU93GllBb6zmod86ZW18B
         LGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590263; x=1781195063;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VK7fFM8X6N/P7i6cTZweEgo6wgNOCjRZs1s1lip8aA=;
        b=AopWKCHIfg0K2QmLnRz/hPeEWkn63J0e8ER9fXCwmh2j9r/eWDQfuaiTT5v3gCVw3y
         LDqfBLMkkUAOJRa7lHibNi0UaczJDiTRYDQyYDavP0WtIq+MIBFCtXf1DfXBLj5+9eIC
         bDYgVqCj/GQvaYsQiO4wiFtbcLgwqKHaX+jnQ+jQySsWsfxcQv/TXWLf++4sDyuW1C05
         qt981AOKjsK1xvZMKFLHnKCBgtGBPERC7gh1dhNF2PI8QH3QjgR96ODOZsQtruxGQHTP
         61+pN9cqhB88JXvACinvuvXpXWmK7DTrTyS9HJTT7DQlva0QfLzwcLT4QjryL2/sjmvS
         Dkuw==
X-Gm-Message-State: AOJu0Ywo/T8AVafA9tfEJ4QQbngda809/aboVTIVwj/6u2cG6VJpevHG
	27Y8FuHD/zapZENKdUDhmzALvYq7GIz2/oidRQRFujqHSbwYR53j4UBkdy4R5g==
X-Gm-Gg: Acq92OHp3b5sG5891Vpaa6R6WQVHB6wCw1VE5B9scC6DEcbYiWiw245VerMxWE+Y49y
	8OIaPcUjph6CZcfUdAIxu9w55wVMoLbKQPB8250Dsz9SSbaUbI7ZONJcOwzVgG7XYcgBLMmptZH
	ApjUO4vNTYLaet3y5MbSt+SDutKZ4xil1x8w5Fh4RhamfUnT6qR4L99nhqNGIjNqmUG7L/yb/zp
	8YEVgQDETM3+UAfvFLlNAniYkO6JhoHwRC2yXnoUZlfiy70cp/8OYBDAhxtuUinvqRPpwp8yV2o
	w0rMqwwIOW0wgRlMxDRb1KQ1fLKjTnkkwal+K4p5j4bIdQQlNhqChgJrcWcXjCCGiybewhKg6ZS
	SIohMLRLNLiH0CULEpTKuUfZK4Ext1OOpeon+3NI34ASSW+dAkfSDklmcLrSHn4dtqO1qcjYJov
	EdqDvYFAxDFG1daa9uvYOTc7z5wpn7F2VZxuzUNMpTqPYJJvY=
X-Received: by 2002:a05:7022:3d89:b0:138:22f:9a2c with SMTP id a92af1059eb24-138022f9ba5mr984053c88.5.1780590262686;
        Thu, 04 Jun 2026 09:24:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.233.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5550bcdsm4214208c88.14.2026.06.04.09.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 09:24:22 -0700 (PDT)
Message-Id: <pull.2130.git.1780590261.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 16:24:18 +0000
Subject: [PATCH 0/2] mingw: terminate child processes in a gentler way
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

This patch series consists of two patches that have been carried in Git for
Windows since 2017 an 2018, respectively.

The problem they work around is a fundamental mismatch between Git's
understanding how processes can be terminated and Windows' multi-threading
centric world view (where multi-process architectures are quite, quite
rare), where processes do not tell other processes to terminate gently
(meaning: giving them a chance to run their atexit() handlers).

As such, Git thinks that it can send processes signals to terminate or
force-stop ("kill") them. There are no signals in the Unix sense on Windows,
though. So we try to emulate them. At present, in vanilla Git that means
that we use the TerminateProcess() Win32 API functions, which is most
similar to Unix' SIGKILL and is typically frowned upon because it does not
allow an orderly shutdown of multi-threaded applications. That's definitely
not what Git wants to do: If it wants to terminate a child process, it wants
that child process to clean up any .lock files, for example. And therefore
it wants to send a SIGTERM.

But the SIGTERM signal does not really have any equivalent on Windows. The
closest is to somehow get the target process to call the ExitProcess() Win32
API function. There is a trick that we employ here to do precisely that: we
create a remote thread in the target process, and specify the ExitProcess()
function as the callee. This works because that function matches the
function signature of thread functions enough that we can get away with it,
and because the address of that function is identical between processes
matching the same CPU architecture. Read: This approach does not work when
trying to terminate i686 processes from an x86_64 git.exe. But since it is
rare to mix and match processes of different CPU architectures on Windows
(certainly in Git scenarios), we kind of resort to this best effort that
works often enough to make it worthwhile.

It's a different story for SIGINT: That signal matches most closely what
Windows calls a ConsoleCtrlEvent. It is different, though, in that a
ConsoleCtrlEvent is not sent to a process, but to a Console, and is handled
by all processes that are attached to said Console. In the MSYS2 runtime
that provides the POSIX emulation layer required by the Bash distributed
with Git for Windows, we work around that by using a similar trick as the
SIGTERM/ExitProcess() injection: a thread is injected into the remote
process, passing the address of the (undocumented) kernel32!CtrlRoutine.
This is quite hacky and requires spawning a separate process to just to
figure out the address of said function, which only works in the MSYS2
runtime because it acquires that address once, and then remembers it for the
rest of its lifetime. Git also simply has no business emulating a Ctrl+C and
instead sends child processes SIGTERM. Therefore, there is no support for
sending SIGINT in this patch series. But patch number 2 implements reacting
to the emulated SIGINT "sent" by the MSYS2 runtime.

Johannes Schindelin (2):
  mingw: kill child processes in a gentler way
  mingw: really handle SIGINT

 compat/mingw.c              |  38 +++++++--
 compat/win32/exit-process.h | 165 ++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+), 8 deletions(-)
 create mode 100644 compat/win32/exit-process.h


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2130%2Fdscho%2Fmingw-kill-gentle-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2130/dscho/mingw-kill-gentle-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2130
-- 
gitgitgadget
