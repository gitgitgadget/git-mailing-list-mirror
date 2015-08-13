From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3] http: add support for specifying the SSL version
Date: Thu, 13 Aug 2015 18:01:51 +0200
Message-ID: <55CCBF6F.3070808@web.de>
References: <1439479731-16018-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: remi.galan-alfonso@ensimag.grenoble-inp.fr
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 18:02:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPux6-0004Q2-NZ
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 18:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbbHMQB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 12:01:56 -0400
Received: from mout.web.de ([212.227.17.12]:56586 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122AbbHMQB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 12:01:56 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MCIe5-1ZYxMH3QO1-00952K; Thu, 13 Aug 2015 18:01:52
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.1.0
In-Reply-To: <1439479731-16018-1-git-send-email-gitter.spiros@gmail.com>
X-Provags-ID: V03:K0:mZv+yytKafUjtTaB5md2Lirf4zXlh1iI5R9U9bU5dYUpz9wcpjR
 7pTM7IvuSWuVeoHaNyC42M15r9soi0hubCodE2th/AfZMRF+7iy1hFKVzdHjcv2cDppgqmW
 99c6IJE73iD732R6iZxqfkCUQGNuae3zyqWHtxLvbB9yz2fstzIacxzcpgTH6c7vPMwMlu0
 W8Z4el3/oiEQxozNl595g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yuF7WLlB3yw=:/qlhZlFko17clD4M4J+sql
 vuk9nGl2TM+LlOS2gnmiqlonRB9IzdMRlNUhhSAID26ZfT2vrJzWEW5wqMLp48Akng7rT/Vww
 VtZ234XJzEJD8fyA0yBbzWTLF7IPYPQmTghWfuLeRFkyOwFXXFRHWAmR8EdJYJqJqLFsyJIxG
 PS0f4ePI2q5ShknzwwNULzyXI/1uiq04WVZ1EW6VscVh3qOeLKavutXZcAIXKYDhdAaQO+30Y
 iZDGK/ekvs1quDMBIeDOJ0veanBoJhTUulzvrEbrWkNeCIHk1j+M8uA3QOrimObNAEKY0uQLQ
 0Y7wJzyJ1ovTNGWtNR2EjKMsnhn44QlutABz+VmzAkn10mm8WR+8okGThDNsATp6eoLP0NwvV
 tfNU1wgFvK8xuYzBqxLVHyvkbfTvgJfVyqA/I9cB3jMzgfMvG2eAl8m0T1cRgysUmXf0SkAZ/
 rpTTKmqZ0LRajLbC8Y31ZXWJcn/smEwJYB4GIPhrcX+/I0dKTta+ruNbeQ+RJ3fGgstDoVCUa
 oFUpP17Svs5dL7+hQl6G3NuKDH605heNbefeq0p56Xk2YsJCv4lpBS8r8UUIAeJVyVUoB/LJn
 M+6/AnhsdnIShD5XEtK4Z3cp+WNax8R7SFRPaOYtmi41x0joPmBeuCYUXxbuNlxXK+XzNRH7/
 cu7tmmfkd4XsvODbB3wLRhYlXf1rKv9i9EWlc7qIJDrXrzAXpBM+c/cO0emi4VfXEsxjS/9WG
 4ap4uw7hU07CPheKuq0CpznMx7puhf9cfnOrcQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275853>

(need to drop Eric from cc-list, no DNS from web.de)

On 2015-08-13 17.28, Elia Pinto wrote:
> Teach git about a new option, "http.sslVersion", which permits one to
> specify the SSL version  to use when negotiating SSL connections.  The
> setting can be overridden by the GIT_SSL_VERSION environment
> variable.
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This is the third version of the patch. The changes compared to the previous version are:
> 
> - Eliminated the unnecessary blank (Junio)
> - Place a structure to associate mnemonic names with the curl enum constant (Junio)
> - Eliminated the invocation to curl_easy_setopt to set the default SSL value. Also removed the static global variable.
>   (Junio)
> - Slight correction in config.txt (Eric)
> 
>  Documentation/config.txt               | 22 ++++++++++++++++++++++
>  contrib/completion/git-completion.bash |  1 +
>  http.c                                 | 32 +++++++++++++++++++++++++++++++-
>  3 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 315f271..b23b01a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1595,6 +1595,28 @@ http.saveCookies::
>  	If set, store cookies received during requests to the file specified by
>  	http.cookieFile. Has no effect if http.cookieFile is unset.
>  
> +http.sslVersion::
should this be https.sslVersion ?
(http doesn't use ssl)

> +	The SSL version to use when negotiating an SSL connection, if you
> +	want to force the default.  The available and default version depend on
> +	whether libcurl was built against NSS or OpenSSL and the particular configuration
> +	of the crypto library in use. Internally this sets the 'CURLOPT_SSL_VERSION'
> +	option; see the libcurl documentation for more details on the format
> +	of this option and for the ssl version supported. Actually the possible values
> +	of this option are:
> +
> +	- sslv2
> +	- sslv3
> +	- tlsv1
> +	- tlsv1.0
> +	- tlsv1.1
> +	- tlsv1.2
> +
from
https://en.wikipedia.org/wiki/Transport_Layer_Security#SSL_1.0.2C_2.0_and_3.0
sslv2 and sslv3 are deprecated.
Should there be a motivation in the commit message why we want to support them ?


> ++
> +Can be overridden by the 'GIT_SSL_VERSION' environment variable.
> +To force git to use libcurl's default ssl version and ignore any
> +explicit http.sslversion option, set 'GIT_SSL_VERSION' to the
> +empty string.
> +
>  http.sslCipherList::
>    A list of SSL ciphers to use when negotiating an SSL connection.
>    The available ciphers depend on whether libcurl was built against
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c97c648..6e9359c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2118,6 +2118,7 @@ _git_config ()
>  		http.postBuffer
>  		http.proxy
>  		http.sslCipherList
> +		http.sslVersion
>  		http.sslCAInfo
>  		http.sslCAPath
>  		http.sslCert
> diff --git a/http.c b/http.c
> index e9c6fdd..d5fecd6 100644
> --- a/http.c
> +++ b/http.c
> @@ -37,6 +37,21 @@ static int curl_ssl_verify = -1;
>  static int curl_ssl_try;
>  static const char *ssl_cert;
>  static const char *ssl_cipherlist;
> +static const char *ssl_version;
> +static struct {
> +	const char *name;
> +	long ssl_version;
> +	} sslversions[] = {
> +		{ "sslv2", CURL_SSLVERSION_SSLv2 },
> +		{ "sslv3", CURL_SSLVERSION_TLSv1 },
> +		{ "tlsv1", CURL_SSLVERSION_TLSv1 },
> +#if LIBCURL_VERSION_NUM >= 0x072200
> +		{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
> +		{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
> +		{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
> +#endif
> +		{ NULL }
> +};
>  #if LIBCURL_VERSION_NUM >= 0x070903
>  static const char *ssl_key;
>  #endif
> @@ -190,6 +205,8 @@ static int http_options(const char *var, const char *value, void *cb)
>  	}
>  	if (!strcmp("http.sslcipherlist", var))
>  		return git_config_string(&ssl_cipherlist, var, value);
> +	if (!strcmp("http.sslversion", var))
> +		return git_config_string(&ssl_version, var, value);
>  	if (!strcmp("http.sslcert", var))
>  		return git_config_string(&ssl_cert, var, value);
>  #if LIBCURL_VERSION_NUM >= 0x070903
> @@ -364,9 +381,22 @@ static CURL *get_curl_handle(void)
>  	if (http_proactive_auth)
>  		init_curl_http_auth(result);
>  
> +	if (getenv("GIT_SSL_VERSION"))
> +		ssl_version = getenv("GIT_SSL_VERSION");
> +	
Minor nit to shorten:
if (ssl_version && *ssl_version) {

> +		int i;
> +		for ( i = 0; i < ARRAY_SIZE(sslversions); i++ ) {
I think Git-style is not to have  ' ' before/after ')' /'('
for (i = 0; i < ARRAY_SIZE(sslversions); i++)

> +			if (sslversions[i].name != NULL && *sslversions[i].name && !strcmp(ssl_version,sslversions[i].name)) {
> +				curl_easy_setopt(result, CURLOPT_SSLVERSION,
> +					sslversions[i].ssl_version);
This is what my man page says:
 CURLcode curl_easy_setopt(CURL *handle, CURLoption option, parameter);
[]

RETURN VALUE
       CURLE_OK (zero) means that the option was set properly...
Should the return value checked (and we die() if we fail ?

> +				break;
> +		}
> +		if ( i == ARRAY_SIZE(sslversions) ) warning("unsupported ssl version %s: using default",
> +							ssl_version);
Should we die() here to make things very clear to the user ?

> +	}
> +
>  	if (getenv("GIT_SSL_CIPHER_LIST"))
>  		ssl_cipherlist = getenv("GIT_SSL_CIPHER_LIST");
> -
>  	if (ssl_cipherlist != NULL && *ssl_cipherlist)
>  		curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
>  				ssl_cipherlist);
> 
