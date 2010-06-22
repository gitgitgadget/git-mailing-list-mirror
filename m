From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH GSoC] gitweb: Add support for enabling 'write' feature
Date: Tue, 22 Jun 2010 13:12:57 +0200
Message-ID: <201006221312.57801.jnareb@gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com> <1277159424-6351-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, pasky@ucw.cz
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 13:13:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR1Pp-0005bL-Cx
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 13:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757876Ab0FVLNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 07:13:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:63213 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab0FVLNL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 07:13:11 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1294781fga.1
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZEYbJpE78hwB55owj3CvROg/shquA8o8mDuaodGlr/0=;
        b=YngGYRbbwVaz5cjNhE7WmvpyIMHKSFB0owpQRhmx2sJKQeELGT2VmDqYTX8bRL0fn6
         EfWwVl2ZefflxcwztUArO8V34GuWzp+c80kTkgHL4zjGkcgPQ2f+qTOrqUB5WqfTrlUS
         u0+0lR48WWQK7SgGgROkyggtHOyFy7NbfsY+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VEHfiYmSY8DTOFy9solp1SiKAek0+bQLjlWdmtXL1vrryVxgJSv+/F8IcFsd5+MGQ8
         L+WHkgsO/lc8SeiT+B9lMH4JwRvnN38xQ5U43UY7HR5hqWc5USakf3PkoSDSnJf8XfOL
         VQkGqNbVTLJt6C6uhwzGX48Q8m2XBdMLIUAS8=
Received: by 10.103.37.28 with SMTP id p28mr2008296muj.86.1277205189129;
        Tue, 22 Jun 2010 04:13:09 -0700 (PDT)
Received: from [192.168.1.15] (abvn56.neoplus.adsl.tpnet.pl [83.8.211.56])
        by mx.google.com with ESMTPS id j2sm7778038mue.23.2010.06.22.04.13.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jun 2010 04:13:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1277159424-6351-1-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149473>

On Tue, 22 June 2010, Pavan Kumar Sunkara wrote:

> Provide $feature{'write'} to enable the 'write'
> functionalities for gitweb. While outputting HTML
> it checks for gitweb_check_feature('write') and if
> it's enabled, proper links will appear along with
> the HTML divs.
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---
>  This patch is based on my previous patch series.
>  http://mid.gmane.org/1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com

It looks a bit like this email is send by accident...
  
>  And this is my first patch in the preparation for integration
>  of write functionality into gitweb.
> 
>  gitweb/lib/Gitweb/Config.pm |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/lib/Gitweb/Config.pm b/gitweb/lib/Gitweb/Config.pm
> index c528595..87f0ba6 100644
> --- a/gitweb/lib/Gitweb/Config.pm
> +++ b/gitweb/lib/Gitweb/Config.pm
> @@ -203,6 +203,17 @@ our %feature = (
>  	# (an array) or gitweb_check_feature(<feature>) to check if <feature>
>  	# is enabled
>  
> +	# Enable the 'write' functionalities for gitweb. While outputting HTML
> +	# it checks for gitweb_check_feature('write') and if it's enabled,
> +	# proper links will appear along with the HTML divs.
> +	
> +	# To enable system wide have in $GITWEB_CONFIG
> +	# $feature{'write'}{'default'} = [1];
> +	# Project specific override is not supported.
> +	'write' => {
> +		'override' => 0,
> +		'default' => [0]},
> +
>  	# Enable the 'blame' blob view, showing the last commit that modified
>  	# each line in the file. This can be very CPU-intensive.

...as there is nothing non-trivial in there.

-- 
Jakub Narebski
Poland
