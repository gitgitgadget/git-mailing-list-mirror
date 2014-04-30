From: Phil Pennock <phil.pennock@spodhuis.org>
Subject: Re: [PATCH] zsh completion: 5.0.3 compat, use emulate
Date: Wed, 30 Apr 2014 15:44:29 -0400
Message-ID: <20140430194429.GC85829@redoubt.spodhuis.org>
References: <EMXW5CZ-001FUQ-3S@ilmenite.field.spodhuis.org>
 <53609249b388d_597a125b3084d@nysa.notmuch>
 <5360c9d095f5c_47db12fd310ef@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 22:02:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfahq-0004gM-9A
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 22:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946044AbaD3UCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 16:02:09 -0400
Received: from redoubt.spodhuis.org ([94.142.241.89]:50435 "EHLO
	mx.spodhuis.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbaD3UCI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 16:02:08 -0400
X-Greylist: delayed 1054 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Apr 2014 16:02:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=spodhuis.org; s=d201312;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=rP7Di4gl5OApkJ2D6HrAJUTEKlO9d7EovCmIq1d6kwE=;
	b=NRnwyFbo2R/atWXV1Co0qpzU+i+NlWT8peAvspqwDWPx/fWntz1tBrRp+bOjYSWI1W9QdnHf6CJ45U65adHpkhGBON7SuY0Mc956YjmiOZMCKwOCqidrVUsGxcMJw2mtBPVT/Umm/YZm90xKLJgl0TIg+B3/F06cyg+8GvD7N9peol10Fxfnn3qqh8t1ETBgi5cJ97d5SAhdJ49R;
Received: from authenticated user by smtp.spodhuis.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	id 1WfaQg-000Mg8-AU; Wed, 30 Apr 2014 19:44:30 +0000
Content-Disposition: inline
In-Reply-To: <5360c9d095f5c_47db12fd310ef@nysa.notmuch>
OpenPGP: url=https://www.security.spodhuis.org/PGP/keys/0x3903637F.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247771>

On 2014-04-30 at 05:00 -0500, Felipe Contreras wrote:
> Felipe Contreras wrote:
> > Phil Pennock wrote:
> > > The bash completion pulled into zsh was being pulled in _as_ zsh, but
> > > used patterns which relied on falling through as unhandled.  In zsh
> > > 5.0.3 this no longer works, resulting in:
> > > 
> > >     __git_complete_remote_or_refspec:33: bad pattern: +*
> > > 
> > > Fix by telling zsh to emulate sh while sourcing the bash config file,
> > > which stickily preserves compatibility options in the function context.
> > > This usage of "emulate" came in with zsh 4.3.10, released 2009-06-01.
> > 
> > I'm using 5.9.5 and I don't see any issue. Howe exactly have you
> > configured this script?
> 
> I meant 5.0.5.
> 
> Anyway, I've tried with multiple versions of zsh and I'm able to
> reproduce the issue by doing 'git push origin <tab>'. However, it seems
> the issue was instroduced in 5.0.3, and fixed in 5.0.4, so I don't think
> we should do anything on our side.

Correct: it was considered a regression and after I mailed the git list,
zsh changed the behaviour and put out 5.0.4 fairly shortly thereafter.
I don't think that 5.0.3 has taken root anywhere, so you should be good.

-Phil
