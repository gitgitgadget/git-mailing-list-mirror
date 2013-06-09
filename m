From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Sun, 09 Jun 2013 13:35:55 -0700
Message-ID: <7vfvwrowd0.fsf@alter.siamese.dyndns.org>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
	<1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
	<7vd2rvqgra.fsf@alter.siamese.dyndns.org>
	<CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com>
	<7vy5ajozuj.fsf@alter.siamese.dyndns.org>
	<CAMP44s38T9EUOe8EBKy1kxa-rEu7g0jb7+HB019AgCub+2SVnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 22:36:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlmLK-00038d-Hc
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 22:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431Ab3FIUf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 16:35:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab3FIUf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 16:35:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81BFD267B0;
	Sun,  9 Jun 2013 20:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P5655fEPM+1AEKE7rKU8XjcNLAQ=; b=OJ+aRK
	cmlagtcYrXhIrHg3AQrldmjFxttSJeRLG/jfAeU07EtlGKXVLt7BBA5WMBiksck3
	9GDPbHkA60V2VxYyyuHFuqD2tFnDM606Q0xl+Zvwlyayjn4srpLAFGWh0Zcy6MVQ
	ORPcqVNAXr2LXxv0029pVYVvjw2HWDTeb2wfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VOwPnEyHlUIQaZNJy4luOhOmsAWLIBsq
	94Akwj2mPUdLS/yUi040K1BfB/+34zNVzrt5F7Qroups0pzCtQbeBjskZV6Nwvl0
	wLqXszAQwkhA4z84xFpziMd0kk6rR9/QwXR733pgoSm4lFN6+Y+cWfRRplHH9wgp
	ixoyCRfl0LU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7679F267AF;
	Sun,  9 Jun 2013 20:35:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D525B267AC;
	Sun,  9 Jun 2013 20:35:56 +0000 (UTC)
In-Reply-To: <CAMP44s38T9EUOe8EBKy1kxa-rEu7g0jb7+HB019AgCub+2SVnw@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 9 Jun 2013 14:33:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 301C2486-D144-11E2-9A6C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227165>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Jun 9, 2013 at 2:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Sun, Jun 9, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>>> --- a/t/test-lib-functions.sh
>>>> +++ b/t/test-lib-functions.sh
>>>> @@ -606,6 +606,18 @@ test_cmp() {
>>>>         $GIT_TEST_CMP "$@"
>>>>  }
>>>>
>>>> +# Check if the file expected to be empty is indeed empty, and barfs
>>>> +# otherwise.
>>>> +
>>>> +test_output_must_be_empty () {
>>>
>>> Why such a big name? test_empty() does the trick.
>>
>> Primarily in order to avoid that exact name "test_empty" that others
>> may want to use for a helper to check that the contents of a string
>> variable is empty.
>
> Which is never going to happen.

For anything, a failure from

	test -z "$mustbeemptystring"

in the test suite is much harder to diagnose because there is
nothing left in the trash directory to inspect, as opposed to

	test ! -s "$mustbeemptyfile"

where you can just go there and inspect yourself.
