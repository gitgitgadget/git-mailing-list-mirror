From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 6/7] t5520: reduce commom lines of code
Date: Sun, 3 Apr 2016 08:46:42 +0200
Message-ID: <5700BC52.1040404@kdbg.org>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
 <1459619912-5445-7-git-send-email-mehul.jain2029@gmail.com>
 <5700145E.4060308@kdbg.org>
 <CA+DCAeT4rF2dqL9iU9WYQJuxiSYstY9AaT2Hc7OvhmFNyKEgAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 08:50:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ambru-0006UD-Cq
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 08:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbcDCGqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 02:46:47 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:44349 "EHLO bsmtp2.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbcDCGqr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 02:46:47 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 3qd5J44HdNz5tlB;
	Sun,  3 Apr 2016 08:46:44 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 7F9755218;
	Sun,  3 Apr 2016 08:46:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <CA+DCAeT4rF2dqL9iU9WYQJuxiSYstY9AaT2Hc7OvhmFNyKEgAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290632>

Am 03.04.2016 um 08:24 schrieb Mehul Jain:
> On Sun, Apr 3, 2016 at 12:20 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 02.04.2016 um 19:58 schrieb Mehul Jain:
>>> +for i in --autostash --no-autostash
>>> +do
>>> +       test_expect_success "pull $i (without --rebase) is illegal" '
>>> +               test_must_fail git pull $i . copy 2>err &&
>>> +               test_i18ngrep "only valid with --rebase" err
>>> +       '
>>> +done
>>
>>
>> Hm. If the implementation of test_expect_success uses the variable, too, its
>> value is lost when the test snippet runs. Fortunately, it does not.
>>
>> You can make this code a bit more robust by using double-quotes around the
>> test code so that $i is expanded before test_expect_success is evaluated.
>
> I think that the current format is preferred over the one you suggest.
> Here[1] Junio
> has given a descriptive explanation.
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/283350/focus=284769

Junio has a point there, of course.

In this light, I suggest that you use a more verbose variable name.

-- Hannes
