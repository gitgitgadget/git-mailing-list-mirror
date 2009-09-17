From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 3/4] reset: add option "--merge-safe" to "git reset"
Date: Thu, 17 Sep 2009 09:24:15 +0200
Message-ID: <4AB1E41F.6050304@viscovery.net>
References: <20090917040835.4048.51057.chriscool@tuxfamily.org> <20090917041440.4048.16353.chriscool@tuxfamily.org> <7vk4zykv7o.fsf@alter.siamese.dyndns.org> <4AB1D957.20902@viscovery.net> <7vr5u6jbgk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Sep 17 09:24:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoBM4-0002HH-3U
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 09:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759073AbZIQHYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 03:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758794AbZIQHYP
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 03:24:15 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:45514 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758202AbZIQHYO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 03:24:14 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MoBLk-0002cL-AX; Thu, 17 Sep 2009 09:24:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0D500BC81; Thu, 17 Sep 2009 09:24:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vr5u6jbgk.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128722>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>> Junio C Hamano schrieb:
>> (2) The intended use-case of --merge-safe is to point the branch head to a
>> different commit, but to carry the changes that currently are in the index
>> and wd over to the new commit, similar to checkout --merge.

This is actually an operation that I need quite often, but I can do it
only by way of git stash.

Clarification: I did not say that I actually meant to carry *only* the
index and wd changes to the new commit. That is, the operation I have in
mind can roughly be done in terms of

  $ git stash
  $ git reset --hard $target
  $ git stash pop

> I have _no_ idea what the intended use-case of --merge-safe is, and that
> was why I asked Christian for clarification in the previous round.  The
> answer was still not clear enough so I pointed out --merge-safe could be
> still doing a wrong thing even in _his_ use-case.

Reading Christian in 200909170554.49416.chriscool@tuxfamily.org, I think
this *is* his use-case? Christian?

-- Hannes
