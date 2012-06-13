From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Wed, 13 Jun 2012 10:32:34 -0700
Message-ID: <7vvcivglsd.fsf@alter.siamese.dyndns.org>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD70A8E.7050502@in.waw.pl> <7vk3zc4mgz.fsf@alter.siamese.dyndns.org>
 <4FD89DD6.1070705@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Jun 13 19:32:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SerQw-00077N-5l
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 19:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354Ab2FMRci convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 13:32:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43501 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754283Ab2FMRch convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 13:32:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EE9D8390;
	Wed, 13 Jun 2012 13:32:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Yqk1K2TiZS+B
	Jlvp78o92ifJlSo=; b=J/kNj4A9zrzdkaVTNrVqxExGQwNbYYJT6+LRM1mqhARM
	ISV9dHDGWf+/QX3acMF60J97dBj7BaCDSpGHG7sPjB8m4Q2u0YpA//zdIb5ohY5v
	Xkx57ZoJZ9PKP2l8pnrdLJOEIA5phViVGC5R2JNusahsqbjdZToybW3EGoWnLAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bGrrBg
	yKQoq+x8zuwLCrckTu+TVFBgfsZsBvimyNYgmPkfhhGb6syMKM5JLhDbdZDCmBRR
	UqMdAM1fc5EDWZW8WWeXIiZsDEGJz3aXvWcWpbq0LMS7MJ7BWHyn7qb/kDAAvjFz
	CoMuyVxVuNoO7SIrnvaNRMDXQnHOIl1YgTUh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14443838F;
	Wed, 13 Jun 2012 13:32:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D7B6838E; Wed, 13 Jun 2012
 13:32:36 -0400 (EDT)
In-Reply-To: <4FD89DD6.1070705@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Wed, 13 Jun 2012 16:04:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C411ED8A-B57D-11E1-8624-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199910>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> On 06/12/2012 04:46 PM, Junio C Hamano wrote:
>> I do not think it is worth another round of resend at this point, so
>> please eyeball the version I fixed up and queued in 'pu' when it is
>> pushed out.  I also moved the '-x <cmd>::' option description to
>> where it belongs (iow, not at the very beginning).
>
> Hi,
> I think some small changes are still in order. Please consider
> squashing this in:
>
> -----8<------
> Subject: [PATCH] squash! rebase -i: teach "--exec <cmd>"
>
> In the commit message: s/each runs/each run/
>
> Fixup to the documentation part:
> - Use the phrase "after each commit in the final history" from Junio'=
s
>   commit message to replace "each commit application". The latter is
>   awkward and not really true.
> - Reorder paragraphs and reword the one about --interactive.
>   Make the part about two forms of exec less verbose.
> - Replace ';' with '&&' in the example. This (a) makes the two
>   examples equivalent, and (b) encourages good practice that we try
>   to follow in git tests to never fail silently. People are likely
>   to copy the example verbatim.

Looks sensible; Lucien, opinions?

>  Documentation/git-rebase.txt | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.=
txt
> index 048da64..179ab77 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -346,22 +346,23 @@ idea unless you know what you are doing (see BU=
GS
> below).
>
>  -x <cmd>::
>  --exec <cmd>::
> -	Append "exec <cmd>" after each commit application line. <cmd>
> -	will be interpreted as one or more shell commands (see
> -	INTERACTIVE MODE below).
> +	Append "exec <cmd>" after each line creating a commit in the
> +	final history. <cmd> will be interpreted as one or more shell
> +	commands.
>  +
> -This option has to be used along with the `--interactive` option
> -explicitly.  You may execute several commands after each commit
> -application.  For this, you can use one instance of `--exec`:
> +This option can only be used with the `--interactive` option
> +(see INTERACTIVE MODE below).
>  +
> -	git rebase -i --exec "cmd1; cmd2; ...".
> +You may execute several commands by either using one instance of `--=
exec`
> +with several commands:
>  +
> -You can also insert several instances of `--exec`, if you wish to on=
ly
> -have one command per line. For example:
> +	git rebase -i --exec "cmd1 && cmd2 && ..."
>  +
> -	git rebase -i --exec "cmd1" --exec "cmd2" ...
> +or equivalently by giving more than one `--exec`:
>  +
> -If `--autosquash` is used, the "exec" lines will not be appended for
> +	git rebase -i --exec "cmd1" --exec "cmd2" --exec ...
> ++
> +If `--autosquash` is used, "exec" lines will not be appended for
>  the intermediate commits, and will only appear at the end of each
>  squash/fixup series.
