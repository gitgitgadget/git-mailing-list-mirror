From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] ignore empty *_ASKPASS variables
Date: Tue, 27 Dec 2011 13:00:12 -0800
Message-ID: <7vhb0l6883.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED38.9010502@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>, gitster@pobox.com
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Tue Dec 27 22:00:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rfe8E-0008Mo-4M
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 22:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260Ab1L0VAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 16:00:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65075 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab1L0VAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 16:00:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B1205266;
	Tue, 27 Dec 2011 16:00:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SvdOrPFLGMYrXvZoAqUg1pxWIH0=; b=nkOexl
	8p2eVbKn74IYePbLcMFunzfnZbCwwHDqsnrdduxRBCloxh3WjZQ6ExIoFVJYbiSc
	kOb/0zkEqgvwG5IU8mui2gJDeG1x8fAoOtU+fmp35z8cjzHtg2fPRZZ919YXKE6o
	J/gxeXaUIOrQ2fEpEqZ0pmOusO+GBb+eyt7Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hEoyfN4tQel9MhRjKENpe3M0mCKSDlhP
	xZtsvLmHRdXenTCh67O0t2dRhtHjm+CLoL8IsfL1GydWqXM9Dv42PfjydIvAv9X0
	O2KWAKJHDBC2mwHtKmOJBgbRuBuPnaaiEBmRjUvHmwh6aFQ4M2JF7NfypCvQAmwB
	lRcOAlk4NnM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92DB55265;
	Tue, 27 Dec 2011 16:00:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2DC35261; Tue, 27 Dec 2011
 16:00:13 -0500 (EST)
In-Reply-To: <4EF9ED38.9010502@tu-clausthal.de> (Sven Strickroth's message of
 "Tue, 27 Dec 2011 17:07:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5A334CC-30CD-11E1-9EF1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187729>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---

I *suspect* that this is a fix-up to a bug in patch 1/5 that lets callers
call _askpass_prompt helper without checking the value of the "askpass",
and if that is the case, this patch should be squashed there.

But there is no justification in the proposed log message above, so I
cannot tell.

>  perl/Git.pm |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 7fdf805..c6b3e11 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -537,6 +537,9 @@ sub askpass_prompt {
>
>  sub _askpass_prompt {
>  	my ($self, $askpass, $prompt) = _maybe_self(@_);
> +	unless ($askpass) {
> +		return undef;
> +	}
>  	my $ret;
>  	open my $fh, "-|", $askpass, $prompt || return undef;
>  	$ret = <$fh>;
