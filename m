From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V4 2/2] user-manual: add section documenting shallow clones
Date: Mon, 28 Dec 2015 14:57:47 -0800
Message-ID: <xmqqfuymji50.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cRMdpJ-k9L33jE01ubfK6MOWNGwuoUULuQqOv8C0we+DQ@mail.gmail.com>
	<1450902961-1528-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 28 23:58:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDgjs-0000GV-OT
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 23:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbbL1W6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 17:58:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752566AbbL1W57 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 17:57:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D412C3891D;
	Mon, 28 Dec 2015 17:57:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f6aMgvWg7TMDCBEy5M/nE76Ch38=; b=DPwv+J
	BMu2lF/g0PjYWCDdBRNbDIFtKVOCCdXNS+w8byBlBGtvhxiFZYMC3B1TSZAork/h
	rNS8Uhy8pVRQmRh+pA8uufa4A0HJFXIiU7MPl17NqQhsV1YznNislOBh1c6ss2/v
	v51LbNlrfbICCRs+FFHG8ggCyXc9466TxQLUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZmRuHr9eE5jtDt64zgQGvVOD58CiqRHd
	SwyuepinYPHVAsCpJ0H8VHCAjst1mVzBN/rKV4Smsb+kLktcbdnyDaqwPG5QgtmE
	upOGFiRNJOY2/tanech63jII1lfPSVKVHeodfWnEkxvVMsbh8jRq1VDKRMSzHN64
	GI1pulMXtdQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC0B03891C;
	Mon, 28 Dec 2015 17:57:58 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 467403891B;
	Mon, 28 Dec 2015 17:57:58 -0500 (EST)
In-Reply-To: <1450902961-1528-1-git-send-email-ischis2@cox.net> (Stephen
	P. Smith's message of "Wed, 23 Dec 2015 13:36:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7037829E-ADB6-11E5-85A2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283052>

"Stephen P. Smith" <ischis2@cox.net> writes:

> Rather than merely pointing readers at the 1.5 release notes to
> learn about shallow clones, document them formally.
>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
>
>  I replaced the paragraphs that I wrote with Eric Shunshine's since it
>  was cleaner.
>
>  I like the idea of linking to the preceeding effort, but gmane.org is
>  currently undergoing maintance and therefore giving me errors when I
>  attempt to access it.
>
>  Documentation/user-manual.txt | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 1c790ac..5c13683 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2128,6 +2128,20 @@ The gitweb cgi script provides users an easy way to browse your
>  project's files and history without having to install Git; see the file
>  gitweb/INSTALL in the Git source tree for instructions on setting it up.
>  
> +[[how-to-get-a-git-repository-with-minimal-history]]
> +How to get a Git repository with minimal history
> +------------------------------------------------
> +
> +A <<def_shallow_clone,shallow clone>>, with its truncated
> +history, is useful when one is interested only in recent history
> +of a project and getting full history from the upstream is
> +expensive.
> +
> +A <<def_shallow_clone,shallow clone>> is created by specifying
> +the linkgit:git-clone[1] `--depth` switch. The depth can later be
> +changed with the linkgit:git-fetch[1] `--depth` switch, or full
> +history restored with `--unshallow`.
> +
>  [[sharing-development-examples]]
>  Examples
>  --------

OK.

> @@ -4645,9 +4659,6 @@ standard end-of-chapter section?
>  
>  Include cross-references to the glossary, where appropriate.
>  
> -Document shallow clones?  See draft 1.5.0 release notes for some
> -documentation.
> -

The 1.5.0 release notes describe three limitations that was present
back in the day.  I think the first two have been lifted (I am not
sure if it is throughly tested and shown to be bulletproof, though),
but the third limitation is fundamental and not something that will
ever be "fixed".  It probably is a good idea to add it here to avoid
hurting unsuspecting new users.

I notice that this section uses "a shallow clone" as a noun that
refers to a repository that has incomplete history--it is a synonym
to "a shallow repository", but more explicitly conveys the fact that
its cauterised history was obtained originally from elsewhere.

And I think that is a good use of the word, but I am not sure if
the phrasing used in your [1/2] is consistent with it:

+[[def_shallow_clone]]shallow clone::
+	A clone of a <<def_repository,repository>> which creates a
+	<<def_shallow_repository,shallow_repository>>.
+

I read this sentence, especially the part "A clone ... which creates"
as referring to "an act of running the 'git clone' command", not
"the (shallow) repository that results from such an act", and found
it a bit strange.

Right now, I do not think we have a canned way to create a shallow
repository locally without running "git clone --depth", but there is
no fundamental reason you shouldn't be able to do so (we can even
today create a shallow repository manually using lower-level tools
without running "clone --depth" from elsewhere).  And for somebody
who has seen such a repository, "a shallow clone" and "a shallow
repository" would have a slight difference.  The former is a shallow
repository that was created using "clone --depth"; the latter may or
may not ahve been created with "clone --depth", it just says the
repository does not have full history without hinting how it was
made so.

Perhaps replace 1/2 with something like this?

    [[def_shallow_clone]]shallow clone::
            Mostly a synonym to <<def_shallow_repository,shallow repository>>
            but the phrase makes it more explicit that it was created by
            running `git clone --depth=...` command.

    [[def_shallow_repository]]shallow repository::
            A shallow <<def_repository,repository>> has an incomplete
            history some of whose <<def_commit,commits>> have
            <<def_parent,parents>> cauter

I dunno.
