X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: latest update to git-svn blows up for me
Date: Mon, 4 Dec 2006 11:54:52 -0800
Message-ID: <20061204195452.GB27342@soma>
References: <863b7wnwcw.fsf@blue.stonehenge.com> <20061204070021.GG1369@localdomain> <86hcwbnb0o.fsf@blue.stonehenge.com> <20061204181241.GA27342@soma> <86zma3lahj.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 19:55:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <86zma3lahj.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33235>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrJtz-0002eo-Ki for gcvg-git@gmane.org; Mon, 04 Dec
 2006 20:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966209AbWLDTy4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 14:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965885AbWLDTy4
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 14:54:56 -0500
Received: from hand.yhbt.net ([66.150.188.102]:41982 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937357AbWLDTyy
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 14:54:54 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 3020B2DC034; Mon,  4 Dec 2006 11:54:52 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon,  4 Dec 2006
 11:54:52 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:
> 
> Eric> "Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >> >>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:
> >> 
> Eric> "Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >> >> 
> >> >> Does this ring a bell?
> >> 
> Eric> Nope.
> >> 
> Eric> This is on r15941 of  https://svn.perl.org/parrot/trunk ?  I can't seem
> Eric> to reproduce this with git svn fetch -r15940:15941
> >> 
> >> No, and that worked for me as well.  Apparently, I might have corrupted my
> >> metadata because I updated git-svn while I was using it.  Is there any way to
> >> reset the metadata without having to re-fetch 15000 revisions?
> 
> Eric> rm .git/refs/remotes/$GIT_SVN_ID .git/svn/$GIT_SVN_ID/.rev_db
> Eric> git svn -i $GIT_SVN_ID rebuild
> 
> That's not working:
> 
> localhost.local:..RROR/parrot-GITSVN % git-svn -i git-svn rebuild
> fatal: 'origin': unable to chdir or not a git archive
> fatal: unexpected EOF
> Failed to find remote refs
> 256 at /opt/git/bin/git-svn line 2151
>         main::safe_qx('git-ls-remote', 'origin', 'refs/remotes/git-svn') called at /opt/git/bin/git-svn line 3404
>         main::copy_remote_ref() called at /opt/git/bin/git-svn line 226
>         main::rebuild() called at /opt/git/bin/git-svn line 187

Can you try:

git update-ref refs/remotes/git-svn \
  <last commit successfully imported from git-svn>

and running rebuild again?

-- 
