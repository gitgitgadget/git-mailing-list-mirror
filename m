Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E1335BA
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214807; cv=none; b=OeQOETTCZnllD7gw6PXCIXswcx0pbRvnIdgcbnMdBXNokX1vEwhbaR+y2/vbOTQyb52tTF4i42sScYzrZ7W37bMbWYGAnouauTgEwUfEnMXt+Z+LS8tk2Ascu/TbNBx+WM2H/3z1soQYMSs924bleOlke1FiWlNvL9I0ic+fUfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214807; c=relaxed/simple;
	bh=9Rn4gL8GzxJwVdnMWAduheH0ONvzAwt59CO4jl8rY6I=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Gh+2ENbxZunFWjMP1txPoWqQLlAa5SNLt5dus3kwwvQ97+dpTXkfuZF22h4uhoODEP9EOq/a/fjBtogqptcUDARv5aEBoNfzGMMQHc9BINzAyHMMYwKpcDml0zs3ADJXvf2usx4mxON3TsOeEDQbNCV7c5In123bosgYggjcU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI0bcnGl; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI0bcnGl"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7cfccba483eso2426014a34.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 06:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770214805; x=1770819605; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mBvTdngeoAvSEWOSPYhVVueHfKoAwwdGj4vvmQej2uQ=;
        b=iI0bcnGlDTYnOMI2UswVQNRJsMdE3KO+KXcpdKwjsN3Af0rZn76wKmjOB1satmU0Q9
         LaBZyePRnYft50OYNBXP+qFCTlZzUMr99/9lBfOJGYNFQp8uyP1apkQ3tQWFt8+C1LpX
         uAJUnkPN5b+c0Sy3TKt6DK8l/CdQZ01F8rfPbOD7R9csRVr5tYaRl9vPFoR5oFi8O0dH
         oC4/PgRZyjmVid1rR54vxsKeyElnf1TdbLDPff7E96met4ulsBcD6r7NBI4RwVwHBnwY
         4zyMfzKg2xT0u/lGlLuNH/MA1TGd9qUgVb7O3QOXt4nlr8mg8EyhXkm56xcme/tHHlep
         /yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214805; x=1770819605;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBvTdngeoAvSEWOSPYhVVueHfKoAwwdGj4vvmQej2uQ=;
        b=foHiPWHwGxeIOE4OYCABggH75r3mnPPvk3fv3J7U/0rSCdoqFRKB0+2dHBsJTYOkWL
         BnxqPdeSsEgzckMBtWur4mWjH7mdYol5KuR4UJklLLdMgN0rQnR8UNVMkfA2ibMyy1GD
         D8O3JwRNPteJ1OTib6wphFrv6JNPlSGpE7G8DAA/Lnv/2yWb41JwajuvErwKCTPsuVlw
         BFzNBMmiGMpzkZUpAeb9dAchGzgqCGFtteE0iUMuixdW6S9cIFLFZtj0tztmE1v/ip1F
         ToYmV+LXlEDgkDYJB7Xjn6u8Dn0YPmIsBX5HHfsOr7/PxGMqy/fsSPtzQOTV8N4Frvw0
         5i6Q==
X-Gm-Message-State: AOJu0Yz+dkhT0K37MwyGZpqZZt8ihI1g9OtK/DEFWcduNDj9Uyfm+Vop
	7e2Y0GyPo9MgWBUzx5Za0UxG9jmKg5jZeEJ8o6p7/mlteJw7HISdDS/6/WXXEA==
X-Gm-Gg: AZuq6aL4BMw5zD/c6Y0N09i6QnhYJW6NFOfsolzoUP4Wgqee0rHE+Tbeo83MrpsZcoZ
	Z1Qg6erl6fmDwwd6XvKuBrtLJi+HePnX3V15J/TFH0Nn5s6GMPNNUdz4/QUp8KTN9o1lSDmZK0z
	3aCSeaBWnUt4GY/6VkYeS4ezzrH79TtXInnODWzV8MfH5iRV/e7NhToLnDxzmq60PGaNPxBRxmv
	jm3/Jaeieonziy28l8q432qIeSI8KDnAW9hMnQ6YUTz5ZZAyCCyJhhMtYsb03uM2Nx5FLrgWk8H
	bBOmJn/oUoM//hUn7ZdnjEQjTX7xavSV/qESBisinkMUVFn5LgNwzNYZui4k94d7ejzXySRUwC0
	EoN1nlLoIgfF9TBGUcqo+llROikTQyyskaISMyeWJHXxM0th1zw6bh7ywywvy1C4g3P9024KgPl
	daMgjWgHNSSZARmw==
X-Received: by 2002:a05:6830:6ad3:b0:7b0:826e:4002 with SMTP id 46e09a7af769-7d448a7c27amr1816592a34.20.1770214805368;
        Wed, 04 Feb 2026 06:20:05 -0800 (PST)
Received: from [127.0.0.1] ([52.173.182.164])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4490f40d9sm1715064a34.5.2026.02.04.06.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:20:04 -0800 (PST)
Message-Id: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 14:19:52 +0000
Subject: [PATCH 00/11] [RFC] config-batch: a new builtin for tools querying config
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
    Derrick Stolee <stolee@gmail.com>

This RFC explores a new git config-batch builtin that allows tools to
interact with Git's config data with multiple queries using a single
process. This is an orthogonal alternative to the effort to create a stable,
linkable config API. Both approaches have different strengths.

My main motivation is the performance of git-credential-manager on Windows
platforms as it can call git config get dozens of times. At 150-200ms per
execution, that adds up significantly, leading to multiple seconds just to
load a credential that already exists. I believe that there are other
benefits to having this interface available, but I can't recall any
specifics at the moment.

