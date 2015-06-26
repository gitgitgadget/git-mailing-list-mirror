From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v10.1 5/7] bisect: simplify the addition of new bisect terms
Date: Fri, 26 Jun 2015 23:37:40 +0200
Message-ID: <vpqioaap2vv.fsf@anie.imag.fr>
References: <CAP8UFD1ofg01R1rEWk3MJweGAQsVc-yrgCH=fjJ_JeU_81yyTA@mail.gmail.com>
	<1435350769-10973-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq381etb1e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 23:37:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8bJp-0000c3-IY
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 23:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbbFZVht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 17:37:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46255 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265AbbFZVhs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 17:37:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5QLbcit011306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2015 23:37:38 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QLbeKk016492;
	Fri, 26 Jun 2015 23:37:40 +0200
In-Reply-To: <xmqq381etb1e.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 26 Jun 2015 14:27:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 26 Jun 2015 23:37:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5QLbcit011306
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435959461.69224@qtIlt2okU/vAcIiXNW00Fg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272830>

Junio C Hamano <gitster@pobox.com> writes:

>>  static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
>>  {
>> -	return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
>> +	return for_each_bisect_ref(submodule, fn, cb_data, "bad");
>>  }
>
> Shouldn't this be passing name_bad instead of "bad"?
>
>>  
>>  static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
>>  {
>> -	return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
>> +	return for_each_bisect_ref(submodule, fn, cb_data, "good");
>>  }
>
> Likewise.

Indeed. Fixed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
