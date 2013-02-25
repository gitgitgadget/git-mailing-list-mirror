From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support FTP-over-SSL/TLS for regular FTP
Date: Sun, 24 Feb 2013 22:44:14 -0800
Message-ID: <7vehg43nb5.fsf@alter.siamese.dyndns.org>
References: <1357999192-877-1-git-send-email-modestas@vainius.eu>
 <20130112142521.GA21639@ftbfs.org> <7057807.F3QETssImX@mdxdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org
To: Modestas Vainius <modestas@vainius.eu>
X-From: git-owner@vger.kernel.org Mon Feb 25 07:44:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9rnm-0004Ju-NK
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 07:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab3BYGoS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2013 01:44:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53759 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551Ab3BYGoR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2013 01:44:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E20A4A628;
	Mon, 25 Feb 2013 01:44:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=2KVZXNGNzQgk9dAH7uoXRK94F
	ek=; b=ZnE1jdrVCnSijCqvni6OZZPrxnHjET8LKZxwiL6Cxe/tKsQ4rcbxaUmGy
	MriRBbMyARcw08fnmD+oE3wlp0qz+wtWTQi+kOVgu2GDxBJuOQwptk8K+as1A2dh
	kiohx718kHdC44U1s/+Wp2QfvyYsUKorPNvO+ZWdLt3YAC3PX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=g1SCEdYl/sY3L36389C
	Mj5XWew8oUIBMOFhm4M4spevWR3HlVJq0hFNMwwvOkeGQmx479pLP7XvfLq73ZmD
	Xb9369Tprw8Z/6DgddEfoQ0XLUuFSWDdsyd2Mnzu7KM3qPkVYj1CPqXQckIqJNT7
	/goI3+AbRLubY0b9qK0oSFCQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADAA0A625;
	Mon, 25 Feb 2013 01:44:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E600A618; Mon, 25 Feb 2013
 01:44:15 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5BF03DA-7F16-11E2-9239-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217037>

Modestas Vainius <modestas@vainius.eu> writes:

> Hello,
>
> Saturday 12 January 2013 06:25:21 ra=C5=A1=C4=97:
>> On Sat, Jan 12, 2013 at 03:59:52PM +0200, Modestas Vainius wrote:
>> > @@ -306,6 +311,11 @@ static CURL *get_curl_handle(void)
>> >=20
>> >  	if (curl_ftp_no_epsv)
>> >  =09
>> >  		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
>> >=20
>> > +#ifdef CURLOPT_USE_SSL
>> > +    if (curl_ssl_try)
>> > +		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
>> > +#endif
>> > +
>> >=20
>> >  	if (curl_http_proxy) {
>> >  =09
>> >  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>> >  		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
>>=20
>> It looks like the indentation of the "if" line you added is messed u=
p.
>
> Yeah, sorry about that. I will fix it.

Did anything happen to this topic since then?
