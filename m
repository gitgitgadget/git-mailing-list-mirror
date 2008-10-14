From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: View remote logs?
Date: Tue, 14 Oct 2008 10:21:52 +0200
Message-ID: <48F456A0.701@drmicha.warpmail.net>
References: <20081014071907.GP16999@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 14 10:23:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpfBa-0004VI-QD
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 10:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbYJNIWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 04:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754527AbYJNIWG
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 04:22:06 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:42915 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753712AbYJNIWF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2008 04:22:05 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id DBEEB179926
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 04:22:02 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 14 Oct 2008 04:22:02 -0400
X-Sasl-enc: vV6NwtuOmQJ+gwaCReOVvkVIVI57DFMsrsurNH3p7FE/ 1223972522
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 36EAD2BFDF
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 04:22:02 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <20081014071907.GP16999@penguin.codegnome.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98174>

Todd A. Jacobs venit, vidit, dixit 14.10.2008 09:19:
> I've Googled around, and tried some experiments with likely-looking
> tools like git log, git diff, and git ls-remote, but they only seem to
> operate on the local repository. In particular, there doesn't seem to be
> an obvious way to view the commit logs on a remote repository without
> pulling it first.
> 
> On an intuitive level, it seems like "git log origin" would allow me to
> see what someone has committed to a remote repository so I can decide
> whether it's something I want to pull. Even something like "git diff
> HEAD origin" would let me know if there were changes I might want to
> pull before doing so.
> 
> Am I missing something obvious? Is it possible to use the CLI to view
> remote logs, or is the only choice to pull everything?

You can always fetch (rather than pull) and then decide whether to pull
(i.e. merge or rebase FETCH_HEAD) or not.

The problem with "remote log" is that log can show diffstats, full diffs
etc, so that it would need all new objects anyways.

If you want to avoid fetching new objects the only way is to run git log
etc. on the remote side. You can do this with ssh, but the other
transports (git:, http:) don't support this.

Michael
