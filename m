From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 2/4] t7512-status-help.sh: better advices for git
 status
Date: Sun, 03 Jun 2012 14:18:18 -0700
Message-ID: <7vvcj8xffp.fsf@alter.siamese.dyndns.org>
References: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 03 23:19:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbICa-000682-GR
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 23:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531Ab2FCVSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 17:18:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55346 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754839Ab2FCVSU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 17:18:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 484728EAF;
	Sun,  3 Jun 2012 17:18:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=VeWy6dgoI17ZonR/l/3Dal0Rh20=; b=Y5lC4RSyy6BDXTdjf0/S
	PyPC7ZTH7FvmcOimcxMWfBnCIIcYa0f7oAo/YY8EKaa3X924W1SbjWf8wuYof8aN
	4hO1GiWvqNr48l9FjCPJX8dQbqZzqiLheK2qCu+uhsrT2XlPOsdkA34EGDP3FSZo
	LHz/LjanZvkzABFAnpQiOVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=iArvQi+oysbqtpSHUfmzGLlVcmS5btiIM4Wl0SmPDkBcdq
	fF69VLtvLUKZzb2SFotfLir5KR7L+gO4FqieOS400Oc9VzusyX504gP4aAcjsWrm
	+GHNfxSnWqn6XdrJ+rkIphxmzLEsB0Xu02QJkGue5cZ8y5RbdHGooGYO0IoLY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 400E38EAD;
	Sun,  3 Jun 2012 17:18:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABD5A8EAC; Sun,  3 Jun 2012
 17:18:19 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4772DBE-ADC1-11E1-B397-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199102>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> The following tests include several cases in which the user needs to
> run 'git status' to know his current situation, whether there're
> conflicts or he's in rebase/bisect/am/ cherry-pick progress.
>
> One of the test is about the set of the advice.statushints config key
> to 'false' in .git/config.
>
> Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
> Signed-off-by: Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>
> Signed-off-by: Jonas Franck <Franck.Jonas@ensimag.imag.fr>
> Signed-off-by: Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
> Signed-off-by: Nguyen Huynh Khoi Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
> Signed-off-by: Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>

Are these spelling of names correct?

I thought Matthieu always called himself "Matthieu Moy", not the
other way around.  I also inferred the convention used for naming
the mailboxes at your institution to be "$First.$Last@$Domain",
which tells me that perhaps these names are all spelled backwards,
i.e. "$Last $First", which probably goes against the convention used
around you and Matthieu?

> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> new file mode 100755
> index 0000000..5f62262
> --- /dev/null
> +++ b/t/t7512-status-help.sh
> @@ -0,0 +1,303 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Valentin Duperray, Lucien Kong, Franck Jonas,
> +#		     Thomas Nguy, Khoi Nguyen
> +#		     Grenoble INP Ensimag
> +#
> +
> +test_description='git status advices'
> +
> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +set_fake_editor
> +
> +test_expect_success 'status when conflicts unresolved' '
> +	git init git &&
> +	cd git &&

Eek.

Later tests seem to use

	git init git &&
	(
		cd git &&
                ... everything is done inside git subdirectory ...
	)

with either "test_when_finished 'rm -fr git'" clean-up before the
first "git init git" or "&& rm -fr git" at the end of the && chain.

Please be consistent.  If you want _me_ to pick one, I'd say

	test_when_finished 'rm -fr git' &&
        git init git &&
        (
        	cd git &&
                ... do everything in git subdirectory ...
	)

would be my choice.

> +test_expect_success 'status when rebase in progress before rebase --continue' '
> +	test_when_finished "cd ../ && rm -rf git" &&

I've said why this is wrong; I won't repeat it.
