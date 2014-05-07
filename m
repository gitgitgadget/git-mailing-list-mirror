From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Standardize python shebangs
Date: Wed, 07 May 2014 20:06:39 +0200
Message-ID: <vpqy4ydpiog.fsf@anie.imag.fr>
References: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 20:06:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi6F2-00059b-9T
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 20:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbaEGSGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 14:06:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55988 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108AbaEGSGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 14:06:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s47I6bDr001910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 May 2014 20:06:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s47I6dYY031593;
	Wed, 7 May 2014 20:06:39 +0200
In-Reply-To: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Wed, 7 May 2014 05:03:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 07 May 2014 20:06:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s47I6bDr001910
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1400090801.72624@WfKP08vz+MVPGU9QAVEvWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248340>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It's better if all our scripts use the same '/usr/bin/env python'.

Why?

Using python2 for git_multimail.py is a deliberate decision:

https://github.com/mhagger/git-multimail/pull/2

(also, contrib/hooks/multimail/README says:

"The git-multimail project itself is currently hosted on GitHub:

    https://github.com/mhagger/git-multimail

We use the GitHub issue tracker to keep track of bugs and feature
requests, and GitHub pull requests to exchange patches (though, if you
prefer, you can send patches via the Git mailing list with cc to me).
Please sign off your patches as per the Git project practice."
)

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/hooks/multimail/README                  | 6 +++---
>  contrib/hooks/multimail/git_multimail.py        | 2 +-
>  contrib/hooks/multimail/migrate-mailhook-config | 2 +-
>  contrib/hooks/multimail/post-receive            | 2 +-
>  contrib/svn-fe/svnrdump_sim.py                  | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/README
> index 477d65f..cf0bcb8 100644
> --- a/contrib/hooks/multimail/README
> +++ b/contrib/hooks/multimail/README
> @@ -76,10 +76,10 @@ Requirements
>    The example scripts invoke Python using the following shebang line
>    (following PEP 394 [1]):
>  
> -      #! /usr/bin/env python2
> +      #! /usr/bin/env python
>  
> -  If your system's Python2 interpreter is not in your PATH or is not
> -  called "python2", you can change the lines accordingly.  Or you can
> +  If your system's Python interpreter is not in your PATH or is not
> +  called "python", you can change the lines accordingly.  Or you can
>    invoke the Python interpreter explicitly, for example via a tiny
>    shell script like
>  
> diff --git a/contrib/hooks/multimail/git_multimail.py b/contrib/hooks/multimail/git_multimail.py
> index 8b58ed6..f6dcdc6 100755
> --- a/contrib/hooks/multimail/git_multimail.py
> +++ b/contrib/hooks/multimail/git_multimail.py
> @@ -1,4 +1,4 @@
> -#! /usr/bin/env python2
> +#! /usr/bin/env python
>  
>  # Copyright (c) 2012-2014 Michael Haggerty and others
>  # Derived from contrib/hooks/post-receive-email, which is
> diff --git a/contrib/hooks/multimail/migrate-mailhook-config b/contrib/hooks/multimail/migrate-mailhook-config
> index 04eeaac..fba0b90 100755
> --- a/contrib/hooks/multimail/migrate-mailhook-config
> +++ b/contrib/hooks/multimail/migrate-mailhook-config
> @@ -1,4 +1,4 @@
> -#! /usr/bin/env python2
> +#! /usr/bin/env python
>  
>  """Migrate a post-receive-email configuration to be usable with git_multimail.py.
>  
> diff --git a/contrib/hooks/multimail/post-receive b/contrib/hooks/multimail/post-receive
> index 4d46828..4f2cf9d 100755
> --- a/contrib/hooks/multimail/post-receive
> +++ b/contrib/hooks/multimail/post-receive
> @@ -1,4 +1,4 @@
> -#! /usr/bin/env python2
> +#! /usr/bin/env python
>  
>  """Example post-receive hook based on git-multimail.
>  
> diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
> index 4e78a1c..bf20819 100755
> --- a/contrib/svn-fe/svnrdump_sim.py
> +++ b/contrib/svn-fe/svnrdump_sim.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python
>  """
>  Simulates svnrdump by replaying an existing dump from a file, taking care
>  of the specified revision range.



-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