This RFC adds git config-batch with a protocol over stdin/stdout for
executing multiple config queries. The implementation has a limited set of
potential queries, but also creates a model for compatibility for tools to
automatically adapt to different Git versions.

I'm submitting this as an RFC before I've polished all of the details
because I want to make sure I'm going down a good direction. Please focus
feedback in these questions:

 * Is this a worthwhile feature to add to Git?
 * Is this a reasonable protocol for stdin/stdout?
 * How can we structure the code to make it easier to contribute new
   commands in the future?
 * This seems like a place where parallel contributions can be made once the
   baseline is implemented. Is there interest in further contributions to
   expand the commands?

This RFC adds the following commands over stdin:

 1. help lists the available commands, giving the caller an understanding of
    what is available in this Git version.
 2. get loads a value for a given key within a certain scope, with optional
    value patterns.
 3. set assigns a key-value pair in a given scope.
 4. unset removes a key-value pair in a given scope with optional value
    patterns.

Each command has an associated version, in case we need to expand or alter
the functionality in the future. This includes the potential to deprecate
and remove certain versions that we no longer want to support, such as
replacing set version 1 with a version 2 and making version 1 no longer
available. I do hope that we will mostly be able to move with new command
names, such as a set-all command including the options for git config set
--all ... instead of increasing the version of the set command.

There is a -z option that changes the command interface to use
NUL-terminated strings. Two NULs specify a command boundary, which promotes
compatibility with a caller that sends an unknown command. However, this
means that we cannot specify an empty string as a token within a command
unless we add more data. This format uses <N>:<string> to provide the
integer <N> which specifies the length of <string>. This is a little
cumbersome, but the format is intended for tools, not humans.

I have a test integration with git-credential-manager available [1] for
testing. This includes a model for interacting with git config-batch in a
compatible way that will respond to certain features not being available:

 1. If git config-batch fails immediately, then all queries are handled by
    git config.
 2. If git config-batch starts without failure, then the first query is for
    the help command.
 3. As queries come to the config system, the query is checked against the
    available commands advertised by git config-batch. If the appropriate
    command is available, then the query is made in that process. If not,
    then the query uses the existing git config command.

One thing that I think would be valuable to include is a reload command that
signals that the git config-batch process should reload the configset into
memory due to config manipulations in other processes, especially while git
config-batch doesn't have all capabilities from git config. I'll include
that in the first version for review, if this RFC leads to positive support.

[1] https://github.com/git-ecosystem/git-credential-manager/pull/2245

I have a few concerns with this implementation that I'd like to improve
before submitting a version for full review. I list them here so you can see
the flaws that I already see, but also so you can add to this list:

 * We need a reload command (as mentioned above).
 * The tests need to include a submodule and submodule-level config.
 * When specifying the local scope to the get command, the matched value
   does not include worktree or submodule config in the same way that git
   config get --local <key> would.
 * The token-parsing API in this helper is still too complicated to use. I
   should create parsing tooling similar to the parse-opts API so each
   command could specify its use of positional values and optional
   arguments.
 * The use of arg:<arg> to specify an optional argument creates the
   inability to submit a value that starts with arg:. Consider alternative
   ways to specify arguments or to specify that the remaining data in the
   command (including spaces) is a final positional argument.
 * In general, I found myself implementing behavior based on the deprecated
   forms of git config that use the --get or --unset style arguments instead
   of git config (set|unset|get) subcommands. It's worth making sure that
   any references to equivalent git config commands use the new modes.
 * I need to add an --[no-]includes option as a command-line argument that
   signals whether include sections should be followed. I don't believe this
   should be specified on a per-command basis, but I'm open to suggestions.
 * I have an early draft of a technical document detailing the plan for this
   builtin. It has some lists of intended future commands that have not been
   implemented. This would also be a good place to document any parsing APIs
   built to help contributors adding to this builtin.

Thanks, -Stolee

Derrick Stolee (11):
  config-batch: basic boilerplate of new builtin
  config-batch: create parse loop and unknown command
  config-batch: implement get v1
  config-batch: create 'help' command
  config-batch: add NUL-terminated I/O format
  docs: add design doc for config-batch
  config: extract location structs from builtin
  config-batch: pass prefix through commands
  config-batch: add 'set' v1 command
  t1312: create read/write test
  config-batch: add unset v1 command

 .gitignore                                |   1 +
 Documentation/git-config-batch.adoc       | 214 ++++++
 Documentation/meson.build                 |   1 +
 Documentation/technical/config-batch.adoc |  70 ++
 Makefile                                  |   1 +
 builtin.h                                 |   7 +
 builtin/config-batch.c                    | 772 ++++++++++++++++++++++
 builtin/config.c                          | 117 +---
 command-list.txt                          |   1 +
 config.c                                  | 116 ++++
 config.h                                  |  26 +
 git.c                                     |   1 +
 meson.build                               |   1 +
 t/meson.build                             |   1 +
 t/t1312-config-batch.sh                   | 372 +++++++++++
 15 files changed, 1592 insertions(+), 109 deletions(-)
 create mode 100644 Documentation/git-config-batch.adoc
 create mode 100644 Documentation/technical/config-batch.adoc
 create mode 100644 builtin/config-batch.c
 create mode 100755 t/t1312-config-batch.sh


base-commit: 83a69f19359e6d9bc980563caca38b2b5729808c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2033%2Fderrickstolee%2Fbatched-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2033/derrickstolee/batched-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2033
-- 
gitgitgadget
