From: Eric Wong <eric@petta-tech.com>
Subject: Re: [PATCH] git-svn: Minimalistic patch which allows svn usernames with space(s).
Date: Wed, 18 Jul 2007 00:36:29 -0700
Message-ID: <20070718073629.GB30559@muzzle>
References: <469CF641.4020707@st.com> <20070717195559.GA20103@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard MUSIL <richard.musil@st.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 09:36:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB45K-0002te-6D
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 09:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717AbXGRHgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 03:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755005AbXGRHga
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 03:36:30 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44284 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249AbXGRHga (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 03:36:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id B185F2DC08D;
	Wed, 18 Jul 2007 00:36:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070717195559.GA20103@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52840>

Eric Wong <eric@petta-tech.com> wrote:
> Richard MUSIL <richard.musil@st.com> wrote:
> > Changed filter for username in svn-authors file, so even 'user name' is accepted.
> > ---
> >  git-svn.perl |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 01c3904..975075e 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -740,7 +740,7 @@ sub load_authors {
> >         my $log = $cmd eq 'log';
> >         while (<$authors>) {
> >                 chomp;
> > -               next unless /^(\S+?|\(no author\))\s*=\s*(.+?)\s*<(.+)>\s*$/;
> > +               next unless /^(\.+?|\(no author\))\s*=\s*(.+?)\s*<(.+)>\s*$/;
> 
> Surely you mean the following:
> 
> +               next unless /^(.+?|\(no author\))\s*=\s*(.+?)\s*<(.+)>\s*$/;
> 
> (No "\" before the ".")   "\." matches a dot/period (.), while "."
> matches anything.

Fwiw, with the regexp corrected:
  Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
