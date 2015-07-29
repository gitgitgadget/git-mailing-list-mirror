From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 04/11] ref-filter: add 'ifexists' atom
Date: Wed, 29 Jul 2015 23:21:14 +0200
Message-ID: <vpqh9omek39.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
	<xmqq8ua0f9lk.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZTUJHnXWJyr0wp0CZgR9S1pBxCEsGRiDPsJdUyzTZaZUw@mail.gmail.com>
	<xmqqy4hy973q.fsf@gitster.dls.corp.google.com>
	<xmqqtwsm94j1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 23:21:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKYn0-000211-P7
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 23:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbbG2VVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 17:21:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45866 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753434AbbG2VVW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 17:21:22 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TLLBkm025200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jul 2015 23:21:11 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TLLEcg024044;
	Wed, 29 Jul 2015 23:21:14 +0200
In-Reply-To: <xmqqtwsm94j1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 29 Jul 2015 11:56:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 29 Jul 2015 23:21:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6TLLBkm025200
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438809674.92783@3KETfBeqCUErUCerhUbmRw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274955>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Couldn't think of a better replacer, any suggestions would be welcome :)
>>
>> See below.
>> ...
>> One way to do all of the above is ...
>
> Note that is just "one way", not the only or not necessarily the
> best.  It certainly is not the easiest, I think.
>
>     %(if:atom)...%(endif)
>
> might be easier to implement.

And I find it easier to read or write too. Nested parenthesis in a
format string make them really tricky. That removes the need for
escaping since the content of the if/endif is a format string like the
others, it can use the same escaping rules (IIRC, %% to escape a %).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
