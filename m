From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 01:21:07 -0400
Message-ID: <20130908052107.GA15610@sigill.intra.peff.net>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
 <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
 <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
 <20130904081047.GB2582@serenity.lan>
 <20130904092527.GB22348@sigill.intra.peff.net>
 <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
 <20130908041805.GB14019@sigill.intra.peff.net>
 <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
 <20130908044329.GA15087@sigill.intra.peff.net>
 <CAMP44s3kow9dooPzK6iD8p2LAgt1mtFuaNsVhkJHrqe4D+8xLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 07:21:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIXR9-0007Vc-WA
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 07:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435Ab3IHFVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 01:21:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:42448 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab3IHFVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 01:21:11 -0400
Received: (qmail 1740 invoked by uid 102); 8 Sep 2013 05:21:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 00:21:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 01:21:07 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s3kow9dooPzK6iD8p2LAgt1mtFuaNsVhkJHrqe4D+8xLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234185>

On Sun, Sep 08, 2013 at 12:09:34AM -0500, Felipe Contreras wrote:

> > It's not if you understand the difference between merge-then-commit and
> > commit-then-merge. But for a clueless user who has been told "replace
> > svn commit" with "git commit && git push" and replace "svn update" with
> > "git pull", it is quite similar.
> 
> Well, yeah, but if they are so clueless they have to be told what to
> do, they can be told to do 'git pull --merge' instead, no?

I think it's fine to tell them to do "git pull --merge". What I'd worry
more about is somebody who is suddenly presented with the choice between
"--rebase" and "--merge" and doesn't know which to choose. We've created a
cognitive load on the user, and even more load if they choose --rebase
and don't quite understand what it means.

The current warning message in jc/pull-training-wheel is quite neutral
between the two options. Perhaps we should lean more towards merging?

I guess that works against John's case, though, which is clueless people
working on a project that _does_ care about the shape of history. At
least they would have to stop and think for a moment, though, which
might help (and maybe convince them to ask more clueful project
members). I don't know.

-Peff
