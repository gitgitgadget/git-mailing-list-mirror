From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fast-export: Avoid dropping files from commits
Date: Thu, 26 Mar 2009 01:40:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903260138410.10279@pacific.mpi-cbg.de>
References: <1238014519-11683-1-git-send-email-newren@gmail.com>  <alpine.DEB.1.00.0903252312460.26370@intel-tinevez-2-302> <51419b2c0903251706n7cfa053eheff542d20ca9a753@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1070383192-1238028015=:10279"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 01:39:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmddE-0006Ng-8g
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 01:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067AbZCZAiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 20:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754426AbZCZAiK
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 20:38:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:38346 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753971AbZCZAiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 20:38:09 -0400
Received: (qmail invoked by alias); 26 Mar 2009 00:38:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 26 Mar 2009 01:38:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185ytw48CY5Ds2t+rtsrHSdaZDcMcQicBh5MIsGzY
	ZRFA14yzFZb9On
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <51419b2c0903251706n7cfa053eheff542d20ca9a753@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114696>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1070383192-1238028015=:10279
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 25 Mar 2009, Elijah Newren wrote:

> On Wed, Mar 25, 2009 at 4:13 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >> -     if (commit->parents) {
> >> +     if (commit->parents &&
> >> +         get_object_mark(&commit->parents->item->object) != 0) {
> >>               parse_commit(commit->parents->item);
> >>               diff_tree_sha1(commit->parents->item->tree->object.sha1,
> >>                              commit->tree->object.sha1, "", &rev->diffopt);
> >
> > I do not understand that change.
> >
> > A good explanation in the commit message might help this stupid 
> > developer.
> 
> I resent the patch in another email (sorry for the duplication, but I 
> don't trust gmail to preserve patches, and responding inline to comments 
> via git-send-email isn't so great either).  Let me know if the 
> explanation is missing anything, is too detailed, or is using incorrect 
> terminology.  In two cases I was sufficiently unsure about my wording 
> that I provided extra wording to try to make it clear what I was talking 
> about.

I am pretty tired, but I still have the impression that I understood it, 
so yes, I like it.

You might want to skip the != 0, though, as we avoid that in the rest of 
Git's source code, too.

Thanks,
Dscho

--8323328-1070383192-1238028015=:10279--
