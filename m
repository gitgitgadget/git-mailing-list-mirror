From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 08:24:19 -0700
Message-ID: <20090813152419.GN1033@spearce.org>
References: <1250140186-12363-1-git-send-email-srabbelier@gmail.com> <1250140186-12363-2-git-send-email-srabbelier@gmail.com> <1250140186-12363-3-git-send-email-srabbelier@gmail.com> <20090813144327.GK1033@spearce.org> <alpine.DEB.1.00.0908131652190.7429@intel-tinevez-2-302> <20090813150446.GM1033@spearce.org> <fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 17:24:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbcAG-0000wO-JD
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 17:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbZHMPYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 11:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754758AbZHMPYS
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 11:24:18 -0400
Received: from george.spearce.org ([209.20.77.23]:49614 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbZHMPYS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 11:24:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 53E64381FD; Thu, 13 Aug 2009 15:24:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125827>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Actually I was thinking that the frontend should allow the user to override
> these options. Assuming it is, say, specifying a marks file, if the user
> wishes to change that, the frontend would probably need to know about the
> new location too.
> 
> So not only is it easier to implement, it makes sense from an ui
> perspective. No?

My point is, most of the options are about paths to local files.

If I export something from hg on machine A, then copy the
fast-import stream to machine B, the marks file on B might not be
in the same path.  I might not even control machine A, maybe you
emailed me that stream file.  I may not be able to use an option
on the source tool to alter the path.

Why shouldn't I be able to (easily) override the marks location
locally, without resorting to stream editing?

Same with --force.  Which probably now demands a counter option,
--no-force.  If you send me a stream with "option force\n" in the
header, why can't I try to import it with "--no-force" first?

-- 
Shawn.
