From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Sun, 05 Feb 2012 12:16:26 -0800
Message-ID: <7v39aphw85.fsf@alter.siamese.dyndns.org>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
 <20120202084859.GC3823@burratino> <7v8vklvxwh.fsf@alter.siamese.dyndns.org>
 <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
 <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
 <7vehuboe5g.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
 <20120204182611.GA31091@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 05 21:16:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru8Vn-0002pI-P7
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 21:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208Ab2BEUQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 15:16:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53773 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858Ab2BEUQa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 15:16:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1827F7E7E;
	Sun,  5 Feb 2012 15:16:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZMvsxbQkbBZ4eqDMEouo8J5qnpA=; b=su0Mdc
	nr5ffZKrMQgaDYfQGTCgwcRaHQ/jTKQVfMWFN6+Ol3CuhSIXPv5SuryfdOq0En+b
	5VLANTaUc/FQWBpGTLqROWBHn0hTJc5BeGDrjh0gY6SMPSX7Qqmtk1XdEKkbQyC7
	P+Q0W8XEj7S2Hj03tlvjfpfj4gdE6gUUqHGPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JLuy8xjKuNLNKEfITgZQUgMME495UB2P
	tN8yKnOM30Ievf1qSpJD+xAps/Iz+sik1U3W+3e6gDjGg/C5snHgFwX0t8EXOvKr
	Z3cHNQVwiP7zuWn7P0iKVNMWX0Avp6aShiHzcZDqe6Tn6nd0ZxliNUtnwDUWTwpn
	1IE29+7UCXE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 103787E7D;
	Sun,  5 Feb 2012 15:16:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65BE47E7C; Sun,  5 Feb 2012
 15:16:28 -0500 (EST)
In-Reply-To: <20120204182611.GA31091@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 4 Feb 2012 13:26:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4931BF7A-5036-11E1-B3CC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189952>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 04, 2012 at 05:46:05PM +0200, Felipe Contreras wrote:
>
>> In any case, the one to blame for the header corruption is git:
>> [...]
>> f2bb9f88 (<spearce@spearce.org>> 2006-11-27 03:41:01 -0500 952)
>> 
>> Notice the mail is wrong.
> ...
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 5a67c20..9b886fa 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1406,7 +1406,8 @@ static void get_ac_line(const char *inbuf, const char *what,
>  		/* Add a trailing '>' to email, since map_user returns plain emails
>  		   Note: It already has '<', since we replace from mail+1 */
>  		mailpos = memchr(mail, '\0', mail_len);
> -		if (mailpos && mailpos-mail < mail_len - 1) {
> +		if (mailpos && mailpos-mail < mail_len - 1 &&
> +		    mailpos > mail && *(mailpos-1) != '>') {
>  			*mailpos = '>';
>  			*(mailpos+1) = '\0';
>  		}
>
> but it feels like the fix should go into map_user.

Thanks.

The map_user() API takes an email address that is terminated by either NUL
or '>' to allow the caller to learn the corresponding up-to-date email
address that is NUL terminated, while indicating with its return value
that if the caller even needs to replace what it already has.  But the
function does not properly terminate email when it only touched the name
part. And I think that is the real bug.

So I agree that the real fix should go to map_user() so that when it says
"I've updated something, so pick up the updated result from the i/o
arguments you gave me, i.e. email and name", it makes sure what it claims
to be an e-mail address does not have the extra '>' in it.

Working around the current behaviour by forcing all callers that pass '>'
terminated e-mail address to have the code like the above quoted patch 
does not feel right.
