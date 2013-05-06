From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config
Date: Mon, 06 May 2013 08:36:15 -0700
Message-ID: <7vtxmgruhc.fsf@alter.siamese.dyndns.org>
References: <15tsj20cizd.fsf@tux.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>
X-From: git-owner@vger.kernel.org Mon May 06 17:36:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZNSh-0003bU-Aa
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 17:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab3EFPgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 11:36:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34607 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754737Ab3EFPgS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 11:36:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 192B81AC14;
	Mon,  6 May 2013 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NjpaHBPlx8vFhpEtFyBpouRB3Ls=; b=lHFr0J
	r55nhVOuwMFzBJ62keoWohx116RzF4ZIsQjqUFchAWhF/afVNNAROwwyBWEgXxvM
	9BJO0Gqgm+tg6A6TCabQXaLk/Pq8G7nsN2dQI9m7QNAs46qhOb4Dhd6fzVYUUopr
	SfU7Df8FWmbOVDnbZHgexC4eM/KLcreF2TmZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kkiu/zU17XO5icf5XfPaFWWcHMkDaKmn
	53fKBf5phKQXOF/EkTUJ4d82jqB3LQdyoS+owrWMThNlqkB2Z56p3ut2+hSPi16X
	QCEsxm3NxnYjaH5PlTEWIibBeupeQBRJgERUVS1lEQthw36H7VjzPZPHUkHOvnkT
	KmwiEsisWHE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F5791AC13;
	Mon,  6 May 2013 15:36:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 544601AC10;
	Mon,  6 May 2013 15:36:17 +0000 (UTC)
In-Reply-To: <15tsj20cizd.fsf@tux.uio.no> (Trond Hasle Amundsen's message of
	"Mon, 06 May 2013 15:53:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1612E30-B662-11E2-8B34-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223463>

Trond Hasle Amundsen <t.h.amundsen@usit.uio.no> writes:

> Hello,
>
> The included patch attempts to improve post-receive-email. It's a

Please don't ;-)

Eh, actually, thanks for the patch.

But when you send a patch the next time around, please have the
above and the next three lines (i.e. "introductory text") _below_
the three-dash line.

> trivial change, but one that helps us Gitolite users. Comments are
> welcome, and this is my first attempt at contributing to the Git
> project. Please keep me on CC as I'm not on the list.

>
> From 878a7af9088e2bcc3afc9b09b9023f1f188c844b Mon Sep 17 00:00:00 2001
> From: Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>
> Date: Mon, 6 May 2013 15:41:25 +0200
> Subject: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config

And remove these five lines above.  We will read the authorship and
subject from the e-mail header of your message.

>
> When getting the project description, we first try gitweb.description
> entry in repo.git/config, but repo.git/description takes precedence if
> it exists. This behaviour mimics that of Gitweb, and is what we want
> when using Gitolite, which deletes repo.git/description upon repo
> creation and rather maintains a gitweb.description entry in
> repo.git/config if a description is configured.
>
> Signed-off-by: Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>
> ---
>  contrib/hooks/post-receive-email |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index 0e5b72d..6ce046a 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -714,7 +714,14 @@ if [ -z "$GIT_DIR" ]; then
>  	exit 1
>  fi
>  
> -projectdesc=$(sed -ne '1p' "$GIT_DIR/description" 2>/dev/null)
> +# Get the repo's description. First try gitweb.description entry in
> +# repo.git/config, but repo.git/description takes precedence if it
> +# exists. This behaviour mimics that of Gitweb.
> +projectdesc=$(git config gitweb.description)
> +if [ -f "$GIT_DIR/description" ]; then
> +        projectdesc=$(sed -ne '1p' "$GIT_DIR/description" 2>/dev/null)
> +fi
> +
>  # Check if the description is unchanged from it's default, and shorten it to
>  # a more manageable length if it is
>  if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null

If description file takes precedence, then the right order to do
this would be

    projectdesc=$(sed -ne 1p "$GIT_DIR/description" 2>/dev/null)
    if expr "$projectdesc" : "Unnamed repository" >/dev/null
    then
            : use it as is
    elif projectdesc=$(git config gitweb.description)
    then
            : use it as is
    else
            projectdesc="UNNAMED PROJECT"
    fi

to avoid calling "git config" when it is not even necessary.

We can obviously shorten it by making it less readable, e.g.        

    projectdesc=$(sed -ne 1p "$GIT_DIR/description" 2>/dev/null)

    ! expr "$projectdesc" : "Unnamed repository" >/dev/null ||
    projectdesc=$(git config gitweb.description) ||
    projectdesc="UNNAMED PROJECT"

but I do not think we want to go in that direction ;-)
