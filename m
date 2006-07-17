From: "Post, Mark K" <mark.post@eds.com>
Subject: RE: git-repack not removing files from $GIT_DIR/objects/[00-ff]
Date: Sun, 16 Jul 2006 21:47:37 -0400
Message-ID: <5A14AF34CFF8AD44A44891F7C9FF410507E43006@usahm236.amer.corp.eds.com>
References: <20060717012154.GA27389@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 17 03:48:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2IDe-0002Qi-DR
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 03:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWGQBsI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 21:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWGQBsH
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 21:48:07 -0400
Received: from ahmler5.mail.eds.com ([192.85.154.70]:18902 "EHLO
	ahmler5.mail.eds.com") by vger.kernel.org with ESMTP
	id S1751198AbWGQBsG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Jul 2006 21:48:06 -0400
Received: from ahmlir3.mail.eds.com (ahmlir3-2.mail.eds.com [192.85.154.133])
	by ahmler5.mail.eds.com (8.13.7/8.12.10) with ESMTP id k6H1m2dM007364;
	Sun, 16 Jul 2006 21:48:03 -0400
Received: from ahmlir3.mail.eds.com (localhost [127.0.0.1])
	by ahmlir3.mail.eds.com (8.13.7/8.12.10) with ESMTP id k6H1ldBG004517;
	Sun, 16 Jul 2006 21:47:39 -0400
Received: from usahm011.amer.corp.eds.com ([130.175.214.152])
	by ahmlir3.mail.eds.com (8.13.7/8.12.10) with ESMTP id k6H1ldqU004512;
	Sun, 16 Jul 2006 21:47:39 -0400
Received: from usahm236.amer.corp.eds.com ([130.175.214.169]) by usahm011.amer.corp.eds.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 16 Jul 2006 21:47:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20060717012154.GA27389@spearce.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-repack not removing files from $GIT_DIR/objects/[00-ff]
thread-index: AcapP4x410aQPnxVTI+ecUb3EZdnnQAA0PBA
To: <spearce@spearce.org>
X-OriginalArrivalTime: 17 Jul 2006 01:47:39.0282 (UTC) FILETIME=[FC523720:01C6A942]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23960>

Thanks for the suggestion, but it didn't help.  One reason is that this
is a bare repository.  When I ran the command, it aborted with "fatal:
Not a git repository."  Most likely because bare repositories don't have
a .git directory in them.


Mark Post 

-----Original Message-----
From: spearce@spearce.org [mailto:spearce@spearce.org] 
Sent: Sunday, July 16, 2006 9:22 PM
To: Post, Mark K
Cc: git@vger.kernel.org
Subject: Re: git-repack not removing files from $GIT_DIR/objects/[00-ff]

"Post, Mark K" <mark.post@eds.com> wrote:
> I'm having a problem that just started occurring with git-repack not
> removing the files from $GIT_DIR/objects/*, and therefore not removing
> the directories, since they're not empty.  The command I'm using (as
the
> git user) is this:
> GIT_DIR=/home/git/pub/scm/linux-2.6.git git-repack -a -d -l
> 
> This used to work, but then suddenly stopped working.  I ran an strace
> -f -F with this same command, and I don't see any attempt being made
to
> unlink the files in $GIT_DIR/objects/*/, but I do see the rmdir
commands
> failing because the directories are not empty.  All of the files in
> those directories are owned by git:git.

Try running `git-prune-packed` after git-repack.  git-repack doesn't
delete the loose objects.

I don't remember git-repack ever doing it either.

-- 
Shawn.
