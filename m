From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 15/23] http.c: new functions for the http API
Date: Fri, 05 Jun 2009 13:50:00 -0700 (PDT)
Message-ID: <m3iqja5rvc.fsf@localhost.localdomain>
References: <20090606000550.17d48ace.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:50:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCgMe-0000T0-MP
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 22:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbZFEUuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 16:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753771AbZFEUuD
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 16:50:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:52511 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbZFEUuB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 16:50:01 -0400
Received: by fg-out-1718.google.com with SMTP id d23so330995fga.17
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=2rO/D4drQUsvIqZcIQDNDNkntWJmn9sZW67nGBZIGUE=;
        b=vMZgNNCwCbBXgKXQzUx7GEHiyYgHt785AfJKcUILihLYJz1LWIm3QtyusZRrKBwy/E
         GxWnh/c0LlzJAUddgz+aG11qNRCiWh+/IzEbBypgagvQ4ZliEq9pgshyxD64dSk4aCjQ
         zBctHZTjgOXETTLIqGDOR3THet0/JeQJMVgVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=s88TtWuZatVXFDQI6g2uNw1uuiqtyZakDgVBJuaI+kenbq4uW1xpCkMQ+DfbgH3DYK
         7VOIo5sbH0a6Z+wt18Me9FbnquZhXQyIMgcalKsWAZz63SETZe5auJJlPSN65+mvcZVY
         Vxx4Xb+wIJ8NgwVFISkTDEww8fMucYkPvHOUk=
Received: by 10.86.65.9 with SMTP id n9mr4351393fga.43.1244235001487;
        Fri, 05 Jun 2009 13:50:01 -0700 (PDT)
Received: from localhost.localdomain (abwo21.neoplus.adsl.tpnet.pl [83.8.238.21])
        by mx.google.com with ESMTPS id e20sm804871fga.10.2009.06.05.13.49.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 13:50:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n55Kn2m4024642;
	Fri, 5 Jun 2009 22:49:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n55Kme0Z024634;
	Fri, 5 Jun 2009 22:48:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090606000550.17d48ace.rctay89@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120833>

Tay Ray Chuan <rctay89@gmail.com> writes:

> From:	Mike Hommey <mh@glandium.org>
> Subject: [WIP Patch 03/12] Two new functions for the http API

So what is the title of this patch: 
  "http.c: new functions for the http API"
or
  "Two new functions for the http API"

Or perhaps it better be
  "http.c: Add http_get_strbuf() and http_get_file() to http API"

