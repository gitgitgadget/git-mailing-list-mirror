From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 01/43] refs.c: create a public version of verify_refname_available
Date: Mon, 05 Oct 2015 06:29:24 +0200
Message-ID: <5611FCA4.9030809@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com> <1443477738-32023-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 06:36:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZixVy-000651-3f
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 06:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbbJEEgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 00:36:38 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:45250 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750793AbbJEEgh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 00:36:37 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2015 00:36:37 EDT
X-AuditID: 1207440f-f79df6d000007c0f-84-5611fca69186
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 92.F6.31759.6ACF1165; Mon,  5 Oct 2015 00:29:26 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E0C.dip0.t-ipconnect.de [79.201.110.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t954TOAA022556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 Oct 2015 00:29:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1443477738-32023-2-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLvsj2CYweGpHBbzN51gtOi60s1k
	8W9CjQOzx4JNpR4Lnt9n9/i8SS6AOYrbJimxpCw4Mz1P3y6BO6Pp2xO2gtuSFS927WBuYJwn
	0sXIySEhYCLx+/saRghbTOLCvfVsILaQwGVGib5rjl2MXED2OSaJtaeb2UESvALaEv1Hp7KC
	2CwCqhLPz75iBrHZBHQlFvU0M4HYogJBEiuWv2CEqBeUODnzCQuILSLgIHF511GwemYBTYlN
	G16AzREWiJT4s6KZBWJZK6PEgWUbwIo4BTwlTm46zgrRoCex4/ovKFteYvvbOcwTGAVmIdkx
	C0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmujlZpbopaaUbmKEhC7/Dsau9TKH
	GAU4GJV4eA/EC4YJsSaWFVfmHmKU5GBSEuUNVQMK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuH9
	/g4ox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4D33G6hRsCg1PbUi
	LTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSr8cXAaAVJ8QDtfQjSzltckJgLFIVoPcWoKCXO
	2w2SEABJZJTmwY2FJaRXjOJAXwrzNoJU8QCTGVz3K6DBTECDFxjygQwuSURISTUwWjp93S1+
	t4Yhy3mawd333/13hDoVzH2dFS7Qpb5vscyBJUvexzx0fLKr68qC3Pt6c04cnbn3tsWWw6Hv
	Xqg21W/93BkbHMRWKrQlvul/g3MpN8/75++zTuv151++YvHgg9SaD9YnM6yOHRHq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279034>

On 09/29/2015 12:01 AM, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Create a public version of verify_refname_available that backends can
> provide.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.c | 51 +++++++++++++++++++++++++++++----------------------
>  refs.h | 17 +++++++++++++++++
>  2 files changed, 46 insertions(+), 22 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 132eff5..ce551e9 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -279,7 +279,7 @@ struct ref_dir {
>   * presence of an empty subdirectory does not block the creation of a
>   * similarly-named reference.  (The fact that reference names with the
>   * same leading components can conflict *with each other* is a
> - * separate issue that is regulated by verify_refname_available().)
> + * separate issue that is regulated by verify_refname_available_dir().)
>   *
>   * Please note that the name field contains the fully-qualified
>   * reference (or subdirectory) name.  Space could be saved by only
> @@ -911,11 +911,11 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
>   *
>   * extras and skip must be sorted.
>   */
> -static int verify_refname_available(const char *refname,
> -				    const struct string_list *extras,
> -				    const struct string_list *skip,
> -				    struct ref_dir *dir,
> -				    struct strbuf *err)
> +static int verify_refname_available_dir(const char *refname,
> +					const struct string_list *extras,
> +					const struct string_list *skip,
> +					struct ref_dir *dir,
> +					struct strbuf *err)
>  {
>  	const char *slash;
>  	int pos;
> [...]
> diff --git a/refs.h b/refs.h
> index 6d30c98..79ea220 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -218,6 +218,23 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
>  int pack_refs(unsigned int flags);
>  
>  /*
> + * Return true iff a reference named refname could be created without
> + * conflicting with the name of an existing reference.  If
> + * skip is non-NULL, ignore potential conflicts with refs in skip
> + * (e.g., because they are scheduled for deletion in the same
> + * operation).
> + *
> + * Two reference names conflict if one of them exactly matches the
> + * leading components of the other; e.g., "foo/bar" conflicts with
> + * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
> + * "foo/barbados".
> + *
> + * skip must be sorted.
> + */

This comment is approximately a copy of the comment for
verify_refname_available_dir(). It seems unnecessary to keep both of
them (and is also a small maintenance burden). I suggest you shorten the
comment at verify_refname_available_dir() and make it refer to the
comment for this function for the details.

> +int verify_refname_available(const char *newname, struct string_list *extra,
> +			     struct string_list *skip, struct strbuf *err);
> +
> +/*
>   * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
>   * REF_NODEREF: act on the ref directly, instead of dereferencing
>   *              symbolic references.
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
