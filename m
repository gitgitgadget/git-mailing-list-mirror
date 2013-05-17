From: John Keeping <john@keeping.me.uk>
Subject: Re: Fwd: git cvsimport implications
Date: Fri, 17 May 2013 10:21:57 +0100
Message-ID: <20130517092157.GA2299@serenity.lan>
References: <CAPZPVFYFL6OS2HWbF0BKNKtNsZ6CfpWmKCypGxeTs7W8-76q8Q@mail.gmail.com>
 <CAPZPVFZLDwLNazvBh5n=Jg_=CZUNz3yTme4JW2NutPgjPzwtLg@mail.gmail.com>
 <7vfvxpfbli.fsf@alter.siamese.dyndns.org>
 <51932A1A.4050606@alum.mit.edu>
 <CAPZPVFZTZFQrCF3gcwcff5LFm9MHhZm-DauLvfzCYrMTw4nQfA@mail.gmail.com>
 <5195F3EB.8000308@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 17 11:22:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdGrd-0007O3-JS
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 11:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab3EQJWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 05:22:09 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:55589 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab3EQJWH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 05:22:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9492DCDA616;
	Fri, 17 May 2013 10:22:06 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3gTa8BzNCciX; Fri, 17 May 2013 10:22:05 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 1CAE0CDA628;
	Fri, 17 May 2013 10:21:59 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <5195F3EB.8000308@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224680>

On Fri, May 17, 2013 at 11:10:03AM +0200, Michael Haggerty wrote:
> On 05/15/2013 08:03 PM, Eugene Sajine wrote:
> > My primary goal was to understand better what are the real problems
> > that we might have with the way we use git cvsimport, so I was not
> > asking about the guarantee of the cvsimport to import things
> > correctly, but if there is a guarantee the import will result in
> > completely broken history.
> 
> So what are you going to do, use cvsimport whenever you cannot *prove*
> that it is wrong?  You sure have low standards for your software.
> 
> The only *useful* guarantee is that software is *correct* under defined
> circumstances.  I don't think anybody has gone to the trouble to figure
> out when that claim can be made for cvsimport.
> 
> > If the cvsimport is that broken - is there any plan to fix it?
> 
> For one-time imports, the fix is to use a tool that is not broken, like
> cvs2git.
> 
> Alternatively, Eric Raymond claims to have developed a new version of
> cvsps that is not quite as broken as the old version.  Presumably
> cvsimport would be not quite as broken if used with the new cvsps.

cvsimport doesn't work with the cvsps-3 - we decided to stick with the
version we have (using cvsps-2) because that is the only option that
supports incremental import; those using if for that are used to its
deficiencies and there is no plan to improve it.  The manpage notes that
it uses a deprecated version of cvsps and recommends alternatives for
one-shot imports.

There is a version of git-cvsimport script in the cvsps-3 repository
that works with it, but it does not support incremental import in the
same was as git.git's git-cvsimport so it will not replace the version
in git.git.
