From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: skip logo in atom feed when there is none
Date: Wed, 5 Jan 2011 01:25:52 +0100
Message-ID: <201101050125.52824.jnareb@gmail.com>
References: <20110104050206.GA8280@burratino> <20110104050247.GB8280@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 01:26:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaHCd-0002XR-56
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 01:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323Ab1AEA0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 19:26:05 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:55774 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab1AEA0D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 19:26:03 -0500
Received: by wwi17 with SMTP id 17so15430525wwi.1
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 16:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=e1xc+Sw0gYgtDDtX4txYwzgMpghWSKJ3WAjxIjdilI4=;
        b=N3g/Q/4MOBjfhbkgY6kibTekoSfzL7SdJfbqly4qp2K1PLAevVZ2BS3rfM3oWBW25y
         b+dQHY3OuprZJam7BhhJu9e99CkjsbbAHCjD2q42tBoJyApEJuEeUBasip1z4IxaKeIw
         26F7xasA8DXK6BlAX5T5Qg7y4zS5uzH4K2GWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kGdCSW7CTz2EkKg9gOwWryGe7ogK7OocsrOJ7RzytdaQ35XR/uqYlFWX/J9W1pDC3p
         ggekuWIDT8haL0d+cxK7w+b6a9KdAgvxPHn2NO7qP2H5yFlbXDrIiBkLcubO9D6zd0UP
         tSwHi2QWbL6xztrQ4Q9Fg23BXxdajoZ+VxV1w=
Received: by 10.227.98.158 with SMTP id q30mr6882718wbn.151.1294187161713;
        Tue, 04 Jan 2011 16:26:01 -0800 (PST)
Received: from [192.168.1.13] (abwq27.neoplus.adsl.tpnet.pl [83.8.240.27])
        by mx.google.com with ESMTPS id x3sm10878978wes.46.2011.01.04.16.25.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 16:26:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20110104050247.GB8280@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164531>

Jonathan Nieder wrote:
> Date: Fri, 3 Sep 2010 19:44:39 -0500
> 
> With v1.5.0-rc0~169 (gitweb: Fix Atom feed <logo>: it is $logo,
> not $logo_url, 2006-12-04), the logo URI to be written to Atom
> feeds was corrected but the case of no logo forgotten.
> 
> Acked-by: Eric Wong <normalperson@yhbt.net>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Good catch.  As an obvious bugfix:

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4779618..c65af1a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -7169,7 +7169,7 @@ XML
>  		if (defined $favicon) {
>  			print "<icon>" . esc_url($favicon) . "</icon>\n";
>  		}
> -		if (defined $logo_url) {
> +		if (defined $logo) {
>  			# not twice as wide as tall: 72 x 27 pixels
>  			print "<logo>" . esc_url($logo) . "</logo>\n";
>  		}
> -- 
> 1.7.4.rc0
> 
> 

-- 
Jakub Narebski
Poland
