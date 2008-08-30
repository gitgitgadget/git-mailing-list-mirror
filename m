From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [PATCH] Replace "git-" with "git " in *.[ch] comments and notifications
Date: Sat, 30 Aug 2008 04:15:09 +0300
Message-ID: <20080830011509.GA16289@zakalwe.fi>
References: <20080829234751.GA2396@zakalwe.fi> <7vvdxj2ucl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Heikki Orsila <heikki.orsila@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 03:16:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZF4g-0002nE-PU
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 03:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbYH3BPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 21:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753080AbYH3BPM
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 21:15:12 -0400
Received: from zakalwe.fi ([80.83.5.154]:34487 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbYH3BPK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 21:15:10 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id B62BF2BC68; Sat, 30 Aug 2008 04:15:09 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <7vvdxj2ucl.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94354>

On Fri, Aug 29, 2008 at 05:56:58PM -0700, Junio C Hamano wrote:
> Heikki Orsila <heikki.orsila@iki.fi> writes:
> 
> > diff --git a/archive.c b/archive.c
> > index e2280df..042f587 100644
> > --- a/archive.c
> > +++ b/archive.c
> > @@ -282,7 +282,7 @@ static int parse_archive_args(int argc, const char **argv,
> >  		OPT_STRING(0, "remote", &remote, "repo",
> >  			"retrieve the archive from remote repository <repo>"),
> >  		OPT_STRING(0, "exec", &exec, "cmd",
> > -			"path to the remote git-upload-archive command"),
> > +			"path to the remote git upload-archive command"),
> >  		OPT_END()
> >  	};
> 
> Are you sure about this one?  How would one spell the command line?
> 
> 	$ git archive --exec='/usr/local/bin/git upload-archive'
> 
> I somehow think this wouldn't fly well.
> 
> I do not think a single patch with the above hunk (which I think is a
> mistake) and other bits that are obviously good (e.g. the first hunk to
> builtin-apply.c we see below) is reviewable, but I cannot think of a
> better alterantive.  Sigh...

OK, wherever git-receive-pack, git-upload-archive or 
git-upload-back was changed to the new form, I changed it back. These 
are afaik the last 3 git-* commands in bindir.

> > @@ -506,17 +506,17 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
> >  		name = orig_name;
> >  		len = strlen(name);
> >  		if (isnull)
> > -			die("git-apply: bad git-diff - expected /dev/null, got %s on line %d", name, linenr);
> > +			die("git apply: bad git diff - expected /dev/null, got %s on line %d", name, linenr);
> >  		another = find_name(line, NULL, p_value, TERM_TAB);
> >  		if (!another || memcmp(another, name, len))
> > -			die("git-apply: bad git-diff - inconsistent %s filename on line %d", oldnew, linenr);
> > +			die("git apply: bad git diff - inconsistent %s filename on line %d", oldnew, linenr);
> 
> I am not sure about this one.  This is not talking about the git-diff
> program, but about a variant of "diff" with git flavour (similar to the
> word "unified diff" -- there is no "unified" command with subcommand
> "diff").   So rolling this kind fo change into a topic that tries to get
> rid of "dashed form of commands" feels quite wrong, even though as a
> general wording improvement, I think it is better than the original (and I
> would even suggest rewording to "git patch", to make sure we are not
> talking about the "git-diff" program).

I'll change it back to git-diff, but retain "git apply".

> I did not look at the rest.

Is the concept OK for this change? I can submit another patch.

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
