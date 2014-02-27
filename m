From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Rewrite git-compat-util.h:skip_prefix() as a loop
Date: Thu, 27 Feb 2014 21:33:45 +0100
Message-ID: <87k3cg47o6.fsf@fencepost.gnu.org>
References: <1393503197-29669-1-git-send-email-sunheehnus@gmail.com>
	<xmqqd2i8z6um.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sun He <sunheehnus@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 21:34:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ7eb-0005Gf-7H
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 21:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbaB0Ud5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 15:33:57 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:52593 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbaB0Ud4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 15:33:56 -0500
Received: from localhost ([127.0.0.1]:51634 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WJ7eV-0003og-Mh; Thu, 27 Feb 2014 15:33:55 -0500
Received: by lola (Postfix, from userid 1000)
	id D5B94E04F5; Thu, 27 Feb 2014 21:33:45 +0100 (CET)
In-Reply-To: <xmqqd2i8z6um.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 27 Feb 2014 11:35:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242854>

Junio C Hamano <gitster@pobox.com> writes:

> Sun He <sunheehnus@gmail.com> writes:
>
>> Signed-off-by: Sun He <sunheehnus@gmail.com>
>> ---
>>  git-compat-util.h |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index cbd86c3..4daa6cf 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -357,8 +357,8 @@ extern int suffixcmp(const char *str, const char *suffix);
>>  
>>  static inline const char *skip_prefix(const char *str, const char *prefix)
>>  {
>> -	size_t len = strlen(prefix);
>> -	return strncmp(str, prefix, len) ? NULL : str + len;
>> +    while( *prefix != '\0' && *str++ == *prefix++ );
>> +    return *prefix == '\0' ? str : NULL;
>
> Documentation/CodingGuidelines?

Mostly relevant for tabification here, not helping much otherwise.  In
particular, does not contain the advice "empty statements should appear
on a line of their own" which would help with readability here.

-- 
David Kastrup
