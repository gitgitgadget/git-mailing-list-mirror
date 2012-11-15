From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 4/8] ident: keep separate "explicit" flags for author
 and committer
Date: Thu, 15 Nov 2012 00:04:57 -0800
Message-ID: <20121115080457.GD8429@elie.Belkin>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003413.GD17819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:05:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYuSB-0006jS-PZ
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 09:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992888Ab2KOIFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 03:05:04 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57289 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992684Ab2KOIFC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 03:05:02 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so981556pbc.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 00:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GpGjdZUH/otm/oji0ubpIDhycu0bg78c/Wye8pO1whA=;
        b=MeBC+XItJGX1tUS2v0J9KvgDAJ18Guu4jSv3530E7B9HU1uZGR5ZxM9S/ev0wODGHm
         fJloiWxF8OjEUHmwfgF8t8rcSF9lVVzLfYLr5vEHIs50B+AOCwmkhWfoRvZTEn508ruL
         sllf3ShBhGzk9TzALzqd6KCtqqyeaDxzoiv9IjoLAnkW/DBgUwIaAniNIvgngy50+1KW
         SMHXIWko366UvgO8dBCsOibExLHeVR55BNuXEOBe7JKoRn2N/luc9aPoim1a3/5KMI1P
         TX9f1xT935u27Zl5EUxxVuVAyW8WcAEW4rHOMZIY2qp1zJXRQuIJ9ZUNTRuaN2/RvXMz
         OYnA==
Received: by 10.68.235.208 with SMTP id uo16mr2282403pbc.65.1352966701988;
        Thu, 15 Nov 2012 00:05:01 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id c1sm9341248pav.23.2012.11.15.00.04.59
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Nov 2012 00:05:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121115003413.GD17819@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209805>

Jeff King wrote:

>   1. GIT_COMMITTER_* is set explicitly, but we fallback for
>      GIT_AUTHOR. We claim the ident is explicit, even though
>      the author is not.
>
>   2. GIT_AUTHOR_* is set and we ask for author ident, but
>      not committer ident. We will claim the ident is
>      implicit, even though it is explicit.
>
> This patch uses two variables instead of one, updates both
> when we set the "fallback" values, and updates them
> individually when we read from the environment.

Nice problem description.  The fixed behavior makes sense to me, for
what it's worth.

Not about this patch, but: in case (1), shouldn't the author fall
back to $GIT_COMMITER_NAME?
