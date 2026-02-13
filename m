Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488523F422
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771012506; cv=none; b=oCsW8OWRCxhy24gixvnepBbTtQGmANswcL/qk+nLhxTurcN5Tnn5OQykJPikAYg0y5afm/F53Hmmz1/3VNmYd4AgBzFHG837LQUbOwRkWTor6LX02/7ktLTOFd87I1vSgT5XWq44oOhho8iM7+SdWuHuIGi/BOt16aAAwp9EOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771012506; c=relaxed/simple;
	bh=V4KgMto+6bIM6rI6crM2PKvNXuWUoQUe+V9sB6ZKmfg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gwL1Q0To3A9FnXshgf0Zd00NneZfyYw2bzkl1O9QreVMBqSbcUp8xTurKrlmM4kiGmKhu5lKemBkXmtScX97L+sks4/jll8gdzqkCcgv8evQCsrg3dKSFFSF+TY7TI+wJ63PhmqwUDqjVV0HJLBIZPkmmDYPgdasLnwnyv/6E0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H58xxZzz; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H58xxZzz"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-896fb37d1f0so25085856d6.2
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 11:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771012503; x=1771617303; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aD/b5iKpHguAeC0jnB0Z+WvM+XZ/OKT1EgCkpZ50+WE=;
        b=H58xxZzzszCaxodPkI0QKpIpx1RPFKUs5yPXRl3rRJpSZQO20aYRcG3ZH366L/s1uC
         M4DfiDzhiWZn7peEph5JyMW+LJFb14SQdxIQbgsfhMm2Nhu+QkHpr+69jPJUs4abgGp3
         pqaeS1DtJB38teHLCDvtZp4wbg2+8tOmZAQacRXIDBeGiuvMO/bdYPIWMbr+HCWI0RK8
         o7qTRVxJQZHsn1ESfmuShChO0hs5SE2CwVSRE1MFGed09j5njmfMYt9xsswgqSJio0ic
         QV2gfGntdb3CwMsJUTD+VEVmEyjqpprzwHur85o0pX2SFoj21qTVxICZjlaYShbA3rNB
         9Vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771012503; x=1771617303;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aD/b5iKpHguAeC0jnB0Z+WvM+XZ/OKT1EgCkpZ50+WE=;
        b=U3OsruovEZoLSbQLd1lBv/OAWnGvdn6e1DpJv9Ck5E4vPWArT5TuKtz/JdkNSmnTcL
         rfXV9tCa/qYIY2D9+QVDxabHiF3eTUSHgevBazdD/vHXTuPTGtuGk+eiacIwIWfVT5bs
         RwUZMobKPNj/d/Qygbw/9Jur2lecu/e3x7CxO3G2plRmN/xKnlhfU8K4QXq6q2Ewmpvy
         qycXTtE1CmkUtGyVWFBz8kWhlzMEDJH9tTDWpE+4z12lGbBwJoRf85tGpWz6uz2zdGw7
         cMiq/b00VWX5OeBmutvnish94c/MB/4Yog73gT4DU8yg1kabC3n9jJfWAuL440wF1jGU
         ToaA==
X-Gm-Message-State: AOJu0Yw6AaHNmr3Q3UIXfBMrhlJGvfFqpHJ0gcxAEvF7wLPw8MGmUdNL
	ZX0xDo0tTe29GIYeCr5yIjH81X7I5ZRbo+6NjnW8UiqlbMjfu9jRyS739PS0Kg==
