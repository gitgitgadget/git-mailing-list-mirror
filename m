From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-add,& "file vanishing" -> need git-add again
Date: Fri, 22 Dec 2006 09:27:23 +1300
Message-ID: <46a038f90612211227v2f1325e5i96ca6f773eb05def@mail.gmail.com>
References: <20061221141335.65170.qmail@web86902.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 21:27:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxUVs-0006aI-R4
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 21:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423074AbWLUU1Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 15:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423076AbWLUU1Z
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 15:27:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:60982 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423074AbWLUU1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 15:27:24 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2489822wxd
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 12:27:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lSgABVCMdRZxYG1s/J9NoOdwoCbOQQdYxVS49ieDfKl4yX1x8Qdnzy599GigL2l9aOAgGOdVBwhmtI1JeWm0MxGKRLZRVAEIea1edtT1ZoaItU/DO9PEYKH9pkzhqF6amSbEq9e42AQyeaAje95E+CwDvme8+wqnB8OgAK9WbS8=
Received: by 10.90.50.1 with SMTP id x1mr8915184agx.1166732843678;
        Thu, 21 Dec 2006 12:27:23 -0800 (PST)
Received: by 10.90.96.19 with HTTP; Thu, 21 Dec 2006 12:27:23 -0800 (PST)
To: "David Tweed" <tweed314@yahoo.co.uk>
In-Reply-To: <20061221141335.65170.qmail@web86902.mail.ukl.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35084>

On 12/22/06, David Tweed <tweed314@yahoo.co.uk> wrote:
> Sidenote: I'm moving the database from the old format to the new one by repeatedly unpacking
> the old database for snapshot X, git-add'ing any file names which have _never_ been in any snapshot
> before, git-commit -a, git-tag, then remove all the files unpacked by the
> old database and move onto snapshot X+1. This takes less than a second per snapshot.

Not sure how large your snapshots are -- a second sounds like a long
time for git operations. While it is a bit more complex, you _can_
operate directly on the index, and the "snapshot" never needs to hit
the disk as such during your migration.

Have a look at how the cvsimport script works for an example.

cheers.


martin
