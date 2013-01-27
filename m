From: John Keeping <john@keeping.me.uk>
Subject: Re: mergetool: include custom tools in '--tool-help'
Date: Sun, 27 Jan 2013 19:56:18 +0000
Message-ID: <20130127195618.GS7498@serenity.lan>
References: <20130127163442.GQ7498@serenity.lan>
 <7vobgawljs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 20:56:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzYLS-0001xX-I3
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 20:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab3A0T43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 14:56:29 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:39798 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab3A0T42 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 14:56:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 04EF7CDA5B0;
	Sun, 27 Jan 2013 19:56:28 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rvhh4rQXHP40; Sun, 27 Jan 2013 19:56:24 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 7545BCDA510;
	Sun, 27 Jan 2013 19:56:20 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vobgawljs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214722>

On Sun, Jan 27, 2013 at 10:03:19AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > 'git mergetool --tool-help' only lists builtin tools, not those that the
> > user has configured via a 'mergetool.<tool>.cmd' config value.  Fix this
> > by inspecting the tools configured in this way and adding them to the
> > available and unavailable lists before displaying them.
> 
> Although I am not a mergetool user, I would imagine that it would
> make sense to show it as available.
> 
> Just like "git help -a" lists subcommands in a way that can be easy
> to tell which ones are the standard ones and which ones are user
> customizations, this may want to give a similar distinction, though.
> I dunno.

I think I'd want to do this with a suffix if at all, so the output would
be like this:

    'git mergetool --tool=<tool>' may be set to one of the following:

            araxis
            gvimdiff
            gvimdiff2
            mytool	(user-defined)
            vimdiff
            vimdiff2

    The following tools are valid, but not currently available:

            bc3
            codecompare
            deltawalker
            diffuse
            ecmerge
            emerge
            kdiff3
            meld
            opendiff
            p4merge
            tkdiff
            tortoisemerge
            xxdiff

    Some of the tools listed above only work in a windowed
    environment. If run in a terminal-only session, they will fail.


Adding more sections for the user-defined tools feels like the output
would be too imposing and would make it hard to immediately identify the
valid option.


John
