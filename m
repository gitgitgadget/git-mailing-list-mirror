From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: TOPGIT: [PATCH] Use standard prefix and DESTDIR rather than explain
Date: Tue, 12 Aug 2008 18:34:34 +0200
Message-ID: <36ca99e90808120934h6d86a7cbpeca8a6c85ba3bce2@mail.gmail.com>
References: <1218545670.7264.2.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Jan Nieuwenhuizen" <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Aug 12 18:35:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSwqY-0001S3-BS
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 18:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbYHLQei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 12:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbYHLQei
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 12:34:38 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:23302 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbYHLQeg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 12:34:36 -0400
Received: by qw-out-2122.google.com with SMTP id 3so228880qwe.37
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5cswz66GKF9arosx7sa2mLokvuCY2c14p4qUmwekWnY=;
        b=WgD5OMLWB14TYfSWnblT9sr+NMK2dc72TZlp+IY7ojrr+eZyur1TTZ9r7Cfnzo1ais
         8KNyH4NiwiaaiMsF9Ib2e/MMK0w3o2ZEkg9NYuRfD9prlXyOpdzFuAwdb0GZMGiEUhsC
         gx1g0eyh0BT5mX3+f1bG7ZHjNL+S66qs5wRKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=I8H3vGik2m+6XTes8I0oqpKJnPjjfnK2EXhNh5zD0keji9CM22j7s04HldU6Of+V23
         EbACCIQlpA1ff8dK3vXG4jk5fsoYoz/CcegvKj/mK5WYG1x3Y0RCrr2OVJCF+CIsZL3j
         PKwEN2klxZzIYMZ0/5OjECb99CacxuWcrsRgs=
Received: by 10.215.66.19 with SMTP id t19mr6711442qak.22.1218558874719;
        Tue, 12 Aug 2008 09:34:34 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Tue, 12 Aug 2008 09:34:34 -0700 (PDT)
In-Reply-To: <1218545670.7264.2.camel@heerbeest>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92112>

On Tue, Aug 12, 2008 at 14:54, Jan Nieuwenhuizen <janneke-list@xs4all.nl> wrote:
> First an install nitpick.
>
>
>
> Signed-off-by: Jan Nieuwenhuizen <janneke@gnu.org>
> ---
>  Makefile |   26 +++++++++++++-------------
>  1 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 6eade1e..ea6489e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,8 +1,7 @@
> -# Set PREFIX to wherever you want to install TopGit
> -PREFIX = $(HOME)
> -bindir = $(PREFIX)/bin
> -cmddir = $(PREFIX)/libexec/topgit
> -sharedir = $(PREFIX)/share/topgit
> +prefix = $(HOME)
> +bindir = $(prefix)/bin
> +cmddir = $(prefix)/libexec/topgit
> +sharedir = $(prefix)/share/topgit
>  hooksdir = $(cmddir)/hooks
>
>
> @@ -31,14 +30,15 @@ $(help_out): README
>        ./create-help.sh $$CMD
>
>  install:: all
> -       install -d -m 755 "$(bindir)"
> -       install tg "$(bindir)"
> -       install -d -m 755 "$(cmddir)"
> -       install $(commands_out) "$(cmddir)"
> -       install -d -m 755 "$(hooksdir)"
> -       install $(hooks_out) "$(hooksdir)"
> -       install -d -m 755 "$(sharedir)"
> -       install -m 644 $(help_out) "$(sharedir)"

> +       install -d -m 755 "$(DESTDIR)$(bindir)"
> +       install -d -m 755 "$(DESTDIR)$(bindir)"
duplicate

Bert
> +       install tg "$(DESTDIR)$(bindir)"
> +       install -d -m 755 "$(DESTDIR)$(cmddir)"
> +       install $(commands_out) "$(DESTDIR)$(cmddir)"
> +       install -d -m 755 "$(DESTDIR)$(hooksdir)"
> +       install $(hooks_out) "$(DESTDIR)$(hooksdir)"
> +       install -d -m 755 "$(DESTDIR)$(sharedir)"
> +       install -m 644 $(help_out) "$(DESTDIR)$(sharedir)"
>
>  clean::
>        rm -f tg $(commands_out) $(hooks_out) $(help_out)
> --
> 1.6.0.rc0.44.g67270
>
>
> --
> Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
> http://www.xs4all.nl/~jantien       | http://www.lilypond.org
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
