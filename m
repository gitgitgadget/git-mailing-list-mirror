From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC 4/6] Docs: send-email: Option order the same in man
	page and usage text
Date: Fri, 26 Sep 2008 18:40:32 -0400
Message-ID: <20080926224032.GA24817@coredump.intra.peff.net>
References: <1222099095-50360-1-git-send-email-mfwitten@mit.edu> <1222375476-32911-1-git-send-email-mfwitten@mit.edu> <1222375476-32911-2-git-send-email-mfwitten@mit.edu> <1222375476-32911-3-git-send-email-mfwitten@mit.edu> <1222375476-32911-4-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Sep 27 00:41:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjM0R-0006ES-9P
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 00:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbYIZWkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 18:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYIZWkf
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 18:40:35 -0400
Received: from peff.net ([208.65.91.99]:3817 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730AbYIZWkf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 18:40:35 -0400
Received: (qmail 8644 invoked by uid 111); 26 Sep 2008 22:40:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 26 Sep 2008 18:40:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Sep 2008 18:40:32 -0400
Content-Disposition: inline
In-Reply-To: <1222375476-32911-4-git-send-email-mfwitten@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96887>

On Thu, Sep 25, 2008 at 03:44:34PM -0500, Michael Witten wrote:

> The man page seems to have listed the options in alphabetical order,
> while the usage text used what I would consider an `intuitive' order
> that groups related items and presents them in the order peopl think
> when writing an email.
> 
> The manual page has been updated to mirror this order.

I think overall this serious is well-intentioned the results look sane
to me (I diffed the manpage and usage text before and after).

My only concerns are:

  4/6: I am not sure about making the order of options the same, as the
       two formats serve different purposes. I think "git send-email
       --foo" should present the options based on commonality of use.
       You clearly got the usage wrong, so I think it is helping you to
       figure out quickly what you probably meant.

       The manpage, on the other hand, is a comprehensive reference and
       so should probably be alphabetized for easy reading.

       That being said, I find the length of the current usage statement
       somewhat ridiculous. I wonder if it would be better still to just
       mention in the usage the overall syntax (i.e., "send-email
       [options] <file | directory>", the few most common options (with
       minimal description), and then refer to the manpage for complete.
       With the goal of taking no more than 10 or so lines (the current
       output is 71 lines!).

  5/6: This isn't really a documentation patch, as it adds a new config
       option. I think the result is reasonable, but it was a surprise
       after reading the rest of the series.

       I was also going to complain that there was no entry in
       Documentation/config.txt for the new option, but I see that none
       of the sendemail options are there. Maybe while you are working
       on this, it is worth factoring them out to send-email-options.txt
       and including it in both git-send-email.txt and config.txt.

-Peff
