From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Refspec patterns with * in the middle
Date: Mon, 2 Mar 2009 13:25:16 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903021323180.19665@iabervon.org>
References: <alpine.LNX.1.00.0903011820590.19665@iabervon.org>  <7viqmrn98i.fsf@gitster.siamese.dyndns.org> <76718490903021001h16009570p7ac8c66a8e8e1f90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1870365447-1236018316=:19665"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 19:27:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeCqq-0001fl-KL
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 19:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbZCBSZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 13:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbZCBSZU
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 13:25:20 -0500
Received: from iabervon.org ([66.92.72.58]:48224 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbZCBSZS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 13:25:18 -0500
Received: (qmail 10443 invoked by uid 1000); 2 Mar 2009 18:25:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Mar 2009 18:25:16 -0000
In-Reply-To: <76718490903021001h16009570p7ac8c66a8e8e1f90@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111957>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1870365447-1236018316=:19665
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 2 Mar 2009, Jay Soffian wrote:

> On Mon, Mar 2, 2009 at 12:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Daniel Barkalow <barkalow@iabervon.org> writes:
> >
> >> My use case is actually, more precisely:
> >>
> >> some/constant/stuff/$PROJ-$NUMBER/junk/my-proj
> >>
> >> Where $NUMBER is the version number, and $PROJ is usually, but not quite
> >> always "my-proj"; the exception being that it might be effectively a
> >> superproject. So I'd like to have:
> >>
> >>  fetch = some/constant/stuff/my-proj-*/junk/my-proj:refs/remotes/origin/*
> >
> > ... and expect "some/constant/stuff/my-proj-2.5/junk/my-proj" to be mapped
> > to "refs/remotes/origin/2.5"?  I think it does not look too bad.
> >
> >> But I can live with remote branches like "my-proj-2.4" instead of "2.4".
> >>
> >> I think it would make sense, and limit typo damage, to say that the * can
> >> only expand to something with a '/' in it if the star has a slash or the
> >> end of the string on each side.
> >
> > I do not understand what you mean by "* can only expand to something with
> > a '/' in it if ..." part.  None of the examples in your message have a
> > case where the asterisk matches across directory boundaries, and I thought
> > you would simply say "* does not match /" and be done with that.
> >
> > What scenario do you have in mind that wants to match a slash with an
> > asterisk?
> 
> I think he means the following are valid:
> 
>  - foo/bar/*/baz
>  - foo/bar/baz/*
> 
> But the following is not:
> 
>  - foo/bar*/baz
> 
> IOW, '*' can only appear as a non-terminating symbol if it is bounded
> by '/' on each side.

You have my criterion right, but I want that to be valid, but only match 
things like "foo/bar-something/baz", not "foo/bar-a/b/baz".

	-Daniel
*This .sig left intentionally blank*
--1547844168-1870365447-1236018316=:19665--
