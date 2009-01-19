From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH] parsecvs: produce tagger fields acceptable to newer git versions
Date: Mon, 19 Jan 2009 14:39:07 +0100
Message-ID: <20090119133907.GF4390@xi.wantstofly.org>
References: <20090119120217.GD4390@xi.wantstofly.org> <87ab9nbh49.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: keithp@keithp.com, git@vger.kernel.org, jay@gnu.org,
	kedars@marvell.com
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Jan 19 14:40:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOuMv-0002o1-R3
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 14:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791AbZASNjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 08:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759725AbZASNjL
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 08:39:11 -0500
Received: from xi.wantstofly.org ([80.101.37.227]:33787 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759422AbZASNjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 08:39:10 -0500
Received: by xi.wantstofly.org (Postfix, from userid 500)
	id 6C1CE7FABA; Mon, 19 Jan 2009 14:39:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87ab9nbh49.fsf@meyering.net>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106357>

On Mon, Jan 19, 2009 at 01:44:06PM +0100, Jim Meyering wrote:

> > Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>
> >
> > diff --git a/git.c b/git.c
> > index da320d1..8f94d1b 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -371,11 +371,13 @@ git_mktag (rev_commit *commit, char *name)
> >  		"object %s\n"
> >  		"type commit\n"
> >  		"tag %s\n"
> > -		"tagger %s\n"
> > +		"tagger %s <%s> %lu +0000\n"
> >  		"\n",
> >  		commit->sha1,
> >  		name,
> > -		author ? author->full : commit->author);
> > +		author ? author->full : commit->author,
> > +		author ? author->email : commit->author,
> > +		commit->date);
> >      if (rv < 1) {
> >  	fprintf (stderr, "%s: %s\n", filename, strerror (errno));
> >  	fclose (f);
> 
> Hi Lennert,

Hey Jim,


> I posted the same patch a while back.
> 
>     http://markmail.org/message/cebh7suc7ejpayos
> 
> However, I never heard back.
> You'll also need the patch below, if you're building
> against a newer version of git.

Can you make your parsecvs repository available somewhere?


thanks,
Lennert
