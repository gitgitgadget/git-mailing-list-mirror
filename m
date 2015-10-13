From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 01/44] refs.c: create a public version of verify_refname_available
Date: Tue, 13 Oct 2015 04:28:23 +0200
Message-ID: <561C6C47.7090108@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:35:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlpR6-0003F5-Ko
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 04:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbbJMCf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 22:35:29 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:50483 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752795AbbJMCf2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2015 22:35:28 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2015 22:35:27 EDT
X-AuditID: 12074411-f797e6d000007df3-e7-561c6c4a6aec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 29.8D.32243.A4C6C165; Mon, 12 Oct 2015 22:28:26 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9D2SNpg003606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 12 Oct 2015 22:28:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444686725-27660-2-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqOuVIxNm8OIEm8X8TScYLbqudDNZ
	/JtQ48DssWBTqceC5/fZPT5vkgtgjuK2SUosKQvOTM/Tt0vgzlhyYyJbwSTVitun/rE3ME6U
	7WLk5JAQMJHoe3CIHcIWk7hwbz1bFyMXh5DAZUaJ+Y9AEiDOWSaJ5sWnmECqeAW0JbYe2wrW
	wSKgKvH5/S8wm01AV2JRTzNYjahAkMSK5S8YIeoFJU7OfMICYosIOEhc3nWUGcRmFtCU2LTh
	BSuILSwQKXHi9TVGiGWtjBJ3drxhA0lwCnhKrL12lg2iQU9ix/VfrBC2vETz1tnMExgFZiHZ
	MQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrq5WaW6KWmlG5ihASv4A7GGSfl
	DjEKcDAq8fC+iJQJE2JNLCuuzD3EKMnBpCTKW5cJFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC
	ey4LKMebklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV4eBQkuDdlw3UKFiUmp5a
	kZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K1vhiYLyCpHiA9vqBtPMWFyTmAkUhWk8xKkqJ
	884ESQiAJDJK8+DGwlLSK0ZxoC+FeWeCnM0DTGdw3a+ABjMBDTZilwIZXJKIkJJqYGxX8mJT
	3npVWFpVpWblUqVSUX9n++XbdM69cKuWaaoX6xHzu7761mqpjS9LH87dLZTmZfXptS8z6+Q5
	BVF99Ws38FvExZrs8Zvqd13fZFbd/MV/9e7KPn74/o5dy2wXHu/G3/6ddZu2hXkd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279475>

On 10/12/2015 11:51 PM, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Create a public version of verify_refname_available that backends can
> provide.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.c | 65 ++++++++++++++++++++++++++++++-----------------------------------
>  refs.h | 17 +++++++++++++++++
>  2 files changed, 47 insertions(+), 35 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 132eff5..fe71ea0 100644
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
> @@ -897,25 +897,13 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
>  /*
>   * Return 0 if a reference named refname could be created without
>   * conflicting with the name of an existing reference in dir.
> - * Otherwise, return a negative value and write an explanation to err.
> - * If extras is non-NULL, it is a list of additional refnames with
> - * which refname is not allowed to conflict. If skip is non-NULL,
> - * ignore potential conflicts with refs in skip (e.g., because they
> - * are scheduled for deletion in the same operation). Behavior is
> - * undefined if the same name is listed in both extras and skip.
> - *
> - * Two reference names conflict if one of them exactly matches the
> - * leading components of the other; e.g., "refs/foo/bar" conflicts
> - * with both "refs/foo" and with "refs/foo/bar/baz" but not with
> - * "refs/foo/bar" or "refs/foo/barbados".
> - *
> - * extras and skip must be sorted.
> + * See verify_refname_available for details.
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
> @@ -2464,9 +2452,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  		 */
>  		strbuf_git_path(&orig_ref_file, "%s", orig_refname);
>  		if (remove_empty_directories(&orig_ref_file)) {
> +			struct ref_dir *loose_refs;
> +			loose_refs = get_loose_refs(&ref_cache);

It's OK to initialize `loose_refs` on the line where it is declared.

>  			last_errno = errno;
> -			if (!verify_refname_available(orig_refname, extras, skip,
> -						      get_loose_refs(&ref_cache), err))
> +			if (!verify_refname_available_dir(orig_refname, extras,
> +							  skip, loose_refs,
> +							  err))
>  				strbuf_addf(err, "there are still refs under '%s'",
>  					    orig_refname);
>  			goto error_return;
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
> +int verify_refname_available(const char *newname, struct string_list *extra,
> +			     struct string_list *skip, struct strbuf *err);

This function has an `extra` parameter but the description of this
parameter disappeared as the docstring was moved from refs.c to here.

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
