From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 12/23] transport.c::get_refs_via_curl(): do not leak refs_url
Date: Fri, 05 Jun 2009 13:46:48 -0700 (PDT)
Message-ID: <m3my8m5ryh.fsf@localhost.localdomain>
References: <20090606000451.262b7711.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:47:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCgJY-0007qs-7r
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 22:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbZFEUqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 16:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753138AbZFEUqw
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 16:46:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:52022 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbZFEUqu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 16:46:50 -0400
Received: by fg-out-1718.google.com with SMTP id 16so650193fgg.17
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 13:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=3bl3Z5E8xKuGHGVBK9Q/DoxFquDmnjHf8EFGgdDVmQ8=;
        b=jjGOeFix160qVF6ZRX2xEhS+itiXTDndS2kD00a4oysG4VVRb87SLfXO4NiVZBL3P4
         j0ADeqhm33VRfQEmnZytWSh0z4BubaTIEXAI2c3NksnHP1ETigE8xe5+uy8cvWXjUwsK
         RSJiNS4sBKMvNGVcdldCnMi7taipWgRgvO0lk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=LR8147lowD5W+X7T/cuPscG9vsSnK0raNcQo3jObLi+KdFR9UVT+pVpR+pV8+Di7Nu
         WvXNBmDXKcZGnCWX5nTNiYHNFkW/Hv10aKS3mHI5b2dL2gMx3BmBAT1y4iGULva8PCMu
         V2VFu2pvZSpDobviuVZZA4imE6+yr9ywKv7uU=
Received: by 10.86.59.18 with SMTP id h18mr4322838fga.71.1244234810325;
        Fri, 05 Jun 2009 13:46:50 -0700 (PDT)
Received: from localhost.localdomain (abwo21.neoplus.adsl.tpnet.pl [83.8.238.21])
        by mx.google.com with ESMTPS id 3sm850675fge.6.2009.06.05.13.46.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 13:46:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n55KklYS024615;
	Fri, 5 Jun 2009 22:46:48 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n55KkkmG024612;
	Fri, 5 Jun 2009 22:46:46 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090606000451.262b7711.rctay89@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120832>

Tay Ray Chuan <rctay89@gmail.com> writes:

> From:	Mike Hommey <mh@glandium.org>
> Subject: [WIP Patch 02/12] Some cleanup in get_refs_via_curl()

So what is the title of this patch? "transport.c::get_refs_via_curl():
do not leak refs_url" or "Some cleanup in get_refs_via_curl()"?

Perhaps it should be "transport.c: Do not leak refs_url in
get_refs_via_curl()"...?

> Date:	Sun, 18 Jan 2009 09:04:27 +0100
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  transport.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/transport.c b/transport.c
> index efecb65..9edd5aa 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -519,6 +519,7 @@ static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
>  		free(ref);
>  	}
> 
> +	free(refs_url);
>  	return refs;
>  }
> 
> --
> 1.6.3.1
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
