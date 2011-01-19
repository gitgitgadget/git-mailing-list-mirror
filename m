From: Maaartin <grajcar1@seznam.cz>
Subject: Re: pushing to a remote branch that one does not own
Date: Wed, 19 Jan 2011 20:25:22 +0100
Message-ID: <4D373AA2.7000501@seznam.cz>
References: <1295461011273-5940751.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: iani <zannos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 20:25:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfdet-0002jJ-RC
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827Ab1ASTZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 14:25:23 -0500
Received: from cgc-instruments.com ([83.169.21.132]:37963 "EHLO
	lvps83-169-21-132.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753521Ab1ASTZX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jan 2011 14:25:23 -0500
Received: (qmail 26358 invoked from network); 19 Jan 2011 20:25:21 +0100
Received: from 188-120-198-113.luckynet.cz (HELO ?10.0.3.100?) (188.120.198.113)
  by cgc-instruments.com with SMTP; 19 Jan 2011 20:25:21 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1295461011273-5940751.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165280>

On 11-01-19 19:16, iani wrote:
>
> Hello,
> I want to contribute via "push" to a branch which I have previously cloned
> from a remote repository. There is a problem:
>
> If i create a new commit on branch "master", which coincides with
> origin/master, then I can push this commit simply with
>     git push
> However, if i switch to a different branch of the repository which was
> cloned, for example by doing:
>     git checkout origin/lilt
> Then I get the message:
> "You are in 'detached HEAD' state. You can look around, make experimental
> ... (etc)"
> So I HAVE to create my own new branch based on the one downloaded in order
> to start committing and pushing changes. My question is therefore:
>
> Am I strictly limited to committing only on the master / origin/master

AFAIK, there's nothing special about origin, except that it's already
set up to track origin/master.

You can't commit to origin/lilt just like you can't commit to
origin/master. Those remote branches are there to mirror corresponding
branches in the remote repo, so you can do things like
git diff master origin/master

> branched, and forced to make a new branch for every branch that I cloned
> from the remote repo, or is there a way of making the heads of the remote
> branches visible as local too?

AFAIK, using
git branch lilt origin/lilt
you create a local branch tracking the remote one. Then you can work
with it just like you work with master. You may want to have a look at
.git/config for [branch <branchname>] sections or not. I'm quite a
newbie, but this works for me.
