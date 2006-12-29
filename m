From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: read-for-fill and caching in gitweb (Re: kernel.org mirroring)
Date: Sat, 30 Dec 2006 00:46:15 +1300
Message-ID: <46a038f90612290346n35386e14g922465d66beaf5ab@mail.gmail.com>
References: <46a038f90612281245s52bdd868h8c421951c7abeb84@mail.gmail.com>
	 <20061229032126.GE6558@localhost>
	 <200612291140.46909.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Robert Fitzsimons" <robfitz@273k.net>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Jeff Garzik" <jeff@garzik.org>, "H. Peter Anvin" <hpa@zytor.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 29 12:46:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0GC1-0004zY-SJ
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 12:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbWL2LqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 06:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbWL2LqQ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 06:46:16 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:1597 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbWL2LqP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 06:46:15 -0500
Received: by wx-out-0506.google.com with SMTP id h27so4895749wxd
        for <git@vger.kernel.org>; Fri, 29 Dec 2006 03:46:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Roy2GBCl9mSNEQzox4rg0j7W1WjJiUHN6QmeGmuWKm5j8NaLL2bDRVTvvy5U5YA4AU9kRWF6I6c2rX5VFN2SN29HNhrXCtIw/vHib1+DAe0Or4YzwiiXvM6OcXxd+6X9OnNZCASHwNk/sNaoHoAshXmEWozhTJ2lIy0UyMaMt3A=
Received: by 10.90.78.9 with SMTP id a9mr12496432agb.1167392775324;
        Fri, 29 Dec 2006 03:46:15 -0800 (PST)
Received: by 10.90.28.1 with HTTP; Fri, 29 Dec 2006 03:46:15 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200612291140.46909.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35588>

On 12/29/06, Jakub Narebski <jnareb@gmail.com> wrote:
> It is simply the case that new features cost more. Namely in earlier
> versions of gitweb Last Change time was taken from HEAD (from current
> branch), in newer we check all branches (using git-for-each-ref).
> For published public repository it migh make sense to pack also heads
> (make them packed refs).

I haven't been using packed refs at all, but it sounds like it's a
single file. So we can stat just that file rather than ask questions
about the heads themselves. That makes checking for if-modified-since
cheap as well.

> I was thinking about making this a gitweb %feature, allowing gitweb
> administrator to chose if Last Change is taken from all branches
> (as it is now), from HEAD (as it was before), or from given branch
> (for example master).

I think the natural thing is to check all heads (doing it on the cheap
on packed-refs repos) and provide tuning tips. in this case "use
packed refs" which I guess will become the default eventually.

cheers,


martin
