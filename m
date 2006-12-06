X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 06 Dec 2006 22:51:13 +0100
Organization: At home
Message-ID: <el7dsn$9a6$1@sea.gmane.org>
References: <7vvekoyb79.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 6 Dec 2006 21:49:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 98
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33526>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs4eD-0005FI-Oj for gcvg-git@gmane.org; Wed, 06 Dec
 2006 22:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937676AbWLFVtq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 16:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937681AbWLFVtq
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 16:49:46 -0500
Received: from main.gmane.org ([80.91.229.2]:51245 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937676AbWLFVtq
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 16:49:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gs4dz-0000ax-8k for git@vger.kernel.org; Wed, 06 Dec 2006 22:49:35 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 22:49:35 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 22:49:35 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Here is a list of topics that are cooking; the commits marked
> with '+' are in 'next', '-' are in 'pu'.  Dates are when the
> topic was last touched [*1*].
> 
> ----------------------------------------------------------------

> * jc/3way (Wed Nov 29 18:53:13 2006 -0800)
>  + git-merge: preserve and merge local changes when doing fast forward
> 
>  This allows you to run a 'git merge' (or 'git pull') that
>  results in a fast-forward merge that updates a path your
>  working tree has modified locally; it merges your local changes
>  into the updated version, in the same way the branch switching
>  'git checkout -m' works.  It has been in next for some time and
>  unless we hear somebody scream I think it is Ok to merge to
>  'master'.

Very nice. Less suprises for CVS users (with "update then commit"
mentality/habits).
  
> * jc/explain (Mon Dec 4 19:35:04 2006 -0800)
>  - git-explain
> 
>  This was just a discussion starter.  I tried to reuse existing
>  status markers various existing command leaves, but it might be
>  a good idea to invent a unified status marker to help 'git
>  explain' (or 'git wtf') command, so that everybody can write
>  into the same file and 'explain' has to know only about that
>  file.  I dunno.

I think it would be nice to have... but as it is very fresh
it probably should cook for a while in next.
 
> * jc/leftright (Sun Oct 22 17:32:47 2006 -0700)
>  - rev-list --left-right.
> 
>  When reviewing "git log --merge" I often wish which side each
>  of the commits comes from, and this is to achieve that.  I
>  haven't met with an enthusiastic support for it, though.
>  Perhaps people do not find need for that, or do not do
>  complicated merges, or have other tools that I do not regularly
>  use that is better than this approach; in which case I should
>  probably drop this.

Looks nice, as an alternative to git-cherry-pick (which sometimes
doesn't do - because it cannot - it's work).
 
> * jc/web (Wed Nov 8 14:54:09 2006 -0800)
>  - gitweb: steal loadavg throttle from kernel.org

Is having loadavg in gitweb, and not configured in server good idea?
What next, log generation in gitweb? Just kidding.
 
> * js/merge (Wed Dec 6 16:45:42 2006 +0100)
>  + merge-file: support -p and -q; fix compile warnings
>  + Add builtin merge-file, a minimal replacement for RCS merge
>  + xdl_merge(): fix and simplify conflict handling
>  + xdl_merge(): fix thinko
>  + xdl_merge(): fix an off-by-one bug
>  + merge-recursive: use xdl_merge().
>  + xmerge: make return value from xdl_merge() more usable.
>  + xdiff: add xdl_merge()
> 
>  merge-recursive that does not rely on RCS "merge".  I use this
>  exclusively these days.  Perhaps cook a little further and
>  merge to 'master'.

Very nice, especially with zealous (tight) merge conflicts.

> * lh/branch-rename (Thu Nov 30 03:16:56 2006 +0100)
>  + git-branch: let caller specify logmsg
>  + rename_ref: use lstat(2) when testing for symlink
>  + git-branch: add options and tests for branch renaming
> 
>  I do not rename branches myself and do not see a need for this
>  nor I have tested it in real-world setting.  The code seemed
>  clean and may be 'master' material.

I'd like to have this, but it MUST work well with reflogs for me.
 
> [Footnote]
> 
> *1* I am trying out an alternative to short-log.  I think the
> above format is easier to see what is going on than separate
> short-log for 'next' and 'pu'.  It is based on the "TO" script
> found in 'todo' branch but hand edited.

It looks and reads better. I usually read only description,
as shortlog is not that useful unless you are interested in
given topic. At least for me.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

