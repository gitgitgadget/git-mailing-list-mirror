From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fix color.pager = false with "git diff"
Date: Thu, 21 Oct 2010 14:02:58 -0500
Message-ID: <20101021190258.GA11759@burratino>
References: <20101021150244.GA18426@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Benjamin Kudria <ben@kudria.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 21:09:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P90W9-0002qi-6Q
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 21:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757689Ab0JUTJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 15:09:27 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38246 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757555Ab0JUTJY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 15:09:24 -0400
Received: by gxk3 with SMTP id 3so326033gxk.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=83SNJdlAWEkbOcSsZvvhAn/gEGa5v5nwAyPr3x7JEhc=;
        b=qBJogfGotMwhnEfrSBtlPCkDm26ySYFOb3ZHnNXMiCdg1nLttRbfodCvfnOh4I/UnG
         Cre7c7/YgAjcvv1QxowqtDnEE3V3JaVDOvMkPrRPSuUrJTDPVvF3xK9d7FOv2wE/rVTl
         UZFfJ0ymzK6ggOr6C1Nf79eC0TTkMFZ8xvgC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z9y/UDlTwDLgwN4AUwUbkY9rqfgZoMGhT4Jo/CKtQyHka1ognX2D9DATFRzIw2DaS6
         2EVyQSwdrinRdKvX1b8MGxyxLm1Kft1W7/l7EfAV7pny4Tk5u+Z+OaV6839DqrjKYJQc
         JLbMZUwDBkvg55E4HvVzbbmtGv/YRGGM25uGY=
Received: by 10.103.121.20 with SMTP id y20mr2120936mum.5.1287688004867;
        Thu, 21 Oct 2010 12:06:44 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 2sm1017898faz.14.2010.10.21.12.06.43
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 12:06:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101021150244.GA18426@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159542>

[reordered for convenience]
Jeff King wrote:

> In favor of this patch:
>
>   1. It fixes a real bug.
>
>   2. Perfect is the enemy of the good, and I don't care enough about
>      this case to refactor the color code.
>
> Against:
>
>   1. It does nothing to fix other times when this ordering problem may
>      arise (I don't think there are others, but I didn't check very
>      thoroughly. And of course new ones may appear).
>
>   2. The bug was reported over 2 years ago, and hasn't come up since,
>      despite remaining unfixed.  Maybe nobody actually cares.

I'd say, go for it.  At least one person (Benjamin Kudria, cc-ed) cared
at some point.  And including the code means that maybe some future hero
refactoring "git diff" will notice and implement the proper solution.

Though to that end, wouldn't it make sense to include

>                                                         A more elegant
> solution would be totally rewriting the color code to check for the
> pager at first output.

in the commit message?
