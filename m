From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/7] Rework strbuf API and semantics.
Date: Thu, 6 Sep 2007 10:50:35 -0400
Message-ID: <20070906145035.GA3546@coredump.intra.peff.net>
References: <20070902224213.GB431@artemis.corp> <11890776114037-git-send-email-madcoder@debian.org> <118907761140-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0709061506330.28586@racer.site> <20070906142155.GB3002@coredump.intra.peff.net> <857in3dfad.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 16:51:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITIhK-0003Xl-0U
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 16:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838AbXIFOuj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 10:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752667AbXIFOui
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 10:50:38 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3391 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757518AbXIFOui (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 10:50:38 -0400
Received: (qmail 22215 invoked by uid 111); 6 Sep 2007 14:50:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Sep 2007 10:50:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2007 10:50:35 -0400
Content-Disposition: inline
In-Reply-To: <857in3dfad.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57887>

On Thu, Sep 06, 2007 at 04:44:42PM +0200, David Kastrup wrote:

> >> Would not "struct strbuf sb = { 0 };" have the same effect?  (I am not so 
> >> standards-keen as other people, who I have no doubt will gladly answer 
> >> this one.)
> >
> > Yes, it would, according to the standard.
> 
> Have a citation for that?

Of course.

See ISO 9899:1999, section 6.7.8.

Paragraph 10:

  If an object that has automatic storage duration is not initialized
  explicitly, its value is indeterminate. If an object that has static
  storage duration is not initialized explicitly, then:

  -- if it has pointer type, it is initialized to a null pointer;

  -- if it has arithmetic type, it is initialized to (positive or
  unsigned) zero;

  -- if it is an aggregate, every member is initialized (recursively)
  according to these rules;

  -- if it is a union, the first named member is initialized (recursively)
  according to these rules.

Paragraph 21:

  If there are fewer initializers in a brace-enclosed list than there
  are elements or members of an aggregate, or fewer characters in a
  string literal used to initialize an array of known size than there
  are elements in the array, the remainder of the aggregate shall be
  initialized implicitly the same as objects that have static storage
  duration.

-Peff
