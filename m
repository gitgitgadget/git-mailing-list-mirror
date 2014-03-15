From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test-lib.sh: use printf instead of echo
Date: Fri, 14 Mar 2014 17:18:55 -0700
Message-ID: <20140315001855.GK15625@google.com>
References: <20140314235735.GA6959@ibr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Uwe Storbeck <uwe@ibr.ch>
X-From: git-owner@vger.kernel.org Sat Mar 15 01:19:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOcJb-0000VZ-MX
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 01:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136AbaCOAS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 20:18:59 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:64780 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbaCOAS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 20:18:58 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so3294871pab.34
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 17:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SGvwByShw11FmTsOyeIPS2DTWF3vpu1cbGQ+kEPf8YA=;
        b=0RKN+lC3XWb3vIfjvrR4lXLZ1uYpXJqKt182H5FJ4mLrl5DVbXtnEwEciRgOVKLq44
         Qh2RALWIixbSeGMzyGfVHMFpYW8yqYg/4NJ21mnfNWwaQG2u3ZGYGookt77HJ1X8rHJv
         +hp4GKCv6wVbwBfaqQ7QyF3fo6xlsh6gkRA6xvw57s2mwpH4yvKB00sykjiakKdyuffC
         IbpDcsRLPxsmHyAxuNB5kQwx2wRhPpUexIsUejsKnlMopX6APSX2fnr+qJCGhE5jW6LS
         J6XIdtbMadXItKjvZjuoHvKeWzgZbAdr1vhVG+xiR8Uda1QKbqrnvlcb1v6NqDV1XqD0
         JZmQ==
X-Received: by 10.66.221.199 with SMTP id qg7mr12066473pac.88.1394842738084;
        Fri, 14 Mar 2014 17:18:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ei4sm20384117pbb.42.2014.03.14.17.18.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Mar 2014 17:18:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140314235735.GA6959@ibr.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244129>

Uwe Storbeck wrote:

> Backslash sequences are interpreted as control characters
> by the echo command of some shells (e.g. dash).

This has bothered me for a while but never enough to do anything about
it.  Thanks for fixing it.

> Signed-off-by: Uwe Storbeck <uwe@ibr.ch>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

(patch left unsnipped for reference)
> ---
>  t/test-lib.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1531c24..8209204 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -277,7 +277,7 @@ error "Test script did not set test_description."
>  
>  if test "$help" = "t"
>  then
> -	echo "$test_description"
> +	printf '%s\n' "$test_description"
>  	exit 0
>  fi
>  
> @@ -328,7 +328,7 @@ test_failure_ () {
>  	test_failure=$(($test_failure + 1))
>  	say_color error "not ok $test_count - $1"
>  	shift
> -	echo "$@" | sed -e 's/^/#	/'
> +	printf '%s\n' "$@" | sed -e 's/^/#	/'
>  	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
>  }
>  
