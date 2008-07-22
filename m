From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
	to "rebase-merge"
Date: Wed, 23 Jul 2008 01:47:03 +0200
Message-ID: <20080722234703.GD5904@leksak.fem-net>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org> <4882350B.6020003@free.fr> <7v3am5zfea.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olivier Marin <dkr+ml.git@free.fr>, Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:48:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLRaU-0007cp-U6
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 01:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbYGVXrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 19:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753542AbYGVXrK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 19:47:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:44767 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753241AbYGVXrI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 19:47:08 -0400
Received: (qmail invoked by alias); 22 Jul 2008 23:47:07 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp014) with SMTP; 23 Jul 2008 01:47:07 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX193ajR/1rd3kmLuEg7j7a2ODVDRIls97i5txJOba+
	vGtSGkz+L3rDsU
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KLRZP-0005KB-2l; Wed, 23 Jul 2008 01:47:03 +0200
Content-Disposition: inline
In-Reply-To: <7v3am5zfea.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89569>

Hi,

Junio C Hamano wrote:
> Olivier Marin <dkr+ml.git@free.fr> writes:
> > @@ -203,9 +204,10 @@ then
> >  
> >  	case "$abort" in
> >  	t)
> > -		rm -fr "$dotest" &&
> > +		git rerere clear &&
> >  		git read-tree -m -u ORIG_HEAD &&
[...]
> diff --git a/git-am.sh b/git-am.sh
> index a44bd7a..5cbf8f4 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -203,9 +203,9 @@ then
>  
>  	case "$abort" in
>  	t)
> -		rm -fr "$dotest" &&
> -		git read-tree -m -u ORIG_HEAD &&
> -		git reset ORIG_HEAD && :
> +		git rerere clear
> +		git read-tree --reset -u HEAD ORIG_HEAD

Perhaps I am confused, but ...
Why is there "HEAD" and "ORIG_HEAD" and not only "ORIG_HEAD"?

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
