From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][Outreachy] branch: allow - as abbreviation of '@{-1}'
Date: Fri, 18 Mar 2016 09:10:37 -0700
Message-ID: <xmqqvb4jrcle.fsf@gitster.mtv.corp.google.com>
References: <1458305231-2333-1-git-send-email-elena.petrashen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elena Petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 17:10:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agwzC-0007rr-Pu
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 17:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbcCRQKo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 12:10:44 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750918AbcCRQKk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2016 12:10:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5B174D014;
	Fri, 18 Mar 2016 12:10:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=A883dV5DNjW+
	TDykKpnORnEQIE8=; b=jJdNAgP8CUgKln7ALJ6YM5L7ML9jsYcX8nIApEAILMsN
	+DPT2LYHQ3FOx2yirSHZ1CwN96h7ypvZlmRIrcEPp1gHB5sP9AHHczcoRIBfFtRv
	ZOAK6A/0hNeurLaRvgs2mblckTveOLyr/B8Cs8dljea749T3BtqtwMya9Vwmqcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tz/Gro
	WnyoSEVKITQew0QFtp05CTevIkeHRZXoNhU6UqiPeCXHY0SWg2NmpSXJ+dFnNpr6
	wA0HM3gYW6Ej+MrdHYm+DZ1aawpYXfcDUdeqdTM8Peykd834roKZtgqLth2y1WJq
	0JjGl6ioT9r81YHiLOZA7j8rINyM0lO/H/v+k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D21A4D013;
	Fri, 18 Mar 2016 12:10:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D8AF24D00F;
	Fri, 18 Mar 2016 12:10:38 -0400 (EDT)
In-Reply-To: <1458305231-2333-1-git-send-email-elena.petrashen@gmail.com>
	(Elena Petrashen's message of "Fri, 18 Mar 2016 15:47:11 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F4A911EE-ED23-11E5-A4F3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289230>

Elena Petrashen <elena.petrashen@gmail.com> writes:

> Signed-off-by: Elena Petrashen <elena.petrashen@gmail.com>
> ---
>
> Hi everyone,
>
> As my first Outreachy submission micropoject I've chosen to try to ap=
proach "Allow '-' as a short-hand for '@{-1} in more places." (http://g=
it.github.io/SoC-2016-Microprojects/ (Cf. $gmane/230828))
> My goal was to teach git branch to accept - shortcut and interpret it=
 as "previous working branch", i.e $git branch -D -
> Really looking forward to hear what do you think, so please let me kn=
ow if something is done incorrectly, etc.
> Thank you,
> Elena

Thanks for your interests.

Here are a few quick ones on the formality:

 * The message was sent with "Content-Type: text/plain; charset=3Dy",
   which you probably did not intend to. Perhaps use git-send-email
   from a more recent version of Git to avoid such a mistake?

 * It is customary to avoid using pretty-quotes ("=E2=80=9C, etc.) arou=
nd
   here when you are merely quoting things (I couldn't see them due
   to the above "charset=3Dy" issue, so I replaced them all in the
   above quote).

 * Your lines are overly long (see the above I quoted).

On the submitted patch itself, in decreasing order of importance:

 * The approach you took turns every "-" that appears as a command
   line argument into "@{-1}", but it does so without even checking
   where "-" appears on the command line is meant to take a branch
   name.  This closes the door to later add an option that takes "-"
   as an argument that means something different (e.g. one common
   use of "-" is to mean "the standard input" when a filename is
   expected).

 * There is no explanation and justification in the proposed log
   message why you took a particular approach.  Why is that a good
   approach?  What are the possible downsides?  What were the
   alternatives (if any), and why is the approach chosen is better
   than them?

 * We forbid declaration-after-statement in our codebase.

 * When you do not yet have the "branch I was previously on", I
   imagine that your implementation would give you this:

   $ git branch -d -
   error: branch '@{-1}' not found.
   $ git branch new -
   fatal: Not a valid object name: '@{-1}'.

   even though the user did not type '@{-1}'.  It probably is OK if
   the user understands "-" is merely a short-hand for "@{-1}", but
   if you limited your "turn '-' to '@{-1}'" to places on the
   command line that are meant to always take a branch name
   (i.e. immediately after "branch -d" in the first example), you
   may be able to give a lot more meaningful error message
   (e.g. when doing "-" to "@{-1}" conversion, notice that you do
   not yet have 'previous branch' and say so, for example).

 * You do not need the brace pairs around the body of these new
   "for" or "if" statements.

>  builtin/branch.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 7b45b6b..9d0f8a7 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -675,6 +675,13 @@ int cmd_branch(int argc, const char **argv, cons=
t char *prefix)
>  	argc =3D parse_options(argc, argv, prefix, options, builtin_branch_=
usage,
>  			     0);
> =20
> +	int i;
> +	for (i =3D 0; i < argc; i++) {
> +		if (!strcmp(argv[i], "-")) {
> +			argv[i] =3D "@{-1}";
> +		}
> +	}
> +
>  	if (!delete && !rename && !edit_description && !new_upstream && !un=
set_upstream && argc =3D=3D 0)
>  		list =3D 1;
