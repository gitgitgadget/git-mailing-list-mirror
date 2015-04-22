From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Git does not convert CRLF=>LF on files with \r not before \n
Date: Wed, 22 Apr 2015 10:42:53 -0700
Message-ID: <xmqq618of49u.fsf@gitster.dls.corp.google.com>
References: <CAFFOgCUTxnbL7vJpf1Hw39CJL_p2raDZ2a3DehhYhdbkVyi2fw@mail.gmail.com>
	<5536A4CB.9050000@web.de>
	<CAFFOgCVkpweSukCW4La737P1uu1hqX8WKr9wF1cLV8ciPu8tuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Alexandre Garnier <zigarn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 19:43:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykyfu-0004R2-6r
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 19:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbbDVRm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 13:42:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753401AbbDVRmz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 13:42:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 26B394B132;
	Wed, 22 Apr 2015 13:42:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:references:date:in-reply-to:message-id
	:mime-version:content-type; s=sasl; bh=kFoOwKmqigAJG3hDVGiclb1kH
	aE=; b=PBPiGxmr5uqOzqaZ+OKdA1vpflpRI0QOBHDNXrb9syJQK0rWVblzHs4tQ
	aPnLMeCu7rdYOCij0OJZ2lOAQ9LsZmMK8TZeXQ98vQDHcVaX6YTcOTazLhs3uzM5
	04GdVL4KAD0GhQ+B5EOfBpFRE/f3W1IiigExdo413+RRG36GeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:references:date:in-reply-to:message-id
	:mime-version:content-type; q=dns; s=sasl; b=yUfDGGFhcuZU4J1oWxk
	jT/VMpZG4i870GKShBpUaJYbwCxRwRW8MQR0tT/BBxI8kuqNEuz0uboQbhvJ9dLW
	NqqHaqBYVbwKmf0slqE6IZ6xtkYW8Laii2Oz9hdR+Ng02qBdUlDEAQv3qK7tpdDd
	YYwtPKmK2Ki6kpyP/u2Y8D2o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 201994B130;
	Wed, 22 Apr 2015 13:42:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99B924B12D;
	Wed, 22 Apr 2015 13:42:54 -0400 (EDT)
References: <xmqq1tjdidle.fsf@gitster.dls.corp.google.com>
In-Reply-To: <CAFFOgCVkpweSukCW4La737P1uu1hqX8WKr9wF1cLV8ciPu8tuQ@mail.gmail.com>
	(Alexandre Garnier's message of "Wed, 22 Apr 2015 15:06:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 017D18D2-E917-11E4-BE72-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267599>

Alexandre Garnier <zigarn@gmail.com> writes:

> Indeed, when changing the gitattributes for '* text', the replacement is OK.

OK.  Earlier I said:

>> But it would be a bug if the same thing happens when the user
>> explicitly tells us that the file has CRLF line endings, and I
>> suspect we have that bug, which may want to be corrected.

but you are saying that my suspicion is incorrect and we do not have
such a bug.

Thanks for digging further.
