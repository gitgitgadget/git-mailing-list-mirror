From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 18:25:59 -0500
Message-ID: <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	 <20070211225326.GC31488@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:26:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGO5h-0006Yx-7K
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822AbXBKX0D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbXBKX0B
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:26:01 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:33455 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932822AbXBKX0A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:26:00 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1428676nze
        for <git@vger.kernel.org>; Sun, 11 Feb 2007 15:26:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HZ79IlHGhvgJ5ALWkYbo/4DooQXz0lkyT6gQYhFYKl63s+pWHKlhXe3qYclEa54hOTVWSQSOQdHE+t1Zm3o50ZiWB+AiRSrN1IwdTLEdDDUjMQ+IJ3rEnzk84InNKbcj7BlZ+HTxT7BnUfkP8ClEqzbJDllHsQuCGeSy6C0FsCw=
Received: by 10.115.47.1 with SMTP id z1mr6585368waj.1171236359679;
        Sun, 11 Feb 2007 15:25:59 -0800 (PST)
Received: by 10.114.195.13 with HTTP; Sun, 11 Feb 2007 15:25:59 -0800 (PST)
In-Reply-To: <20070211225326.GC31488@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39328>

On 2/11/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > Is this happening because the repository on the server is not
> > completely packed? It is basically building a pack of the whole thing
> > and shipping it to me, right?
>
> Correct.  The wire protocol only allows us to send one pack.
> So we have to pack everything and transmit it as a single unit.
>
> > If that is the case, why not first pack the whole repository and then
> > copy it down the wire? Now the next clone that comes along doesn't
> > have to do so much work. Would this help to eliminate some of the load
> > at kernel.org?
>
> Probably, but then the daemon needs write access to the repository.
> This isn't required right now; it can be strictly read-only and
> still serve the contents.
>
> > remote: Total 63, written 63 (delta 0), reused 63 (delta 0)
> > 100% (63/63) done
> > fatal: pack: not a valid SHA1
> > New branch: 0953670fbcb75e26fb93340bddae934e85618f2e
>
> What version of git is this?  That looks like we're assuming the word
> pack was an object, but I'm not sure why we would do such a thing...

jonsmirl@jonsmirl:/usr/local/bin$ git --version
git version 1.5.0.rc2.g53551-dirty


>
> --
> Shawn.
>


-- 
Jon Smirl
jonsmirl@gmail.com
