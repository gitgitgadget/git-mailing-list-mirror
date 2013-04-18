From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 3/6] transport-helper: clarify pushing without refspecs
Date: Thu, 18 Apr 2013 11:24:29 +0100
Message-ID: <20130418102428.GX2278@serenity.lan>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
 <1366258473-12841-4-git-send-email-felipe.contreras@gmail.com>
 <20130418101133.GW2278@serenity.lan>
 <CAMP44s33WLE6xJ_bFJBX2z0hdkALqCKpq7Ve+8hZw2URWUPz_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 12:24:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USm1H-0003sa-9h
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 12:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968089Ab3DRKYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 06:24:43 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:59275 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967505Ab3DRKYm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 06:24:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id CE1A06064FF;
	Thu, 18 Apr 2013 11:24:41 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XwqW3Sp6UXSh; Thu, 18 Apr 2013 11:24:41 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 4F548606580;
	Thu, 18 Apr 2013 11:24:30 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAMP44s33WLE6xJ_bFJBX2z0hdkALqCKpq7Ve+8hZw2URWUPz_w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221643>

On Thu, Apr 18, 2013 at 05:14:18AM -0500, Felipe Contreras wrote:
> On Thu, Apr 18, 2013 at 5:11 AM, John Keeping <john@keeping.me.uk> wrote:
> > On Wed, Apr 17, 2013 at 11:14:30PM -0500, Felipe Contreras wrote:
> >> This has never worked, since it's inception the code simply skips all
> >> the refs, essentially telling fast-export to do nothing.
> >>
> >> Let's at least tell the user what's going on.
> >>
> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >> ---
> >>  Documentation/gitremote-helpers.txt | 4 ++--
> >>  t/t5801-remote-helpers.sh           | 6 +++---
> >>  transport-helper.c                  | 5 +++--
> >>  3 files changed, 8 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> >> index ba7240c..4d26e37 100644
> >> --- a/Documentation/gitremote-helpers.txt
> >> +++ b/Documentation/gitremote-helpers.txt
> >> @@ -162,8 +162,8 @@ Miscellaneous capabilities
> >>       For remote helpers that implement 'import' or 'export', this capability
> >>       allows the refs to be constrained to a private namespace, instead of
> >>       writing to refs/heads or refs/remotes directly.
> >> -     It is recommended that all importers providing the 'import' or 'export'
> >> -     capabilities use this.
> >> +     It is recommended that all importers providing the 'import'
> >> +     capability use this. It's mandatory for 'export'.
> >
> > s/It's/It is/
> 
> What's the difference?

"It's" is considered informal, while we do adopt that tone on the
mailing list and sometimes in the documentation, in general I think we
should avoid contractions in the formal documentation.

In this case it is particularly jarring because it immediately follows a
sentence where we use the full "It is" form.
