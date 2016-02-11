From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 03/21] refs: add methods for the ref iterators
Date: Thu, 11 Feb 2016 09:42:45 +0100
Message-ID: <56BC4985.5070707@alum.mit.edu>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 09:50:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTmwq-0007p2-Ad
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 09:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbcBKIt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 03:49:56 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50535 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751399AbcBKItz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2016 03:49:55 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2016 03:49:55 EST
X-AuditID: 1207440e-befff70000000398-17-56bc4987c417
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 68.24.00920.7894CB65; Thu, 11 Feb 2016 03:42:47 -0500 (EST)
Received: from [192.168.69.130] (p548D69E5.dip0.t-ipconnect.de [84.141.105.229])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1B8gjCI032592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 11 Feb 2016 03:42:46 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1454701462-3817-4-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1G333BNmsLxNw2L+phOMFl1Xupks
	/k2ocWD2WLCp1GPB8/vsHp83yQUwR3HbJCWWlAVnpufp2yVwZ6yfsY6pYLV6xelvi1kaGM8p
	dDFycEgImEgsP+7XxcjFISSwlVHiyv6LjBDOBSaJRfdesnQxcnIIC7hK/NzzFswWEXCQuLzr
	KDNEUSujxKKVdxlBEswCmhIn3t5lA7HZBHQlFvU0M4HYEgJyEr3dk8CaeQW0JfYd7mIE2cwi
	oCrxZa42SFhUIETi/dfnrBAlghInZz4BK+cU8JD40XgdaryexI7rv1ghbHmJ5q2zmScwCsxC
	0jILSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuka6+VmluilppRuYoQELt8Oxvb1
	MocYBTgYlXh4f9TsDhNiTSwrrsw9xCjJwaQkynvQbU+YEF9SfkplRmJxRnxRaU5q8SFGCQ5m
	JRFeZ1ugHG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgvenB1CjYFFq
	empFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChS44uBsQqS4gHaK+gJsre4IDEXKArReopR
	UUqc96c7UEIAJJFRmgc3FpaOXjGKA30pzJsHsp0HmMrgul8BDWYCGrzj+y6QwSWJCCmpBsb4
	z/p7A9RaBb8KMu9tWnJSTCFK5k/iOb4Nmb/uCExmmF6cveyy4M21pe8eLVlRbJ2yP21bbNSN
	1siH15ztT35TZF6ivq5NagLzyn7BBXdaJL/e2Wf1Wnnv5+Bv1nyzw9g22cbvWOm/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285951>

On 02/05/2016 08:44 PM, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.c               | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  refs/files-backend.c | 41 +++++++++++++++++++++++++++------------
>  refs/refs-internal.h | 29 ++++++++++++++++++++++++++++
>  3 files changed, 112 insertions(+), 12 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index afdde7d..e598b73 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1158,3 +1158,57 @@ int resolve_gitlink_ref(const char *path, const char *refname,
>  {
>  	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
>  }
> +
> +int head_ref(each_ref_fn fn, void *cb_data)
> +{
> +	return the_refs_backend->head_ref(fn, cb_data);
> +}
> +
> +int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
> +{
> +	return the_refs_backend->head_ref_submodule(submodule, fn, cb_data);
> +}
> +

I think it is unnecessary to have so many virtual functions. For
example, here you have made head_ref_submodule() virtual. But the files
and lmdb implementations of this function are identical. They both call
do_head_ref(), which are (confusingly) two independent static functions.
But those functions are *also* defined identically, namely

> static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
> {
> 	struct object_id oid;
> 	int flag;
> 
> 	if (submodule) {
> 		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
> 			return fn("HEAD", &oid, 0, cb_data);
> 
> 		return 0;
> 	}
> 
> 	if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
> 		return fn("HEAD", &oid, flag, cb_data);
> 
> 	return 0;
> }
> 

After all, what else would they possibly want to do? And both
resolve_gitlink_ref() and read_ref_full() are already virtual functions
(actually read_ref_full() only has a single definition but it calls the
virtualized resolve_ref_unsafe()).

So it seems to me that it is unnecessary for head_ref_submodule() to be
virtual, and that there only needs to be one definition of do_head_ref().

(Off-topic: for that matter, do_head_ref() is itself almost pointless.
It could easily be inlined if we were sure that nobody passes it
submodule==NULL.)

Similarly, I bet that if do_for_each_ref() were just a little bit more
capable, then the following functions could also remain non-virtual
(i.e., one definition could be shared across all backend implementations):

* for_each_ref()
* for_each_ref_submodule()
* for_each_ref_in()
* for_each_fullref_in()
* for_each_ref_in_submodule()
* for_each_replace_ref()
* for_each_namespaced_ref()
* for_each_rawref()

> [...]
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index e83bc22..4a1d215 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -216,6 +216,24 @@ typedef int verify_refname_available_fn(const char *refname, struct string_list
>  typedef int resolve_gitlink_ref_fn(const char *path, const char *refname,
>  				   unsigned char *sha1);
>  
> +/* iteration methods */
> +typedef int head_ref_fn(each_ref_fn fn, void *cb_data);
> +typedef int head_ref_submodule_fn(const char *submodule, each_ref_fn fn,
> +				  void *cb_data);
> +typedef int for_each_ref_fn(each_ref_fn fn, void *cb_data);
> +typedef int for_each_ref_submodule_fn(const char *submodule, each_ref_fn fn,
> +				      void *cb_data);
> +typedef int for_each_ref_in_fn(const char *prefix, each_ref_fn fn,
> +			       void *cb_data);
> +typedef int for_each_fullref_in_fn(const char *prefix, each_ref_fn fn,
> +				   void *cb_data, unsigned int broken);
> +typedef int for_each_ref_in_submodule_fn(const char *submodule,
> +					 const char *prefix,
> +					 each_ref_fn fn, void *cb_data);
> +typedef int for_each_rawref_fn(each_ref_fn fn, void *cb_data);
> +typedef int for_each_namespaced_ref_fn(each_ref_fn fn, void *cb_data);
> +typedef int for_each_replace_ref_fn(each_ref_fn fn, void *cb_data);
> +
>  struct ref_storage_be {
>  	struct ref_storage_be *next;
>  	const char *name;
> @@ -228,6 +246,17 @@ struct ref_storage_be {
>  	resolve_ref_unsafe_fn *resolve_ref_unsafe;
>  	verify_refname_available_fn *verify_refname_available;
>  	resolve_gitlink_ref_fn *resolve_gitlink_ref;
> +
> +	head_ref_fn *head_ref;
> +	head_ref_submodule_fn *head_ref_submodule;
> +	for_each_ref_fn *for_each_ref;
> +	for_each_ref_submodule_fn *for_each_ref_submodule;
> +	for_each_ref_in_fn *for_each_ref_in;
> +	for_each_fullref_in_fn *for_each_fullref_in;
> +	for_each_ref_in_submodule_fn *for_each_ref_in_submodule;
> +	for_each_rawref_fn *for_each_rawref;
> +	for_each_namespaced_ref_fn *for_each_namespaced_ref;
> +	for_each_replace_ref_fn *for_each_replace_ref;
>  };
>  
>  extern struct ref_storage_be refs_be_files;
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
