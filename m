From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC] Add --create-cache to repack
Date: Fri, 28 Jan 2011 10:08:30 +0100
Message-ID: <4D42878E.2020502@viscovery.net>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Hawley <warthog19@eaglescrag.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 28 10:08:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PikJx-0003sL-23
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 10:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149Ab1A1JIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 04:08:39 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43909 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755132Ab1A1JIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 04:08:36 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PikJi-0004Dn-TH; Fri, 28 Jan 2011 10:08:31 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A1A5B1660F;
	Fri, 28 Jan 2011 10:08:30 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <1296201984-24426-1-git-send-email-spearce@spearce.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165603>

Am 1/28/2011 9:06, schrieb Shawn O. Pearce:
> A cache pack is all objects reachable from a single commit that is
> part of the project's stable history and won't disappear, and is
> accessible to all readers of the repository.  By containing only that
> commit and its contents, if the commit is reached from a reference we
> know immediately that the entire pack is also reachable.  To help
> ensure this is true, the --create-cache flag looks for a commit along
> refs/heads and refs/tags that is at least 1 month old, working under
> the assumption that a commit this old won't be rebased or pruned.

In one of my repositories, I have two stable branches and a good score of
topic branches of various ages (a few hours up to two years 8). The topic
branches will either be dropped eventually, or rebased.

What are the odds that this choice of a tip commit picks one that is in a
topic branch? Or is there no point in using --create-cache in a repository
like this?

-- Hannes
