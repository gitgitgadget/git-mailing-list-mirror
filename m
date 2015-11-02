From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 25/26] refs: break out ref conflict checks
Date: Mon, 02 Nov 2015 17:52:01 +0100
Message-ID: <563794B1.5000002@alum.mit.edu>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com> <1445998467-11511-26-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 17:59:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtIRw-0005Uc-RT
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 17:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbbKBQ7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 11:59:11 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:55269 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752887AbbKBQ7I (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2015 11:59:08 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2015 11:59:08 EST
X-AuditID: 12074412-f79a76d000007c8b-0e-563794b4b33e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 26.53.31883.4B497365; Mon,  2 Nov 2015 11:52:04 -0500 (EST)
Received: from [192.168.69.130] (p4FC972AE.dip0.t-ipconnect.de [79.201.114.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA2Gq1VL003530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 2 Nov 2015 11:52:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1445998467-11511-26-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLtlinmYwaMDKhbzN51gtOi60s1k
	0dB7hdmB2ePiJWWPBc/vs3t83iQXwBzFbZOUWFIWnJmep2+XwJ2x9fZ/1oKvihUPLjxnamBc
	ItXFyMEhIWAisX25dBcjJ5ApJnHh3nq2LkYuDiGBy4wSZ6edZIVwzjNJ/P64kxWkildAW2LZ
	r0Z2kGYWAVWJP285QMJsAroSi3qamUBsUYEgiRXLXzBClAtKnJz5hAXEFhFwkLi86ygziM0s
	oCZxaMkjsBphAUeJReenMEPsamOU2LdoJlgRp4CXxIQni1ghGvQkdlz/BWXLSzRvnc08gVFg
	FpIds5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrplebmaJXmpK6SZGSOgK7WBc
	f1LuEKMAB6MSD2+Gu1mYEGtiWXFl7iFGSQ4mJVFe3knmYUJ8SfkplRmJxRnxRaU5qcWHGCU4
	mJVEeM/1A+V4UxIrq1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFkZTg4lCR4WyYDNQoW
	paanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDIjW+GBirICkeoL1TQNp5iwsSc4GiEK2n
	GBWlxHk3gyQEQBIZpXlwY2EJ6RWjONCXwrwNIFU8wGQG1/0KaDAT0ODwbaYgg0sSEVJSDYy2
	rGWTN+14onRsvsO/rKRr9x+Xt29tO75hUvet6WYf7nvLMPMujO8+9uCb1MFctXXW208rRast
	mZN84mBhq9+2Z3xiordfvMk0MpppMtN4G/+RBfMym9csNwt+aszxO+1z0eMTC1bu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280699>

On 10/28/2015 03:14 AM, David Turner wrote:
> Create new function verify_no_descendants, to hold one of the ref
> conflict checks used in verify_refname_available.  Multiple backends
> will need this function, so it goes in the common code.
> 
> rename_ref_available also moves to the common code, because alternate
> backends might need it and it has no files-backend-specific code.

It is preferred that log messages be written in the imperative voice:

    ... so move it to the common code.

    Also move rename_ref_available ...

> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs-be-files.c | 49 ++++++++-----------------------------------------
>  refs.c          | 38 ++++++++++++++++++++++++++++++++++++++
>  refs.h          | 15 +++++++++++++++
>  3 files changed, 61 insertions(+), 41 deletions(-)
> 
> diff --git a/refs-be-files.c b/refs-be-files.c
> index 0eabea9..97a5983 100644
> --- a/refs-be-files.c
> +++ b/refs-be-files.c
> @@ -729,6 +729,7 @@ static int verify_refname_available_dir(const char *refname,
>  					struct strbuf *err)
>  {
>  	const char *slash;
> +	const char *extra_refname;
>  	int pos;
>  	struct strbuf dirname = STRBUF_INIT;
>  	int ret = -1;
> @@ -834,33 +835,15 @@ static int verify_refname_available_dir(const char *refname,
>  		}
>  	}
>  
> -	if (extras) {
> -		/*
> -		 * Check for entries in extras that start with
> -		 * "$refname/". We do that by looking for the place
> -		 * where "$refname/" would be inserted in extras. If
> -		 * there is an entry at that position that starts with
> -		 * "$refname/" and is not in skip, then we have a
> -		 * conflict.
> -		 */

In your version, the above comment is replaced with

    /* Look for the place where dirname would be inserted in extras. */

which is pretty obvious, I think, from the following line. It's
debatable whether the long-winded old comment was worthwhile, but I
think the new comment is clearly not. I suggest either restoring a
longer explanation or eliminating the comment altogether.

> -		for (pos = string_list_find_insert_index(extras, dirname.buf, 0);
> -		     pos < extras->nr; pos++) {
> -			const char *extra_refname = extras->items[pos].string;
> -
> -			if (!starts_with(extra_refname, dirname.buf))
> -				break;
> -
> -			if (!skip || !string_list_has_string(skip, extra_refname)) {
> -				strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
> -					    refname, extra_refname);
> -				goto cleanup;
> -			}
> -		}
> +	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
> +	if (extra_refname) {
> +		strbuf_addf(err,
> +			    "cannot process '%s' and '%s' at the same time",
> +			    refname, extra_refname);
> +	} else {
> +		ret = 0;
>  	}

Project practice is to leave out unnecessary braces.

>  
> -	/* No conflicts were found */
> -	ret = 0;
> -
>  cleanup:
>  	strbuf_release(&dirname);
>  	return ret;
> @@ -2460,22 +2443,6 @@ out:
> [...]
> diff --git a/refs.c b/refs.c
> index 056c172..5d8b6ea 100644
> --- a/refs.c
> +++ b/refs.c
> [...]
> diff --git a/refs.h b/refs.h
> index f97a2e4..88fea3e 100644
> --- a/refs.h
> +++ b/refs.h
> [...]
> @@ -623,6 +625,19 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
>  			const unsigned char *new_sha1, const char *msg,
>  			int flags, struct strbuf *err);
>  
> +/*
> + * Check for entries in extras that are within the specified
> + * directory, where dirname is a reference directory name including
> + * the trailing slash (e.g., "refs/heads/master/"). Ignore any
> + * conflicting references that are found in skip. If there is a
> + * conflicting reference, return its name.
> + *
> + * extras and skip must be sorted lists of reference names. skip can
> + * be NULL; extras cannot.

The last sentence is incorrect; the function can handle extras == NULL.

> + */
> +const char *find_descendant_ref(const char *dirname,
> +				const struct string_list *extras,
> +				const struct string_list *skip);
>  
>  enum expire_reflog_flags {
>  	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
