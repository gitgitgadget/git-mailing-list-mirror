From: "trajce nedev" <trajcenedev@hotmail.com>
Subject: Re: [PATCH 00/28] clean-ups of static functions and returns
Date: Mon, 14 Aug 2006 18:40:21 -0700
Message-ID: <BAY110-F2347BACD15C6BACC34E839B84F0@phx.gbl>
References: <7vsljyajxj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 03:40:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCnv1-0003lc-Ev
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 03:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWHOBkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 21:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbWHOBkZ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 21:40:25 -0400
Received: from bay0-omc2-s25.bay0.hotmail.com ([65.54.246.161]:40186 "EHLO
	bay0-omc2-s25.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S932748AbWHOBkY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 21:40:24 -0400
Received: from hotmail.com ([65.54.229.33]) by bay0-omc2-s25.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Aug 2006 18:40:23 -0700
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 14 Aug 2006 18:40:22 -0700
Received: from 65.54.229.220 by by110fd.bay110.hotmail.msn.com with HTTP;
	Tue, 15 Aug 2006 01:40:21 GMT
X-Originating-IP: [24.6.85.104]
X-Originating-Email: [trajcenedev@hotmail.com]
X-Sender: trajcenedev@hotmail.com
In-Reply-To: <7vsljyajxj.fsf@assigned-by-dhcp.cox.net>
To: junkio@cox.net
X-OriginalArrivalTime: 15 Aug 2006 01:40:22.0683 (UTC) FILETIME=[C6113EB0:01C6C00B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25434>

So you're just going to continue passing numbers around in the hope that 
someday they'll be used for something?

Trajce Nedev

>From: Junio C Hamano <junkio@cox.net>
>To: David Rientjes <rientjes@google.com>
>CC: git@vger.kernel.org
>Subject: Re: [PATCH 00/28] clean-ups of static functions and returns
>Date: Mon, 14 Aug 2006 18:04:24 -0700
>
>David Rientjes <rientjes@google.com> writes:
>
> > On Mon, 14 Aug 2006, Junio C Hamano wrote:
> >
> >> Interesting.  Did you use some automated tool to spot them?
> >>
> >
> > No, these changes are from my own personal tree that optimizes 
>everything for
> > speed since I am working with terabytes of data.  I only submitted 
>changes that
> > I thought would be beneficial for your project as well.
> >
> >>  * Making stricter error checking in the future harder.  There
> >>    are three classes, but the lines between them are fuzzy.
> >>
> >>         [PATCH 04/28] builtin-diff.c cleanup
> >>...
> >>         [PATCH 23/28] makes peek_remote void
> >>
> >>    The callers of the first group check their return values, so
> >>    we could make error checking of these functions stricter in
> >>    the future without affecting the rest of the code.  The ones
> >>    that currently die() (or usage()) could be made into more
> >>    libified form to return error codes.
> >>
> >>    So I do not think it is worth doing these.
> >
> > I disagree.  Having static functions return ints that are the
> > same for _every_ code path and are checked against upon return
> > is never good style.  It implies that error checking is
> > already done and the return value is of importance.
>
>I would agree with your above statement about the second group,
>but not the ones listed in the first group, whose callers are
>prepared to receive error returns.  It just happens that these
>callees do not currently detect errors, but some of them
>certainly could be improved to return errors, instead of just
>calling die().
>
>-
>To unsubscribe from this list: send the line "unsubscribe git" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
