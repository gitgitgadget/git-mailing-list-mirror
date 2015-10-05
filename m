From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 18/43] refs-be-files.c: add a backend method structure
 with transaction functions
Date: Mon, 05 Oct 2015 10:03:02 +0200
Message-ID: <56122EB6.2020501@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com> <1443477738-32023-19-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 10:10:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj0qf-00087M-2s
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 10:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbbJEIKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 04:10:10 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61943 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751104AbbJEIKI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 04:10:08 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2015 04:10:08 EDT
X-AuditID: 1207440c-f79e16d000002a6e-e7-56122eb86c3b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 1B.7F.10862.8BE22165; Mon,  5 Oct 2015 04:03:04 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E0C.dip0.t-ipconnect.de [79.201.110.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t95832Ao031588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 Oct 2015 04:03:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1443477738-32023-19-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqLtDTyjM4OwfDov5m04wWnRd6Way
	+DehxoHZY8GmUo8Fz++ze3zeJBfAHMVtk5RYUhacmZ6nb5fAnfGudQ9jwTeJihXvX7I1MJ4W
	6WLk5JAQMJF4c3cHM4QtJnHh3nq2LkYuDiGBy4wSMye3MEE455gknl9tZAKp4hXQlnh85Ts7
	iM0ioCox8chCsG42AV2JRT3NYDWiAkESK5a/YISoF5Q4OfMJC4gtIuAgcXnXUbB6ZgFNiU0b
	XrCC2MICWRL9e6ezQCxrA9o8u4MNJMEp4CXR3vqGDaJBT2LH9V+sELa8RPPW2cwTGAVmIdkx
	C0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKEBC/PDsZv62QO
	MQpwMCrx8EokCYYJsSaWFVfmHmKU5GBSEuWt1REKE+JLyk+pzEgszogvKs1JLT7EKMHBrCTC
	q60FlONNSaysSi3Kh0lJc7AoifOqLlH3ExJITyxJzU5NLUgtgsnKcHAoSfD66gI1ChalpqdW
	pGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIOiNb4YGK8gKR6gvbtBbuItLkjMBYpCtJ5iVJQS
	5/0EkhAASWSU5sGNhaWkV4ziQF8K83aDbOcBpjO47ldAg5mABvfLgw0uSURISTUwdlximtZw
	7FiTwhL1Oas2lqj4PljSOjNewfyCqzf3+vsppmtU+1ftM63fPeP//raLi/Qkz/M/jH96d89+
	VZV3HMLWAcI510pmHF+4oduss9VdP9nn77nGf5JVr2bLXV9vpDzf6whX84kuPeUI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279043>

On 09/29/2015 12:01 AM, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Add a ref structure for backend methods. Start by adding method pointers
> for the transaction functions.
> 
> Add a function set_refs_backend to switch between backends. The files
> based backend is the default.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs-be-files.c | 62 +++++++++++++++++++++++++++-------------------
>  refs.c          | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  refs.h          | 36 +++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+), 25 deletions(-)
> 
> [...]
> diff --git a/refs.h b/refs.h
> index 729bc3c..a1db3ef 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -530,4 +530,40 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
>  			 reflog_expiry_cleanup_fn cleanup_fn,
>  			 void *policy_cb_data);
>  
> +/* refs backends */
> +typedef struct ref_transaction *(*ref_transaction_begin_fn)(struct strbuf *err);

Hmmm, I thought our convention was to define typedefs for functions
themselves, not for the pointer-to-function; e.g.,

    typedef struct ref_transaction *ref_transaction_begin_fn(struct
strbuf *err);

(which would require `struct ref_be` to be changed to

        ref_transaction_begin_fn *transaction_begin;

etc.) But now as I grep through the code it looks like both conventions
are used. So never mind :-)

> +typedef int (*ref_transaction_update_fn)(struct ref_transaction *transaction,
> +		const char *refname, const unsigned char *new_sha1,
> +		const unsigned char *old_sha1, unsigned int flags,
> +		const char *msg, struct strbuf *err);
> +typedef int (*ref_transaction_create_fn)(
> +		struct ref_transaction *transaction,
> +		const char *refname, const unsigned char *new_sha1,
> +		unsigned int flags, const char *msg, struct strbuf *err);
> +typedef int (*ref_transaction_delete_fn)(struct ref_transaction *transaction,
> +		const char *refname, const unsigned char *old_sha1,
> +		unsigned int flags, const char *msg, struct strbuf *err);
> +typedef int (*ref_transaction_verify_fn)(struct ref_transaction *transaction,
> +		const char *refname, const unsigned char *old_sha1,
> +		unsigned int flags, struct strbuf *err);
> +typedef int (*ref_transaction_commit_fn)(struct ref_transaction *transaction,
> +				     struct strbuf *err);
> +typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
> +
> +struct ref_be {
> +	struct ref_be *next;
> +	const char *name;
> +	ref_transaction_begin_fn transaction_begin;
> +	ref_transaction_update_fn transaction_update;
> +	ref_transaction_create_fn transaction_create;
> +	ref_transaction_delete_fn transaction_delete;
> +	ref_transaction_verify_fn transaction_verify;
> +	ref_transaction_commit_fn transaction_commit;
> +	ref_transaction_free_fn transaction_free;
> +};
> +
> +
> +extern struct ref_be refs_be_files;
> +int set_refs_backend(const char *name);
> +
>  #endif /* REFS_H */
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
