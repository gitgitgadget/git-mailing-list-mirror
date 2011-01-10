From: Ingo Br=?ISO-8859-1?Q?=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH] Fix wrong failures in config test
Date: Mon, 10 Jan 2011 18:15:22 +0100
Message-ID: <4d2b3ecd.7c62abb5.bm000@wupperonline.de>
References: <20110110165251.GB7714@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 10 18:16:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcLMA-0004UX-VX
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 18:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab1AJRQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 12:16:32 -0500
Received: from smtp-a.tal.de ([81.92.1.9]:54698 "EHLO smtp-a.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754391Ab1AJRQc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 12:16:32 -0500
Received: from point.localnet (mue-88-130-97-192.dsl.tropolys.de [88.130.97.192])
	(Authenticated sender: ib@wtal.de)
	by smtp-a.tal.de (Postfix) with ESMTP id E8E7A111C2C0
	for <git@vger.kernel.org>; Mon, 10 Jan 2011 18:16:29 +0100 (CET)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1PcLM4-5jI-00 for <git@vger.kernel.org>; Mon, 10 Jan 2011 18:16:28 +0100
In-Reply-To: <20110110165251.GB7714@burratino>
X-Mailer: blueMail/Linux 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164885>

Jonathan Nieder wrote on Mon, 10 Jan 2011 10:52:51 -0600:

> Could you explain the nature of the failures in more detail?

Yeah, sorry.

> What version of git are you building?

1.7.3.5

> Is GIT_CONFIG already set in the environment before you run
> t1300-repo-config.sh (it shouldn't matter)?

No.

> How does output from "sh t1300-repo-config.sh -v -i" end?

  expecting success: git config --rename-section branch.eins branch.zwei
  fatal: No such section!
  not ok - 50 rename section
  #       git config --rename-section branch.eins branch.zwei

The problem is that the last 'git config' worked on other-config due to
variable GIT_CONFIG. Test 50 should work now on .git/config, but as
GIT_CONFIG is still set, it doesn't and fails.

Ingo
