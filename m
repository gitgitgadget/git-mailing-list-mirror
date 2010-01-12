From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/18] date.c: mark file-local function static
Date: Tue, 12 Jan 2010 01:05:23 -0800
Message-ID: <7vr5pv3d7w.fsf@alter.siamese.dyndns.org>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
 <1263282781-25596-5-git-send-email-gitster@pobox.com>
 <4B4C34B3.3010508@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 12 10:05:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUch1-0002ez-7Z
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 10:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797Ab0ALJFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 04:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978Ab0ALJFd
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 04:05:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab0ALJFc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 04:05:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C7ADC8EFE4;
	Tue, 12 Jan 2010 04:05:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fQ7YYEF/ZWNf1fvTxiGDUl6M6jQ=; b=TwkWyi
	siUugOF3OEEwwgN0D4TzTjE0x+iQ7iJSrH0GDOFOH+WM8kRYJYdBOIF1cKQo/pIp
	ZDeqwvvM3pQ1XybDKCy7IlxHwFKVRXyA1sPoZnAKZAaF0L4IfR+7H6nwyEq9Nxy6
	O1PNdZ8r4GYTUm0uJyMiCHW7V7UBOWQPjxAgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KPeDAFNW7ijLlM5iTQEB2apupFwkFPTe
	tVjVLi9u8h8Ris9+aFvM+ra+HWXBcgSVBVcjP9llFopkSCpsqCZ2LZdg9VunJ5Au
	yE3MnLmPpDHAeUziEx/yRNFPubt8t63LVrlxODH3LO/HKyhtSZxKG1UWRAGLXKF7
	q4xvKw67p4A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 996A18EFE1;
	Tue, 12 Jan 2010 04:05:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C10078EFDF; Tue, 12 Jan
 2010 04:05:24 -0500 (EST)
In-Reply-To: <4B4C34B3.3010508@viscovery.net> (Johannes Sixt's message of
 "Tue\, 12 Jan 2010 09\:37\:07 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A066B898-FF59-11DE-BBA7-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136707>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 5c59687..85dea12 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -198,7 +198,6 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
>>  extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
>>  
>>  extern int prefixcmp(const char *str, const char *prefix);
>> -extern time_t tm_to_time_t(const struct tm *tm);
>>  
>>  static inline const char *skip_prefix(const char *str, const char *prefix)
>>  {
>
> This one is used from compat/mingw.c for the gettimeofday emulation.
> Please leave it extern.

Ouch; I thought I ran "git grep <sym> pu" for all of them.
Sorry and thanks.
