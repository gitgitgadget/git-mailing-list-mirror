Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63F214D716
	for <git@vger.kernel.org>; Tue,  7 May 2024 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078324; cv=none; b=tH8LhLMe51Bbq60cVjZ9R+o8x4T0/TgjX4R3OnjdUyEP0AGSqQ6baMXI1enoMo+2X8vsDRXd0SQ3M+SMpuKi1yqtyDYDXtvOV4dV1N8XFakOBTxEEKahyLisEOq1RdgGVSMqSCt+Zl/h+Yd8zGDOt7NUe2iMGs8gcwkSf1ML4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078324; c=relaxed/simple;
	bh=+YG8aO5UYakFGT8z8H3WX2MQCCro+coAtRWBClZToz8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nsdZ0mk7gn3z2bFFBpCg81Yw7dIhmBE311mvkoLhSb4UYhB66zBFhw3GO6z3cw0N4b7ITpidj+du9JZP01d4LSmoG0VK41NmUvjpLNGlZCDZy14xqvlyjW4pacdKYCpGyZ177m/2Rjqnnyhwoo/zH90hnbJSYjfZRg4McqVsSe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=cQMXzcZK; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="cQMXzcZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715078313; x=1715683113;
	i=johannes.schindelin@gmx.de;
	bh=zAuC7ulfu4mW5SUOAMlpwgq+pBsyGDznOmIg84U0EAs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cQMXzcZKNFXczbKMNGyeZs3WGjizqVX92KVPeCQUuKYIwVQnmsA8ViFqFder/e2l
	 F9PPGu3XLllOZgFgpvANnwL/w+uTmol5EO860QnLKoXdYVOvYMT1QgOGG2IAaNbIx
	 WVi6ddsE4uKa+pLlbmoXk85IfXbt83AODAMZphnq9fKfU2zvoWk/iYzbICh+eRoNA
	 kCxhGRtiMfWtwUW/H6KZsG5E35jUdz/mw5t6d3f3o1xIyrZcfD+TOg1Geqp76iSks
	 7JNASfeYDoxWC0f4+ZubyEJRsQ56FLgJOuclATkKNIdVn2dFhHqjZ90lqS7MgHS6+
	 ef4o8f+v/yh4/5zkGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.244]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRjt-1sbiDo0GHh-00da26; Tue, 07
 May 2024 12:38:33 +0200
Date: Tue, 7 May 2024 12:38:31 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] docs: document upcoming breaking changes
In-Reply-To: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
Message-ID: <e1350757-80d6-3ca6-3ef1-4b6ba496ba9e@gmx.de>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Yv3cdK0efIsMDSoJ6+rRyouIpF8h3V1lrYoWKLYRXC3PNCC9sh7
 TEiLpbQVy+KOUj4xTCg6WTyzNG9RVMd1nEtbimFFGdf/U1iRCD+23A45sn59EArPIqJZmps
 OtHj+givAzldfGmXA2/Ck/0EpTWMQ3p9qQA2krSPi85lTsLDl/u238vbUUZCymH1kVunyFW
 BC7lTuOeu96dGsjjK6q4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tXs9UDcxWqQ=;SLwCUe6Y1Gemh9v1C2IsklQ/twe
 xsCkA/aNAG8RXssC5GvyVa6udrMOMOf5CiQs0j+wBkT9q6znBEbPVBGADtqaeVbNZivkz01H3
 h85ztq2/HYATNj9OQqJIYpVbEZEERWkrsKS4p8IJ8e9R/S7gFTQWZcQgEv9BdkROgDaurlIg2
 bJfnJnhekEhGomQG1p4klXBnyI0kDWJj5rWuyq1+F//nuIFsa80rTUIXz2c/5hEigoDG19Twz
 ZQGM5Pw8lHj8IniKLZMvyZB0FZoHDvXQpyxTQHIhYoyEFWoUknEDMhGHrV81waG3MYgMb2TL3
 osL5HI8Nx+9bPOLJVvk91XT680viG9GXZ2qeUlbDi7OC+HX7rnlkGKEDOPR5EotDycmh3W4Nq
 3UAe3zknHpSmIZqeSPkubJ/KRwIdm30qI6xcjW0R604ujTmPoRSvn30hHnj3/L9VJsEf8x4dR
 RO9Tli5D+ldpJC6D1h+C0Mx/GDXEpEL1b7M6Dqf4YpNeDLu10hr4OVaoUyKbd7UFbXa+RKTbw
 o+bjCgkoDnU0TOJWcKvt0DB92zbLefLRf7HBrO3VYYe7si5ojMDVMt4r8QiE869q3h5GN0se2
 LOUN4GpGbMkXqYp4jRw5GvIpPC7HGdMG6dxTk0ooYOsujzf4MygJyZlbVGuk5emb9owaZYdjW
 3hdttRu0f3iP9eqYyMz0AxJ0L633jyohlx/6SpjqFsNuoTpgK4u6SUi+uZmsWiqx+nZZSCPjB
 7uw/eoNDJpGiv7wUQh4O9RVJL4PrJMO6gEDrFSnwKsrCG6vb0YJv3YjzgFkoZ11Qa+DJLGXop
 eju1tsl5ByPGVwGd665JBknMN1ur9L7n0OT3nh4tnrFsE=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 7 May 2024, Patrick Steinhardt wrote:

