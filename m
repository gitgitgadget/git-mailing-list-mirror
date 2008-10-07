From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: error pushing stash ?
Date: Mon, 6 Oct 2008 17:40:51 -0700
Message-ID: <20081007004051.GA18889@spearce.org>
References: <20081007003435.GZ5774@eratosthenes.cryptobackpack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Bryson <david@statichacks.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 02:42:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn0eP-0007bD-8T
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 02:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbYJGAkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 20:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753443AbYJGAkx
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 20:40:53 -0400
Received: from george.spearce.org ([209.20.77.23]:46621 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbYJGAkw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 20:40:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EA0C03835F; Tue,  7 Oct 2008 00:40:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081007003435.GZ5774@eratosthenes.cryptobackpack.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97648>

David Bryson <david@statichacks.org> wrote:
> [remote "backup"]
...
>     mirror = 1
> 
> Only to find some odd error messages:
> 
> $ git push backup
> Counting objects: 133, done.
> Compressing objects: 100% (109/109), done.
> Writing objects: 100% (109/109), 31.25 KiB, done.
> Total 109 (delta 82), reused 0 (delta 0)
> error: refusing to create funny ref 'refs/stash' remotely
> To /users/dbryson/backup/janus.git/
>    549f8a4..8e93d51  8654 -> 8654
>    ef6195b..549f8a4  origin/8654 -> origin/8654
>  + 623e7cb...63d7262 origin/master -> origin/master (forced update)
>  ! [remote rejected] refs/stash -> refs/stash (funny refname)
> error: failed to push some refs to '/users/dbryson/backup/janus.git/'

refs/stash is a funny refname because it contains only 1 '/'.
Normally a valid ref has at least 2 '/', e.g. refs/heads/8654 or
refs/tags/v1.0.

Naming the stash refs/stash was perhaps funny in the first place
since it cannot be moved about on the transport protocol, but then
again the bulk of the stash data is actually in the reflog for the
stash (and not the stash ref itself) so there is basically no point
in pushing or fetching a stash directly.

-- 
Shawn.
