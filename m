From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] pager: remove 'S' from $LESS by default
Date: Tue, 6 May 2014 17:55:16 -0400
Message-ID: <20140506215516.GA30185@sigill.intra.peff.net>
References: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com>
 <1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr>
 <20140505184441.GS9218@google.com>
 <110110563.544859.1399320654149.JavaMail.zimbra@imag.fr>
 <xmqqppjqg6an.fsf@gitster.dls.corp.google.com>
 <87mweuss7d.fsf@fencepost.gnu.org>
 <vpqzjiuu4i5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Kastrup <dak@gnu.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	d9ba@mailtor.net
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 06 23:55:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhnKd-0005eY-Iv
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 23:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbaEFVzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 17:55:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:46251 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751208AbaEFVzS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 17:55:18 -0400
Received: (qmail 14758 invoked by uid 102); 6 May 2014 21:55:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 May 2014 16:55:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 May 2014 17:55:16 -0400
Content-Disposition: inline
In-Reply-To: <vpqzjiuu4i5.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248256>

On Tue, May 06, 2014 at 08:49:22PM +0200, Matthieu Moy wrote:

> Exactly. I personally never use "git blame" outside "git gui blame" for
> this reason.

I'd recommend "tig blame" for this, too, which behaves like "less -S"
with respect to long lines (and also makes it easy to jump to the full
diff, or restart the blame from the parent of the found commit).

> It's possible for a user to set pager.blame to "less -S" to get back to
> the previous behavior only for blame.
> 
> The idea of having a separate default value for pager.blame (or set
> $LESS differently for blame) crossed my mind, but I actually don't like
> it, as it would make it harder for a user to fine-tune his configuration
> manually (one would have to cancel all the corner-cases that Git would
> set by default).

Agreed. We already get some confusion from users with "git has set $LESS
for me".  Changing it to "git set up $LESS depending on which command is
running" seems like it would cause more of the same.

-Peff
