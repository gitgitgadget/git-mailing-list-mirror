From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase-i-p: only list commits that require rewriting
	in todo
Date: Mon, 20 Oct 2008 20:39:35 -0400
Message-ID: <20081021003935.GC32569@coredump.intra.peff.net>
References: <cover.1224055978.git.stephen@exigencecorp.com> <0977b23f6c709d4aea76de7a88e9fe17272b31ea.1224055978.git.stephen@exigencecorp.com> <20081020115003.GA11309@coredump.intra.peff.net> <7vej2a3kl5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Haberman <stephen@exigencecorp.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 02:40:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks5Io-0002T4-DZ
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 02:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbYJUAji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 20:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbYJUAji
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 20:39:38 -0400
Received: from peff.net ([208.65.91.99]:1717 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601AbYJUAjh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 20:39:37 -0400
Received: (qmail 17088 invoked by uid 111); 21 Oct 2008 00:39:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Oct 2008 20:39:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2008 20:39:35 -0400
Content-Disposition: inline
In-Reply-To: <7vej2a3kl5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98751>

On Mon, Oct 20, 2008 at 04:36:38PM -0700, Junio C Hamano wrote:

> I do not remember the individual patches in the series, but I have to say
> that the script at the tip of the topic is, eh, less than ideal.
> 
> Here is a small untested patch to fix a few issues I spotted while reading
> it for two minutes.
> 
>  * Why filter output from "rev-list --left-right A...B" and look for the
>    ones that begin with ">"?  Wouldn't "rev-list A..B" give that?
> 
>  * The abbreviated SHA-1 are made with "rev-list --abbrev=7" into $TODO in
>    an earlier invocation, and it can be more than 7 letters to avoid
>    ambiguity.  Not just that "${r:0:7} is not even in POSIX", but use of
>    it here is actively wrong.
> 
>  * There is no point in catting a single file and piping it into grep.

All of those look like sane changes to me (I'll admit that before I
didn't even look at the script beyond the breakage on my test box).

-Peff
