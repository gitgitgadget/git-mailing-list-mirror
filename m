From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 11:40:41 +0000
Message-ID: <b0943d9e0712190340p23341dd8lb9ebbbce9b29cb8e@mail.gmail.com>
References: <20071214105238.18066.23281.stgit@krank>
	 <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
	 <20071217224812.GA6342@diana.vm.bytemark.co.uk>
	 <20071218052115.GA13422@diana.vm.bytemark.co.uk>
	 <b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com>
	 <20071219093400.GA4361@diana.vm.bytemark.co.uk>
	 <b0943d9e0712190209y485bc2f8w806bd2cad309e74b@mail.gmail.com>
	 <20071219112035.GA5565@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 12:41:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xIe-0002VR-Oe
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 12:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbXLSLkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 06:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbXLSLkn
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 06:40:43 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:28783 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbXLSLkm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 06:40:42 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2622996rvb.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 03:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=C00wEAtlJWDZWHpBuqPfgMVRRBE12Eoedtp7ZrCU/9o=;
        b=FjC4jdJwMu8i0mUQyv+nbiEVld+12v+NrNqY2ATuWNTFalnkHZ3/G1stpPWHiX9M5vFm//95bAsreD9RnrHoa3sb8yRza5eIdaJuspXe07RJgm1uSGU1TPPgBXyabCt2KzcWfRn1/XLcp3Q1H06ik4b1k4w22b5p2hOUFSAnk4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MOdsIz/0xjeV6XM2pKqflCZWDB/tiiAWws3iRkejpgFvxf48purzwUE0UOvyvKLn1W6WnsWbY2eXiF7OjVXxvE0rlifcXw+DSfq6Wx+T7/D7AW6dGiuoy7pXz7B5RBhTp7/KSETIw+1YytuA7P02N+C3wNn9I/ByGYXpRXKbO4Y=
Received: by 10.140.128.3 with SMTP id a3mr2882116rvd.221.1198064441674;
        Wed, 19 Dec 2007 03:40:41 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Wed, 19 Dec 2007 03:40:41 -0800 (PST)
In-Reply-To: <20071219112035.GA5565@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68891>

On 19/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-12-19 10:09:40 +0000, Catalin Marinas wrote:
>
> > For the 'status --reset', I'll keep it if we have a separate
> > 'resolved' command.
>
> ?

It needs to call the resolved_all to remove checked-out stages if
stgit.keeporig =3D=3D 'yes'. Maybe it could also do some sanity check i=
f
HEAD !=3D top. With 'git reset --hard', people might easily add an
argument and break the whole stack.

> > In the past, StGIT only used the core git functionality and stayed
> > away from the porcelain scripts. We now started to use some of the
> > built-in commands more and more and I think it is fine but the git
> > scripts look more volatile to me than the C code (look at the many
> > variants the git merging went through, from shell scripts to python
> > and only now seems to be stabilised with the recursive merge as a
> > built-in command).
>
> Hmm? Have we started to use more porcelain lately?

I think Yann was complaining about using git-show since it looks more
like a porcelain command.

> > Adding the functionality I need to git-mergetool would also mean
> > always using the latest GIT with StGIT.
>
> It wouldn't keep being the latest git version, though.

Yes, but at least initially it should be pretty recent.

> > Anyway, if you like git-mergetool, I think you can easily change th=
e
> > StGIT configuration to
>
> I don't use interactive merging at all. What I wanted was to get rid
> of StGit's own interactive merging.

I use it quite often and I even invoke it automatically
(stgit.autoimerge). I'll push some patches tonight together with most
of your safe branch and we can alter them afterwards.

> So you want StGit to do two things: patch stacks, and fix some git UI
> warts. Hey, I can live with that. :-) But I firmly believe that the
> wart fixing parts of StGit should be (1) optional, so that the same
> job can easily be done with just git; and (2) as thin as possible, to
> make them easy to explain in terms of git, and cheap to maintain.

Unless you need the keeporig functionality, you can now always use
plain git for solving merges, add/rm/cp, 'reset --hard' etc. At some
point, we could make it safe for 'git rebase' but I think we need the
DAG patches.

> > That's not the case with 'resolved'.
>
> No, I see.

As I said, if you don't need keeporig, just use git-add (or stg-add
when I'll add the alias).

--=20
Catalin
