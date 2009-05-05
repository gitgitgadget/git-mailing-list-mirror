From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: Re: [PATCH v2 2/4] Add format.coverauto boolean
Date: Tue, 5 May 2009 15:29:24 +0200
Message-ID: <20090505132923.GC26208@fsst.voodoo.lan>
References: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org> <1241431142-8444-3-git-send-email-ft@bewatermyfriend.org> <7v8wlc4fqo.fsf@alter.siamese.dyndns.org> <20090505084916.GB26208@fsst.voodoo.lan> <7vvdof25oe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 15:29:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1KiW-0003dO-OO
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 15:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbZEEN3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 09:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbZEEN3n
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 09:29:43 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:37644 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbZEEN3n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 09:29:43 -0400
Received: from [212.117.84.18] (helo=fsst.voodoo.lan)
	by smtprelay10.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M1KiI-0006XJ-Ef; Tue, 05 May 2009 15:29:38 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M1Ki4-0003id-Gy; Tue, 05 May 2009 15:29:24 +0200
Content-Disposition: inline
In-Reply-To: <7vvdof25oe.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118296>

Junio C Hamano <gitster@pobox.com>:
[...]
> For one thing, I do not see a huge need for this configuration variable.
> Why is "--cover" too cumbersome to type, when you are already willing to
> type "format-patch"?  You can alias the whole thing away to make it even
> shorter.  For another, we do not simply break people's scripts knowingly.
> 
> For this feature to go forward, somebody has to find a way not to break
> people's scripts even when the user uses it.  One possibility is to find a
> nicer verb X and introduce "git X" command that does what "format-patch"
> does but with a better default (and syntax --- people get confused by the
> oldest form "git format-patch $commit", which does not behave like "git
> log $commit" simply because the syntax predates the modern "revision
> range" notation the "log" family supports, such as A..B).

Yes, this whole compatibility issue is exactly the reason why I said
earlier, that we could only take format.coverletter (the way it's
currently implemented in the latest series) and forget about
format.coverauto (and its implications) altogether:

<1241431142-8444-1-git-send-email-ft@bewatermyfriend.org>:
} Now that I think of it again, two weeks after writing this mail
} originally, I guess it would be possible to drop format.coverauto
} altogether and tell users to use:
} 
}  % git config --global alias.fp format-patch --cover-letter
} 
} I don't know which solution would be preferred. If it's the user-should-
} use-an-alias approach, I'll create a series that gets rid of
} format.coverauto changes.

I obviously was missing quotes around the alias's value but then,
'git fp' would do exactly what I'm after with this series. You could
just set format.coverletter to 2 and use 'git fp'. You always get a
cover letter for patch series longer than one patch.

The other approach, to create yet another subcommand just for this
would be too much IMHO. There are enough of them already.

Regards, Frank

-- 
In protocol design, perfection has been reached not when there is
nothing left to add, but when there is nothing left to take away.
                                                  -- RFC 1925
