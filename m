From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 17/23] http.c::http_fetch_ref(): use the new http API
Date: Fri, 05 Jun 2009 13:50:58 -0700 (PDT)
Message-ID: <m3eity5rtq.fsf@localhost.localdomain>
References: <20090606000556.9cbf4ac0.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:51:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCgNe-0000oM-68
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 22:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbZFEUvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 16:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbZFEUu7
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 16:50:59 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:44070 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbZFEUu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 16:50:58 -0400
Received: by bwz9 with SMTP id 9so1764189bwz.37
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 13:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=yRd/tZlBVOC+VJUaiOPm7quXDJi/Uc7E7XAJcQYxi3k=;
        b=fphdRvBlKGlzUxcFUYAimH0iiZ0+a0yOAdReROj99ezkKu74Mhw2Ok4Yp6CzGY1K9g
         L755POGSE8lWyEfwXt8TwkDUh9uYP5B/RJyRZ8rveQUS5d035nnc3GOaMdnQXCmGdkye
         5DFT9D4/xRxnuKPjOX0+f+/rcdXfhkrzSBWpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=HgAbVZgtC0Sn013MyjZGoLoFCykV0iH/rMhUqps1KeALo17BB4p+k9/XzOFziL+CQ/
         ff1piK+kywYGeUQpKElAfDj/6zVOSl3wvS6j1xe8DMKDfcmtW+iKnjLTmvrtMLS6EYEm
         MFWOAxtNRUnT9YR1UCjZZ+OpfUVfUa6r+CRHM=
Received: by 10.204.65.65 with SMTP id h1mr3577630bki.26.1244235059168;
        Fri, 05 Jun 2009 13:50:59 -0700 (PDT)
Received: from localhost.localdomain (abwo21.neoplus.adsl.tpnet.pl [83.8.238.21])
        by mx.google.com with ESMTPS id 21sm370936fkx.44.2009.06.05.13.50.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 13:50:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n55Ko8sE024664;
	Fri, 5 Jun 2009 22:50:18 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n55Knbq8024656;
	Fri, 5 Jun 2009 22:49:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090606000556.9cbf4ac0.rctay89@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120834>

Tay Ray Chuan <rctay89@gmail.com> writes:

> From:	Mike Hommey <mh@glandium.org>
> Subject: [WIP Patch 04/12] Use the new http API in http_fetch_ref()

What is the subject of this patch:
  "http.c::http_fetch_ref(): use the new http API"
or
  "Use the new http API in http_fetch_ref()"

Perhaps this and previous patch should be squashed?

> Date:	Sun, 18 Jan 2009 09:04:29 +0100
> 
> The error message ("Unable to start request") has been removed, since
> the http API already prints it.
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  http.c |   33 ++++++++-------------------------
>  1 files changed, 8 insertions(+), 25 deletions(-)
> 
> diff --git a/http.c b/http.c
> index df22180..2a49372 100644
> --- a/http.c
> +++ b/http.c
> @@ -773,34 +773,17 @@ int http_fetch_ref(const char *base, struct ref *ref)
>  {
>  	char *url;
>  	struct strbuf buffer = STRBUF_INIT;
> -	struct active_request_slot *slot;
> -	struct slot_results results;
> -	int ret;
> +	int ret = -1;
> 
>  	url = quote_ref_url(base, ref->name);
> -	slot = get_active_slot();
> -	slot->results = &results;
> -	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
> -	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
> -	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
> -	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
> -	if (start_active_slot(slot)) {
> -		run_active_slot(slot);
> -		if (results.curl_result == CURLE_OK) {
> -			strbuf_rtrim(&buffer);
> -			if (buffer.len == 40)
> -				ret = get_sha1_hex(buffer.buf, ref->old_sha1);
> -			else if (!prefixcmp(buffer.buf, "ref: ")) {
> -				ref->symref = xstrdup(buffer.buf + 5);
> -				ret = 0;
> -			} else
> -				ret = 1;
> -		} else {
> -			ret = error("Couldn't get %s for %s\n%s",
> -				    url, ref->name, curl_errorstr);
> +	if (http_get_strbuf(url, &buffer, HTTP_NO_CACHE) == HTTP_OK) {
> +		strbuf_rtrim(&buffer);
> +		if (buffer.len == 40)
> +			ret = get_sha1_hex(buffer.buf, ref->old_sha1);
> +		else if (!prefixcmp(buffer.buf, "ref: ")) {
> +			ref->symref = xstrdup(buffer.buf + 5);
> +			ret = 0;
>  		}
> -	} else {
> -		ret = error("Unable to start request");
>  	}
> 
>  	strbuf_release(&buffer);
> --
> 1.6.3.1
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
