From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: git merge --squash isn't "marked as a merge"??
Date: Tue, 29 Jul 2008 09:49:29 +0200
Message-ID: <488ECB89.5060801@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 09:50:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNjyi-00030G-Il
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 09:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbYG2Hti convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2008 03:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753277AbYG2Hti
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 03:49:38 -0400
Received: from morch.com ([193.58.255.207]:36129 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245AbYG2Hth (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 03:49:37 -0400
Received: from [192.168.1.214] (ANice-157-1-60-153.w90-36.abo.wanadoo.fr [90.36.75.153])
	by morch.com (Postfix) with ESMTP id AF2B5277D
	for <git@vger.kernel.org>; Tue, 29 Jul 2008 09:51:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90595>

Newbie alert:

I have a feature branch where I have N tiny commits with sloppy/private
commit messages. Being able to have private commits was the main reason=
=20
I'm using git (as a frontend to svn).

Today the feature is in a "good" state, and I want to merge it into a=20
main branch, showing a single commit with a well phrased message for al=
l=20
the world to see. So I:

$ git checkout master
$ git merge --squash feature
$ git commit -F wellphrased.msg

Now I was expecting that:
$ git merge feature
would do nothing (I already did a merge!). But it pulls in all the
sloppy commits and messages from "feature"!

Of course now I could continue with a new branch made like this:
$ git checkout -b feature2 master
and continue working privately on feature2 again. Then I'll end up with
feature..feature47 before I'm done. Each with its own segment of my=20
private history. A real mess.

Can I continue on feature somehow so I privately can "git log" and
see all my messy commits (both before and after the "git merge
--squash") and then regularly "git merge" and/or "git merge --squash"
back and forth between "feature" and "master" as I deem appropriate?

I'm guessing that if the --squash *did* put in a "merge arrow" (setting
a "parent" of the commit to the head of feature) thereby allowing merge
to not do anything, then git log would also follow feature's sloppy
history too. They go together as a pair. Is that right? Testing this:

git help merge says about --squash:
> Produce the working tree and index state as if a real merge happened,
> but do not actually make a commit or move the HEAD, nor record
> $GIT_DIR/MERGE_HEAD to cause the next git commit command to create a
> merge commit.

So I tried "git merge --squash feature", then set up .git/MERGE_HEAD to=
=20
the same contents as .git/refs/heads/feature and then "git commit". Thi=
s=20
produced the same result as "git merge" without --squash including all=20
the sloppy messages.

SO: It seems to me I cannot continuously merge "feature" to "master" in=
=20
chunks with "--squash" as I would like. Is that right? Is my desire=20
fundamentally misguided, and is there A Better Way?

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
