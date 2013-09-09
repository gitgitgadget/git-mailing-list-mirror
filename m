From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 9 Sep 2013 21:24:35 +0100
Message-ID: <20130909202435.GJ2582@serenity.lan>
References: <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
 <20130908041805.GB14019@sigill.intra.peff.net>
 <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
 <20130908172605.GF5359@vauxhall.crustytoothpaste.net>
 <CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
 <20130909000153.GG5359@vauxhall.crustytoothpaste.net>
 <CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
 <vpqr4cy4g5q.fsf@anie.imag.fr>
 <xmqq1u4x4yst.fsf@gitster.dls.corp.google.com>
 <20130909195231.GA14021@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 22:25:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ811-0002Ll-Fq
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 22:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466Ab3IIUYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 16:24:50 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:56933 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310Ab3IIUYt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 16:24:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id D77AF6064A6;
	Mon,  9 Sep 2013 21:24:48 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S40iROCItfxX; Mon,  9 Sep 2013 21:24:48 +0100 (BST)
Received: from serenity.lan (mukota.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id EF9946064E0;
	Mon,  9 Sep 2013 21:24:37 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130909195231.GA14021@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234370>

On Mon, Sep 09, 2013 at 03:52:31PM -0400, Jeff King wrote:
> On Mon, Sep 09, 2013 at 11:47:45AM -0700, Junio C Hamano wrote:
> 
> > You are in favor of an _option_ to allow people to forbid a pull in
> > a non-ff situation, and I think other people are also in
> > agreement. So perhaps:
> > 
> >  - drop jc/pull-training-wheel and revert its merge from 'next';
> > 
> >  - update Felipe's series with a bit of tweak to make it less
> >    impactful by demoting error into warning and advice.
> > 
> > would be a good way forward?
> 
> I think that would address the concern I raised, because it does not
> create a roadblock to new users accomplishing their task. They can
> ignore the warning, or choose "merge" as the default to shut up the
> warning (and it is easy to choose that if you are confused, because it
> is what git is doing by default alongside the warning).

I think we need to make sure that we give instructions for how to go
back if the default hasn't done what you wanted.  Something like this:

    Your pull did not fast-forward, so Git has merged '$upstream' into
    your branch, which may not be correct for your project.  If you
    would rather rebase your changes, run

        git rebase

    See "pull.mode" in git-config(1) to suppress this message in the
    future.

?
