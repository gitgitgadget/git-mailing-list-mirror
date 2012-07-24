From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 5/7] i18n: am: mark more strings for translation
Date: Tue, 24 Jul 2012 13:16:00 -0500
Message-ID: <20120724181600.GH2939@burratino>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <d3711733085d683d9a63cff6f615ef3114f2d3c0.1343112786.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 20:17:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stjei-0006tK-4Z
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 20:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501Ab2GXSQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 14:16:20 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:55146 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932590Ab2GXSQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 14:16:05 -0400
Received: by gglu4 with SMTP id u4so6984921ggl.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RUR5pWYg677JMT+aPRL20M1aUQ0hVj9mGMsxY4tnu0o=;
        b=GOzLMtIkXoIFbOKSjRAMq84x3wX/hfOlMhODRXx3T0qYqtmulJBzl3200y0Np/XGCO
         Uo115fSVAfRmbF4H5bqC5lAPO6li4WOlYZlBlm0zGCz//wchlBlAQdNbWufG12NhZg31
         1dyd631OqX6NUyeq7qn+EFpy1y/Hmn1xUJvh23+WTJ0g5YUd3CyyUnNLAz6bEx+65Eph
         FvUbYIvFU+2CAjJp6ScZjCaiMn3GF39jcqOzBaRkO+pZawx5AibB4e4vkEV55HJdvXl/
         ny3704Zu4Ec6h0LnznMgVUmMGAsdwjw7mcrBmOq95My+dHuDmo9kNCY2e3sBhvq/kw37
         1Y4A==
Received: by 10.42.19.2 with SMTP id z2mr11164442ica.33.1343153764729;
        Tue, 24 Jul 2012 11:16:04 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id ch4sm2575408igb.2.2012.07.24.11.16.03
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 11:16:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d3711733085d683d9a63cff6f615ef3114f2d3c0.1343112786.git.worldhello.net@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202050>

Hi,

Jiang Xin wrote:

> Mark additional 3 strings for translation, and reduce one indentation
> level for one gettextln clause introduced in commit de88c1c.

The above description doesn't mention:

[...]
> @@ -387,8 +386,8 @@ do
>  	-i|--interactive)
>  		interactive=t ;;
>  	-b|--binary)
> -		echo >&2 "The $1 option has been a no-op for long time, and"
> -		echo >&2 "it will be removed. Please do not use it anymore."
> +		echo >&2 $(gettext "The -b option has been a no-op for long time, and
> +it will be removed. Please do not use it anymore.")

... that this changes the message when the --binary option is passed.
Before this patch, it says

	The --binary option has been a no-op for a long time, and ...

After the patch, it says

	The -b option has been a no-op for a long time, and ...

Intentional?  That may be a good change or a bad one (I haven't
thought clearly about it), but it seems at least worth mentioning.
Cc-ing Thomas in case he has advice.

Thanks,
Jonathan
