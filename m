From: Jeff King <peff@peff.net>
Subject: Re: [bug] git-clone over ssh fails when repository has local
	commits
Date: Sun, 6 Apr 2008 12:11:20 -0400
Message-ID: <20080406161120.GB24358@coredump.intra.peff.net>
References: <1caff7430804060645s764f24f8y3d07ee8647ec8f25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: seventh guardian <seventhguardian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 18:12:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiXTS-00028Q-3t
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 18:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbYDFQLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 12:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbYDFQLW
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 12:11:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4993 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013AbYDFQLW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 12:11:22 -0400
Received: (qmail 26828 invoked by uid 111); 6 Apr 2008 16:11:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 06 Apr 2008 12:11:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Apr 2008 12:11:20 -0400
Content-Disposition: inline
In-Reply-To: <1caff7430804060645s764f24f8y3d07ee8647ec8f25@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78896>

On Sun, Apr 06, 2008 at 02:45:22PM +0100, seventh guardian wrote:

>  $ git-clone ssh://<host>/<path>
> Initialized empty Git repository in <path>/.git/
> Password:
> remote: Counting objects: 132468, done.
> remote: Compressing objects: 100% (25543/25543), done.
> remote: Total 132468 (delta 107355), reused 130574 (delta 105466)
> Receiving objects: 100% (132468/132468), 42.12 MiB | 4161 KiB/s, done.
> Resolving deltas: 100% (107355/107355), done.
> error: Trying to write ref REMOTE_HEAD with nonexistant object
> f7a51afd56964cb0f10178353315d2680832ea54
> fatal: Cannot update the ref 'REMOTE_HEAD'.
> Warning: Remote HEAD refers to nonexistent ref, unable to checkout.

It sounds like your remote repository has a bogus HEAD that points to a
non-existent object. Can you ssh to <host> and confirm that you can do a
"git show HEAD" in the remote repo?

-Peff
