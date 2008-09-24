From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Partial tree export and merging
Date: Wed, 24 Sep 2008 07:39:45 -0700
Message-ID: <20080924143945.GN3669@spearce.org>
References: <ACF330629DFB034AB290061C320F43460836E082@GOEMAILBE02.europe.mahr.lan> <48D9FACB.20901@mahr.de> <48DA476F.1070700@mahr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@mahr.de>
To: Heiko Voigt <heiko.voigt@mahr.de>
X-From: git-owner@vger.kernel.org Wed Sep 24 16:41:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiVY1-0004R9-O4
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 16:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbYIXOjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 10:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbYIXOjq
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 10:39:46 -0400
Received: from george.spearce.org ([209.20.77.23]:44642 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbYIXOjp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 10:39:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 485163835F; Wed, 24 Sep 2008 14:39:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48DA476F.1070700@mahr.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96636>

Heiko Voigt <heiko.voigt@mahr.de> wrote:
>
> I am currently facing a challenge for adding limited access to a git  
> repository for the i18n and documentation (language) team.
...
> To archieve this I would like to extract a repository that only contains  
> the documentation and localization files which can be used by the i8n  
> and doc team. This should be regularly merged into the development (with  
> code) repository.
>
> My idea of a solution would be to export patches only for the specific  
> files and import them into a seperate empty repository/branch using  
> git-format-patch and git-am. This seperate repository then itself then
> could be imported again with a normal merge operation. Has a anyone  
> already solved such a problem or other ideas how to solve this ?

See git-filter-branch.  You can use it to slice the history down
to only contain these files, but still show the full change history
of them (assuming that is what you are trying to get).

Once the history is split into a new "doc+html" repository have
developers _only_ edit the docs/html in the doc+html repository,
don't make more edits in the source code repository.

You can use git-submodule or git-merge with the subtree strategy
to pull changes from the doc+html repository into the main source
repository.

-- 
Shawn.
