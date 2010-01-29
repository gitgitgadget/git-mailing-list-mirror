From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Fri, 29 Jan 2010 10:44:03 -0800
Message-ID: <20100129184403.GC22101@spearce.org>
References: <20100129012350.GD20488@spearce.org> <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com> <20100129183705.GB22101@spearce.org> <fabb9a1e1001291041w48776835m9b291923fbb859c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 19:44:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NavpI-00032K-5G
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 19:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab0A2SoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 13:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752798Ab0A2SoJ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 13:44:09 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:42235 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab0A2SoI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 13:44:08 -0500
Received: by qw-out-2122.google.com with SMTP id 8so414103qwh.37
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 10:44:07 -0800 (PST)
Received: by 10.224.5.72 with SMTP id 8mr444197qau.96.1264790647522;
        Fri, 29 Jan 2010 10:44:07 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm1604247qyk.7.2010.01.29.10.44.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 10:44:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fabb9a1e1001291041w48776835m9b291923fbb859c3@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138338>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Fri, Jan 29, 2010 at 19:37, Shawn O. Pearce <spearce@spearce.org> wrote:
> > I was intentionally slating this for maint, to fix a bug a user
> > reported when handling large streams.
> 
> Ah, sorry, did not notice that.
> 
> Speaking of which, how does one figure out what commit a patch
> is/could be based on? Couldn't we include that in the part behind the
> triple dash?

You have to tell the other guy in your cover letter section.  You can
try to guess if the index information is accurate by grepping
around a log output looking for that blob sha-1 and then finding
what branch that's in.  Its not pretty.

IIRC other DVCS systems include the ancestor identity in their
patch output.  Git doesn't bother, because in a multi-patch series
the 2nd (and subsequent) patches would have useless id information.

-- 
Shawn.
