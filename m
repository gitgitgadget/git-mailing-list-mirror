From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-rev-parse(1) questions
Date: Mon, 30 Apr 2007 20:51:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704302036520.29859@racer.site>
References: <mz0pwwi3.fsf@cante.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 20:52:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hiaz6-0005Sc-Ds
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 20:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946624AbXD3SwD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 14:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946592AbXD3SwB
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 14:52:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:60896 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1946625AbXD3Sv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 14:51:59 -0400
Received: (qmail invoked by alias); 30 Apr 2007 18:51:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 30 Apr 2007 20:51:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hWVdFhQMh1a6a89SjrfSTlLYhbOw8WH2IMQLpWC
	wIu6by2e5803Yq
X-X-Sender: gene099@racer.site
In-Reply-To: <mz0pwwi3.fsf@cante.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45875>

Hi,

On Mon, 30 Apr 2007, Jari Aalto wrote:

> Could someone provide example commands where and how to use these:
> 
>     * A suffix ^ followed by an empty brace pair (e.g. v0.99.8^{})
>       means the object could be a tag, and dereference the tag
>       recursively until a non-tag object is found.

You can get at the _commit_ tagged with version 1.0.0 by doing "git 
rev-parse v1.0.0^{}" (as opposed to the tag object).

>     * A colon, optionally followed by a stage number (0 to 3) and a
>       colon, followed by a path; this names a blob object in the index
>       at the given path. Missing stage number (and the colon that
>       follows it) names an stage 0 entry.

You can see that at best when you have a conflicted merge. For example, if 
"git ls-files --unmerged" says that "README" is unmerged, "git show 
:1:README" will show _your_ original version, while "git show :2:README" 
will show the to-be-merged version.

Hth,
Dscho
