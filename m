From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: What's cooking in git.git (Oct 2008, #03; Tue, 14)
Date: Sat, 18 Oct 2008 22:12:47 +0200
Message-ID: <200810182212.47166.johannes.sixt@telecom.at>
References: <7v8wsq7rt5.fsf@gitster.siamese.dyndns.org> <48F5AB87.4080409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 22:14:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrIBW-0008QJ-S6
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 22:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbYJRUMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 16:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbYJRUMu
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 16:12:50 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:43074 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbYJRUMt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 16:12:49 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 32AE2BEEF9;
	Sat, 18 Oct 2008 22:12:47 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9BBB61D167;
	Sat, 18 Oct 2008 22:12:47 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <48F5AB87.4080409@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98567>

On Mittwoch, 15. Oktober 2008, Johannes Sixt wrote:
> Junio C Hamano schrieb:
> > * pb/rename-rowin32 (Sun Oct 12 21:01:23 2008 -0700) 2 commits
> >  - (squash): index-pack: do not unconditionally make packfile read-
> >    only
> >  - Do not rename read-only files during a push
> >
> > Supposedly fixes pack file renames on Windows.  The (squash) patch is my
> > attempt to fix its breakage.
>
> I'm afraid I can't reproduce the problem that the commit message
> describes.

On a different system I was able to reproduce the problem, and this patch 
fixes it.

I tried to fix the breakage in the compat layer, but the result was too 
fragile (change the source to read-write before that operation, change to 
read-only afterwards), and this patch (including your fixup) looks much 
cleaner.

-- Hannes
