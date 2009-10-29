From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] More precise description of 'git describe --abbrev'
Date: Thu, 29 Oct 2009 15:47:02 -0700
Message-ID: <7vws2d4y3d.fsf@alter.siamese.dyndns.org>
References: <b48ea8a00910291438r8b66a0fq9e821393ecfff0bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gisle Aas <gisle@aas.no>
X-From: git-owner@vger.kernel.org Thu Oct 29 23:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3dmB-0006a5-Si
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 23:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756792AbZJ2WrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 18:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756737AbZJ2WrI
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 18:47:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756779AbZJ2WrI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 18:47:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0A18C8ABBE;
	Thu, 29 Oct 2009 18:47:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hvkJX8yjwxpgveJlP+wW292S6p8=; b=U3CCSB
	lbJJjFWBJeKKMihX7XgQtnUhmiLu43m1VSkJw53ugCP1gWKNcLnp0HqkvLDlDEis
	X2ij1Q3q6S2bZnO30ZY+4psC0NOrLBqP/o9wN6ZQORZqsSMySYXN39mSeyGgdhfe
	C96WWZRbPsLC1/LaqIw5uBJf2ScsxCVYh+cos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EW5mT8Oi5jnVNDRNWh+ORGrA39ILHUSB
	EvndeKA2mYAKXX4ZQXQ/+ZuPNlmX69G93D1lR3JB++X7TOUhGei7BmirlUggoJkS
	HUrEG09IWgGzE6IJoyrIcYtepQyN8QwD3mlKh6z6kt35FzmN2QkaQUY12cwMSwSf
	whlBMAlewx0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF0738ABBD;
	Thu, 29 Oct 2009 18:47:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1E4088ABBC; Thu, 29 Oct 2009
 18:47:04 -0400 (EDT)
In-Reply-To: <b48ea8a00910291438r8b66a0fq9e821393ecfff0bf@mail.gmail.com>
 (Gisle Aas's message of "Thu\, 29 Oct 2009 22\:38\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FD1D55EA-C4DC-11DE-9C64-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131665>

Gisle Aas <gisle@aas.no> writes:

> Also make the examples show what 'git describe' actually outputs
> currently.  I guess the default --abbrev value has been changed from 4
> to 7 at some point.

Some are good changes, but I do not think the example with --abbrev=4 is.

$ git describe 975bf9cf5ad5d440f98f464ae8124609a4835ce1
v1.3.2-216-g975bf9c
$ git describe 975b31dc6e12fba8f7b067ddbe32230995e05400
v1.0.0-21-g975b31d

Next time somebody adds a new object whose name happens to begin with
975b3 you would need to update the example output.

> Signed-off-by: Gisle Aas <gisle@aas.no>
> ---
>  Documentation/git-describe.txt |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index b231dbb..743eb95 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -44,7 +44,9 @@ OPTIONS
>
>  --abbrev=<n>::
>  	Instead of using the default 7 hexadecimal digits as the
> -	abbreviated object name, use <n> digits.
> +	abbreviated object name, use <n> digits or as many digits
> +	are needed to form a unique object name.  An <n> of 0
> +	will suppress long format, only showing the closest tag.
>
>  --candidates=<n>::
>  	Instead of considering only the 10 most recent tags as
> @@ -68,8 +70,8 @@ OPTIONS
>  	This is useful when you want to see parts of the commit object name
>  	in "describe" output, even when the commit in question happens to be
>  	a tagged version.  Instead of just emitting the tag name, it will
> -	describe such a commit as v1.2-0-deadbeef (0th commit since tag v1.2
> -	that points at object deadbeef....).
> +	describe such a commit as v1.2-0-gdeadbee (0th commit since tag v1.2
> +	that points at object deadbee....).
>
>  --match <pattern>::
>  	Only consider tags matching the given pattern (can be used to avoid
> @@ -106,10 +108,10 @@ With --all, the command can use branch heads as
> references, so
>  the output shows the reference path as well:
>
>  	[torvalds@g5 git]$ git describe --all --abbrev=4 v1.0.5^2
> -	tags/v1.0.0-21-g975b
> +	tags/v1.0.0-21-g975b3
>
>  	[torvalds@g5 git]$ git describe --all HEAD^
> -	heads/lt/describe-7-g975b
> +	heads/lt/describe-7-g975b31d
>
>  With --abbrev set to 0, the command can be used to find the
>  closest tagname without any suffix:
> -- 
> 1.6.2.95.g934f7
