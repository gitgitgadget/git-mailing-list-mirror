From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7 4/9] gitweb: right-align date cell in shortlog
Date: Sat, 27 Jun 2009 20:28:04 +0200
Message-ID: <200906272028.05239.jnareb@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-4-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-5-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 20:29:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKcdR-0007x0-0q
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 20:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbZF0S2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 14:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbZF0S2K
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 14:28:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:23372 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbZF0S2J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 14:28:09 -0400
Received: by fg-out-1718.google.com with SMTP id e12so218897fga.17
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KceQEjhg38i4nCrIdg7xYEHoL5SXd/oyK8bFugKowY8=;
        b=dGCh/DcfpjCplEexkyRtU340FpQsOqtZX3pC0lxRrZIjQ9GIeFtey9aB9knMOkw1kX
         CtOk0fOer4y/qyS3Yj/aVp9PxmXbDrWu8gcdVCDTUwY6ilANRoQjEam4XlxbyOFJDkkB
         1DfuvnoSo2rPFHnwCfTaXiH1NU6oZj99fHDbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dKcwuHgvvsloUXi9+beqXdLD8sdai4jSdNGB3sfzaYeksHbbbR2CW0xKQQFTLjR4jZ
         2MAQCGyX+zbgJWo5JVM28Q7m9N5rP9G3T1MiRkZP4fwu7LeB+YFs/2W1Naad/sBrzaS7
         CYLo9uz1AELdKRGIowpotNiT0o2UHdyo7Twxw=
Received: by 10.86.61.2 with SMTP id j2mr191750fga.61.1246127290672;
        Sat, 27 Jun 2009 11:28:10 -0700 (PDT)
Received: from ?192.168.1.13? (abwd106.neoplus.adsl.tpnet.pl [83.8.227.106])
        by mx.google.com with ESMTPS id 4sm3137303fgg.27.2009.06.27.11.28.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 11:28:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246104305-15191-5-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122378>

On Sat, 27 June 2009, Giuseppe Bilotta wrote:

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

I don't like it.  In my opinion it is less readable that way, especially
if word wrapping gets involved:

  5 hours |
      ago |

  5 hours |
      ago |

   5 days |
      ago |

It is IMVHO a bit ugly.


That aside this is *not complete*.  Take a look at 'summary' view.  
You have there 'date' column in 'shortlog' section aligned to the right,
while in 'heads' and 'tags' section it is aligned to the left.  Add to
that "Last Change" column in projects list view (which should probably
be aligned to the left, even with this patch completed).

NAK from me.  (Alternate stylesheet?  Just kidding...)

> ---
>  gitweb/gitweb.css |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 68b22ff..ef24a1b 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -180,6 +180,10 @@ table {
>  	border-spacing: 0;
>  }
>  
> +table.shortlog td:first-child {
> +	text-align: right;
> +}
> +
>  table.diff_tree {
>  	font-family: monospace;
>  }

On the other hand: it is short and simple.

-- 
Jakub Narebski
Poland
