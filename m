From: Jeff King <peff@peff.net>
Subject: Re: [BUG] malloc error when using large file.
Date: Mon, 22 Jun 2009 17:15:42 -0400
Message-ID: <20090622211542.GA19364@coredump.intra.peff.net>
References: <B03A893ADFE80748942D13AFAF2845190C2D5D388A@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Emmanuel Puerto <emmanuel.puerto@maxim-ic.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 23:15:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIqrp-00088A-HG
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 23:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbZFVVPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 17:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752981AbZFVVPo
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 17:15:44 -0400
Received: from peff.net ([208.65.91.99]:49857 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbZFVVPn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 17:15:43 -0400
Received: (qmail 9051 invoked by uid 107); 22 Jun 2009 21:17:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 22 Jun 2009 17:17:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2009 17:15:42 -0400
Content-Disposition: inline
In-Reply-To: <B03A893ADFE80748942D13AFAF2845190C2D5D388A@ITSVLEX06.it.maxim-ic.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122060>

On Mon, Jun 22, 2009 at 02:54:18AM -0700, Emmanuel Puerto wrote:

> I use Git with some Virtual Machine and I have an issue with 2 of them.
> When I use some VM I have created with a "pre-allocated" disk split
> into a 2Go file. For example a "ls" give:
> [...]
> So if I just do a "git init" and after do a "git add -A" I have the
> following error:
> fatal: Out of memory, malloc failed

Many operations in git assume that a whole file can be held in memory at
once. Do you actually have 2G available on the machine? Are there any OS
limits that might be a problem?

-Peff
