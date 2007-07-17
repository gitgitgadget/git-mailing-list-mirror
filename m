From: Eric Wong <eric@petta-tech.com>
Subject: Re: [PATCH] git-svn: Minimalistic patch which allows svn usernames with space(s).
Date: Tue, 17 Jul 2007 12:55:59 -0700
Message-ID: <20070717195559.GA20103@muzzle>
References: <469CF641.4020707@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard MUSIL <richard.musil@st.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 22:28:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAtet-0000qc-O0
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 22:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756531AbXGQU2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 16:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756409AbXGQU2d
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 16:28:33 -0400
Received: from hand.yhbt.net ([66.150.188.102]:43454 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754377AbXGQU2c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 16:28:32 -0400
X-Greylist: delayed 1951 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jul 2007 16:28:32 EDT
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 2713E2DC08D;
	Tue, 17 Jul 2007 12:56:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <469CF641.4020707@st.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52798>

Richard MUSIL <richard.musil@st.com> wrote:
> Changed filter for username in svn-authors file, so even 'user name' is accepted.
> ---
>  git-svn.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 01c3904..975075e 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -740,7 +740,7 @@ sub load_authors {
>         my $log = $cmd eq 'log';
>         while (<$authors>) {
>                 chomp;
> -               next unless /^(\S+?|\(no author\))\s*=\s*(.+?)\s*<(.+)>\s*$/;
> +               next unless /^(\.+?|\(no author\))\s*=\s*(.+?)\s*<(.+)>\s*$/;

Surely you mean the following:

+               next unless /^(.+?|\(no author\))\s*=\s*(.+?)\s*<(.+)>\s*$/;

(No "\" before the ".")   "\." matches a dot/period (.), while "."
matches anything.

-- 
Eric Wong
