From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: friendlier names
Date: Tue, 27 Jan 2009 07:38:37 -0800
Message-ID: <20090127153837.GB1321@spearce.org>
References: <87mydc6a2r.fsf@mcbain.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 16:40:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRq2l-0002WE-1N
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 16:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbZA0Pij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 10:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbZA0Pii
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 10:38:38 -0500
Received: from george.spearce.org ([209.20.77.23]:44921 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbZA0Pih (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 10:38:37 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0A47938210; Tue, 27 Jan 2009 15:38:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <87mydc6a2r.fsf@mcbain.luannocracy.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107356>

David Abrahams <dave@boostpro.com> wrote:
> 
> For example, why couldn't the "index" be called the "stage" instead?
> That, along with knowing that "git add" was a synonym for "git stage"
> would have flattened the learning curve considerably for me.

Historical reasons...

Waaay back the "index" was an index of the files git knows about in
your working directory.  It made sense to call it an index, as like
a book index it was a full listing of what's here, sorted by name.

That's pre-1.0 days.  Like the very first version Linus ever
released.  Aka commit e83c5163316f89bfbde7d9ab23ca2e25604af290.

Much, much later, over many months, the index morphed into what
you see today, which is a "staging area", accessed by "git add".

This was all incremental, in small parts.  Nobody set out to
design a "staging area" or to have "staging actions".  Back
when it was really the index you updated it with a tool called
git-update-index.  Adding new files required the --add flag.

People found --add annoying, so they wrote "git add" as a
wrapper around it.  But modified existing files still had
to be updated with git-update-index.  Then someone pointed
out that add of an existing file and add of a new file are
similiar enough that they should just be the same command,
"git add".

Only late last October at the GitTogether did we start to talk about
creating a command called "git stage", because people have started to
realize we seem to call it a "staging area" as we train newcomers...

The tools are _all_ slowly evolved over time.  Nothing in git
was ever set out from the beginning as a "this is what we are
going to do".  The only part of Git that is like that is the core
data structure on disk for the object store.  That hasn't changed
since Linus switched from SHA1(COMPRESS(data)) to SHA1(data) for
the object naming algorithm, and even that was done in the first
couple of weeks.

-- 
Shawn.
