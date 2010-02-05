From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Showing whitespace on minus lines of diff ouput
Date: Thu, 04 Feb 2010 22:02:03 -0800
Message-ID: <7vr5p0kyp0.fsf@alter.siamese.dyndns.org>
References: <76718491002041747t327bf2f5l85e095244f6ee1ed@mail.gmail.com>
 <7veil0o02z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:06:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL3L-0003Bj-VN
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003Ab0BEGCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 01:02:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab0BEGCL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 01:02:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB465960B4;
	Fri,  5 Feb 2010 01:02:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aHXp8ukcewsOw7mv6ko/vvzrvYQ=; b=yCU6ld
	DgYWShAhbSM8zzMmCMufUX3pRqAOTWxGPsEUgZipW3M47tQMsXy1RxhZJaQh+Bq/
	B2jCJ7i16UfkLj9Opc35YsQZoYSWMuwqLz7kdhQkqDVIwH9nAAbL2msBlUib9hnd
	YHbZpq2KDqdzUtrydeUJ9v9awEoSGWHGBW12I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LZyDdBT9+UOFQQICq5Vnj3w3NsDmIfHH
	75h/VUG+VZ8+jGe8SBhkXRpLnLGWz/N0/M5yN+Whw28vLyOKfRy1zp9AmK9fENAu
	arm5sjlZHGyqzZb/54DAfXG1Bu8TC1z8quwT5H0oWnENq8+bObTR/Z6DcnGZao3Y
	Zzdg0B4JS2g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 867D6960B3;
	Fri,  5 Feb 2010 01:02:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C92D9960B2; Fri,  5 Feb
 2010 01:02:04 -0500 (EST)
In-Reply-To: <7veil0o02z.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 04 Feb 2010 19\:03\:48 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE5AFE1C-121B-11DF-9580-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139035>

Junio C Hamano <gitster@pobox.com> writes:

> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> The colored diff output is quite helpful to show introductions of whitespace.
>>
>> However, if whitespace has been removed, it's impossible to see in the
>> diff output since whitespace is colorized on '+' lines, but not '-'
>> lines.
>>
>> I'm looking at diff.c, but wow. Can someone more familiar with this
>> file point me toward how I'd make a patch to colorize whitespace on
>> '-' lines as well?
>
> Totally uninterested.  "diff -R" would be enough, wouldn't it?

Actually the reason I don't like the idea to highlight corrected errors
was not just because "'diff -R' is enough".

The coloring of whitespace errors are like compiler warnings, at least to
me, and giving similar highlighting to corrected ones defeats the purpose
by making the output more distracting..
