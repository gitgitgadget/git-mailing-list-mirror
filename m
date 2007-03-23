From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: [PATCH] git-apply: Do not free the wrong buffer when we convert the data for writeout
Date: Fri, 23 Mar 2007 09:55:22 +0600
Message-ID: <200703230955.22801.litvinov2004@gmail.com>
References: <200702281036.30539.litvinov2004@gmail.com> <7virctt3yi.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703221355110.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 23 04:55:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUasX-0005B0-Oh
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 04:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671AbXCWDzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 22 Mar 2007 23:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422675AbXCWDzc
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 23:55:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:46827 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422671AbXCWDzb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2007 23:55:31 -0400
Received: by ug-out-1314.google.com with SMTP id 44so896976uga
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 20:55:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KcCa4yUkrJUjZqM8Eqks2vU5sjW5eZqFcl+yYMfxwaOHU1X8q9NzKTtO4FbE6yUq7MNA+3PtwiPlZw7bMnZzPjwtCGKfkRKX1/AYfpq3Xl8R9JwQZ/JZE5rWnPzHEaizOSRBZH8SMuSw+gwiDntlQanvpbnGmeK9M1yEuhdvhDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YATv2FYIdMTnZxPccKZI2QGANGybmmaYzZDiWZo9sbBJuHsLid1r/h2E8kV6lb574xBofXz1A03gIH4OA/JGJ5OadZoBCWiDbD7d3z8+CY2xoemLwnLdjfbGykWEUzT77VFvvuqVOU4r9sC2D+q8JpPfXhkQvbLXtVCcE1rjZuo=
Received: by 10.67.19.17 with SMTP id w17mr6032296ugi.1174622130586;
        Thu, 22 Mar 2007 20:55:30 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id j3sm3069345ugd.2007.03.22.20.55.28;
        Thu, 22 Mar 2007 20:55:29 -0700 (PDT)
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.64.0703221355110.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42901>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Friday 23 March 2007 02:55 Linus Torvalds =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BB(a):
> On Thu, 22 Mar 2007, Junio C Hamano wrote:
> > This patch also moves the call to open() up in the function, as
> > the caller expects us to fail cheaply if leading directories
> > need to be created (and then the caller creates them and calls
> > us again).  For that calling pattern, attempting conversion
> > before opening the file adds unnecessary overhead.

I have applied this patch ontop of next (d06644b) and it also fix by re=
po=20
breakage.=20

Thanks for help !
Alexander Litvinov.
