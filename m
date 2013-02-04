From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: "git archve --format=tar" output changed from 1.8.1 to 1.8.2.1
Date: Sun, 3 Feb 2013 18:45:12 -0600
Message-ID: <20130204004512.GB6243@kroah.com>
References: <20130131172805.GC16593@kroah.com>
 <7vzjzpgswz.fsf@alter.siamese.dyndns.org>
 <20130131174103.GA20111@kroah.com>
 <7vr4l1gqv8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org,
	Konstantin Ryabitsev <mricon@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 04:23:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Ce5-00086e-9c
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 04:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab3BDDWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 22:22:38 -0500
Received: from mail.kernel.org ([198.145.19.201]:49300 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753932Ab3BDDWh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 22:22:37 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 304B120268;
	Mon,  4 Feb 2013 03:22:36 +0000 (UTC)
Received: from localhost (1007host2.starwoodbroadband.com [12.108.174.2])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 6F1802026B;
	Mon,  4 Feb 2013 03:22:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vr4l1gqv8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mail.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215351>

On Thu, Jan 31, 2013 at 10:16:27AM -0800, Junio C Hamano wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Thu, Jan 31, 2013 at 09:32:12AM -0800, Junio C Hamano wrote:
> >
> >> How about fixing kup to teach the "let's cheat and let the other end
> >> run 'git archive', if the resulting archive and GPG signature
> >> locally created does match, we do not have to transfer the tarball
> >> itself" trick a fall-back mode that says "but if the signature does
> >> not match, then transfer the bulk used to create the signature to
> >> the remote anyway".  This fallback can and should of course be
> >> useful for the compressed patch transfer.
> >
> > Ugh, uploading a 431Mb file, over a flaky wireless connection (I end up
> > doing lots of kernel releases while traveling), would be a horrible
> > change.  I'd rather just keep using the same older version of git that
> > kernel.org is running instead.
> 
> Then how about fixing kup to try both versions of Git?  There will
> be people who run different versions of Git anyway, and kup should
> not be preventing Git from helping people on other platforms, or
> improving its output in general.

I think the combinations of different versions of git that would have to
be installed on kernel.org to handle stuff like this as things change
over time, wouldn't be worth it.

The number of people this affects right now is only one (me), given that
the offending file is not in Linus's tree right now, so he doesn't have
issues with uploading new releases.

So I'll just work to ensure I have the same version of git in place if I
ever run into this problem again.  Or just break down and do
full-compressed tarballs instead, if I'm in a place where I have a good
network connection.

thanks,

greg k-h
