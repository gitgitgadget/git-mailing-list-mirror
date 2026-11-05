Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.204.172.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860896;
	b=sK+JvHOfpIPQS8AqcDN12rkw4c5oAcPrcW4QGAtkDgApTwXq0O5/q2CjfNOwMQIqOf26
	 KGNkwRz//yDTqarwK7Sx71JaSPbbHFeQwjYYausTzXXDj7H3UeHcUz3rfaI5vH9kswB44
	 9vsrUvVcap/WFnUD4q0zAXLpYttgUvqzXwStEU5gI58MoPaHl/8Utc2XgJtI8NN1iXGOw
	 WjpOIXIOt52f7k7nJgwpPWQlAMNGbVnaczsp01YOXPkKhojhfYRAso5q4VaU9fsKMlLV5
	 CiOhVCLU8I4lXil3EVNQjBVRtOdu5TnNkrfx6yo2ER4JqueNi13zMpadyDG+cMvPhag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860896;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=s5MEzhRNE5nmftWJfbbFGuCepnUuk5nA5XllHvX95OA=;
	b=HrRnALKwnzLtKtunl2WWrWXvjmcZUWAnUSoCQyIeZ4WeYVMVygFvOgO/rO1BwFUf875Z
	 GcEZ2leHt0TFpC7rLtW3bnmx/TG9+6dcw3UwZJ5Y0wdL0ZlQyvRhiqSsnktfqPOkXCHAt
	 BuO5NjErxGTyfrCDce918lPXntqIsW27lGKMuS6DYnFvuSA1vKJk3FRqim4E904sbag8O
	 uj1iOsb1CCjd5AhCuI3aeQovPXNTe8QziYpKZORZ/TiJJ9glcEIGv/p8bvwS67ZXakOzh
	 qfRsZbOWMQ6gQLasAHzsgzdUS8y0z6NRkAhXl1nU0XXY4B2MC+uJb7wk9dC02d1z7cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wsoptics.de;
	spf=pass smtp.mailfrom=wsoptics.de;
	dkim=pass header.d=wsoptics.de header.i=@wsoptics.de header.a=rsa-sha256 header.s=2019 header.b=QdDmsF5Y;
	arc=none smtp.remote-ip=62.204.172.141
Received: from mail.hq.wsoptics.de (mail.hq.wsoptics.de [62.204.172.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEBE606D809
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 06:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEEBE606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wsoptics.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wsoptics.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=wsoptics.de header.i=@wsoptics.de header.a=rsa-sha256 header.s=2019 header.b=QdDmsF5Y
Received: from [IPV6:2a02:f90:269:fc00::be2] (unknown [IPv6:2a02:f90:269:fc00::be2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.hq.wsoptics.de (Postfix) with ESMTPSA id 7D79D117183
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 07:41:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wsoptics.de; s=2019;
	t=1793860886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s5MEzhRNE5nmftWJfbbFGuCepnUuk5nA5XllHvX95OA=;
	b=QdDmsF5YBgEP9cjBZDkOZJrLiHOwkhokQJQLy2AhDQpkqybHriskjQ25X5MMJxWrZDBczT
	T2dyu/59qi+jbl/uRGwqhAiRFggVXYlla/JCVAKj3tQKI1CSvyz41i4BU3XBnXOarhEuJC
	0Pg5sXuV236D4Y4UZ5h5GLvuXxd1G58fWP68Xoxx55iUGFruQppbztBInr5umO+X6ZRwbo
	xbDp0rbaP/p603XX5oUdZvvnjRTyUoj/4WYEUYnMwnnL+uiwoyVWPFiR2nDyCNUXzDj0nm
	aclJYQ3Jbht9ghA4wOHHuo0bKbgg1Z8Ia9eKu47W3+KSYl5KFEBiLUCNw43K+eDrK9dAIs
	sGDryoeoWMcKDkNWKvHn5Uwz/R2Ywn3yS0DCA+HuwsTI1bMb+l0NBslGbTvAm0RDPqIBIm
	5liSD8yIECx0swcwDXXgeCbtUsoNw/r7QpUzftvCPhuYos+7NesCnawo8J7ZI7EyJC1qBD
	iPb/HBJtHqBi/FnHDFdEIxIrQ9XbmrhDGEfErzFQ4F5dXIpCn7TNQ5f3ZaY+/4yFNBkvGc
	83y5d4yxgR/xI1OGS/TCJHtsBiN1S9pzdk/Qo+rrM/n9d8xUKcdb7KaFmoeZ/O4o31sxH2
	W0z9ENVW8coOzm6RUOpRHLEdqTdJkMu+jq8xPUqJGB+F6iLMg86bA=
Message-ID: <ba964c70-60ab-4b7a-a0fa-6e028e401a09@wsoptics.de>
Date: Thu, 5 Nov 2026 07:41:26 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: git@vger.kernel.org
From: Christoph Weiss <weiss@wsoptics.de>
Subject: [BUG] Geometric maintenance prunes commits without updating
 commit-graph
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

After updating our internal Forgejo instance from 16 to 17, many of our 
repositories' health checks started failing.  This appears to be due to 
the update entailing a switch in Git from 2.52 to 2.54, which in turn 
changed the default maintenance strategy from `gc` to `geometric`.

The following script hopefully reproduces the problem with `geometric`:


#!/bin/sh
set -eu

unset GIT_DIR GIT_COMMON_DIR GIT_WORK_TREE GIT_INDEX_FILE GIT_CONFIG
unset GIT_OBJECT_DIRECTORY GIT_ALTERNATE_OBJECT_DIRECTORIES 
GIT_CONFIG_COUNT GIT_CONFIG_PARAMETERS
export GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL=/dev/null

repro_dir=$(mktemp -d)
printf 'Repository: %s/repo.git\n' "$repro_dir"
git --version
git init --quiet --bare --template= --initial-branch=main 
"$repro_dir/repo.git"
cd "$repro_dir/repo.git"
git config user.name Reproducer
git config user.email repro@example.invalid
git config core.commitGraph true
git config gc.writeCommitGraph true

# Use `gc` here and no error occurs.
git config maintenance.strategy geometric

tree=$(git mktree </dev/null)
base=$(printf 'base\n' | git commit-tree "$tree")
obsolete=$(printf 'obsolete\n' | git commit-tree "$tree" -p "$base")
git update-ref refs/heads/main "$base"
git update-ref refs/heads/obsolete "$obsolete"
git repack -ad
git commit-graph write --reachable --split
git update-ref -d refs/heads/obsolete

# Avoid waiting for Git's default two-week pruning grace period.
touch -t 200001010000 objects/pack/*
first=$(printf 'first\n' | git commit-tree "$tree" -p "$base")
second=$(printf 'second\n' | git commit-tree "$tree" -p "$first")
git update-ref refs/heads/main "$second"
# Packs with three and two objects force geometric maintenance to 
consolidate both.
printf '%s\n' "$first" "$second" | git pack-objects objects/pack/pack 
 >/dev/null

printf '\nBefore maintenance:\n'
git fsck --full --no-dangling

git maintenance run --auto --no-detach

printf '\nAfter maintenance:\n'
git fsck --full --no-dangling


Best,
Christoph
