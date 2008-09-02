From: Heikki Orsila <shd@modeemi.fi>
Subject: Re: [PATCH] Add --filedirstat diff option
Date: Tue, 2 Sep 2008 14:58:49 +0300
Message-ID: <20080902115848.GA1252@jolt.modeemi.cs.tut.fi>
References: <20080901011259.GA31696@zakalwe.fi> <7vd4jnnifp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 14:00:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaUYi-0004Wy-Py
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 14:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbYIBL71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 07:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbYIBL71
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 07:59:27 -0400
Received: from mail.cs.tut.fi ([130.230.4.42]:64385 "EHLO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbYIBL70 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 07:59:26 -0400
Received: from amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70])
	by mail.cs.tut.fi (Postfix) with ESMTP id 6EC7CBFAE;
	Tue,  2 Sep 2008 14:59:23 +0300 (EEST)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70]) (amavisd-maia, port 10024)
 with ESMTP id 05647-10; Tue,  2 Sep 2008 14:59:22 +0300 (EEST)
Received: from modeemi.modeemi.cs.tut.fi (modeemi.modeemi.cs.tut.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with ESMTP id 14669BFAB;
	Tue,  2 Sep 2008 14:59:19 +0300 (EEST)
Received: from jolt.modeemi.cs.tut.fi (jolt.modeemi.cs.tut.fi [130.230.72.144])
	by modeemi.modeemi.cs.tut.fi (Postfix) with ESMTP id CE00422202;
	Tue,  2 Sep 2008 14:58:49 +0300 (EEST)
Received: by jolt.modeemi.cs.tut.fi (Postfix, from userid 16311)
	id 7F646A30D7; Tue,  2 Sep 2008 14:58:49 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <7vd4jnnifp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Maia Mailguard 1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94668>

On Mon, Sep 01, 2008 at 11:57:46PM -0700, Junio C Hamano wrote:
> Heikki Orsila <heikki.orsila@iki.fi> writes:
> 
> > @@ -2474,7 +2478,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
> >  		options->output_format |= DIFF_FORMAT_DIRSTAT;
> >  	else if (!strcmp(arg, "--cumulative"))
> >  		options->output_format |= DIFF_FORMAT_CUMULATIVE;
> > -	else if (!strcmp(arg, "--check"))
> > +	else if (opt_arg(arg, 'X', "filedirstat", &options->dirstat_percent)) {
> > +		options->output_format |= DIFF_FORMAT_DIRSTAT;
> > +		options->filedirstat = 1;
> 
> Why 'X'?  It would never match, confusing to the reader, and risks a
> sudden change in behaviour when these statements are reordered or somebody
> mechanically attempts to convert this to parse_options().

This is embarrassing.. I just copied the previous "dirstat" line.. 
*grin*

Anyway, what about the concept of filedirstat? Is it agreeable?

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
