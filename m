From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not break ACLs with restrictive umask
Date: Tue, 05 Jun 2012 15:28:07 +0200
Message-ID: <vpqk3zlhorc.fsf@bauges.imag.fr>
References: <CALbm-Ea5ZkAGFyB2OETqe7vK7LE+yO0zSaa_+kFMXOhO-nMwMQ@mail.gmail.com>
	<7vhauqsue3.fsf@alter.siamese.dyndns.org>
	<CALbm-EatNCPjFRO4NyGfZuSa72-FXwZcd_7cFe-f_iMOdGL4MQ@mail.gmail.com>
	<7vy5o2ra7w.fsf@alter.siamese.dyndns.org>
	<vpqpq9ejnxs.fsf@bauges.imag.fr>
	<CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
	<20120605075614.GE25809@sigill.intra.peff.net>
	<vpq4nqqj8ss.fsf@bauges.imag.fr>
	<CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 15:28:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbto8-0000PI-3E
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 15:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934179Ab2FEN2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 09:28:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43798 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934105Ab2FEN2T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 09:28:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q55DJXFd014816
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 5 Jun 2012 15:19:33 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sbtns-0001P8-Lg; Tue, 05 Jun 2012 15:28:08 +0200
In-Reply-To: <CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
	(Stefan Beller's message of "Tue, 5 Jun 2012 14:23:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 05 Jun 2012 15:19:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q55DJXFd014816
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339507174.37336@GGOzYDGSlkBNHy8rvTxpwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199242>

Stefan Beller <stefanbeller@googlemail.com> writes:

> Hi,
>
> so I applied that patch with git apply, but here 2 out of 4 tests now
> still fail.

Yes, Jeff's patch checks for a "working" setfacl/getfacl, but does not
check for subtle brokenness of it.

I'd say a filesystem that accepts setfacl, returns the right line in
getfacl, and then does not really work is broken, and it's a feature
that the testsuite shows test failures. A simple fix for you would be to
disable ACLs, either on your system or in your $HOME.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
