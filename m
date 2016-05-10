From: Junio C Hamano <gitster@pobox.com>
Subject: Re: wishlist; unify behavior while cloning non-bare repos over http to be in line with ssh/local
Date: Tue, 10 May 2016 15:13:08 -0700
Message-ID: <xmqq8tzhmuiz.fsf@gitster.mtv.corp.google.com>
References: <xmqqfutpoepz.fsf@gitster.mtv.corp.google.com>
	<20160510221032.GV23764@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Michael Hanke <michael.hanke@gmail.com>
To: Yaroslav Halchenko <yoh@onerussian.com>
X-From: git-owner@vger.kernel.org Wed May 11 00:13:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Fu3-00022F-Q0
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 00:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbcEJWNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 18:13:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751913AbcEJWNM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 18:13:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEB891B79E;
	Tue, 10 May 2016 18:13:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9scUHkxUFbJIO0KWYAQHcQ/Hh6s=; b=vBZTo6
	SVzFsMSxvJNtxCVu9Vc9+wHsALra6nngrKK8QPSok4meGWQjfRHPvCjRpNlmU8oZ
	dPzakaL2zacBhHwuVYWj5midfL6CguDu3ITppp8dyNnJHKQEIGiKKbXySkA+Vunh
	HeMY+kIuqS7jvWZzwpZ6ZyOvxbYwGbS1iMsGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hfnEHGs7Tq0GMgrOdrjKKnbSuz6XW1wr
	p88y40ekk4mSrrJzlAUC2aSXlIvkInOpcV0EwKwvPEpHWIgdIL2L9aP+zjUyluxC
	/xix4U6v9bUUk5nHaxdktuoJfWcC8Ym2QnZyInDdBzZFvDxG1bOFskHHjx1nI5Gs
	YMKT0tCgyus=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6A4E1B79D;
	Tue, 10 May 2016 18:13:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B2071B79C;
	Tue, 10 May 2016 18:13:10 -0400 (EDT)
In-Reply-To: <20160510221032.GV23764@onerussian.com> (Yaroslav Halchenko's
	message of "Tue, 10 May 2016 18:10:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 61693744-16FC-11E6-ACDE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294203>

Yaroslav Halchenko <yoh@onerussian.com> writes:

>> The necessary update to the client might be as simple as using
>> $GIVEN_URL/.git/ and attempting the request again after seeing the
>> probe for $GIVEN_URL/info/refs fails.
>
> Sure -- workarounds are possible,...

Just so that there is no misunderstanding, the above was not a
workaround but is an outline of an implementation of updated http
client shipped with Git.
