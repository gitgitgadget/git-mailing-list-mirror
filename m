From: Thomas Koch <thomas@koch.ro>
Subject: Re: How to rebase when some commit hashes are in some commit messages
Date: Sun, 18 Oct 2015 15:58:25 +0200
Message-ID: <1634617.ZbHCyji7nE@x121e>
References: <561C1132.3090606@orange.fr> <AD64941D9533442AB025BE27FF8F08AF@PhilipOakley> <561F597B.8090102@orange.fr>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Philip Oakley <philipoakley@iee.org>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Francois-Xavier Le Bail <devel.fx.lebail@orange.fr>
X-From: git-owner@vger.kernel.org Sun Oct 18 16:08:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znods-0002KM-4Z
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 16:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbbJROIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 10:08:24 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:39371 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbbJROIX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 10:08:23 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Oct 2015 10:08:23 EDT
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx2.mailbox.org (Postfix) with ESMTPS id 84A6C43526;
	Sun, 18 Oct 2015 15:58:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
	by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
	with ESMTP id DPyrd1888TCj; Sun, 18 Oct 2015 15:58:32 +0200 (CEST)
User-Agent: KMail/4.14.1 (Linux/4.2.0-0.bpo.1-amd64; KDE/4.14.2; x86_64; ; )
In-Reply-To: <561F597B.8090102@orange.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279810>

On Thursday 15 October 2015 09:44:59 Francois-Xavier Le Bail wrote:
> >> On Tue, 13 Oct 2015 10:50:40 +0200
> >> Francois-Xavier Le Bail <devel.fx.lebail@orange.fr> wrote:
> >>> >> For example, if I rebase the following commits, I would want that
> >>> >> if the commit hash 2222222... become 7777777...,
> >>> >> the message
> >>> >> "Update test output for 2222222222222222222222222222222222222222"
> >>> >> become
> >>> >> "Update test output for 7777777..."
> >>> >> 
> >>> >> Is it possible currently? And if yes how?

The code review system Gerrit (highly recommended!) uses a commit-hook to adds 
a trailer line to every commit message, e.g.:

Change-Id: Id8269a1aa4a2c7a1a584b23b01d63259410c4e85

This Change-Id is used to identify a change even if the change gets amended or 
rebased and thus is represented in a different commit.

So if you're using Gerrit you can refer to changes instead of commits and use 
the Change-Id. Even if you don't use Gerrit you can still use its commit-hook 
to write the Change-Id trailers.

Regards,

Thomas Koch
