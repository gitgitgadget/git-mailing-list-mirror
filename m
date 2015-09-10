From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v17 06/14] ref-filter: implement an `align` atom
Date: Thu, 10 Sep 2015 18:53:09 +0200
Message-ID: <vpq37ymp66i.fsf@scolette.imag.fr>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441900110-4015-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 18:53:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za567-0000o1-KM
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 18:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbbIJQxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 12:53:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34444 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbbIJQxO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 12:53:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8AGr6EO017854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 10 Sep 2015 18:53:07 +0200
Received: from scolette (scolette.imag.fr [129.88.43.86])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8AGr9iX025192;
	Thu, 10 Sep 2015 18:53:09 +0200
In-Reply-To: <1441900110-4015-7-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 10 Sep 2015 21:18:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 10 Sep 2015 18:53:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8AGr6EO017854
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442508787.61721@aRmFj610mKheYmGHN02obg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277602>

Karthik Nayak <karthik.188@gmail.com> writes:

> +			/*
> +			 * TODO: Implement a function similar to strbuf_split_str()
> +			 * which would omit the separator from the end of each value.
> +			 */
> +			s = to_free = strbuf_split_str(valp, ',', 0);
> +
> +			align->position = ALIGN_LEFT;
> +
> +			while (*s) {
> +				if (s[1])

A comment like /* strip trailing ',' */ here would really help the
reader IMHO.

> +					strbuf_setlen(s[0], s[0]->len - 1);

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
