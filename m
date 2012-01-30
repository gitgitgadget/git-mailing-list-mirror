From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/5] gitweb: limit links to alternate forms of project_list to active project_filter
Date: Mon, 30 Jan 2012 17:09:51 +0100
Message-ID: <201201301710.04406.jnareb@gmail.com>
References: <20120128165606.GA6770@server.brlink.eu> <20120130095252.GA6183@server.brlink.eu> <20120130114706.GC9267@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Mon Jan 30 17:10:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrtom-0006OG-04
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 17:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124Ab2A3QKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 11:10:21 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33316 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab2A3QKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 11:10:17 -0500
Received: by eaal13 with SMTP id l13so1167978eaa.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 08:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=NSVddDp6gM08pjC810PSVcXlZZDYpYEUn3PpNggEau0=;
        b=SW2tDWKO3xBaUtse8YDFqbkTiopnb43deQu42zX+zQdRFZA6ssnUCuC+1V57lpQ7q/
         sBu50tWs1NybrnWVMwOFhHYYwaH0q/73j8uJhBZxZTP79VjHzpTUuMDq0hrz+5dTNc2o
         mTFRom4wzFY/dWmlL7Uu+8/CxuhZA8tx1bEEU=
Received: by 10.213.34.203 with SMTP id m11mr2994453ebd.40.1327939816451;
        Mon, 30 Jan 2012 08:10:16 -0800 (PST)
Received: from [192.168.1.13] (abwi152.neoplus.adsl.tpnet.pl. [83.8.232.152])
        by mx.google.com with ESMTPS id n17sm74212278eei.3.2012.01.30.08.10.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 08:10:16 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120130114706.GC9267@server.brlink.eu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189371>

On Mon, 30 Jan 2012, Bernhard R. Link wrote:

> If project_list action is given a project_filter argument, pass that to
> TXT and OPML formats.

Nice.

This way [OPML] and [TXT] links provide the same list of projects as
the projects_list page they are linked from.

> Signed-off-by: Bernhard R. Link <brlink@debian.org>
> ---
>  gitweb/gitweb.perl |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 36efc10..e022e11 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3976,9 +3976,11 @@ sub git_footer_html {
>  		}
>  
>  	} else {
> -		print $cgi->a({-href => href(project=>undef, action=>"opml"),
> +		print $cgi->a({-href => href(project=>undef, action=>"opml",
> +		                             project_filter => $project_filter),
>  		              -class => $feed_class}, "OPML") . " ";
> -		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
> +		print $cgi->a({-href => href(project=>undef, action=>"project_index",
> +		                             project_filter => $project_filter),
>  		              -class => $feed_class}, "TXT") . "\n";
>  	}

Nicely short.

-- 
Jakub Narebski
Poland
