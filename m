From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [STGIT PATCH] replace "git repo-config" usage by "git config"
Date: Thu, 24 Jan 2008 18:20:01 +0000
Message-ID: <b0943d9e0801241020y3ca5e5bah973922c4fc99f733@mail.gmail.com>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com>
	 <200801162158.26450.kumbayo84@arcor.de>
	 <20080117074559.GB25213@diana.vm.bytemark.co.uk>
	 <20080118042447.GA13178@diana.vm.bytemark.co.uk>
	 <b0943d9e0801230335m4a2d1855uf465d0d134f3ef39@mail.gmail.com>
	 <20080123161014.GA5850@diana.vm.bytemark.co.uk>
	 <b0943d9e0801230842w250ab963t16a1ab3c8024487e@mail.gmail.com>
	 <20080124070125.GA19653@diana.vm.bytemark.co.uk>
	 <b0943d9e0801240731q856925al267d81548f5e2091@mail.gmail.com>
	 <20080124180835.GA28723@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Peter Oberndorfer" <kumbayo84@arcor.de>, git@vger.kernel.org,
	"Pavel Roskin" <proski@gnu.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 19:20:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI6go-00083e-Lu
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 19:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbYAXSUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 13:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbYAXSUG
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 13:20:06 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:36691 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbYAXSUE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2008 13:20:04 -0500
Received: by nz-out-0506.google.com with SMTP id s18so255487nze.1
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 10:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=EvDswlO/nbsJqEol265rCXCHi5M07EcQCQk0K67fQ1U=;
        b=mZ4srdkbjSOXi6SkVTpz+6fsa4UCGyzIlAxJZMLaR6+Jz0Uv2zCbKkzd3AL1mQoYBxYHBkA+f23ofcQsB5ayoZOgM465F78b0eU/ehHtrgj1u2oPR3Uravr81OD4RjNNQ8NW+ZXFkrcqlmbHkf1Mq4kfusadHh7RHdgAh+nqOSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z7FpipwKJ9RnyYzbODBEzCgvtj9QUB6EfGgh3BirbVKT4ShdGf8c9IJHhIUZ6QatSpcGX7GA7mwm/sJe+GwesZjxjuNgVjZMRlliHxHWvPj/rNqxmfNeM1PKY/tJHPZQ22H9Hj5w4OKloPbwv7f88TncMeU5dW0uMQL9hHBXxU8=
Received: by 10.141.179.5 with SMTP id g5mr711782rvp.76.1201198801616;
        Thu, 24 Jan 2008 10:20:01 -0800 (PST)
Received: by 10.140.193.5 with HTTP; Thu, 24 Jan 2008 10:20:01 -0800 (PST)
In-Reply-To: <20080124180835.GA28723@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71642>

On 24/01/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-01-24 15:31:40 +0000, Catalin Marinas wrote:
>
> > Another thing, can the '--keep' option be added? Can it work with
> > the new structure? I use it quite often as I make some minor
> > modification and I'd like to pop patches without affecting the loca=
l
> > changes.
>
> As is, it works out of the box as long as your local changes are in
> files not touched by the command.

It used to work in this case as well :-).

> Making it work in other cases as well should be doable -- behind the
> scenes, we'd save the local changes much like a patch, and try to
> apply it at the end. (In fact, we should probably not create this
> "patch" until git-read-tree tells us it can't do its job due to local
> changes.)

My simple approach was to apply the cumulated diff of the patches to
be popped in reverse (and change the top of the stack). If there are
no conflicts, it works just fine. If it cannot do this, there might be
conflicts and I create a temporary patch manually. Merging that patch
would probably lead to conflicts needing to be solved.

=46or the push operation, we try the diff applying followed by a
three-way merge if the former fails. We could do something similar
with the pop operation for keeping the local changes - try the
reversed diff or create a temporary patch automatically.

But, I'd really like for this not to be enabled by default. I might
forget to refresh a patch and will go to another just to realise that
there are uncommitted changes, hence the "check_local_changes()" call
for most of the commands affecting the stack.

--=20
Catalin
