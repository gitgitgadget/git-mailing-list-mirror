From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v8 1/3] submodule: add get_submodule_config helper
	funtion
Date: Fri, 21 Dec 2012 09:20:33 +0100
Message-ID: <20121221082033.GB560@book.hvoigt.net>
References: <cover.1355932282.git.wking@tremily.us> <3377beb925bc209d90058493b74d174db1b7aa50.1355932282.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: wking@tremily.us
X-From: git-owner@vger.kernel.org Fri Dec 21 09:29:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlxzM-0000qt-Ja
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 09:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468Ab2LUI3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 03:29:35 -0500
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:44394 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab2LUI3e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 03:29:34 -0500
X-Greylist: delayed 531 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2012 03:29:33 EST
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TlxqN-0004fi-Ep; Fri, 21 Dec 2012 09:20:35 +0100
Content-Disposition: inline
In-Reply-To: <3377beb925bc209d90058493b74d174db1b7aa50.1355932282.git.wking@tremily.us>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211960>

On Wed, Dec 19, 2012 at 11:03:31AM -0500, wking@tremily.us wrote:
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2365149..263a60c 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -153,6 +153,32 @@ die_if_unmatched ()
[...]
> +get_submodule_config () {
> +	name="$1"
> +	option="$2"
> +	default="$3"
> +	value=$(git config submodule."$name"."$option")
> +	if test -z "$value"
> +	then
> +		value=$(git config -f .gitmodules submodule."$name"."$option")
> +	fi
> +	printf '%s' "${value:-$default}"
> +}
> +
> +
> +#

Minor nit: For all other functions we only have one newline as
separator.

Cheers Heiko
