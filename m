From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Document LF appearing in shallow command during
 send-pack/receive-pack
Date: Wed, 27 Aug 2014 15:10:17 -0700
Message-ID: <20140827221017.GY20185@google.com>
References: <1409172416-10750-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:10:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMlQD-0003ZP-Tj
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 00:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935884AbaH0WKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 18:10:23 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:59178 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbaH0WKV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 18:10:21 -0400
Received: by mail-ie0-f171.google.com with SMTP id rp18so108651iec.2
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Z9ATFFuTHI9CqZlYe/2HT6GzTPPYqvEPUUzIo0a4+Kk=;
        b=T10iqJQ/Hz8a5XSP94v63ofSctf5hfe8r1fcqoK6OX2+n68IYmB6wlpyoH7nVxY1zA
         yIBvexMW6U8xcEPAdtdvlouB5BgKq3Y9p/hzxsIkdCxi6QOsu5sKiwEfajVcuPE8643z
         eZ1BSdNhWJ/0dzPOHgbmJRPkIY03vE3GWgwCdIHQ6wbH4cEL86P5/bvdIWLnnnTuSnLK
         fa/wft5V9fXVXgz5Pc3PcBDLYRQuM+647BOZ6bGw66V+k0evlZT1vdypwFoPlnVkOe4Y
         7ycRQvarijag3DG4XF9n2fe1dp4rhEMHUGwUsAzUyJBrmNsMe/KzlRUN8wbSipWSyJTK
         GCWg==
X-Received: by 10.66.139.106 with SMTP id qx10mr32363920pab.126.1409177420820;
        Wed, 27 Aug 2014 15:10:20 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id g7sm2326477pdj.7.2014.08.27.15.10.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Aug 2014 15:10:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1409172416-10750-1-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256052>

Shawn Pearce wrote:

> The implementation sends an LF, but the protocol documentation was
> missing this detail.
>
> Signed-off-by: Shawn Pearce <spearce@spearce.org>
> ---
>  Documentation/technical/pack-protocol.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index 18dea8d..569c48a 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -467,7 +467,7 @@ references.
>  ----
>    update-request    =  *shallow command-list [pack-file]
>  
> -  shallow           =  PKT-LINE("shallow" SP obj-id)
> +  shallow           =  PKT-LINE("shallow" SP obj-id LF)

In git, the client sends LF and the server is happy with or
without LF.  JGit and libgit2 don't send 'shallow' lines.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

>  
>    command-list      =  PKT-LINE(command NUL capability-list LF)
>  		       *PKT-LINE(command LF)
> -- 
