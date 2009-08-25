From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: rebase hint unmerged file removed
Date: Tue, 25 Aug 2009 09:35:49 +0200
Message-ID: <4A939455.5030908@viscovery.net>
References: <20090824140549.GA3973@debian.b2j> <4A92A6E6.5060702@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 09:36:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfqZU-0004rz-35
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 09:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbZHYHfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 03:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbZHYHft
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 03:35:49 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:2435 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbZHYHft (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 03:35:49 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MfqZK-0002Gq-5N; Tue, 25 Aug 2009 09:35:50 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E22BE4E4; Tue, 25 Aug 2009 09:35:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A92A6E6.5060702@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127013>

Johannes Sixt schrieb:
> Rebase -i emitted used to write merge-recursive's conflict hints that said
> "modify/delete", "modify/rename", "content", etc. I think that's what you
> were looking for. But these hints have vanished since quite some time now.
> I haven't taken the time, yet, to track down when this happened and why.

Ok, I bisected it to 6eb1b437 (cherry-pick/revert: make direct internal
call to merge_tree(), 2008-09-02), which is part of a series around
merge-recursive: 1ad6d46..ed520a8

The commit message says: "One regression is that the status message is
lost as there is no way to flush them from outside the refactored library
code yet." But is it intentional that these messages were never recovered?

BTW, I miss the messages a lot, too, but I'm unfamiliar with the code in
question to try to do something about it.

-- Hannes
