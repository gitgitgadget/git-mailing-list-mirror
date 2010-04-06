From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: [PATCH] Initialize notes trees if %N is used and no
 --show-notes given
Date: Tue, 6 Apr 2010 13:19:04 +0200
Message-ID: <20100406111904.GA46425@macbook.lan.lan>
References: <20100405115548.GA19971@macbook.lan.lan>
 <201004061127.01471.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Jeff King <peff@peff.net>, Johannes Gilger <heipei@hackvalue.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 06 13:19:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz6oP-0007A0-6F
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 13:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226Ab0DFLTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 07:19:12 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:52550 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049Ab0DFLTK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 07:19:10 -0400
Received: from p5082b7c2.dip.t-dialin.net ([80.130.183.194]:60068 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1Nz6oC-0001Ue-Ux; Tue, 06 Apr 2010 13:19:05 +0200
Content-Disposition: inline
In-Reply-To: <201004061127.01471.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 80.130.183.194
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144128>

On 06/04/10 11:27, Thomas Rast wrote:
> [A Cc would have been nice, I nearly missed this but it's clearly my
> bug.]
Sorry for that, haven't mailed to git-ml for quite a while ;)

> I see three options:
> - %N could simply expand to nothing if notes are disabled
> - %N could silently initialize as above
> - your patch
The first option would be confusing. I, for one, would simply put %N in
my log and never really know that existing notes aren't displayed. I
wasn't even sure my git.git checkout had notes, so I created one myself.
A better behaviour would be to not expand %N if notes are disabled, so a
user gets some kind of feedback that %N isn't working.

I'd really like %N to do the initialization. There is no other
placeholder which requires an extra option to work, if I see it
correctly.

As for the builtin formats I was under the impressions that they worked
completely outside the parser for placeholders, so one would not use
'%N' in a builtin format, and %N initializing the notes would not
conflict with --no-notes and builtin formats.

> though for your patch, I'd also remove the assert() since it's
> basically there to enforce the requirement of initializing them; the
> trees list can never be NULL after init_display_notes().
Sure.

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://heipei.net
GPG-Key: 0xD47A7FFC
GPG-Fingerprint: 5441 D425 6D4A BD33 B580  618C 3CDC C4D0 D47A 7FFC
