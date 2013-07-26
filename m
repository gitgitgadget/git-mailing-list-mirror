From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config doc: quote paths, fixing tilde-interpretation
Date: Fri, 26 Jul 2013 08:45:10 -0700
Message-ID: <7vk3kd2um1.fsf@alter.siamese.dyndns.org>
References: <1374835322-6452-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 17:45:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2kCy-0002P2-Cv
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 17:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429Ab3GZPp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 11:45:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38789 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932413Ab3GZPpY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 11:45:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 412C832D59;
	Fri, 26 Jul 2013 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MJ+n0zCEff1Y37uBE/kRe1Hec5A=; b=LaFNON
	Mnhivt1hYG0CN5HAqVUw2DCQC5LIQkErfDYBmohY/0uVD0q7wMW+14LgQEI+wheq
	NNXWaz8yiopAcU65VavQRIxAlT3+xZ8AH7V55e7HtVl2oo6XeJk6ReiW9OePq0xG
	fU7t2VH7D/TO6UeSvian0b786E7Nd0++sodOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tdRkoILGGJokok08dlrWeJv9m0KN3QE9
	hEAhNkEmfpJTXXhFUGYcAK/mJURN0IMSlKGzO4/mP+w1W+g80ZKLAsWRrOoTUx53
	h76sXxdaJG/+Sf3G07suWj5AKyYrK2oY4fvBjUnaxwXLGwtKMF2Wdau6W9DNf7Ln
	YJIsdM4Fpyo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 349D632D58;
	Fri, 26 Jul 2013 15:45:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 510A732D4A;
	Fri, 26 Jul 2013 15:45:21 +0000 (UTC)
In-Reply-To: <1374835322-6452-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 26 Jul 2013 16:12:02 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 611521EC-F60A-11E2-9E31-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231189>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The --global section of git-config(1) currently reads like:
>
>   For writing options: write to global /.gitconfig file rather than the
>                                        ^
> 				       start tilde
>
>   repository .git/config, write to $XDG_CONFIG_HOME/git/config file if
>   this file exists and the/.gitconfig file doesn’t.
>                           ^
> 			  end tilde
>
> Instead of tilde (~) being interpreted literally, asciidoc subscripts
> the text between the two tildes.  To fix this problem, use backticks (`)
> to quote all the paths in the file uniformly, just like config.txt does.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Candidate for maint?

Surely; thanks for sharp eyes.

>  Documentation/git-config.txt | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 34b0894..2dbe486 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -96,29 +96,31 @@ OPTIONS
>  	names are not.
>  
>  --global::
> -	For writing options: write to global ~/.gitconfig file rather than
> -	the repository .git/config, write to $XDG_CONFIG_HOME/git/config file
> -	if this file exists and the ~/.gitconfig file doesn't.
> +	For writing options: write to global `~/.gitconfig` file
> +	rather than the repository `.git/config`, write to
> +	`$XDG_CONFIG_HOME/git/config` file if this file exists and the
> +	`~/.gitconfig` file doesn't.
>  +
> -For reading options: read only from global ~/.gitconfig and from
> -$XDG_CONFIG_HOME/git/config rather than from all available files.
> +For reading options: read only from global `~/.gitconfig` and from
> +`$XDG_CONFIG_HOME/git/config` rather than from all available files.
>  +
>  See also <<FILES>>.
>  
>  --system::
> -	For writing options: write to system-wide $(prefix)/etc/gitconfig
> -	rather than the repository .git/config.
> +	For writing options: write to system-wide
> +	`$(prefix)/etc/gitconfig` rather than the repository
> +	`.git/config`.
>  +
> -For reading options: read only from system-wide $(prefix)/etc/gitconfig
> +For reading options: read only from system-wide `$(prefix)/etc/gitconfig`
>  rather than from all available files.
>  +
>  See also <<FILES>>.
>  
>  --local::
> -	For writing options: write to the repository .git/config file.
> +	For writing options: write to the repository `.git/config` file.
>  	This is	the default behavior.
>  +
> -For reading options: read only from the repository .git/config rather than
> +For reading options: read only from the repository `.git/config` rather than
>  from all available files.
>  +
>  See also <<FILES>>.
> @@ -218,9 +220,9 @@ $(prefix)/etc/gitconfig::
>  
>  $XDG_CONFIG_HOME/git/config::
>  	Second user-specific configuration file. If $XDG_CONFIG_HOME is not set
> -	or empty, $HOME/.config/git/config will be used. Any single-valued
> +	or empty, `$HOME/.config/git/config` will be used. Any single-valued
>  	variable set in this file will be overwritten by whatever is in
> -	~/.gitconfig.  It is a good idea not to create this file if
> +	`~/.gitconfig`.  It is a good idea not to create this file if
>  	you sometimes use older versions of Git, as support for this
>  	file was added fairly recently.
