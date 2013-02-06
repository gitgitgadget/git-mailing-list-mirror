From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] git-send-email: Use git credential to obtain
 password.
Date: Wed, 6 Feb 2013 18:19:43 -0500
Message-ID: <20130206231943.GM27507@sigill.intra.peff.net>
References: <cover.1360183427.git.mina86@mina86.com>
 <1d13f9fb587b8ea740cdd774173b8f63f45f86af.1360183427.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ted Zlatanov <tzz@lifelogs.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 00:20:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3EHh-0006db-8x
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 00:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757866Ab3BFXTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 18:19:47 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37244 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755064Ab3BFXTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 18:19:46 -0500
Received: (qmail 12044 invoked by uid 107); 6 Feb 2013 23:21:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 18:21:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 18:19:43 -0500
Content-Disposition: inline
In-Reply-To: <1d13f9fb587b8ea740cdd774173b8f63f45f86af.1360183427.git.mina86@mina86.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215663>

On Wed, Feb 06, 2013 at 09:47:06PM +0100, Michal Nazarewicz wrote:

> From: Michal Nazarewicz <mina86@mina86.com>
> 
> If smtp_user is provided but smtp_pass is not, instead of prompting
> for password, make git-send-email use git credential command
> instead.
> 
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> ---
>  Documentation/git-send-email.txt |  4 +--
>  git-send-email.perl              | 59 +++++++++++++++++++++++-----------------
>  2 files changed, 36 insertions(+), 27 deletions(-)

Nice. I don't see anything obviously wrong with the code, but I didn't
try it myself. I wonder how hard it would be to have some tests in
t9001. It looks like we don't test the smtp code paths at all, since we
would have to implement a fake smtp server. Which probably means the
answer is is "pretty hard", unless there is an easy-to-use CPAN smtp
server module we can plug in.

-Peff
