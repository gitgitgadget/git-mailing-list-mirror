From: Ingo Br=?ISO-8859-1?Q?=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH] Fix wrong failures in config test
Date: Mon, 10 Jan 2011 20:21:49 +0100
Message-ID: <4d2b5c52.68e3cdc2.bm000@wupperonline.de>
References: <7vhbdg6286.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 10 20:22:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcNKS-0002cP-9A
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 20:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828Ab1AJTWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 14:22:48 -0500
Received: from smtp-a.tal.de ([81.92.1.9]:58865 "EHLO smtp-a.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483Ab1AJTWs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 14:22:48 -0500
Received: from point.localnet (mue-88-130-97-192.dsl.tropolys.de [88.130.97.192])
	(Authenticated sender: ib@wtal.de)
	by smtp-a.tal.de (Postfix) with ESMTP id 93669111C325
	for <git@vger.kernel.org>; Mon, 10 Jan 2011 20:22:45 +0100 (CET)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1PcNKF-2Pz-00 for <git@vger.kernel.org>; Mon, 10 Jan 2011 20:22:43 +0100
In-Reply-To: <7vhbdg6286.fsf@alter.siamese.dyndns.org>
X-Mailer: blueMail/Linux 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164893>

I wrote:

> Is it only me [...] experiencing these failures?

And the answer is yes. Sorry.

As Jonathan and Junio stated,

>  envvar=value git command

>  GIT_CONFIG=other-config git config anwohner.park ausweis

shouldn't affect the environment of the tests.

Unfortunately, I had a shell alias function named git that interfered. In
fact it passes to the git program (command git "$@") but sadly does not know
about the newly set PATH and (still inexplicably to me) makes the variable
set.

So it's all my problem.

Ingo
