From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] user-manual: add global config section
Date: Sun, 05 Apr 2009 02:47:59 -0700
Message-ID: <7v7i1zv3cg.fsf@gitster.siamese.dyndns.org>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-6-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 11:49:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqOyz-0007pZ-4b
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 11:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757016AbZDEJsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 05:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757002AbZDEJsH
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 05:48:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756980AbZDEJsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 05:48:05 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D410C1D0;
	Sun,  5 Apr 2009 05:48:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9D04CC1CE; Sun, 
 5 Apr 2009 05:48:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DB3BE950-21C6-11DE-BF40-DD19768B9EAE-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115649>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/user-manual.txt |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 3278aa7..a3032c7 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -40,6 +40,36 @@ without any explanation.
>  Finally, see <<todo>> for ways that you can help make this manual more
>  complete.

I think a "getting started" section near the beginning of the manual is a
good idea (and ll.40- is a very early part of the manual).

For that "introductory" purpose, however, I'd suggest showing how they
appear in the actual .git/config file first in the editor and then show a
way to use the "git config" command as an alternative.

> +[[getting-started]]
> +Getting started
> +=============
> +
> +Git's configuration is distributed among different locations--this manual will
> +only to deal with 'global' and 'repository' variables, where 'repository'
> +variables take precedence over 'global' ones.
> +
> +You would probably want to start setting up something useful:
> +------------------------------------------------
> +$ git config --global color.ui auto
> +------------------------------------------------
> +
> +This will make prettier the output of certain commands such as `git diff`, but
> +that's not important; what is important here is that `color.ui` has been
> +stored in the 'global' (for the user) configuration.

"(for the user)" in parentheses here is better than not saying it
anywhere, but I think you should have it in the first paragraph where you
explain there are (at least) two kinds, global vs repository, in order to
clarify what you mean by 'global' is not "system/site wide" but "in any
repository I use" upfront.

> +View and manually modify the configuration with the `--edit`
> +option (which will use '$EDITOR'):
> +------------------------------------------------
> +$ git config --global --edit
> +[color]
> +        ui = auto
> +------------------------------------------------

Copies of user manual are found quite easily (and bookmarked by many
people) on the web, and are looked at by people with not-so-bleeding-edge
version of git, so I'd rather not to give them "config --edit" this early
in the documentation.  Perhaps after at least 6 months (preferrably a
year) after a release that has the new option, we can start encouraging
it, but not before.  So I'd suggest replacing 'with the --edit ...'  with
'$HOME/.gitconfig with your favorite editor' or something like that for
now.

> +Or you can manually edit the file which is located in `~/.gitconfig`. Other
> +locations are `/etc/gitconfig` (system), and `.git/config` (repository).

IOW, have this (without "Or") at the very beginning, and then as an
alternative give "git config color.ui auto".

Thanks.
