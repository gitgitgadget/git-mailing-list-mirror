From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 05/10] ref-filter: add option to match literal pattern
Date: Sat, 11 Jul 2015 11:26:50 +0200
Message-ID: <vpqvbdryrhh.fsf@anie.imag.fr>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
	<1436437671-25600-1-git-send-email-karthik.188@gmail.com>
	<1436437671-25600-5-git-send-email-karthik.188@gmail.com>
	<xmqqfv4wklph.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZT+59dcCW+QHhvK8Wp5Q_1YhkfCxV0=PirOWtVKWFCvCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 11:27:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDr3q-0000uM-1s
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 11:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbbGKJ07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 05:26:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58131 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753371AbbGKJ07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 05:26:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6B9QoV5008193
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 11 Jul 2015 11:26:50 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6B9Qosj020651;
	Sat, 11 Jul 2015 11:26:50 +0200
In-Reply-To: <CAOLa=ZT+59dcCW+QHhvK8Wp5Q_1YhkfCxV0=PirOWtVKWFCvCw@mail.gmail.com>
	(Karthik Nayak's message of "Sat, 11 Jul 2015 11:25:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 11 Jul 2015 11:26:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6B9QoV5008193
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1437211613.20851@Om+k+t+sml8xfG0MtmABJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273870>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Fri, Jul 10, 2015 at 10:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> Since 'ref-filter' only has an option to match path names
>>> add an option for regular pattern matching.
>>
>> There is nothing "regular" about the pattern matching you are
>> adding.
>>
>> Everywhere else we use patterns on refs we call wildmatch(), which
>> is an enhanced implementation of fnmatch(3), and you are doing the
>> same in this new codepath.
>>
>> Just drop that word from here (and if you said something similar in
>> the documentation, drop "regular" ffrom there as well).  It would
>> invite confusion with regular expression matching, which we will not
>> do for refs.
>
> Ok, will do. Thanks

Just dropping "regular" leads to a strange sentence, since the path name
match is also a kind of pattern-matching. I'd write

Since 'ref-filter' only has an option to match path names, add an option
for plain fnmatch pattern-matching.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