X-Gm-Gg: AZuq6aKBncmv+qpInklIZQOdpHIMQ1dC6gnifqVs7OEcRuyuKGG879uSbq7ORMnZjQu
	si+bbXT/CBxcr9ryuy4DFWWZYWKHgBHLFQZ5NUvn63iLjc7IfwV+KKMDNXy2n3OuwvAL1yyYH55
	TfFrHwKLQKdVe7bxZqfQEgO3k67di+49TU/tQkkcK55YzOOP8byd0Ns870bMVCS9CkJ0CZLVWuG
	N4O8TpU0rIJUF+hqFtG7/FCcws1RivbJqrJIYbBref4H3rfvU8PprYE9T/aRYmIRqxA89PHJCXJ
	dd394OnPy9WxWTVkACBiJur6yi++9BBBy7QCPf5ZWkiPR9nU+LtCN+ZNH/zuunp7LTicqkqMRFJ
	3Fg0lyIOrk1CcOLoS8ZqIWm1VGsL9TVQyIKLJiiAbAjx3GwmbX7m/jOmbMjF+oNyvG85caGUu7G
	Rf7MPxyru4bsTxv1pGIDTBS2+w
X-Received: by 2002:a05:6214:242c:b0:894:6b9e:253e with SMTP id 6a1803df08f44-897404b8296mr11409626d6.52.1771012502624;
        Fri, 13 Feb 2026 11:55:02 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7dc1csm70953586d6.10.2026.02.13.11.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:55:02 -0800 (PST)
Message-Id: <pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 19:54:54 +0000
Subject: [PATCH v2 0/6] trace2: add macOS and Windows process ancestry tracing
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
Cc: gitster@pobox.com,
    stolee@gmail.com,
    johannes.schindelin@gmx.de,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>

In 353d3d77f4 (trace2: collect Windows-specific process information,
2019-02-22) Windows-specific process ancestry information was added as a
data_json event to TRACE2. Furthermore in 2f732bf15e (tr2: log parent
process name, 2021-07-21) similar functionality was added for Linux-based
systems, using procfs.

Let's teach Git on macOS to also gather process ancestry information, and
emit it as a cmd_ancestry TRACE2 event.

Furthermore, let's refactor the Windows implementation to align with the
Linux and macOS versions - by emitting the ancestry information as a
cmd_ancestry event. We keep the older, custom data_json event type on
Windows for compatibility for consumers of the TRACE2 data that use the
older event.

Finally, we add tests of the cmd_ancestry events in the new t0213 test
script. Extend the trace2 test helper to allow us to execute commands with a
known process in the ancestry ("test-tool"); we use this to allow tests to
filter out the uncontrolled environment (how the test script was run, and on
what system).

Thanks, Matthew


Updates in v2
=============

 * On macOS do not filter out PPID 1 or 0, to match what the Linux
   implementation does.
   
   Stopping before PID 1 and 0 means we do not emit the launchd init process
   on macOS. The Linux implementation does not do this, nor does the Windows
   implementation.

 * Add t0213-trace2-ancestry tests and extend the trace2 test helper.
   
   The tests use the "400ancestry" test helper to spawn child processes with
   controlled trace2 environments. Verify that the process ancestry is being
   correctly captured on platforms that support cmd_ancestry.

 * Drop USE_THE_REPOSITORY_VARIABLE macro as it was not required.

 * Updated commit messages to use more standard format to refer to existing
   commits.

Matthew John Cheetham (6):
  trace2: add macOS process ancestry tracing
  build: include procinfo.c impl for macOS
  trace2: refactor Windows process ancestry trace2 event
  trace2: emit cmd_ancestry data for Windows
  test-tool: extend trace2 helper with 400ancestry
  t0213: add trace2 cmd_ancestry tests

 compat/darwin/procinfo.c                 |  97 ++++++++++++
 compat/win32/trace2_win32_process_info.c |  58 ++++----
 config.mak.uname                         |   2 +
 contrib/buildsystems/CMakeLists.txt      |   2 +
 meson.build                              |   2 +
 t/helper/test-trace2.c                   |  59 ++++++++
 t/meson.build                            |   1 +
 t/t0210-trace2-normal.sh                 |   5 +-
 t/t0213-trace2-ancestry.sh               | 180 +++++++++++++++++++++++
 9 files changed, 379 insertions(+), 27 deletions(-)
 create mode 100644 compat/darwin/procinfo.c
 create mode 100755 t/t0213-trace2-ancestry.sh


