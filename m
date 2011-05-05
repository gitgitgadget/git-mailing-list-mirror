From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fast-import.txt: --relative-marks takes no parameter
Date: Thu, 05 May 2011 10:18:07 -0700
Message-ID: <7v7ha59icw.fsf@alter.siamese.dyndns.org>
References: <a1f7a117ba4deff49c7462f62e1be5da500540fb.1304586800.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 05 19:18:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI2C2-0003Vg-Vc
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 19:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab1EERST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 13:18:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab1EERSS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 13:18:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D7A75912;
	Thu,  5 May 2011 13:20:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XIFWDz2rXHsYTPzBw1v0LIrhsmk=; b=k0Tbvn
	+YAqNNgdJeQ+Ua0lK4Lo/AwNmBRJ5IRov8ALdK0cIgaf/p4fo+cETdZ1QqAN5ANw
	ppMP7zbMhDasX/daHn8bi92h1Tcg0WC95NwFGXcHnpiAL0/wx+bFxR3h4BAk9ppK
	TuyGotU8c8xCYegKhuBe9xRT/FWGUOWN8lIOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tZIJdK+jS5TH8AjiCX4+1vTQVog47/RZ
	4pwXwbRepzw7BUD2p4/PkOXh4V9FoM5WmRCuRy4Ju+ZWHIUZEO+vrFaJtwNJPZxz
	esE3osjFvKBLUlScKmVmsk9bMKb4YeaPfn/BeNYxkuieqMTvHvlqbZ7gNKTloKrL
	L+1keQypKdc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 09E285910;
	Thu,  5 May 2011 13:20:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D2C8D590F; Thu,  5 May 2011
 13:20:13 -0400 (EDT)
In-Reply-To: <a1f7a117ba4deff49c7462f62e1be5da500540fb.1304586800.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu, 5 May 2011 11:13:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2B13866-773B-11E0-A4BE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172854>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Remove spurious "=" after --relative-marks.

"fast-import" does accept --relative-marks= (or --relative-marksmith for
that matter), I think, as its parser added in bc3c79a (fast-import: add
(non-)relative-marks feature, 2009-12-04) is broken and uses prefixcmp()
when parsing the command line.  Sverre may want to fix it.

But your patch is the right thing to do anyway, as I think this option
never meant to accept any option argument.

Will apply.  Thanks.

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/git-fast-import.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 2c2ea12..249249a 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -83,7 +83,7 @@ OPTIONS
>  	skips the file if it does not exist.
>  
>  --relative-marks::
> -	After specifying --relative-marks= the paths specified
> +	After specifying --relative-marks the paths specified
>  	with --import-marks= and --export-marks= are relative
>  	to an internal directory in the current repository.
>  	In git-fast-import this means that the paths are relative
> @@ -93,7 +93,7 @@ OPTIONS
>  --no-relative-marks::
>  	Negates a previous --relative-marks. Allows for combining
>  	relative and non-relative marks by interweaving
> -	--(no-)-relative-marks= with the --(import|export)-marks=
> +	--(no-)-relative-marks with the --(import|export)-marks=
>  	options.
>  
>  --cat-blob-fd=<fd>::
