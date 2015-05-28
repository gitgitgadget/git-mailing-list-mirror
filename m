From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/WIP v3 1/4] for-each-ref: extract helper functions out of grab_single_ref()
Date: Thu, 28 May 2015 22:13:32 +0200
Message-ID: <vpqr3q0o3yr.fsf@anie.imag.fr>
References: <5567527A.6090607@gmail.com>
	<1432835025-13291-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 22:13:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy4BS-0001PX-H3
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 22:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337AbbE1UNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 16:13:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37825 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271AbbE1UNh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 16:13:37 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SKDTxA009964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2015 22:13:29 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SKDWaK017691;
	Thu, 28 May 2015 22:13:32 +0200
In-Reply-To: <1432835025-13291-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 28 May 2015 23:13:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 28 May 2015 22:13:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4SKDTxA009964
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433448811.04286@gxU98BTyWe6aN8TAvh7Rhw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270189>

Karthik Nayak <karthik.188@gmail.com> writes:

> This is a preperatory patch for restructuring 'for-each-ref' and
> evntually moving most of it to 'ref-filter' to provide the

s/evntually/eventually/

The patch looks much nicer now.

> -	int cnt;
> [...]
> +	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
> +	cb->grab_array[cb->grab_cnt++] = ref;
>  
> -	cnt = cb->grab_cnt;
> -	REALLOC_ARRAY(cb->grab_array, cnt + 1);
> -	cb->grab_array[cnt++] = ref;
> -	cb->grab_cnt = cnt;

This hunk is not advertized in the commit message, and I had to fight a
bit to understand what it does with "we're extracting helper functions"
in mind. It would have been much easier to review in a separate patch
entitled "for-each-ref: simplify code" for example.

But I agree that your version is simpler indeed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
