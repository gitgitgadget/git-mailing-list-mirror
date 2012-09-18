From: Mischa POSLAWSKY <git@shiar.nl>
Subject: Re: [PATCH] git-jump: ignore (custom) prefix in diff mode
Date: Tue, 18 Sep 2012 04:52:29 +0200
Message-ID: <20120918025229.GB19986@pearl.mediadesign.nl>
References: <1347844915-4130-1-git-send-email-git@shiar.nl>
 <20120917030143.GA19986@pearl.mediadesign.nl>
 <7vy5k9w7eh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 04:52:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDnvU-0005Sv-9y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 04:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167Ab2IRCwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 22:52:32 -0400
Received: from pearl.mediadesign.nl ([195.177.242.41]:57582 "HELO
	pearl.mediadesign.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755912Ab2IRCwb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 22:52:31 -0400
Received: (qmail 9863 invoked by uid 1007); 18 Sep 2012 04:52:29 +0200
Content-Disposition: inline
In-Reply-To: <7vy5k9w7eh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt 1.5.20 + Vim 7.2 (Debian 6.0.5 GNU/Linux 2.6.32.59)
X-URL: http://shiar.nl/
X-Accept-Language: nl, eo, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205784>

Junio C Hamano skribis 2012-9-16 22:22 (-0700):

> Mischa POSLAWSKY <git@shiar.nl> writes:
> 
> > Subject: [PATCH/RFC] format-patch: force default file prefixes in diff
> >
> > Override user configuration (eg. diff.noprefix) in patches intended for
> > external consumption to match the default prefixes expected by git-am.
> >
> > Signed-off-by: Mischa POSLAWSKY <git@shiar.nl>
> > ---
> 
> Not all projects expect to see a/ & b/ prefix and these are
> configurable for a reason.  Robbing the choice that has been
> supported for quite a long time from them is an unacceptable
> regression.

My bad, I was assuming format-patch would mostly interact with git am.

> Why did you think this may be a good idea in the first place?
> 
> Perhaps you had configured your diff.noprefix in a wrong
> configuration file?  This is primarily per-project choice, and your
> clone of git.git should not have diff.noprefix set, neither your
> $HOME/.gitconfig unless you always work on projects that want
> diff.noprefix.

Then I'm not using it as intended.  For me it's just a personal
preference of how I'd like to review commits (diff/show) so I can easily
copy-paste file names (less essential since my discovery of git jump,
but still).  It's not something I'd like to be communicated with any
upstream project (format-patch).

So it seems I'm asking for a new feature: to be able to configure local
and inter-project diff options differently.  In this case I'd be helped
by either format.noprefix=0 or a to be bikeshedded localdiff.noprefix=1.
I don't know about other options though.  Does anybody actually want
mnemonicprefix to be sent out as well?

Another solution could be a single option defining behaviour exceptions:
format.diff = normal | textconv | noconfig
Expanding on the existing --(no-)textconv difference in format-patch.

-- 
Mischa
