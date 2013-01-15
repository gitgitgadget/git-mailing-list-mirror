From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] am: invoke perl's strftime in C locale
Date: Tue, 15 Jan 2013 08:50:59 -0800
Message-ID: <20130115165058.GA29301@sigill.intra.peff.net>
References: <20130114205933.GA25947@altlinux.org>
 <20130115155953.GB21815@sigill.intra.peff.net>
 <CALWbr2w+q5=Z8__g+J_s2NtTMgziHrntFqsi8vCJyvfO2qi81A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Dmitry V. Levin" <ldv@altlinux.org>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 17:51:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv9jR-0006Ea-Bg
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 17:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab3AOQvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 11:51:03 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34158 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755167Ab3AOQvC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 11:51:02 -0500
Received: (qmail 30947 invoked by uid 107); 15 Jan 2013 16:52:18 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Jan 2013 11:52:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2013 08:50:59 -0800
Content-Disposition: inline
In-Reply-To: <CALWbr2w+q5=Z8__g+J_s2NtTMgziHrntFqsi8vCJyvfO2qi81A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213647>

On Tue, Jan 15, 2013 at 05:42:12PM +0100, Antoine Pelisse wrote:

> > This puts all of perl into the C locale, which would mean error messages
> > from perl would be in English rather than the user's language. It
> > probably isn't a big deal, because that snippet of perl is short and not
> > likely to produce problems, but I wonder how hard it would be to set the
> > locale just for the strftime call.
> 
> Maybe just setting LC_TIME to C would do ...

Yeah, that is a nice simple solution. Dmitry, does just setting LC_TIME
fix the problem for you?

-Peff
