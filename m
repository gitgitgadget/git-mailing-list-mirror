From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 3/5] bisect: simplify the addition of new bisect terms
Date: Wed, 24 Jun 2015 23:26:32 +0200
Message-ID: <vpqbng43iif.fsf@anie.imag.fr>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435159062-23468-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435159062-23468-4-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqegl19frm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 23:26:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7sBx-0007KO-Bj
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 23:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbbFXV0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 17:26:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49745 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbbFXV0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 17:26:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5OLQUWG022361
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 24 Jun 2015 23:26:30 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5OLQXPx002778;
	Wed, 24 Jun 2015 23:26:33 +0200
In-Reply-To: <xmqqegl19frm.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 24 Jun 2015 10:29:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 24 Jun 2015 23:26:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5OLQUWG022361
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435785992.80952@mE5Xbj/fB37lgee9/KKaJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272608>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> diff --git a/bisect.c b/bisect.c
>> index 2d3dbdc..08be634 100644
>> --- a/bisect.c
>> +++ b/bisect.c
>> @@ -747,7 +747,10 @@ static void handle_bad_merge_base(void)
>>  				"between %s and [%s].\n",
>>  				bad_hex, bad_hex, good_hex);
>>  		} else {
>> -			die("BUG: terms %s/%s not managed", name_bad, name_good);
>> +			fprintf(stderr, "The merge base %s is %s.\n"
>> +				"This means the first commit marked %s is "
>> +				"between %s and [%s].\n",
>> +				bad_hex, name_bad, name_bad, bad_hex, good_hex);

Indeed, I forgot to apply the previous remark. Fixed.

> -		if (!strcmp(name_bad, "bad")) {
> +		if (!strcmp(name_bad, "bad") && !strcmp(name_good, "good") {

Indeed. Applied.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
