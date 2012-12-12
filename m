From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-prompt.sh vs leading white space in
 __git_ps1()::printf_format
Date: Tue, 11 Dec 2012 16:03:36 -0800
Message-ID: <7vy5h45e7b.fsf@alter.siamese.dyndns.org>
References: <CAA01Cso1E4EC4W667FEU_af2=uGOfPuaWEB3y+zPCpB+bPzoaA@mail.gmail.com>
 <20121128132033.GA10082@xs4all.nl>
 <CAA01CspHAHN7se2oJ2WgcmpuRfoa+9Sx9sUvaPEmQ-Y+kDwHhA@mail.gmail.com>
 <50B66F41.1030305@xs4all.nl> <7vlidltpyj.fsf@alter.siamese.dyndns.org>
 <50C7B811.7030006@xs4all.nl> <7v7goo6vi3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	git@vger.kernel.org
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Dec 12 01:03:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiZnp-0008St-8q
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 01:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab2LLADk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 19:03:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701Ab2LLADj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 19:03:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FE179029;
	Tue, 11 Dec 2012 19:03:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u+QIzaYBhht9O9r/MVw2/i/DeFQ=; b=k4vFG9
	u8Our6rM4xZTAOaDt04VJi+83IIjfE/fVeJPdIRjhnvlr6tccnWek5mk1Tm198vs
	KknvTYczOiTWuBUFLhsqabwEFJxIDR7fLXOJzBoul+6Cove/jvXNts+NN+k6Hjnx
	NGZgjV/Zu5JrXNJw9zWS1RbwVnEipLKncnmRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jTiDvNVqGBUutCIPJHGOTAcivVg5nXIF
	ycY9pCaPVIcaM3DHR67GHcx22/Qw6sXICaJi7dwvUFR27cZ9NyJDgfPIxdC79OAX
	vH+dhatsRuSgmNHKjXe/sCkhHPJ+aNxeBM0wgH3faoJzazpZNx67FhachJxHet25
	Gh7Fdx6FPuE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D6ED9028;
	Tue, 11 Dec 2012 19:03:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60CC29027; Tue, 11 Dec 2012
 19:03:38 -0500 (EST)
In-Reply-To: <7v7goo6vi3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 11 Dec 2012 15:04:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6159A4C0-43EF-11E2-A6F2-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211318>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps like this?

OK, this time with a log message.

-- >8 --
Subject: [PATCH] git-prompt.sh: update PROMPT_COMMAND documentation

The description of __git_ps1 function operating in two-arg mode was
not very clear.  It said "set PROMPT_COMMAND=__git_ps1" which is not
the right usage for this mode, followed by "To customize the prompt,
do this", giving a false impression that those who do not want to
customize it can get away with no-arg form, which was incorrect.

Make it clear that this mode always takes two arguments, pre and
post, with an example.

The straight-forward one should be listed as the primary usage, and
the confusing one should be an alternate for advanced users.  Swap
the order of these two.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-prompt.sh | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index a8b53ba..9b074e1 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -10,14 +10,20 @@
 #    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
 #    2) Add the following line to your .bashrc/.zshrc:
 #        source ~/.git-prompt.sh
-#    3a) In ~/.bashrc set PROMPT_COMMAND=__git_ps1
-#        To customize the prompt, provide start/end arguments
-#        PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
-#    3b) Alternatively change your PS1 to call __git_ps1 as
+#    3a) Change your PS1 to call __git_ps1 as
 #        command-substitution:
 #        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
 #        ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
-#        the optional argument will be used as format string
+#        the optional argument will be used as format string.
+#    3b) Alternatively, if you are using bash, __git_ps1 can be
+#        used for PROMPT_COMMAND with two parameters, <pre> and
+#        <post>, which are strings you would put in $PS1 before
+#        and after the status string generated by the git-prompt
+#        machinery.  e.g.
+#           PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
+#        will show username, at-sign, host, colon, cwd, then
+#        various status string, followed by dollar and SP, as
+#        your prompt.
 #
 # The argument to __git_ps1 will be displayed only if you are currently
 # in a git repository.  The %s token will be the name of the current
-- 
1.8.1.rc1.128.gd8d1528
