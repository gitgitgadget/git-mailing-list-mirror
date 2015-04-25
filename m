From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/5] setup: add gentle version of read_gitfile
Date: Sat, 25 Apr 2015 09:54:51 -0700
Message-ID: <xmqqwq10ywpw.fsf@gitster.dls.corp.google.com>
References: <1429952801-2646-1-git-send-email-erik.elfstrom@gmail.com>
	<1429952801-2646-2-git-send-email-erik.elfstrom@gmail.com>
	<xmqq1tj8178e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Erik =?utf-8?Q?Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 18:55:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym3M2-0006cX-EZ
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 18:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbbDYQyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 12:54:54 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751398AbbDYQyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 12:54:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F271499DB;
	Sat, 25 Apr 2015 12:54:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M19d0X7jNG7HZCBJ+ZRARhXrcMg=; b=Qj9IjA
	qTXgZV8dIAt4FGm6zBQh56v8q9SgsTQ8VXpLG1p2QtyoJi553jz6uAIefS5MrhVy
	RijH5rIlBDOylth0YLCK0s2ORRjejzXzJ6WUQlTpyl7CrAlIYAK/NQoSj6Cz/ob2
	lS5YgVuMCullKwzQsbnly+c/lhGA4qMsbJTos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x0j4eGtoIfKMhSWCm1oZDkbI3ein7ngp
	0jkxFRVDyAaxe8kohjvo70t9gI4xCEyO8G47l57Y1QiUF7BEDfKLisXBt+vPpx0Q
	98WHzhqa45qya6Ucr8MdDaXgPPtLbiVWL60R0GNOCb4ypP+UBjAfGq3MNSs9FDod
	kHotAVO1pUg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 072B5499DA;
	Sat, 25 Apr 2015 12:54:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81599499D9;
	Sat, 25 Apr 2015 12:54:52 -0400 (EDT)
In-Reply-To: <xmqq1tj8178e.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sat, 25 Apr 2015 09:51:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CADC4828-EB6B-11E4-8F22-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267795>

Junio C Hamano <gitster@pobox.com> writes:

>> +		switch (error_code) {
>> +		case 1: // failed to stat
>> +		case 2: // not regular file
>
> Please do not use C++ // comments.

No need to resend for this; I'll locally amend.
