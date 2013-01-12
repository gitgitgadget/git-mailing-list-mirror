From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] cvsimport: rewrite to use cvsps 3.x to fix major bugs
Date: Sat, 12 Jan 2013 10:26:49 -0800
Message-ID: <20130112182649.GC4624@elie.Belkin>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
 <50F17DB0.2050802@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Rorvick <chris@rorvick.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Jan 12 19:31:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu5rC-00046m-Ka
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 19:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab3ALS0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 13:26:55 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:47133 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab3ALS0z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 13:26:55 -0500
Received: by mail-pb0-f51.google.com with SMTP id ro12so1483967pbb.38
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 10:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RGkV6Mhgn9FGkjAX9X2qhSAZLxcWYs79Svgqx/UgkEo=;
        b=bBRLcVcmISm4TXbfSSFujpi8T7cakhxdToXo6Z8B3ZBsOYNK6tQIqdhk3V+V7RPOrB
         okLa9T+jvaeDzBd0Vn1kiTzseJfvRsN3M3WmkFVZZY1Mzc+R9jeCDJVp9GqAdx0p1Rl6
         6Vejb6IpUhTL6LFBXXSmHf6gzz5qfw0Z9A24XE8hINVmqUTnImH9rf/QSPeXsJHAEvgq
         GBwwAiVQbm7Ubnx8lHaYZdiGQH6RaM9+r/9hFjBp+W9kEv1Q8euFpylpg4bBpneDO7mf
         BhzWMz62dc56s/ZhICtWdmaSha+cVJcoSph7TM8ipfbT8OFeKS7duXFyNRRrCcRD55IY
         TuYA==
X-Received: by 10.66.74.197 with SMTP id w5mr204584494pav.60.1358015214540;
        Sat, 12 Jan 2013 10:26:54 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id o5sm5385781pay.5.2013.01.12.10.26.52
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Jan 2013 10:26:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50F17DB0.2050802@alum.mit.edu>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213299>

Michael Haggerty wrote:

> Regarding your claim that "within a few months the Perl git-cvsimport is
> going to cease even pretending to work": It might be that the old
> git-cvsimport will stop working *for people who upgrade to cvsps 3.x*.
> But it is not realistic to expect people to synchronize their git and
> cvsps version upgrades.  It is even quite possible that this or that
> Linux distribution will package incompatible versions of the two packages.

Moreover, I feel an obligation to point the following out:

In a hypothetical world where cvsps 3.x simply breaks "git cvsimport"
it is likely that some distributions would just stick to the existing
cvsps and not upgrade to 3.x.  Maybe that's a wrong choice, but that's
a choice some would make.  An even more likely outcome in that
hypothetical world is that they would ship it renamed to something
like "cvsps3" alongside the existing cvsps.  Or they could rename the
old version to "cvsps2".  If we were the last holdout, we could even
bundle it as compat/cvsps.

So please do not act as though the cvsps upgrade is a crisis that we
need to break ourselves for at threat of no longer working at all.
The threat doesn't hold water.

Luckily you have already written patches to make "git cvsimport" work
with cvsps 3.x, and through your work you are making a better
argument: "The new cvsimport + cvsps will work better, at least for
some users, than the old tool."

Just don't pretend you have the power to force a change for a less
sensible reason than that!

Hope that helps,
Jonathan
