From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Thu, 24 Jul 2014 08:39:51 +0200
Message-ID: <vpqlhrjqmyw.fsf@anie.imag.fr>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>
	<xmqqtx67bt78.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 08:41:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XACiK-0001No-5k
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 08:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934179AbaGXGlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 02:41:12 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42631 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934164AbaGXGlL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 02:41:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6O6dpJX002892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 Jul 2014 08:39:51 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6O6dp8n030298;
	Thu, 24 Jul 2014 08:39:51 +0200
In-Reply-To: <xmqqtx67bt78.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 23 Jul 2014 15:34:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 Jul 2014 08:39:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6O6dpJX002892
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406788793.56405@lpSHlj1MLqOpIwobkscNxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254149>

Junio C Hamano <gitster@pobox.com> writes:

> in my ~/.gitconfig and then for a particular project I wanted to use
> a custom pattern in its .git/config but it was sufficient to define
> the pattern without using extended regexp, I would be tempted to say
>
> 	diff.foo.funcname "Wine$"

The point is: to do that, you need to know that funcname exists, hence
read archives of the doc before 2008 (it disapeared in
45d9414fa5599b41578625961b53e18a9b9148c7) or read the code. And if I
read correctly the commit message for the commit, funcname is not
portable so you should use xfuncname anyway.

The real reason for this change is to let the code work with the new
git_config, but I think it's reasonable not to bother with the original
behavior for a feature deprecated so long ago.

That said, I think the commit message should be improved (recall the
drawbacks of funcname).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
