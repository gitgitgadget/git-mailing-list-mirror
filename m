From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: respect '~' and '~user' in mailmap.file
Date: Tue, 27 May 2014 12:09:39 -0400
Message-ID: <20140527160939.GA29693@sigill.intra.peff.net>
References: <1401180358-27281-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 18:09:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpJwk-0004Tf-ES
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 18:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbaE0QJm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2014 12:09:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:60288 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751777AbaE0QJl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 12:09:41 -0400
Received: (qmail 16088 invoked by uid 102); 27 May 2014 16:09:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 May 2014 11:09:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 May 2014 12:09:39 -0400
Content-Disposition: inline
In-Reply-To: <1401180358-27281-1-git-send-email-oystwa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250172>

On Tue, May 27, 2014 at 10:45:58AM +0200, =C3=98ystein Walle wrote:

> git_config_string() does not handle '~' and '~user' as part of the
> value. Using git_config_pathname() fixes this.

Makes sense. Curious if there was a reason we did not use it in the
first place, I looked at the history. The reason is that mailmap.file
was added in d551a48 (2009-02-08) and git_config_pathname came months
later in 395de25 (2009-11-17). Retro-fitting it now should not cause a
problem for any sane paths. So:

Reviewed-by: Jeff King <peff@peff.net>

-Peff
