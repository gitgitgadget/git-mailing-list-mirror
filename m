From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] Add function to checkout a branch in git.el
Date: Wed, 13 Feb 2008 21:29:21 +0300
Message-ID: <87y79ovhfi.fsf@osv.gnss.ru>
References: <87wsp8u9m7.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 19:30:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPMMt-0004X8-M4
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 19:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbYBMS3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 13:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbYBMS3a
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 13:29:30 -0500
Received: from javad.com ([216.122.176.236]:2560 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbYBMS33 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 13:29:29 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m1DITRd79684;
	Wed, 13 Feb 2008 18:29:27 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JPMMD-00049C-LT; Wed, 13 Feb 2008 21:29:21 +0300
In-Reply-To: <87wsp8u9m7.dlv@maison.homelinux.org> (utf's message of "Wed\, 13 Feb 2008 16\:53\:12 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73809>

<vanicat@debian.org> writes:
> One can now:
> - checkout an existing branch with M-x git-change-branch
> - create and checkout a new branch with C-u M-x git-change-branch

s/git-change-branch/git-checkout/? I mean is there any reason it is
called differently from GIT's "git checkout"?

Besides, I also think that prefix is not a good idea for this kind of
stuff (see my other reply in this thread).

> - do all this from the Git menu
> ---
> It could also be interesting to add some  key biding for those
>
> Also one might want to update the *git-status* buffer after checkout,
> but this is not done by this patch

Why? Isn't it as simple as calling (git-refresh-status) at the end of
git-change-branch?

>  contrib/emacs/git.el |   45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 45 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
> index a8bf0ef..404c8e6 100644
> --- a/contrib/emacs/git.el
> +++ b/contrib/emacs/git.el
> @@ -1138,6 +1138,50 @@ Return the list of files that haven't been handled."
>    (when (eq (window-buffer) (current-buffer))
>      (shrink-window-if-larger-than-buffer)))
>  
> +(defun git-list-branch ()
> +  "Return a list of available branch"

s/branch/branches/

> +  ;; should I check if I'm in a git repository ?
> +  (let ((branchs ()))

s/branchs/branches/


-- Sergei.
