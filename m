From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Tue, 17 Apr 2007 20:02:30 +0200
Message-ID: <e5bfff550704171102j61234553qb388a4be67592a07@mail.gmail.com>
References: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
	 <e5bfff550704122238l4a453cb7g38834c7da3432d5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Paul Mackerras" <paulus@samba.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 20:03:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hds10-0005gp-6V
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 20:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161264AbXDQSCf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 14:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161276AbXDQSCe
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 14:02:34 -0400
Received: from nz-out-0506.google.com ([64.233.162.236]:41172 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161264AbXDQSCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 14:02:33 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1555094nze
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 11:02:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N+xY4PttkVmeR49UrGCf/mQYz8Tuak72+vhsNvaVNj7KXLLdc5GHiNbBeDndgmgxH/Des9UG7DJ6HxZC2wQPPKWt/8XiJukEb4xmRBMDZz9e0zECUIF6jKOwbJ42O01F4pCkKUItuXjxcS1UDyjLIPwsUVOPQuYC9v+MhotPNtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AQX0ABOpAaCaPnXvciGQ0Bq/fHsD6+vohkw/Rrn4aVJn8YlXkt6BaihhmhCHcPhLNTOeOn+9gMJB9freiUmLVZFZ7b7N/4e/hmaNIkBlWQ0utXwbCbbA9L10MPbFXSKGGUVhFUEB9pRXp2qLTQdjguTjVSR45rrHsELaEw6OZfI=
Received: by 10.115.75.1 with SMTP id c1mr2543177wal.1176832950952;
        Tue, 17 Apr 2007 11:02:30 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Tue, 17 Apr 2007 11:02:30 -0700 (PDT)
In-Reply-To: <e5bfff550704122238l4a453cb7g38834c7da3432d5a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44807>

On 4/13/07, Marco Costalba <mcostalba@gmail.com> wrote:
> On 4/12/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> >
> > So I can see two ways to fix this:
> >  - bug Paul about alternate diff viewing capabilities in gitk. He's cc'd
> >    here. A way to make the "diff" pane show just the new one, the old one,
> >    or even both side-by-side with some mousy interface?
> >  - add some actual switch to git diff generation to hide the negative side
> >    of a unified diff, and add some way to just make gitk pass that switch
> >    in.
> >
> > I dunno. I realize that it's not just gitk - gitweb, qgit etc don't allow
> > the tricks *either*, but gitk was the one I just hit this with.
>
> Currently in qgit you can select a revision + a file and call an
> external diff viewer, as example Kompare (tweakable from
> 'Edir->settings->External diff viewer' menu) to view the diff
> side-by-side, or in any other way the viewer allows, for the selected
> file.
>
> I like also the idea to hide the negative side but I would rather
> prefer a togglable command/button instead of a command line argument
> or a setting, so to allow easy and quick hide/unhide on the same
> patch.
>
> I will work on it..... ;-)
>

I have pushed a patch with support for toggling view of the negative
side of an unified diff (right most 'filter' button in patch viewer
tab or CTRL+H shortcut).

In case someone is interested repo is, as usual,

                git://git.kernel.org/pub/scm/qgit/qgit.git


  Marco

P.S: Another two useful shortcuts are the hide/unhide of revision
description header ('h' key or from 'View' menu) and hide/unhide of
secondary panes ('s' key or from 'View' menu) they work in all the
different tabs.
