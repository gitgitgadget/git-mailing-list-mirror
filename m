From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 00:56:48 -0400
Message-ID: <45346290.6050300@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <200610170119.09066.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 06:57:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZh0b-00045D-Mv
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 06:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423061AbWJQE4z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 00:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423062AbWJQE4y
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 00:56:54 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:42162 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1423061AbWJQE4x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 00:56:53 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZh0T-0000Yl-00; Tue, 17 Oct 2006 00:56:50 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610170119.09066.jnareb@gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29019>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jakub Narebski wrote:
> Well, <ref>~<n> means <n>-th _parent_ of a given ref, which for branches
> (which constantly change) is a moving target.

Ah.  Bazaar uses negative numbers to refer to <n>th parents, and
positive numbers to refer to the number of commits that have been made
since the branch was initialized.

> One cannot have universally valid revision numbers (even
> only per branch) in distributed development. Subversion can do that only
> because it is centralized SCM. Global numbering and distributed nature
> doesn't mix... hence contents based sha1 as commit identifiers.

Sure.  Our UI approach is that unique identifiers can usefully be
abstracted away with a combination of URL + number, in the vast majority
of cases.

> But this doesn't matter much, because you can have really lightweight
> tags in git (especially now with packed refs support). So you can have
> the namespace you want.

The nice thing about revision numbers is that they're implicit-- no one
needs to take any action to update them, and so you can always use them.

> I wonder if any SCM other than git has easy way to "rebase" a branch,
> i.e. cut branch at branching point, and transplant it to the tip
> of other branch. For example you work on 'xx/topic' topic branch,
> and want to have changes in those branch but applied to current work,
> not to the version some time ago when you have started working on
> said feature.

If I understand correctly, in Bazaar, you'd just merge the current work
into 'xx/topic'.

> What your comparison matrick lacks for example is if given SCM
> saves information about branching point and merges, so you can
> get where two branches diverged, and when one branch was merged into
> another.

I'm not sure what you mean about divergence.  For example, Bazaar
records the complete ancestry of each branch, and determining the point
of divergence is as simple as finding the last common ancestor.  But are
you considering only the initial divergence?  Or if the branches merge
and then diverge again, would you consider that the point of divergence?

merge-point tracking is a prerequisite for Smart Merge, which does
appear on our matrix.

> Plugins = API + detection ifrastructure + loading on demand.
> Git has API, has a kind of detection ifrastructure (for commands and
> merge strategies only), doesn't have loading on demand. You can
> easily provide new commands (thanks to git wrapper) and new merge
> strategies.

I'm not sure what you mean by API, unless you mean the commandline.  If
that's what you mean, surely all unix commands are extensible in that
regard.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNGKQ0F+nu1YWqI0RAsW+AJoDOsNRmBjo3raT43JL6qn7SuJNRwCfe9l5
oAZ9OyrxMQlHnwrruhcjz9Y=
=RNuG
-----END PGP SIGNATURE-----
