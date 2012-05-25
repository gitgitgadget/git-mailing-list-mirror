From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config doc: remove confusion about relative GIT_DIR from
 FILES section
Date: Fri, 25 May 2012 16:06:31 -0400
Message-ID: <20120525200631.GA4364@sigill.intra.peff.net>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
 <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
 <20120525174237.GA4267@burratino>
 <CAE1pOi3qSEY=Dj-Fqj+=anULVmCdsm72_k+B0SpdGiCO3u7L9A@mail.gmail.com>
 <20120525181204.GA4491@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 22:06:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY0mU-0002QF-8H
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 22:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226Ab2EYUGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 16:06:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56063
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab2EYUGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 16:06:33 -0400
Received: (qmail 12643 invoked by uid 107); 25 May 2012 20:07:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 May 2012 16:07:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 May 2012 16:06:31 -0400
Content-Disposition: inline
In-Reply-To: <20120525181204.GA4491@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198518>

On Fri, May 25, 2012 at 01:12:04PM -0500, Jonathan Nieder wrote:

> From the FILES section of the git-config(1) manual:
> 
> 	$GIT_DIR/config::
> 		Repository specific configuration file. (The filename is
> 		of course relative to the repository root, not the working
> 		directory.)
> 
> That's confusing because $GIT_DIR really is relative to the working
> directory.
> 
> 	$ GIT_DIR=.git GIT_EDITOR='pwd; echo editing'
> 	$ export GIT_DIR GIT_EDITOR
> 	$ git config --edit --local
> 	/home/jrn/src/git/Documentation
> 	editing .git/config
> 
> It turns out that the comment is a remnant from older days when the
> heading said ".git/config" (which is indeed relative to the top of the
> worktree).
> 
> It was only when the heading was changed to refer more precisely to
> <git dir>/config (see v1.5.3.2~18, AsciiDoc tweak to avoid leading
> dot, 2007-09-14) that the parenthesis stopped making sense.  Remove
> it.

Thanks for digging in the history for the answer.

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 3f5d216a..d9463cb3 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -198,9 +198,7 @@ If not set explicitly with '--file', there are three files where
>  'git config' will search for configuration options:
>  
>  $GIT_DIR/config::
> -	Repository specific configuration file. (The filename is
> -	of course relative to the repository root, not the working
> -	directory.)
> +	Repository specific configuration file.
>  
>  ~/.gitconfig::
>  	User-specific configuration file. Also called "global"

This makes a lot more sense to me.

Acked-by: Jeff King <peff@peff.net>

-Peff
