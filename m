From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [RFH] shifting xdiff hunks?
Date: Wed, 12 Apr 2006 23:52:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604122348010.7104@alien.or.mcafeemobile.com>
References: <7vmzeqyolw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 08:52:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTvh6-0001Rz-77
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 08:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWDMGwj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 02:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWDMGwj
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 02:52:39 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:17333 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S964800AbWDMGwj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 02:52:39 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C9CA9> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Wed, 12 Apr 2006 23:52:34 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzeqyolw.fsf@assigned-by-dhcp.cox.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18652>

On Wed, 12 Apr 2006, Junio C Hamano wrote:

> The first hunk begins by an addition of a couple of non-blank
> line followed by an addition of a blank line.  The second hunk,
> while it does the same thing, is shown differently.
>
> Now, from correctness point of view, this is not a problem at
> all, but I am wondering if xdiff can help to always shift the
> hunk down or up to consistently produce one way or another
> (personally I feel the former is easier to read).

Next on your screens, Junio and Linus in the new commedy "Pickier and Pickiest" :)



> Here is a rough sketch of what I think I want.  When we have
> additions, as long as the first line added happens to match the
> first line that is common between the versions that comes after
> the added hunk (that is, in the case of the second hunk above,
> the empty line before "gitlink:git-rm[1]" happens to match the
> empty line after the added three lines), roll the hunk down by
> one, until you cannot roll it down anymore.
>
> Just in case I get misinterpreted, I am not talking about
> treating empty lines in any special way.  It is more about
> "starting the hunk with actually changed line".  The first hunk
> above clearly begins with something added, while the second one
> does not.
>
> Is this something easy to do with the xdiff code?

Yes, this is what GNU diff does. It's a post-process of the edit script. 
Not a problem at all. Till this weekend (included) I'm pretty booked, but 
I'll do that in the following days.



- Davide
