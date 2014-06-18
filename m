From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v18 11/48] refs.c: make remove_empty_directories alwasy
 set errno to something sane
Date: Wed, 18 Jun 2014 23:00:06 +0200
Message-ID: <53A1FDD6.3030202@alum.mit.edu>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com> <1403020442-31049-12-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 23:00:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMxt-0008RE-5j
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 23:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755696AbaFRVAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 17:00:10 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43478 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755467AbaFRVAI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2014 17:00:08 -0400
X-AuditID: 1207440c-f79656d000000c83-42-53a1fdd7841c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id EC.A7.03203.7DDF1A35; Wed, 18 Jun 2014 17:00:07 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB19A6.dip0.t-ipconnect.de [93.219.25.166])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5IL063M029288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 18 Jun 2014 17:00:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403020442-31049-12-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqHv978Jgg/szzSy6rnQzWfybUOPA
	5LFgU6nH501yAUxR3DZJiSVlwZnpefp2CdwZcy7/ZSxYyV3RfW4zWwPja44uRk4OCQETidtz
	HrBA2GISF+6tZ+ti5OIQErjMKDFrXzMLhHOeSeJa6yNmkCpeAW2JeVdugHWwCKhK7N/+hQ3E
	ZhPQlVjU08wEYosKBEnM/jyPHaJeUOLkzCdg9SICdhLrby0EmyMskCmxvOMFWI2QQI3EzXXX
	wOKcAq4S834uZ+1i5AC6SFyipzEIJMwsoCPxru8BM4QtL7H97RzmCYwCs5BsmIWkbBaSsgWM
	zKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31cjNL9FJTSjcxQoKUZwfjt3UyhxgFOBiVeHgX
	XF4YLMSaWFZcmXuIUZKDSUmU98APoBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXvlfQDnelMTK
	qtSifJiUNAeLkjiv6hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTvrD9AjYJFqempFWmZOSUIaSYO
	TpDhXFIixal5KalFiaUlGfGgSI0vBsYqSIoHaO9OkHbe4oLEXKAoROspRl2OU3eOtTEJseTl
	56VKifP2gRQJgBRllObBrYClpFeM4kAfC/O2g1TxANMZ3KRXQEuYgJaoTJwHsqQkESEl1cBo
	6ckelvz67rRnLmv4U/YZM+mtTdstedZ1+lkPu/+Pre7GneFK8/laNL0qLiZuxqmOsBx1lkcR
	bHYc548ueJP3SWXtofutvSwb++wcFma8Yt4ULnp28uEri33PNTpsnc8QIeI9b57o 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252069>

There is a typo in the commit log subject line:

s/alwasy/always/

Michael

On 06/17/2014 05:53 PM, Ronnie Sahlberg wrote:
> Making errno when returning from remove_empty_directories() more
> obviously meaningful, which should provide some peace of mind for
> people auditing lock_ref_sha1_basic.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/refs.c b/refs.c
> index a48f805..cc69581 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1960,14 +1960,16 @@ static int remove_empty_directories(const char *file)
>  	 * only empty directories), remove them.
>  	 */
>  	struct strbuf path;
> -	int result;
> +	int result, save_errno;
>  
>  	strbuf_init(&path, 20);
>  	strbuf_addstr(&path, file);
>  
>  	result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
> +	save_errno = errno;
>  
>  	strbuf_release(&path);
> +	errno = save_errno;
>  
>  	return result;
>  }
> @@ -2056,6 +2058,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
>  	return logs_found;
>  }
>  
> +/* This function should make sure errno is meaningful on error */
>  static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  					    const unsigned char *old_sha1,
>  					    int flags, int *type_p)
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
