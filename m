Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31AB672
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739634699; cv=none; b=HOdm+r7GTrYWxvnSn6QzE2BHUna7GeJ1RTSEhtekyMb0+blQLizjv0rHnqv6UuFTzL6kCL+qSHx4DrapblQN2wwoWzRwTM4qHAxlzOp2YATmOeDVRW661F8vYkKNBtFq117vqVP5f2R2nqlPF6T2VM9oAUGfsicMLyG1MtqiIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739634699; c=relaxed/simple;
	bh=tXxsFrj6bbxULLFMtyOFhoKqhIYdzMlXYVpHpCc4M8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUSmYA2mUtocZPp//FDHvAQRK9KHsE06eMz5hhf/JRQkdx/hYWSXUg3KBopWhluIdRv8pfdlARwxSrOdGfFZMUrsoGMm2RfbQVPQSJ6CqMDCusDSD65NgL27QU5rKJYRaFHSVQufpGaq/NTfRLN/3ZAredqx3nVZf1HVA+PHB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHbmymTx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHbmymTx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c4159f87so40873925ad.0
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739634697; x=1740239497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9SKuhmm0WcVZ60zyJSGhkKh+SMfMZtgmh6LVXvYOqk=;
        b=hHbmymTx0yw+tiXJYQKY6KVvVwefT5WEMvD7VmOz9CmHqw1pGVIk3zMUFJpeYs66XX
         S9WrYT+/vM5Bn9zEAe1v4XRdtqO5Srp0j0nZwFSywo6LAHI191IlTSf6/bNZSv2uTm80
         bGq6Uo2SJOkpzG+MQf2ehxaTr5awqKuJSS+0+iLMY7SHRPhWG5STsl8REhpF47DdLf53
         Aj/FsEJo+M5+Hi4mEo3/Au4ADcUdPrHtEKTpvMUEKB6opYCafOtNkzy/3UfGCrrfZ2ql
         POKmeBpO5LUXc/cmcHIT0ZhxT97LdKzWK6DaanjL2LHIE2/ML/5L9+QjU6cTKggHP2jI
         B4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739634697; x=1740239497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9SKuhmm0WcVZ60zyJSGhkKh+SMfMZtgmh6LVXvYOqk=;
        b=ru5WO97s1+xKTDdMT+65WhYYLxZuQx7k7U/Im4OHbNz6N5VDP7xwZ6cZaQaO9ZWEuY
         b0P68PpDyA/LcbLK9sQXv4Jg7DqRDne655COy74WSzbmz6YNYfV1QdzUJmOsPPsM2Ep9
         b4wFt5JhIo0BHmetGDRBE1BQDKgG+FoKgIcxja22lUz2+NW8V0HxN9KYoRmEMNeewmt1
         3hCsd5V5LHqsovKAreAZ6h3bH8x4JGZ1QsOLAhIOaGdtoCRId4efZBXp1eZLkq9hn/sL
         JfIcxEegu+WfStCfPJ/ZlkLw8iADcn3jfjuQJKBQS5CcmXa/j/Ij66kmKoAiC3CpeLpw
         HqmA==
X-Forwarded-Encrypted: i=1; AJvYcCUyFnJdyNGJXdZWFuP3gEgig3K6eLMDvURZoFifTMPD8iY28SWc3j+mw8lHpEgivmGAIXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjTuNb2C9W6SpT34UAarf0VqTG7GasB9vbei/TwCJfltszim68
	ib8jLLlzIW/W/fAdgaeCzlJJlHyMOTgnpF7MRTEVRTAQ+4t3DOCv
X-Gm-Gg: ASbGncsF/sVIAvGKiUmV2vEOVXdyyNubjYGAfFRwKIGfxeyyOUqa/l57T8/kof6l62m
	kS3CpEA3uDZsY72ir0XaLsdAgEhnO/snr/n6QNJ9ZTAS4n9GMlEPJdELm0l/ysqJryhMYR7cgcJ
	yiRhkoH5b334hLjEhNCmKBIFbvN4BO4MWo0HU79tw6KS4wKS3L9WyqE61fD2PmTX7yNN+g7+DvA
	ybx43bzdH09Ex79kYRsBIZZj7jeoadmeBN8CpxGV2wjsvidvxXZtr+0EmuPvCLxtFuD1SJ1oFt4
	rJdq44zF9fbLLwUtZerjhUdc2JBUAWShQWo8IkxT
