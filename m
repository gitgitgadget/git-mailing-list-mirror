From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] hooks: Add ability to specify where the hook directory is
Date: Mon, 25 Apr 2016 13:33:22 -0700
Message-ID: <xmqqlh41junh.fsf@gitster.mtv.corp.google.com>
References: <CACBZZX7jTHqSq0ADJxO0cP+1MZMWAowLMMj4J0NHkFTYOYsJiw@mail.gmail.com>
	<1461532702-4045-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 22:33:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aunCF-0003dL-0v
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 22:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbcDYUd0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 16:33:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933411AbcDYUd0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 16:33:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A33D116761;
	Mon, 25 Apr 2016 16:33:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nIc/Bxa3BS3c
	nJoNA3qm+MJWiLc=; b=Ne0CCA31Kti4bwZMmDoQz1MGuqfaKp1OPNtUIGvmAtXB
	1UwK6MTqGPjXtZwCZPauQp/ZBdIt412MFHxWt1YHJI2aYTd3X/XDkaWe+y+o3A9O
	cARRA2/I0g5lJkJQ1IDc05jgzBzhe7LRvmAfmn5IrIsYLhqIWsxmKIX5r3mRZLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=b+XEjH
	7m1c5GV2zE5nBar9GnLA1L25aHRRStLNYTsY9bBtE9JtBhjvWv+3uDSOF1+3rG3q
	kRZaazn6zeCMTz2qHgUqb1QfHPcAp1XHTE4RZRKRhh+/iguvtcBqke02GnA4YDBQ
	CTo206WHaH2Gcr+nkXhLcs45tuf3kSlbGC4EY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AB3F16760;
	Mon, 25 Apr 2016 16:33:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F16221675F;
	Mon, 25 Apr 2016 16:33:23 -0400 (EDT)
In-Reply-To: <1461532702-4045-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 24 Apr
 2016 21:18:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F516915A-0B24-11E6-82CA-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292552>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +core.hooksPath::
> +	By default Git will look for your hooks in the
> +	'$GIT_DIR/hooks' directory. Set this to different path,
> +	e.g. '/etc/git/hooks', and Git will try to find your hooks in
> +	that directory, e.g. '/etc/git/hooks/pre-receive' instead of
> +	in '$GIT_DIR/hooks/pre-receive'.
> ++
> +The path can either be absolute or relative. In the latter case see
> +the discussion in the "DESCRIPTION" section of linkgit:githooks[5]
> +about what the relative path will be relative to.

=2E.. which does not seem to appear there, it seems?

>  DESCRIPTION
>  -----------
> =20
> -Hooks are programs you can place in the `$GIT_DIR/hooks` directory t=
o
> -trigger action at certain points. Hooks that don't have the executab=
le
> -bit set are ignored.
> +Hooks are programs you can place in a hooks directory to trigger act=
ion
> +at certain points. Hooks that don't have the executable bit set are
> +ignored.
> +
> +By default the hooks directory is `$GIT_DIR/hooks`, but that can be
> +changed via the `core.hooksPath` configuration variable (see
> +linkgit:git-config[1]).

The section talks about what the cwd of the process that runs the
hook is, but it is not clear at all from these three lines in
core.hooksPath description above how the cwd of the process is
related with the directory the relative path will be relative to.

Unless the readers know that the implementation makes sure that the
process chdir'ed to that final directory before calling find_hook(),
that is.  And I do not think you want to assume that knowledge on
the side of the readers.

> diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path=
=2Esh
> new file mode 100755
> index 0000000..31461aa
> --- /dev/null
> +++ b/t/t1350-config-hooks-path.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +
> +test_description=3D'Test the core.hooksPath configuration variable'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'set up a pre-commit hook in core.hooksPath' '
> +	mkdir -p .git/custom-hooks .git/hooks &&
> +	write_script .git/custom-hooks/pre-commit <<EOF &&
> +printf "%s" "." >>.git/PRE-COMMIT-HOOK-WAS-CALLED
> +EOF

Because there is no funny interpolation going on, it would help
readers to signal that fact by quoting the end-of-here-text marker.
And it makes the entire test block reads nicer if you indent the
body of hte here-text by prefixing the end-of-here-text marker with
a dash, i.e.

	write_script .git/custom-hooks/pre-commit <<-\EOF &&
	printf "%s" "." >>.git/PRE-COMMIT-HOOK-WAS-CALLED
	EOF

> +	cat >.git/hooks/pre-commit <<EOF &&
> +	write_script .git/hooks/pre-commit &&
> +printf "%s" "SHOULD NOT BE CALLED" >>.git/PRE-COMMIT-HOOK-WAS-CALLED
> +EOF
> +	chmod +x .git/custom-hooks/pre-commit

You didn't want cat and chmod here?

> +'
> +
> +test_expect_success 'Check that various forms of specifying core.hoo=
ksPath work' '
> +	test_commit no_custom_hook &&
> +	git config core.hooksPath .git/custom-hooks &&
> +	test_commit have_custom_hook &&
> +	git config core.hooksPath .git/custom-hooks/ &&
> +	test_commit have_custom_hook_trailing_slash &&
> +	git config core.hooksPath "$PWD/.git/custom-hooks" &&
> +	test_commit have_custom_hook_abs_path &&
> +	git config core.hooksPath "$PWD/.git/custom-hooks/" &&
> +	test_commit have_custom_hook_abs_path_trailing_slash &&
> +	printf "%s" "...." >.git/PRE-COMMIT-HOOK-WAS-CALLED.expect &&
> +	test_cmp .git/PRE-COMMIT-HOOK-WAS-CALLED.expect .git/PRE-COMMIT-HOO=
K-WAS-CALLED
> +'
> +
> +test_done
