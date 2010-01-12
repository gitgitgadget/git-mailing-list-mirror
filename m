From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Display author and committer after "git commit"
Date: Tue, 12 Jan 2010 09:52:12 -0500
Message-ID: <20100112145212.GA11053@coredump.intra.peff.net>
References: <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com>
 <xuu2zl4tfuij.fsf@nowhere.com>
 <20100106073806.6117@nanako3.lavabit.com>
 <7v4omz17xz.fsf@alter.siamese.dyndns.org>
 <xuu28wc9xd42.fsf@nowhere.com>
 <7vskagh9fg.fsf@alter.siamese.dyndns.org>
 <xuu2fx6d9rzb.fsf_-_@nowhere.com>
 <7vzl4lw160.fsf@alter.siamese.dyndns.org>
 <xuu2zl4kks3s.fsf@nowhere.com>
 <20100112142405.GA13369@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adam Megacz <adam@megacz.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 15:52:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUi6p-0006wa-6B
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 15:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385Ab0ALOwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 09:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753020Ab0ALOwX
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 09:52:23 -0500
Received: from peff.net ([208.65.91.99]:48040 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036Ab0ALOwW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 09:52:22 -0500
Received: (qmail 7711 invoked by uid 107); 12 Jan 2010 14:57:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 Jan 2010 09:57:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2010 09:52:12 -0500
Content-Disposition: inline
In-Reply-To: <20100112142405.GA13369@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136722>

On Tue, Jan 12, 2010 at 09:24:06AM -0500, Jeff King wrote:

>   - It tries to quote any percents in the author name, but user formats
>     don't actually have a quoting mechanism! Probably we should
>     interpret "%%" as "%". Even though it's a behavior change, I
>     consider the current behavior buggy.

Actually, on second thought, they do: you can use %x25 to get the same
effect. I still think we should support '%%' as a more readable and
expected alternative (this is how printf works, and daemon.c's expansion
already does this).

-Peff
