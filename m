From: Sam Vilain <sam@vilain.net>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Mon, 31 Mar 2008 09:19:10 +1300
Message-ID: <47EFF5BE.7030502@vilain.net>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com> <47EECF1F.60908@vilain.net> <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no> <47EFD253.6020105@vilain.net> <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Sun Mar 30 22:20:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg40l-0000q1-Pw
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 22:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbYC3UTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 16:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553AbYC3UTS
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 16:19:18 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:53347 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225AbYC3UTS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 16:19:18 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 5043521C97E; Mon, 31 Mar 2008 09:19:16 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 49CA521C97A;
	Mon, 31 Mar 2008 09:19:11 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78510>

Eyvind Bernhardsen wrote:
> Well, the point of "submodule push" was to avoid having to push in  
> each submodule manually; not enforcing the requirement that commits in  
> submodules must be publicly available before pushing from the main  
> module is a recipe for disaster, or at least annoyance.  And nobody  
> likes an annoying git.

ok.  so, refuse to push without forcing, don't do something dumb.

> Pushing to a branch works except that I couldn't figure out what to do  
> if the push doesn't succeed, ie, the branch has advanced on the remote  
> end.

It's simple.  You just fail and tell the user what happened, and let
them decide what to do.

> It's a reflog, not a branch, because a submodule can be changed to a  
> different branch, rewound, etc between commits in the main module;  
> there's no requirement that the old commit is in the new commit's  
> history.

If it is a rewind there is no issue, because you don't even need to push.

But again it comes back to - let the user sort it out, don't try to be
too clever.

Sam.
