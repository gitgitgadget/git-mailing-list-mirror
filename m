From: John Keeping <john@keeping.me.uk>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 12:08:39 +0100
Message-ID: <20130523110839.GT27005@serenity.lan>
References: <20130522115042.GA20649@inner.h.apk.li>
 <7v4ndukhx0.fsf@alter.siamese.dyndns.org>
 <20130523090657.GB23933@inner.h.apk.li>
 <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
 <20130523102959.GP9448@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Szakmeister <john@szakmeister.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 23 13:08:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfTOA-0004EP-DV
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 13:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758566Ab3EWLIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 07:08:48 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:55079 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758557Ab3EWLIs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 07:08:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 9F1B96064D1;
	Thu, 23 May 2013 12:08:47 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B1c5ojSUbrMo; Thu, 23 May 2013 12:08:47 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 67DDA60652F;
	Thu, 23 May 2013 12:08:40 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130523102959.GP9448@inner.h.apk.li>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225240>

On Thu, May 23, 2013 at 12:29:59PM +0200, Andreas Krey wrote:
> On Thu, 23 May 2013 05:48:38 +0000, John Szakmeister wrote:
> ...
> > This is a feature of `git pull` that I really despise.  I really wish
> > `git pull` treated the remote as the first parent in its merge
> > operation.
> 
> I'd actually only like it that way when pulling from
> the tracking branch, not for any pull.

I'll add my voice to the "annoyed by this" pile ;-)

I've been annoyed by this at $DAYJOB recently.  A lot of people seem to
blindly "git pull" without much thought about how the history is ending
up and what they actually want to do.

I wonder if it would make sense for "git pull" (with no arguments) to
pass "--ff-only" to git-merge, allowing this to be overridden with
--rebase and --merge (which doesn't currently exist).  With some
suitable advice output we could hopefully educate users about how to
shape their history.
