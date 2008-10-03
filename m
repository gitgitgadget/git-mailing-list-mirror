From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: use_pathinfo filenames start with /
Date: Fri, 3 Oct 2008 13:28:33 +0200
Message-ID: <200810031328.33956.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-4-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-5-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 13:30:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klirz-0004rj-05
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 13:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbYJCL3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 07:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752939AbYJCL3S
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 07:29:18 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:30541 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbYJCL3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 07:29:14 -0400
Received: by ey-out-2122.google.com with SMTP id 6so511771eyi.37
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 04:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=oFGSyeefLPg7t9Wff9YGtbqBCqtryOr5BFqGAoFbKO0=;
        b=LGUXrL6HBcxj35+6sxttkDeTx1a0UyssjJasEOFKQ+BrhP1JTMQcuXQprejdTHywBJ
         XnYmkaKpWvpegxwnx9S5l/gVTFdg//H3jYHCahOZ03TWd6Yci8y4ybF5OxFGSa02+iO5
         RD/Yf4SIsXpoIC1q85maHWaAlNMinjaLPhCDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pZx9PbeCgwG2rVXweAxRegG+gyqdqaypEqO5LvU0qCe/E+SvCdkRh5kxGKjb0D7j8K
         xupFG4hP41jYabibZO63VvfuLKphholWsuvlyE1cca9YaSZmFo/T6hF4fuoXsPFJvbGC
         St8gNZdJE28244R8haGjfe/L/wJY7kneDnwXA=
Received: by 10.210.40.10 with SMTP id n10mr1178562ebn.9.1223033352764;
        Fri, 03 Oct 2008 04:29:12 -0700 (PDT)
Received: from ?192.168.1.11? (abvs210.neoplus.adsl.tpnet.pl [83.8.216.210])
        by mx.google.com with ESMTPS id 5sm4069380eyf.8.2008.10.03.04.29.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Oct 2008 04:29:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1222906234-8182-5-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97414>

On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:

> When using path info, make filenames start with a / (right after the :
> that separates them from the hash base). This minimal change allows
> relative navigation to work properly when viewing HTML files.

...in 'raw' mode/'blob_plain' view.

This allows to for example view web site as it was at some revision,
following relative links and checking if they are broken.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

(Note that it depends on previous patch, and without it doesn't make
sense, so this Ack doesn't matter much now!)

> ---
>  gitweb/gitweb.perl |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 2c380ac..3e5b2b7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -690,7 +690,7 @@ sub href (%) {
>  		# try to put as many parameters as possible in PATH_INFO:
>  		#   - project name
>  		#   - action
> -		#   - hash or hash_base:filename
> +		#   - hash or hash_base:/filename
>  
>  		# Strip any trailing / from $href, or we might get double
>  		# slashes when the script is the DirectoryIndex
> @@ -708,11 +708,11 @@ sub href (%) {
>  			delete $params{'action'};
>  		}
>  
> -		# Finally, we put either hash_base:file_name or hash
> +		# Finally, we put either hash_base:/file_name or hash
>  		if (defined $params{'hash_base'}) {
>  			$href .= "/".esc_url($params{'hash_base'});
>  			if (defined $params{'file_name'}) {
> -				$href .= ":".esc_url($params{'file_name'});
> +				$href .= ":/".esc_url($params{'file_name'});
>  				delete $params{'file_name'};
>  			}
>  			delete $params{'hash'};
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
