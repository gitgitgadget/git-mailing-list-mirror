From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: handle adjacent RFC 2047-encoded words
 properly
Date: Mon, 24 Nov 2014 10:44:04 -0500
Message-ID: <20141124154404.GB25912@peff.net>
References: <1416786604-4988-1-git-send-email-dpb@corrigendum.ru>
 <CAPc5daVjNDg5CcWsMwfn=DZhwpCBdU2LYXOpFWZwhx2p8hLRww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
	<dpb@corrigendum.ru>, Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 16:44:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsvoZ-0001eR-J8
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 16:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbaKXPo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 10:44:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:44081 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754037AbaKXPoF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 10:44:05 -0500
Received: (qmail 28624 invoked by uid 102); 24 Nov 2014 15:44:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 09:44:05 -0600
Received: (qmail 17490 invoked by uid 107); 24 Nov 2014 15:44:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 10:44:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Nov 2014 10:44:04 -0500
Content-Disposition: inline
In-Reply-To: <CAPc5daVjNDg5CcWsMwfn=DZhwpCBdU2LYXOpFWZwhx2p8hLRww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260129>

On Sun, Nov 23, 2014 at 11:27:51PM -0800, Junio C Hamano wrote:

> Was the change to the test to use Cyrillic really necessary, or did it
> suffice if you simply extended the existsing "Funny Name" spelled with
> strange accents, but you substituted the whole string anyway?
> 
> Until I found out what the new string says by running web-based
> translation on it, I felt somewhat uneasy. As I do not read
> Cyrillic/Russian, we may have been adding some profanity without
> knowing. It turns out that the string just says "Cyrillic Name", so I am
> not against using the new string, but it simply looked odd to replace the
> string whole-sale when you merely need a longer string. It made it look
> as if a bug was specific to Cyrillic when it wasn't.

I do not mind hidden Cyrillic profanity[1], but I found the new text
much harder to verify, because the shapes are very unfamiliar to my
eyes. I'd prefer if we can stick to accented Roman letters.  I realize
this is me being totally Anglo-centric. But for Cyrillic readers,
consider how much more difficult it would be to manually verify the test
if it were written in an unfamiliar script (e.g., Hangul).  The
surrounding code is already written in Roman characters (and English),
so it probably makes sense as a common denominator.

-Peff

[1] As long as it is only crude and not mean. :)
