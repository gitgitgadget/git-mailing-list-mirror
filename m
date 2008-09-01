From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 00/12] Towards a better merge resolution support
Date: Mon, 1 Sep 2008 11:44:12 +0200
Message-ID: <20080901094412.GB3993@blimp.local>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 11:45:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka5yN-0000Q9-Fa
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 11:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbYIAJoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 05:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754575AbYIAJoP
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 05:44:15 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:62772 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbYIAJoP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 05:44:15 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20lf4ka7
Received: from tigra.home (Fab22.f.strato-dslnet.de [195.4.171.34])
	by post.webmailer.de (fruni mo55) (RZmta 16.47)
	with ESMTP id y00f9dk819NWb1 ; Mon, 1 Sep 2008 11:44:13 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 0DFA9277AE;
	Mon,  1 Sep 2008 11:44:13 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id F3CF736D1D; Mon,  1 Sep 2008 11:44:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220056963-2352-1-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94552>

Junio C Hamano, Sat, Aug 30, 2008 02:42:31 +0200:
> This consists of two loosely related topics on improving conflicted merge
> resolution support.
> 
> The early part of the series is what you already saw.  In addition to
> recording a conflicted merge in the RCS merge style we have traditionally
> used, this allows you to optionally use "diff3 -m" style.  The difference
> is that the latter format shows the part from the common ancestor that
> corresponds to the parts both sides modified to cause the conflict, in
> addition to the changes done on each side.  This can be chosen by setting
> a configuration variable.  Rerere mechanism is updated to understand this
> new format as well, and conflicts from either formats interoperate well,
> because rerere mechanism only records and uses the changes made on each
> side, not what was in the common ancestor.

This reminds me: when resolving a conflict in a git repo (when trying
something from next or pu), I often notice that I'd like to resolve it
the same way it was done on next or pu. IOW, copy the commit
resolution from some other merge commit. Maybe can be a way to use
rerere mechanism with that?
