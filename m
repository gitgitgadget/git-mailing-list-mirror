From: John Keeping <john@keeping.me.uk>
Subject: Re: git submodule ignores --git-dir
Date: Fri, 11 Sep 2015 16:28:07 +0100
Message-ID: <20150911152807.GA17201@serenity.lan>
References: <55F1E2AB.3020507@monetas.net>
 <55F2F028.7070505@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Filip Gospodinov <filip.gospodinov@monetas.net>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Sep 11 17:28:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaQFX-0000g5-NX
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 17:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbbIKP2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 11:28:23 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:33219 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbbIKP2X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 11:28:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9C7F8866033;
	Fri, 11 Sep 2015 16:28:22 +0100 (BST)
X-Quarantine-ID: <pnzOjQqc37T2>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pnzOjQqc37T2; Fri, 11 Sep 2015 16:28:19 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 793E5CDA61C;
	Fri, 11 Sep 2015 16:28:11 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <55F2F028.7070505@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277671>

On Fri, Sep 11, 2015 at 05:15:52PM +0200, Jens Lehmann wrote:
> Am 10.09.2015 um 22:06 schrieb Filip Gospodinov:
> > I know that for this particular use case I can just use `git clone --recursive`
> > and that other use cases can be worked around by using `cd`. Still, I wonder if
> > the behavior I discovered is a bug or if it's expected.
> 
> I don't think this is a bug. The git submodule command needs a work tree
> to read the .gitmodules file from, that's while it fails when using
> --git-dir from outside the work tree. But I admit that the error message
> "No submodule mapping found in .gitmodules for path ..." could be improved
> to clearly state that the .gitmodules file wasn't found.
> 
> Unfortunately trying to show git the right work tree:
> 
> $ git --git-dir=$PWD/repo2/.git --work-tree=$PWD/repo2 submodule update --init
> 
> Didn't work as I expected it to either:
> 
> fatal: /home/Sledge/libexec/git-core/git-submodule cannot be used without a working tree.
> 
> So you'll have to cd into the repo for now.

There's also "git -C /path/to/repo" which avoids the need for a separate
"cd".
