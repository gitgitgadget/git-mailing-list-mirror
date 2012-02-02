From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC (version A)] gitweb: use CGI with -utf8 to process Unicode query  parameters correctly
Date: Thu, 2 Feb 2012 21:11:02 +0100
Message-ID: <201202022111.03336.jnareb@gmail.com>
References: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com> <m37h05c8c1.fsf@localhost.localdomain> <201202022108.51353.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:10:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2zD-0007p9-1O
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab2BBUKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 15:10:22 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51556 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781Ab2BBUKW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 15:10:22 -0500
Received: by eekc14 with SMTP id c14so900777eek.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 12:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=ZzgF0Rjen5VjaTL8TzB1rB8Ap6MjB00zaN4gmrne/rQ=;
        b=f67cjatn/qgzciRlKiqklRGxvc0K2+nPB59T5GUJN/S5KzlT7kGN+esG8/5Aqz5i5T
         QMqRcomO1nrAxpTaYAyvpZU5N32HXK2q5woFxcQB3acdcKnoPLpEVwMGgi3BMsixABcs
         KTck1eb9215vMPc3FWE2+yIpnZUw4v8g1EmX4=
Received: by 10.14.53.74 with SMTP id f50mr1394042eec.5.1328213421187;
        Thu, 02 Feb 2012 12:10:21 -0800 (PST)
Received: from [192.168.1.13] (abwd54.neoplus.adsl.tpnet.pl. [83.8.227.54])
        by mx.google.com with ESMTPS id y12sm12848627eeb.11.2012.02.02.12.10.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 12:10:20 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201202022108.51353.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189694>

> According to "Using Unicode in a Perl CGI script" article on
> http://www.lemoda.net/cgi/perl-unicode/index.html the simplest
> solution is to just import '-utf8' pragma for CGI module:
> 
> 	use CGI '-utf8';
> 	my $value = params('input');
[...]
> ---

Except it doesn't work for me...

>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9cf7e71..a7441ef 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -10,7 +10,7 @@
>  use 5.008;
>  use strict;
>  use warnings;
> -use CGI qw(:standard :escapeHTML -nosticky);
> +use CGI qw(:standard :escapeHTML -nosticky -utf8);
>  use CGI::Util qw(unescape);
>  use CGI::Carp qw(fatalsToBrowser set_message);
>  use Encode;
> -- 
> 1.7.6
> 
> 

-- 
Jakub Narebski
Poland
