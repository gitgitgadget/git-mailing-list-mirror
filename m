From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
Date: Thu, 23 Aug 2012 14:27:19 -0700
Message-ID: <7vlih52tag.fsf@alter.siamese.dyndns.org>
References: <002201cd807d$0e83d300$2b8b7900$@schmitz-digital.de>
 <7v8vd6alqe.fsf@alter.siamese.dyndns.org>
 <003001cd808b$9d505730$d7f10590$@schmitz-digital.de>
 <7vk3wq964r.fsf@alter.siamese.dyndns.org>
 <003c01cd808f$f24e2a60$d6ea7f20$@schmitz-digital.de>
 <7v7gsq94gd.fsf@alter.siamese.dyndns.org>
 <004101cd8096$fce3a700$f6aaf500$@schmitz-digital.de>
 <7vwr0q63po.fsf@alter.siamese.dyndns.org>
 <000601cd8101$a6f81900$f4e84b00$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Thu Aug 23 23:27:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4ew6-0004xJ-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 23:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759253Ab2HWV1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 17:27:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756045Ab2HWV1W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 17:27:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC1D78469;
	Thu, 23 Aug 2012 17:27:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4rkGHfwxeh4Y0H/W0cuZ92Sx/2k=; b=FD2zOR
	LS5XOH4TIXJ8atrRqdpFpKPuSpSIDv4ZeA33/G/MPXfXgnARJaqOZY8HCgdW6P8p
	oSGAWZvAFwLTUg3H0SP6LdMTgpXXSYNOFzQmbtLETPRi874P064rU41OwM1wlA+u
	XdrwKiKATGm3E3v5Qu5FLoab9P/N+jHYSgGBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SQmo4PEAB1GkAikSvA6ZQPejLRJBPFLi
	+S+PLBouzIgWqzr4yzZYwHrin8bw8BDSJJC2hXosTh3cxM9an6gFxl5pn22j2ijY
	fnTZBlVPZe7AuhVtokUqocbzXAhmQc5IvY3WljOSmwZvdQhaLnCF6ZLDNzcHWJZO
	1tUMPL2WZZg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 996758468;
	Thu, 23 Aug 2012 17:27:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7E508466; Thu, 23 Aug 2012
 17:27:20 -0400 (EDT)
In-Reply-To: <000601cd8101$a6f81900$f4e84b00$@schmitz-digital.de> (Joachim
 Schmitz's message of "Thu, 23 Aug 2012 09:33:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 527A576A-ED69-11E1-9E97-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204174>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
>> Sent: Wednesday, August 22, 2012 11:06 PM
>> To: 'Junio C Hamano'
>> Cc: 'git@vger.kernel.org'
>> Subject: RE: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
>> 
>> > From: Junio C Hamano [mailto:gitster@pobox.com]
>> > Sent: Wednesday, August 22, 2012 11:02 PM
>> > To: Joachim Schmitz
>> > Cc: git@vger.kernel.org
>> > Subject: Re: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
>> >
>> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
>> >
>> > >> > diff --git a/http.c b/http.c
>> > >> > index b61ac85..18bc6bf 100644
>> > >> > --- a/http.c
>> > >> > +++ b/http.c
>> > >> > @@ -806,10 +806,12 @@ static int http_request(const char *url, void
>> > >> > *result, int target, int options)
>> > >>
>> > >> Likewrapped X-<
>> > >
>> > > Any suggestion?
>> >
>> > Other than "don't wrap" (or "get a real MUA and MTA" X-<), unfortunately no.
>> >
>> > I do not know if you have checked MUA specific hints section of
>> > Documentation/SubmittingPatches; there may be environment specific hints
>> > described for a MUA you may have at hand (or not).
>> 
>> I checked, but Outlook isn't mentioned :-(
>
> OK, Outlook inserts line breaks at position 76. I can't switch it off completely, but can set it to anything between 30 and 132. I
> set it to 132 now, does that look OK now?

Yeah, modulo that with all the above noise and with "---" before the
log message you inserted by hand before the real commit log message,
and also the log message is not properly line-wrapped, it is getting
closer to what is expected of a patch to be applied.

I've applied it by hand and fixed the log message up, so no need to
resend this particular one.  Thanks.

> ---
>
> This reverts be22d92 (http: avoid empty error messages for some curl errors, 2011-09-05) on platforms with older versions of
> libcURL.
>
> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> ---
>  http.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/http.c b/http.c
> index b61ac85..18bc6bf 100644
> --- a/http.c
> +++ b/http.c
> @@ -806,10 +806,12 @@ static int http_request(const char *url, void *result, int target, int options)
>  				ret = HTTP_REAUTH;
>  			}
>  		} else {
> +#if LIBCURL_VERSION_NUM >= 0x070c00
>  			if (!curl_errorstr[0])
>  				strlcpy(curl_errorstr,
>  					curl_easy_strerror(results.curl_result),
>  					sizeof(curl_errorstr));
> +#endif
>  			ret = HTTP_ERROR;
>  		}
>  	} else {
