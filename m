From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/6] gitweb: remove PATH_INFO from $my_url and $my_uri
Date: Mon, 29 Sep 2008 10:33:33 +0200
Message-ID: <200809291033.34588.jnareb@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com> <1222030663-22540-5-git-send-email-giuseppe.bilotta@gmail.com> <1222030663-22540-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	"Shawn O. Pearce (interim Git maintainer)" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 10:34:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkEDT-0006OA-R4
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 10:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbYI2Idl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 04:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbYI2Idl
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 04:33:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:34433 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbYI2Idk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 04:33:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1354817fgg.17
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=swFrphvrTMME/e+ijOrOV08PfqhnDfmO9vsvTcDNQXc=;
        b=xsOqQ1AaNn8loLnuXS+kYz+VL2pygZnSgiJ+FSgJ9UIP8lpYv/3JGwyofisrmqB0dC
         /+5S+cUf//ix7lfvJCudTMXPWhDbJyBOObhLHkCPpwwTU71ITEhtb4VVvtuRHGeN1UrW
         3n0aJrTEy9yzoLbo0UnX7slFRH3h5o0MShOwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IPEWflx5OCAtda0UMEjYh7We3A9gT7VTab8J36O09HfaCRd4msC1iPUdKITg5TVHb5
         7elZeDqUogLIRr2Uw/5+rBxsiZ9Igyf7hASQCHDp2GwoKD3PEq/Vm1cfL/RPWNYJ5QeH
         DK8jDX8/ewRD7dUX7J8tzzcKK8g72pWT0OzEk=
Received: by 10.86.98.14 with SMTP id v14mr3941415fgb.74.1222677219586;
        Mon, 29 Sep 2008 01:33:39 -0700 (PDT)
Received: from ?192.168.1.11? (abvx193.neoplus.adsl.tpnet.pl [83.8.221.193])
        by mx.google.com with ESMTPS id l19sm2766534fgb.7.2008.09.29.01.33.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Sep 2008 01:33:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1222030663-22540-6-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97001>

On Sun, 21 Sep 2008, Giuseppe Bilotta wrote:

> This patch (combined with appropriate server configuration) allows usage
> of the gitweb CGI script as DirectoryIndex for the server root even when
> the pathinfo feature is enabled.
>

This is IMHO a bugfix for a path_info handling bug, for which there
was an ugly workaround of specifying base URL ($my_url and $my_uri)
explicitly in gitweb configuration (GITWEB_CONFIG).

Therefore I think that this patch should have been sent outside of
the rest of "new path_info features" series, as a separate single
patch, and now that it is there it really should be applied, perhaps
even to the 'maint' branch.

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>
(for what is worth)

> ---
>  gitweb/gitweb.perl |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0dd2526..4a91d07 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -26,6 +26,10 @@ our $cgi = new CGI;
>  our $version = "++GIT_VERSION++";
>  our $my_url = $cgi->url();
>  our $my_uri = $cgi->url(-absolute => 1);

Perhaps some comment here?

> +if (my $path_info = $ENV{"PATH_INFO"}) {
> +	$my_url =~ s,$path_info$,,;
> +	$my_uri =~ s,$path_info$,,;

+	$my_url =~ s,\Q$path_info\E$,,;
+	$my_uri =~ s,\Q$path_info\E$,,;

Just in case.

> +}
>  
>  # core git executable to use
>  # this can just be "git" if your webserver has a sensible PATH

I was wondering if $path_info should be global variable, but then
I checked that $path_info is local to evaluate_path_info() subroutine.
So it is good as it is now, but with quoting regular expression
metacharacters.

-- 
Jakub Narebski
Poland
