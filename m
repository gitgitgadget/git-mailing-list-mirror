From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sun, 21 Mar 2010 03:49:54 +0530
Message-ID: <f3271551003201519r61d3b9e5y83691ebb25da3534@mail.gmail.com>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com> 
	<32541b131003191132y119037f8rae598d0037786703@mail.gmail.com> 
	<fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com> 
	<32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com> 
	<alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de> <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com> 
	<alpine.LNX.2.00.1003201724270.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Mar 20 23:20:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt71r-000659-3W
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 23:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297Ab0CTWUQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 18:20:16 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63586 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab0CTWUP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Mar 2010 18:20:15 -0400
Received: by gyg8 with SMTP id 8so2080758gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Tau8pxJMkNF8eGnkzIVXng1v2JrncRIpgf7/mb+ueU0=;
        b=bTe1N9EUWLNASgAIhNudcoXcGfeCAsipBbql7xPq/uvaI74JN3w4xvxpi0l8k6SMeC
         67Lx0rcQwsCjYHT/OV+Yn1Es0Xvcui4fwFaOre2QZOYk2fwBsSnJ+729iHTYJtRZLzK6
         ED7ntMErCf/tC0LRNkNSrrAfM7MBAV2B8d/NA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QMR3Vv2dAP5pskYAPU58gW/KfpPIWnIlvL2VYSW6AOsgeZCzz0Fl2D3PCkhvhNmWzX
         2aHd0HCocYX2hhpPHJqG0z7MuOjN0XBIfFN5khwZPiiRKQp8XtNlC27mNDMpAKYMnPkw
         LqnXgao2qaYxnOYAEatI7ZymJYczEiSxQudNk=
Received: by 10.91.203.38 with SMTP id f38mr2435131agq.18.1269123614279; Sat, 
	20 Mar 2010 15:20:14 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1003201724270.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142763>

> The one thing I worry about is that you are proposing to wait a while
> before submitting your changes upstream. =A0I would suggest pushing
> whatever pieces work to contrib/ early on to get more feedback from
> reviewers and testers. =A0(I am saying this selfishly, as a potential
> tester.)

Okay, I'll try to get patches integrated immediately then.

> The structure for remote helpers should be that each foreign system h=
as a
> single helper which git can call with instructions on what to do (bot=
h for
> foreign-to-git and for git-to-foreign operations). So 3 and 4 have to=
 be
> functions of the same program, and it's probably best for 2 and 5 and
> maybe 1 to also be part of this program.

Right. I only split it up for the purposes of illustration. 3 and 4
will be merged into a program called `git-remote-svn` that will
automatically be invoked when Git encounters an SVN remote. 2 and 5
will be merged into another program `svn-export-import` which can be
thought of as the fusion of svn-fast-export and svn-fast-import.
`git-remote-svn` will invoke it when necessary. And yeah, I don't know
if I want to write the SVN client into `svn-export-import` or leave it
as a separate program.

> So the helper wouldn't be running git-fast-export or git-fast-import,
> unless it was a helper for using git as the foreign system.

Ah. I just realized that :)

> If you're going to work in C, you should look at my Perforce helper. =
It's
> suitable for mainline inclusion, due to using a free-as-in-beer,
> made-available-without-license-terms C++ library for the Perforce sid=
e,
> but may be a better model for a C remote helper than git.py is.

Thanks. I'll have a look. git.py isn't very useful.

Regards,
Ramkumar
