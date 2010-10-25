From: Seth Robertson <in-git@baka.org>
Subject: Re: Are "private blobs/trees" possible?
Date: Mon, 25 Oct 2010 16:43:23 -0400
Message-ID: <201010252043.o9PKhN6I024622@no.baka.org>
References: <AANLkTimQ7Z9Cd2yKw5jFD6UBzFRBZk_-SpC7jc6+JACw@mail.gmail.com>
        <1288037406.819.93.camel@drew-northup.unet.maine.edu>
Cc: Kynn Jones <kynnjo@gmail.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Mon Oct 25 23:18:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAURE-0005rB-Sb
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 23:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979Ab0JYVSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 17:18:35 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:54025 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755420Ab0JYVSe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 17:18:34 -0400
X-Greylist: delayed 2081 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Oct 2010 17:18:34 EDT
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id o9PKhNMg007293
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 25 Oct 2010 16:43:24 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id o9PKhN6I024622;
	Mon, 25 Oct 2010 16:43:23 -0400
In-reply-to: <1288037406.819.93.camel@drew-northup.unet.maine.edu>
Comments: In reply to a message from "Drew Northup <drew.northup@maine.edu>" dated "Mon, 25 Oct 2010 16:10:05 -0400."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159971>


In message <1288037406.819.93.camel@drew-northup.unet.maine.edu>, Drew Northup
writes:

    On Mon, 2010-10-25 at 15:19 -0400, Kynn Jones wrote:
    > There are some files that I want to keep under local git
    > control, but never push to any remote repositories.

    > What's the best way to implement this idea with git?

    > The best solution I can think of is to put these files in some
    > git-controlled directory that is not below the "main" working
    > directory, and have an (ignored) symlink to it in this working
    > directory.

    > Is there a better way?

    There is no restriction that you only have one git repository on any
    given machine.... Set up your symlink to those files in their own git
    repository.

Depending on your proposed workflow (e.g. do you want to perform many
git operations such as commit, push, pull, tag, branch, etc) on the
public and private repositories at the same time even if they go
different places, a multi-repository management system like gitslave
(http://gitslave.sf.net) might work for you.  If you do not plan to
branch/tag your private repository along with the public repository or
do not have an "upstream" for your private repository, the symlink
approach is probably the best.

In either case, remember .git/info/exclude and git-config's
core.excludesfile for a way to privately ignore the symlink or
gitslave files.

					-Seth Robertson
