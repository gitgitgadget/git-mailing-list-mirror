From: Chris Webb <chris@arachsys.com>
Subject: Re: Editing the root commit
Date: Wed, 20 Jun 2012 20:39:23 +0100
Message-ID: <20120620193922.GB3192@arachsys.com>
References: <20120619091657.GA28005@arachsys.com>
 <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
 <20120619111709.GC10692@arachsys.com>
 <20120620093205.GB10579@arachsys.com>
 <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
 <20120620192938.GC31520@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:39:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQkd-0005Ud-P0
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757944Ab2FTTja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:39:30 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:59349 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab2FTTj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:39:27 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1ShQkO-0001Yc-9y; Wed, 20 Jun 2012 20:39:24 +0100
Content-Disposition: inline
In-Reply-To: <20120620192938.GC31520@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200343>

Jeff King <peff@peff.net> writes:

> But if the first commit is deleted (or reordered), then it is not
> appropriate to detach to the root; we must detach to the first picked
> commit, which we can only do after we see the final instruction sheet.

It's worse than that isn't it? If you have

  A -- B -- C

and the sheet says drop A, pick B, pick C, you can't detach to B. You want
the commit B as a root (i.e. with no parent), not the commit B with parent
A. You need to have the patch from A to B replayed as the first commit on an
empty branch (only without the branch).

Cheers,

Chris.
