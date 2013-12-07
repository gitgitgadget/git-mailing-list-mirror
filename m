From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: Re: git log --no-walk --tags produces strange result for certain user
Date: Sat, 7 Dec 2013 19:04:13 +0400
Message-ID: <01D3F259-94E1-4084-9210-34E2DB7B7545@jetbrains.com>
References: <5EE449B7-AB75-4EFF-85F9-292727FA1C53@jetbrains.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 07 16:04:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpJQV-0000w9-KB
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 16:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112Ab3LGPEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 10:04:11 -0500
Received: from mail1.intellij.net ([46.137.178.215]:57736 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796Ab3LGPEL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Dec 2013 10:04:11 -0500
Received: (qmail 28287 invoked by uid 89); 7 Dec 2013 15:04:08 -0000
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@81.3.129.2)
  by ip-10-62-119-91.eu-west-1.compute.internal with ESMTPA; 7 Dec 2013 15:04:08 -0000
In-Reply-To: <5EE449B7-AB75-4EFF-85F9-292727FA1C53@jetbrains.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238985>



Sorry for the duplication, but does anyone have an idea about this issue?

I'm worried because I've already received reports from 3 users, and I'm not sure if just skipping these "pseudo-tags" is a correct decision.

Thanks for any help!

-- Kirill.

On Dec 3, 2013, at 14:08 , Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com> wrote:

> Hey,
> 
> I use the following commands to receive the list of tags together with hashes the point to:
> 
>    git log --tags --no-walk --format=%H%d%x01 --decorate=full
> 
> Generally it works fine, however a user reported that for his repository this command returns the list containing several hashes without tag references. Something like this:
> 
>    05c9a3a6247698ff740ca3a79828456347afdcef (HEAD, tag: refs/tags/2.33, refs/remotes/origin/master, refs/remotes/origin/HEAD, refs/heads/master)
>    a7fda708d76d7f83d5a160b6b137b98b7677f771 (tag: refs/tags/2.44)
>    f119c2e7c69bb5ed1da5bae29c8754550ab96bde
>    07385a6ebe5a2e01e6ba9c8d0cb7b15c9a13f65d (tag: refs/tags/1.69)
> 
> Here third hash doesn't have a reference. There are 3 such hashes in his repository.
> 
> How can this happen? Is it a bug or some special scenario?
> 
> * I've already asked the user to execute `git tag --points-at` on these "suspiciously tagged" hashes: nothing was returned.
> * `git show --decorate=full` executed on these hashes return commit details, and no references on them.
> * From the log user sees that these hashes indicate some "normal" commits, nothing special at first glance.
> 
> Git version that he uses is 1.8.4.0.
> 
> Thanks!
> 
> -- Kirill.
