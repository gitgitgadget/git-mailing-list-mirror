From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 16:25:31 -0700
Message-ID: <7vwrdd1gyc.fsf@alter.siamese.dyndns.org>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
 <7vk49d5t8u.fsf@alter.siamese.dyndns.org> <4E6E928A.6080003@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Boaz Harrosh <bharrosh@panasas.com>,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Shumkin <zapped@mail.ru>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:25:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Fsh-0003a0-79
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129Ab1ILXZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:25:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755668Ab1ILXZd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:25:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 115184D81;
	Mon, 12 Sep 2011 19:25:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kciXQG01h97s5+af7SAdgauLfmQ=; b=Xl6kdK
	BoyCzBH8ZmZehZVhNsQLJim81YAoaVLIy1jFc9m58xQQaQH8h57ILrezMQfbRXR5
	XD9Y+j+09A1Rt4MmXTrtRbUyckXF/u6KSWez8iTGQtltey6bPzpMvoP2BjnEGlYq
	ntyAUg9BjbKpoyzJm4Wmc4KX7CD7iygl8ywQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jtl56YhP1jJJ3MdvnZgq1NJJazz9qxOV
	1uPYFMSABjm87rGH8veIinumjHMZY0+pX/hTSbuujH3ki5SBX+oyfYKCYAYURkLy
	fbibPCHFFFQzMfzRt8KbC3iJakq+AzEe0RhEmLSPH/zzgEWd8rEyU6eVV0OGXqMq
	NRtWufyBHag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07D474D80;
	Mon, 12 Sep 2011 19:25:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B92A4D7F; Mon, 12 Sep 2011
 19:25:32 -0400 (EDT)
In-Reply-To: <4E6E928A.6080003@sunshineco.com> (Eric Sunshine's message of
 "Mon, 12 Sep 2011 19:15:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 828A441C-DD96-11E0-8A7F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181256>

Eric Sunshine <sunshine@sunshineco.com> writes:

> The following extensions I mentioned are missing from jk/default-attr:
>
> 	"*.htm diff=html",
> 	"*.cpp diff=cpp",
> 	"*.mm diff=objc",
>
> On Windows, .htm is common, and .cpp is required by several Windows
> C++ compilers. On Mac OS X, .mm is used for Objective-C++. The other
> extensions I mentioned (.cs, .hpp, .m) are present in jk/default-attr.
>
> Peff also asked if uppercase extensions are common on Windows. They
> are, so one often sees .HTM, .HTML, etc. Should this issue be handled
> by jk/default-attr?

I do not think we would mind adding .HTM but would people limit themselves
to uppercase while not limiting themselves to three letters and use .HTML?

> By the way, there appears to be an error in 1ff2bcf79b (attr: map
> builtin userdiff drivers to well-known extensions, 2011-08-25):
>
>> static const char *builtin_attr[] = {
>>  	"[attr]binary -diff -text",
>> +	"*.html diff=html",
>> 	...omitted...
>> +	"*.f[0-9][0-9] diff=fortran",
>> +	"*.m objc",
>>  	NULL,
>
> Shouldn't the last entry be?
>
> 	"*.m diff=objc",

Thanks for spotting. I'll locally amend only this part and hope somebody
would volunteer to submit an agreed version as the final one ;-)
