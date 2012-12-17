From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] gitk-git/Makefile: track TCLTK_PATH as it used to
 be tracked
Date: Sun, 16 Dec 2012 23:33:54 -0800
Message-ID: <7vvcc1m8t9.fsf@alter.siamese.dyndns.org>
References: <20121217071716.26209.54407.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:34:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkVDK-0003iU-SY
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 08:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246Ab2LQHd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 02:33:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768Ab2LQHd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 02:33:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BD849CE5;
	Mon, 17 Dec 2012 02:33:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h8GBsevANDEPLyaoFx+t87Mjd5o=; b=F0rjxp
	9TO6n5pT58i5rSRk9sMbXiOpUlGVCQmLw72n072E1rJ/nVl+s+FRyJHClODefmoy
	LtU1fbs/1EWvw/Bkwfdth2K399LyWNMENoOLsdLac0sb46UYs7lJrDwJqnnhLRad
	q3dIgz8bWo2fTZ4Ff2Pqwy82RmMnLjkamA8M4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MAQiC5Z2kAQlCRrMYePnC/JOaRAMKPg6
	iKTJNbJQ/mKA8yBKznKVJI7M5cqOhe5dlWxjkshBuD8DfvqnzkoKop49+y/s3klZ
	z8Y1i3TN8xqvM3eVH3rb1YMLvdqQFO+uF7UZLnfH1eABtEV0ZE4QUadKTMlBGo7m
	SroVGhHYYro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 191E39CE4;
	Mon, 17 Dec 2012 02:33:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 597B09CE3; Mon, 17 Dec 2012
 02:33:56 -0500 (EST)
In-Reply-To: <20121217071716.26209.54407.chriscool@tuxfamily.org> (Christian
 Couder's message of "Mon, 17 Dec 2012 08:17:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D61316C-481C-11E2-B3C0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211653>

Christian Couder <chriscool@tuxfamily.org> writes:

> In 62ba514 (Move gitk to its own subdirectory, 2007-11-17) some
> code used to track TCLTK_PATH was left in the main Makefile instead
> of being moved to the new Makefile that was created in gitk-git/.
>
> The code left in the main Makefile should have been removed by a
> previous patch in the same series as this one.
>
> And this patch puts some code back to track TCLTK_PATH properly
> where it should be, that is in gitk-git/Makefile.
>
> Note that there is already some code to do that in git-gui/Makefile.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  .gitignore          |  1 -
>  gitk-git/.gitignore |  2 ++
>  gitk-git/Makefile   | 16 ++++++++++++++--

I'll apply the .gitignore part to my tree, but could you split the
rest out and have Paul apply to his tree at

    git://ozlabs.org/~paulus/gitk.git

>  3 files changed, 16 insertions(+), 3 deletions(-)
>  create mode 100644 gitk-git/.gitignore
>
> diff --git a/.gitignore b/.gitignore
> index 086c5af..56a4b2b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -171,7 +171,6 @@
>  /git-whatchanged
>  /git-write-tree
>  /git-core-*/?*
> -/gitk-git/gitk-wish
>  /gitweb/GITWEB-BUILD-OPTIONS
>  /gitweb/gitweb.cgi
>  /gitweb/static/gitweb.js
> diff --git a/gitk-git/.gitignore b/gitk-git/.gitignore
> new file mode 100644
> index 0000000..d7ebcaf
> --- /dev/null
> +++ b/gitk-git/.gitignore
> @@ -0,0 +1,2 @@
> +/GIT-TCLTK-VARS
> +/gitk-wish
> diff --git a/gitk-git/Makefile b/gitk-git/Makefile
> index e1b6045..5acdc90 100644
> --- a/gitk-git/Makefile
> +++ b/gitk-git/Makefile
> @@ -17,6 +17,16 @@ DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
>  bindir_SQ = $(subst ','\'',$(bindir))
>  TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
>  
> +### Detect Tck/Tk interpreter path changes
> +TRACK_TCLTK = $(subst ','\'',-DTCLTK_PATH='$(TCLTK_PATH_SQ)')
> +
> +GIT-TCLTK-VARS: FORCE
> +	@VARS='$(TRACK_TCLTK)'; \
> +		if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
> +			echo 1>&2 "    * new Tcl/Tk interpreter location"; \
> +			echo "$$VARS" >$@; \
> +		fi
> +
>  ## po-file creation rules
>  XGETTEXT   ?= xgettext
>  ifdef NO_MSGFMT
> @@ -49,9 +59,9 @@ uninstall::
>  	$(RM) '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
>  
>  clean::
> -	$(RM) gitk-wish po/*.msg
> +	$(RM) gitk-wish po/*.msg GIT-TCLTK-VARS
>  
> -gitk-wish: gitk
> +gitk-wish: gitk GIT-TCLTK-VARS
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
>  	sed -e '1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' <gitk >$@+ && \
>  	chmod +x $@+ && \
> @@ -65,3 +75,5 @@ $(ALL_MSGFILES): %.msg : %.po
>  	@echo Generating catalog $@
>  	$(MSGFMT) --statistics --tcl $< -l $(basename $(notdir $<)) -d $(dir $@)
>  
> +.PHONY: all install uninstall clean update-po
> +.PHONY: FORCE
