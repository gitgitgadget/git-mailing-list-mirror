From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 04/10] ref-filter: modify "%(objectname:short)" to take length
Date: Sun, 11 Oct 2015 18:05:22 +0200
Message-ID: <vpqlhb92xx9.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<1444295885-1657-5-git-send-email-Karthik.188@gmail.com>
	<vpqh9m1mbln.fsf@grenoble-inp.fr>
	<CAOLa=ZT8YydU-4HH2migNewtiAvB=wOCWx2TGV+Y+8YVHCdaNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 18:06:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlJ8Q-00020r-3q
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 18:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbbJKQFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 12:05:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50245 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612AbbJKQFb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 12:05:31 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9BG5LNc027667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 11 Oct 2015 18:05:21 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9BG5MWU023443;
	Sun, 11 Oct 2015 18:05:22 +0200
In-Reply-To: <CAOLa=ZT8YydU-4HH2migNewtiAvB=wOCWx2TGV+Y+8YVHCdaNQ@mail.gmail.com>
	(Karthik Nayak's message of "Sat, 10 Oct 2015 23:45:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 11 Oct 2015 18:05:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9BG5LNc027667
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445184325.54312@5Mx6OFb6Rn2Gl27yVSIXGw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279338>

Karthik Nayak <karthik.188@gmail.com> writes:

>>> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
>>> index 7c9bec7..6fc569e 100755
>>> --- a/t/t6300-for-each-ref.sh
>>> +++ b/t/t6300-for-each-ref.sh
>>> @@ -385,6 +385,28 @@ test_expect_success 'Check short objectname format' '
>>>       test_cmp expected actual
>>>  '
>>>
>>> +cat >expected <<EOF
>>> +$(git rev-parse --short=1 HEAD)
>>> +EOF
>>
>> Please write all code within test_expect_success including this
>> (t/README:
>>
>>  - Put all code inside test_expect_success and other assertions.
>>
>>    Even code that isn't a test per se, but merely some setup code
>>    should be inside a test assertion.
>> ).
>>
>
> Was just following the previous syntax, should have read that. fixed it

The common practice (not necessarily a rule, though) when you write code
next to other code that does not follow the style is:

* If it's not too disturbing, adopt the new style and keep the old code
  as-is. I think we are in this case.

* If the new and the old style do not mix well, prepend a "modernize
  style" patch to the series, and adopt the new style in the patch
  itself.

* If you're too lazy to do a "modernize style", adopt the old style for
  consistency.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
