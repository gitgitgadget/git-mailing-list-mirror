From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP/PATCH v5 05/10] for-each-ref: introduce 'ref_array_clear()'
Date: Mon, 08 Jun 2015 19:21:02 +0200
Message-ID: <vpqa8wat8u9.fsf@anie.imag.fr>
References: <55729B78.1070207@gmail.com>
	<1433574581-23980-1-git-send-email-karthik.188@gmail.com>
	<1433574581-23980-5-git-send-email-karthik.188@gmail.com>
	<vpqvbey6yli.fsf@anie.imag.fr> <5575B25A.6020608@gmail.com>
	<vpqbngq2mkw.fsf@anie.imag.fr>
	<xmqq3822cer4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:21:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20ja-00020g-VH
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbbFHRVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:21:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55551 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbbFHRVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:21:09 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t58HL0ZL019667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 19:21:00 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58HL260009695;
	Mon, 8 Jun 2015 19:21:02 +0200
In-Reply-To: <xmqq3822cer4.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 08 Jun 2015 10:05:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 08 Jun 2015 19:21:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58HL0ZL019667
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434388862.28945@bksDeNZJ+4X61HWGuvNBjg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271089>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> On 06/08/2015 08:23 PM, Matthieu Moy wrote:
>>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>>
>>>> > +/* Free all memory allocated for ref_array */
>>>> > +void ref_array_clear(struct ref_array *array)
>>>>
>>>> Is this a private function? If so, then add static. If not, you probably
>>>> want to export it in a .h file.
>>>>
>>> It is in ref-filter.h.
>>
>> Ah, OK. It comes later in the series.
>
> Confused I am; if it comes later not in the same patch then it is
> not OK, is it?

We could introduce ref-filter.h earlier, indeed. To me, the current
solution is good enough, but introducing ref-filter.h early and adding
function definition there in the same commit as you drop the "static"
keyword for them would clearly be an improvement.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
