From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use -h for synopsis and --help for manpage consistently
Date: Mon, 03 Oct 2011 15:03:51 -0700
Message-ID: <7vhb3penqw.fsf@alter.siamese.dyndns.org>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
 <20111003182136.GA6136@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Oct 04 00:04:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAqcC-0003lV-3b
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 00:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645Ab1JCWD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 18:03:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab1JCWDy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 18:03:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6DCE5E12;
	Mon,  3 Oct 2011 18:03:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+1Ei63uYn4WZwfUhamAULyGKAMc=; b=Js/zQ6
	aWXup5fE3paNuQ8EQ8fPyHgq2W9KLeYM2ycQpXFSbaSNO692CEoatkgbsIxKQNMD
	nFGbopWxoxehD1GRv6bkx7a4HUHY0Afs5drlWPPCWIHpUnQuzyOcUPznmSkR5ZYI
	fir8pDVW4zYaP9j1+0emdGRliaE8RV4vlk5fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lApy1UVlXBLuGNqKbubyM9SFW3A2h67D
	2NYEZv9tB2iwggPSXRHEE+//EuIyCBUiXq1Gy2K7tgkX9fCvynS6834YvnnLMdH4
	U18SnBS+meYEa8tpComqJMqXccQfwezUw/cvrFF9xWU2HhGy+nj/mKRANLWHzb5+
	RFJKGoqg5V8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B432E5E0F;
	Mon,  3 Oct 2011 18:03:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46C755E0E; Mon,  3 Oct 2011
 18:03:53 -0400 (EDT)
In-Reply-To: <20111003182136.GA6136@ecki.lan> (Clemens Buchacher's message of
 "Mon, 3 Oct 2011 20:21:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95006DA8-EE0B-11E0-9B72-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182715>

Clemens Buchacher <drizzd@aon.at> writes:

> Hi Junio,
>
> This is a re-send in case you missed it.

Thanks.

> Cheers,
> Clemens
>
> --8<--
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
> ...
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 1b8bff2..6c5185e 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -109,14 +109,14 @@ my $usage =
>      "    --strict-paths      : Don't allow recursing into subdirectories\n".
>      "    --export-all        : Don't check for gitcvs.enabled in config\n".
>      "    --version, -V       : Print version information and exit\n".
> -    "    --help, -h, -H      : Print usage information and exit\n".
> +    "    -h                  : Print usage information and exit\n".
>      "\n".
>      "<directory> ... is a list of allowed directories. If no directories\n".
>      "are given, all are allowed. This is an additional restriction, gitcvs\n".
>      "access still needs to be enabled by the gitcvs.enabled config option.\n".
>      "Alternately, one directory may be specified in GIT_CVSSERVER_ROOT.\n";
>  
> -my @opts = ( 'help|h|H', 'version|V',
> +my @opts = ( 'h', 'version|V',

I am a bit skeptical about the removal of 'H' here (also in git-svn).

Granted, no sane script would have ever used "-H" (or "-h" for that
matter) so there is little chance for this to introduce a painful
regression.
