From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 11/28] test suite: remove pointless redirection.
Date: Tue, 6 May 2014 15:57:39 -0400
Message-ID: <20140506195739.GM1655@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-12-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:26:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhlUi-00063F-2j
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 21:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbaEFT5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 15:57:36 -0400
Received: from josefsipek.net ([64.9.206.49]:1698 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028AbaEFT5f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 15:57:35 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 01B6955654;
	Tue,  6 May 2014 15:57:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-12-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248239>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Fri, Mar 21, 2014 at 08:31:49AM +0100, Per Cederqvist wrote:
> The shouldfail function already redirects stderr to stdout, so there
> is no need to do the same in t-028.sh and t-021.sh.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/t-021.sh | 2 +-
>  regression/t-025.sh | 2 +-
>  regression/t-028.sh | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/regression/t-021.sh b/regression/t-021.sh
> index 6337d7b..614e870 100755
> --- a/regression/t-021.sh
> +++ b/regression/t-021.sh
> @@ -61,7 +61,7 @@ for n in `_seq -2 $npatches`; do
>  	if [ $n -gt 0 ]; then
>  		cmd guilt pop -n $n
>  	else
> -		shouldfail guilt pop -n $n 2>&1
> +		shouldfail guilt pop -n $n
>  	fi
>  
>  	cmd list_files
> diff --git a/regression/t-025.sh b/regression/t-025.sh
> index 3824608..985fed4 100755
> --- a/regression/t-025.sh
> +++ b/regression/t-025.sh
> @@ -44,7 +44,7 @@ shouldfail guilt new "white space"
>  cmd list_files
>  
>  for pname in prepend mode /abc ./blah ../blah abc/./blah abc/../blah abc/. abc/.. abc/ ; do
> -	shouldfail guilt new "$pname" 2>&1
> +	shouldfail guilt new "$pname"
>  
>  	cmd list_files
>  done
> diff --git a/regression/t-028.sh b/regression/t-028.sh
> index 8480100..88e9adb 100755
> --- a/regression/t-028.sh
> +++ b/regression/t-028.sh
> @@ -29,6 +29,6 @@ guilt series | while read n; do
>  	cmd guilt header $n
>  done
>  
> -shouldfail guilt header non-existant 2>&1
> +shouldfail guilt header non-existant
>  
>  # FIXME: how do we check that -e works?
> -- 
> 1.8.3.1
> 

-- 
Failure is not an option,
It comes bundled with your Microsoft product.
