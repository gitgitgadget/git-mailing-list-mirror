From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: how to use two bare repositories?
Date: Sat, 12 Apr 2008 00:23:37 +0100
Message-ID: <20080411232337.GO29940@cs-wsok.swansea.ac.uk>
References: <20080411222205.GN29940@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 01:24:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkSba-0002k8-1H
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 01:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758792AbYDKXXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 19:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758704AbYDKXXk
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 19:23:40 -0400
Received: from mhs.swan.ac.uk ([137.44.1.33]:45242 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758593AbYDKXXj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 19:23:39 -0400
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.69)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1JkSao-0004SA-0I; Sat, 12 Apr 2008 00:23:38 +0100
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id E3B4EDAE20;
	Sat, 12 Apr 2008 00:23:37 +0100 (BST)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 8CB6C741BB; Sat, 12 Apr 2008 00:23:37 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20080411222205.GN29940@cs-wsok.swansea.ac.uk>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79311>

Just adding a further question:

Apparently bare repositories are strange things,
which perhaps are not really supported by git.
Alright, then I use additionally a real repository C.

Now in the automated process of package generation,
the user of my library gets always a clone of C,
created by

git clone --no-hardlinks path-to-C

However having the origin C built into that clone
is not really useful, since no user has access to C.
The natural think to do would be to use instead

git clone --no-hardlinks --origin http:address-of-B path-to-C

but unfortunately 

git complains that "http:address-of-B" is not suitable
as an origin??

However "http:address-of-B" works for pull ?

If option "origin" doesn't work, how else is it possible
to provide the package-clone with a sensible default value
for the pull-operation (this can only be B here)?

Oliver


On Fri, Apr 11, 2008 at 11:22:05PM +0100, Oliver Kullmann wrote:
> Hi,
> 
> I have the following problem:
> 
> We use a public repository, a bare repository A,
> used with push and pull via ssh.
> A is only to be used by the core developer group.
> 
> Now I want to create another public repository B,
> from which anonymous pull is possible via http.
> So B should be another bare repository.
> 
> The problem is now that it seems not to be possible
> to update B:
> 
> 1. pulling from A is not possible since B is bare;
> 2. fetching from A seems to work, checking the content of
>    B via gitk seems to indicate that B has been updated
>  --- however pulling from B doesn't work: The newly
>  fetched changes are not transported to a repository
>  which pulls from B ???
> 
> Hope somebody can shed light on this behaviour.
> 
> Thanks!
> 
> Oliver
> 
> --
