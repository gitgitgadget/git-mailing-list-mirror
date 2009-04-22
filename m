From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Removing duplicated code between builtin-send-pack.c and
 transport.c
Date: Wed, 22 Apr 2009 14:24:07 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0904221407160.10753@iabervon.org>
References: <09511913-0ED3-41C0-A4F0-9F2D452C00D7@petdance.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Lester <andy@petdance.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 20:25:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwh8m-00084n-RG
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 20:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbZDVSYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 14:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbZDVSYK
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 14:24:10 -0400
Received: from iabervon.org ([66.92.72.58]:52526 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913AbZDVSYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 14:24:09 -0400
Received: (qmail 26243 invoked by uid 1000); 22 Apr 2009 18:24:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Apr 2009 18:24:07 -0000
In-Reply-To: <09511913-0ED3-41C0-A4F0-9F2D452C00D7@petdance.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117225>

On Wed, 22 Apr 2009, Andy Lester wrote:

> There's a ton of code duplicated between transport.c and builtin-send-pack.c,
> from print_push_status() and its static helpers.
> 
> Is there a reason NOT to refactor it out of the builtin and use the 
> transport? 

I think the builtin should actually just be deprecated and eventually 
removed. As far as I know, nothing actually runs "git send-pack" rather 
than calling send_pack(), but I left the builtin entry point, along with 
its helpers, just in case.

If you're interested in reorganizing things there, I think it would be 
best to move send_pack() to a new send-pack.c, such that 
builtin-send-pack.c can go away entirely.

	-Daniel
*This .sig left intentionally blank*
