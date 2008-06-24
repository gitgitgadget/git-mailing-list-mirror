From: "David Jeske" <jeske@google.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 10:42:04 -0000
Message-ID: <21109.6734311015$1214304662@news.gmane.org>
References: <willow-jeske-01l5oEsvFEDjCjRW>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5oEswFEDjCZBN>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 12:50:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB66u-0006JJ-Vk
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 12:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759457AbYFXKuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 06:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759412AbYFXKuA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 06:50:00 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60104 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759413AbYFXKt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 06:49:59 -0400
Received: (qmail 11957 invoked by uid 90); 24 Jun 2008 10:49:35 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Tue, 24 Jun 2008 10:42:04 -0000
In-Reply-To: <willow-jeske-01l5oEsvFEDjCjRW>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86032>

As a more practical question, how do I do this workflow illustrated below?

It's sort of similar to the workflow that "git stash" is trying to support,
except that I have a bunch of commits instead of a bunch of
uncommitted-changes.

I pull a repository that looks like this:

.  a<--b<--c  <--master

Then I hack away to this, and then throw my own branch on the end, along with
master:

.  a<--b<--c<--d<--e<--f<--g  <--master (jeske)
.                             <--feature1 (jeske)

While the server looks like this:

.  a<--b<--c<--1<--2<--3  <--master (server)

I want to get my repository to look something like this:

.  a<--b<--c<--1<--2<--3  <--master (jeske)
.           \
.            d<--e<--f<--g   <-- feature1 (jeske)

So I can then do this:

.  a<--b<--c<--1<--2<--3<--zz  <--master (jeske)
.           \
.            d<--e<--f<--g   <-- feature1 (jeske)

..and then push zz onto the server after 3.

..and I want to do it with safe commands that won't leave any dangling
references. (say if I forget to put the feature1 branch on)

How do I do that?
