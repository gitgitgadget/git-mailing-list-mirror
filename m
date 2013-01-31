From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Thu, 31 Jan 2013 14:38:45 -0500
Message-ID: <20130131193844.GA14460@sigill.intra.peff.net>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 <7vvcafojf4.fsf@alter.siamese.dyndns.org>
 <20130130074306.GA17868@sigill.intra.peff.net>
 <7v7gmumzo6.fsf@alter.siamese.dyndns.org>
 <87pq0l5qbc.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 20:39:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0zyZ-0006gJ-6S
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 20:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175Ab3AaTit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 14:38:49 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54833 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690Ab3AaTis (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 14:38:48 -0500
Received: (qmail 13370 invoked by uid 107); 31 Jan 2013 19:40:11 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Jan 2013 14:40:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2013 14:38:45 -0500
Content-Disposition: inline
In-Reply-To: <87pq0l5qbc.fsf@lifelogs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215155>

On Thu, Jan 31, 2013 at 10:23:51AM -0500, Ted Zlatanov wrote:

> Jeff, is there a way for git-credential to currently support
> authinfo/netrc parsing?  I assume that's the right way, instead of using
> Michal's proposal to parse internally?
> 
> I'd like to add that, plus support for the 'string' and "string"
> formats, and authinfo.gpg decoding through GPG.  I'd write it in Perl,
> if there's a choice.

Yes, you could write a credential helper that understands netrc and
friends; git talks to the helpers over a socket, so there is no problem
with writing it in Perl. See Documentation/technical/api-credentials.txt
for an overview, or the sample implementation in credential-store.c for a
simple example.

-Peff
