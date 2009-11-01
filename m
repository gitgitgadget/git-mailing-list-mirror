From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Fw: git-core: SIGSEGV during {peek,ls}-remote on HTTP remotes.
Date: Sun, 1 Nov 2009 15:16:20 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911011504460.14365@iabervon.org>
References: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru>  <7v8weq50pm.fsf@alter.siamese.dyndns.org> <fabb9a1e0911010646v2043bdb7l9215f1114e9e8385@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-415119531-1257106580=:14365"
Cc: Junio C Hamano <gitster@pobox.com>,
	Samium Gromoff <_deepfire@feelingofgreen.ru>,
	git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>,
	Mike Hommey <mh@glandium.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 21:16:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4gqm-0006rf-Tk
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 21:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbZKAUQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 15:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbZKAUQR
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 15:16:17 -0500
Received: from iabervon.org ([66.92.72.58]:46599 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753323AbZKAUQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 15:16:16 -0500
Received: (qmail 18181 invoked by uid 1000); 1 Nov 2009 20:16:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Nov 2009 20:16:20 -0000
In-Reply-To: <fabb9a1e0911010646v2043bdb7l9215f1114e9e8385@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131877>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-415119531-1257106580=:14365
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Sun, 1 Nov 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Sun, Nov 1, 2009 at 05:27, Junio C Hamano <gitster@pobox.com> wrote:
> >  - Should we fix get_helper() in transport-helper.c, instead of touching
> >   ls-remote.c like this patch does?
> 
> Probably, yes.

If we change the ls-remote.c case, it becomes impossible for a struct 
transport to ever have a NULL remote field. And the change to ls-remote 
removes a special case. I'd go so far as to say that ls-remote.c should 
provide a struct remote, and transport_get should enforce that there's a 
struct remote.

	-Daniel
*This .sig left intentionally blank*
--1547844168-415119531-1257106580=:14365--
