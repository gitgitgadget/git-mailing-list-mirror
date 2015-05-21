From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Thu, 21 May 2015 10:47:41 +0200
Message-ID: <vpqr3qagvv6.fsf@anie.imag.fr>
References: <555C88C2.8060902@gmail.com>
	<1432127904-21070-2-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 10:47:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvM8y-0004od-Ep
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 10:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbbEUIrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 04:47:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51888 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbbEUIro (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 04:47:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4L8leZY002822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 May 2015 10:47:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4L8lfPU031750;
	Thu, 21 May 2015 10:47:41 +0200
In-Reply-To: <1432127904-21070-2-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 20 May 2015 18:48:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 21 May 2015 10:47:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4L8leZY002822
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432802861.29913@nyzgxTqM1Nnll/oGELUQ1Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269572>

Karthik Nayak <karthik.188@gmail.com> writes:

> +static int match_name_as_path(const char **pattern, const char *refname)

I would have appreciated a short docstring. The full doc would probably
be as long as the code, but a few examples of what matches and what
doesn't can help the reader.

> +static struct ref_filter_item *new_ref_filter_item(const char *refname,
> +						   const unsigned char *sha1,
> +						   int flag)
> +{
> +	struct ref_filter_item *ref =  xcalloc(1, sizeof(struct ref_filter_item));

double-space after =.

> +++ b/ref-filter.h
> @@ -0,0 +1,47 @@
> +#ifndef REF_FILTER_H
> +#define REF_FILTER_H
> +
> +#include "sha1-array.h"
> +#include "refs.h"
> +#include "commit.h"
> +
> +/*
> + * ref-filter is meant to act as a common provider of API's for
> + * 'tag -l', 'branch -l' and 'for-each-ref'. ref-filter is the attempt

Don't be shy: attempt at unification -> unification. This message may be
an attempt, but we'll polish it until it is more than that.

> + * at unification of these three commands so that they ay benefit from

they *may*?

> + * the functionality of each other.
> + */

I miss a high-level description of what the code is doing. Essentially,
there's the complete repository list of refs, and you want to filter
only some of them, right?

>From the name, I would guess that ref_filter is the structure describing
how you are filtering, but from the code it seems to be the list you're
filtering, not the filter.

> +/* An atom is a valid field atom used for sorting and formatting of refs.*/

"used for" is very vague. Be more precise, say how it will be involved
in sorting & formatting.

> +/*  ref_filter will hold data pertaining to a list of refs. */

This is the answer to the "what?" question, which is not very hard to
infer from the code. That's not anwsering "what for?" or "why?", which
are much harder to infer for the reader.

(plus you have a double-space after /*)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
