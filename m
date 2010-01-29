From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] fast-import: Stream very large blobs directly to
	pack
Date: Fri, 29 Jan 2010 10:30:24 -0800
Message-ID: <20100129183024.GA22101@spearce.org>
References: <20100129012350.GD20488@spearce.org> <7vockdjx6w.fsf@alter.siamese.dyndns.org> <20100129152254.GC21821@spearce.org> <20100129163838.GD21821@spearce.org> <m3aavwbwaz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 19:30:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Navc1-0002Yu-KP
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 19:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390Ab0A2Sa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 13:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753350Ab0A2Sa2
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 13:30:28 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:31502 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab0A2Sa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 13:30:28 -0500
Received: by qw-out-2122.google.com with SMTP id 8so411544qwh.37
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 10:30:27 -0800 (PST)
Received: by 10.224.57.198 with SMTP id d6mr451344qah.94.1264789826956;
        Fri, 29 Jan 2010 10:30:26 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm1598918qyk.5.2010.01.29.10.30.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 10:30:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m3aavwbwaz.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138334>

Jakub Narebski <jnareb@gmail.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> >  Documentation/git-fast-import.txt |    6 ++
> >  fast-import.c                     |  172 +++++++++++++++++++++++++++++++++----
> >  t/t5705-clone-2gb.sh              |    2 +-
> >  t/t9300-fast-import.sh            |   46 ++++++++++
> >  4 files changed, 208 insertions(+), 18 deletions(-)
> 
> > +--big-file-threshold=<n>::
> > +	Maximum size of a blob that fast-import will attempt to
> > +	create a delta for, expressed in MiB.  The default is 512.
> > +	Some importers may wish to lower this on systems with
> > +	constrained memory.
> > +
> 
> Shouldn't there be config variable corresponding to this command line
> option, so that it can be set once for [constrained] system?

Implemented as core.bigFileThreshold in this patch... but I didn't
document it...

-- 
Shawn.
