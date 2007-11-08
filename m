From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH amend] git-mailsplit: with maildirs not only process cur/, but also new/
Date: Wed, 07 Nov 2007 18:09:26 -0800
Message-ID: <7vfxzh7ajt.fsf@gitster.siamese.dyndns.org>
References: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org>
	<20071026160118.GA5076@ferdyx.org>
	<20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org>
	<20071105225258.GC4208@steel.home>
	<20071106085418.14211.qmail@54d7c9212e25c5.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>,
	"Fernando J. Pereda" <ferdy@gentoo.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 03:10:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipwqe-0004vM-B3
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 03:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758824AbXKHCJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 21:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758791AbXKHCJj
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 21:09:39 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40116 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758823AbXKHCJh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 21:09:37 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 436F82EF;
	Wed,  7 Nov 2007 21:09:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9463C933E5;
	Wed,  7 Nov 2007 21:09:52 -0500 (EST)
In-Reply-To: <20071106085418.14211.qmail@54d7c9212e25c5.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Tue, 6 Nov 2007 08:54:18 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63924>

Gerrit Pape <pape@smarden.org> writes:

> When saving patches to a maildir with e.g. mutt, the files are put into
> the new/ subdirectory of the maildir, not cur/.  This makes git-am state
> "Nothing to do.".  This patch lets git-mailsplit additional check new/
> after reading cur/.
>
> This was reported by Joey Hess through
>  http://bugs.debian.org/447396
>
> Signed-off-by: Gerrit Pape <pape@smarden.org>
> ---
>
> On Mon, Nov 05, 2007 at 01:58:50PM +0100, Jakub Narebski wrote:
>> > +        for (i = 0; i < 2; ++i) {
>> Wouldn't it be better to use sizeof(sub)/sizeof(sub[0]) or it's macro
>> equivalent ARRAY_SIZE(sub) instead of hardcoding 2 to avoid errors?
> I made the array NULL-terminated.
>
> On Mon, Nov 05, 2007 at 04:26:24PM -0500, Jeff King wrote:
>> Isn't the subject line now wrong?
> Yes, thanks.
>
> On Mon, Nov 05, 2007 at 11:52:58PM +0100, Alex Riesen wrote:
>> Why is missing "cur" (or "new", for that matter) a fatal error?
>> Why is it error at all? How about just ignoring the fact?
> As suggested by Jeff, I made it ignore the error on ENOENT.

Looks good to me.  Final acks please?
