From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7004: test that "git-tag -u" implies "-s"
Date: Tue, 11 Dec 2007 00:22:57 -0500
Message-ID: <20071211052257.GA350@coredump.intra.peff.net>
References: <alpine.LFD.0.9999.0712101950110.28293@woody.linux-foundation.org> <20071211042436.GA23805@coredump.intra.peff.net> <7v63z5j16g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Carlos Rica <jasampler@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 06:23:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1xaW-0004YF-6u
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 06:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbXLKFXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 00:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbXLKFXA
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 00:23:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4250 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbXLKFXA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 00:23:00 -0500
Received: (qmail 6315 invoked by uid 111); 11 Dec 2007 05:22:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 11 Dec 2007 00:22:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2007 00:22:57 -0500
Content-Disposition: inline
In-Reply-To: <7v63z5j16g.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67790>

On Mon, Dec 10, 2007 at 08:38:31PM -0800, Junio C Hamano wrote:

> +get_tag_header implied-sign $commit commit $time >expect
> +echo 'Another signed tag' >>expect
> +echo '-----BEGIN PGP SIGNATURE-----' >>expect
> +test_expect_success '-u implies signed tag' '
> +	git-tag -u CDDE430D -m "Another signed tag" implied-sign &&
> +	get_tag_msg implied-sign >actual &&
> +	git diff expect actual
> +'

One thing that my original did test but this version doesn't: not only
does -u imply -s, but -u implies -s which implies -a. IOW, using "-u"
will put you in an editor (and a poorly done fix might have gotten this
wrong, but apparently Linus is a super-genius).

Your other two tests look good.

-Peff
