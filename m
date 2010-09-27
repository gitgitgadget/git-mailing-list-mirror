From: Jeff King <peff@peff.net>
Subject: Re: A sudden lack of permission
Date: Mon, 27 Sep 2010 12:07:59 -0400
Message-ID: <20100927160759.GB10256@sigill.intra.peff.net>
References: <4CA0AFC4.1060001@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ivan Uemlianin <ivan@llaisdy.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 18:08:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0GFX-00055G-UP
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 18:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759728Ab0I0QIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 12:08:04 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55191 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756812Ab0I0QID (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 12:08:03 -0400
Received: (qmail 17519 invoked by uid 111); 27 Sep 2010 16:08:02 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 27 Sep 2010 16:08:02 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Sep 2010 12:07:59 -0400
Content-Disposition: inline
In-Reply-To: <4CA0AFC4.1060001@llaisdy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157346>

On Mon, Sep 27, 2010 at 03:52:52PM +0100, Ivan Uemlianin wrote:

> I have been using git quite happily for a good while, pushing to my
> remote.  Suddenly this afternoon the remote told me I didn't have
> permission:
> 
>     $ git push
>     ivan@remote.org's password:
>     Counting objects: 19, done.
>     Delta compression using up to 2 threads.
>     Compressing objects: 100% (11/11), done.
>     Writing objects: 100% (11/11), 1.04 KiB, done.
>     Total 11 (delta 8), reused 0 (delta 0)
>     error: insufficient permission for adding an object to repository
> database ./objects
> 
>     fatal: failed to write object
>     error: unpack failed: unpack-objects abnormal exit
>     To ivan@remote.org:/var/www/git/my_repos.git
>      ! [remote rejected] master -> master (n/a (unpacker error))
>     error: failed to push some refs to
> 'ivan@remote.org:/var/www/git/my_repos.git'
> 
> I had sufficient permission even this morning!
> 
> Please could someone tell me what might have happened and, more
> importantly, how I can start pushing to the remote again?  The
> project in my_repos is large, so I'd rather not start a new repos
> from scratch.

Presumably the permissions on the server changed for some reason. Can
you ssh to the remote host and confirm that user "ivan" has permissions
to write to the repo's objects dir? If not, then you will have to figure
out what happened, but it is likely outside the scope of git (e.g., an
overly inclusive chmod by some cron job or admin on the box).

If you do have permissions, then we will have to dig deeper into why git
would fail, but the permissions would appear fine.

-Peff
