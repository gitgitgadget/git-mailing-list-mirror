From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t1507: add additional tests for @{upstream}
Date: Wed, 11 Apr 2012 10:57:42 -0700
Message-ID: <7vbomykv6x.fsf@alter.siamese.dyndns.org>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
 <1334161035-26355-2-git-send-email-zbyszek@in.waw.pl>
 <7vfwcakvfw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Apr 11 19:57:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI1nj-0005M0-L2
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 19:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760643Ab2DKR5q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 13:57:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56156 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759508Ab2DKR5p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 13:57:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57F6D767C;
	Wed, 11 Apr 2012 13:57:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jAeyw63etGn4
	22zvzbsg0/bQs/w=; b=by9DQ2j2G6ypmVCSVhxM0G85B8VLCCv3bFN8IxPFQt+7
	0HnoawrZLkUnK8aVLzIvdrTUu/XJJS0SZsqWu22NKB4vz3BcejFpr1nuZkfNY7sg
	l/wR1QDIocC5PVKHkq1R8DAjB8NtDpLIqyr8qSIMZVVBSTogHPMG0yuXBT3+Eak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XMxVPt
	hsH7PmZcTAIzZdX0VwFOnJP+WVn6KfW2N12JjU3axvDwhrhD1V4A+iY9CRnQ0D0n
	WT6qZGihEH8GhnXBG1Yy8IaJp5ohGj/tOCLfAw66eYZnUVi0fLIY+vH5qeTB4BfM
	XFBPm4NLrdplSK6EqR8pTewidReD0RIhjTKZQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E15F767B;
	Wed, 11 Apr 2012 13:57:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7AFE7678; Wed, 11 Apr 2012
 13:57:43 -0400 (EDT)
In-Reply-To: <7vfwcakvfw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 11 Apr 2012 10:52:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6922EDE-83FF-11E1-ADC0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195225>

Junio C Hamano <gitster@pobox.com> writes:

> Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:
>
>> +error_message () {
>> +	(cd clone &&
>> +	 test_must_fail git rev-parse --verify "$@")
>> +}
>> ...
>> +test_expect_success 'branch@{u} error message when no upstream' '
>> +	cat >expect <<-EOF &&
>> +	error: No upstream branch found for ${sq}non-tracking${sq}
>> +	fatal: Needed a single revision
>> +	EOF
>> +	(cd clone &&
>> +	 test_must_fail git rev-parse --verify non-tracking@{u}) 2>actual =
&&
>
> Why not use "error_message" as other new tests?

I think the remainder of the message should be ignored.  Will comment o=
n
individual steps.

Thanks.
