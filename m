From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git tag --no-merged?
Date: Wed, 04 Feb 2015 13:27:18 -0800
Message-ID: <xmqq1tm5nz9l.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.2.00.1502041615110.30476@ds9.cixit.se>
	<54D26B7C.7020300@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 22:27:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJ7Tr-0007M1-2e
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 22:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbbBDV1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2015 16:27:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932213AbbBDV1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2015 16:27:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 985B334666;
	Wed,  4 Feb 2015 16:27:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0KKJA9TOzeq0qqbkKZH5BW5G2wA=; b=kBUCFH
	96qKpS+HAbHMRHmqWTaKwrbIhAgGvaLDDjFVdtwxsnOUl3plpY9f8JMfqSgpEKaB
	1jUUjzyc/Ci1dB7Ez/PKHQXx3xMILzqZH05JbeCK5RsWlOZcy5Fg298XmzuiIDX3
	5OAwVK5+p2tQBLYy/0voMbBL97+o5pOgvrLxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sm8pST8ZE/Pwqz2YUO6QSgxOrMLRAKK8
	ReAPfrUum7xqkITalfH0Dp2QWqXV3zqd72ccA4/gJfymqKUVRGisjBlhLDEVG8/7
	OSNPO2+u0uE8+5P97lOQpj7WzWOPK9QuhHSM+i2unOR6WFqMOWLJsE4ig4OjDKdv
	lFnjUc/PpVU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9008134664;
	Wed,  4 Feb 2015 16:27:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19C5C34663;
	Wed,  4 Feb 2015 16:27:20 -0500 (EST)
In-Reply-To: <54D26B7C.7020300@kdbg.org> (Johannes Sixt's message of "Wed, 04
	Feb 2015 19:57:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99BAD84A-ACB4-11E4-B4D8-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263358>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 04.02.2015 um 16:19 schrieb Peter Krefting:
>> Using "git branch --no-merged" I can get a list of branches that I have
>> that I haven't merged into my current branch.
>
> Assuming v2.0.0 is a tag, using "git branch --no-merged v2.0.0" you can
> see which branches haven't been merged into v2.0.0.

I think the request is a bit more involved than "Which one is not
yet in v2.0.0?"

The question, as I now understand it after reading it again, 

    I want to merge the changes from the maintenance branches to
    master (and possibly to other maintenance branches if there are
    changes relevant to other products), but I only want to do this for
    our tagged released.

is "which branches, whose tips are already tagged, are not yet in
'master'?"

The one I gave is not what was asked, either, as I misread the
question.  It was an answer to "which commits are not yet in any
tagged version, show them together with the names of branches from
which they are reached".
