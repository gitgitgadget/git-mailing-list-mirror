From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] doc: don't claim that cherry-pick calls patch-id
Date: Wed, 25 Sep 2013 01:28:22 +0300
Message-ID: <20130924222822.GA2308@redhat.com>
References: <1380060333-2226-1-git-send-email-mst@redhat.com>
 <20130924221409.GT9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 00:26:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOb3c-0002kX-4f
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 00:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab3IXW0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 18:26:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52671 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754374Ab3IXW0H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 18:26:07 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8OMQ5Vr031337
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 24 Sep 2013 18:26:05 -0400
Received: from redhat.com (vpn1-6-23.ams2.redhat.com [10.36.6.23])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r8OMQ3EN016346;
	Tue, 24 Sep 2013 18:26:04 -0400
Content-Disposition: inline
In-Reply-To: <20130924221409.GT9464@google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235323>

On Tue, Sep 24, 2013 at 03:14:09PM -0700, Jonathan Nieder wrote:
> Michael S. Tsirkin wrote:
> 
> > Subject: [PATCH] doc: don't claim that cherry-pick calls patch-id
> 
> s/cherry-pick/cherry/
> 
> > The id is already different for binary files.
> > Let's document that they are similar, not identical.
> 
> Thanks.
> 
> [...]
> > --- a/Documentation/git-cherry.txt
> > +++ b/Documentation/git-cherry.txt
> > @@ -13,12 +13,13 @@ SYNOPSIS
> >  DESCRIPTION
> >  -----------
> >  The changeset (or "diff") of each commit between the fork-point and <head>
> > -is compared against each commit between the fork-point and <upstream>.
> > +is compared against diff of each commit between the fork-point and <upstream>.
> 
> I think the old version of this sentence is clearer.
> 
> > -The commits are compared with their 'patch id', obtained from
> > -the 'git patch-id' program.
> > +The diffs are compared with their diff id (sha1) calculated after removing
> > +any whitespace and line numbers (similar but not necessarily identical
> > +to 'patch id', obtained from the 'git patch-id' program).
> 
> The hash used internally is just an implementation detail, so maybe this
> sentence could just be dropped?

I think the fact whitespace is ignored is relevant to users, no?
We probably should drop talking about hash here.

> >  Every commit that doesn't exist in the <upstream> branch
> > -has its id (sha1) reported, prefixed by a symbol.  The ones that have
> > +has its diff id (sha1) reported, prefixed by a symbol.  The ones that have
> 
> Confusingly, here 'id' means 'commit name'.  For example:
> 
>  $ git log --oneline -1 sb/repack-in-c
>  0b63c6a repack: improve warnings about failure of renaming and removing files
>  $ git cherry sb/repack-in-c^ sb/repack-in-c
>  + 0b63c6a5b78f3fdd8c4e4fed4e535e7f4eed4257
> 
> Hope that helps,
> Jonathan
