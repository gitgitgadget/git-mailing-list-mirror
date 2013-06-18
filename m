From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Tue, 18 Jun 2013 16:33:04 +0200
Message-ID: <vpqppvjpjz3.fsf@anie.imag.fr>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
	<vpqsj0fr19j.fsf@anie.imag.fr>
	<CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
	<vpq7ghrqzrv.fsf@anie.imag.fr>
	<CACuz9s0=7z-M1-zgRNUs2hS-4LcuXrsWbqyDaMnuvFXRnP7E-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Alexander Nestorov <alexandernst@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 16:33:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UowyB-00034O-0Y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 16:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897Ab3FROdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 10:33:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41971 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292Ab3FROdK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 10:33:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5IEX3kJ031470
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 16:33:05 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Uowy1-0005Lu-1o; Tue, 18 Jun 2013 16:33:05 +0200
In-Reply-To: <CACuz9s0=7z-M1-zgRNUs2hS-4LcuXrsWbqyDaMnuvFXRnP7E-Q@mail.gmail.com>
	(Alexander Nestorov's message of "Tue, 18 Jun 2013 16:22:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Jun 2013 16:33:05 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228240>

[ The rule here is to keep everyone Cced, not just git@vger ]

Alexander Nestorov <alexandernst@gmail.com> writes:

> Indeed, "git update-index --refresh" before "git reset" did the trick :)
> Anyways, what about the proposal? Should it be implemented?

I'd say the current behavior is OK by default (it's not so common to
have stat-only changes, and re-checking the content would slow down the
other operations).

We could add a flag to "git reset" asking it to refresh the index before
continuing, but that would essentially end-up doing "git update-index
--refresh; git reset".

It would make more sense to me to add something about update-index in
the documentation of git reset. Patches welcome ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
