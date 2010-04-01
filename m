From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 1/6] Gitweb: add ignore and clean rules for minified files
Date: Thu, 1 Apr 2010 10:24:48 +0200
Message-ID: <201004011024.50615.jnareb@gmail.com>
References: <4BB430A0.7040700@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Apr 01 10:25:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxFiP-0005cL-1u
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 10:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab0DAIZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 04:25:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:54175 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab0DAIZF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 04:25:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so710067fgg.1
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 01:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=U3i8OwTa/q3JrAuiONR9k1q6wlIKVz+BoHmX1vmpGJQ=;
        b=W2tb/iDqv3ecY1YcZz1ktIgmYlYwmCdgNBDpIGWUmtTif8fu6W+r4tunkUVRn/vEkz
         djj7LFKCCquU3559CvBO2Tm24P1QgqpqtYfqOaztk9ikSWIMT77UdxWKzS/VtOQ9xU9i
         eVTBBcCNJ76cBytjWiba9qZXQ4nxu5sszE4FE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kF84qC5XULgrdi4T+buZRYwpS8OBURGohSCJsOaVOuZEMoFbn8TfPSQTm8yut+Kdae
         ECp3Rc5+ZfZWtpnTs9qEg5qNke/28o+rOijs3X15i0RG7vSbxZ4pDpLHL6rb0ElBp+T/
         Qe3IEe8rFKpyubCow6jTXjewyhfdDXuoAug5k=
Received: by 10.86.221.34 with SMTP id t34mr1578398fgg.36.1270110302926;
        Thu, 01 Apr 2010 01:25:02 -0700 (PDT)
Received: from [192.168.1.13] (abws156.neoplus.adsl.tpnet.pl [83.8.242.156])
        by mx.google.com with ESMTPS id 21sm17247203fks.23.2010.04.01.01.25.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Apr 2010 01:25:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BB430A0.7040700@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143722>

On Thu, 1 April 2010, Mark Rada wrote:

> Signed-off-by: Mark Rada <marada@uwaterloo.ca>

For what it's worth:
Acked-by: Jakub Narebski <jnareb@gmail.com> 

> diff --git a/Makefile b/Makefile
> index 6d73a8c..5384d33 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2089,7 +2089,7 @@ clean:
>  	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
>  	$(MAKE) -C Documentation/ clean
>  ifndef NO_PERL
> -	$(RM) gitweb/gitweb.cgi
> +	$(RM) gitweb/gitweb.{cgi,min.*}
>  	$(MAKE) -C perl clean
>  endif

Minor nit: this would be first line that uses {a,b} shell glob 
construct.  Why not write it as:

  -	$(RM) gitweb/gitweb.cgi
  +	$(RM) gitweb/gitweb.cgi gitweb/gitweb.min.*

-- 
Jakub Narebski
Poland
