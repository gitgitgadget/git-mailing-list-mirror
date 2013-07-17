From: John Keeping <john@keeping.me.uk>
Subject: Re: Git counterpart to SVN bugtraq properties?
Date: Wed, 17 Jul 2013 14:33:57 +0100
Message-ID: <20130717133357.GB2337@serenity.lan>
References: <51E69612.6020201@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 15:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzRrw-0000Rx-Vu
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 15:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313Ab3GQNeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 09:34:08 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:49965 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831Ab3GQNeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 09:34:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 259251980DF;
	Wed, 17 Jul 2013 14:34:07 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yERDyDIMQgUF; Wed, 17 Jul 2013 14:34:04 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 2E5B96064C7;
	Wed, 17 Jul 2013 14:34:00 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <51E69612.6020201@syntevo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230624>

On Wed, Jul 17, 2013 at 03:03:14PM +0200, Marc Strapetz wrote:
> I'm looking for a specification or guidelines on how a Git client should
> integrate with bug tracking systems. For SVN, one can use
> bugtraq-properties [1] to specify e.g. the issue tracker URL or how to
> parse the bug ID from a commit message. AFAIU, there is nothing
> comparable for Git [2]? If that's actually the case, is someone
> interested in working out a similar specification for Git?
> 
> [1] http://code.google.com/p/tortoisesvn/source/browse/tags/version_1.2.0/doc/issuetrackers.txt
> 
> [2] http://stackoverflow.com/questions/17545548

The Git way to record the issue ID as a footer in the commit message.
See for example [1].  Although I'm not aware of any standard for naming
this footer.

In terms of recording the URL and other data, I think you'd want a
dotfile in the repository (perhaps .bugzilla).  This shoudld probably be
in the gitconfig format, like .gitmodules.

I think "all" it needs is to draw up a spec for the names of keys and
format of their values, along with the format of footer(s) identifying
issues associated with a commit and to persuade UI developers to support
it... ;-)

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4a88f73f14f6d6c94616538427e1235a6d0a5885
