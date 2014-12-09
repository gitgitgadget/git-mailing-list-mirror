From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] introduce git root
Date: Tue, 09 Dec 2014 10:17:13 -0800
Message-ID: <xmqqoarcn0wm.fsf@gitster.dls.corp.google.com>
References: <CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
	<vpqoaro99xd.fsf@anie.imag.fr>
	<xmqqd284rryz.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
	<20141202070415.GC1948@peff.net>
	<xmqqd282m09j.fsf@gitster.dls.corp.google.com>
	<20141204092251.GC27455@peff.net>
	<xmqqlhmntf02.fsf@gitster.dls.corp.google.com>
	<20141204211232.GC19953@peff.net>
	<CAP8UFD2P9P9zL=irZ-7uPD6+bEhxaiABowh0O3RT01Ov3VqT6w@mail.gmail.com>
	<20141205092752.GC32112@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 19:17:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyPLl-0004nO-7F
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 19:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbaLISRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 13:17:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752005AbaLISRX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 13:17:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D99B24E82;
	Tue,  9 Dec 2014 13:17:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iBVu0qrCx5gY/jy1qmuXz+g7FIo=; b=W5paA1
	fMgzEiWopkL9M+I89F2oZs51qgAoi+0jXOOg0wCYbKDbi+SQdv3dA3a20M5cG3FT
	bl4SJoOfuxxfFiQ4Zo+NSOybBMU+XzPb9nRpFgGpNA6+psJYP+v+361hcQCFm+3l
	ChY7SvrH9rJB16dTh+NHOFG+dnUAQqjTSQxoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VSFMVPFfR6rUiVueOpAxtqXTDtub5V/8
	3Fqs/crik5GWzX2BjfW2eW+HGRtdzj6fppMKLan369qipFgYzxjzQPscW3Lo7LyY
	+keOSC9jzDBCd+bGl+vxeb4i9ynbWxLUqQVJfHSZR6ciWbzGJ4iKpmr4F7kXZaSr
	OaU7fDtGGT8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CE4724E81;
	Tue,  9 Dec 2014 13:17:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 332A824E7F;
	Tue,  9 Dec 2014 13:17:15 -0500 (EST)
In-Reply-To: <20141205092752.GC32112@peff.net> (Jeff King's message of "Fri, 5
	Dec 2014 04:27:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9A61F9F2-7FCF-11E4-A3FF-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261135>

Jeff King <peff@peff.net> writes:

> But the one place I do not agree is:
>
>> I think "sequence.editor" and "core.editor" are better because:
>> 
>> - they use the same syntax as the config variables, so they are easier
>> to remember and to discover, and
>
> I really don't like using "core.editor" here, because it has the same
> name as a config variable, but it is _not_ the config variable. It
> happens to use the config variable as one of the inputs to its
> computation, but in many cases:
>
>   git config core.editor
>
> and
>
>   git var core.editor
>
> will produce different values. They are entirely different namespaces.
> Using the same syntax and name seems unnecessarily confusing to me.

I think this is a valid concern.

It is a tangent, the current definition of "git_editor" helper reads
like this:

        git_editor() {
                if test -z "${GIT_EDITOR:+set}"
                then
                        GIT_EDITOR="$(git var GIT_EDITOR)" || return $?
                fi

                eval "$GIT_EDITOR" '"$@"'
        }

If "git var editor" were to compute a reasonable value from the
various user settings, and because GIT_EDITOR is among the sources
of user settings, I wonder if the surrounding "if test -z then...fi"
should be there.

The pager side seems to do (halfway) "the right thing":

        git_pager() {
                if test -t 1
                then
                        GIT_PAGER=$(git var GIT_PAGER)
                else
                        GIT_PAGER=cat
                fi
                : ${LESS=-FRX}
                : ${LV=-c}
                export LESS LV

                eval "$GIT_PAGER" '"$@"'
        }

The initial "test -t 1" is "we do not page to non-terminal", but we
ask "git var" to take care of PAGER/GIT_PAGER fallback/precedence.

It is tempting to argue that "we do not page to non-terminal" should
also be part of "various user settings" for "git var" to take into
account and fold this "if test -t 1...then...else...fi" also into
"git var", but because a typical command line "git var" will be used
on would look like this:

	GIT_PAGER=$(git var pager)
        eval "$GIT_PAGER" ...

with the standard output stream of "git var" not connected to
terminal, that would not fly very well, and I am not sure what
should be done about it.

This is another tangent that comes back to the original "how to name
them?" question, but I wonder if a convention like this would work.

 * When asking for a feature (e.g. "what editor to use"), if there
   is a git-specific environment variable that can be set to
   override all other settings (e.g. "$GIT_EDITOR" trumps "$EDITOR"
   environment or "core.editor" configuration), "git var" can be
   queried with the name of that "strong" environment variable.

 * All other features without such a strong environment variables
   should not be spelled as if there is such an environment variable
   the user can set in order to avoid confusion.

Here are some consequences that come to my mind, if we adopt such an
approach:

 * We would keep GIT_EDITOR and GIT_PAGER (e.g. "git var
   GIT_EDITOR");

 * GIT_SEQUENCE_EDITOR is an example of an overriding environment
   variable, and as such, "what editor to use when munging the
   rebase insn sheet?", would be "git var GIT_SEQUENCE_EDITOR".

 * We would deprecate GIT_AUTHOR_IDENT and GIT_COMMITTER_IDENT
   because setting such an environment variable would not do
   anything.  Add "git var author-ident" that is clear that it does
   not name an environment variable as its replacement.

 * It is OK to add support for new queries, e.g. GIT_AUTHOR_DATE,
   for existing environment variables that we already take into
   account but that the current "git var" does not support.

Arguably, we could go the other way around.  Instead of adding "git
var author-ident", we actually allow GIT_AUTHOR_IDENT environment
variable to be set and used instead of GIT_AUTHOR_{NAME,EMAIL,DATE}.
If that approach is practical, then we could stick to the syntax
that looks like an environment variable name.  A script could then
instead of doing:

	GIT_AUTHOR_IDENT=$(git var GIT_AUTHOR_IDENT)
        ... parse it into NAME,EMAIL,DATE and ...
        export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE

        ... complicated set of operations to prepare ...

        git commit-tree ...

do this instead:

	GIT_AUTHOR_IDENT=$(git var GIT_AUTHOR_IDENT)
        export GIT_AUTHOR_IDENT

        ... complicated set of operations to prepare ...

        git commit-tree ...
