From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 28/43] refs.c: add ref backend init function
Date: Mon, 05 Oct 2015 10:37:59 +0200
Message-ID: <561236E7.1050508@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com> <1443477738-32023-29-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <rsahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 10:45:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj1OV-0004EN-Jk
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 10:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbbJEIpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 04:45:09 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:46370 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752140AbbJEIpI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 04:45:08 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2015 04:45:08 EDT
X-AuditID: 1207440f-f79df6d000007c0f-38-561236e806e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 2A.B9.31759.8E632165; Mon,  5 Oct 2015 04:38:00 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E0C.dip0.t-ipconnect.de [79.201.110.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t958bxbc000543
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 Oct 2015 04:38:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1443477738-32023-29-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1H1hJhRm8HKjjcX8TScYLbqudDNZ
	tDx9x+LA7LFgU6nHguf32T0+b5ILYI7itklKLCkLzkzP07dL4M748eA0Y8EF8YoJLTvZGhif
	CHUxcnJICJhITF2/hB3CFpO4cG89WxcjF4eQwGVGifNL7zKCJIQEzjFJHHhsAGLzCmhLXHt2
	lLWLkYODRUBVYuOCCJAwm4CuxKKeZiYQW1QgSGLF8heMEOWCEidnPmEBsUUEHCQu7zrKDGIz
	C2hJbHl0AWyMsICzxJPTYhBr2xgljhw5C1bDKeAlcXPddnaIej2JHdd/sULY8hLb385hnsAo
	MAvJillIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdELzezRC81pXQTIyRw+Xcw
	dq2XOcQowMGoxMN7IF4wTIg1say4MvcQoyQHk5Iob62OUJgQX1J+SmVGYnFGfFFpTmrxIUYJ
	DmYlEV5tLaAcb0piZVVqUT5MSpqDRUmcV32Jup+QQHpiSWp2ampBahFMVoaDQ0mClwcYoUKC
	RanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoDiNLwZGKkiKB2ivJkg7b3FBYi5QFKL1
	FKOilDjvHVOghABIIqM0D24sLB29YhQH+lKY1xOknQeYyuC6XwENZgIa3C8PNrgkESEl1cDo
	/DFLhannpxL7G5ECneobAhzO0yUlOj3dmEzd9FcY+M6z2j9tvk2t/bzK1f45Jy/dvKIQybTV
	dWOR7IqAXXsUPpsu6F7U/YlDvyi+Z/f8G4dXRT2sOV1oNvU20zHfqM7JnSGdjf6y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279045>

On 09/29/2015 12:02 AM, David Turner wrote:
> The file backend doesn't need this function, but other backends might.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
> ---
>  refs-be-files.c | 1 +
>  refs.c          | 4 +++-
>  refs.h          | 4 +++-
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/refs-be-files.c b/refs-be-files.c
> index 37e244a..eaa74b6 100644
> --- a/refs-be-files.c
> +++ b/refs-be-files.c
> @@ -3737,6 +3737,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
>  struct ref_be refs_be_files = {
>  	NULL,
>  	"files",
> +	NULL,
>  	files_transaction_begin,
>  	files_transaction_update,
>  	files_transaction_create,
> diff --git a/refs.c b/refs.c
> index 769574d..9ce10b7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -19,13 +19,15 @@ struct ref_be *refs_backends = &refs_be_files;
>  /*
>   * This function is used to switch to an alternate backend.
>   */
> -int set_refs_backend(const char *name)
> +int set_refs_backend(const char *name, void *init_data)
>  {
>  	struct ref_be *be;
>  
>  	for (be = refs_backends; be; be = be->next)
>  		if (!strcmp(be->name, name)) {
>  			the_refs_backend = be;
> +			if (be->init_backend)
> +				be->init_backend(init_data);

I don't like that this virtual function, alone among all of them
introduced so far, is allowed to be NULL. That seems non-obvious and
something extra that devs have to remember.

I think it would be better for the files backend to define a do-nothing
function that can be stuck in this slot.

If you are opposed to that for some reason, then please at least add a
comment where this function pointer is added to `struct ref_be`, warning
that it can be NULL.

>  			return 0;
>  		}
>  	return 1;
> diff --git a/refs.h b/refs.h
> index 0b407b2..0dc626e 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -586,6 +586,7 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
>  			 void *policy_cb_data);
>  
>  /* refs backends */
> +typedef void (*ref_backend_init_fn)(void *data);
>  typedef struct ref_transaction *(*ref_transaction_begin_fn)(struct strbuf *err);
>  typedef int (*ref_transaction_update_fn)(struct ref_transaction *transaction,
>  		const char *refname, const unsigned char *new_sha1,
> @@ -641,6 +642,7 @@ typedef int (*for_each_reftype_fullpath_fn)(each_ref_fn fn, char *type,
>  struct ref_be {
>  	struct ref_be *next;
>  	const char *name;
> +	ref_backend_init_fn init_backend;
>  	ref_transaction_begin_fn transaction_begin;
>  	ref_transaction_update_fn transaction_update;
>  	ref_transaction_create_fn transaction_create;
> @@ -669,6 +671,6 @@ struct ref_be {
>  
>  
>  extern struct ref_be refs_be_files;
> -int set_refs_backend(const char *name);
> +int set_refs_backend(const char *name, void *init_data);
>  
>  #endif /* REFS_H */
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
