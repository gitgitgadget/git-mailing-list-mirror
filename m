From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Wed, 30 Jan 2013 02:43:06 -0500
Message-ID: <20130130074306.GA17868@sigill.intra.peff.net>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 <7vvcafojf4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 08:43:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0SKa-00088i-R6
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 08:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254Ab3A3HnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 02:43:11 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53847 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689Ab3A3HnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 02:43:09 -0500
Received: (qmail 27756 invoked by uid 107); 30 Jan 2013 07:44:32 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Jan 2013 02:44:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jan 2013 02:43:06 -0500
Content-Disposition: inline
In-Reply-To: <7vvcafojf4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215004>

On Tue, Jan 29, 2013 at 11:53:19AM -0800, Junio C Hamano wrote:

> Either way it still encourages a plaintext password to be on disk,
> which may not be what we want, even though it may be slight if not
> really much of an improvement.  Again the Help-for-users has this
> amusing bit:

I do not mind a .netrc or .authinfo parser, because while those formats
do have security problems, they are standard files that may already be
in use. So as long as we are not encouraging their use, I do not see a
problem in supporting them (and we already do the same with curl's netrc
support).

But it would probably make sense for send-email to support the existing
git-credential subsystem, so that it can take advantage of secure
system-specific storage. And that is where we should be pointing new
users. I think contrib/mw-to-git even has credential support written in
perl, so it would just need to be factored out to Git.pm.

-Peff