> Over time, Git has grown quite a lot. With this evolution, many ideas
> that were sensible at the time they were introduced are not anymore and
> are thus considered to be deprecated. And while some deprecations may be
> noted in manpages, most of them are actually deprecated in the "hive
> mind" of the Git community, only.
>
> Introduce a new document that lists upcoming breaking changes to address
> this issue. This document serves multiple purposes:
>
>   - It is a way to facilitate discussion around proposed deprecations.
>
>   - It allows users to learn about deprecations and speak up in case
>     they have good reasons why a certain feature should not be
>     deprecated.
>
>   - It states intent and documents where the Git project wants to go.

I love it.

FWIW my first reaction was: These deprecations should be mentioned in the
release notes of the current versions, as a heads-up. But then I saw the
impressive list you accumulated and agree that it needs to have its own
document.

> The document is _not_ intended to cast every single discussion into
> stone. It is supposed to be a living document that may change over time
> when there are good reasons for it to change.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>
> Please note that this is explicitly marked as a request for comments.
> The proposed list of changes is neither exhaustive, nor do I necessarily
> think that every single item on that list is a good idea. The intent is
> to spark discussions, so some of the ideas on the list are controversial
> by design.
>
> Further note that this is not a "Git 3.0 is around the corner"-style
> document. I do not want to propose that a breaking Git 3.0 should be
> released soonish, and neither do I have the authority to decide that. I
> rather want us to document deprecations such that users, developers,
> hosters and distros are well aware of upcoming deprecations and can
> either speak up or prepare accordingly.
>
> Also, while a minority of the proposed deprecations does have links to
> mailing list threads, the majority doesn't. If we have good discussions
> to link to I'd love to add those links. I hope that some of the items
> will spark discussions that I can link to in v2.
>
> Patrick
>
>  Documentation/UpcomingBreakingChanges.md | 65 ++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/UpcomingBreakingChanges.md
>
> diff --git a/Documentation/UpcomingBreakingChanges.md b/Documentation/Up=
comingBreakingChanges.md
> new file mode 100644
> index 0000000000..94d77a8af1
> --- /dev/null
> +++ b/Documentation/UpcomingBreakingChanges.md
> @@ -0,0 +1,65 @@
> +# Upcoming breaking changes
> +
> +The intent of this document is to track upcoming deprecations for the n=
ext major
> +Git release. It is supposed to be a living document where proposed chan=
ges and
> +deprecations are up for discussion.
> +
> +## Git 3.0
> +
> +### Changes
> +
> +  - The default initial branch name will be changed from "master" to "m=
ain".
> +
> +    Cf. <pull.762.git.1605221038.gitgitgadget@gmail.com>,
> +    <CAMP44s3BJ3dGsLJ-6yA-Po459=3D+m826KD9an4+P3qOY1vkbxZg@mail.gmail.c=
om>.
> +
> +  - The default hash function for new repositories will be changed from=
 "sha1"
