From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] add central method for prompting a user using
 GIT_ASKPASS or SSH_ASKPASS
Date: Tue, 27 Dec 2011 12:47:30 -0800
Message-ID: <7vwr9h68t9.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ECC0.606@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Tue Dec 27 21:47:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rfdvv-0000d0-R3
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 21:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112Ab1L0Urf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 15:47:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925Ab1L0Urd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 15:47:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3CB97EAD;
	Tue, 27 Dec 2011 15:47:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=fkt8L8lusWLam12jEKAvqDvXeAs=; b=uDAcrzSqglHjXQj1V/Gc
	tIUpAOzqei6+gNd+eRkgRR8JgjIEVw/sdswpKfcCComP4rDD10cMhxK/wPFF9ZpU
	SJs33EA7FLntg63eZl6qWrYKHoDHWPgdo+apQ9tW1yafxH9OsrP/yfk70ynsOpHm
	85+kp0KZli1qcu62NpaHom0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=MY60JqKkp2JVrj/WpdqRpY+xdRzGij7hpA16nMas9mKslq
	bZBywUaML1fB4ZaN+ZZZyIYm6GALIAuaX/6h7Q/8ZMxsa6/3xX5lw0caEm0eI98g
	FPyPFoB+BisRfwapM2LA6Wm9EYpknk3Y01grmzWf+EOttusHzzfzk7kew4Ae0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C93107EAC;
	Tue, 27 Dec 2011 15:47:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F108F7EAA; Tue, 27 Dec 2011
 15:47:31 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF720432-30CB-11E1-9E9D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187726>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---

Thanks.

Please indicate what area you are touching on the Subject, e.g.

	Subject: [PATCH 1/5] perl/Git.pm: add askpass_prompt() method

and explain what problem it tries to solve, how it tries to solve it, and
why this particular way of solving that problem is a good thing to have in
the proposed commit log message (but see the comments to 2/5 before doing
so).

>  perl/Git.pm |   36 +++++++++++++++++++++++++++++++++++-
>  1 files changed, 35 insertions(+), 1 deletions(-)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index f7ce511..7fdf805 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -58,7 +58,7 @@ require Exporter;
>                  command_output_pipe command_input_pipe command_close_pipe
>                  command_bidi_pipe command_close_bidi_pipe
>                  version exec_path html_path hash_object git_cmd_try
> -                remote_refs
> +                remote_refs askpass_prompt
>                  temp_acquire temp_release temp_reset temp_path);
>
>
> @@ -512,6 +512,40 @@ C<git --html-path>). Useful mostly only internally.
>  sub html_path { command_oneline('--html-path') }
>
>
> +=item askpass_prompt ( PROMPT)

Is the unbalanced spacing around parentheses your finger slippage?

> +
> +Asks user using *_ASKPASS programs and return answer from user.

Other =item entries in this file (I only checked a couple of earlier ones)
begin with "Construct a new ...", "Execute the given git command ...",
i.e. in imperative mood.

Also I agree with Jakub that it would be more appropriate to start the
description with the purpose and the effect, i.e. what the function is
for, than the internal implementation, i.e. what the function does.

> +Checks if GIT_ASKPASS or SSH_ASKPASS is set, and use first matching for querying
> +user and returns answer.
> +
> +If no *_ASKPASS variable is set, the variable is empty or an error occours,
> +it returns undef and the caller has to ask the user (e.g. on terminal).
> +
> +=cut
> +
> +sub askpass_prompt {
> +	my ($self, $prompt) = _maybe_self(@_);
> +	if (exists $ENV{'GIT_ASKPASS'}) {
> +		return _askpass_prompt($ENV{'GIT_ASKPASS'}, $prompt);
> +	} elsif (exists $ENV{'SSH_ASKPASS'}) {
> +		return _askpass_prompt($ENV{'SSH_ASKPASS'}, $prompt);
> +	} else {
> +		return undef;

Two problems with this if/elsif/else cascade.

 - If _askpass_prompt() fails to open the pipe to ENV{'GIT_ASKPASS'}, it
   will return 'undef' to us. Don't we want to fall back to SSH_ASKPASS in
   such a case?

 - The last "return undef" makes all callers of this method to implement a
   fall-back way somehow. I find it very likely that they will want to use
   the fall-back code that uses Term::ReadKey found in _read_password, and
   they will hate the above askpass_prompt implementation for focing them
   to duplicate the code more than they will appreciate the flexibility
   that they could implement a different fall-back.

> +}
> +
> +sub _askpass_prompt {
> +	my ($self, $askpass, $prompt) = _maybe_self(@_);

I am not sure why you would want _maybe_self() here for this internal
helper function _askpass_prompt that is not even called as a method of
anything.

> +	my $ret;
> +	open my $fh, "-|", $askpass, $prompt || return undef;
> +	$ret = <$fh>;
> +	$ret =~ s/[\012\015]//g; # strip \n\r, chomp does not work on all systems (i.e. windows) as expected
> +	close ($fh);
> +	return $ret;
> +}
> +
> +
>  =item repo_path ()
>
>  Return path to the git repository. Must be called on a repository instance.
