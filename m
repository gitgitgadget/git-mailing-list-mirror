From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git.el: Don't use font-lock-compile-keywords
Date: Sat, 2 Apr 2011 19:19:02 -0500
Message-ID: <20110403001902.GA25671@elie>
References: <m3oc501rja.fsf@e4300lm.epcc.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	Kevin Ryde <user42@zip.com.au>
To: Lawrence Mitchell <wence@gmx.li>
X-From: git-owner@vger.kernel.org Sun Apr 03 02:19:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6B2O-0002yV-7F
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 02:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757484Ab1DCATU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 20:19:20 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64414 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386Ab1DCATO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 20:19:14 -0400
Received: by iyb14 with SMTP id 14so4764042iyb.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 17:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tQDYJWlYXjNOvQM8Z01wYkBKDuDkm2Yf1RuuoLpNM2M=;
        b=GCu3nhGZdedAcc5tj3ySsHzRki5x5hQ3P/6GwEkx1zogIhFLP/6T84Q5EgdqBM+5od
         4Yx/0vYYYoWcUwUhf/p1qZ76rVCdXZnlbKt80MI7fWfk6oMIpE1VtNYZ6R9rz49ZpbI3
         HE9bBD2/J+RPJE2vzOSiqr23ZLOtsuhARW7tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oe3BE1KHLakg7hvcu4uHN2I4CvQO45cmjOdUoiAfTHn4Tpbp+01IhQ01/iMxTgALSZ
         WpoR+9M5kFZyyQNuibbXQhtvIki641Mw4L2aNwp1oB1qpbyO4qqK3OlXvzjCRC9wl72V
         KIUIW0vX0errTcPKjiKOOmh4/DqJFV9C/N4Zk=
Received: by 10.42.138.68 with SMTP id b4mr1857844icu.499.1301789953352;
        Sat, 02 Apr 2011 17:19:13 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.ameritech.net [68.255.107.98])
        by mx.google.com with ESMTPS id wo15sm2346184icb.4.2011.04.02.17.19.10
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Apr 2011 17:19:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3oc501rja.fsf@e4300lm.epcc.ed.ac.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170667>

Hi,

Lawrence Mitchell wrote:

> If font-lock is disabled, font-lock-compile-keywords complains.
> Really what we want to do is to replace log-edit's font-lock
> definitions with our own, so define a major mode deriving from
> log-edit and set up font-lock-defaults there.  We then use the
> optional MODE argument to log-edit to set up the major mode of the
> commit buffer appropriately.
>
> Signed-Off-By: Lawrence Mitchell <wence@gmx.li>
> ---
> I sent this before, in response to Johnathan's message of 4th Feb
> (http://thread.gmane.org/gmane.comp.version-control.git/36088/focus=166038),
> but it's possible it got lost in the noise.

Thanks.  This is way beyond my knowledge of emacs; I was just passing
on Kevin's report before.  Kevin, what do you think?  Is it a good
fix?

(For those reading between the lines: why, yes, if you would like to
be maintainer of the contrib/emacs directory, we would be happy to
have you.  When can you start? :))

> So here it is
> again.  The originally proposed patch from Debian is to use
> font-lock-add-keywords rather than font-lock-compile-keywords.
> However, it doesn't exist in XEmacs, if one is looking to
> maintain compatibility, I believe this patch is the right thing
> to do.
>
>  contrib/emacs/git.el |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)

Leaving patch unsnipped for reviewers' sake.

Sorry for the slow response,
Jonathan

> 
> diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
> index 214930a..65c95d9 100644
> --- a/contrib/emacs/git.el
> +++ b/contrib/emacs/git.el
> @@ -1310,6 +1310,13 @@ The FILES list must be sorted."
>        (when sign-off (git-append-sign-off committer-name committer-email)))
>      buffer))
>  
> +(define-derived-mode git-log-edit-mode log-edit-mode "Git-Log-Edit"
> +  "Major mode for editing git log messages.
> +
> +Set up git-specific `font-lock-keywords' for `log-edit-mode'."
> +  (set (make-local-variable 'font-lock-defaults)
> +       '(git-log-edit-font-lock-keywords t t)))
> +
>  (defun git-commit-file ()
>    "Commit the marked file(s), asking for a commit message."
>    (interactive)
> @@ -1335,9 +1342,9 @@ The FILES list must be sorted."
>          (git-setup-log-buffer buffer (git-get-merge-heads) author-name author-email subject date))
>        (if (boundp 'log-edit-diff-function)
>  	  (log-edit 'git-do-commit nil '((log-edit-listfun . git-log-edit-files)
> -					 (log-edit-diff-function . git-log-edit-diff)) buffer)
> -	(log-edit 'git-do-commit nil 'git-log-edit-files buffer))
> -      (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
> +					 (log-edit-diff-function . git-log-edit-diff)) buffer 'git-log-edit-mode)
> +	(log-edit 'git-do-commit nil 'git-log-edit-files buffer
> +                  'git-log-edit-mode))
>        (setq paragraph-separate (concat (regexp-quote git-log-msg-separator) "$\\|Author: \\|Date: \\|Merge: \\|Signed-off-by: \\|\f\\|[ 	]*$"))
>        (setq buffer-file-coding-system coding-system)
>        (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t))))
> -- 
> 1.7.4.rc2.18.gb20e9
