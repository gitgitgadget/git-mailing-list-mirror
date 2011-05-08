From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2] Do not strip empty lines / trailing spaces from a
 commit message template
Date: Sun, 08 May 2011 11:14:08 -0700
Message-ID: <7vy62hrrf3.fsf@alter.siamese.dyndns.org>
References: <4DC65888.7090309@gmail.com>
 <1304850662-6424-1-git-send-email-billiob@gmail.com>
 <4DC68C88.7030604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
To: Boris Faure <billiob@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 20:14:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ8Uo-0005HV-Tl
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 20:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409Ab1EHSOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 14:14:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab1EHSOR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 14:14:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 49B7150FD;
	Sun,  8 May 2011 14:16:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lysI6NEgTo5breAJ3fTquYz6UpI=; b=iR0dkJ
	FKV/WPcl9IRYhCz0kKDQ792/4hRZbbkIhQtXX6oiRxZW2C/Xn7WGyO5Jmr+FeBvz
	PZS4EDkBr7x4eQMsUXHVwrhQKW+vjOpB+g8HVtZv6WSknloRdf8qJObivtkbWjEt
	KwIXHUFZI7+NjjLnm650U9Migfq/cE+TbXX04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C+1ZhguKwBvS/mCgVB6NhRZly4ytSvgO
	J8lyGi3YnhWWolZTsfoqeY16CaoXF7gkZeCZeZ4jktlYbTPID0iv6Q0FqrL1JtqA
	z8+G78QbY2T0FavCd7uzSwGDbd8ixtNxcTQFsZCpWkraQghN4B4rwbGYPO7HftZL
	9p91cYRxKP4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0FC0650FC;
	Sun,  8 May 2011 14:16:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0207850F6; Sun,  8 May 2011
 14:16:14 -0400 (EDT)
In-Reply-To: <4DC68C88.7030604@gmail.com> (Sebastian Schuberth's message of
 "Sun, 08 May 2011 14:28:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 454211A8-799F-11E0-90EE-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173170>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On 08.05.2011 12:31, Boris Faure wrote:
>
>> Templates should be just that: A form that the user fills out, and forms
>> have blanks. If people are attached to not having extra whitespace in the
>> editor, they can simply clean up their templates.
>>
>> Added test with editor adding even more whitespace.
>>
>> Signed-off-by: Boris Faure<billiob@gmail.com>
>> Based-on-patch-by:Sebastian Schuberth<sschuberth@gmail.com>
>
> Thanks for rebasing the patch and adding the test! I've run the whole
> test suite on Linux, and all tests pass for me (including the added
> one).

Thanks, both.  The updated log message explains _why_ this change is a
good thing very well.

I'd avoid "echo -e" which is not portable, though.
