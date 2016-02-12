From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 19/21] refs: add register_ref_storage_backends()
Date: Fri, 12 Feb 2016 16:42:04 +0100
Message-ID: <56BDFD4C.3050809@alum.mit.edu>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-20-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 16:42:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUFrW-0006pl-5c
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 16:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbcBLPmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 10:42:22 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49770 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751592AbcBLPmT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2016 10:42:19 -0500
X-AuditID: 1207440f-d9fff70000007e44-81-56bdfd4d73f2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 5E.0A.32324.D4DFDB65; Fri, 12 Feb 2016 10:42:05 -0500 (EST)
Received: from [192.168.69.130] (p548D685F.dip0.t-ipconnect.de [84.141.104.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1CFg4Tn020308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Feb 2016 10:42:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1454701462-3817-20-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqOv3d2+YwcEnTBbzN51gtOi60s3k
	wOSx4Pl9do/Pm+QCmKK4bZISS8qCM9Pz9O0SuDM6b51nL9glXPH0x0ymBsanfF2MnBwSAiYS
	u44/Yu5i5OIQEtjKKHF7/zcmCOc8k8SNJTeZQKqEBdwl/r9Zzwpiiwg4SFzedZQZxBYSaGOU
	OLBbBMRmE9CVWNTTDFbPK6AtsXnPG3YQm0VAVaKx8wxYXFQgROL91+esEDWCEidnPmEBsTkF
	PCVm3fkBVsMsoCex4/ovVghbXmL72znMExj5ZiFpmYWkbBaSsgWMzKsY5RJzSnN1cxMzc4pT
	k3WLkxPz8lKLdE30cjNL9FJTSjcxQkKPfwdj13qZQ4wCHIxKPLyGt/aECbEmlhVX5h5ilORg
	UhLlbXy2N0yILyk/pTIjsTgjvqg0J7X4EKMEB7OSCK9BE1CONyWxsiq1KB8mJc3BoiTOq75E
	3U9IID2xJDU7NbUgtQgmK8PBoSTB+/s3UKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJp
	SUY8KPbii4HRB5LiAdr7D6Sdt7ggMRcoCtF6ilFRSpx3G0hCACSRUZoHNxaWUF4xigN9Kcyr
	8AeoigeYjOC6XwENZgIavOP7LpDBJYkIKakGxtSFUuFei3MmP33w/31zXcnNd5evLDn9Xe3N
	n77H6etDzcP4wqza5svfW7WFc02sl9JUX5FPdzgm1+hW8bEUiesUWC27df3gkZeiblY+p1e2
	nO3cYn6z7lZ5q2pn2IMKiUWlggUbwtlqfkRIPP+4s5r91etC6bU9epdsaqr+ndki 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286054>

On 02/05/2016 08:44 PM, David Turner wrote:
> This new function will register all known ref storage backends... once
> there are any other than the default.  For now, it's a no-op.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/init-db.c |  3 +++
>  config.c          | 25 +++++++++++++++++++++++++
>  refs.c            |  8 ++++++++
>  refs.h            |  2 ++
>  4 files changed, 38 insertions(+)
> 
> [...]
> diff --git a/config.c b/config.c
> index b95ac3a..b9ef223 100644
> --- a/config.c
> +++ b/config.c
> @@ -11,6 +11,7 @@
>  #include "strbuf.h"
>  #include "quote.h"
>  #include "hashmap.h"
> +#include "refs.h"
>  #include "string-list.h"
>  #include "utf8.h"
>  
> @@ -1207,6 +1208,30 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  	}
>  
>  	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
> +		char *storage = NULL;
> +
> +		/*
> +		 * make sure we always read the ref storage config
> +		 * from the extensions section on startup
> +		 */
> +		ret += git_config_from_file(ref_storage_backend_config,
> +					    repo_config, &storage);
> +
> +		register_ref_storage_backends();
> +		if (!storage)
> +			storage = xstrdup("");
> +
> +		if ((!*storage) ||
> +		    (!strcmp(storage, "files"))) {

Nit: you have some unnecessary parentheses here.

> +			/* default backend, nothing to do */
> +			free(storage);
> +		} else {
> +			ref_storage_backend = storage;
> +			if (set_ref_storage_backend(ref_storage_backend))
> +				die(_("Unknown ref storage backend %s"),
> +				    ref_storage_backend);
> +		}
> +
>  		ret += git_config_from_file(fn, repo_config, data);
>  		found += 1;
>  	}
> diff --git a/refs.c b/refs.c
> index 715a492..e50cca0 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1554,3 +1554,11 @@ done:
>  	string_list_clear(&affected_refnames, 0);
>  	return ret;
>  }
> +
> +void register_ref_storage_backends(void) {
> +	/*
> +	 * No need to register the files backend; it's registered by
> +	 * default. Add register_ref_storage_backend(ptr-to-backend)
> +	 * entries below when you add a new backend.
> +	 */

This function must be called every run, right? So why not make it
register the "files" backend explicitly? That would make it obvious
really quick if this function fails to get called in some code path.
Just a thought...

> +}
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
