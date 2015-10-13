From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 25/44] refs.h: document make refname_is_safe and add
 it to header
Date: Tue, 13 Oct 2015 09:33:24 +0200
Message-ID: <561CB3C4.1010208@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-27-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 09:33:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlu5a-0001yr-CU
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 09:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbbJMHde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 03:33:34 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:55271 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751779AbbJMHdc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 03:33:32 -0400
X-AuditID: 1207440c-f79e16d000002a6e-c5-561cb3c6c943
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 9B.B0.10862.6C3BC165; Tue, 13 Oct 2015 03:33:26 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9D7XOK9017212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 13 Oct 2015 03:33:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444686725-27660-27-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixO6iqHtss0yYwbo7XBbzN51gtOi60s3k
	wOSx4Pl9do/Pm+QCmKK4bZISS8qCM9Pz9O0SuDNmtO1gKZjCXbHv3kH2BsbrHF2MnBwSAiYS
	E/a9YoOwxSQu3FsPZHNxCAlcZpQ49rkDyjnLJPF492ZGkCpeAW2J1gezWUFsFgFVievTeplB
	bDYBXYlFPc1MILaoQJDEiuUvoOoFJU7OfMICYosIOEhc3nUUrF5YIEpi5+sPrBAL2hglOl4d
	BNrGwcEp4CVx60Y6SA2zgJ7Ejuu/WCFseYntb+cwT2Dkn4Vk7CwkZbOQlC1gZF7FKJeYU5qr
	m5uYmVOcmqxbnJyYl5dapGuol5tZopeaUrqJERKSPDsYv62TOcQowMGoxMP7IlImTIg1say4
	MvcQoyQHk5Io7+kNQCG+pPyUyozE4oz4otKc1OJDjBIczEoivEktQDnelMTKqtSifJiUNAeL
	kjiv6hJ1PyGB9MSS1OzU1ILUIpisDAeHkgSv6CagRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8
	lNSixNKSjHhQTMYXA6MSJMUDtLcXpJ23uCAxFygK0XqKUVFKnFcMJCEAksgozYMbC0s0rxjF
	gb4U5g0BqeIBJim47ldAg5mABhuxS4EMLklESEk1MDrvNRDWWeXHMFv42lWWMF2/iRHlf6/q
	7jG8dDQ+4fGcdNe+dZPkLu7nfvXsps7OvuP9R9etu3H05Nq0WZ++fq6bM9kqz+DqtQl2qnXT
	3hx/YGZlUxPh5/RW9+ocL9vzt0PnZWawymszOS2sav1+xPn4ygOh15etCq6v2rB4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279485>

On 10/12/2015 11:51 PM, David Turner wrote:
> This function might be used by other refs backends
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/refs.h b/refs.h
> index fc8a748..7a936e2 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -348,6 +348,17 @@ int verify_refname_available(const char *newname, struct string_list *extra,
>  			     struct string_list *skip, struct strbuf *err);
>  
>  /*
> + * Check if a refname is safe.
> + * For refs that start with "refs/" we consider it safe as long they do
> + * not try to resolve to outside of refs/.
> + *
> + * For all other refs we only consider them safe iff they only contain
> + * upper case characters and '_' (like "HEAD" AND "MERGE_HEAD", and not like
> + * "config").
> + */
> +int refname_is_safe(const char *refname);
> +
> +/*
>   * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
>   * REF_NODEREF: act on the ref directly, instead of dereferencing
>   *              symbolic references.
> 

The previous commit deleted this comment from where it previously
appeared in refs-be-files.c. It would make more sense to squash this
commit onto that one so it's clear that you are moving the comment
rather than creating a new comment out of thin air.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
