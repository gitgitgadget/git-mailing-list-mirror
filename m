From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 2/8] gitweb: uniform author info for commit and commitdiff
Date: Fri, 26 Jun 2009 01:14:43 +0200
Message-ID: <200906260114.44345.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 01:14:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJy9d-0003ax-EQ
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 01:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbZFYXOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 19:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbZFYXOm
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 19:14:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:53588 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbZFYXOm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 19:14:42 -0400
Received: by fg-out-1718.google.com with SMTP id e21so383284fga.17
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 16:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NHSBHV4DuTYTl8p1uNJU9mGDpFajkCCjwySyUwGS0ow=;
        b=WwZV0EP8eNT5WsiHdQjy34P4lto8EU5NBmoNw909xwprVru041hgd8PNnrLrBOyFm6
         skzMcCVvM6wqoVz8HWpqpTS8cLTIT5TwoWwuX5ZWqgKW3/ufbNChTccRK8mUynMmmn6s
         pPlqhs4C63UDDxZ4rw7advkgtVKYm3e+Cf2GY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hWXTRIeaUSDszpw/34nMU7iWzNoj59JPXdqureo/hw1ln9VDhSUH5F9m/WR8hAZM/H
         G08pwel5YUtrKSsdXtwgfm1pwY03CHWdJgxJKiWJCckG/cM6VS93cUANYi9fxu7+qo5x
         CDMC5GTktsOFmqAIwDuQ3xMCpWdgK1jcz9Wgw=
Received: by 10.86.59.18 with SMTP id h18mr3145295fga.14.1245971684194;
        Thu, 25 Jun 2009 16:14:44 -0700 (PDT)
Received: from ?192.168.1.13? (abwu167.neoplus.adsl.tpnet.pl [83.8.244.167])
        by mx.google.com with ESMTPS id e11sm7226644fga.1.2009.06.25.16.14.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 16:14:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122258>

On Thu, 25 June 2009, Giuseppe Bilotta wrote:

Here I would write that 'commitdiff' view moves from

  Giuseppe Bilotta [Mon, 22 Jun 2009 22:49:58 +0000 (00:49 +0200)]

to

  author      Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
              Mon, 22 Jun 2009 22:49:58 +0000 (00:49 +0200)
  committer   Jakub Narebski <jnareb@gmail.com>
              Tue, 23 Jun 2009 18:02:21 +0000 (20:02 +0200)"

(perhaps with A U Thor and C O Mitter as example names).

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9b60418..cdfd1d5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5595,7 +5595,11 @@ sub git_commitdiff {
>  		git_header_html(undef, $expires);
>  		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
>  		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
> -		git_print_authorship(\%co, 'localtime' => 1);
> +		print "<div class=\"title_text\">\n" .
> +		      "<table class=\"object_header\">\n";
> +		git_print_full_authorship(\%co);
> +		print "</table>".
> +		      "</div>\n";
>  		print "<div class=\"page_body\">\n";
>  		if (@{$co{'comment'}} > 1) {
>  			print "<div class=\"log\">\n";

Nice and short thanks to refactoring you have done in previous patch.


Very good that you put this in separate patch, so it can be evaluated
independently, and decided independently whether it is worth having more
detailed authorship information in 'commitdiff', making it more like
'commit' view, or be more like 'log' view with similar, but slightly
extended authorship information.

I personally am a bit ambivalent about this issue...

> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

-- 
Jakub Narebski
Poland
