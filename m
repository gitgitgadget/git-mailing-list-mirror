From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a commit.signoff configuration variable to always
 use --signoff
Date: Sat, 27 Dec 2008 03:53:47 -0800
Message-ID: <7v8wq1esvo.fsf@gitster.siamese.dyndns.org>
References: <7v63l6f1mc.fsf@gitster.siamese.dyndns.org>
 <1230368596-6865-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sat Dec 27 12:55:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGXlJ-0007Yo-Ko
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 12:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbYL0Lx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 06:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbYL0Lx5
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 06:53:57 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbYL0Lx5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2008 06:53:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BF2348AFC0;
	Sat, 27 Dec 2008 06:53:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 040708AFBA; Sat,
 27 Dec 2008 06:53:49 -0500 (EST)
In-Reply-To: <1230368596-6865-1-git-send-email-dato@net.com.org.es> (Adeodato
 =?utf-8?Q?Sim=C3=B3's?= message of "Sat, 27 Dec 2008 10:03:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 082B39DC-D40D-11DD-B254-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103998>

Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> +commit.signoff::
> +	If set, 'git commit' will behave as if '-s' option was given.
> +	Please use this option with care: by enabling it, you're stating
> +	that all your commits will invariably meet the S-o-b
> +	requirements for any project you send patches to. It's probably

This is true only if you set it in your global configuration.  A more s=
ane
usage would be to have it per repository as you recommend in a later
sentence, and "for any project" part is untrue when the reader does so.

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.=
txt
> index b5d81be..abab839 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -96,7 +96,8 @@ OPTIONS
>  -s::
>  --signoff::
>  	Add Signed-off-by line by the committer at the end of the commit
> -	log message.
> +	log message. This overrides the `commit.signoff` configuration
> +	variable.

Good and careful thinking.  I like it.
