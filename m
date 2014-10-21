From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reflog --date
Date: Tue, 21 Oct 2014 15:21:16 -0700
Message-ID: <xmqqvbndhxnn.fsf@gitster.dls.corp.google.com>
References: <CAHQ6N+oQV8Uesv_eCBZc+hpwR5rDWA22OXR05AJ_zXcf7bfQ7g@mail.gmail.com>
	<xmqqh9yx1gkt.fsf@gitster.dls.corp.google.com>
	<CAHQ6N+rb6eNC0_uzCAdH-HNb_SmdG4-W9DgmVKjfNpRcKKxk=w@mail.gmail.com>
	<xmqq8uk91emg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 00:21:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xghnw-0006fr-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 00:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933410AbaJUWVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 18:21:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933387AbaJUWVT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 18:21:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E96A618BCD;
	Tue, 21 Oct 2014 18:21:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pjSka7PKS+xoG3M/9LVyVVSpmjE=; b=Z9lrt3
	76h30fDOHgyqo/hzta2sPqjlBrO6d6m6MeZUhjP+VRgPqXGaxTXj5EqC0c0AZ8bq
	IAQOlAsP59GE/8hx7y+c7RCrDql9wlXphhu3eGZyDkeYW315fQcyJUmERrlRcTGl
	my6iKUr0y8si5Z8EOV5DsBpYipQlQnS+sFxQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ay8qGoL+T7jaHNez3wyvhD6W8sWpFdee
	i0+wGnhc9uPE+h+nREOr0GncMTRS6F2sT3xAblgMby469VA3BByPqyGMb5WiqAm2
	dMSZy7mznd255KH72yxP/6iJ4T11DJzBAwsehrpwsxNwp+Mns/pLUShmZo6ri8y5
	gWaRu20noag=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E046618BCC;
	Tue, 21 Oct 2014 18:21:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C90218BCB;
	Tue, 21 Oct 2014 18:21:17 -0400 (EDT)
In-Reply-To: <xmqq8uk91emg.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 21 Oct 2014 11:06:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 93815A4A-5970-11E4-A9C6-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> John Tapsell <johnflux@gmail.com> writes:
>
>> For me, writing "git reflog @{now}"  is a lot less intuitive than "git
>> reflog --date"
>>
>> Currently the top google search for this question is here:
>>
>> http://stackoverflow.com/questions/17369254/is-there-a-way-to-cause-git-reflog-to-show-a-date-alongside-each-entry
>>
>> Which doesn't mention "@{now}"   at all.
>
> I would say that a site where cluelesses attempt to lead other
> cluelesses is not the best source of information ;-), but that tells
> us that either our docs are not read by people or they do not give
> necessary information to them clearly enough.

And it turns out it is a little bit of both.  We have this shown in
"git log --help":

    -g::
    --walk-reflogs::
    ...
    By default, 'commit@\{Nth}' notation is
    used in the output.  When the starting commit is specified as
    'commit@\{now}', output also uses 'commit@\{timestamp}' notation
    instead.

and "git reflog --help" says that "It is an alias for git log -g
--abbrev-commit --pretty=oneline; see git-log(1)." in fairly early
part of its description.
