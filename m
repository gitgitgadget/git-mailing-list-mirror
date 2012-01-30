From: "Bernhard R. Link" <brl@mail.brlink.eu>
Subject: Re: [PATCH v5 2/5] gitweb: add project_filter to limit project list
 to a subdirectory
Date: Mon, 30 Jan 2012 21:03:55 +0100
Message-ID: <20120130200355.GA2584@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <20120130095252.GA6183@server.brlink.eu>
 <20120130114557.GB9267@server.brlink.eu>
 <201201301657.12944.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 21:03:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrxS4-0001g9-4w
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 21:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab2A3UDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 15:03:39 -0500
Received: from server.brlink.eu ([78.46.187.186]:54103 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230Ab2A3UDj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 15:03:39 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrxRx-0005uy-75; Mon, 30 Jan 2012 21:03:37 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrxSF-0001BY-W6; Mon, 30 Jan 2012 21:03:56 +0100
Content-Disposition: inline
In-Reply-To: <201201301657.12944.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189409>

* Jakub Narebski <jnareb@gmail.com> [120130 16:56]:
> On Mon, 30 Jan 2012, Bernhard R. Link wrote:
> 
> > This commit changes the project listing views (project_list,
> > project_index and opml) to limit the output to only projects in a
> > subdirectory if the new optional parameter ?pf=directory name is
> > used.
> 
> It would be nice to have in this or in a separate commit an update
> to get_page_title() for HTML output, and to git_opml() updating
> <title> element in OPML output, so that it mentions that project
> list is limitied to $project_filter subdirectory.

Indeed. I overlooked that.

> > Reusing $project instead of adding a new parameter would have been
> > nicer from a UI point-of-view (including PATH_INFO support) but
> > would complicate the $project validating code that is currently
> > being used to ensure nothing is exported that should not be viewable.
>
> Nb. I wonder if we should make it invalid to have both 'project' and
> 'project_filter' parameters...

$project_filter should be ignored when $project is defined which is
enforced in all but those three actions.

action=project_list gets confused (shows wrong breadcrumbs) if $project
is defined, but that is unrelated to this changes, so one might to fix
that independently.

I'll resend the series as replies to this mail. What to do next? Wait
foranother explitit Acked-By of those? Or resend it to gitster@pobox.com
if no new issues are found?

        Bernhard R. Link
