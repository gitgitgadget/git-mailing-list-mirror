From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] add -u: only show pathless 'add -u' warning when changes exist outside cwd
Date: Tue, 19 Mar 2013 07:21:47 +0100
Message-ID: <vpq1ubb3o5g.fsf@grenoble-inp.fr>
References: <20130313040845.GA5057@sigill.intra.peff.net>
	<20130313041037.GB5378@sigill.intra.peff.net>
	<20130319034415.GI5062@elie.Belkin>
	<20130319034822.GL5062@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 07:22:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHpwY-0004AD-Ev
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 07:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331Ab3CSGWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 02:22:14 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34665 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755582Ab3CSGWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 02:22:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r2J6LkY3006738
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 19 Mar 2013 07:21:47 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UHpvf-0007II-DK; Tue, 19 Mar 2013 07:21:47 +0100
In-Reply-To: <20130319034822.GL5062@elie.Belkin> (Jonathan Nieder's message of
	"Mon, 18 Mar 2013 20:48:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 19 Mar 2013 07:21:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2J6LkY3006738
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1364278912.93495@7sBlMhlHYH7J1jSP+s0Idw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218486>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The warning about use of 'git add -u' with no pathspec is annoying
> because it serves no purpose in this case.  So suppress the warning
> unless there are changes outside the cwd that are not being added.

No time to review the code now. I thought about implementing something
like that, but did not do it because I didn't want the change in the
code to be too big. At some point, we'll have to remove the warning and
it's easier with my version than with yours. But the "damage" to the
code do not seem too big, so that's probably OK and will actually reduce
the pain for some users.

Discussions showed that many people were already using "git add -u"
without knowing whether it was full tree or not, so for these people the
change is somehow harmless anyway ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
