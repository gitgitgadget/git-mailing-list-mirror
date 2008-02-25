From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] mergetool: clarify local/remote terminology
Date: Mon, 25 Feb 2008 15:11:02 -0500
Message-ID: <20080225201102.GA21928@coredump.intra.peff.net>
References: <1203570776-62019-1-git-send-email-jaysoffian@gmail.com> <76718490802250631p262baf1bw23873e5fdbbb7180@mail.gmail.com> <20080225184648.GC15131@sigill.intra.peff.net> <76718490802251107y44ff2d6ahf5446ae0408c67b0@mail.gmail.com> <20080225192106.GB19666@sigill.intra.peff.net> <76718490802251209u240bc0b2s8e268c7f1943c3d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:11:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTjfu-0003xC-Rf
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 21:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534AbYBYULI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 15:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756579AbYBYULG
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 15:11:06 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3036 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755927AbYBYULF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 15:11:05 -0500
Received: (qmail 12678 invoked by uid 111); 25 Feb 2008 20:11:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 25 Feb 2008 15:11:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2008 15:11:02 -0500
Content-Disposition: inline
In-Reply-To: <76718490802251209u240bc0b2s8e268c7f1943c3d9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75060>

On Mon, Feb 25, 2008 at 03:09:04PM -0500, Jay Soffian wrote:

> >  Probably HEAD and HEAD~5 (perhaps along with their oneline logs). I
> >  think the best we can do is "whatever the user said to get us here"
> >  which is not something you can calculate after the fact; you have to
> >  remember what the user said.
> 
> Right, so the porcelain would have to save this information somewhere
> for mergetool to access (yes/no/maybe?).

Yes (that's what would go into a .git/status type of file).

> Anyway, that's why the first iteration of my patch takes --left
> and --right arguments so at least you can tell it how you got
> there.

Yes, I saw that. The problem is that git-mergetool is invoked by the
user. Is it really improving the usability to have to manually specify
--left and --right? Saving and restoring the state seems like the only
useful option.

-Peff
