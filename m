From: David Aguilar <davvid@gmail.com>
Subject: Re: [POC PATCH] diff options: Introduce --interactive
Date: Mon, 30 Mar 2009 02:04:39 -0700
Message-ID: <20090330090438.GA18953@gmail.com>
References: <1238391670-4421-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 11:06:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoDRP-0008TB-Sw
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbZC3JEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 05:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbZC3JEG
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:04:06 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:53602 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbZC3JEE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 05:04:04 -0400
Received: by qyk16 with SMTP id 16so3369865qyk.33
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 02:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WogrSp/iZLUJHIfogSmYnkDV5D2SycZbYeqTRLbxZ2A=;
        b=Xe4yIfHZVv4U9fYg41DYLtMC3FtU/RGVZyNXNqQLHEAnNb+MEy3IjbsHKUvrn1m1iE
         b+9jI+JaKZL7pAysRbXyFkzREb6/qZadROCEjIIZw+CBFnHu1xss8FzPf/KXdHo6qLqP
         UH8JhuJjcm287KFZbiQyKauX1qdFAM9FMSoeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xCLJJ5Zv6aREItD2PTw0PLczXP263r0/96LuX1SB7EnRW4slC/PGk5H6Z8Vo3nqo9x
         Hirsf1AS4PjRz7sqfVwsSDWK7lT29oGrBNXMtQfnfRAkqWsrEBxvX82PMELOX3ne5B1p
         XWJ3w4kkeOKfXy3QPHDiJMdD0UmameLYoVEoA=
Received: by 10.224.2.200 with SMTP id 8mr5738700qak.341.1238403841012;
        Mon, 30 Mar 2009 02:04:01 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 6sm5584454qwd.38.2009.03.30.02.03.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 02:04:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1238391670-4421-1-git-send-email-pkufranky@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115110>

On  0, Ping Yin <pkufranky@gmail.com> wrote:
> The new option --interactive introduces an interactive diff mode. Now we
> can choose to see the diff for a selected file.

I just tried it out.  Very cool.
It's exactly the functionality users have asked me about.

I just sent a for-the-future patch that teaches difftool
to tell difftool-helper that it shouldn't prompt when
you're using --interactive.

I noticed git-diff doesn't have a -i flag yet,
perhaps it could be the shorthand for --interactive?

(I'd have to change that for-the-future patch I just sent
 too since it also only checks for the long form...)

I like it.

> 
> This is a preparation to introduce the --tool option to launch the
> external diff tool for a selected file.

With both of our latest patches:

	git difftool --interactive <revargs>

does exactly what one would expect it to.


How are you envisioning --tool?  It'd be great if we didn't
need the perl wrapper, though something does need to set
GIT_EXTERNAL_DIFF/GIT_PAGER/etc... (that is, unless you have a
better way =))


> >> When the user types a number,  git-difftool-helper is launched to show
> >> the diff for the corresponding file.
> >
> > Cool.
> > I had two patches that I sent to the list for
> > git-difftool.perl.  If you're going to patch it then you might
> > want to base it on top of those.
> >
> When i try to code on git-difftool.perl, i find it is more appropriate to add
> the --interactive and then --tool options to git-diff itself. So here is a
> proof of concept patch based on next. What we should do next is to try to
> design a good UI.

I'll see if I can come up with any suggestions.
I liked it on the first test drive.


-- 

	David
