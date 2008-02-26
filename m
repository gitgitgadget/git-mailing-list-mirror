From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [RFC] Build in clone
Date: Tue, 26 Feb 2008 13:53:35 -0500
Message-ID: <1204052015.11329.5.camel@gaara.boston.redhat.com>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
	 <200802260321.14038.johan@herland.net>
	 <alpine.LNX.1.00.0802261128360.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Santi =?ISO-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 19:55:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU4wf-00047E-Cn
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 19:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763564AbYBZSxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 13:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763551AbYBZSxw
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 13:53:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52832 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763482AbYBZSxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 13:53:51 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m1QIrfcU002342;
	Tue, 26 Feb 2008 13:53:41 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1QIrffO012322;
	Tue, 26 Feb 2008 13:53:41 -0500
Received: from [192.168.1.104] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1QIreQP032010;
	Tue, 26 Feb 2008 13:53:40 -0500
In-Reply-To: <alpine.LNX.1.00.0802261128360.19024@iabervon.org>
X-Mailer: Evolution 2.21.91 (2.21.91-2.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75160>

On Tue, 2008-02-26 at 12:36 -0500, Daniel Barkalow wrote:
> On Tue, 26 Feb 2008, Johan Herland wrote:
> 
> > Other than the failing tests, it seems to work fairly well. I've been
> > playing around with it for a few minutes, and on a test repo I have with
> > 1001 branches and 10000 tags, it cuts down the runtime of a local git-clone
> > from 25 seconds to ~1.5 seconds. (simply by eliminating the overhead of
> > invoking git-update-ref for every single ref) :)
> 
> Good to hear. A certain amount of the point is performance, and I've only 
> got relatively simple repositories on Linux to test with, where everything 
> is too fast to tell anyway.

Yeah, that's pretty cool.

> > - Fix "clone from $repo" reflog messages (using strbufs; something tells
> >   me more of this code would benefit from using strbufs)
> 
> Most likely. I think Kristian wrote most of this before strbuf existed or 
> something of the sort.

No this was after the strbuf API went in.  The "clone from $repo"
messages I just left at the time because I was lazy, but yeah, they'll
need some strbuf love, or maybe just snprintf.  I don't agree that
strbuf applies very well for the rest of the code.  I'm a big fan of the
strbuf functionality, but I've been very deliberate about using and not
using it.

cheers,
Kristian
