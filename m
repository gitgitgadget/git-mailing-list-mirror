From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 1/3] refactor ref status logic for pushing
Date: Tue, 8 Dec 2009 12:17:21 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0912081158040.14365@iabervon.org>
References: <20091208223413.98e99d3e.rctay89@gmail.com> <20091208223543.c7f88afe.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 18:17:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI3gn-0007Gs-W8
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 18:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbZLHRRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 12:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938194AbZLHRRS
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 12:17:18 -0500
Received: from iabervon.org ([66.92.72.58]:36685 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938184AbZLHRRP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 12:17:15 -0500
Received: (qmail 16044 invoked by uid 1000); 8 Dec 2009 17:17:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Dec 2009 17:17:21 -0000
In-Reply-To: <20091208223543.c7f88afe.rctay89@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134897>

On Tue, 8 Dec 2009, Tay Ray Chuan wrote:

> Move the logic that detects up-to-date and non-fast-forward refs to a
> new function in remote.[ch], set_ref_status_for_push().

Is there some reason to not have set_ref_status_for_push() be static in 
transport.c now? (Sorry for not suggesting this before.)

Other than that, it looks good to me.

I think it might be a good idea to have it generate a peer ref for refs 
that don't have one when mirror is used, which would eliminate a couple 
more lines, but there's no reason that has to be done in the same patch.

	-Daniel
*This .sig left intentionally blank*
