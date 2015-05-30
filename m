From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Sat, 30 May 2015 12:41:30 +0200
Message-ID: <20150530104129.GA4309@book.hvoigt.net>
References: <5547C961.7070909@web.de>
 <CAHd499CRge9Y6VzdC_ngXS4WxuQ9HizXQJzLpX3iQStY5Cg=6g@mail.gmail.com>
 <37f399418bbebb3b53a50bf8daffcdc0@www.dscho.org>
 <CAHd499Do2aB5E_=aDzkoDssEbgz181rH36X28Oe7Zcok2f=zBQ@mail.gmail.com>
 <20150518123036.GB16841@book.hvoigt.net>
 <CAHd499CETM2jmZ2iJk=AoXtjLUCQ==u6q9Z5P-3EVGSY48FY_A@mail.gmail.com>
 <20150519104413.GA17458@book.hvoigt.net>
 <CAHd499D9vOtLOBj2s5EOfsojSStZY+HdZR35icZ5cssLNkcD-A@mail.gmail.com>
 <20150521125122.GA22553@book.hvoigt.net>
 <55691DE3.70200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 12:41:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyeCv-0004mF-OY
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 12:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbbE3Kld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 06:41:33 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:52434 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932342AbbE3Klb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 06:41:31 -0400
Received: from [92.76.94.183] (helo=book.hvoigt.net)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YyeCD-0003v6-NU; Sat, 30 May 2015 12:40:53 +0200
Content-Disposition: inline
In-Reply-To: <55691DE3.70200@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270283>

On Fri, May 29, 2015 at 09:18:11PM -0500, Robert Dailey wrote:
> So I am working on trying to setup my environment (VM through Virtual Box)
> to do some testing on this. You all have encouraged me to try the mailing
> list review model. So I won't give up yet.

I am not sure you need a VM or Linux environment. Of course it will be
helpful in case your tests do no pass on Linux (which they sometimes do
due to some differences between the OSes). But until we actually run
into that problem I do not see anything wrong developing your change
purely on Windows. Since it seems you are more familiar with that
platform I would even encourage you to do so. That reduces the toolset
friction which you might experience in a new environment. Even if you
run into the problem, that your tests do not pass on Linux, we might be
able to solve that on the list.

Have you seen the github pull request -> mailing list proxy thing[1]? If
that helps you maybe you can test it and use it for your patch
submission. I think nobody will be annoyed if we get some strange emails
on the list during that testing phase since that might help more
contributors to contribute.

> In the meantime I'd like to ask, do we even need to add an option for this?
> What if we just make `diff.submodule log` not use --first-parent? This seems
> like a backward compatible change in of itself. And it's simpler to
> implement. I can't think of a good justification to add more settings to an
> already hugely complex configuration scheme for such a minor difference in
> behavior.
> 
> Thoughts?

This behavior has been with --first-parent for a long time. Even though
it seems like a minor change in my experience there will be complaints
from people that have got used to it and will now get big differences.
You never know how people use it. Since the extra value (full-log)
(AFAIR) has reached a consensus on the list and it allows us to satisfy
both long log and short log users I would prefer to go that route.

Cheers Heiko

[1] http://article.gmane.org/gmane.comp.version-control.git/269699
