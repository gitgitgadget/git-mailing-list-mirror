From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] log: honor log.merges= option
Date: Tue, 07 Apr 2015 19:28:26 -0700
Message-ID: <xmqq4morcq0l.fsf@gitster.dls.corp.google.com>
References: <1428110521-31028-1-git-send-email-koosha@posteo.de>
	<1428110521-31028-2-git-send-email-koosha@posteo.de>
	<xmqqy4m7ek9q.fsf@gitster.dls.corp.google.com>
	<5524571C.90007@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Wed Apr 08 04:28:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YffjM-0004VC-C8
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 04:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbbDHC2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 22:28:37 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753964AbbDHC2e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 22:28:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48E4E47C2C;
	Tue,  7 Apr 2015 22:28:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/ELu1zDBJGaGPq0nIcgSGCZu8EE=; b=KNRA7S
	V5U+jc0vyAKsP0rrhfOIgrmk1zqfDZFwb0tzkPqoBx3Qw3MjH0kjGrD7aJXaQccA
	wcx+O1KbeVTouH9lDuByypSGSq26Cw7jODjbYuVyZjhunMgmiqSOpqxZt5xysBES
	igv1zxDN5D2SDxlqNIa4h4m/C+QCzKdhJrQpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NkbQbrCbxFDPx3zv9bxosUvhqWjC34n9
	xWG8D23rO7Hx2u3wBeXkMPfkVF+f8U2bN+84kvfS3r80xl9ClCxTOGB+M2V4eIbx
	DobhQwdOU2hXoZ8vQDcCS+9bVpyPWIhHvQhGQn3qe2LEhDP+z/aL3FwTSbgvNga4
	Vf2aa9X6luk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42A3947C2B;
	Tue,  7 Apr 2015 22:28:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD30447C25;
	Tue,  7 Apr 2015 22:28:27 -0400 (EDT)
In-Reply-To: <5524571C.90007@posteo.de> (Koosha Khajehmoogahi's message of
	"Wed, 08 Apr 2015 00:15:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F0822850-DD96-11E4-99B7-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266946>

Koosha Khajehmoogahi <koosha@posteo.de> writes:

> On 04/04/2015 10:00 PM, Junio C Hamano wrote:
>> Koosha Khajehmoogahi <koosha@posteo.de> writes:
>> 
>>> From: Junio C Hamano <gitster@pobox.com>
>>>
>>> [kk: wrote commit message]
>> 
>> Ehh, what exactly did you write ;-)?
>> 
>> I think the most important thing that needs to be explained by the
>> log message for this change is that the variable is honored only by
>> log and it needs to explain why other Porcelain commands in the same
>> "log" family, like "whatchanged", should ignore the variable.
>>
> So, what would be the reason? 

It is strange that you have to ask me to give you the reason why you
chose it that way, isn't it?

>> I think that we must not to allow format-patch and show to be
>> affected by this variable, because it is silly if log.merges=only
>> broke format-patch output or made "git show" silent.  But I didn't
>> think about others.  Whoever is doing this change needs to explain
>> in the log message the reason why it was decided that only "git log"
>> should pay attention to it.
>> 
