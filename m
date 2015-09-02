From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Wed, 02 Sep 2015 17:50:57 +0200
Message-ID: <vpqoahkom5a.fsf@anie.imag.fr>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
	<vpqvbbttdjm.fsf@anie.imag.fr>
	<CAOLa=ZQxWO6+_N6TKgZ09HVGiNNDy29p6kU56Y2TX8Y+kYTcsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 17:51:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXAJm-0002fg-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 17:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348AbbIBPvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 11:51:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55173 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786AbbIBPvG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 11:51:06 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t82FotRo022982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 2 Sep 2015 17:50:56 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t82FovwX029326;
	Wed, 2 Sep 2015 17:50:57 +0200
In-Reply-To: <CAOLa=ZQxWO6+_N6TKgZ09HVGiNNDy29p6kU56Y2TX8Y+kYTcsA@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 2 Sep 2015 18:42:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Sep 2015 17:50:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t82FotRo022982
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441813856.59751@ldRWN+XA6nca+dRwo5PmdA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277102>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Wed, Sep 2, 2015 at 2:15 PM, Matthieu Moy
>>> @@ -754,6 +816,42 @@ static void populate_value(struct ref_array_item *ref)
>>>                       else
>>>                               v->s = " ";
>>>                       continue;
>>> +             } else if (skip_prefix(name, "align", &valp)) {
>>> +                     struct align *align = &v->align;
>>> +                     struct strbuf **s;
>>> +
>>> +                     if (valp[0] != ':')
>>> +                             die(_("format: usage %%(align:<width>,<position>)"));
>>> +                     else
>>> +                             valp++;
>>
>> I agree with Junio that skip_prefix(name, "align:" ...) is simpler for
>> the same thing.
>
> Correct me if mistaken, but Junio wanted the first skip_prefix to
> check for "align:" rather than "align", but that would mean we don't have
> the error printing.
>
> Are you sure we want to skip that?

See my other message: you convinced me ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
