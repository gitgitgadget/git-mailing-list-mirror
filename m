From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: clone from url with email address as username?(escaping @ symbol)
Date: Tue, 29 Sep 2009 20:09:22 +0200
Message-ID: <vpqws3hpqr1.fsf@bauges.imag.fr>
References: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com>
	<fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com>
	<vpq1vlp962h.fsf@bauges.imag.fr>
	<fabb9a1e0909290732h5119170ew133d906b67e49f99@mail.gmail.com>
	<970bc7c80909290831l59b7fc4at4ec0082f42f3ef87@mail.gmail.com>
	<vpq63b1u1p6.fsf@bauges.imag.fr>
	<alpine.DEB.2.00.0909291946520.23903@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Bennett <benbennett@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Sep 29 20:09:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msh8p-00041k-LZ
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 20:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbZI2SJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 14:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbZI2SJ0
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 14:09:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56112 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbZI2SJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 14:09:26 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8TI5uPM002713
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 29 Sep 2009 20:05:56 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Msh8c-0004b3-SH; Tue, 29 Sep 2009 20:09:22 +0200
In-Reply-To: <alpine.DEB.2.00.0909291946520.23903@tvnag.unkk.fr> (Daniel Stenberg's message of "Tue\, 29 Sep 2009 19\:48\:57 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 29 Sep 2009 20:05:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8TI5uPM002713
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1254852357.65795@AjqI1bT6eSvJQ4h6U9tqeg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129320>

Daniel Stenberg <daniel@haxx.se> writes:

> On Tue, 29 Sep 2009, Matthieu Moy wrote:
>
>> Unfortunately, it seems the complete URL is passed to curl, and curl
>> is the one doing it wrong. Indeed:
>>
>> $ curl -v https://user@email.com@server.com/path/
>> * getaddrinfo(3) failed for email.com@server.com:443
>
> This is not exactly curl "doing it wrong". This is a user passing in
> something that isn't a URL to the command that asks for a URL to work
> on. The user part cannot legally have a '@' letter in a URL, you must
> encode it.
>
>> In short, you have to use %40 to escape the @, and curl does it this
>> way because the RFC doesn't allow @ in usernames.
>
> Exactly. So curl is not "wrong", it just can't work around this user-error.

It may not want work around user-errors, but you can hardly say that
it _can't_. Many tools do in this case, Firefox is one of them. And
anyway, trying to connect to email.com@server.com is probably the
worst thing it can do.

At least, it could warn about two @ in the URL and say it can't
handle it ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
