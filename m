From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 6/8] gitweb: add 'alt' to avatar images
Date: Sat, 27 Jun 2009 01:39:54 +0200
Message-ID: <200906270139.55006.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-6-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-7-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 01:40:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKL1Z-0005Rp-Bw
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 01:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbZFZXjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 19:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbZFZXjy
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 19:39:54 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:42952 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbZFZXjx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 19:39:53 -0400
Received: by fxm18 with SMTP id 18so282fxm.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 16:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PO6I1UnY6TFv05FchnNk83BNED6EXoEzUcmxMerNq9s=;
        b=a0hk7CI4tJEI1gEoJb96mLYEiP1zo+7wYffYdUPxhD2XQ60ohpE4+bvpftIFBW+P5k
         vFRao4ONMfxLjUaqWSzIrE3Y5g2xJ8D0vRkrYzPu6nMPyrzL4Xk/edY3zpNech5y837q
         77YjnQhKHxapDKiYCKGcBU0SjKWOGBUwpab6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=eRCxnF7dQ3rYg1Nh/LcyZus716HvxRRyzXKXDwsRNyaSNQGrIGQ6SrJ5jL8dNnKSJd
         1oxbQbkl1ytn6ceZ3EtdqvBI0YdcOSQg57qqbjFYZ10fli4YBP/WZBBRP34rq7upNoQv
         Pkcsm18IfOL+X7FvLxDcFipT1TVs+nE0QjBuw=
Received: by 10.103.131.18 with SMTP id i18mr2616201mun.107.1246059594875;
        Fri, 26 Jun 2009 16:39:54 -0700 (PDT)
Received: from ?192.168.1.13? (abwa104.neoplus.adsl.tpnet.pl [83.8.224.104])
        by mx.google.com with ESMTPS id 12sm19241889muq.23.2009.06.26.16.39.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 16:39:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245926587-25074-7-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122336>

On Thu, 25 June 2009, Giuseppe Bilotta wrote:

> Without it, text-only browsers display the URL of the avatar, which can
> be long and not very informative. 

Actually different text-only web browsers behave differently (with
default settings).

Before this patch:
 * lynx show basename of the URL of the avatar, which ain't pretty
   [avatar.php?gravatar_id=955680802bc3d50476786bb3ca9cfc52&amp;size=16]
 * elinks doesn't show by default images at all, which means that only
   &nbsp; used for padding will be visible (don't use &nbsp;?)
 * w3m show basename of avatar URL without extension nor query string:
   [avatar]

After this patch:
 * lynx   show alt text, i.e. 'gravatar' (no [] to mark as image)
 * elinks show alt text, i.e. 'gravatar' (no [] to mark as image)
 * w3m show alt text, i.e. gravatar, in separate color (also no [])

Lynx Version 2.8.5rel.1
ELinks 0.10.3
w3m version w3m/0.5.1+cvs-1.946

> We use the avatar provider name for the alt text.

I am not sure if 'type of avatar' wouldn't be easier to understand than
'avatar provider name'.  OTOH the latter is more correct.  Perhaps
"We use the avatar provider (type of avatar) for the alt text"?
But that is just nitpicking...

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d3bc849..3e6786b 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3294,7 +3294,7 @@ sub git_get_avatar {
>  	# as needed. If no variant puts something in $url, we assume avatars
>  	# are completely disabled/unavailable.
>  	if ($url) {
> -		return $pre_white . "<img class=\"avatar\" src=\"$url\" />" . $post_white;
> +		return $pre_white . "<img class=\"avatar\" src=\"$url\" alt=\"$git_avatar\" />" . $post_white;
>  	} else {
>  		return "";
>  	}

Nice, simple improvement.

> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

-- 
Jakub Narebski
Poland
