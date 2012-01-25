From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash-completion: don't add quoted space for ZSH (fix
 regression)
Date: Tue, 24 Jan 2012 20:06:38 -0800
Message-ID: <7vsjj41l4h.fsf@alter.siamese.dyndns.org>
References: <20120114152030.GX30469@goldbirke>
 <1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
 <CAMP44s2nYMmfC36+pGaYfOZUQy3fLMYDuaSriPYjHBeApmsRVg@mail.gmail.com>
 <CAMP44s0T15idhwb6Eae5vdMxf25KK9MhY57mBf+BFN=OSC6Lhg@mail.gmail.com>
 <7vzkdmqebh.fsf@alter.siamese.dyndns.org>
 <CAMP44s3GMGMD5Y9Z=Uu_e55_eZOG2zY76u8B=ORKsMx6yoXW5Q@mail.gmail.com>
 <7v1uqxq4jm.fsf@alter.siamese.dyndns.org> <vpqlip5qvcm.fsf@bauges.imag.fr>
 <CAMP44s2x2kJEJsQLZCJiegZY863X=kVO5xof9QBUin35i-BzhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 05:06:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpu8E-000645-9M
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 05:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab2AYEGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 23:06:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753448Ab2AYEGl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 23:06:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C30FE61E3;
	Tue, 24 Jan 2012 23:06:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bFaw/YuySRljXwZ5QA+Wpp+qZV0=; b=xZZTBS
	Jee0NlDvwh4wHu+zlVl7Ygzfpgvju2IyxJ04C2C1ATRRq0PBkr7uupKOMJwIkKMn
	5BIgHKHqV0viBv2mGl/vJKxSCUFYFXqm/oShMfNhqci9LV+98d58wI9YoMhLFsqa
	q4qPxoCeMihEl3UEbuW4R4FfO9SGs6Q3G2DxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HYWdfJP5YKPAYrJLuFfjJpGIu0wp0ief
	M7hFEMUFCprnQC4ZBV8qd0Ko8G+6F94FRPV0b1GGL8xq253PT4td6H2TMS4Tv0BR
	PjhHnVxBVDxRM3Ilc+fPGx449YsVWsgGsXxoc+TDvGwZm5fRpZSaR4HtcrSoQuSw
	Ol7cMMtfZ+0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAE9761E2;
	Tue, 24 Jan 2012 23:06:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3283C61E1; Tue, 24 Jan 2012
 23:06:40 -0500 (EST)
In-Reply-To: <CAMP44s2x2kJEJsQLZCJiegZY863X=kVO5xof9QBUin35i-BzhA@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 25 Jan 2012 03:39:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FBC6407E-4709-11E1-AA1F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189096>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> At worse, my patch is not intrusive and can easily be reworked later.
>
> I believe I have found a more generic and simpler fix that works for
> both the regression in v1.7.9, and users of zsh >= 4.3.12.
>
> Patch sent.

Matthieu, care to take a look?

It looks fairly straightforward and would have absolutely no impact on
bash users.

Thanks, Felipe.

-- >8 --
From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] git-completion: workaround zsh COMPREPLY bug

zsh adds a backslash (foo\ ) for each item in the COMPREPLY array if IFS
doesn't contain spaces. This issue has been reported[1], but there is no
solution yet.

This wasn't a problem due to another bug[2], which was fixed in zsh
version 4.3.12. After this change, 'git checkout ma<tab>' would resolve
to 'git checkout master\ '.

Aditionally, the introduction of __gitcomp_nl in commit a31e626
(completion: optimize refs completion) in git also made the problem
apparent, as Matthieu Moy reported.

The simplest and most generic solution is to hide all the changes we do
to IFS, so that "foo \nbar " is recognized by zsh as "foo bar". This
works on versions of git before and after the introduction of
__gitcomp_nl (a31e626), and versions of zsh before and after 4.3.12.

Once zsh is fixed, we should conditionally disable this workaround to
have the same benefits as bash users.

[1] http://www.zsh.org/mla/workers/2012/msg00053.html
[2] http://zsh.git.sourceforge.net/git/gitweb.cgi?p=zsh/zsh;a=commitdiff;h=2e25dfb8fd38dbef0a306282ffab1d343ce3ad8d

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b0062ba..c83c734 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2631,6 +2631,10 @@ _git ()
 		# workaround zsh's bug that leaves 'words' as a special
 		# variable in versions < 4.3.12
 		typeset -h words
+
+		# another workaround for zsh because it would quote spaces in
+		# the COMPREPLY array if IFS doesn't contain spaces
+		typeset -h IFS
 	fi
 
 	local cur words cword prev
@@ -2687,6 +2691,10 @@ _gitk ()
 		# workaround zsh's bug that leaves 'words' as a special
 		# variable in versions < 4.3.12
 		typeset -h words
+
+		# another workaround for zsh because it would quote spaces in
+		# the COMPREPLY array if IFS doesn't contain spaces
+		typeset -h IFS
 	fi
 
 	local cur words cword prev
