From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 2/5] gitweb: Describe CSSMIN and JSMIN in gitweb/INSTALL
Date: Mon, 6 Jun 2011 15:01:26 -0500
Message-ID: <20110606200126.GB30588@elie>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
 <1307382271-7677-3-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Drew Northup <drew.northup@maine.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 22:01:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTfzW-0005Yd-5j
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 22:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756468Ab1FFUBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 16:01:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36122 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281Ab1FFUBc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 16:01:32 -0400
Received: by iwn34 with SMTP id 34so3403005iwn.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 13:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0mvAgW3pn64BYuv0qWpMYGrSqPe46gFs9M3H6//jQqc=;
        b=W9RPEBABxLh5MfVBzuTlkYyCk+6ltremIG+2V/gmggzrJl56Nf9e9ORopQog0NSkEc
         jAVKtd1CbWqaUiCNShmUeuoLYEOtYScvEfi/6kTs3adv79GKsdZhtbOeDgZpq7br3W1K
         RqsNz9+KCdB5jLGRxxv6DJv2PaoJZJF1byT2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ujk1rBicsaEXUFpdUdL71szjMGTtK1FjPiMDY40BTgDdrAH2tVJb++8VLTmb0b7XPA
         ZkExlob3+2rlRwxjnkPxRNFEpJTZ8SS/LmmjAXuTNvJnhcTHS+cdFq8fmRawWNbLIjoF
         jSvD5GUTWwRcILM0yyD0ezQLb5JWntuCLucgU=
Received: by 10.43.62.13 with SMTP id wy13mr1746980icb.342.1307390491182;
        Mon, 06 Jun 2011 13:01:31 -0700 (PDT)
Received: from elie (adsl-68-255-97-40.dsl.chcgil.sbcglobal.net [68.255.97.40])
        by mx.google.com with ESMTPS id f6sm2960737icx.15.2011.06.06.13.01.28
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 13:01:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307382271-7677-3-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175159>

Jakub Narebski wrote:

> The build-time configuration variables JSMIN and CSSMIN were mentioned
> only in Makefile; add their description to gitweb/INSTALL.
>
> This required moving description of GITWEB_JS up, near GITWEB_CSS and
> just introduced CSMIN and JSMIN.

Why does this require that?  Ah, to make the analogy with GITWEB_CSS
clear and because the JSMIN description refers to it.

> --- a/gitweb/INSTALL
> +++ b/gitweb/INSTALL
> @@ -147,6 +147,19 @@ You can specify the following configuration variables when building GIT:
[...]
> + * CSSMIN, JSMIN
> +   Invocation of a CSS minifier or a JavaScript minifier, respectively,
> +   working as a filter (source on standard input, minified result on
> +   standard output).  If set, it is used to generate a minified version of
> +   'static/gitweb.css' or 'static/gitweb.js', respectively.  *Note* that
> +   minified files would have *.min.css and *.min.js extension, which is
> +   important if you also set GITWEB_CSS and/or GITWEB_JS.  [No default]

When I first read this, I thought it meant these command lines were
going to be cooked into the gitweb script and invoked at run time.
Maybe (sorry for the rough text):

* CSSMIN, JSMIN
  Command for a CSS minifier or a Javascript minifier, working as a
  filter [...]
  These are used if defined to generate smaller, non human-readable
  versions of 'gitweb/gitweb.css' and 'static/gitweb.js' at
  'static/gitweb.min.css' and 'static/gitweb.min.js'.  Only the minified
  versions are installed, which is important if you also set GITWEB_CSS
  or GITWEB_JS.  [No default]

Aside from that, looks good.  Thanks.