> Date:	Sun, 18 Jan 2009 09:04:28 +0100
> 
> http_get_strbuf and http_get_file allow respectively to retrieve contents of
> an URL to a strbuf or an opened file handle.
> 
> http_error prints out an error message containing the URL and the curl error
> (in curl_errorstr).
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
> 
> I've added an additional slot->local = NULL when cleaning up in
> http_request().
> 
>  http.c |  104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  http.h |   30 ++++++++++++++++++
>  2 files changed, 134 insertions(+), 0 deletions(-)
> 
> diff --git a/http.c b/http.c
> index 75fce9e..df22180 100644
> --- a/http.c
> +++ b/http.c
> @@ -665,6 +665,110 @@ static char *quote_ref_url(const char *base, const char *ref)
>  	return strbuf_detach(&buf, NULL);
>  }
> 
> +/* http_request() targets */
> +#define HTTP_REQUEST_STRBUF	0
> +#define HTTP_REQUEST_FILE	1
> +
> +static int http_request(const char *url, void *result, int target, int options)
> +{
> +	struct active_request_slot *slot;
> +	struct slot_results results;
> +	struct curl_slist *headers = NULL;
> +	struct strbuf buf = STRBUF_INIT;
> +	int ret;
> +
> +	slot = get_active_slot();
> +	slot->results = &results;
> +	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
> +
> +	if (result == NULL) {
> +		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
> +	} else {
> +		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
> +		curl_easy_setopt(slot->curl, CURLOPT_FILE, result);
> +
> +		if (target == HTTP_REQUEST_FILE) {
> +			long posn = ftell(result);
> +			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
> +					 fwrite);
> +			if (posn > 0) {
> +				strbuf_addf(&buf, "Range: bytes=%ld-", posn);
> +				headers = curl_slist_append(headers, buf.buf);
> +				strbuf_reset(&buf);
> +			}
> +			slot->local = result;
> +		} else
> +			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
> +					 fwrite_buffer);
> +	}
> +
> +	strbuf_addstr(&buf, "Pragma:");
> +	if (options & HTTP_NO_CACHE)
> +		strbuf_addstr(&buf, " no-cache");
> +
> +	headers = curl_slist_append(headers, buf.buf);
> +
> +	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
> +	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
> +
> +	if (start_active_slot(slot)) {
> +		run_active_slot(slot);
> +		if (results.curl_result == CURLE_OK)
> +			ret = HTTP_OK;
> +		else if (missing_target(&results))
> +			ret = HTTP_MISSING_TARGET;
> +		else
> +			ret = HTTP_ERROR;
> +	} else {
> +		error("Unable to start HTTP request for %s", url);
> +		ret = HTTP_START_FAILED;
> +	}
> +
> +	slot->local = NULL;
> +	curl_slist_free_all(headers);
> +	strbuf_release(&buf);
> +
> +	return ret;
> +}
> +
> +int http_get_strbuf(const char *url, struct strbuf *result, int options)
> +{
> +	return http_request(url, result, HTTP_REQUEST_STRBUF, options);
> +}
> +
> +int http_get_file(const char *url, const char *filename, int options)
> +{
> +	int ret;
> +	struct strbuf tmpfile = STRBUF_INIT;
> +	FILE *result;
> +
> +	strbuf_addf(&tmpfile, "%s.temp", filename);
> +	result = fopen(tmpfile.buf, "a");
> +	if (! result) {
> +		error("Unable to open local file %s", tmpfile.buf);
> +		ret = HTTP_ERROR;
> +		goto cleanup;
> +	}
> +
> +	ret = http_request(url, result, HTTP_REQUEST_FILE, options);
> +	fclose(result);
> +
> +	if ((ret == HTTP_OK) && move_temp_to_file(tmpfile.buf, filename))
> +		ret = HTTP_ERROR;
> +cleanup:
> +	strbuf_release(&tmpfile);
> +	return ret;
> +}
> +
> +int http_error(const char *url, int ret)
> +{
> +	/* http_request has already handled HTTP_START_FAILED. */
> +	if (ret != HTTP_START_FAILED)
> +		error("%s while accessing %s\n", curl_errorstr, url);
> +
> +	return ret;
> +}
> +
>  int http_fetch_ref(const char *base, struct ref *ref)
>  {
>  	char *url;
> diff --git a/http.h b/http.h
> index 1ef7dc1..3d878d5 100644
> --- a/http.h
> +++ b/http.h
> @@ -114,6 +114,36 @@ static inline int missing__target(int code, int result)
> 
>  #define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
> 
> +/* Options for http_request_*() */
> +#define HTTP_NO_CACHE		1
> +
> +/* Return values for http_request_*() */
> +#define HTTP_OK			0
> +#define HTTP_MISSING_TARGET	1
> +#define HTTP_ERROR		2
> +#define HTTP_START_FAILED	3
> +
> +/*
> + * Requests an url and stores the result in a strbuf.
> + *
> + * If the result pointer is NULL, a HTTP HEAD request is made instead of GET.
> + */
> +int http_get_strbuf(const char *url, struct strbuf *result, int options);
> +
> +/*
> + * Downloads an url and stores the result in the given file.
> + *
> + * If a previous interrupted download is detected (i.e. a previous temporary
> + * file is still around) the download is resumed.
> + */
> +int http_get_file(const char *url, const char *filename, int options);
> +
> +/*
> + * Prints an error message using error() containing url and curl_errorstr,
> + * and returns ret.
> + */
> +int http_error(const char *url, int ret);
> +
>  extern int http_fetch_ref(const char *base, struct ref *ref);
> 
>  #endif /* HTTP_H */
> --
> 1.6.3.1
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
