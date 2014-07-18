From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v10 4/4] test-config: add tests for the config_set API
Date: Fri, 18 Jul 2014 23:52:40 +0200
Message-ID: <vpqwqba1gif.fsf@anie.imag.fr>
References: <1405675142-20300-1-git-send-email-tanayabh@gmail.com>
	<1405675142-20300-5-git-send-email-tanayabh@gmail.com>
	<xmqqzjg6mwhm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 23:53:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8G6F-0006jS-2w
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 23:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755680AbaGRVxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 17:53:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55920 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210AbaGRVxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 17:53:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6ILqcO2016726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Jul 2014 23:52:38 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6ILqeP8027868;
	Fri, 18 Jul 2014 23:52:40 +0200
In-Reply-To: <xmqqzjg6mwhm.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 18 Jul 2014 10:01:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 18 Jul 2014 23:52:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6ILqcO2016726
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406325162.65864@3oiUU/kq0PJUxHMI9Dlv4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253850>

Junio C Hamano <gitster@pobox.com> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> +test_expect_success 'proper error on non-existant files' '
>> +	echo "Error (-1) reading configuration file non-existant-file." >expect &&
>
> s/tant/tent/ perhaps?
> cf. http://en.wiktionary.org/wiki/non-existant

It seems so. My bad.

>> +test_expect_success 'proper error on non-accessible files' '
>> +	chmod -r .git/config &&
>> +	test_when_finished "chmod +r .git/config" &&
>> +	echo "Error (-1) reading configuration file .git/config." >expect &&
>> +	test_expect_code 2 test-config configset_get_value foo.bar .git/config 2>actual &&
>> +	test_cmp expect actual
>> +'
>
> Doesn't this one need some prerequisite?

My bad too ;-). There should have been SANITY,POSIXPERM I guess (Tanay:
search "prereq" in t/README if you don't see what we're talking about).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