X-Google-Smtp-Source: AGHT+IGxl/DiYiuHXTunMHdPnNnBfxVwWKeSobtyfeWppviOBCzrFo91s25ZIbqkJoUbXIUJk3cK6A==
X-Received: by 2002:a17:903:2cb:b0:21f:6ce6:7243 with SMTP id d9443c01a7336-221040d84c0mr53137865ad.51.1739634696755;
        Sat, 15 Feb 2025 07:51:36 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d559089asm45024285ad.241.2025.02.15.07.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:51:36 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: christian.couder@gmail.com,
	gitster@pobox.com
Cc: Johannes.Schindelin@gmx.de,
	git@vger.kernel.org,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com
Subject: [PATCH v6 0/6][Outreachy] extend agent capability to include OS name
Date: Sat, 15 Feb 2025 21:20:46 +0530
Message-ID: <20250215155130.1756934-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
References: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For debugging, statistical analysis, and security purposes, it can
be valuable for Git servers to know the operating system the clients
are using.

For example:
- A server noticing that a client is using an old Git version with
security issues on one platform, like macOS, could verify if the
user is indeed running macOS before sending a message to upgrade."
- Similarly, a server identifying a client that could benefit from
an upgrade (e.g., for performance reasons) could better customize the
message it sends to nudge the client to upgrade.

Our current agent capability is in the form of "package/version" (e.g.,
"git/1.8.3.1"). Let's extend it to include the operating system name (os)
i.e in the form "package/version-os" (e.g., "git/1.8.3.1-Linux").
The operating system name is retrieved using the 'sysname' field of 
he `uname(2)` system call or its equivalent.

Including OS details in the agent capability simplifies implementation,
maintains backward compatibility, avoids introducing a new capability,
encourages adoption across Git-compatible software, and enhances
debugging by providing complete environment information without affecting
functionality.

Note that, due to differences between `uname(1)` (command-line
utility) and `uname(2)` (system call) outputs on Windows,
`transfer.advertiseOSVersion` is set to false on Windows during
testing. See the message part of patch 5/6 for more details.

My mentor, Christian Couder, sent a previous patch series about this
before. You can find it here
https://lore.kernel.org/git/20240619125708.3719150-1-christian.couder@gmail.com/

Changes since v5
================
 - Used "-" instead of " " for seperating "version" and "os" in the agent string.

Usman Akinyemi (6):
  version: replace manual ASCII checks with isprint() for clarity
  version: refactor redact_non_printables()
  version: refactor get_uname_info()
  version: extend get_uname_info() to hide system details
  t5701: add setup test to remove side-effect dependency
  agent: advertise OS name via agent capability

 Documentation/gitprotocol-v2.txt | 13 +++---
 builtin/bugreport.c              | 13 +-----
 connect.c                        |  2 +-
 t/t5701-git-serve.sh             | 26 ++++++++++--
 t/test-lib-functions.sh          |  8 ++++
 version.c                        | 69 +++++++++++++++++++++++++++++---
 version.h                        | 10 +++++
 7 files changed, 116 insertions(+), 25 deletions(-)

Range-diff versus v5:

1:  82b62c5e66 = 1:  82b62c5e66 version: replace manual ASCII checks with isprint() for clarity
2:  0a7d7ce871 = 2:  0a7d7ce871 version: refactor redact_non_printables()
3:  0187db59a4 = 3:  0187db59a4 version: refactor get_uname_info()
4:  d3a3573594 = 4:  d3a3573594 version: extend get_uname_info() to hide system details
5:  3e0e98f23d = 5:  3e0e98f23d t5701: add setup test to remove side-effect dependency
6:  8878e9c9ab ! 6:  48cf946f61 agent: advertise OS name via agent capability
    @@ Commit message
     
         Our current agent capability is in the form of "package/version" (e.g.,
         "git/1.8.3.1"). Let's extend it to include the operating system name (os)
    -    i.e in the form "package/version os" (e.g., "git/1.8.3.1 Linux").
    +    i.e in the form "package/version-os" (e.g., "git/1.8.3.1-Linux").
     
         Including OS details in the agent capability simplifies implementation,
         maintains backward compatibility, avoids introducing a new capability,
    @@ Documentation/gitprotocol-v2.txt: form `agent=X`) to notify the client that the
     -"git/1.8.3.1"). The agent strings are purely informative for statistics
     -and debugging purposes, and MUST NOT be used to programmatically assume
     -the presence or absence of particular features.
    -+printable ASCII characters (i.e., the byte range 31 < x < 127), and are
    -+typically of the form "package/version os" (e.g., "git/1.8.3.1 Linux")
    ++printable ASCII characters (i.e., the byte range 33 <= x <= 126), and are
    ++typically of the form "package/version-os" (e.g., "git/1.8.3.1-Linux")
     +where `os` is the operating system name (e.g., "Linux"). `X` and `Y` can
     +be configured using the GIT_USER_AGENT environment variable and it takes
     +priority. The `os` is retrieved using the 'sysname' field of the `uname(2)`
    @@ Documentation/gitprotocol-v2.txt: form `agent=X`) to notify the client that the
      ls-refs
      ~~~~~~~
     
    + ## connect.c ##
    +@@ connect.c: const char *parse_feature_value(const char *feature_list, const char *feature, s
    + 					*offset = found + len - orig_start;
    + 				return value;
    + 			}
    +-			/* feature with a value (e.g., "agent=git/1.2.3") */
    ++			/* feature with a value (e.g., "agent=git/1.2.3-Linux") */
    + 			else if (*value == '=') {
    + 				size_t end;
    + 
    +
      ## t/t5701-git-serve.sh ##
     @@ t/t5701-git-serve.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      . ./test-lib.sh
    @@ t/t5701-git-serve.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +	then
     +		printf "agent=FAKE\n" >agent_capability
     +	else
    -+		printf " %s\n" $(uname -s | test_redact_non_printables) >>agent_capability
    ++		printf -- "-%s\n" $(uname -s | test_redact_non_printables) >>agent_capability
     +	fi &&
      	cat >expect.base <<-EOF &&
      	version 2
    @@ version.c
      #include "gettext.h"
      
      const char git_version_string[] = GIT_VERSION;
    -@@ version.c: const char *git_user_agent_sanitized(void)
    - 
    - 		strbuf_addstr(&buf, git_user_agent());
    - 		redact_non_printables(&buf);
    -+
    -+		if (!getenv("GIT_USER_AGENT")) {
    -+			strbuf_addch(&buf, ' ');
    -+			strbuf_addstr(&buf, os_info());
    -+		}
    - 		agent = strbuf_detach(&buf, NULL);
    - 	}
    - 
    -@@ version.c: int get_uname_info(struct strbuf *buf, unsigned int full)
    - 	     strbuf_addf(buf, "%s\n", uname_info.sysname);
    - 	return 0;
    +@@ version.c: const char *git_user_agent(void)
    + 	return agent;
      }
    -+
    -+const char *os_info(void)
    + 
    ++/*
    ++  Retrieve, sanitize and cache operating system info for subsequent
    ++  calls. Return a pointer to the sanitized operating system info
    ++  string.
    ++*/
    ++static const char *os_info(void)
     +{
     +	static const char *os = NULL;
     +
    @@ version.c: int get_uname_info(struct strbuf *buf, unsigned int full)
     +
     +	return os;
     +}
    ++
    + const char *git_user_agent_sanitized(void)
    + {
    + 	static const char *agent = NULL;
    +@@ version.c: const char *git_user_agent_sanitized(void)
    + 		struct strbuf buf = STRBUF_INIT;
    + 
    + 		strbuf_addstr(&buf, git_user_agent());
    ++
    ++		if (!getenv("GIT_USER_AGENT")) {
    ++			strbuf_addch(&buf, '-');
    ++			strbuf_addstr(&buf, os_info());
    ++		}
    + 		redact_non_printables(&buf);
    + 		agent = strbuf_detach(&buf, NULL);
    + 	}
     
      ## version.h ##
     @@
    @@ version.h: const char *git_user_agent_sanitized(void);
      */
      int get_uname_info(struct strbuf *buf, unsigned int full);
      
    -+/*
    -+  Retrieve, sanitize and cache operating system info for subsequent
    -+  calls. Return a pointer to the sanitized operating system info
    -+  string.
    -+*/
    -+const char *os_info(void);
     +
      #endif /* VERSION_H */

-- 
2.48.1

