From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/2]  rm: better error message on failure for multiple files
Date: Mon, 10 Jun 2013 19:42:12 +0200
Message-ID: <vpqtxl5dfrf.fsf@anie.imag.fr>
References: <1370879981-18937-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	<7v8v2hkhqc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	git@vger.kernel.org,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 19:43:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um67S-0000xM-Gq
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 19:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351Ab3FJRm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 13:42:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43810 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754342Ab3FJRm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 13:42:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5AHgACF020355
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 19:42:10 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Um66e-0006FK-LK; Mon, 10 Jun 2013 19:42:12 +0200
In-Reply-To: <7v8v2hkhqc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 10 Jun 2013 10:17:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 19:42:10 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227334>

Junio C Hamano <gitster@pobox.com> writes:

>> +{
>> +	if (files_list->nr) {
>> +		struct strbuf err_msg = STRBUF_INIT;
>> +		int i;
>> +		strbuf_addstr(&err_msg, main_msg);
>> +		for (i = 0; i < files_list->nr; i++)
>> +			strbuf_addf(&err_msg,
>> +				    "\n    %s",
>
> Is there an implication of having always 4 spaces here to l10n/i18n
> here?  I am wondering if it should be _("\n    %s").

I'd say this is just formatting and should be the same in every
languages, but I'm far from an expert in the domain. Maybe some
right-to-left languages would need this.

>         test_expect_success 'rm files with different staged content' '
>                 cat >expect <<\-EOF &&

(that should be -\EOF, not \-EOF I think)

>  (2) by using a dash '-' before the end-of-here-text marker, you can
>      align the body of here text with a leading tab (HT).

This works because the list of files is aligned with spaces, but is
seems a bit fragile to me to use this -EOF on a text which uses
indentation. Anyway, I'm fine with both.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
