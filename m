From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: How is git used as other than the project's version control?
Date: Tue, 28 Apr 2009 09:31:24 +0100
Message-ID: <e2b179460904280131x1797862eq501797af2132f2c9@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3EC48@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 10:31:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyij2-0002xN-CZ
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 10:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbZD1Ib0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 04:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbZD1Ib0
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 04:31:26 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63659 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbZD1IbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 04:31:25 -0400
Received: by fxm2 with SMTP id 2so385853fxm.37
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 01:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XoFMuw0gymJlUDKw581ECt8O4SD4nt1XdwwlDe1s/20=;
        b=wBXVXh9g6VjDxMoavpWfzY97WLJW8wJewCDtZl1hIw2Rp2Yg1kcAlHqYTiLlT4Lavs
         ELU5ryQjNFZQWIAeK3H+Lk92ckaNV5Vo8WWMrpWy7KSgrrKRsNBXcw8Zz1qJ1I7MEcmm
         FGTGSzECZUWFgs43zo69HYJrtHZRCTjHTI7xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OxGFvGcNXqXuoU95iq4n/fZK6hK7vMxjouXuNhHfqtgv3l6mp/USLCFK4JUm0z5SVb
         SeMPgMuAQUsOjF+8msrwF6xXc3zKvZMiYVHK4qRjf9vCcmI+EBG3c3jvqs/2AjIEs1bF
         zTHyZAs0V+GhL0qI1uJ+2tKEyRTsOnwJvOnD4=
Received: by 10.223.115.80 with SMTP id h16mr2225844faq.94.1240907484300; Tue, 
	28 Apr 2009 01:31:24 -0700 (PDT)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70AE3EC48@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117755>

2009/4/27 John Dlugosz <JDlugosz@tradestation.com>:
> I'm interested in finding out how people use git "on the side", when it
> is not the project's actual version control system.

We have historically used a very simple pessimistic locking strategy
with our legacy platform source. Individual files or groups of files
are checked out to developers' home directories and they override
what's in the live area when that dev compiles and tests for
themselves.

I basically inserted git under this mechanism, thus allowing the
optional use of merge and integrate (lockless development),
topic-branches, tags etc. Git also functions as our tripwire solution
to ensure changes to that master shared repo have all been made
traceably.

Git effectively is the VCS now, as what was there before was only
barely acceptable when it came to accessing old versions etc, but if
you don't want to interact with git, you don't have to even know it's
there. Until it saves your arse.

Mike
