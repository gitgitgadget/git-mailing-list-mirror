From: Jeff King <peff@peff.net>
Subject: Re: bsd group semantics
Date: Tue, 31 Mar 2009 18:25:42 -0400
Message-ID: <20090331222540.GA25820@coredump.intra.peff.net>
References: <20090331112637.GA1910@coredump.intra.peff.net> <7vvdpp6623.fsf@gitster.siamese.dyndns.org> <20090331160842.GA9019@coredump.intra.peff.net> <7veiwd61k1.fsf@gitster.siamese.dyndns.org> <20090331184604.GA10701@coredump.intra.peff.net> <7vy6ul4exy.fsf@gitster.siamese.dyndns.org> <20090331203600.GA24340@coredump.intra.peff.net> <7vr60d4btl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LomQb-0007aF-9Z
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 00:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833AbZCaWZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 18:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbZCaWZ4
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 18:25:56 -0400
Received: from peff.net ([208.65.91.99]:40266 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755833AbZCaWZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 18:25:56 -0400
Received: (qmail 13699 invoked by uid 107); 31 Mar 2009 22:26:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 31 Mar 2009 18:26:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2009 18:25:42 -0400
Content-Disposition: inline
In-Reply-To: <7vr60d4btl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115325>

On Tue, Mar 31, 2009 at 02:33:26PM -0700, Junio C Hamano wrote:

> > -	# All directories must have 2770
> > -	test -z "$(sed -n -e "/^drwxrws---/d" -e "/^d/p" actual)" &&
> 
> Did you mean 
> 
> -	# All directories must have 2770
> -	test -z "$(sed -n -e "/^drwxrws---/d" -e "/^d/p" actual)" &&
> +	# All directories must have either 2770 or 770
> +	test -z "$(sed -n -e "/^drwxrw[sx]---/d" -e "/^d/p" actual)" &&

No, I meant what I said, but I was wrong. ;) I was thinking that bit
only tested for one thing, but it was actually testing for two. Sorry.

Can you fix it up when you apply, then?

-Peff
