From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 13/29] Check that "guilt header '.*'" fails.
Date: Thu, 15 May 2014 18:47:49 -0400
Message-ID: <20140515224749.GB1334@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-14-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri May 16 00:47:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4RF-0003uS-Kl
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 00:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbaEOWrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 18:47:42 -0400
Received: from josefsipek.net ([64.9.206.49]:1710 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629AbaEOWrl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 18:47:41 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 26B4755654;
	Thu, 15 May 2014 18:47:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-14-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249215>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Tue, May 13, 2014 at 10:30:49PM +0200, Per Cederqvist wrote:
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/t-028.out | 7 +++++++
>  regression/t-028.sh  | 4 ++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/regression/t-028.out b/regression/t-028.out
> index 1564c09..ea72a3a 100644
> --- a/regression/t-028.out
> +++ b/regression/t-028.out
> @@ -49,3 +49,10 @@ Signed-off-by: Commiter Name <commiter@email>
>  
>  % guilt header non-existant
>  Patch non-existant is not in the series
> +% guilt header .*
> +.* does not uniquely identify a patch. Did you mean any of these?
> +  modify
> +  add
> +  remove
> +  mode
> +  patch-with-some-desc
> diff --git a/regression/t-028.sh b/regression/t-028.sh
> index 88e9adb..2ce0378 100755
> --- a/regression/t-028.sh
> +++ b/regression/t-028.sh
> @@ -31,4 +31,8 @@ done
>  
>  shouldfail guilt header non-existant
>  
> +# This is an evil variant of a non-existant patch.  However, this
> +# patch name is a regexp that just happens to match an existing patch.
> +shouldfail guilt header '.*'
> +
>  # FIXME: how do we check that -e works?
> -- 
> 1.8.3.1
> 

-- 
Si hoc legere scis nimium eruditionis habes.
