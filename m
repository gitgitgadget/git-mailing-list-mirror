From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 3/3] git-gui: Do not suggest a gc if gc --auto
 would not do it
Date: Thu, 18 Feb 2010 09:49:12 -0600
Message-ID: <20100218154911.GA32372@progeny.tock>
References: <20100218143431.GA30486@progeny.tock>
 <20100218144122.GC30520@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Mark Brown <broonie@sirena.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 16:49:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni8d2-0008MG-K2
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 16:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758528Ab0BRPtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 10:49:14 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:46615 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758515Ab0BRPtN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 10:49:13 -0500
Received: by gxk27 with SMTP id 27so2800464gxk.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 07:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=h61xe4sJMw1n6XEXNuvyY6mggeRvt6/uldiKx6biosI=;
        b=ZKVGh9Qg7YSJctjLTgdx41sLf7ev7X6VSG1IN8EE+okrPDGqduJnoZ/wlwrozv8GFk
         SHmy5hI0AKG8Sv+eVb8Puz56+3fyfTepx7rRtubfzsssMJWu/ccmdxP7+My+1pTJXf9g
         sjGPjtKqXiDEjY3mf4XqtXkWmbxhpSCtMGLJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Q4YTpWgv7vx2rRxqUrlUisSTL2GIbiInojGAsruCvx66f/jzM7ae5IyhzPpZUwSdbs
         LhtYAvr7b909v6KprN1ym/fQNY49khnxrs18Ka/JO4gn2Gm32N4ysvRyjiFJVYhwULgL
         5VTgpXp0SdllQjCtPxdoNdomS9fv0pBOL7pWY=
Received: by 10.101.174.12 with SMTP id b12mr3446168anp.120.1266508151953;
        Thu, 18 Feb 2010 07:49:11 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm1008994gxk.3.2010.02.18.07.49.10
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 07:49:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100218144122.GC30520@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140348>

Jonathan Nieder wrote:

> The gui-specific heuristic of assuming Windows filesystems will
> tolerate fewer loose objects has been carried over.

Er, was carried over in a previous local patch but not this one.
Sorry for the confusion.

Jonathan

>  	set ndirs 1
> -	set limit 8
> +	set limit [expr {($gc_auto_threshold + 255) / 256}]
>  	if {[is_Windows]} {
>  		set ndirs 4
> -		set limit 1
>  	}
