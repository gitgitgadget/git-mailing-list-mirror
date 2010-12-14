From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/14] t{3032,6038}-*.sh: Allow SED_BIN_OPT to override
 the -b sed option
Date: Tue, 14 Dec 2010 11:31:02 -0800
Message-ID: <7vlj3stamh.fsf@alter.siamese.dyndns.org>
References: <4D07BAE8.6070904@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 14 20:31:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSaaj-0002oX-OR
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 20:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758873Ab0LNTbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 14:31:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758869Ab0LNTbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 14:31:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57D6B2EF0;
	Tue, 14 Dec 2010 14:31:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2VQJimYTf95goGQ9hejHBSomUUo=; b=n7jSXP
	k9RMAt+n3lOtPm1TPA7bx8hP8/DGykGrNAodM7UIWYr6MhsBR7+D9J4FKRAP5Bn8
	bIi504zZCtSOizpjaY30IY9igCh5YKpZ7bfiIOWM4WpdxFWgI1ZPL1CH82aXXCX0
	6nbq4dI+MhtxE8x6ToYDHEUjw9yzacg30Cd+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E/DlWvtppLYWQP3bPRvIQeNtwLUrzxQq
	MDiFYMTmpwczHysyaTnaiejZTg/BPSJhI4ROKO70CYZAVJ2g4ex2EEyS59NyLSWb
	2T5jH4dl7vcdJ9lh8ZNyBRcaKgNrlKzkSpvqD/HRZT/YrXpi0i7UDpHyYsaYZoKY
	AlKjCcPFHUM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34BEC2EEF;
	Tue, 14 Dec 2010 14:31:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3E72F2EED; Tue, 14 Dec 2010
 14:31:28 -0500 (EST)
In-Reply-To: <4D07BAE8.6070904@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue\, 14 Dec 2010 18\:43\:52 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C16EF272-07B8-11E0-A078-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163681>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Some older versions of sed (eg. v3.02) do not understand the -b
> (--binary) option. However, these versions of sed may have an
> equivalent option we can use to request binary mode processing
> (eg. -c or --nocr).
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> I nearly didn't send this patch, since my MinGW sed is somewhat old, and
> most people would not have this problem. (Note I *think* I installed
> using msysGit-fullinstall-1.6.4-preview20090729.exe)
> So, feel free to drop this patch...
>
>  t/t3032-merge-recursive-options.sh |    2 +-
>  t/t6038-merge-text-auto.sh         |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
> index 29e049a..22d9988 100755
> --- a/t/t3032-merge-recursive-options.sh
> +++ b/t/t3032-merge-recursive-options.sh
> @@ -13,7 +13,7 @@ test_description='merge-recursive options
>  
>  . ./test-lib.sh
>  
> -test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
> +test_have_prereq SED_STRIPS_CR && SED_OPTIONS=${SED_BIN_OPT--b}

It is unclear who is supposed to feed you SED_BIN_OPT.

Perhaps a patch to add an insn like "If you have an ancient sed, export
SED_BIN_OPT=-c before running tests" to t/README is also necessary to go
together with this change.
