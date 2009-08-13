From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/4] fast-import: put option parsing code in seperate
	functions
Date: Thu, 13 Aug 2009 07:40:07 -0700
Message-ID: <20090813144007.GJ1033@spearce.org>
References: <1250140186-12363-1-git-send-email-srabbelier@gmail.com> <1250140186-12363-2-git-send-email-srabbelier@gmail.com> <alpine.DEB.1.00.0908131208400.7429@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 16:40:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbbTX-0002dQ-O8
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 16:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbZHMOkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 10:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752316AbZHMOkH
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 10:40:07 -0400
Received: from george.spearce.org ([209.20.77.23]:35383 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbZHMOkH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 10:40:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 108BE381FD; Thu, 13 Aug 2009 14:40:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0908131208400.7429@intel-tinevez-2-302>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125822>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 12 Aug 2009, Sverre Rabbelier wrote:
> 
> > +static void option_export_marks(const char *marks)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +	strbuf_addstr(&buf, marks);
> > +	mark_file = strbuf_detach(&buf, NULL);
> > +}
> 
> Heh, this is a pretty convoluted way to write
> 
> 	mark_file = xstrdup(marks);
> 
> ;-)

Agreed.

> > +static void option_force()
> > +{
> > +	force_update = 1;
> > +}
> 
> I'm not sure that I would put these simple assignments in separate 
> functions, but that's certainly up to you!

Oh, good point.  Yes, please don't do that, please just write these
directly into the option parser.

Aside from these remarks, this patch looks good to me.

-- 
Shawn.
