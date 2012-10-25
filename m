From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] fix 'make test' for HP NonStop
Date: Thu, 25 Oct 2012 12:51:59 +0200
Message-ID: <002f01cdb29e$c2db47e0$4891d7a0$@schmitz-digital.de>
References: <001e01cdb061$c25f6380$471e2a80$@schmitz-digital.de> <20121025095826.GM8390@sigill.intra.peff.net> <002e01cdb29a$893593f0$9ba0bbd0$@schmitz-digital.de> <20121025104900.GA6363@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Jeff King'" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:52:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRL30-0002sK-Kx
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 12:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072Ab2JYKwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 06:52:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:56462 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab2JYKwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 06:52:09 -0400
Received: from DualCore (dsdf-4db53cfd.pool.mediaWays.net [77.181.60.253])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0Lsf1t-1TGIJi1YID-012gLA; Thu, 25 Oct 2012 12:52:07 +0200
In-Reply-To: <20121025104900.GA6363@sigill.intra.peff.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQI2sQMOQ5ANofWD9kSBDc7fafINHQKHXgBmASq388ECc588spbGrZRA
Content-Language: de
X-Provags-ID: V02:K0:hIryNjfriXvsmo3Fq/sTjvEqYkHMdNrZHSBP0WmFCA5
 elz8KkIM7BCvrVJG16DPoKs+Ga3nWUebxr2iOgsyIxftrz41jC
 NrzI+3+UfBolB8GFEmGnnidv5V/34KuZvUp7N3yCgQ4aTXGuZe
 imxsHVvnFUuDgcbOx5BkYgleb1G59CDFkwPF5u49HNRm32uY74
 PkaeFCoGpUTH5fv+J9M69HbdWv1e0UaE5mbZS6d6+XDd2cdnf3
 Mb9bgdHVmUpR+XKGpx8sG7FNqW0IPDAzn8k2dzUwfI9f8e/ISn
 zXMhAvDk/KsVWyKHlPIxFeZyNZFel5oCMRNPIx7OMVbo56gJP4
 2UimcCvYyG9oyyc6yUp25abI8lTWq8rfUNspCMMlN+oMjXQZoL
 gtJg6bI42v09A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208387>

> From: Jeff King [mailto:peff@peff.net]
> Sent: Thursday, October 25, 2012 12:49 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] fix 'make test' for HP NonStop
> 
> On Thu, Oct 25, 2012 at 12:21:44PM +0200, Joachim Schmitz wrote:
> 
> > > > +	# for 'make test'
> > > > +	# some test don't work with /bin/diff, some fail with /bin/tar
> > > > +	# some need bash, and some need ${prefix}/bin in PATH first
> > > > +	SHELL_PATH=${prefix}/bin/bash
> > > > +	SANE_TOOL_PATH=${prefix}/bin
> > >
> > > This feels a little too specific to go in our Makefile. Do we have any
> > > reason to think that where you are installing git is going to be the
> > > same place you have bash and other sane tools? Wouldn't this mean that
> > > things work when you run "make" but mysteriously break when you run
> > > "make prefix=/my/local/install/of/git"?
> >
> > Well, "make" won't break (I think), but "make test" very well might.
> 
> Sure.
> 
> > Well, so far all OpenSource packages ported to HP NonStop (at least
> > the ones on ituglib.connect-community.org) use prefix=/usr/local and
> > there is no intention to change that.
> 
> But then I would think using /usr/local would be the sane thing to put
> there, if that is the closest to "standard" for your platform.

OK, yes, hardcoding /usr/local seems OK too.
Would I need to re-roll?

Bye, Jojo
