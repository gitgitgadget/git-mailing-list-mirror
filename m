From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remove protocol from gravatar and picon links for clear
 if Gitweb is being called through a secure server
Date: Mon, 28 Jan 2013 13:54:32 -0800
Message-ID: <7vfw1lug6f.fsf@alter.siamese.dyndns.org>
References: <1359400490-16449-1-git-send-email-admin@andrej-andb.ru>
 <20130128205834.GC7759@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrej Andb <admin@andrej-andb.ru>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 22:55:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzwfM-0005JW-5H
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 22:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab3A1Vyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 16:54:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50666 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135Ab3A1Vye (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 16:54:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ABE8CED8;
	Mon, 28 Jan 2013 16:54:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FiREW9IlS2/odR15X11WLhTjZzI=; b=T2g1va
	PYqE1mGZU84ztWDpjk4uzrWhbWAJwBuRcVQUkaiIvJASGuD3ETeSNv9cPz4K3KuF
	ENxORE/mKJmJtNTUjyjtC6OKp6luoz/Ia2+DxjtrkLMs+dTwlYPWWfYbVzPkAQor
	RjMXb2JhLSXJfwVKQk8V6KeETg+VLQtNy+MYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L+BekuS+lD0hGs6O3GD7pZnF8cHWn8Ni
	J1qKxMUFdOTLeqIgSbRimDzKF40+8UbsKr62t7TUAbbHcOnTaDpwQOgjvbrYv+/9
	Lo1AazgrMMOcTSFx0vLiaWNxdQ/WzmIo7MqZJqJhpytLRd0cXlP0rLf32W6SYBwD
	Ns8upgIbHlQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4256FCED7;
	Mon, 28 Jan 2013 16:54:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5081CED5; Mon, 28 Jan 2013
 16:54:33 -0500 (EST)
In-Reply-To: <20130128205834.GC7759@google.com> (Jonathan Nieder's message of
 "Mon, 28 Jan 2013 12:58:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D0EF7A6-6995-11E2-A7A0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214878>

Jonathan Nieder <jrnieder@gmail.com> writes:

> (cc-ing some area experts)
> Hi Andrej,
>
> Andrej Andb wrote:
>
>> [Subject: remove protocol from gravatar and picon links for clear if
>> Gitweb is being called through a secure server]
>
> Sounds good to me.  May we have your signoff?  (See
> Documentation/SubmittingPatches for what this means.)
>
> Thanks,
> Jonathan
> (patch left unsnipped for reference)
>
>> ---
>>  gitweb/gitweb.perl | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index c6bafe6..1309196 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -2068,7 +2068,7 @@ sub picon_url {
>>  	if (!$avatar_cache{$email}) {
>>  		my ($user, $domain) = split('@', $email);
>>  		$avatar_cache{$email} =
>> -			"http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
>> +			"//www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .

Hrmph.  Is that even a valid URL to refer to that external site from
a https://my.site/some/where/ base URL?  I wouldn't be surprised if
browsers allowed it, but I do not recall seeing such a use in RFCs.

Intuitively it feels strange that the above lets the site that gave
you the base URL dictate over what scheme sites unrelated to it has
to serve their resources.