> +    to "sha256".
> +
> +  - The default ref backend for new repositories will be changed from "=
files" to
> +    "reftable".
> +
> +### Removals
> +
> + - git-config(1) has learned to use subcommands that replace implicit a=
ctions
> +   (e.g. `git config foo.bar baz`) as well as the action flags (e.g. `g=
it config
> +   --unset-all`). The actions will be removed in favor of subcommands.
> +   Prerequisite for this change is that the new subcommands have been o=
ut for at
> +   least for two years to give script authors time to migrate.
> +
> +   Cf. <ZjiL7vu5kCVwpsLd@tanuki>.
> +
> + - git-http-push(1) can be used to push objects to a remote repository =
via
> +   HTTP/DAV. Support for write support via WebDAV is not in widespread =
use
> +   nowadays anymore and will be removed together with the command.
> +
> + - The dumb HTTP protocol can be used to serve repositories via a plain=
 HTTP
> +   server like Apache. The protocol has not seen any updates recently a=
nd is
> +   neither compatible with alternative hash functions nor with alternat=
ive ref
> +   backends. It will thus be removed.
> +
> + - git-update-server-info(1) generates data required when serving data =
via the
> +   dumb HTTP protocol. Given the removal of that protocol, it serves no=
 purpose
> +   anymore and will be removed together with the protocol. This include=
s the
> +   "receive.updateServerInfo" and "repack.updateServerInfo" config keys=
 and the
> +   `git repack -n` flag.
> +
> + - `$GIT_DIR/branches/` and `$GIT_DIR/remotes/` can be used to specify
> +   shorthands for URLs for git-fetch(1), git-pull(1) and git-push(1). T=
his
> +   concept has long been replaced by remotes and will thus be removed.
> +
> + - git-annotate(1) is an alias for git-blame(1) with the `-c` flag. It =
will
> +   be removed in favor of git-blame(1).

This is the only item I am not quite sure about. Its maintenance cost is
negligible, I would think, and the cost of using a judging command name is
less negligible.

> +
> + - "gitweb" and git-instaweb(1) can be used to browse Git repositories =
via an
> +   HTTP server. These scripts have been unmaintained for a significant =
amount of
> +   time and will be removed.
> +
> + - git-filter-branch(1) can be used to rewrite history of a repository.=
 It is
> +   very slow, hard to use and has many gotchas. It will thus be removed=
 in favor
> +   of [git-filter-repo](https://github.com/newren/git-filter-repo).
> +
> + - githooks(5) can be installed by placing them into `$GIT_DIR/hooks/`.=
 This has
> +   been a source of multiple remote code execution vulnerabilities. The=
 feature
> +   will be removed in favor of `core.hooksDirectory` and the new config=
-based
> +   hooks.

Since I already expressed interest in having this document, especially in
the proposed form of being a _living_ document, i.e. subject to change, I
would like to add:

- The "dashed form", i.e. support for calling `git-<command>` instead of
  `git <command>` in scripts, has been deprecated for a long time and the
  intention is still to remove it.

- The command to import patches from Quilt seems to be used rarely, if
  ever, and will be removed.

- Support for importing repositories from GNU Arch will be removed because
  it would not appear to have any users.

- Support for interacting with CVS repositories (via `cvsimport`,
  `cvsexportcommit` and `cvsserver`) is of dubious use by now, judging by
  the number of times these commands have been mentioned recently. The
  code has been essentially unmaintained, too, and will be removed.

Ciao,
Johannes
