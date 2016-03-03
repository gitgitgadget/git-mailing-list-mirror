From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] Documentation/git-pull: document --[no-]autostash option
Date: Thu, 03 Mar 2016 09:14:19 -0800
Message-ID: <xmqqbn6v32ms.fsf@gitster.mtv.corp.google.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-3-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pyokagan@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 18:14:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abWpc-00057b-Og
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 18:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756330AbcCCROX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 12:14:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754510AbcCCROW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 12:14:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E6294798C;
	Thu,  3 Mar 2016 12:14:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bdnym5+4d8fV+aZZXTsbU2jcvnI=; b=Rl9k2i
	9/Z21AYITZsPn5vKaAiM10CpyofUWjcgX1cYOBJaFGxbiUyFz/uWFrtpbSvyzd+G
	XcZknKEYRo85vMHz+Noz5e8s3EB0wccR5518QEIzgNgsQf+VHFu31Rjl3RMpv/SB
	LUthGot3H4TuKJS9dvsTLTbhWfY+Pjy4UHj34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OBMiSHDu21x4XtNP+GRIDgCKeQ7Pz5g0
	jxMDNVWurakB0DVFBw6iB1KHnALp6XhiukfJuCmoF/1s9TyCB4k/CN/5stVYzTi1
	gYPPbMtCPDsUEPZ65jHg8s39gJuT+9tjiFPVZOMoJfLmyah4py2kZYUNEFPtAQ+Y
	s1HbeIJQCtk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 862954798B;
	Thu,  3 Mar 2016 12:14:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E047347987;
	Thu,  3 Mar 2016 12:14:20 -0500 (EST)
In-Reply-To: <1457021601-9099-3-git-send-email-mehul.jain2029@gmail.com>
	(Mehul Jain's message of "Thu, 3 Mar 2016 21:43:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E929020-E163-11E5-8DAA-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288192>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
>  Documentation/git-pull.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index a62a2a6..a593972 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -128,6 +128,21 @@ unless you have read linkgit:git-rebase[1] carefully.
>  --no-rebase::
>  	Override earlier --rebase.
>  
> +--autostash::
> +--no-autostash::
> +	Automatically create a temporary stash before the operation
> +	begins, and apply it after the operation ends. This means
> +	that you can run rebase on a dirty worktree.
> ++
> +This option is only valid when '--rebase' option is used.
> ++
> +The default is --no-autostash, unless rebase.autoStash configuration 
> +is set.
> ++
> +[NOTE]
> +Use with care: the final stash application after a successful
> +rebase might result in non-trivial conflicts.
> +

Should this entry this verbose?

 - Is there a non-temporary stash?

 - I think "This means that ..." is totally unnecessary.

 - It probably makes sense to have "This option is only valid..." as
   a separate second paragraph as you did.

 - "The default is..." is misleading.  Even if rebase.autostash is
   set to false, we won't autostash, but that is different from the
   default being "--no-autostash".

   Think of "--[no-]autostash" option as *ONE* way to affect the
   auto-stashing behaviour, and treat "options" and "behaviours" two
   different things.

There is no default "option" for this.  It is that "autostash"
behaviour defaults to what is given to rebase.autostash if
exists, and can be explicitly set by --[no-]autostash if given.

But that is the norm for any configuration and option that overrides
the configuration, so it probably is a better use of the ink to say
something like this perhaps?

        --autostash::
        --no-autostash::
                Before starting "pull --rebase", create a stash to save
                local modifications, and apply the stash when done (this
                option is only valid when "--rebase" is used).
        +
        '--no-autostash' is useful to override the 'rebase.autoStash'
        configuration variable (see linkgit:git-config[1]).

By the way, some other patches in this series say --noautostash
without a dash after --no, which you would want to correct.

Thanks.
