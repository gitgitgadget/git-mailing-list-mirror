From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Wed, 21 Jun 2006 09:17:56 +1200
Message-ID: <46a038f90606201417k71c4c43ak59204774bcfe8246@mail.gmail.com>
References: <e79921$u0e$1@sea.gmane.org>
	 <46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com>
	 <e79jtd$51j$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 23:18:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsnbs-0003IM-CM
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 23:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWFTVR7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 17:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWFTVR7
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 17:17:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:29576 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751108AbWFTVR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 17:17:58 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2481623ugf
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 14:17:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rNFcnWR34OFDPegLpLXWdkQQq4Q7hCXtRYD3D97KECMh4VgWdLrG4sZNl4CMryjju0Oo9kCmZ+NXbGtYeDh7zjBQoBnqXGru0KGI52FHbKXyh+PqhxX14/Gr++kpT/OhFoxBBXotL4zDUCVZnE00Sgy7Z3ea8ggdXJ5Gf+WkSW8=
Received: by 10.78.47.15 with SMTP id u15mr2997423huu;
        Tue, 20 Jun 2006 14:17:56 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Tue, 20 Jun 2006 14:17:56 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <e79jtd$51j$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22226>

On 6/21/06, Jakub Narebski <jnareb@gmail.com> wrote:
> > I intend to post a patch that adds snapshot support in Perl, in the
> > main code. Just need to make it optional ;-)
>
> Check http://marc.theaimsgroup.com/?l=git&m=111909432415478&w=2 for
> in the main code snapshot implementation.
>
> http://www.liacs.nl/~sverdool/gitweb.cgi?p=gitweb.git;a=summary
> http://www.liacs.nl/~sverdool/gitweb.git
>
> Would separate snapshot CGI script make it work faster?

I was thinking about that same one, we found (and fixed) a bug or two
on top of that so my plan is to rebase it on top of the gitweb on next
;-)

> >> Any further ideas for other useful features?
> >
> > Now what I think would rock too is something similar to gitk's "nearby
> > tags" feature. When reading a commit, it lists the heads and tags that
> > this commit is part of. It's very useful. Now I'll have to read up on
> > how gitk does it.
>
> If I remember correctly, it was done in the background, and it was done
> at least partially _in_ gitk (Tcl/Tk).

I suspect it is doing a whole lot of git-merge-base invocations, which
are rather costly. I don't know of any cheaper way to ask that
question.

> > And, as you mention in your other post, mod_perl support. And a bit of
> > speed. Gitweb right now is really really slow.
>
> Perhaps mod_cache would help. Especially if cache can be configured to
> look only at the hash part, plus formatting (normal, plain/raw, blame,
> search match highlighting).

Right, some URLs are guaranteed to be static (those blob views), so it
can just cache on the full URL, for ever and ever. The other ones...
well, we just make sure we don't do anything too expensive there ;-)



martin
