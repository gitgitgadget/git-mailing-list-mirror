From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Wed, 02 Sep 2015 19:10:46 +0200
Message-ID: <vpqio7slpbd.fsf@anie.imag.fr>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
	<xmqqegihrg6t.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQ0nyaQmvE3suT6hh0jO3s_iYxFLjSuLUY4STneMFJf9Q@mail.gmail.com>
	<xmqqd1y0q30g.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQLG_HB0trodXPCb9n4x2FuH7h7-+KJYLEdNZSpd0PHsg@mail.gmail.com>
	<xmqqy4goomdk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 19:10:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXBYm-0001cn-B7
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 19:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545AbbIBRKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 13:10:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56595 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754892AbbIBRKw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 13:10:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t82HAisF001216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 2 Sep 2015 19:10:44 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t82HAkZL030524;
	Wed, 2 Sep 2015 19:10:46 +0200
In-Reply-To: <xmqqy4goomdk.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 02 Sep 2015 08:45:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Sep 2015 19:10:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t82HAisF001216
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441818646.3176@dhHjCGlUdDbOlz61rswzWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277108>

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Wed, Sep 2, 2015 at 8:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>>>> +             die(_("format: `end` atom used without a supporting atom"));
>>>>>
>>>>> Not a show-stopper, but we may need some wordsmithing for "a
>>>>> supporting atom" here; an end-user would not know what it is.
>>>>
>>>> Probably something like "format: `end` atom should only be
>>>> used with modifier atoms".
>>>
>>> Between "supporting" and "modifier" I do not see much difference,
>>> though.
>>
>> I don't see how we could provide a better message, as %(end) atom
>> would be common to various atoms eventually.
>
> I said "not a show-stopper" without giving a suggestion exactly
> because I didn't (and I still don't) think either you or I can come
> up with a good wording ;-).  That is why the message was Cc'ed to
> the list for others to comment.

I don't really have a better proposal either. What we really mean is
"%(end) requires an atom that requires to be paired with %(end)", but
that wouldn't really help. I prefer "supporting" to "modifier":
To me, %(color:red) can be called a "modifier" by I wouldn't call %(if)
a modifier. "Supporting" is vague, but less misleading to me.

Perhaps "corresponding"? (not convinced myself ...)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
