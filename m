From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/4] make filepairs detachable
Date: Fri, 30 Jun 2006 10:21:15 +0200
Message-ID: <81b0412b0606300121q4148dfb0qb5915bd029d72f44@mail.gmail.com>
References: <20060630002736.GB22618@steel.home>
	 <7vy7vfmoit.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0606300042r24931d9i5fad0e849b8de84c@mail.gmail.com>
	 <7v7j2zkrod.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 10:21:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwEFf-0004Jo-C4
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 10:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWF3IVT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 04:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWF3IVS
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 04:21:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:32531 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751473AbWF3IVR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 04:21:17 -0400
Received: by ug-out-1314.google.com with SMTP id m3so703392ugc
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 01:21:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W8wpSnAGDiD/dFWOe1GtzgPPUElGWCWVNj9xX6y1WEs8zyOPeDp7bvbdp0msJ2AVJU+ALaV5Aw28P0JXTha4lomEo3mc4frTIXnZgJ8EJPnxqWCKmnRUmQFs7q0pUgfLkuBEcXNknvTalqMZWxVpkH2Fy+CXo6L8925czarUKuQ=
Received: by 10.78.139.5 with SMTP id m5mr1545212hud;
        Fri, 30 Jun 2006 01:21:15 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Fri, 30 Jun 2006 01:21:15 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v7j2zkrod.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22971>

On 6/30/06, Junio C Hamano <junkio@cox.net> wrote:
>
> > BTW, is there any chance we get the struct diff_filepair's
> > double-linked? They don't seem to be sorted. Will increase
> > the memory footprint, though.
>
> You do not necessarily have to do things in place.  In fact, all
> of the standard diffcore transformers create a new queue, read
> from the old queue and place the filtered or munged result in
> the new queue, swap the global queued_diff variable to point at
> the new one and discard the old queue.
>
> See diff.c::diffcore_apply_filter() for the simplest example.
>

I see. Looks dangerous outside of diff.c though.
