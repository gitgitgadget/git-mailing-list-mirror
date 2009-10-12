From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] user-manual: add global config section
Date: Mon, 12 Oct 2009 14:06:39 -0700
Message-ID: <7vws30cof4.fsf@alter.siamese.dyndns.org>
References: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com>
 <1255293786-17293-2-git-send-email-felipe.contreras@gmail.com>
 <20091011222729.GA5114@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 23:14:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxSDj-0002of-JP
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 23:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933152AbZJLVH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933144AbZJLVH6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:07:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933103AbZJLVH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:07:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B33E875D17;
	Mon, 12 Oct 2009 17:06:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=QHGpnjSqCkAoviX9nYy9aFJt32I=; b=edO6Pg6GocePIdfzL2IF8od
	7ktwKtJP/fvTp7bEVWETDhHm6SBkcd8IB5Yx3KOpl4XA/Ns7VszO6/Ed4WsLjtcX
	bsjwiDb4ZGM2mh8VrPEYL74d8Q8zMZG5B1McPOnw3w9OXg/dIS+PpH8soa/2Iknj
	laUPOSi7hrBVF76OQJuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=mkeHzIuz0K93tcLDG0vvvcXUOtHkGH8uYFD0tGSRYkiCHJMp5
	tbRf+U4+6z/RTSJQElRwcIQNRHycgcLIFe4NMBi/5FYYK1OU7WYB6jszdCM75yWT
	8MT24AhNo85mYtTZApOtsBT/LEC++dUgGxA5oI7c5DgNIMsZB5ny59YXAg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7585C75D14;
	Mon, 12 Oct 2009 17:06:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B091F75D12; Mon, 12 Oct 2009
 17:06:40 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 26990698-B773-11DE-9F48-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130073>

Jonathan Nieder <jrnieder@gmail.com> writes:

> This is very early in the manual, where every word counts.  I am not
> very good at wording and do not have any better suggestions, but would
> it be possible to more efficiently convey this:
>
> 	Git reads its per-user configuration from ~/.gitignore.
>
> 	That file can also be manipulated with the "git config"
> 	command, which can be convenient in scripts or when using
> 	operating systems like Windows where it is not clear where
> 	the home directory is.
>
> 	For example, if your terminal supports it, you can tell Git
> 	to use color in the output for commands such as "git diff"
> 	with "git config --global color.ui auto".
>
> 	For more information and a list of possible settings, see
> 	git-config(1).

The way how the above introduces the "git config" command to people who
see git for the first time makes sense.  Unfortunately, --global and
per-user do not "click" together when given in isolation, and I think it
would help if it is explained this way, using a setting that can validly
be either per-user or project specific:

    Various configuration variables affect how git operates.  Some are
    specific to the user (e.g. if you prefer to see the output in colour),
    while some are specific to a repository (e.g. what other repositories
    it interacts with).  Git reads from ~/.gitconfig file to learn your
    personal settings and .git/config file of the repository you are
    working in to learn the repository settings.

    These are plain text files that you can view or edit in your text
    editor, but they also can be manipulated with the "git config"
    command, which is convenient in scripts or ...

    For example, if you want to use a particular e-mail address only while
    working in the current repository, you would set "user.email" variable
    to that e-mail address in the repository configuration file (i.e.
    .git/config) with this command:

	git config user.email your@email.address.xz

    If on the other hand you want to use the same address for any project
    you work with, you can instead set this in your personal configuration
    file (i.e.  ~/.gitconfig) with this command:

	git config --global user.email your@email.address.xz

    For more information ...

Since this is an end-user material, I deliberately omitted talking about
the --system (i.e. /etc/gitconfig) in the above.
