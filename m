From: Mike Hommey <mh@glandium.org>
Subject: Re: Dose git-fetch need --reference option like git-clone?
Date: Sun, 11 Nov 2007 09:38:40 +0100
Organization: glandium.org
Message-ID: <20071111083840.GA17231@glandium.org>
References: <46dff0320711110009y713c7d38q7b1457c92daecef6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yin Ping <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:39:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir8M7-0005cE-TI
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbXKKIjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 03:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753060AbXKKIjd
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:39:33 -0500
Received: from vawad.err.no ([85.19.200.177]:59613 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752494AbXKKIjc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:39:32 -0500
Received: from aputeaux-153-1-97-92.w86-217.abo.wanadoo.fr ([86.217.119.92] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1Ir8Lo-0002qK-1s; Sun, 11 Nov 2007 09:39:30 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1Ir8L2-0004WX-Vd; Sun, 11 Nov 2007 09:38:41 +0100
Content-Disposition: inline
In-Reply-To: <46dff0320711110009y713c7d38q7b1457c92daecef6@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64430>

On Sun, Nov 11, 2007 at 04:09:55PM +0800, Yin Ping wrote:
> I want to track remote repsotory (say remoteA) on my local repository
> (say localB), so i do the following in directory localB
> $ git remote add remoteA git://remoteAUrl
> $ git fetch remoteA
> This will fetch all objects from git://remoteAUrl if localB and
> remoteA don't have common objects.
> 
> If I already have a cloned remoteA on local machine (say
> /path/to/remoteACloned), I want to do following to reduce the net
> traffic as git-clone:
> git fetch --reference /path/to/remoteACloned remotedA
> 
> Is this reasonable? Or is there already a resolution for this case?

It would probably be reasonable to have this on git-remote. Anyways, you
can easily do it yourself by editing .git/objects/info/alternates and
adding /path/to/remoteACloned in it. You can happily git fetch after
that.

Mike
