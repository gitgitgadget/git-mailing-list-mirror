From: "Dan Nicholson" <dbn.lists@gmail.com>
Subject: Re: quick bare clones taking longer?
Date: Thu, 10 May 2007 15:08:01 -0700
Message-ID: <91705d080705101508y26eabb37oaf90aa4d9a7e239a@mail.gmail.com>
References: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
	 <20070509.150256.59469756.davem@davemloft.net>
	 <7v3b25siwk.fsf@assigned-by-dhcp.cox.net>
	 <20070509.162301.48802460.davem@davemloft.net>
	 <7vy7jxr35a.fsf@assigned-by-dhcp.cox.net>
	 <7vd519r10c.fsf@assigned-by-dhcp.cox.net>
	 <vpqtzul3xzm.fsf@bauges.imag.fr> <4642DE52.F9F0A5B2@eudaptics.com>
	 <loom.20070510T224750-851@post.gmane.org>
	 <7vbqgsibrr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 11 00:08:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmGoN-0005Sc-Gs
	for gcvg-git@gmane.org; Fri, 11 May 2007 00:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762620AbXEJWIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 18:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758901AbXEJWIF
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 18:08:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:45769 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762620AbXEJWID (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 18:08:03 -0400
Received: by ug-out-1314.google.com with SMTP id 44so697361uga
        for <git@vger.kernel.org>; Thu, 10 May 2007 15:08:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CJ9/lASnIjNi+X025EQvFI161lxEz6nHOcvVErXyVCWk2vzh87AKKvC8+aptTJaXANQtyMIx/729Ab390MTw61lR403Ln8zOVcLyF3E9+kxWH/g3mW18fzr2b9JUYXiX7peaM9YmNfTclWgI+HXySE9HaDa4yi7UUAJ978F9QQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mROaiVH9laxQl0G4IeYNit6fYNnSzMX5TTmmVFzjsna07TrMUWFhnhzzTis6LkzoK/ELf84lVoajy9R+ycZqjkexsB+QLA7Om0dM3zrbnTYKZzbhVD7o80l4CoSkLll4YTXfTgXOMBzIQHmhV6DqOXL0i+OEdPaCs21VvffnKe0=
Received: by 10.82.145.7 with SMTP id s7mr3995452bud.1178834881317;
        Thu, 10 May 2007 15:08:01 -0700 (PDT)
Received: by 10.82.104.16 with HTTP; Thu, 10 May 2007 15:08:01 -0700 (PDT)
In-Reply-To: <7vbqgsibrr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46909>

On 5/10/07, Junio C Hamano <junkio@cox.net> wrote:
> Dan Nicholson <dbn.lists@gmail.com> writes:
>
> > In fact, all POSIX shells should support `cd -P' according to the spec, so it
> > should probably just be used directly instead of hoping that /bin/pwd exists.
> >
> > (cd -P "$1" && (cd .git ; pwd)) 2>/dev/null
> >
> > http://www.opengroup.org/onlinepubs/009695399/utilities/cd.html
>
> Yes but no ;-).  I've said this a few times on the list in the
> past, but I'll repeat it again for new people.
>
> We reject something whose portability in question by saying
> "It's not _even in_ POSIX".  We on the other hand try to refrain
> from saying "POSIX says you are supposed to have it, so screw
> people that are not fully POSIX".

Yes, I suppose. At the same time, git already implicitly requires more
than, say, a Bourne shell. Functions, $( ) command substitution, ${}
parameter expansion, $(( )) arithmetic expansion, etc. These are all
standard in a POSIX shell, but may or may not exist in other shell
variants.

--
Dan
