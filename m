From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v15 11/13] tag.c: use 'ref-filter' APIs
Date: Wed, 02 Sep 2015 11:09:28 +0200
Message-ID: <vpq4mjdtcfr.fsf@anie.imag.fr>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-12-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 11:09:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX430-0003Ac-2P
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 11:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbbIBJJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 05:09:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45963 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752625AbbIBJJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 05:09:33 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8299R7d010730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 2 Sep 2015 11:09:27 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8299SJP021587;
	Wed, 2 Sep 2015 11:09:28 +0200
In-Reply-To: <1441131994-13508-12-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 1 Sep 2015 23:56:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Sep 2015 11:09:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8299R7d010730
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441789768.16295@s4Pjgn+UmFLArHeoxvSeDQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277085>

Karthik Nayak <karthik.188@gmail.com> writes:

> +	if (filter->lines)
> +		format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
> +					   filter->lines);
> +	else
> +		format = "%(refname:short)";
> +
> +	verify_ref_format(format);
> +	filter_refs(&array, filter, FILTER_REFS_TAGS);
> +	ref_array_sort(sorting, &array);
> +
> +	for (i = 0; i < array.nr; i++)
> +		show_ref_array_item(array.items[i], format, 0);

Nice :-).

(I'd cut the string argument to xstrfmt after "%(end)" to avoid long
line)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