base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2040%2Fmjcheetham%2Ftrace2-macos-ancestry-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2040/mjcheetham/trace2-macos-ancestry-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2040

Range-diff vs v1:

 1:  d99a30a1a7 ! 1:  233f6cdd33 trace2: add macOS process ancestry tracing
     @@ Metadata
       ## Commit message ##
          trace2: add macOS process ancestry tracing
      
     -    In 353d3d77 (trace2: collect Windows-specific process information)
     -    Windows-specific process ancestry information was added as a data_json
     -    event to TRACE2. Furthermore in 2f732bf1 (tr2: log parent process name)
     -    similar functionality was added for Linux-based systems, using procfs.
     +    In 353d3d77f4 (trace2: collect Windows-specific process information,
     +    2019-02-22) Windows-specific process ancestry information was added as
     +    a data_json event to TRACE2. Furthermore in 2f732bf15e (tr2: log
     +    parent process name, 2021-07-21) similar functionality was added for
     +    Linux-based systems, using procfs.
      
          Teach Git to also log process ancestry on macOS using the sysctl with
          KERN_PROC to get process information (PPID and process name).
     @@ Commit message
      
       ## compat/darwin/procinfo.c (new) ##
      @@
     -+#define USE_THE_REPOSITORY_VARIABLE
     -+
      +#include "git-compat-util.h"
      +#include "strbuf.h"
      +#include "strvec.h"
     @@ compat/darwin/procinfo.c (new)
      +	strvec_push(names, name.buf);
      +
      +	/*
     -+	 * Recurse to the parent process. Stop if ppid is 0 or 1
     -+	 * (init/launchd) or if we've reached ourselves (cycle).
     ++	 * Recurse to the parent process. Stop if ppid not valid
     ++	 * or if we've reached ourselves (cycle).
      +	 */
     -+	if (ppid > 1 && ppid != pid)
     ++	if (ppid && ppid != pid)
      +		push_ancestry_name(names, ppid, depth + 1);
      +
      +cleanup:
 2:  c786a038f3 = 2:  546fcc3446 build: include procinfo.c impl for macOS
 3:  7ccd0a9a6d ! 3:  2b02f62f0d trace2: refactor Windows process ancestry trace2 event
     @@ Metadata
       ## Commit message ##
          trace2: refactor Windows process ancestry trace2 event
      
     -    In 353d3d77 (trace2: collect Windows-specific process information) we
     -    added process ancestry information for Windows to TRACE2 via a data_json
     -    event. It was only later in 2f732bf1 (tr2: log parent process name) that
     -    the specific cmd_ancestry event was added to TRACE2.
     +    In 353d3d77f4 (trace2: collect Windows-specific process information,
     +    2019-02-22) we added process ancestry information for Windows to TRACE2
     +    via a data_json event. It was only later in 2f732bf15e (tr2: log parent
     +    process name, 2021-07-21) that the specific cmd_ancestry event was
     +    added to TRACE2.
      
          In a future commit we will emit the ancestry information with the newer
          cmd_ancestry TRACE2 event. Right now, we rework this implementation of
 4:  a06344dc75 ! 4:  6b9054115e trace2: emit cmd_ancestry data for Windows
     @@ Metadata
       ## Commit message ##
          trace2: emit cmd_ancestry data for Windows
      
     -    Since 2f732bf1 (tr2: log parent process name) it is now possible to emit
     -    a specific process ancestry event in TRACE2. We should emit the Windows
     -    process ancestry data with the correct event type.
     +    Since 2f732bf15e (tr2: log parent process name, 2021-07-21) it is now
     +    now possible to emit a specific process ancestry event in TRACE2. We
     +    should emit the Windows process ancestry data with the correct event
     +    type.
      
          To not break existing consumers of the data_json "windows/ancestry"
          event, we continue to emit the ancestry data as a JSON event.
 -:  ---------- > 5:  b9a94291a6 test-tool: extend trace2 helper with 400ancestry
 -:  ---------- > 6:  6a5232540e t0213: add trace2 cmd_ancestry tests

-- 
gitgitgadget
