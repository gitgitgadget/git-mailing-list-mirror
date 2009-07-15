From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: How to manage multiple personal projects
Date: Wed, 15 Jul 2009 12:39:11 -0400
Message-ID: <32541b130907150939w563eeb63ib850513c93d35c2c@mail.gmail.com>
References: <a1138db30907150900j7d6152ebs755d83adf7717287@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Richards <paul.richards@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 18:40:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR7Wk-0003v2-Hd
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 18:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbZGOQjd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jul 2009 12:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbZGOQjc
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 12:39:32 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:35517 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156AbZGOQjb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jul 2009 12:39:31 -0400
Received: by gxk9 with SMTP id 9so2385164gxk.13
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vKVvK3n7zody75FAZfOLHf+CbK5TKQnzeYXaZ+TNrXQ=;
        b=L/rU98hq88TPMV7s3nYCWYBY9X1kqnTyZbKBOiO92CY+xRxIvB8FbVoTtW5/cHMy5/
         ddgb0AgxHHZZOcGa3ZX6bRgptdmSAby75sCApjOydMuU8Eiw1kT1iwRL0Tq4SQXcXLJ7
         K/6Y1iTAyeMbuNAyJsJAYZbT836V6vXPWprck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gT/ziFHyhCMyS2jAkaJDGW5PDnuDvJsM9Ogj+cI7nDV4WTUJ7/V/cQ9K0ZaotnO12x
         y3py411QsFL2k65vM83wURKmzJmnddm5pllQ3f6XWt9YVToNeKoRPXZfHu9Ox5E49KQu
         Q9dVrR6Z0IpDqi94M2NFHHoFA3hRUSopI3hNE=
Received: by 10.150.230.1 with SMTP id c1mr12751230ybh.216.1247675971136; Wed, 
	15 Jul 2009 09:39:31 -0700 (PDT)
In-Reply-To: <a1138db30907150900j7d6152ebs755d83adf7717287@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123327>

On Wed, Jul 15, 2009 at 12:00 PM, Paul Richards<paul.richards@gmail.com=
> wrote:
> I believe the correct choice with Git is to create a repository per
> project. =A0This would work OK for me, but I worry about the shear
> number of repositories I'd end up creating. =A0Part of the nice thing
> with my current Subversion setup is that starting a new project is
> very easy and cheap, I don't create a new repository each time.

Creating the repository for a git project is astonishingly cheap,
because the initial repository exists inside the source tree of the
project itself.  So you don't even have to decide in advance what to
name your project.  I'd say this is even easier than creating a new
svn directory.

You could then decide to publish your project (and go through a couple
of steps to do so) only if it's important enough.  Also, if you use
something like github.com, this part is really easy - and someone else
will pay the bandwidth costs.

> I think what might work with Git (and for which I'd like some advice)
> is something inbetween. =A0I could have a single Git repository to ho=
ld
> my small experiment projects where initially is where I always start
> my work by creating a new directory. =A0Then if any of them start to
> mature, I could move the project out into it's own repository for
> real. =A0Would Git support this in some way tracking changes from one
> repo to the other? =A0Or would I end up having to "replay" all the
> commits from one repo to the other?

Although I definitely recommend just making one git repo per project
in your case, you *could* do exactly what you describe above using
git-subtree:  http://github.com/apenwarr/git-subtree.  Disclosure: I
wrote git-subtree, so I like it by default.

However, doing this would only really be useful if your projects
cross-reference each other in some way.  My main motivation for
writing git-subtree, for example, is that I often end up building
useful tools that grow inside one of my other projects, then turn out
to be good on their own (or as part of another project).  So it's not
that I kept unrelated projects together for convenience (because it
really isn't any more or less convenient in git), but rather that I
wasn't able to predict the future, and git-subtree lets me change my
mind.

Have fun,

Avery
