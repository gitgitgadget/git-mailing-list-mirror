From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 00:43:29 -0400
Message-ID: <20130908044329.GA15087@sigill.intra.peff.net>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
 <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
 <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
 <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
 <20130904081047.GB2582@serenity.lan>
 <20130904092527.GB22348@sigill.intra.peff.net>
 <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
 <20130908041805.GB14019@sigill.intra.peff.net>
 <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 06:43:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIWqj-00024E-Fe
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 06:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367Ab3IHEnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 00:43:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:42181 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab3IHEnd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 00:43:33 -0400
Received: (qmail 32117 invoked by uid 102); 8 Sep 2013 04:43:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Sep 2013 23:43:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 00:43:29 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234177>

On Sat, Sep 07, 2013 at 11:37:13PM -0500, Felipe Contreras wrote:

> > By "svn-like", I mean the people whose workflow is:
> >
> >   $ hack hack hack
> >   $ git commit
> >   $ git push ;# oops, somebody else pushed in the meantime
> >   $ git pull
> >   $ git push
> 
> But that's not svn-like at all.

It's not if you understand the difference between merge-then-commit and
commit-then-merge. But for a clueless user who has been told "replace
svn commit" with "git commit && git push" and replace "svn update" with
"git pull", it is quite similar.

> > Those people would now have to learn enough to choose between merge and
> > rebase when running the "git pull".
> 
> But that's only if they don't care about the shape of history. In my
> experience the people that cling more to centralized VCS do not like
> merges, so they rebase everything to make it a straight line. That is
> much more "svn-like".
> 
> So chances are they are already doing 'git pull --rebase' (or
> similar), so their workflow wouldn't be affected.

I think we are talking about two classes of users. People who truly
don't care about the shape of history will also not care about using
"git pull --rebase", because the only reason to use it is to impact the
shape of history.

I agree there is also a set of people coming from the centralized vcs
world who want to keep a linear history.

-Peff
