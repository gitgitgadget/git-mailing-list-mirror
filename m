From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] solaris test results
Date: Wed, 20 Feb 2008 19:41:46 -0500
Message-ID: <20080221004146.GA6682@coredump.intra.peff.net>
References: <20080220235944.GA6278@coredump.intra.peff.net> <7vk5kz171q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 01:42:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRzW4-00042A-W9
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 01:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759518AbYBUAlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 19:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758896AbYBUAlt
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 19:41:49 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3361 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758763AbYBUAlt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 19:41:49 -0500
Received: (qmail 10082 invoked by uid 111); 21 Feb 2008 00:41:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 20 Feb 2008 19:41:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2008 19:41:46 -0500
Content-Disposition: inline
In-Reply-To: <7vk5kz171q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74581>

On Wed, Feb 20, 2008 at 04:34:25PM -0800, Junio C Hamano wrote:

> >   - Sun's diff doesn't understand "-u". I was able to use GNU diff.
> >     Since comparing actual and expected output is so common, we could
> >     potentially abstract this with a "test_cmp()" function and use
> >     something platform specific. It's probably not worth the trouble, as
> >     it impacts only the test suite, and only on systems with a totally
> >     broken diff.
> 
> It is unfair to call diff without -u "totally broken".  It is
> not even in POSIX yet IIRC.

Fair enough (and you are right that it is not even POSIX). Is it
something we want to work around? We "diff -u" quite a bit in the test
suite.

> >   - t7505 uses a hook which hard-codes /bin/sh but uses syntax that
> >     the Solaris /bin/sh doesn't like. Maybe hooks should get their
> >     $SHELL value replaced?
> 
> You've already did that in your [PATCH 2/3], haven't you?  So
> why not?

Because I didn't look very closely, and I assumed it was one of the
regular hooks. But yes, it is defined in the script and could get the
same treatment.

-Peff
