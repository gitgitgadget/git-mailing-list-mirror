From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] introduce git root
Date: Thu, 04 Dec 2014 21:00:35 +0100
Message-ID: <vpqegsfchi4.fsf@anie.imag.fr>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com>
	<2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
	<CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
	<vpqoaro99xd.fsf@anie.imag.fr>
	<xmqqd284rryz.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
	<20141202070415.GC1948@peff.net>
	<xmqqd282m09j.fsf@gitster.dls.corp.google.com>
	<20141204092251.GC27455@peff.net>
	<xmqqlhmntf02.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 21:01:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwcaB-0000YQ-BA
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 21:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbaLDUAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 15:00:55 -0500
Received: from mx2.imag.fr ([129.88.30.17]:48650 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753877AbaLDUAy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 15:00:54 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id sB4K0Wgq012399
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 4 Dec 2014 21:00:33 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id sB4K0ZlA011911;
	Thu, 4 Dec 2014 21:00:35 +0100
In-Reply-To: <xmqqlhmntf02.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 04 Dec 2014 11:02:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 04 Dec 2014 21:00:33 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: sB4K0Wgq012399
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1418328036.62892@CBz7+10gtsK237GIIGzTrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260791>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Christian raised the issue of cluttering the "git --option"
>> namespace,
>> and I do agree that's a potential issue. 
>
> I am not sure if that is an issue at all. You will need the same
> number of options to cover all the necessary "computables" somewhere
> anyway.
>
> "git --show-this-or-that-computable" is not more or not less
> cluttering compared to "git var --show-this-or-that-computable".

I disagree.

Right now, a user reading "man git" sees --version, --help, -C,
--exec-path, --html-path, --man-path, ... at a flat list (it's actually
the first thing he can read from the man page).

The point of having commands is to make the features hierarchic. "git
rebase" do many things, but these things are all grouped under the
command "git rebase".

Indeed, I would find "git var" to be a nice place to group the "show me
such or such path". Not sure it's worth the trouble of changing the
existing "git --*-path", but I think "git var" should be the place for
new things.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
