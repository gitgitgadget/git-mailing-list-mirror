From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 09/11] ref-filter: move code from 'for-each-ref'
Date: Mon, 08 Jun 2015 19:08:33 +0200
Message-ID: <vpq4mmiw2jy.fsf@anie.imag.fr>
References: <1433598496-31287-9-git-send-email-karthik.188@gmail.com>
	<1433673294-16243-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:08:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20XT-0007RZ-0E
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbbFHRIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:08:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40003 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbbFHRIi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:08:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t58H8VmY009335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 19:08:32 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58H8X03009406;
	Mon, 8 Jun 2015 19:08:33 +0200
In-Reply-To: <1433673294-16243-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 7 Jun 2015 16:04:54 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 08 Jun 2015 19:08:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58H8VmY009335
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434388113.81876@m5L8443jYp/IOVH3OAj6Og
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271083>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -1129,7 +56,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  
>  	memset(&ref_cbdata, 0, sizeof(ref_cbdata));
>  	ref_cbdata.filter.name_patterns = argv;
> -	for_each_rawref(ref_filter_handler, &ref_cbdata);
> +	filter_refs(for_each_rawref, &ref_cbdata);

This seems unrelated from the rest of the patch. And you haven't
introduced filter_refs yet!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
